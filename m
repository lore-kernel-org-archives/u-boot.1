Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3306FCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6BB848EB;
	Mon, 15 Jun 2026 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDUAGv6C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="inREnjUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E26884704; Mon, 15 Jun 2026 09:02:02 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA6383FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IuDk3332546
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /U95DSAkJNRHuSksfuBaJ5TLiLhf8p9AYTq08NDKuDI=; b=EDUAGv6CZrR9UGfS
 oTBIcGC/yfkfIBeTUA8dfvlBtZzBKlmNBWbYkNjsyWVI3fFl1A6gt77imWVybkJF
 9HXCWbPeOsgCKwGmATI7/D8bFPvsaaXTpQXZfs9y/FO0QxU+GZVCtPM9yZ4e+kWI
 K0BjGKQI9dZioQv5VqId1ptzastryRiqYNeYoP7p9lSh9g226aO9Zl0fLVJwOqU4
 7k5jPWNxW3TN0hQcf0CFreC3CLh6HPHC07OWXF9SeE6nxRxJ9dODILrIgK7khZRv
 jYolbsHTXciTgOt7yD1yyLVe18WxXcDrmejb6BYahk5nP1Yfi5jNA4rMZAHgYFoO
 Oiu04g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye164st-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so2286374b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506915; x=1782111715; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/U95DSAkJNRHuSksfuBaJ5TLiLhf8p9AYTq08NDKuDI=;
 b=inREnjUD40Xxn++pTzPZGTBbXAJTI8gigPC3uBm7TW0/Dxdvs93J3PU3Awax1m1rgy
 7iBOBjIMCeUhcQR3JIEQhOycqHxVHOtdg3ltXJ/qry6wrDatHeVto5+H0FFg6ROqErXB
 0olXzMNoHWjDmhpeovsKHRsEOyBCrKi202Exie6ChWprtuGdyNfpQY5mFIqwX4xwnLWC
 ZMvYRJAth8vVr6Z491tgcoI/82bygz4OOsEiM4zg2t9gbfS1pGCyhuyRYnS0AADqPAMC
 Pk5HKOOpncn1O/cZRigXOfB3E8odtTEMevz5hZ3MKU919+Ct0kz58nhdz2cj0W1cPVEL
 2MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506915; x=1782111715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/U95DSAkJNRHuSksfuBaJ5TLiLhf8p9AYTq08NDKuDI=;
 b=WQR9t2X1h3nVCauqxys2lOnvzgA9f1PQNWXGath4tKfkujcTCkapvN3AmVTRST9mOq
 I7F7coOpEH3CrCe8j+f3Z5DjDk4EOK8wwjcmJMvo0Dy9A5d13HSsjPzBIrh7lLs5jKZE
 nQdLpwCnmgPTUGNCtHOMgy3+fxrx2MCSV8TR2dcV6++tOfmLkY4K+2X9U+qZrbc9mf2u
 WwHZe6waJTYpMX1y+2QF+HuEaTjaixN/g1VUntNl0yCEFgqM0ZNzcUu7YLc+cZK877AQ
 tfF8DXVTNY8WWscuXmS80NY6z7LHuZ2CN6jBQSqPj6nMWkg4B+85dCiFX2LFPpOMQqLL
 bC2g==
X-Gm-Message-State: AOJu0Yw8CVoI1rjSeYlR/VzvGe/EltT+qxcGxlupANZ07IocQee1vwnB
 yhAaMtu9ML9k4gu9NNKaQubsElH2aSzcD+nvBE9MguubNpYq1r9X4dSVu716xsAqWCEXbPUMAtK
 LCf3pX3AriPwmJwWA86ENq9jzNz7iHo8c7kZq9dymu5lIoqJ0ngU5nv86
