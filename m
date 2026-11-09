Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F91606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0co4NBDe;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cw9cSfby
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F06B4072E;
	Mon,  9 Nov 2026 21:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5W70Rvz6iaG; Mon,  9 Nov 2026 21:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 772C040786
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260951;
	b=GVqiocvIAdCxvpkv2rxpP8vRzwmOOn6O/bjrnlz1+zTp/66Y42mOWHnbKGvdlYogHBtJ
	 nGgh61yFc11KFT2vtOcbaP3sNa9ALaQYoLMEa+I4Bdst+3Khlk+jHbzc4OPuYtTbqkoNb
	 2hRuLXrdr1pNtFY9EcEukzrRDw7IINUOp1vTRwM4QW37ipsalaGQ98YzHZkE/iA5MrMDP
	 V2rWUnMlJNuQvgxUQEoR7tB9qQrAi5m4945cd3e0gh3Yl50CR31SpKvhXwEmcVgpCmEpT
	 xzPTTXFZhVPq/Pkd1m20zNcTs3snfjqnyKv4Zn6ydfxw0Nzzpk3XsLhu4VKRxiZ0+2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SQtmBHUcrkK9ogV4zyr2kBmYqYWuiSFacRAIKqRh1QI=;
	b=lu8WFZUF4lMW7zL/aO1qhEbhx65vAu/WdRrHUIn3a2jHqC9kGYP2bAHKxyJJ4M+lo1A0
	 KhMwlOPE76MnQcpQ77yyNsqvrANkZli6AWcP2MpoUVS6Pe5SZmXNu73vENObKXDhDolMZ
	 be+7rcxkJB6nqNBIq5Lha11nGzpbHxHdEgZz7/jbiN7sntevFXc2eQNUeoY9SZaN+tBnr
	 1gXCvK2e3Lq7lgjNBVA2NKMhrK6RZJ1+/3Pk4Jw1nEOrPQ9ujuUvnhtEwgQzzd2uRwp6O
	 ess6Jl+pM4JL/qQ4VjI7lQOgzQxZ+er3ipY35wXEjTJObRQ5a7lkzuudLm2lthFjFYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260951;
	bh=SQtmBHUcrkK9ogV4zyr2kBmYqYWuiSFacRAIKqRh1QI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0co4NBDeFIo1A+3nJXv7Sjkss8/4Erh3vq6TYoh6UoyzxWkTTLxKcjYdAhfdhKPaK
	 43aHbvkuJ3lz3007S2Y1z2mtwWdTQ9+CGd9SmpEeLKmluGyiUxj+2aXbqPmzcjxjot
	 MnVYMrN84D4gkPYXIrspo0p1eDTzSJmXFNMKu4xRBMtODXw+/PgBO/R3t/gQxFD+NY
	 11wOGB2csHF4/nCfF/Hlrs2nRdIX3LQg8DEWe27xcMVAtvavS1CbOSE3AWwT9xX9oX
	 +PsZE84yl7cuR6Z5Cw8IdNt05o29NWkOioGNWs4ZjPiplAbl80bMgbTc2vJsuFW8Fh
	 O83jphloljj8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 772C040786;
	Mon,  9 Nov 2026 21:49:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38EFCCC4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A41780FB4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygnYtYpHuxOE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6CB88105B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cw9cSfby
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6CB88105B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:59 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso773484f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260937; x=1794865737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQtmBHUcrkK9ogV4zyr2kBmYqYWuiSFacRAIKqRh1QI=;
 b=cw9cSfby2V1DwcNnEe2pQX7rb3WSilTIfPmaq5bvrIWleMnQ+mtDl4I/RfjIxAyiVd
 EB7duJv5gEcYgfnfv0dejbHBnOjiYGeRMsbZ+gAdzAA/k0wI9I+cazskVVFcGgJ2dqOv
 WifvTZUe5tcPc0AUMjDsS6fia50Sj+y+oqljAgl6NtPJyN/poIQ+zHW3zIGRt+MJkB1I
 Admo43CMOZjx43bXS3Uijv/0UsXDukWQ8Q0sy4kD+uWY3ahdDLvj06ZYtZDAjCAZ6VE+
 r6AbOWKI6WbeberGC7H8ITcR6koLNnKR1c0joj7KUsDuoSnMu9Hfpa6lQcrVBurKphq8
 tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260937; x=1794865737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQtmBHUcrkK9ogV4zyr2kBmYqYWuiSFacRAIKqRh1QI=;
 b=chC7CkywwoDvtjPyNxuq7RfMRv7FypQDdPctblWBALG/cpVL7mhpyESjSR0jnGOv/F
 U/YAumO5KLZC1B71QjLUKk0biy8kWP2Jezug3Sgx90pVnI3g/ykLN4aXUfD+/Tsdu36u
 0OeC6ygeRj8F9ZlaGQxkfDGh4l5lDxOuMHnzb3lWpFySAy3lloa8XWrYq6Ouow9PKCBW
 AzmSW7soQRt0g54PnVBJ8qpihgKF9NLpybgofluAuZ9mD20Wfbaj8fVZGo8ZoZbukoOd
 mQaxh976NCxcsn3qYvgYurQW1WBRRjhJV3yS6FPEc2BE//DyjOfBfjoP/QuuW4+xpuPC
 L9mw==
X-Forwarded-Encrypted: i=1;
 AL+hErHLuOxSou8LDSs6INfxu/H2MqoJJd/GyHvi1Uzg5EmhtbaAAM+KYTo/f7w85g5D57/4h2xkx0I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+L3AHF+vrLGrCmCJLK2lHKVjbRyztAWSLFO9FvKO/1Ht3NMMeo
 ASM7KSLgxImREnT+wwLwRn5P9aqtKn0/e/FZrIPaJmGHY7Av4i0SaPM+MN09OBEtc78=
