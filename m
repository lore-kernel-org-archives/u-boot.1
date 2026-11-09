Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE40606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UBtlE+MU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ESe/UnmY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1814D810C9;
	Mon,  9 Nov 2026 21:49:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNB2YnS3I4ET; Mon,  9 Nov 2026 21:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA16D81083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260941;
	b=ApZ+pc4468KwF0cIuirgzRtes6YfDSU6y66GyyL+puPPiAcYUxs8sn5zJvKbGkZ5ioWj
	 ZLWAyWZsMjusNA12Yff0UZtcIhwAu6m3rB4+0O9/FJs8kUcaG1mhoBKeF1Pg/Wwrzt6t8
	 7dzZHqpEthSgmO4JNuKXEoCB2i6bJi35A9+BvWhciYwPiZRdVnRha4f/6zPzE8R6RqsJi
	 pD5oSS8nvIXiL4PO+Gfx+xf+Eblw1tZ9FnjqX+gVthGsuuboIiS6mQ8Fxr1Aa/Scu034b
	 zzutD9j72I7xWCQoobuIuhAovdidEhWpaAo2hcPDNy3K4dnFICz2w2JYOFlnlsCz7wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BG4MOHqNIHjY+bxeZKx5hHZpkH2Ob+gozDbd9dWB3dE=;
	b=sA1WpAUS+03wFssiPH8wucdOp3NKlV/3NnevPy4Nfsu+e/BYhVuWCOlpB0uPoq918Nux
	 DUoCdu8FcV4vuidBI8P+KlUnNiNLoKRHSJTeoyFV7NdbJdwgY3PWarO1/H+bC3k85+qwp
	 IGeb47KHG8JrATtIXFQn1Pz+LtpulXnwdByQOSNXbu0LtbE3E/rPnsiwi9xyjCpa064i1
	 scRtEKvs0beqKARoHW1SYQSbyjxpXLqsmTFNh6Piy9yaEwSIKfBw+ADB+4bXPGz+//+Ni
	 IKYlqF/erzUnL5ajZmUX9Z0lKahL794rivHR1DVmfdv9w7/p/jX4PLDAOiMGbRONeXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260941;
	bh=BG4MOHqNIHjY+bxeZKx5hHZpkH2Ob+gozDbd9dWB3dE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UBtlE+MUIPnRyYKdI6yzO/NEIB4kWSZZMopxQYdoahQp/TpC6JO8+68TR+QQJEIcX
	 GmM8PMOUE6IRPpW4QLAso/cKFD8KUS5y3AdZwBz+91vAaHLD+euX3gwCOGQlqqgimO
	 1gSZU6exnk8aII+VolQZVlKYghNk29qihxDNYx4tvbgi4xQZTG4gmlLRb9+XSbyJ/n
	 yyv6TmSGclqMCjs+QxE5BxAxAAfnKUhP//EZ3/TQWVpKItXbZRSAGqvvfLD3wBDC0f
	 Q59RMc4lieRzEc0eHJX13RJsupBPMDvLguQJyUHv+SRLrWbzOI3vbbacpCcKjCCkFb
	 juHf0Lp+3YGGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA16D81083;
	Mon,  9 Nov 2026 21:49:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8005CC4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E0794030A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id queZim2LP_TE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8EFF2402EE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ESe/UnmY
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EFF2402EE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so14513925e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260933; x=1794865733;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BG4MOHqNIHjY+bxeZKx5hHZpkH2Ob+gozDbd9dWB3dE=;
 b=ESe/UnmYA0qbElpFTLlxOchrWby/LzNHnDW0hyrt2WPyZ80EoaOJFvMf2Toxl0pYP1
 blPe1WXCacBrmKYvb9+Sh8z2gkjKtZwo7fxZJRWO8g+tv9bKfxRUeF6scfTN1rFKF6K3
 vv4C4zX58rjvjMz5dEcjGUQ9Ku8H1EIyJZ3cIIEMxVoWSTcggSA4ryp9WIf05OrwpDuV
 Aw2GVgpiR6tpXXFyLlsRGQBNfblumWHTZxOFLGWF+jSTwjK5koodEtjNoJOqYmkpXptI
 IL5X/mGd75Z2nhSDjFJcSsExuMm0GIQkgDjcE3/zsQ2bdMKQuzerh8nugEJTrdgb5jiK
 aWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260933; x=1794865733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BG4MOHqNIHjY+bxeZKx5hHZpkH2Ob+gozDbd9dWB3dE=;
 b=uqdsa/R8THa+lpZsr9FrRxY7Uj8HhNOmNY4rMnGIMwHNOahGxbMMCymz/45UktMNXO
 TXfv1piRvOTn+nrotP13YRf4nd2oi2Betj2/6zGZVpJqYcsqIpEg3mRjs3/2sqre3a8U
 tn2fdKGGl+GbOMmcH0/hmL2RToQQkP9B0CUBd7oZxll3Km/ITb4Y0shEC/3aoOIOkR0s
 g7dBJm48vU/8mW0iGRPBBjv9RSfBrZpNMsqQVI6U4+AsJV3vQanqQ1iByRcZpKyumIeT
 RmUxyBFzKzZQLYeEcFlYKP7VcwL3e6NpDaJ4NtJIAfMI1ZdUnnvCpHxteht0EL9GY/tr
 1lsA==
