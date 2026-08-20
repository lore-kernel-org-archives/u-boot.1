Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B80C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 05:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C5A6606DC;
	Thu, 20 Aug 2026 05:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJLJQRhQMxwW; Thu, 20 Aug 2026 05:08:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787202511;
	bh=3ShcDsEkAGatWzsfanCJcL7QI0zzVobtUGZ+o+sitZM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ecp+wp2Fv2EXgI1voFCJQsTN1FY84TM6iVuAF3LvZqS8HkGDtkIeqXVPiUzY+iVel
	 Q8GUk//B8eXWNHn8h+KCD0p5IhGWz0XGPcaxA6LRs0FsCQagx/SEd2qX0Da212X07X
	 5VGhlV+pyVKjeAKfZFQWbFgBvX88kvZC87jWFTKNhjGSfEd8afOH8d72t0aEPkwYSj
	 iiVT114uW7QYnI5vK4Ndz6Lj0+eGTSmSOpEFvMZUNqpc2NKGykfWdUeuNhJERdyPFB
	 stZKV0ECeFsz1fx96sqGmoYcK1HHPGCusWz7QSQ4lcKXtKvg0TUiQp5I/FMwHIDIju
	 oUnDf7KMo0qaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEB9260623;
	Thu, 20 Aug 2026 05:08:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 059ED1EA4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E04D080C12
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6InucBZooQuG for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 05:08:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RK6oEalz; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q166rMDR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0205380C11
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7dkc938790
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3ShcDsEkAGatWzsfanCJcL
 7QI0zzVobtUGZ+o+sitZM=; b=RK6oEalzftTwsbBP6oK3ZTenZFfhSPQUNbRX3K
 d6g9bsVAYoxI3l50J4u5OHsRxuugweolkLKTz8/kxQ7TgQ4ZGC+QkDmS4VDEJV0b
 SFIVP+VfX+YoIAIA7iZxeWzoMre6qLjEbPXXGDLCT3vrrP2UwQcYRvECMUlyx7JF
 /8rIg9hpOQ5A2EwngUmbY1Wc9cy7qIHfRh82giM6aQP0w2xWIn99VJ/Ny/fMG7Ki
 2tkcjl21P3aL2vyr5erHQhrUTViyo667ZzgexgapBxQVnDmKX6hg/DvcLERreCRF
 x1eVqZQBpIvXrTwTu2/BeMXfOmzYSP4FsCQ7BlwsNQP3yffA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d3dtg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so3493924a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787202508; x=1787807308;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ShcDsEkAGatWzsfanCJcL7QI0zzVobtUGZ+o+sitZM=;
 b=Q166rMDR5lwIaYeQKMcFlzCsem07i8N/n0A29/2+66AePFnyvcYKVqzTxd+o6M8hmC
 8+FYiQ1xryN44yWzcdTwqYqhCh7sOnc6HDrtzLTkCPgIeLo8luIqXXuG9aTh79KWI1LR
 Mf+c9eredZhy+dJ4AyNLUIOpQXH+HUh/fbeggmRat6l9b1uPcbYdKXHBpGHZpinQd+OY
 DW4tm9dpKybyXRLS3N8iiZS+zicbPv7K3tKj/7IcAdJAcHvAPa9ZkoQOksGZlWfJO69t
 8DaqzBp2yFXP74QXBVx67wMxFxbfBDnUzatzSHDy0IxYPBau10PiJHTrCwG8mXuu4d3V
 y+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787202508; x=1787807308;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ShcDsEkAGatWzsfanCJcL7QI0zzVobtUGZ+o+sitZM=;
 b=MgN/XkeJIU9GfmMiSHBcsLnP8nFPCURdar90XT1ccPH63yCr6GWMGXyocd84w3xhc1
 LbPM7wamIfbk/WFO4asOd9EAc45KlV2CVPfSjLkbUJxV+8gaD5G0zmMVgfHcPgOTA8uN
 kNyVoKwFQ0FFmqcFoq+gMHYPctHQNHheF8L+lSSVL/I8eIrdIFmnVf7daekgZy1gbscO
 KrgHP36+gviuW9pA8QPwQBeOPwZo3mk7mO+itJcTMKZtuJSgG1Ny+REG/x90XRRhPPEU
 ej/hy2Ci8+cRwUWDKYFstGSa4KQUd6THkmrhvH6aHC6LvswLsca7zKAsZEB+fyDPB6Wl
 myJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtPa7coW7rBdotJMH7spp5gyuj2rjfE6lOBYAUNj0vsubxfHF4avPgPkSMa6U4FsiyuPm2rUg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kyU96KG+sUrVzZIdPaH/F4t8LLuO8COmr+sk50nY3kCzGhFVnZ
 sV7/PcBL8qw7wMg84WFLwz4ANQskHz43nHEupi5y29FPu4ahMGNZJLzKL+t8q4x9A09YNv7C70D
 OqL9pc3uGfdJ6pkvzHcFh9U9L4fwKujLA7J7ln2eYFpoSbngB2ao0TlwvEr/z4lUgFufmN1E=