X-Gm-Gg: AYBFou3sXjrvgHYmE2iKKHSQvnNNSvNFOGfAgRjfqAhjn7xaIMVQGuPpZb4RJS6nMD3
 CtmjvsTTV0TlCsMkYcdgaCQBo8lq/6NdLGKjlWRNbUxOm/PETASHuLJs07rzB6r6hkia80WG1/o
 JaxfMLDSMHDt9lSYFwj7q8TUKaVaay+hRj2JpzHM2IH837iBLvsuxbznygicvdqx0Le4NLX6MQg
 RW1GM/4EDb6rF1IpPMABe+iMPdYZDKkDrxenbOAx1WySGT7u/S91SpwdtuObc95HoKp/+IzSvEt
 g3wa2St71DmaMfBLR6SGw7ztzUvpY4UbfaTmPZDaODIrcl9eFbp5m4qSyZM9DgURC9+Hr9V3BwT
 HchaR6ndD8aUMu/V9lOUfX37h1un+F/j5TAS/HxZV8k47EcOLAHkct4DNS7NrLpLMxPCxCtqy4v
 RnKRLXnAcXngsDz4yVPLv/uYKhLD230g0EE/0P9dHbm3wCQc4K7h+1BoA4OYbxe/390GQ/xCs1V
 iIDIAxWMHVtyBtCwyPkamuK57XSQB3V2bSPXcefgJRoJFJPwQXo9bN4wtLKUyLVkw57Aq84ObfD
 NDCMgIQC97c2zy8nrLO4KK3rtDRbE4QTXSSSGFSWIqOXS2/cI/2vzqDJiDkCrn6mmkVsQGJMtyq
 0Eg+Sqve1jcRAIrjpGg==
X-Received: by 2002:a05:6000:3102:b0:492:b221:ac38 with SMTP id
 ffacd0b85a97d-498303f13d3mr1263164f8f.26.1794260937595; 
 Mon, 09 Nov 2026 13:48:57 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:56 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:22 +0100
Subject: [PATCH v4 5/7] boot: fit: let callers choose where to place the
 devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-5-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a FIT specifies a load address, the loader writes the base
devicetree there before processing overlays. A caller which wants
to prepare the tree at an address of its own cannot prevent this
early write, even if an overlay later fails.

Allow callers to prepare the devicetree without writing to addresses
specified by the FIT. Alignment and decompression still take place,
so the result is ready to use. Keep the existing bootm behavior.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c | 3 ++-
 boot/image-fit.c | 9 +++++----
 include/image.h  | 9 +++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index e65114ff835..9678bf9c9b6 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len,
+							       arch, FIT_LOAD_OPTIONAL,
+							       &load, &len,
 							       NULL);
 
 				if (fdt_noffset < 0)
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6e7c7a4a509..2f5adeb6d08 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2221,6 +2221,7 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	fit_image_get_comp(fit, noffset, &img_comp);
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
+	    load_op != FIT_LOAD_PREPARE &&
 	    !fit_image_get_load(fit, noffset, &img_load)) {
 		void *dst = map_sysmem(img_load, data_sz);
 
@@ -2445,7 +2446,7 @@ static int fit_image_load_alloc(struct bootm_headers *images, ulong addr,
 
 	data = map_to_sysmem(buf);
 	load = data;
-	if (load_op == FIT_LOAD_IGNORED) {
+	if (load_op == FIT_LOAD_IGNORED || load_op == FIT_LOAD_PREPARE) {
 		log_debug("load_op: not loading\n");
 		/* Don't load */
 	} else if (fit_image_get_load(fit, noffset, &load)) {
@@ -2658,8 +2659,8 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp,
-		     bool *caller_must_free_datap)
+		     int arch, enum fit_load_op load_op, ulong *datap,
+		     ulong *lenp, bool *caller_must_free_datap)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2698,7 +2699,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	fdt_noffset = fit_image_load_alloc(images, addr, &fit_uname,
 					   &fit_uname_config, arch, IH_TYPE_FLATDT,
 					   BOOTSTAGE_ID_FIT_FDT_START,
-					   FIT_LOAD_OPTIONAL, &load, &len,
+					   load_op, &load, &len,
 					   &caller_must_free_data);
 
 	if (fdt_noffset < 0)
diff --git a/include/image.h b/include/image.h
index 562ba3049bc..c62e55eab0b 100644
--- a/include/image.h
+++ b/include/image.h
@@ -608,6 +608,7 @@ enum fit_load_op {
 	FIT_LOAD_OPTIONAL,	/* Can be provided, but optional */
 	FIT_LOAD_OPTIONAL_NON_ZERO,	/* Optional, a value of 0 is ignored */
 	FIT_LOAD_REQUIRED,	/* Must be provided */
+	FIT_LOAD_PREPARE,	/* Ignore load address, but align/decompress */
 };
 
 int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_start,
@@ -719,6 +720,10 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  *			name (e.g. "conf-1") or NULL to use the default. On
  *			exit points to the selected configuration name.
  * @param arch		Expected architecture (IH_ARCH_...)
+ * @param load_op	Load-address policy for the base image only; see
+ *			enum fit_load_op. FIT_LOAD_PREPARE ignores the address but
+ *			still aligns/decompresses as needed. Overlays always use
+ *			FIT_LOAD_IGNORED.
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
  * @param caller_must_free_datap
@@ -731,8 +736,8 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp,
-		     bool *caller_must_free_datap);
+		     int arch, enum fit_load_op load_op, ulong *datap,
+		     ulong *lenp, bool *caller_must_free_datap);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.56.0

