Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A4606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YOEW0+DN;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EdMmyHbN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBAC5608CE;
	Sat,  7 Nov 2026 12:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fULtF7jUZaQC; Sat,  7 Nov 2026 12:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2283560767
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055804;
	b=Tk/z81pojEgK15DHkLjRJcffftbp75bYBWrmB4hBY5YRwbnRYqC1BtjL1nFKA10MmiRT
	 RatojsXwXiKc04uG5b2WxleJ8j3dNJ8DMuikTToDxJfg0JKWlr96UCgf5c+BTWe3+Vg+a
	 Nl4jzoEe15n6xeGajCxpGFx0vZQ4H6Hj7PHcXmqvHN42ed67Oz+IKLWXH1ySgOb02lyry
	 zXT1b4CUbkGixHa7s5vqwD32oID2/EnCwSkRlK8jbdf9THdMN7HSwK2Z3J3j605TpFZuF
	 4/thUkM/+R/1Z0WwmF2n6tp0TxUpOwVs8DvDaZcbZw5xKuQixSoblO08S9e6dniV/6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
	b=l39BayJ8qZrJ+Le9LRMB92LUdZ/kwAV8aWRanl+NsoeK57Iqd3qhrjAMJdxsjtv9f0ce
	 7KkVhecGJUW/U6gPl/6Sv+dVCSGoao+pZfJWtsER5MUZXV9calpcSIQ8qkngfia5gZAmq
	 sGeHTRpMnM9p8DhiEoyxrCuwEwkY7Cqlxo2fr3OzwDKW6mpVBNAHaNesiOVj/RLuMOyfg
	 77RSEt9XhF3Gil0KcRvT4Oj5zSztuEEQXc1h9Y2pdojP25/aE/Y9Jkt+hpIKRRTzWULf/
	 B3zVf6x93xyLdRC9RTWKCnafIfyNuRnyVvY6cfKiQDuobxkCnQctTCsYqSF4lwTjZbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EdMmyHbN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055804;
	bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YOEW0+DNqtiZDtbGsOEf9bgEpAikqagBOLCSMe5KtGuAVIElznAhC5tgNAqYjYcGf
	 IuidavFEP4fUONG1ZiryjcBhk9KmyLjzUx+okT9Wdrls2TzVBw+VeeY0uXWJT6lxQP
	 ZJFUBoClsVtl8mWeBIlJQo5eD4Ic+yAEHS/xJ1BFkSL113qMbLJeC8DVKf1z7Z3mEw
	 yTSGfpBIuBwEteJ3JtVSYzhepo9rMn3KtxV3sghvoLk6oqDOa/RFEHJVLsRBuyi6bs
	 GS5kBCY6W/yDliU5l+HVwtPjwQh6IZmgbWrj9EKlIG8sKRWXVc8H5lvsadQDo2Sc5H
	 /iPhNuS5+IoXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2283560767;
	Sat,  7 Nov 2026 12:50:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61DC931F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47136606EA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqBmf3C8pRbc for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AF3D606C0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EdMmyHbN
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AF3D606C0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:40 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b58c577e9dso247947a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036158; x=1794640958;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
 b=EdMmyHbNgFZiqW5nqHO8bz+s44ZHqDa/rfVTsPT14PJvg3lB0NIxumIPFAeHXxTmWr
 963ClMnhGGLxI04j9WosHTR7E57Hqm4so3oK+PCzYG0l9xogkFnHrTIF9Y+Z94Fk0y2y
 93PsCnSc5v3r53maYpYO9C2k+QAsHgiB/5q0Cgmf6InXhvEzfyp/iBAq8WAKnkh1zfhr
 ZZ7vh7XHrnMQ1yNu6kuqTOgpmpW8uzAGJEtcE8RNbfCv1v2ZNzZMNpU7Xharsx2h2Maj
 QC/AbIvTDk3LGR58ndlkPodnXcS0Mo/zZFaq+z83cftZQUqTiwaesTgoEPfB3naFyszk
 pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036158; x=1794640958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
 b=s+IRFntXxCoGkDnoJT9E13LvW/AZc+ESek8YXerRDAplUthY5GBh13EtGT9PGPjJpI
 uDh7RVqbdJZPR1nITnscehHDp3EhIdFSD3Z0W5SnqoP9/d+Mz9eFnX+sKwl51ulia1LX
 NlVOOvPCheu2zNCcVmn0u6tsFzm+BbWLR71/1aMoD4IrTSTVM0dy4cTlJEm7ilx5eKxB
 JvK7p/6cVP4EhI2iioxjnfS5EF+BncTJ9d/A4evz8WpY0QbDpWQvjHKvpjGkXbSNCN1o
 rlQ4ybgRLxqBt42UmSNoUhMMIOVx/9NOpquVE4t9tKvBa8rH5mE90FpKXfJXf7dAZJdn
 +TVw==
