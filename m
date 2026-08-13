Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5E1C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 861D04095C;
	Thu, 13 Aug 2026 05:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klppmLhJ_xMU; Thu, 13 Aug 2026 05:53:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA0164094E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600426;
	bh=RloHWs3oXisIKexkmFbjiy2eK5Toyon6yDOEjsuhaF4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Mt876Gl5km17Yg434aVDF4N5lLqnJ931AERrJQ6eMtRK0OZeD5P8/hVneWF0tzK/9
	 iALrsJ0iUrkgGx+PA/KgWKoTlLqige41RHrpP1FPWJzViH3hIP+l7te68N6+PKTv4z
	 o3kPWJ9G6g5v11E01YOkXTVxiGNBZC6F5YHweaBF4BHzcW3KT1cSuZBxH/EZ9b2wY2
	 uvzGC/SOpsmTUkNA3mz63tBixoLqvM1jO6dEsWgjS+4GU0WrkBKunFE/MmdHRXT/2Q
	 vDHnFAHxHVZeZ2bxBijMfAP9YL7gh3RygIVglEomVRXqeG7K0ZwSWTSnHpxPyxFJbp
	 tzCQmpoqrMGxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA0164094E;
	Thu, 13 Aug 2026 05:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE4D4109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0DCC40347
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69QPUxGn27-y for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AF04A40121
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF04A40121
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF04A40121
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g8Br1072472
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:44 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14sygr00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so37939325ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600423; x=1787205223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RloHWs3oXisIKexkmFbjiy2eK5Toyon6yDOEjsuhaF4=;
 b=d4Q+qGYjq7QlVt2bVCOYGuBODHTAkSSLcZKEUSrhRtH8Q5SclUW9IhdmH7UP/EgdCt
 cOK+KJ3NGeVb/3b50MmecRzQY6ZhlSN/GDdKf8jHtTp7RxXdQa4YrFnFHv5vZWxIp/4g
 QUi2qRR/qa0CbDs0cjtgT9n3+vtaNRP+FxQFo2FX97hxI1s6Lp4Lz2XiQiM4RXWOhcgz
 llDAjyg6iv5E9u7fBkSbDp4SszcUy5paHlRcq3l6W/IZvMGYID3LwGcI6rdYyQJ1WGz7
 2Rdn5m0dE56wUECSvaBPGWE2kGDrYE75DOFsdYkL6Sws8+BOH7ANL1RDiFYUAuY/gM8e
 ii+Q==
X-Gm-Message-State: AOJu0YyKDtDqCaOrCUCGGuiUXB8zkHZkHWMa+OfMXjraUHvE0mZyElq/
 BkPelaXb61YjQ5PnUWjm2yYFRmQYPD85NqTLxl0O0tEfrEZVdO6W1LjxGu1S6sH6lpMAN4emF85
 LMVDggPkgVgQDFOuwRvEiEduf/AHqcQDOHc3/NQAfrx9N8zvsBvfWZh3FAwvYuQ71cg1vHNY=
X-Gm-Gg: AR+sD11dQwAbEzcTLlWp5BPG8zoIWIys2wjOE5QpYouBtcBlv/oYLyAxISwcNs83v9e
 PVPetgkrKkLDdhUJ4tItp8PqcArIHvH3FH5nzHMbgyfM5/pNGrousnEWmEilt8+FEHYlzBVueZb
 DTJbK7iAAidMiuX4oAh2jVxaVZklb5rlesrAtEfk6TC4e/ABN23tYF9pxOuc0prUiYPjLdzzLEu
 J/dG/q3pscQl0GncB5VcQUNf9UeaLVg6dhwQnqi0usnnxf7MVWdyR5AIk+0zobU/2DxsVNWLbnB
 PYZnLZG2P3/lprrStFczbiRYBIj47c/DHDdSKJs8MMJZCtQ5v5nCbSWe7hScLG4yJC6dqzyPBhh
 fucSfQ1mQNu+RMX+dgFFiNzOUik21F/r0Ntx5l9uADIS+QB5KAoaV8RHNRkITtaA3gO8Klf6uZk
 7h4JQL+BfCZJj5/skn0/9ZKOgLR2H0
X-Received: by 2002:a05:6a20:3ca7:b0:3c4:397a:69aa with SMTP id
 adf61e73a8af0-3cc5549bcfdmr4673706637.31.1786600423217; 
 Wed, 12 Aug 2026 22:53:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca7:b0:3c4:397a:69aa with SMTP id
 adf61e73a8af0-3cc5549bcfdmr4673665637.31.1786600422767; 
 Wed, 12 Aug 2026 22:53:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc760524sm3921430eec.1.2026.08.12.22.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:53:42 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:23:30 +0530
