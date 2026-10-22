Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40A606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LF0WGjpe;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lg4dkW61
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CF33406F9;
	Thu, 22 Oct 2026 16:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUkWFqWAd7tK; Thu, 22 Oct 2026 16:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEA3D40674
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686031;
	b=R09ZfDGbvuiLaZm1hlh0xS43lTynEYH5o5/rKveAfjdnK1VVM2cN49CUfSF3HSwPdQPH
	 k5CPR680xpL6PK2gJfD204E9wG5Z3fjef6RyvZsVKXaggtsUBFpcUcgqc/pW/EcqUxD1s
	 RoGeq0Caus9qkPZnaYgTawP7GOW5tt93tEFehPowymYn7W4AN5SmPYw8SFbEWdbz/BXvp
	 iq1iDDDmfvFnVuapivRCXNwSwYFt2grCBKkSAH+PdxdpTJgqK8wmBKykJJ4XTsCTbe+x3
	 ECgNTWQO7FpW3g0Sp5jPgTO20OrkuBOKkxJpqeSC+Q01jkLfYQJdDukaY48pki0aV7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
	b=JdLek3UDla6li6wXes1T2MxsH5Ag8qeXGOwzv3LYEYmtP1nup+KKM+3dKNk1SHiT/XQs
	 lG1zMBeSR3UV1ycQjk/bOtsw65ymGaICnchmonbrtmysDMAwXHShD8W7sp2NYW8FNlvPQ
	 0RDfGCfewglqRDOiPTegV1lWyRA0WMnDUGS+wS6AH9bujEhGSicAZRyM4slzgBlbsIdN3
	 m52edYMh/MztgAeA+zjTp4mM9ciaUtIFZ3SSxC6x/vnnvzMGkAgfgPzGrkdx68t54hMSp
	 Y6tUL0kt7WOFsWN2d0U2658v1x1m2bQWFC4b858sfR5kj00iUhLylBNmoWxVqGNsr3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lg4dkW61;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686031;
	bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LF0WGjpevxyTdI8eYr1dZm18JtGgzGONQZjBeC9vA0+at9JfDuoHN7XXocxZHJUey
	 f/PwhIt6nVbuwXwxVqc4oaoelZC5w34y54OzX4rGvoEjQxO56LhKCAuz652t4FtnV+
	 5NQF1fDeR6FJQZV0euDVwD/CIEl5y919KfLk/BHuNqrv4dg7cqSjsnORUd0UNXm8tz
	 TufuDL3SKhfoWOu/1Fg/PlRZdFSqGmGS6efJsUuGqe3uPGrwttmKNQ6rUk4OECOYVZ
	 mX//PoMW6EXrFHr7LlD7z9DwVBL1MP8m1gFvC/t/kD6k7X34Jj8FTkgh2ZA5ifIPjU
	 blivHcifQASjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEA3D40674;
	Thu, 22 Oct 2026 16:20:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 694793A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F16E40688
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uq1nyEUaMpyt for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 322E340674
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686026;
 b=BjVngRo0uELfLFJVfPaasOZMn3NNu45G1ctSBNvqvolG39EK6SkAWGryztkhaaSAiE10
 BHuOl6aLnQnAvTQ7GkeHAZSuyCuG4Xa27oXW9nMnp1ddGE4Py8g4CN4Y03t6d1GdCG8Zo
 M46hnugMrzbO0DDemR95B3UHwl68uILu6NwjhtJOUcwvuJzsCz2rZ3TdVXZ5L+zjK0GNq
 62Momv3jdyvpq4Jms+uFOztGUvR3KQPyN1G/TKaxVHIdGCDtlvXGMftcG3T4Ex4ZG4GBv
 s9iJLGXwQPVrd9y/88iCNQxb4hM1Ej97JY+NfvVLznauUjOQnXX7UHQ/FLVVMx5SdDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686026;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=h3zH30QUEzuQ7lj0AEY1H2eHQ6/p0HnjqSMvgz6klDvfit+AtcQ84864kYoJ3/1cAN16
 U5ezy5bJyCXx9HjyeXIsZexE3t+NetgK8O01CqXQPQqvnoeWV3Lp2od4za20P2pvA4oop
 l09brvbgfZU/x69+Jy8n+VNWc/nCqdl3mhat/5MFJr5e1sC+syj5foVD/94wt5mnUFe/A
 CgJJith3T8H+0EYBsseCYvxulHn/6v+jGaBQQ9Z7Pi8Yvu+DTO2GnTCmAbcezbbvs5kZJ
 4qxc3m5PXIH2N5zGcCAn/dHXZbx2U1DY8VAm4/5lOJm9DEFjIHd0TpXhY9tRY/NqNWw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lg4dkW61; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lg4dkW61
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 322E340674
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:25 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso23774255e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686024; x=1793290824;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=lg4dkW61uPDvd/UNsfNKPhGBv2Ha0SvsS49PNaqXiUY2/8gcNaFoxoWRPzHHqHrOkO
 VzrujW38tE3siBt65FNOGCqQBtMq+1VEvlFBF279pqJQS9Ap8ZK6XoRvZ1LhmPx8EdS2
 5MNHLFwKdUUJpSjBpV+s/PIaqpP7W3MDAp3w0FOjSRhrn1ecD+upp5Az1fHe3jmeKIWd
 /F2JO7a4xHNFCwEBrTqUkC0HdMLb7i2Jga6eJMNesg6x5Pa7akSkv6ho4VprWVYqH/Mi
 p8iCWQmOEanEBuOSJyNMaZ/kQNIjyOCxyL/J27X5y/8JzPL4uLm5+H37egwIH2k6wGiK
 AaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686024; x=1793290824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssgvAuDc72p1Rw2ab1alYH4XHKJ+huby9vbdR2/oEz0=;
 b=2uKv9kTYY6PfZxlvelKtCSeuvrfA9O96SIg+lTDD+M/oPqcMNktuiRuE1WSEFblc6Y
 635kSgr7bOe3RHoYffCSg0rDHZpVW4hj8O+HEq9YQ0WxE1lli0jc0/5b1axfZuIfWLWB
 7wuGLUAcjuk2Ml/NE5n/xlYWIF0NuT6/VytqbM5+nQvHxPMqAHuYHkwP5D/kjJ1qGw88
 QFK4L75+wAxgSic90wvqKJPHB7Ol6o+UHSAoOAtqGTBI2gDWOAR2Ajxywb295nenF1vJ
 v8W7ATuAjkT0PBjNmpxWvclJYy6buKctWAXYhAPHT5Joex1hnRE0p6NxaUg7HdEX1Brj
 wrPA==
