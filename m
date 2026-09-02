Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F312AC61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA8BF811C1;
	Wed,  2 Sep 2026 17:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iEbtccIx7zQp; Wed,  2 Sep 2026 17:06:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368818;
	bh=jSJuLdvXVUWaQ8WWVUtbPuOnjXSjAos8SVH6HSlcceM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V3pQXqkIiJQXuzlKhdfBjxXkb1nikE2uunFqihaQVSjHLJdXn4zPG0C/bHtTgemcN
	 pug8WPR0/IHDhkYDaafw11opMxa/1OPT/B3YD/G2jh4OmsU4YWJmua6TZF3EMyguxy
	 v5oK8K7qCX6iuvbTCjyoC2fJfu2yFvsqbDfLGXBoVLCLA/cFGkrBgfpCl/fmbyjdN0
	 UwEXb3r8s1eXvC7dycQfy2cSLwLov8iWFqIP6MYQZoZRMizcLjwq0S+RlgvzgFDmBT
	 BfVw57IL6aCzQSDhBnr7GeJjSK4+V/UP/9JHFMKE15z3yBmpuswFOEEb0k+nB6dURj
	 8zVkGorCgP/0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C370181516;
	Wed,  2 Sep 2026 17:06:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 823782FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 685636100C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BDo8u1Dsdxu for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:06:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oyH1B2jf; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cHz9nBQz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7870E60BC6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GfxPO1495545
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jSJuLdvXVUWaQ8WWVUtbPuOnjXSjAos8SVH
 6HSlcceM=; b=oyH1B2jfaLcY884XOhuHrMi1EJUfkQgDshdYm2BThynKaTSecb8
 gWvMOxdbpFta7CdqLKA0aAJ4Gmf+gqYHFm0ag9+S4JXyVNleTBegq4UcWPEo/Wil
 HC68ptk/f5lbVqu8LUI6LSdINQyiZN9ExvpMaK/DZ20OEQL2ycuQRvvXQUmC6Qw+
 UR6pl3aE6fiw/pZWo4kfgAG5LUv5Bt1DygN+koFHH0fcimX1QIiLhRLcAc7jlmCs
 aoGPUeqUp6rSxDInCAfyivYjrefx12pCtxrprRoj6LQIRKfCxz502CcHCHlgPcTo
 Qj/ce3kvbrEQb6/7mFjFR9LnKfXKqSf0oig==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4rwxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:06:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398e1f7d1a5so2094343a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368771; x=1788973571;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jSJuLdvXVUWaQ8WWVUtbPuOnjXSjAos8SVH6HSlcceM=;
 b=cHz9nBQzNQQCKSefnouVkU0zVM2niTTSq/g/2+hP0EAGIbU/7Cq2cUfGJ1ALWykkbW
 JfisCoegPFlf/YW+m17HleSbd703uMazsXegoS6usZeS3orfz57Rn3ehY4ilnamAo3cs
 EaPhFzuwRRtBShNr67OFHwcXbyAV8LJvf7a36FnSo6IpSKZos3t6sEfN25fxt2uPfaxN
 QJZFSlgGlrdf7oA6JCjLZ5FoSkMQEiAGElecaa24p2XkG3VMiRLeyzToHsyJ7r74Te9x
 4+XeGoEjr5ecTSmu8tX4wUD4oVthI25KNvZ0YkQrtFiJjKbu1R9wGs9CprTvPQQ1FFh/
 mAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368771; x=1788973571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jSJuLdvXVUWaQ8WWVUtbPuOnjXSjAos8SVH6HSlcceM=;
 b=tWaF8EXGNSO5cTu2dpxAb6mBgJM+UHm1srfFyOMqOoAyzEejzcTCyGD/viGDwxIFah
 vXgX4GmnJbO6hQnH4jONY1BwxsdJ94uydNG9fs814HOuQG4na6uEGTOvREgeuVuaNGfs
 G+AoE4Hg/CH6QB0ud0euaaZoWrCvUDsN6j9L2SNq7kZcFmMjQ/lVoKTAnyJpzRJpL8yl
 yxRjoNZLtIBAMsFj4fRhQ6Ytjl80hOub0cDfygoLlOAeibjHQZufFJDFtI70s0nsIgoV
 pnhY3/vXs7XzQcBkAIS8YKDz4dVpJVx2/99kmNEyY17vgmMbJ87ksIrMS9Ll03JOWx/4
 caSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByh3PEFfZmkLRNbKxXqXdwLhdFeQ00OjHo6I1vyxzLnImKeargJJlKQjAYn9Ul2PdHlFcb2xl4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJPLE/xAjEgwYFG73bMxMvt5cGl54rxFdwm55w/G8N10HA+Lkc
 3m3gS4+EIhQniJWMatoT1S8SF7grH6/lr7X1uGClsvE9aKSJttaaUgGP3JcJ16Y5jp4gX8Iqzc4
 8b49LKXVfAEy9EDy9VyNwBZihwpaPQKK6ufsDmqbzu2FD+VQkbQY0tFpVmMRPkc0zP4W/oqs=
