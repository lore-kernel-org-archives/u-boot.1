Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F7C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CAA980F32;
	Wed, 22 Jul 2026 16:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJvtvxSgPnf3; Wed, 22 Jul 2026 16:25:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C43980EFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784737548;
	bh=dCNpbqpb5vualuUPTjYY1LrZHGQQYwUdxDerAo/tY6k=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=fy5J/dvvs409p28TLHzsltrfq0RpP29UBWG0CaaFyTVx2XLlyQi7gDvkY4UuvOOk6
	 cnVEwPyyBdcEVjAZY9udhFfGZuXbeK4IzxTrS8qV0Hte+++a73ZqhpaOwD3OM/c4MN
	 T5ESheoaoGcqHKh5TrfzIt5uFsGbF5jlAtPC2skB09+y9H1/kYSyjlXkQPiEM54t+e
	 J53zIVllXeCo7JDn1jQMh7BkdVjX2p/mj8sUTS8OoR3QUZhfG0Y0EWGnPNK+sauMxw
	 xx8yY6yQ4NCvImA7igl4XL52X+0huFmsLZZ/PTTuPZYQbJ1bUJKTo9MrlFjBVaYP3W
	 M6gr5hgJOdL+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C43980EFB;
	Wed, 22 Jul 2026 16:25:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C2E8224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E43240100
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6hswoygwEqr for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:25:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EFAD0400B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFAD0400B8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFAD0400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:44 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYGuR1044146
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:44 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4u6uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:25:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso3474269a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737543; x=1785342343;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dCNpbqpb5vualuUPTjYY1LrZHGQQYwUdxDerAo/tY6k=;
 b=bCwVE0Xwe+uAKnCpSUpj8XpKNpngOpe/uwqfjQcG2J6OUWE33MDX0J7JMRkWESELAO
 cCbOCWAQffLYBh5s58lKLAImiNvFRiJCDJIZueNS+jhKjAWmQbsVvsDR5rh+ecMWitMa
 pYgyWAC4I6nu/5+MuW9i2cSzYRN0MnS7NrA0etbMjzIXJA2FbqZYrJWRKdZTkqiL9CJC
 b7/Lwr+xQELzslprCLDmzbx+UzS6ebCd6b6JKr0fYXLDdSAyhHkTpSfKxvJFYeYfOY0g
 iTqiSD8Z86P6VrKe/ax7y3bq7fCRuDJSseobvCvpvFwthsdnoGBBthTWGXCJX7GHRhLS
 ut2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd/BPMziTxSnDxfjtOvOs1PqpMtJHuLv04KXnLh7KoadBCEosW3TXoE5fR6WyCQLhPGcYomKI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxVrF0aWXTx1wfEBMstNAREJSyKB1AY90P7JXQl3jClm+UOiMsl
 XZByrfhvegsLOEiTgD40gqq7JYMblvwMcpGMtIuP+7tmjulL5U24eOZlP0UvZChLP88scCxHUjH
 lBHqYVn+fEDvbOe1J+yH3aY93iA95BhAPO2jb/Ug/M06HsOaGgPtB+h3VTQmG/DbACgWtO2M=
X-Gm-Gg: AR+sD12XKiJo2OAxFh4C09nzxPBpDK8J0ScofV/GPC233jbiKHO5bmaYIkJIcXX+jT0
 7ISKc7XK4jOeT3/nJL+IKdY5rYTLsOjf/gpiAo2ACrsaNw85/7rdXVVOP221KWsVfTI5w99nR7+
 QhhPdnm5vQ8OPCwvMfDGSJ3WMVQRgbCHB6Zs+MPoSQx2Ml2FiXGOx7A2rDwzPzQF489azhWfZr3
 cuzaUr7jYJoVfpV1nA6/SHAqWP/kP+WjHebiVcxG5fpH8iMip3ZE/+WIk8mRXmusQfvXvKVjLqr
 N4Q+3iLQjxhlcG3YPYmTALXRufnpVDFydoBn4p+45y3VfvtxEzWJlwB2w/zmOiLcVlz7tYy9EtJ
 h0PkawsY0vXD9TNtBfcZEsnDqhxFiy0us+DPoAFefbYcCqQ66kF5tNwBr5z0MMwZTWM7711Hjem
 2eg470Rle/b3P6vOCeMHd+e0cyQajU
X-Received: by 2002:a05:6a21:7a96:b0:3c3:7cfe:b337 with SMTP id
 adf61e73a8af0-3c3ad7ad9e3mr21786144637.30.1784737543165; 
 Wed, 22 Jul 2026 09:25:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a96:b0:3c3:7cfe:b337 with SMTP id
 adf61e73a8af0-3c3ad7ad9e3mr21786097637.30.1784737542704; 
 Wed, 22 Jul 2026 09:25:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1302659fsm8184507c88.8.2026.07.22.09.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:25:42 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:55:34 +0530
Subject: [PATCH v2] qcom_defconfig: Switch Qualcomm fastboot flash from MMC
 to block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-fb-v2-1-4800dc35b2a9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP3uYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3bQk3RQj8zRTA4NE40SDFCWgwoKi1LTMCrAh0bG1tQCuHa9CVAA
 AAA==
