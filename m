Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22AAC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 17:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCF58773A;
	Mon, 27 Nov 2023 18:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bVxn3WMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124BA87547; Mon, 27 Nov 2023 18:11:10 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E85187655
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 18:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332e40315bdso2805798f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701105065; x=1701709865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNRQg0s3PMAlvStfqc3rfrJhX2ihiUrWDGcFjnnfTfI=;
 b=bVxn3WMb+D+pWEvkWlWg21CG3E5RB8PsmC3YXrABl+xnbIm/WgPbQmj1Zr8waWi3xi
 Se9sa05WNBNK39r8Nq0e78tcWDQc89nNjkL+3ShYshXaNGu5I9mGtnYJ7dCgtmOPcgNS
 GyxLQVoH/TSuXXBQVzDN0dMcVR7M/6/w/seOPQp3InuKIjWJj7DedJlVBOImbaoaXteh
 Kfv7YYiHCwE3iY93KQP39GTtxr7onnE+PNTYBuBkh5EcEG54pKbTmIVa6ZsUAeyU8Yu/
 mWWLbZAPhnwh6J0a9Xnr8Inu5bekWK5se7bG7Szuk/h+k3Gi/xyjr9dMUR3wTr7FAw20
 H0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701105065; x=1701709865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNRQg0s3PMAlvStfqc3rfrJhX2ihiUrWDGcFjnnfTfI=;
 b=egxgA2CQWQOeaNpiS+MbJ1AQmw8nTJ7mRsY7u4Ivpu+8pCEGYPZt+FVuvO73XsWuBB
 GDCtCBfficTBdHt+AlFLCvgOOOJ8hjqEePp8sQyDprI8oF1+UEBcKqagidHz59sp04OR
 nV/PfVW8UiDWqqr095AHJd/YIf2oPETm1dSBfNcWytUTF5EtgV0uZJbjEcMGLdFfD2fr
 yfHf6ojSrrSeFvF1jD2Mx8nm4zyD0WS0VUkUHEZhk8w4kjWqgKq+KKnBMMEL2y1i0hqY
 sckntTlOlMGpbJvKgwFtPTntWutLYyLEgEhamE0d6wkWH1H+0jTia8lL62UZjgct4wyH
 xZxg==
X-Gm-Message-State: AOJu0YwcXG+jFAY9QH49uAKj7ByrdIS8PSOkJAbB71dG6FWh/IrYIIgg
 g0BFvOmCe1v407SyLTjhirDzLg==
X-Google-Smtp-Source: AGHT+IG9ll5ox2kyqn3SaCcD8+W+9YigLXGUsosrXl7HCCZQr1i5SeUtg0fUZ7f0HsSpPvoP41ethA==
X-Received: by 2002:a5d:49c7:0:b0:332:d4a6:1143 with SMTP id
 t7-20020a5d49c7000000b00332d4a61143mr8969855wrs.7.1701105065182; 
 Mon, 27 Nov 2023 09:11:05 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 cp12-20020a056000400c00b00333040a4752sm2401198wrb.114.2023.11.27.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:11:04 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: sean.anderson@seco.com, sjg@chromium.org, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
Date: Mon, 27 Nov 2023 19:10:57 +0200
Message-Id: <20231127171058.165777-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If a value is not valid during the DT or SYSINFO parsing,  we explicitly
set that to "Unknown Product" and "Unknown" for the product and
manufacturer respectively.  It's cleaner if we move the checks insisde
smbios_add_string() and always report "Unknown" regardless of the missing
field.

pre-patch dmidecode
<snip>
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Unknown
        Product Name: Unknown Product
        Version: Not Specified
        Serial Number: Not Specified
        UUID: Not Settable
        Wake-up Type: Reserved
        SKU Number: Not Specified
        Family: Not Specified

[...]

post-patch dmidecode:

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Unknown
        Product Name: Unknown
        Version: Unknown
        Serial Number: Unknown
        UUID: Not Settable
        Wake-up Type: Reserved
        SKU Number: Unknown
        Family: Unknown
[...]

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
Changes since v1:
- None

 lib/smbios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..fcc8686993ef 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -102,7 +102,7 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
 	int i = 1;
 	char *p = ctx->eos;

-	if (!*str)
+	if (!str || !*str)
 		str = "Unknown";

 	for (;;) {
@@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		const char *str;

 		str = ofnode_read_string(ctx->node, prop);
-		if (str)
-			return smbios_add_string(ctx, str);
+		return smbios_add_string(ctx, str);
 	}

 	return 0;
@@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int handle,
 	t->vendor = smbios_add_string(ctx, "U-Boot");

 	t->bios_ver = smbios_add_prop(ctx, "version");
-	if (!t->bios_ver)
+	if (!strcmp(ctx->last_str, "Unknown"))
 		t->bios_ver = smbios_add_string(ctx, PLAIN_VERSION);
 	if (t->bios_ver)
 		gd->smbios_version = ctx->last_str;
@@ -281,11 +280,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
 	t->product_name = smbios_add_prop(ctx, "product");
-	if (!t->product_name)
-		t->product_name = smbios_add_string(ctx, "Unknown Product");
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_SYSTEM_VERSION);
 	if (serial_str) {
@@ -315,11 +310,7 @@ static int smbios_write_type2(ulong *current, int handle,
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
 	t->product_name = smbios_add_prop(ctx, "product");
-	if (!t->product_name)
-		t->product_name = smbios_add_string(ctx, "Unknown Product");
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION);
 	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag");
@@ -344,8 +335,6 @@ static int smbios_write_type3(ulong *current, int handle,
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
 	t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
 	t->bootup_state = SMBIOS_STATE_SAFE;
 	t->power_supply_state = SMBIOS_STATE_SAFE;
--
2.40.1