X-Gm-Message-State: AFq9FYLSSSn6jC2nAD3os5zY+1Gccw/XEr4YQbCNgo07A8TDGhojgzMl
 JLIEDqwEfy5aqfLDKp0/Suh71eP1UTyJDUqGgLVTsOe9+rXOlfRIZbaOAW36DzyKVrs=
X-Gm-Gg: AYBFou0q5G3zECcojrowR63s3EnyQtjb9NJs3OlI/cDACjAkfety9K4ZrB3TIvjI6+w
 pOsgu4vB4mY9sS7aJZelR2pezOMYe3KodTbQuDSRA5n1MaFxaZR7tsWPupDbvZm6wXTai+7gppe
 2Ln/G9mjCUYYSkj+7PCA/+Qb4D+ZTpH5koayMCKF/Rvf9XLDl68ejYKgSx/VyjekV09XUOTSyAy
 BuxdkP47pxxDlhOSLtYJImDW8NX9z74oOVWgPfbeT3rFgqEXIoeNiHpwLE43uHBqlvjoL1Qef3c
 z68ACABNIU+GRcSCL6gM5XkwyUpleop4mKfCuvvBjmaOz9PSvIW9W+4UxuuzCqhSwUKqwNQT9Wx
 M56QD8WkpHeVkeC7tRKbIXuBHv8o6Fh+m9jbhSUA22gqcYbSnJFW1Pp6GW08P0W3DtzimftYobf
 fnsXIPr1bobm9qgg+ZuuRvJ+G1ad5LCa7TMO4keORgm+BA3QnrX4ORJzM6DlPWQNmlHWvD+VtgL
 tjQugdmulWjvH5rfv6cbBgCdXzKgaeSkXOGrzIqvxGMesvAJOFrzKS7ug7T9TtlT01lZjEV46uk
 4q5ea8i7Xyeijv1ePo6ZYTXlIs8m
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e11f:b2ec with SMTP id
 5b1f17b1804b1-4a1fd8a068fmr145038375e9.3.1792686023652; 
 Thu, 22 Oct 2026 09:20:23 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:23 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 18:20:11 +0200
Subject: [PATCH v2 1/5] boot: fit: tell callers when a devicetree buffer
 must be freed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-1-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIT devicetree loader can return either data inside the FIT or a
