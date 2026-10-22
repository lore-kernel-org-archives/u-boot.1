Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D1606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AzpSodd/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L2ROcwgC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10C5360892;
	Thu, 22 Oct 2026 07:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6aiVAVdz4k1; Thu, 22 Oct 2026 07:09:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A168B608C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652961;
	b=Gtdy3PdLaYX7Xa0hLVK+jEwKotLp9Z3pi8OMBRaWk7ESd7Z+C5jrUWFsSXp2pDl9pNml
	 njeXclQBX05bGnPjKlTH8HraYHRpuWCUSsU+35qJTocusEzQzdRa26lon9uJUDBodivor
	 SZoRi0aG3/ZxNv533fNF5LADS4cgc9Faj6w7KuD6clP7K8IwY8vadwODxZDakEmYw1QHR
	 BLOaJrsgWUQtUbL68rl8dcZ7JxYp5anuWEA/1+AgtOZ3mUsYM5iI+01P0JPepetXE9etc
	 mGseM5gKXAtL6YhgcYlag0MEuxu0QVA07I3RrZNWz8Nj3SV9bbgW/6csUcTVaZbt6aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W6XZplW8L0rz4NPacQf75zIxOBBzdKxNz+HLy8EqFwE=;
	b=R9OJ0pwkdVvQKoIf9Q2eqHfzP5cmP3WxDvnbzPcbKEsOdY8gYnfis0Sz2lB3eQCoqzl2
	 6qHSKvHYDoa4TyQxR3L7VUTTWNjO7PNY5uVsI8sMw33+N3Nv5Th+dyGzq6TzK656Jdn1M
	 VQoj8b4GSyAO/N9/m69ZJwn/jrPFXtDFLIdc10xwqOOEoq07akYKsvdO5499uONejL9TJ
	 ldbrREy0xf0kbMQSCeCxijKdjOuASN0zQSWd6hm3vl3MMYqDaQWMB4WjfceA1Xu8ll/gQ
	 bWcNYXmXqVWeUSuoOb00HJN4EKL+FDEoGeV6CTDJGlVyssfhOTfUneXsiuSi4a5u0Ag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652961;
	bh=W6XZplW8L0rz4NPacQf75zIxOBBzdKxNz+HLy8EqFwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AzpSodd/dUHWtHfFeyM81xmwhDQQ5Q+otRH+VNSOP40ozaGP/TKdTE/nCZUFrEpca
	 GPIAzo7j9DgdOT517o3ak09ZP5SaKGLL4E+oBQyn7o3aqKZyLTUWRUh47tXhs9sN73
	 4TumsiDb+HUJEj/AAIMtDvLjlJJycaHr/uzEQbeRwRqWoeSGuHrbRd5vj/RLYH0RHo
	 lwUcvSuQRzBK2Mm7oZSFzNQBzPhVYfCnwP30i2uyS9cEoN4f77dH6eBugMKQrF6hA2
	 nMaKEtAJrbD2tVaopE0XQDdqSSb0kplO20lEc77szTTF9pJCvIWFoRS7hciW7qE2OI
	 1RwH6UVrl/nbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A168B608C0;
	Thu, 22 Oct 2026 07:09:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 736F01AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 658D640721
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C7FuJetwunCi for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65B70406E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652950;
 b=OCCEAwtX/DLP6Jm0sa4k0Qtd0H0vRsnn/vwH8NeEAuFcdDN5FlMmwG0xjOazf7EqCFe8
 jowJwSdmGAKdJqMyyo4IVMFRC3rPCfC6IvGuUwn3IHPy7g7oTMPArtBC9lUsovtr1HaRO
 BNAB3zN1aa4CI5OpgFTfo9CFMi9kwZ11CPjgSbDfaHzvspl1zXD/ydbu5h7KwxTg4ZoIZ
 EgVue3yHTccTPkBs/TAD9udc8egh/I/4OBjVUlcukmoS8NW4+d2KiqFz0SZf6/dNMner6
 pu2vaFiFxqOQ2JRMwxNa8W6n+6jBU43zQhLxcL8bwkVD4DdHFiXd7uGYQV0JtexaUaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652950;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=W6XZplW8L0rz4NPacQf75zIxOBBzdKxNz+HLy8EqFwE=;
 b=Ce4QzPP+d4sh0hzdUpbPHfKZLQxaRHX+uJmw41A8pV1f7n0oFZ61731J5ZvEqszAbLxX
 HD6N5taXaQzh2Ui4z07nTQJwmfcEOQqcCBeGW3AEpeDjFpsLrTAfHO6aZuSUTNvxyvY4V
 vjPf2XAu7R2i+i6Uy/M/qSnOj91iKKJuE7v+1uRyPpyQBfBoxJ7KFF4ESPftJrgdSdX/a
 HG5c66QWVE+3IJu9w0DoCgipv0Ma3evmbKmf007O1Wq0mjoUsHPn4osrQsv44A1OuRblG
 daZ7o4j9s4tEgHyNQ2pvdUOwr3xXVSqCoj98iPQPxHp8XI2KfPQlrq0Z1YpBbZsdw/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L2ROcwgC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=L2ROcwgC
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65B70406E6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-487049569b6so981140f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652948; x=1793257748;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6XZplW8L0rz4NPacQf75zIxOBBzdKxNz+HLy8EqFwE=;
 b=L2ROcwgCzp5jFrhEb9OWzjXOoVJAYv7ii24TrqRdzTRU9FA4oToZ7PaHw07nkF8qfx
 XRrBlRMw+0LE91yj5EN2SHI6y6tQALUL/QuBNWb2nC6AxZ6iPISi8whNDxT5/JwzsPRL
 w9XNxkjCPq/0mKNyz/vlEEzc7yGiB5nTy4muprMFtiLePNmZYHWxDzKLMGoK4d9OycWj
 rngXFRYVKcKDLH1k1MP/edfGeqUai4LM9km8cgTX1/Wyb4HUP3e1hI5aQeOCHr1+RREr
 +iJMMqXkK7bPKyfiYKQSH+JjcEFjKVuD8EXu+8VWC9YjSEJfOS2apGAaBlsydwN8w9Ox
 Gd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652948; x=1793257748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6XZplW8L0rz4NPacQf75zIxOBBzdKxNz+HLy8EqFwE=;
 b=c8ltOYFVWP+dwF6EsP+P9PfHjWj1cz1BWLgdD9sr1WY/YnyeuBBBsvq+mjIU0sGc5W
 kL2Z6tHnivWQntDysN26Sx4H56c9wdpE5Ot9YxsHX/37gaSfTVmvklEaw58UjUVGippk
 +vvGCvdkPYFuyMATI3r2uGBsuMN6Hrba4SDO7YRexPen9nOokN38IQvWnvtWCJAW/Y7V
 Cu9L35ojWa9tgw1iHOXshz16Q0hA0G8BxfbE4Z6m7pCOiRyRQf1Qh2GmSiBuhwO+kC5E
 0X5H2gmfmZ648Jdke/QohOHaTfet4x/QiBrRMFk7bD322UwfTsW8utrqw9jdeqpjqqaJ
 10pQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzX97VfHtNGKvRVAq+rD2S08AXt3oz0dpzcRU9+5Yp0WJKbpUvfGA/g0lw8nz4orgjbP9aC4I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL3lAL/ScuqkTfAQIKkV6lLvR4cX9cqO2K7wEMtaeTonNdxacpy
 SDdnv/qWzfmIDco+OPRfyzARQY4aCIkWVmsDbHFjcVO443S76pKBwbLj