X-Forwarded-Encrypted: i=1;
 AL+hErES6HLgxtlHll1C+321FlHLOI5q/DiklGnX1+5XmBYidfpJRWzyLmfxQHi80kyPZ8ZLz0nz35w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8qYhSY+q0ANbJERJCgldCc1M/YNLwMAIZdJFIeYVgl8M/Vsz0t
 8JRlf9unheqc9ElvbMifomDmXPVPRHHEeG1XPGrXaGV0yDwAdni6FU/UFbiPlDBk8g0=
X-Gm-Gg: AYBFou3YscxMwJnFvPzU8jqJJpPOkhq+1hu2jhMqYMzdWJVo13/gVNBFGpnsA2z42cr
 u/ysDdG+t0u0TNnDWUJs59oBXck3w+xsdvxF/pDJPhp7jzh/W80vpkKhlVsV2oNxwjoXSvwjUdX
 cHCHcadoP3Nn4OP/0hQ0zVf2Knpli31oXBnyrt3RTxA0uwLR9pwYrkV2uYqJ9BMpttaNSZhkveg
 /+kBtr9EF9c33TrMFmaEzREPY85+ptD8YxtTcsdvKtvCEP2rOeiv0sLMEZun8HORK0/8jtosJOc
 uo6fYmuk/XXzofHyDxC+a0dqiy2l7+de+RIpLmo9YkqGDvINFa6TOXP48FVleD0A7a0EQMli2O0
 jYGXVHMS0rFBDImk+05uTzZKI3ZgsjdwIUmL8LEzdQ2R5N3CudcSmrbg4m9v+cTZiws9xXFssw3
 b91kyRlIfuSlCGctPVV9cUup5p/nBnRNwte0cFBs44hjLA1yCXLWweJSxn0P/e0NxTe7lE8C248
 HLObLsy6ZskWwCwL/rq5Ny7Q0LbaSX34b0rshm9TYweSXO1NXWeIhHJeANeApYH+WQofPY+z3lR
 SWAcmlVuP3lhUou/wCbHGLyV7KSZKpLnxR/Al4rWnjoiIJaShksKa21uIqcLoHfWrVAOpzs+m95
 gUwczy1dwsAfO4P4NWw==
X-Received: by 2002:a05:600c:354b:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ba0233bdb1mr8681915e9.11.1794260933248; 
 Mon, 09 Nov 2026 13:48:53 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:52 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:20 +0100
Subject: [PATCH v4 3/7] boot: fit: tell callers when a devicetree buffer
 must be freed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-3-5323cbfcc9f3@baylibre.com>
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

The FIT devicetree loader can return either data inside the FIT or a
newly allocated buffer. Callers which only need a temporary result
cannot tell whether it is safe to free.

Report when the returned buffer must be freed. This lets the new
fdt fit command copy the result to its chosen address without leaking
memory or freeing part of the original FIT. Also release the original
buffer when an overlay copy replaces it, and on subsequent errors.

Document how to map the returned address back to a pointer before
freeing it.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c |  3 ++-
 boot/image-fit.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
 include/image.h  |  8 +++++++-
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 956a3d97c42..e65114ff835 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len);
+							       arch, &load, &len,
+							       NULL);
 
 				if (fdt_noffset < 0)
 					return -ENOENT;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index fd43e1fed44..1909a6a2cb4 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2242,10 +2242,13 @@ static inline int fit_image_load_storage(struct bootm_headers *images,
 }
 #endif
 