X-Gm-Gg: AR+sD12SGzk9NQ82Tz0OxY5gzgAAxePq0XqHy6iRiyUgIgQM+gaX4wKdBN2yFWKdjFL
 fa91Hu5AEHJKWLRT/rzbEMdtSbeMZJQ8fs5yT6tRSbdtwF9q0l5wtLkjTgikrDWKLFjCXQWisF5
 d0bgzGFzHEHiLisv1x5T5Dv20V5UbpVRJ0efeX8Ibkh6sHfBvIKzgH1YS8qyBwEHyQ1hPW3Q/Dx
 97iRuwK05V6bu/FJ0eUJAt7s2gW99pH+nJO6u4Dum2h9i5qs9m2LNQHrmqnS7FrajFAcxl8jEJ2
 1C9sZi7uPrTaX4+D2yg3hJAmVdDdkR0Yps0HRx4VOCJwykPCRcCGdhUh53zbLbrzVUxLMMv2tfx
 J3+mpdceGMuLIdvs/1Aasec98Z5BLW54F2+FezelAe8KZO5canvrjlf8IvEJ+rWWVQKBTUmyUUF
 EsESV488tk+/gDYcSkebzaiAS8/cFA
X-Received: by 2002:a17:90a:d60d:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-39580bc9ad4mr19506384a91.7.1787202508357; 
 Wed, 19 Aug 2026 22:08:28 -0700 (PDT)
X-Received: by 2002:a17:90a:d60d:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-39580bc9ad4mr19506274a91.7.1787202507950; 
 Wed, 19 Aug 2026 22:08:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm12012395eec.28.2026.08.19.22.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:08:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/3] clk: qcom: use GATE_CLK_POLLED for CBCR-backed gate
 clocks
Date: Thu, 20 Aug 2026 10:38:21 +0530
Message-Id: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWLhmoC/22MQQ7CIBQFr9L8tTSAIOLKe5jGEPi2xLYoVKJpu
 LvYtZuXzMtkVkgYPSY4NStEzD75MFfguwbsYOYeiXeVgVN+oIrviR3v194sSJiVKIU5GhQKqv6
 IePPvLXXpKg8+LSF+tnJmv/dPJDNCiZZCW+OEo1qdQ0rt82VGG6aprQNdKeULo10nzqcAAAA=
X-Change-ID: 20260723-clk_gate-1c5e54a8ae47
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787202504; l=1365;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uOSmiLKoWSiQNWizX9C9nqgeqagstpPRWczwJ7FYGYA=;
 b=xrtTUFjpYkDEqbceLtKp7v+i1JbALSpTq5mOLbhUIbA9MNERCwXPYcYVntadeRS0OVcyNsRag
 cjlQMQXbBVvCEAiIUklIc4ion/ujPmWLbg6F8F7CIbCt1mLrWsXuKVi
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX3Kowr4CEckOj
 mTsT0TAnSgzEVtIq0tCz/MMIndO2yxz7Mjt873p87SpytjSA1cNhJQs3NaycSiwdV+vwkF71zcx
 gll5LrR48X7Mux7mssT5pOK3f98R5kO9FWPgCiT4heRmqUvPhlT6xORViCGj25qwbwgbxf8B+DR
 B44BNSNvfi6AT2XO3woXjvqSUfemgw3pC9qQcF2up6SBBJ6FkPViaKHae67sjRkPSom3rUwVWLc
 IJ9VNsqN/gi1/p3shA59vS50PkxpW2C0ITiUuUNCp7K8+jaQokxR1YPbTZX4MPf/NYXVwM1/cJS
 zd6lxMtdnv+JgqcNxYARS4Zoe0sZoRaV1SUintj3PgRVbERrc3xYQu7oDtR5CKFNazhLg3ATruf
 GBGjb8lLZoaHIxrspAw1LlibUwmrMzvdMO0DAAp7GAFhuHKgUfK5a03jj198nkbH5ky95sow2r3
 cGhErl9lkzb9YR2mhog==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a868bcd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ibkjCfJP2SEpUh-meP4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 6M1IuONX6CeU017NKEc0m6T0ftuoFp_u
X-Proofpoint-GUID: 6M1IuONX6CeU017NKEc0m6T0ftuoFp_u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfXxLmzdvDyBxFG
 dQzE6axjCQedQS6w8wQSNYC8hpxz+lQfq3ibFTyLU611GXno7os4f3klMKbNImmECmS8UkxDFUY
 wM29F3I7Qxwt2oaual55Oj1zrf3WrUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200035
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

Convert CBCR-backed gate clocks in the sa8775p, sc7280, and qcs615
clock drivers from GATE_CLK() to GATE_CLK_POLLED(), so clock enable is
confirmed by polling the per-clock CBCR status bit instead of assuming
the enable write took effect immediately.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- keep the USB3 pipe and UFS TX/RX symbol clocks unpolled across
  sa8775p, sc7280, and qcs615; their CBCR only clears CLK_OFF once the
  QMP PHY is running, so polling them at GCC enable time would time out
- Link to v1: https://lore.kernel.org/r/20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com

---
Balaji Selvanathan (3):
      clk: qcom: sa8775p: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: sc7280: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: qcs615: use GATE_CLK_POLLED for CBCR-backed gate clocks

 drivers/clk/qcom/clock-qcs615.c  | 38 ++++++++++++++-------------
 drivers/clk/qcom/clock-sa8775p.c | 36 +++++++++++++-------------
 drivers/clk/qcom/clock-sc7280.c  | 56 +++++++++++++++++++++-------------------
 3 files changed, 67 insertions(+), 63 deletions(-)
---
base-commit: de02bc0eccb76aec8272abed651c35ab120f4844
change-id: 20260723-clk_gate-1c5e54a8ae47

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

