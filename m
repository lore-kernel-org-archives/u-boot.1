Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2362C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5805940A2B;
	Thu, 23 Jul 2026 14:39:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvLtBQpfij-P; Thu, 23 Jul 2026 14:39:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C7C640A22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817558;
	bh=SoFo9RlfjMfQd5bd4/3kOZE2mAJE11b3orI68KtydH8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=uI5zcAy4tiCTXPdG2VmwRmLXb4/C1L2YnIAcFKgSKr2RGOXGIhGoE8RBfInRWwaL6
	 cdQbx6TkIcloD5cTS15iXUi/nE6h7GG2ivwU2N3LuIupHYCCHIBESacctGwrHEvWx0
	 EOU+w0k9mRdXORgBV7hO+TwHqLzgEuBJB/a2hL77Jq09IvI8feJW5b8vfkjR3ak0ss
	 ZDwIZVa2RYAbH8hPI9CUSBZs/wr1aHUAIp4RQTA8iS5Y2O611fWFri+Z2rTmKHuayh
	 oBzaSzaf2n6ym+tCeuBsNxIH6PzJmGgOjPXmR6SgNGeG2A1C8dIyWEsRie6fzYqAPd
	 RXTj3cFSu4ugQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C7C640A22;
	Thu, 23 Jul 2026 14:39:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01D39390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E824D81082
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4Ik9XuJfoSu for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 931438107D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 931438107D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 931438107D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F5680087; Thu, 23 Jul 2026 16:39:11 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2171680287
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:08 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvgCV020909
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:07 GMT
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk6c7kk8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so17617271cf.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817546; x=1785422346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SoFo9RlfjMfQd5bd4/3kOZE2mAJE11b3orI68KtydH8=;
 b=np5ZJgwEmuG3uG2iUv5EkAJLegN2jNJALwphT/WIW6GPaTrEZXmpOZjkzAZhrAyWdR
 2oyEPO3N622j6IeWpdKnAzlofm6rDIp8rUU/M/Y62MZJtcCstEXTPMGY8iTmjZl6ACMV
 Tntll5vMla9N00iRkc/O9UzH3GmEW4ou/urm2n/Q8I/CKnZdfVpyUJZNT/PKuH4agJn/
 T6hqfI81fTvPuNsWk6j7aJoU5DI3SBWexfcMeheZWoeiq6ofzSblAU+fGI/1tt2crPx0
 y5Hvd/AUagrhOHfBbfYfbte7s14bf72Jmeav8mXoiKOWeVR1kSaQXswcyULSgSPTQIN/
 Wvuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVoHsZt4mSinuwfEUu5d7GjSDJjSaBOaU9zZGqY6TjhL+bdD9/5LUG08H+V+tRL3DcJG0Heys=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq9BPueVqa9sjIjhZeHAd2NNAH44y31RWwWirLjohqT31wu3eg
 YXl+K3rM/IOx+5Pq9RhGP+6x/W8rYkIMC+x/L1pOm6jww401bVVu+G11djVtzVYvNG/QmngUjHe
 X9E9g1X3h0DLtUbENohN7FxxMg5mFs3E1TgvMnFLuYUB/GD2L70rCAjl5
X-Gm-Gg: AR+sD11wz4KKeGWppHVHW29+9pNyE7bR0KiXUNDU2EZetAedZTiylh2MUFD43W2DF5B
 cQyNQT1EzhY9yPUgZ9wVMvPAEIiHmsQ9LF85Gl20eTrJ8GDUtP+9gO+xY3cYCbo77Nn/lMuWuHC
 TO49PEppoB1qZ+LtwDw4V6S6uStOCuY2/g49SC8QUkTfzAgNhxUMbiD54GwzvNA/YqO4xkKfjJ5
 NUlB6qD/0oOTlXPNKrG/BBm+sT2PemcqDnQKJJW1ad9sAy06etiTtlKHa77w3D83OfutUcXerAC
 pkpkvXKN672OpQk/+gfK+s3th8DWMYqwxLQ1orM46EgGa0k552uRrEx7xrz4eGWDKPB3VA3xqGK
 vTamAWacHCru0dX3BdJ1lkKvhw/+DizGgRv/RibVH0Z2UACmt7kA=
X-Received: by 2002:a05:622a:2586:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-5283de4e310mr29895501cf.36.1784817545758; 
 Thu, 23 Jul 2026 07:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:2586:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-5283de4e310mr29895031cf.36.1784817545285; 
 Thu, 23 Jul 2026 07:39:05 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:39:04 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: [PATCH v3 4/5] optee: rename rpmb.c to rpmb_emmc.c
