Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F9D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC2C88A9D;
	Sun,  1 Dec 2024 17:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjoIkWJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF85887D1; Sun,  1 Dec 2024 17:15:05 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D4688C98
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee3737d2b5so1957564a91.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069699; x=1733674499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=03El7e+xs3uRUri06MWFIWuR2hx98IJGb0LCJYk/NGM=;
 b=SjoIkWJaswdOIBbfFKp3KtGl4lJnbbEWww61Ad8GD6an+bBvIlkGZHb9IGVwWZ0kzi
 TJne8Q8l61BJVhEvu9jboNuKgVLHkuKbAB0Xi55hFmI4JRVvIJndQLlK5U3UU9nmNepa
 93w2VRMMcZNO+5cm5mHpbNKprrRh6yHRmszAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069699; x=1733674499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03El7e+xs3uRUri06MWFIWuR2hx98IJGb0LCJYk/NGM=;
 b=UNJrjqZaFkx8awnFBz8ZeyFi2ogYShGJw+gW0u2DuEjw0V1GO6k+Lm2KuGgOPQxLFn
 nAlh0ymkNsKR/rY1hVWbbc1JkSRsrhd0XSyIiKdSqMaL5YzDi8pOHixBmk/17iko01Q7
 Kc1wcL0DHNG1PrQgml3ZLLBSGLYhJsb/YeX8zUNsi2bQOY074dQvKRf5PY0VP1E5dH7T
 9O9UG0Usz0hohbuwBJdmj+UqAEsk/vc/EG/MWxlZLMIU90PWWpyvhW8pvFGAnbLB6Tbz
 N6RRRwmv5ObX8U68aA5u0akI1jLzfu4GWm/uf+F3mUhbW4LAHzSrOabuiSVxfYOlqggR
 C4TA==
X-Gm-Message-State: AOJu0YxL+wEZxRfhUO0eHh/vGpa3NomeI1r80rochesJ9S91NSunUuec
 ceQOWzo4hVHfzgVLsJB41MgkZNXbxTiDjONc3lzVWrPeucvXWazbVc2QprHM2OexCFP4clxVOSh
 QKTmGzswFYhVELxazDFQ5TWPhiLwnl7LF1eZ/
X-Gm-Gg: ASbGncsQhy3sK5G3GIzXZ7pqMxZeX2yNA5HS1yK0ASpl0XA/k4BByQE5fpUKyyQlu3v
 s10mDnAL8CevSGVNFD7oMiNf4xKgMrA==
X-Google-Smtp-Source: AGHT+IGWQVXerDmVZApWXOvEcSgJeUp2xdxd12UP6s9K5Eq2dse++iF0zaPx1rJ1fVixLNodJOezPn04ixB2WjtrcbE=
X-Received: by 2002:a17:90b:4c0a:b0:2ee:9d57:243 with SMTP id
 98e67ed59e1d1-2ee9d570daamr5237955a91.1.1733069698902; Sun, 01 Dec 2024
 08:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-9-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-9-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:14:18 -0700
Message-ID: <CAFLszTjbB6jmERfTFa6NKuNTHaEs_gchAv616wOWOYZFWPfmhA@mail.gmail.com>
Subject: Re: [PATCH 08/10] Use the correct ramdisk address
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> CONFIG_SYS_BOOT_RAMDISK_HIGH copies the initrd out of the FIT and into
> correctly aligned RAM, but the addresses used for this are then discarded
> by the x86 bootm code. Fix that.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  arch/x86/lib/bootm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index c4446b1f9c6..cabf18fccb7 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -72,6 +72,7 @@ int arch_fixup_memory_node(void *blob)
>  /* Subcommand: PREP */
>  static int boot_prep_linux(struct bootm_headers *images)
>  {
> +       ulong initrd_start, initrd_size;
>         char *cmd_line_dest = NULL;
>         struct legacy_img_hdr *hdr;
>         int is_zimage = 0;
> @@ -134,10 +135,16 @@ static int boot_prep_linux(struct bootm_headers *images)
>                 goto error;
>         }
>
> +       if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH)) {
> +               initrd_start = images->initrd_start;
> +               initrd_size = images->initrd_end - images->initrd_start;
> +       } else {
> +               initrd_start = images->rd_start;
> +               initrd_size = images->rd_end - images->rd_start;
> +       }
>         printf("Setup at %#08lx\n", images->ep);
>         ret = setup_zimage((void *)images->ep, cmd_line_dest,
> -                       0, images->rd_start,
> -                       images->rd_end - images->rd_start, 0);
> +                          0, initrd_start, initrd_size, 0);
>
>         if (ret) {
>                 printf("## Setting up boot parameters failed ...\n");
> --
> 2.47.0
>