X-Gm-Gg: AYBFou31qwT3FKjPYzasYWBvt4MM1llsSm/W8MvY2wAr5CEmSXIPCqnzfbMYS1armMd
 X1CMmUtScAEg4vIw3UzZmJQVl8Ss5HSKQIy+ehA911WqJ66nIbZpOr0BRpQ1OVYc2RDCVccF0G8
 BZZN7ylvI0DEi9rnCHn5defiIE0uceP8Os094135xowZHnJoTNPys1+v5U+Txks70qIceQwuNOI
 RzWLsaVsZCN5RK7Vk6MPzxRonDGkM+uPtxCJy23ceLdUUB1nWkGtmiYJkWIaT2t0pPShX1muIcj
 KlWGN30H2UZbzr4qrYuVIy03pcA39ZWrfCLkHL5eG+0TXUWlE8pzDLlYSWAPnXZZ7Vy5zyQ3Q0M
 GjSwh2I6B5YUtDjBHJ6GXh2QavA9nh4V3L4v3j4Zm8y62GLBhcWih+L6mx2YwyuUMWExRLuUhmL
 9tiLBJoWj+rz9mDyDyGKY=
X-Received: by 2002:a17:90b:1dc1:b0:398:d6f4:c61a with SMTP id
 98e67ed59e1d1-39aee13c22dmr9943374a91.17.1788368771259; 
 Wed, 02 Sep 2026 10:06:11 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc1:b0:398:d6f4:c61a with SMTP id
 98e67ed59e1d1-39aee13c22dmr9943288a91.17.1788368770777; 
 Wed, 02 Sep 2026 10:06:10 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bde5bfsm8105688eec.27.2026.09.02.10.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:06:10 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/3] qcom: Enable HS200/HS400 eMMC modes on Qualcomm
 platforms
Date: Wed,  2 Sep 2026 22:35:56 +0530
Message-Id: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX1BU6EDY8EC14
 ZvQ7l0hT3qEn74wO6i+LkfIkxL6nNf0T1Rx+JOy8y8Cx2EnWUcW2VqA9I/do18yVViTXDU+lzCZ
 4l94SFz6fr0mP/xkwtzWrmnnAbB73UTEaA+GR0SaUF1/v5Olfyq/PL/IzBUOThh+BqGOyfEadLz
 MuX7sdtKA2HLAEtLuOM8qiiDwuza/zI7uMtd+6zeos0tSXyRbvKek8uG+aazn7ftX+w8rgLTWWX
 t4KCKwRgmMfa2YN6d79wINSgmbxQ3w8Dl0xxIExp/lhXE4koFiOFN1QwTj/kkNvgBpjQIBXuXtj
 Wqo+SblbnjeJH7z/eEKe3AdDm1WiXVsDcgzK5PNqT07h1kxRG+OmNwPil+inRI4xUnqS9pJ/pLx
 qR3aUDmlHjICLQw556bJj1w2SfyHHWkLdlF3UNV7/As3OGC70OZF+X07PwU07abS93iR499vEd8
 byz+R3lFGDsrDHEyOCQ==
X-Proofpoint-ORIG-GUID: 21P8LtfaU0pRiatQCygaIDluvgOiLIWL
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a985784 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uONKjo44xmtWkbe8JK0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 21P8LtfaU0pRiatQCygaIDluvgOiLIWL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX55ggnMKTAgGT
 J5J8y9E1Em6IUrzkgmaxsc/NUkJaloi4xzRjLAXYrNHtxpMi907Yml5lKXUrganWHzAl3ie49Qa
 W6mukLuRK9fbaBAE/FlXp85o7yL3vWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020150
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds HS200 and HS400 support for Qualcomm SDHCI controllers
by implementing the required DLL initialization, tuning, and calibration
sequences in the msm_sdhci driver.

Qualcomm SDHCI controllers were previously limited to High Speed and
DDR52 modes due to the lack of HS200 tuning and HS400 DLL calibration
support. This series enables higher-speed eMMC modes by adding the
required controller-specific programming sequences while preserving
support for the existing SDCC core variants.

In addition, the series fixes an issue in the handling of the
"max-frequency" device tree property and enables HS400 support in
Qualcomm defconfigs.

Changes in v2:
- Address review feedback by simplifying tuning logic, removing dead code,
  and improving HS400 error handling.

Link to v1: https://lore.kernel.org/u-boot/20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (3):
  mmc: msm_sdhci: fix max-frequency read into wrong-sized variable
  mmc: msm_sdhci: add HS200/HS400 support
  configs: qcom: enable CONFIG_MMC_HS400_SUPPORT

 configs/qcom_defconfig  |   1 +
 drivers/mmc/msm_sdhci.c | 785 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 783 insertions(+), 3 deletions(-)

-- 
2.34.1