X-Gm-Gg: AYBFou2IdEoHaXHMThIq4E43BcacbmK6/Uj6mJCQOyc6r/bo4B9VuxyBEIslHyUh2O2
 dmmJgMhvSLCrNApHXJWBGNS6bLDdbm4vEMqV9CTMsAwvW/J7I82MpdzQm7AzeVc2QCZnV+2Nncy
 tQuJp2av3pYe5RwrE8KBzz6og6f7lIAgEb99UmI7pATo0ijo0S5BnFLn9Q6vdyG08/TeY7GjxSy
 lnOK/W3itOp9+2QmYM4Fl2jijG2DkZUqHELV0MpXBHugpA+6ny0JOCtG9cPOPD/8ibQV9fpBNME
 1r71Qy/Ir2bvNY73EuFDaMlbP95y1Ju6mF1e7iby+7+PJThUz0Abc/7mrqF0nY4/OLY3qgkhBOn
 5km2MTCw9O3rQ+b0BOtzN0F0JPbNws1AsQBDz3Nyy64GCId7ygrCwFfSVJF1RzJEUXyPwXEUNyz
 kqzLQNHdL8K98muIKYjjjyCzx3DTb5B88fcJyy3gKY3uOz6LPrblDMoVlC/jLCGC8xuDrHYwTLR
 c9v8pO9zSE0p5JX8IJKWm5DYXRHE6R3G1ZO6KJzsDSDHTuSiiXGtmPmhJv1cw==
