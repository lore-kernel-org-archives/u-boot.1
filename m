Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0F3FEC0E6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AF683A91;
	Tue, 24 Mar 2026 18:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOqy1d9e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YPNuK114";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D4E807C0; Tue, 24 Mar 2026 18:59:53 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B6480087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCqYJg127487
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mUUzI6LytuP
 N6kSg0m/prYsHjYELy9QNhlvvfnOUzlc=; b=kOqy1d9ehzg0ZqGqs/G/DOwiO13
 v5RDg5tjndLHjd+qfJXHYZr0TszaVM7Tx/mCtWbctA9Rh7AWmr9PgBeTGB5959Mz
 VNgDpRnofJjw7SRkihA+5Ge2HKRRdVJkhzBe71QJQStcQrCS2RemByoP+V5tfrRr
 0HFUizOYYmg29W1ddT9dOGXJHE/uZ1OYmgBUpv2uhjrmfbrAzxl68XSFqujizhMg
 EQef+xbcYrgM+ppvrSlSXELXdrvgnWqcJ0r4gWCOzaT1cnGFekG/oJShCdWub8oJ
 CS00CoZ+DS1Oj6Rg0Us2crJkuFegTeV4ksmT/kaCwLnxSt+0EFZ7m4AzifA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m18k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c38b85c25so4692026b3a.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774375188; x=1774979988; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mUUzI6LytuPN6kSg0m/prYsHjYELy9QNhlvvfnOUzlc=;
 b=YPNuK1146RGUpBYXXYV7WSGD+F+vsG7Dc9afoF+7SuFw7MoQ3qAabXrFszRox7oMvH
 QQM+RnBIitLoaven978crghRpKx7+Zt29RSgo8vpP7MLgraNm77eBBY0PJaJ59OQbuEr
 Ybtpernur9axmV10BzLACKXH0VG3eGTJIVpbFeaP44jcxmmbSMLNitMl/cdhq/lKO83j
 yseXGlGsRvuPrRiZmzX7e+HVsJMa1kwLfrCnl+UH4wkpSXDh62p5C6N8iyvsR3yfeair
 /+TEWA4dp6DJBHgQrw7WoAIuPk2X+FX1Smew4dUWRofsYVtp17z81UcXO6EVEtRmOaxa
 FNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774375188; x=1774979988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mUUzI6LytuPN6kSg0m/prYsHjYELy9QNhlvvfnOUzlc=;
 b=p259HLvXmb5d4XywOfxfzsKhNEZPsS0t6LIhSiI6U39hnqpNNEnrVjWswpcJV1xhDh
 Cev2H1gq5lgGPH76PwrfMYpXmvJ1Kle+KLNdxGj/XR1OJsijhM+HTSnC3ogagzasqY8I
 mH3+9uDfmUtgz4ydnyD4yFR8NWfAinDGkg97kY3/a241o0nEEOY5mylZR5+qXbDDgOX8
 9ApRcq6mKkai4o6beVjKDMQpz4ZGRvy/1iZm/5rWiSCTq6vpLA0iFBo52hfEC/tKefuT
 ID6pTvKnQnGw2FJAD3U3Xb6YTesp9PKDaowrn7K1DpifOYAYuniFPZbtNG27RIfIHSHV
 qUoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ZlNtsSqTT7T+JKQ7c8RWC0PVt3K7VcRl/reSm6mvbv3RLqtj+YMiH+/8VpNPQevMw84OZiY=@lists.denx.de
X-Gm-Message-State: AOJu0YwXvIJJ31NiruLoGj6VoaK2JowzgH3BCrEV2JX5LOu5NmvIgHOv
 LsQcMjkaOObve7ty0CEogtUlID6l1Nea4gR9Cge721qxmOkuhC5i1r7wZsJYVZuD3/SGWCsFS9j
 ceyOvU8jHJuJxPhbg5NtIZ+5D4au6nacN/aduIk5nB1Y3UdyirAwFfPuy