Subject: [PATCH 2/2] test: efi_capsule: add sandbox coverage for
 dfu_alt_num override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-firmware-dfu-alt-num-v1-2-43f034253b21@oss.qualcomm.com>
References: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
In-Reply-To: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600412; l=5534;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yLAFJy3o9H7ILuQkbb4/tzqz0uUShfJk6AaSCN3ZKV0=;
 b=K06+9chMCUYfXCYvH9gmNiDx2DIulZcj64roSPg36dXdhjJ0qW+h6sO3SRFYHWg5ooOn2Un97
 EVmXQYzv9ULDRtV7DcznEWzpeyIevmhOpdDUNYZfYkI/5meml/I1qSl
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7d5be7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tDDqN7UG_OogWC0oBqkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfXxkSiueQfjhk6
 4ey+vmii5N5lXAHGerCUaV1O39twWkLw4DRrzezKX1qUu+B4seqVnceDN7lOFBH5OgrybfC9B3W
 VqVScf+tcEzaanOmyIPFpCDJGKBieG3Y5zk+q/CDN0dC41nhD4hVNjUjA1UoY+4GRkXIj0Mpub1
 4RCpmS6Gx9CKpF+VkuHjFNffpMowUqsdoQ5MzX2OfBalphlS0Px7CBE19AzTBJ0v1XSEJz9teFn
 +bhszf5JvP0oW0TWRFaeMvaXD5u/D2bjapu77nsskBqO746m+nZC9WpWiAU8dJjq9PnQW02t0fT
 f23iRSwOzs+troy3IEteuu2apsoW0Usu6FvoUMUPotkaJhGBVA7u/O74NG3ReQc5F/ZMsK5bWst
 cePO3tyCCyDCnaE26MGZq4MfOaO5gMnBncer0wj9J4nz3rNiYToK+W2mC1Mh59PxCKq+p0NDNFI
 lLkIXNxvjrO8wjmfhEA==
X-Proofpoint-ORIG-GUID: WmL04yp1OnLFbhdEU8AVFsAee2oZtroc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX+Lb2SEmzsiu+
 uKWQskkBDyJsgYliyTI7ZyX5pdr/9WEzTlCt1WgyVeu3ZvGXrefMPYPeQlRnKbwKhyt1cwSO/hc
 CCNxQoqyEvtevhZxVItYAJTbD9k736w=
X-Proofpoint-GUID: WmL04yp1OnLFbhdEU8AVFsAee2oZtroc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RloHWs3oXisIKexkmFbjiy2eK5Toyon6yDOEjsuhaF4=; b=GhYIl2GCEgIjF/Gq
 I7G5ctTQ5GknhOo+4S67eGfxPIxlbDCeu536p+JWpUiDU86Y90qD1QUbFsqhCSDS
 agFTFTRdj+/ZB3KRXhS1z58oaRH/29HDPjPoDXbiT2mOcIATyCukKPUBxuEix7qd
 q0epIpswKO+/EnSXWHgy8bfHZVpTmv/dagkEVzrNBdzmUP7F/N8A9B1CbbCPjKC2
 fgiU6Z5+lf5KUPaSC982QTnT4nHGHyOQECF2dWKDDL1bBrNfrFV7VnTk40vUNu2S
 XzFt7t9pQ+rpY8z7jxbTQR4plmhAi6TJHCYMrjiH4qXQhZjl1WL6s1KkE4y/VJbp
 D1euew==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600423; x=1787205223;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RloHWs3oXisIKexkmFbjiy2eK5Toyon6yDOEjsuhaF4=;
 b=hAjtzx1HGLA36lneiz1EnQ4OuPMFE+WEhJOrJTB/nM+yAYrXasVPnPZJF4NGg2cwRp
 s7/zsihB9y8bLLkzTUx2fJGAm0fV9cg9M6GfnhXRQGV+ox35rp1ToxE2h3YFLWxmuuYN
 pHuYMZJp5goZ0p/dSuXe8NFy0gjKRD7/IMmrT8JANOP2BH/MNLm/y6HB3tfZHUOJHkP7
 tQOAT4zeVUqk8scXKnFCKRNyHcu+OzoYr95i5BX3hg2q5TBL7ORbSGYjDufjkZqmpWRc
 4W4OOYCjmkZsSrlu1ls3ohYUd3TLp7Whc8G7ZSK2MUePxl6HLK3f1rL/IJzQCTXAwc6z
 7IzQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GhYIl2GC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hAjtzx1H
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