X-Change-ID: 20260722-fb-d27f500a3a0d
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784737538; l=1371;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=CoDtlJ1p541OnP24tkDYT+Ie+QtI84kLC9YvzUuDmyc=;
 b=CZ3VLACuC5VnrauCSe4sKky0xq1laZfhN6neKyCKmRzu4w+obwYaf08uLtic4d6y/AY2quplV
 m2ZkxZEaAygD3pD4yybRnuvHSwdAuCnqyMB//luuJfhHUKgDX6Etptb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: rOS5AHqUl9auYmjBHYHEh4eOE5h2s8rt
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60ef07 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zMPxuuT9sPh8inKU_Q8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX4s64VBIHuci6
 ewd731dDJSPjjLcXx4cZq6Rs9bGyTOZH+cWGCBI10uUxS2Y0ZPz+lQcSrb4XlVCIdgFGPse9zaG
 nuaCOM3fm5ZEvzAV6JOE7PORGWrypkkOh3VaeUAznU4VxKpE7F2eoo3GmE5X5uFUpisAHD/JaCv
 R/5NoKsSfZx5yx7lJXJ5V+kZ+e6+c+v4EtH8Hgus6mJ7wZlp57fNvGI/ih6m9gW+Jp1tTDFvSyZ
 PMxUsxNhxFfb0HNwiRPyw0NXnJzj6g6fIv41rslVkYEBWkc0ukLXwUC9HeYU8opWY47SWunEL/4
 8uCrc8f3T/Fwf4Jr+u3C+0zrBIQitmNDPMipleFbxcCza3QEjNfJPRAsDeKY6vH8TejtIoINaoi
 ZBl9wDJZ74RlGsM371xEiCvfZruBXtboLlFSiORG/LbJ/xsdmQhr303mfYfImWwRboOns9YgbbO
 Is2SYTT+MzqbCS1Xvtw==
X-Proofpoint-ORIG-GUID: rOS5AHqUl9auYmjBHYHEh4eOE5h2s8rt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX2Ge2aH7hWcrR
 F6qKkCABx0rVxGAtGyiuq9EKxUJhzGxI4cAo5/38b9IkCvjYuSKT9NsmuL0LD5hA1WHgUF1pIh4
 InPqGrw6GqQuJW6RFZEWLVfyPlP81xo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220161
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dCNpbqpb5vualuUPTjYY1L
 rZHGQQYwUdxDerAo/tY6k=; b=cwTtyWsrb9Y4PKGl8GXdgO5C7AzHrEbC1M7zb4
 r5HknC2chubZEr/2jtK+jL/yEmbikwPZahshc7ViliaJrHT1eEmWqw/BEwvnlLGW
 vAsIEiCG1hvbozDx7Jtw5YP/rKpIfAhnN7oK1JNTNYx3Td3Burpvb2LPFwjEeJhc
 H0rrNvKqo0UJW96TVffab4oFeqs5ecqZ4lAK/QEP48mTTbUvy3GnCYyYF4EU6hu2
 eIdM8ND1jJdddyTvuw/XkCTOe2r9WrKqAHZghCvp4K4gsvZPnb0B7yhMnRSgqvfs
 5TeYaYvuKvxva8bksmHA14MFsucgxbv7wDWnpMeFprtFExeg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784737543; x=1785342343;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dCNpbqpb5vualuUPTjYY1LrZHGQQYwUdxDerAo/tY6k=;
 b=BRII0ncTdbwPbjtutqyglov/V3Lp8bzVIwt/E92ium/zBQ08TmrdEc/zxGHXgKzRXt
 1CAjsxrgMck4EGwz62FSzBja+0KAal5FmWs+zBgaSDYEUn6bLKuWLyzQmOVc/UkyKslz
 uvKV5Wi4QFr7kSXYfvkYXaFpSuUrZaRzZzOqkUgfTsLdZve55hXEPwpcH8tfLR9VFcw8
 IRK1+AQGyhBPWnAEIYG+QNTnRAMDzx2/kqVKT4zjnkxW4zhwb3uYt+Kp3W5TXQfPwb4X
 tbhOzjO3gFdesmIetZW+8H3jNu4MiZ/v6bPw6BtqaKW/LTRqTnXbTAmKmQMTDxkKoDeQ
 1NeQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cwTtyWsr; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BRII0ncT
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Since most of the Dragonwing boards have UFS as the default storage,
switch the default fastboot flash target in qcom_defconfig itself from
MMC to generic block device (SCSI interface, device ID 4). Boards that
use eMMC as their default storage can override this in their
board-specific defconfigs.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Updated commit description.
- Link to v1: https://lore.kernel.org/u-boot/20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com/
---
 configs/qcom_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..51b33966228 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -81,8 +81,9 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x0
 CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y

---
base-commit: 1b8283bd3220e898d338fb98929f0b06ed63da84
change-id: 20260722-fb-d27f500a3a0d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