X-Gm-Gg: ATEYQzyw4+95mEKJmao+HyDvrbsvdwYMHPgLvV6WteHqEWOW7H1dpw/oN9Q86JjF5SE
 3sLZNX2ErYDWLBXJ72agHyJ7IckUJCSSOWPrSE2Z7MVsDQtIsCi73ZXl247WN7mFeiCEqeAc641
 1huP3awqriHYNsYBDl41G6yv3+WjxEQeo4HGmLcnICbqwNMNJcaMKxYStCQ5bUgBvelnHPpkbiG
 h36b8JAH+FvnpS6TTUVAp/B9OTAkSvnQ8CZLzRiUPP2Xf/bq0CUOEzInjUji5pM2qdINfgsIt93
 0LTFLTBlNTDzXMih1lSI9z2Np42ynEKMXW2EY7dogK9LP05/5F2t1ZGmWZjoUPaRljMR19EgOJO
 p7nxedxfK1TNZVhDxAYE1QIhgF75WixLyrmRmt9tJfLpD4nKnYaXN1XoF4cL7Ow+Bv0HBMYEVsX
 2zt8ls64nsXfzFRYv5jx3NxBb1AGGWneE=
X-Received: by 2002:a05:6a00:9089:b0:82c:2647:eeea with SMTP id
 d2e1a72fcca58-82c6df8e900mr491824b3a.38.1774375187690; 
 Tue, 24 Mar 2026 10:59:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:9089:b0:82c:2647:eeea with SMTP id
 d2e1a72fcca58-82c6df8e900mr491803b3a.38.1774375187235; 
 Tue, 24 Mar 2026 10:59:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm15503901b3a.17.2026.03.24.10.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:59:46 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 sjg@chromium.org, mkorpershoek@kernel.org, jan.kiszka@siemens.com,
 paul.liu@linaro.org, j-humphreys@ti.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v4 1/2] efi_loader: make EFI_HAVE_RUNTIME_RESET a
 user-selectable option
Date: Tue, 24 Mar 2026 23:29:12 +0530
Message-Id: <20260324175913.92858-2-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c2d114 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2wRzn4P2ctwTsMK90zoA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: -r0_74ijvB4knSWozSPiEwu6ekKyQBF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOSBTYWx0ZWRfX72p+W2sMestT
 aenJsy/TJ5on1QApH0Jkw2wb0Lv9K8rREdVS9YzZF6jY9XeZpssOfUy+ayxkf5sHSnJLzbP7Plz
 FwjAwG2yGKYP0pJXhNgk1ADGfT0+FPDIXjUFCKBRONptTNuM/zj+qjPUpHQO2DxNIgymJO1CAvu
 HV2rjYuY2kVVzdt/bLb4i1FyaPNKB7cxguM5e3x7OGvjenCfp+6UobIM3Jb2m3uyvn31YxLhhA1
 fLIAqyr8MkO/o+5WGR/lADZR2e9xobDFsJdcfGHaPIcSiCLJNs+Qb8wIkp+tdn/JUTn7KlfhgEB
 xnM1Qh4J3Da+EjRWcBPg9Q8IPBr4xhj9pkbZY2oNclCS25kplglWbYfGBHlbTl8CYqEuL5DWFj/
 cmbnLkcOvIzETEfSwbapop98TBzv7fhtbvUDfw3a2bNCw/NTHw+9GY1jer3LdFW+RLhVbeQPS9s
 DCvZnVj0r7WvjkxhKqw==
X-Proofpoint-GUID: -r0_74ijvB4knSWozSPiEwu6ekKyQBF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240139
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Expose EFI_HAVE_RUNTIME_RESET as a proper Kconfig boolean with a prompt
so platforms can explicitly enable or disable advertising the EFI reset
runtime service.

The current PSCI-based EFI runtime reset implementation is always
enabled whenever CONFIG_PSCI_RESET is selected, but it does not support
passing the additional arguments required for specialized reset modes.
As a result, reboot requests such as bootloader mode or EDL mode cannot
be propagated correctly and instead fall back to a normal reboot.

By making EFI_HAVE_RUNTIME_RESET user-configurable, platforms that
depend on extended PSCI reset can now explicitly disable EFI runtime
reset handling even when CONFIG_PSCI_RESET is enabled, ensuring
that the kernel retains full control of advanced reboot paths.

Default behavior for existing platforms remains unchanged.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 lib/efi_loader/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d06..31d1c4fc257 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -100,8 +100,7 @@ config EFI_SET_TIME
 	  can be used by an EFI application to adjust the real time clock.
 
 config EFI_HAVE_RUNTIME_RESET
-	# bool "Reset runtime service is available"
-	bool
+	bool "Reset runtime service"
 	default y
 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
-- 
2.34.1