Add a third sandbox fw_images[] entry (image_index 3) that aliases
onto the same DFU alt setting as image_index 1 through a strong
efi_firmware_get_dfu_alt_num() override, plus the matching capsule
GUID and test case that applies it via ESRT and checks the write
landed. Without the override this would fail, since dfu_alt_info has
no alt number 2 (the default image_index - 1) defined.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/sandbox/dts/sandbox_capsule.dtsi              | 12 ++++++
 board/sandbox/sandbox.c                            | 18 +++++++++
 include/sandbox_efi_capsule.h                      |  1 +
 .../test_efi_capsule/test_capsule_firmware_raw.py  | 45 ++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
index 34d29916b30..e5464df1715 100644
--- a/arch/sandbox/dts/sandbox_capsule.dtsi
+++ b/arch/sandbox/dts/sandbox_capsule.dtsi
@@ -166,4 +166,16 @@
 			};
 		};
 	};
+
+	capsule12 {
+		filename = "Test06";
+		efi-capsule {
+			image-index = <0x3>;
+			image-guid = SANDBOX_ALTIMG_IMAGE_GUID;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
 };
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 13006a0ffc2..8ae7c244a09 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -42,6 +42,16 @@ struct efi_fw_image fw_images[] = {
 		.fw_name = u"SANDBOX-UBOOT-ENV",
 		.image_index = 2,
 	},
+	{
+		/*
+		 * Aliases image_index 3 onto the same DFU alt setting (0) as
+		 * SANDBOX-UBOOT above, to exercise the
+		 * efi_firmware_get_dfu_alt_num() override below and prove it
+		 * is consulted instead of the default (image_index - 1 = 2).
+		 */
+		.fw_name = u"SANDBOX-ALTIMG",
+		.image_index = 3,
+	},
 #elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
 	{
 		.fw_name = u"SANDBOX-FIT",
@@ -57,6 +67,14 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+u8 efi_firmware_get_dfu_alt_num(u8 image_index)
+{
+	if (image_index == 3)
+		return 0;
+
+	return image_index - 1;
+}
+
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
 #if !CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
index 84d45ec5cfd..848f1bdc4aa 100644
--- a/include/sandbox_efi_capsule.h
+++ b/include/sandbox_efi_capsule.h
@@ -10,6 +10,7 @@
 #define SANDBOX_UBOOT_ENV_IMAGE_GUID	"9e339473-c2eb-530a-a69b-0cd6bbbed40e"
 #define SANDBOX_FIT_IMAGE_GUID		"46610520-469e-59dc-a8dd-c11832b877ea"
 #define SANDBOX_INCORRECT_GUID		"058b7d83-50d5-4c47-a195-60d86ad341c4"
+#define SANDBOX_ALTIMG_IMAGE_GUID	"2d137324-092d-5f04-a62c-a7b2442cb0ee"
 
 #define UBOOT_FIT_IMAGE			"u-boot_bin_env.itb"
 
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index b8cb483b380..6c1cc3c6cc8 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -238,3 +238,48 @@ class TestEfiCapsuleFirmwareRaw:
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_fw6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """ Test Case 6
+        Update U-Boot on SPI Flash via an image_index whose DFU alt number
+        is resolved through board/sandbox/sandbox.c's
+        efi_firmware_get_dfu_alt_num() override rather than the default
+        (image_index - 1), proving the override is honored.
+        0x100000-0x150000: U-Boot binary (but dummy)
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test06']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        capsule_auth = u_boot_config.buildconfig.get(
+            'config_efi_capsule_authenticate')
+
+        # reboot
+        ubman.restart_uboot(expect_reset = capsule_early)
+
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            # make sure the dfu_alt_info exists because it is required for making ESRT.
+            output = ubman.run_command_list([
+                'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;u-boot-env raw 0x150000 0x200000"',
+                'efidebug capsule esrt'])
+
+            # ensure that SANDBOX_ALTIMG_IMAGE_GUID is in the ESRT.
+            assert '2D137324-092D-5F04-A62C-A7B2442CB0EE' in ''.join(output)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            # the override maps image_index 3 to dfu_alt_num 0, the same
+            # alt as SANDBOX-UBOOT (image_index 1). Without the override,
+            # the default (image_index - 1 = 2) does not exist in
+            # dfu_alt_info and the write would fail, leaving content 'Old'.
+            expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
+            verify_content(ubman, '100000', expected)

-- 
2.34.1