newly allocated buffer. Callers which only need a temporary result
cannot tell whether it is safe to free.

Report when the returned buffer must be freed. This lets the new
fdt fit command copy the result to its chosen address without leaking
memory or freeing part of the original FIT. Also release temporary
allocations when they are no longer needed, including on error.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fdt.c |  3 ++-
 boot/image-fit.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-----------
 include/image.h  |  5 ++++-
 3 files changed, 61 insertions(+), 15 deletions(-)

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
index 60e47db5fb0..4f4e7b4e06a 100644
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
+				ulong *lenp, bool *ownedp)
 {
 	int image_type = image_ph_type(ph_type);
 	int cfg_noffset, noffset;
@@ -2255,6 +2258,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const void *fit;
 	void *buf;
 	void *loadbuf;
+	bool load_owned = false;
 	size_t size;
 	int type_ok, os_ok;
 	ulong load, load_end, data, len;
@@ -2262,6 +2266,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *prop_name;
 	int ret;
 
+	if (ownedp)
+		*ownedp = false;
 	fit = map_sysmem(addr, 0);
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
 	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
@@ -2487,6 +2493,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		log_debug("decompressing image\n");
 		if (load == data) {
 			loadbuf = aligned_alloc(8, max_decomp_len);
+			if (!loadbuf)
+				return -ENOMEM;
+			load_owned = true;
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2494,13 +2503,17 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		if (image_decomp(comp, load, data, image_type,
 				loadbuf, buf, len, max_decomp_len, &load_end)) {
 			printf("Error decompressing %s\n", prop_name);
-
+			if (load_owned)
+				free(loadbuf);
 			return -ENOEXEC;
 		}
 		len = load_end - load;
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 		   (load & 7)) {
 		loadbuf = aligned_alloc(8, len);
+		if (!loadbuf)
+			return -ENOMEM;
+		load_owned = true;
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
 	} else if (load != data) {
@@ -2517,6 +2530,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 	    fdt_check_header(loadbuf)) {
 		puts("Subimage data is not a FDT\n");
+		if (load_owned)
+			free(loadbuf);
 		return -ENOEXEC;
 	}
 
@@ -2526,6 +2541,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	*datap = load;
 	*lenp = len;
+	if (ownedp)
+		*ownedp = load_owned;
 	if (fit_unamep)
 		*fit_unamep = (char *)fit_uname;
 	if (fit_uname_configp)
@@ -2535,6 +2552,16 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
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
@@ -2631,7 +2658,7 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2639,7 +2666,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	const char *fit_uname_config = NULL;
 	char *fit_uname_config_copy = NULL;
 	char *next_config = NULL;
-	ulong load, len;
+	ulong load = 0, len = 0;
+	bool load_owned = false;
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
 	ulong ovload, ovlen, ovcopylen, need;
 	const char *uconfig;
@@ -2651,6 +2679,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	if (ownedp)
+		*ownedp = false;
 
 	if (fit_uname_configp && *fit_uname_configp) {
 		fit_uname_config_copy = strdup(*fit_uname_configp);
@@ -2664,11 +2694,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+					   &load_owned);
 
 	if (fdt_noffset < 0)
 		goto out;
@@ -2699,6 +2729,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
 					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
 					   &base_buf_size);
+	if (load_owned) {
+		free(map_sysmem(load, len));
+		load_owned = false;
+	}
 	if (err < 0) {
 		if (err != -ENOMEM)
 			printf("Required FDT copy for applying DTOs failed: %s\n",
@@ -2809,9 +2843,17 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 out:
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	if (fdt_noffset >= 0 && base_buf)
+	if (fdt_noffset >= 0 && base_buf) {
 		load = map_to_sysmem(base_buf);
+		load_owned = true;
+	}
 #endif
+	if (fdt_noffset < 0 && load_owned) {
+		free(map_sysmem(load, len));
+		load_owned = false;
+	}
+	if (ownedp)
+		*ownedp = load_owned;
 	if (datap)
 		*datap = load;
 	if (lenp)
diff --git a/include/image.h b/include/image.h
index d991b4c2bc3..4ef5344c718 100644
--- a/include/image.h
+++ b/include/image.h
@@ -721,12 +721,15 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param ownedp	Returns true if the loaded image is separately allocated
+ *			and must be freed by the caller; may be NULL if the caller
+ *			does not need this information
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.56.0

