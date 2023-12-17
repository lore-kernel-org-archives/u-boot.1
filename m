Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D2C46CD3
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA02B87CD8;
	Sun, 17 Dec 2023 17:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6d0o5sO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F5B87CAE; Sun, 17 Dec 2023 17:36:46 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A309B87C96
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7b7020f03c9so110596639f.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702831001; x=1703435801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De1+a+m+4UWj3EBkJvn/XottNehwYnCTOBJVCOY34jc=;
 b=n6d0o5sOxFWlFJ8YupkMpl2O+ZTtDk7GCPz5a+j7fFqv1Ubve74QUn0PLr/O7qEC6n
 ubuQ6Md2AbUmgSzhSEHGdiiouIqeXypiYQ3Wte9yIxhVOMUoGP1axTCWn7lLvFNe702e
 o162BoR0UnOYHp09mYp/ugUZp4YGBQMueAYbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702831001; x=1703435801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De1+a+m+4UWj3EBkJvn/XottNehwYnCTOBJVCOY34jc=;
 b=stmt0lfUziKObcwLhLRin0UFyZ1OSbueYQswl6Pu819EQTQ1hjtO3noGgJ6dDkbSLp
 u3+DD6Pu5sdK3hFljtK1sWSdhZIWV9yP8C9rMuKc7uSS2avkg4AZxGf3yL2e/m2mVRFV
 IfLdy7vuwurNpn40UZ7gxI910W4x/z9wknwLUI8jgwkL81VYW657TZ89v3it2KCFt0EX
 KiIJZOXRR4uE6QilfwWK6fACuViGRCTEjsW9HseJmeat8y0mpNR/Zo76q9zcu1Nleu9P
 k4O6xqnxLeixCJSH45Bblh60QonVDndt+75Rvxt1RUd3FjX4oY+C6CmVuNuY7DJaPolR
 1CXw==
X-Gm-Message-State: AOJu0YyNGQ6fSRCDqm+zMJhyqPlxQdV2T/IDegvMZPai4TzW4y03NK1O
 TgiPO/cupf1S02R+yXc1WvBoF3XueCCkf/T6bbAYQg==
X-Google-Smtp-Source: AGHT+IHQcq7K2i+S/rnasvIlRiO43aoCaVSp/U/VhRJolFQYy4/S7pvpwGsBiegGzNNp77xqKm4AKQ==
X-Received: by 2002:a5d:8d0c:0:b0:7b7:652a:7497 with SMTP id
 p12-20020a5d8d0c000000b007b7652a7497mr11272947ioj.3.1702831001173; 
 Sun, 17 Dec 2023 08:36:41 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/10] fdtgrep: Allow propagating properties up to supernodes
Date: Sun, 17 Dec 2023 09:36:22 -0700
Message-ID: <20231217163627.2339802-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

The existing bootph binding is defined such that properties in a
subnode are also implied in the supernode also, as in this example:

   buttons {
      /* bootph,pre-ram is implied by btn1 */
      compatible = "gpio-keys";

      btn1 {
         bootph,pre-ram;
         gpios = <&gpio_a 3 0>;
         label = "button1";
         linux,code = <BTN_1>;
      };

Provide an option to implement this in fdtgrep.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index ca639a2d9f4f..f1ff1946bd4a 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -63,6 +63,7 @@ struct display_info {
 	int types_inc;		/* Mask of types that we include (FDT_IS...) */
 	int types_exc;		/* Mask of types that we exclude (FDT_IS...) */
 	int invert;		/* Invert polarity of match */
+	int props_up;		/* Imply properties up to supernodes */
 	struct value_node *value_head;	/* List of values to match */
 	const char *output_fname;	/* Output filename */
 	FILE *fout;		/* File to write dts/dtb output */
@@ -606,6 +607,16 @@ static int check_props(struct display_info *disp, const void *fdt, int node,
 					 strlen(str));
 	}
 
+	/* if requested, check all subnodes for this property too */
+	if (inc != 1 && disp->props_up) {
+		int subnode;
+
+		for (subnode = fdt_first_subnode(fdt, node);
+		     subnode > 0 && inc != 1;
+		     subnode = fdt_next_subnode(fdt, subnode))
+			inc = check_props(disp, fdt, subnode, inc);
+	}
+
 	return inc;
 }
 
@@ -955,7 +966,7 @@ static const char usage_synopsis[] =
 	case '?': usage("unknown option");
 
 static const char usage_short_opts[] =
-		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTv"
+		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
 		USAGE_COMMON_SHORT_OPTS;
 static const struct option usage_long_opts[] = {
 	{"show-address",	no_argument, NULL, 'a'},
@@ -985,6 +996,7 @@ static const struct option usage_long_opts[] = {
 	{"skip-supernodes",	no_argument, NULL, 'S'},
 	{"show-stringtab",	no_argument, NULL, 't'},
 	{"show-aliases",	no_argument, NULL, 'T'},
+	{"props-up-to-supernode", no_argument, NULL, 'u'},
 	{"invert-match",	no_argument, NULL, 'v'},
 	USAGE_COMMON_LONG_OPTS,
 };
@@ -1016,6 +1028,7 @@ static const char * const usage_opts_help[] = {
 	"Don't include supernodes of matching nodes",
 	"Include string table in binary output",
 	"Include matching aliases in output",
+	"Add -p properties to supernodes too",
 	"Invert the sense of matching (select non-matching lines)",
 	USAGE_COMMON_OPTS_HELP
 };
@@ -1202,6 +1215,9 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
 		case 'T':
 			disp->add_aliases = 1;
 			break;
+		case 'u':
+			disp->props_up = 1;
+			break;
 		case 'v':
 			disp->invert = 1;
 			break;
-- 
2.43.0.472.g3155946c3a-goog