X-Gm-Gg: Acq92OFYEnMPOalwPzL091+tyuNtco4nLuPROcBbWeQ2kdcygu0ft4xEh1mUO07e8Yo
 J7CIGeXAeMRtnuLULxsg46Xm0eqOlL9S8uqx3ClDpnOiRufP6Rpa0w0zkw617ynFrfNTuoc9EtZ
 x6q/vaxiMLzqKyhmWeen00nkTwyUvS3BAaAS+2NdZ/nmvT4lOex7RIyusUDTLLt7LDVwE1GffjM
 bzQm38wC/u+HXxSZq61KkrvuCSIHGR+ZDx1jfL+IlKssuk6FGRuPM03tZK4wf3n7LrMkaSXPAxH
 Lz+qHJwkXIyNxYu5EO3JF3Ht7jVcPP4Icg3sXD4Htneh+FxY8qpa8OEtXnbxMb2p9IBxaFUwxuR
 TT9i8G/Q1WvDckLf9qHvooihm+Vju3Tap44grF8DCflPPZaEPxMB4g8Zylmlokq2rbN4IRc3aIv
 gFNqCxGnFCVG4VRdWfOE7kEZCFqYd6y9qdIATJPve+vcLgz++ahw==
X-Received: by 2002:a05:6a00:1306:b0:843:472b:dba9 with SMTP id
 d2e1a72fcca58-8434d10739cmr13529197b3a.45.1781506915335; 
 Mon, 15 Jun 2026 00:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1306:b0:843:472b:dba9 with SMTP id
 d2e1a72fcca58-8434d10739cmr13529145b3a.45.1781506914832; 
 Mon, 15 Jun 2026 00:01:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:01:54 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:01 +0530
Subject: [PATCH v3 05/14] part: enable part_get_info_ptr for SPL UFS
 partition boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-5-360bceb29596@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=1276;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Urd2PO1McWcemspEsjM0gh/0UkFs30arCf6WVtZxpt8=;
 b=IkQtcQf6uxUEphsDPUVHIYhZJEelu7D5PIhl9eS7r3eBYN+V3ldS5JAjqD3gHYISIImfJEHbD
 mMJKw4jKHLSD4LlexKEMhqNZ4ZvlnYnCNmvD9yYhwAi5ya1WtkmrRVN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 70EbA5NpADNe-qY8gB4d8IsObA9vzTXw
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fa365 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=nXLrjZHcL9H6pKHq5Y0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXwi1VJ2dFcsEa
 qQSaQy2KqQs0/uNWNHzHNOZjjvDHBRDRqu4cZSq8TztANZkt7V2AnB4pTazOn3ZknQweERJjbBo
 0ZrTueUL0R946ys/tE/WZ+kBWzWpCM4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXyKjcHAgD/Ui3
 k1g8/SeqUU8fvKeadW+F2FE4fMPAlBApdU+EXVL8wBqqR1CIqVtWPKTm3xjMC1lvfF+poWLuvXS
 SajFHNEJAKKLHeNBP2GRXbHrDOqcVcJ7353f2c/ChJ2GcoLmAAPQNCZidu3Bp1y+anlBwUpAuk5
 JfelOC90/lr1W1ZEEVHwDbfV78uq9HnCNRVwmE/Gsh9Cn7A2EYg/bt1BmrgroQ9grO/oXkNGtpP
 lmnbgkVDJdS9SoMcHuPm8C30iLCb/mfjWdIBwJwTURsDQky3gBoCodMNpmizABnfNhYa5ReysRv
 hzfyUNhsAA6VVDzxXtuiMQyfSPRRbBZmdqsOdCSnvUxwti9QMCV3NXzjh3GrGURO5JnEG9M5DEl
 6tEJB7h2yQ88ytwzEx8jrPB3Hyuxn1hsRoHyDob7DSd5v5tY9kFK4PzZnl24TEDSg555k1KTOwZ
 Zs75CPQWuWqL6NKCkNQ==
X-Proofpoint-ORIG-GUID: 70EbA5NpADNe-qY8gB4d8IsObA9vzTXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150071
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION to the preprocessor
guard in include/part.h that controls whether part_get_info_ptr()
resolves to a real function or NULL. This ensures partition lookup
is available in SPL when UFS partition-based boot is selected,
consistent with how MMC raw partition mode is handled.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 include/part.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/part.h b/include/part.h
index 15daacd7faa..47b91e2043c 100644
--- a/include/part.h
+++ b/include/part.h
@@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SPL_FS_SQUASHFS) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL

-- 
2.34.1