-int fit_image_load(struct bootm_headers *images, ulong addr,
-		   const char **fit_unamep, const char **fit_uname_configp,
-		   int arch, int ph_type, int bootstage_id,
-		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+/* Track load-time copies without changing the public fit_image_load() API. */
+static int fit_image_load_alloc(struct bootm_headers *images, ulong addr,
+				const char **fit_unamep,
+				const char **fit_uname_configp,
+				int arch, int ph_type, int bootstage_id,
+				enum fit_load_op load_op, ulong *datap,
+				ulong *lenp, bool *caller_must_free_datap)
 {
 	int image_type = image_ph_type(ph_type);
 	int cfg_noffset, noffset;
@@ -2263,6 +2266,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *prop_name;
 	int ret;
 
+	if (caller_must_free_datap)
+		*caller_must_free_datap = false;
 	fit = map_sysmem(addr, 0);
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
 	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
@@ -2536,6 +2541,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	*datap = load;
 	*lenp = len;
+	if (caller_must_free_datap)
+		*caller_must_free_datap = loadbuf_owned;
 	if (fit_unamep)
 		*fit_unamep = (char *)fit_uname;
 	if (fit_uname_configp)
@@ -2545,6 +2552,16 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	return noffset;
 }
 
+int fit_image_load(struct bootm_headers *images, ulong addr,
+		   const char **fit_unamep, const char **fit_uname_configp,
+		   int arch, int ph_type, int bootstage_id,
+		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+{
+	return fit_image_load_alloc(images, addr, fit_unamep, fit_uname_configp,
+				    arch, ph_type, bootstage_id, load_op, datap,
+				    lenp, NULL);
+}
+
 int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 		       ulong *setup_start, ulong *setup_len)
 {
@@ -2641,7 +2658,8 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp,
+		     bool *caller_must_free_datap)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2649,7 +2667,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	const char *fit_uname_config = NULL;
 	char *fit_uname_config_copy = NULL;
 	char *next_config = NULL;
-	ulong load, len;
+	ulong load = 0, len = 0;
+	bool caller_must_free_data = false;
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
 	ulong ovload, ovlen, ovcopylen, need;
 	const char *uconfig;
@@ -2661,6 +2680,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	if (caller_must_free_datap)
+		*caller_must_free_datap = false;
 
 	if (fit_uname_configp && *fit_uname_configp) {
 		fit_uname_config_copy = strdup(*fit_uname_configp);
@@ -2674,11 +2695,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			fit_uname_config = fit_uname_config_copy;
 	}
 
-	fdt_noffset = fit_image_load(images,
-		addr, &fit_uname, &fit_uname_config,
-		arch, IH_TYPE_FLATDT,
-		BOOTSTAGE_ID_FIT_FDT_START,
-		FIT_LOAD_OPTIONAL, &load, &len);
+	fdt_noffset = fit_image_load_alloc(images, addr, &fit_uname,
+					   &fit_uname_config, arch, IH_TYPE_FLATDT,
+					   BOOTSTAGE_ID_FIT_FDT_START,
+					   FIT_LOAD_OPTIONAL, &load, &len,
+					   &caller_must_free_data);
 
 	if (fdt_noffset < 0)
 		goto out;
@@ -2709,6 +2730,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
 					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
 					   &base_buf_size);
+	if (caller_must_free_data) {
+		free(map_sysmem(load, len));
+		caller_must_free_data = false;
+	}
 	if (err < 0) {
 		if (err != -ENOMEM)
 			printf("Required FDT copy for applying DTOs failed: %s\n",
@@ -2819,9 +2844,17 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 out:
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	if (fdt_noffset >= 0 && base_buf)
+	if (fdt_noffset >= 0 && base_buf) {
 		load = map_to_sysmem(base_buf);
+		caller_must_free_data = true;
+	}
 #endif
+	if (fdt_noffset < 0 && caller_must_free_data) {
+		free(map_sysmem(load, len));
+		caller_must_free_data = false;
+	}
+	if (caller_must_free_datap)
+		*caller_must_free_datap = caller_must_free_data;
 	if (datap)
 		*datap = load;
 	if (lenp)
diff --git a/include/image.h b/include/image.h
index d991b4c2bc3..562ba3049bc 100644
--- a/include/image.h
+++ b/include/image.h
@@ -721,12 +721,18 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param caller_must_free_datap
+ *			Returns true if the caller owns the allocated result;
+ *			false on error. When true, the caller must release it with
+ *			free(map_sysmem(*datap, *lenp)) after use. May be NULL if
+ *			ownership information is not needed.
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp,
+		     bool *caller_must_free_datap);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.56.0