X-Gm-Message-State: APuU4Z91u4MPiZGb/X9oq/EjKT4a/Q2UbEQk0S2HC38J0ZVl8cIM3lmv
 T7WcxbORwPcmCox+RgGUfaWqpoGd9HTrRNwJ2D1As1N4A2KItR68HwoRaQhP8AP3Joemw7YTZ7p
 jRLwz
X-Gm-Gg: AYBFou1Hj04KxsZvvDMjKNgo+nHEmQezVP8C77JWUdMcBlDFb57mKpMiWNvnAC9KX/T
 m7Ignp17DERPI4aP5aN2iiARYjscBCOkEfNhXp5x5SacSok7cNJFxX5DGpKVWd8+zIzC3Fhhn/u
 44GPsklVvotQmNEmKVqvyvM9jBqXFiD8pK7w3hqXh6Q0XxafgBcTIfLl++fTjx2RNdKKHjA9LOF
 7wHUoqNq3vRGfWxGfJ8NxM4gcAkR3fqSUhliOsz3CzvH5DSIoRiS/+YTTurdsAO145hs4g0YHEi
 TXF8FusMgHvuvbmu1Ee5BDwcDZUmKZux3QOfARINUKhqAaXbYUICVmhmp0b6i5uucwt0WKjXqsf
 HNuvb7+qJRDvE6xXN8mSq82YqJCXEZO3rb5UBJBtzy0jVVWlNtyKfRs4HSON9TZGY03liWTpfHV
 dhhBFhCDi03UdxXZE5boStzU1VPwO5n01rr+yzDv4RTKD5s7Ud8R+tlDiQR921hr+A68bTVYIcD
 wmm7gaPETsJpNfBPHE42S3HlWMAtgynYUGPtQd/Fo3N1Q/FxIQbrDnilCR9Gr1uJvmkaco+9fc4
 YKznzLftVxnuPxxLAms+pg/WzzvbiUqYlqlTU9WeAiNM+5cryk/5FcTV6la+z4cmNQfOo9VgPxk
 bZAdcfocajA==
X-Received: by 2002:a17:907:da04:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c4d352cc4efmr502186366b.3.1794036158493; 
 Fri, 06 Nov 2026 23:22:38 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:38 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 07/30] usb: host: xhci: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:01 +0100
Message-ID: <20261107072224.3492260-8-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced drivers/usb/dwc3/core.c has a global dwc3_core_soft_reset().
xhci-dwc3.c has its own function with the same name, so a build with
both CONFIG_USB_DWC3 and CONFIG_USB_XHCI_DWC3 fails to link.

Make the xhci-dwc3.c version static and rename it to
_dwc3_core_soft_reset(). Drop its prototype from
include/linux/usb/dwc3.h too, since it would now point to the core.c
function, which takes a different struct dwc3.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 include/linux/usb/dwc3.h     | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 5b352866a5b7..ce740b8f51a1 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
diff --git a/include/linux/usb/dwc3.h b/include/linux/usb/dwc3.h
index 9ceee0a1c9f6..e916275b9817 100644
--- a/include/linux/usb/dwc3.h
+++ b/include/linux/usb/dwc3.h
@@ -216,7 +216,6 @@ struct dwc3 {					/* offset: 0xC100 */
 
 #ifdef CONFIG_USB_XHCI_DWC3
 void dwc3_set_mode(struct dwc3 *dwc3_reg, u32 mode);
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg);
 int dwc3_core_init(struct dwc3 *dwc3_reg);
 void dwc3_set_fladj(struct dwc3 *dwc3_reg, u32 val);
 #endif
-- 
2.53.0