Date: Thu, 23 Jul 2026 16:38:21 +0200
Message-ID: <20260723143852.2287208-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0iv7C3jYgMtPvZjr3nniIl2OcwV9yI-k
X-Proofpoint-ORIG-GUID: 0iv7C3jYgMtPvZjr3nniIl2OcwV9yI-k
X-Authority-Analysis: v=2.4 cv=baZbluPB c=1 sm=1 tr=0 ts=6a62278b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=E6ZNdhIRmaKDHt24uZgA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX+UjzgIq1oB6f
 DjBMslC0mgHmM5ZkIsr0MsSp8Cs0yZKgmiJUZ7EkgjVGSPZWJCJ2tTcKGd5xDBG0vFYMenDl8m0
 M6rlH7r7F1me3Ug83vNYaYmJ/0Z88p8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfXww77hWsWas9O
 kq/47AeAv4X46orSes6Q3PSHAjGsWTeQIVTaU+tyIU++SNtQq0TmPasYYFXWwo+Zq8fHtILu7vt
 J9dSOjyFTHVSMcj/85BP2RG8eeaClXip1bt+/D91ddU6eySbJBgra8VVbuiYYaYMz8jyLm2NANp
 ZaF5zy6Gfbn+mBn3x0gycjBwvk/r9hGKl5u8V232189UzhutJOHkmpfc4QQuuqwbqQXkGgOkfy4
 czuCe3W1vbqC3Am+l0141ENuuRoWv4Ea0MSbcLi63P45HZ92z7O7D1UFsHx3nyF6R5jpA2413dK
 KF+uTOLpWfTNd1AjzU9/jKK4q7znwc0kSr5eHBEdXrHrI5dfZJWNa5+D5K76uH6XrdTyfkVOhSf
 cKsrX2z5yRbSoX7G+cEgc+YV0F9UjyQU6iQwZlfI7OC/zmxNIqRCjgQT2QlfQsamWrZsqq/P8wl
 7t44RRxddtsRE167Y1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SoFo9RlfjMf
 Qd5bd4/3kOZE2mAJE11b3orI68KtydH8=; b=g8rKRVp2KviejHj6BrgxCIcS2gj
 yGnzsX9aP1AxNtb4+kNr7JXhPVC6UKWXetqZE6Bquz478QkLfDvSK+6mMMyVQqsN
 MmAFRhTegum+iPC800WYT51ECNzvKtLg5lJq3VENLCrYaBIAwy1uFRpJUC/SqquE
 17/DSoAFkpISBTl9fF5jSjz6uDJe3GrT2lmxzKE84ePa0GIcP22Uh2DaaZ7r1YID
 uXdHjZfwzsR9p9XXZO0Iul17e02tHC6uTs8i3rEWu3qLa7Kv7XDktA+dyIH0hP8b
 otWoj9CtfBdVKI/HKKzUXJM6vrckE7iuiA1cCdlbskp9CEgMurDBopu9Wsw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817546; x=1785422346; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SoFo9RlfjMfQd5bd4/3kOZE2mAJE11b3orI68KtydH8=;
 b=I4V+b1FFEB5m1xFgBCSKIn2xTKjiSkWAugQ6tphg0OQSyg4WCMuVTVdqXtnbozNW5A
 AkrgUQxS5L20rZhPndE7znF5ZR4UO3Fru2NnmNcGNIB9JE5bE/8g9UtRob7GJT0ads2P
 UZJ1FzcIjT4xiOYbZDovuht09PMFr0nf8B8ZcCDFVb6F6w/1F2T4BXYPxHK0AIzomiF9
 MC+laBZCJnI74O/DJjy0M6+4MaXKFN+OX8oG4l5TT936iplPgC4RP8feiqlnEY8hpL+3
 GDPretlibRQOEItIKznQwhGiK1AjZ3BFUz7hGZdV1tzjRncKaVWJ2M1WdaPJ6FILUmYl
 2lZA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=g8rKRVp2; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I4V+b1FF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8rKRVp2";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="I4V+b1FF"; 
 dkim-atps=neutral
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
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
supplicant (eMMC only). Rename it to rpmb_emmc.c.

No functional change.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile                | 2 +-
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 36ac085ef42..d0c7f8dfb12 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
+obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_emmc.c
similarity index 100%
rename from drivers/tee/optee/rpmb.c
rename to drivers/tee/optee/rpmb_emmc.c
-- 
2.54.0

