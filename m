Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0805AC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 17:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2B3809A5;
	Fri, 28 Mar 2025 18:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k8GCi0wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B4AC810EA; Fri, 28 Mar 2025 18:06:24 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD82805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e535e6739bso3923145a12.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743181581; x=1743786381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DVQy9pzG7MgsGKk/lOhNN8DYfOQLW28jiVe9Xr570xE=;
 b=k8GCi0wk/HCmA+pdJOXSE2fYvYh/iZ0Cr4N3Ok6JOvGGlbV7PdiZvz9HMv5I3VUWZn
 zGzYMmepT6L8rEZyK+p+1afvE/jmcDLo3UI/QVI63hpBL23DFyoSPtIb1I3rwgAtSMf7
 A36hpEio/Hq+tr1qy5qZObuV1/EjSWQLIkZJB4wB8UKfhkxk/F/B4gHZUp2gdffqJ/IL
 JfVHkqwu9HP9lo4+lSEQXvVJvyKUIuI07p4xy298m+zMIhr9M1x3o8d+9tpi1fBLdzOQ
 y4iER7gTxArNM9g1xEOTlyrGjtfleOTT12j3ABBl/ChKjqC5RCK+4f/KoBAGoRiYmUlT
 wCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743181581; x=1743786381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DVQy9pzG7MgsGKk/lOhNN8DYfOQLW28jiVe9Xr570xE=;
 b=FHUFIRN8CnFH/MrSnVGetrAPxThIz+GGfugx/CEF1WiQpEXDUfLgE1lXCF9E0uQ/X8
 tu7e5IJ4ZEAqlvYNPiIlGBi8yTtXpcz9IY8oVtwumaZPs02ectvis84tpTVLb8ldPRnH
 YrQyfJO8TrE8B9Ptpe8XxeEidu8AtGR7Yfhfj/NkCGhydWetmTOMtfgBhF/nu7KZnMy9
 WOdAnJjs+XswuP1HiWsH3op6z2nVBjxv3O7gQryJGSutaFO/8vI8guQ9YZsK2C/JInbh
 zAqm3HouMQhf1IrlCVNkvPmULfnKAjsBlHbrzvD7HDthKag2rK4Wv5LEDmtJPUyWY/nk
 Gl7g==
X-Gm-Message-State: AOJu0YwZFm8a3lakd0w/0ee4aRwKQCfxMvM71LK0bZmnJCdirYAymuAC
 dR3ULpCwip+v4FCBwt8A8AQWPoU9LHVhtMBW3GxYXCrTPQc0JLDZigX4V6TVzUsAhZ8lrze47Fn
 uIPGPHVI5NHNSFNhPgZqYvHh7uSI=
X-Gm-Gg: ASbGnctMCpc+ZnZuVwfgn3vBAcFuT9lO0e7XgOb7I0BqpWPxw43hjhgefXDQhALhsvv
 +EHTB7feaRqvDf6TLUukDZiXyiJM558qvjOi8cDp9M1ZYR27AKcI9nWr47/ljFp9O/0yPZHoyym
 g+3LIkSvNIB1Y0hh9ImCxPag7TYA==
X-Google-Smtp-Source: AGHT+IEHMNOlMHIWrBKHNdmvityZ+xlj0PMM3dhZ2zrlpSy82ADt+05NYINIb5EoW/Gh4VIGoUfw4f/Jg1YEHrU/YTY=
X-Received: by 2002:a05:6402:280f:b0:5e5:bbd5:676a with SMTP id
 4fb4d7f45d1cf-5ed8f3fd169mr7363173a12.22.1743181580940; Fri, 28 Mar 2025
 10:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250328163115.642347-1-patrice.chotard@foss.st.com>
In-Reply-To: <20250328163115.642347-1-patrice.chotard@foss.st.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Mar 2025 17:06:09 +0000
X-Gm-Features: AQ5f1JoX5fVF-zQpNe1IjgBk7NDeEAgxpT8SXnHkO36KBEJZIMnqQUnwiOXHvss
Message-ID: <CALeDE9NHP6J97A0Zy13TDB66cpcJutT0DYvU=Ts6G4aBN+RwVg@mail.gmail.com>
Subject: Re: [PATCH] dtc: introduce label relative path references
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 28 Mar 2025 at 16:52, Patrice Chotard <patrice.chotard@foss.st.com>
wrote:

> Since introduction of OF_UPSTREAM flag, U-Boot's dtc must be able
> to compile Kernel's device tree.
>
> Since kernel commit 7de129f5389b ("ARM: dts: stm32: stm32mp151a-prtt1l:
> Fix QSPI configuration"), label relative path references has been
> introduced. These label relative path references is not supported
> by current U-Boot dtc version 1.5.0: (see mailing list discussion [1]).
>
> In order to support such label relative patch references
> adds following commit from upstream DTC tree:
>

Maybe we need to rebase to the latest upstream dtc, I'm not sure pulling in
a random set of bits from upstream is the right way to do things as it's
brings things selectively which may bring along other issues.


> commit 651410e54cb9 ("util: introduce xstrndup helper")
> commit ec7986e682cf ("dtc: introduce label relative path references")
>
> [1] https://lore.kernel.org/all/20250115144428.GZ3476@bill-the-cat/T/
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>
>  scripts/dtc/dtc-lexer.l  |  2 +-
>  scripts/dtc/dtc-parser.y | 13 +++++++++++++
>  scripts/dtc/livetree.c   | 33 ++++++++++++++++++++++++++++++---
>  scripts/dtc/util.c       | 11 +++++++++++
>  scripts/dtc/util.h       |  1 +
>  5 files changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
> index d3694d6cf20..d34e1b04220 100644
> --- a/scripts/dtc/dtc-lexer.l
> +++ b/scripts/dtc/dtc-lexer.l
> @@ -215,7 +215,7 @@ static void PRINTF(1, 2) lexical_error(const char
> *fmt, ...);
>                         return DT_REF;
>                 }
>
> -<*>"&{/"{PATHCHAR}*\}  {       /* new-style path reference */
> +<*>"&{"{PATHCHAR}*\}   {       /* new-style path reference */
>                         yytext[yyleng-1] = '\0';
>                         DPRINT("Ref: %s\n", yytext+2);
>                         yylval.labelref = xstrdup(yytext+2);
> diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
> index 011a5b25539..b3b9c83873d 100644
> --- a/scripts/dtc/dtc-parser.y
> +++ b/scripts/dtc/dtc-parser.y
> @@ -34,6 +34,12 @@ extern void yyerror(char const *s);
>
>  extern struct dt_info *parser_output;
>  extern bool treesource_error;
> +
> +static bool is_ref_relative(const char *ref)
> +{
> +       return ref[0] != '/' && strchr(&ref[1], '/');
> +}
> +
>  %}
>
>  %union {
> @@ -176,12 +182,17 @@ devicetree:
>                          */
>                         if (!($<flags>-1 & DTSF_PLUGIN))
>                                 ERROR(&@2, "Label or path %s not found",
> $1);
> +                       else if (is_ref_relative($1))
> +                               ERROR(&@2, "Label-relative reference %s
> not supported in plugin", $1);
>                         $$ = add_orphan_node(name_node(build_node(NULL,
> NULL), ""), $2, $1);
>                 }
>         | devicetree DT_LABEL DT_REF nodedef
>                 {
>                         struct node *target = get_node_by_ref($1, $3);
>
> +                       if (($<flags>-1 & DTSF_PLUGIN) &&
> is_ref_relative($3))
> +                               ERROR(&@2, "Label-relative reference %s
> not supported in plugin", $3);
> +
>                         if (target) {
>                                 add_label(&target->labels, $2);
>                                 merge_nodes(target, $4);
> @@ -197,6 +208,8 @@ devicetree:
>                          * so $-1 is what we want (plugindecl)
>                          */
>                         if ($<flags>-1 & DTSF_PLUGIN) {
> +                               if (is_ref_relative($2))
> +                                       ERROR(&@2, "Label-relative
> reference %s not supported in plugin", $2);
>                                 add_orphan_node($1, $3, $2);
>                         } else {
>                                 struct node *target = get_node_by_ref($1,
> $2);
> diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
> index ba06ef348be..4cfc2adccdd 100644
> --- a/scripts/dtc/livetree.c
> +++ b/scripts/dtc/livetree.c
> @@ -583,12 +583,39 @@ struct node *get_node_by_phandle(struct node *tree,
> cell_t phandle)
>
>  struct node *get_node_by_ref(struct node *tree, const char *ref)
>  {
> +       struct node *target = tree;
> +       const char *label = NULL, *path = NULL;
> +
>         if (streq(ref, "/"))
>                 return tree;
> -       else if (ref[0] == '/')
> -               return get_node_by_path(tree, ref);
> +
> +       if (ref[0] == '/')
> +               path = ref;
>         else
> -               return get_node_by_label(tree, ref);
> +               label = ref;
> +
> +       if (label) {
> +               const char *slash = strchr(label, '/');
> +               char *buf = NULL;
> +
> +               if (slash) {
> +                       buf = xstrndup(label, slash - label);
> +                       label = buf;
> +                       path = slash + 1;
> +               }
> +
> +               target = get_node_by_label(tree, label);
> +
> +               free(buf);
> +
> +               if (!target)
> +                       return NULL;
> +       }
> +
> +       if (path)
> +               target = get_node_by_path(target, path);
> +
> +       return target;
>  }
>
>  cell_t get_node_phandle(struct node *root, struct node *node)
> diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
> index 23334d39bb6..25d4db1e8c2 100644
> --- a/scripts/dtc/util.c
> +++ b/scripts/dtc/util.c
> @@ -46,6 +46,17 @@ char *xstrdup(const char *s)
>         return d;
>  }
>
> +char *xstrndup(const char *s, size_t n)
> +{
> +       size_t len = strnlen(s, n) + 1;
> +       char *d = xmalloc(len);
> +
> +       memcpy(d, s, len - 1);
> +       d[len - 1] = '\0';
> +
> +       return d;
> +}
> +
>  /* based in part from (3) vsnprintf */
>  int xasprintf(char **strp, const char *fmt, ...)
>  {
> diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
> index 211d584435d..23e32962385 100644
> --- a/scripts/dtc/util.h
> +++ b/scripts/dtc/util.h
> @@ -70,6 +70,7 @@ static inline void *xrealloc(void *p, size_t len)
>  }
>
>  extern char *xstrdup(const char *s);
> +extern char *xstrndup(const char *s, size_t len);
>
>  extern int PRINTF(2, 3) xasprintf(char **strp, const char *fmt, ...);
>  extern char *join_path(const char *path, const char *name);
> --
> 2.25.1
>
>