X-Received: by 2002:a05:6000:1111:b0:48d:fed0:ccbd with SMTP id
 ffacd0b85a97d-48e264caa01mr6511935f8f.34.1792652947756; 
 Thu, 22 Oct 2026 00:09:07 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:07 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 06/10] usb: ehci-vf: use usb_get_dr_mode()
Date: Thu, 22 Oct 2026 09:08:56 +0200
Message-ID: <20261022070900.616265-7-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver parses the dr_mode property itself, through the flat tree,
into an enum of its own that mirrors enum usb_dr_mode. Use
usb_get_dr_mode() and USB_DR_MODE_* instead, as ehci-mx6 does. A
missing property still means host, for legacy device trees.
usb_get_dr_mode() does not tell it from a value it does not know, so
such a value now means host as well instead of failing the probe.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - usb_get_dr_mode() is read once and USB_DR_MODE_UNKNOWN falls back to
      host, as Marek proposed; an unknown value now means host too, as in
      v6, instead of failing with -EINVAL as in v7
    
    Changes in v7:
    - Marek's review: this patch only replaces the private enum and the
      strcmp() chain; the ID detect gpio moves to the next patch
    - a missing dr_mode property means host and an unknown value fails with
      -EINVAL again, as before the series; v6 made an unknown value host
    
    Changes in v6:
    - new patch, from the review of the register base patch in v5: the
      private enum duplicated USB_DR_MODE_*

 drivers/usb/host/ehci-vf.c | 62 +++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..90840cea92d 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,8 +21,8 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
-#include <linux/libfdt.h>
 #include <fdtdec.h>
+#include <linux/usb/otg.h>
 
 #include "ehci.h"
 
@@ -150,29 +150,19 @@ int ehci_vf_common_init(struct usb_ehci *ehci, int index)
 	return 0;
 }
 
-/* Possible port types (dual role mode) */
-enum dr_mode {
-	DR_MODE_NONE = 0,
-	DR_MODE_HOST,		/* supports host operation */
-	DR_MODE_DEVICE,		/* supports device operation */
-	DR_MODE_OTG,		/* supports both */
-};
-
 struct ehci_vf_priv_data {
 	struct ehci_ctrl ctrl;
 	struct usb_ehci *ehci;
 	struct gpio_desc cdet_gpio;
 	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
+	enum usb_dr_mode dr_mode;
 	u32 portnr;
 };
 
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
-	const char *mode;
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -192,34 +182,32 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
-	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-	if (mode) {
-		if (0 == strcmp(mode, "host")) {
-			priv->dr_mode = DR_MODE_HOST;
-			priv->init_type = USB_INIT_HOST;
-		} else if (0 == strcmp(mode, "peripheral")) {
-			priv->dr_mode = DR_MODE_DEVICE;
-			priv->init_type = USB_INIT_DEVICE;
-		} else if (0 == strcmp(mode, "otg")) {
-			priv->dr_mode = DR_MODE_OTG;
-			/*
-			 * We set init_type to device by default when OTG
-			 * mode is requested. If a valid gpio is provided
-			 * we will switch the init_type based on the state
-			 * of the gpio pin.
-			 */
-			priv->init_type = USB_INIT_DEVICE;
-		} else {
-			debug("%s: Cannot decode dr_mode '%s'\n",
-			      __func__, mode);
-			return -EINVAL;
-		}
-	} else {
-		priv->dr_mode = DR_MODE_HOST;
+	priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+	/* Handle legacy DTs without dr_mode property, fall back to host */
+	if (priv->dr_mode == USB_DR_MODE_UNKNOWN)
+		priv->dr_mode = USB_DR_MODE_HOST;
+
+	switch (priv->dr_mode) {
+	case USB_DR_MODE_HOST:
 		priv->init_type = USB_INIT_HOST;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		priv->init_type = USB_INIT_DEVICE;
+		break;
+	case USB_DR_MODE_OTG:
+		/*
+		 * We set init_type to device by default when OTG
+		 * mode is requested. If a valid gpio is provided
+		 * we will switch the init_type based on the state
+		 * of the gpio pin.
+		 */
+		priv->init_type = USB_INIT_DEVICE;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	if (priv->dr_mode == DR_MODE_OTG) {
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
 		gpio_request_by_name_nodev(offset_to_ofnode(node),
 					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
 					   GPIOD_IS_IN);
-- 
2.55.0

