Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0DEC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 08:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF348803A;
	Wed, 27 Mar 2024 09:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZ0QosNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A1688044; Wed, 27 Mar 2024 09:50:29 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC8787F36
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso1044413a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711529427; x=1712134227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/7EaowtJXBz9w+90gjXpdaHouzzLrrXTFxKKtxK/ADY=;
 b=sZ0QosNtKvqEjz5I176W24tLOluX9akaxes7rHFaRdSFl/7zIU5xXIANRc52Vsue0M
 70tXp3ZI860JPlJIXfLQMVBA8xA3PtvUMV2NaYXkCeU0o+nl2HuWsfu2vh80k0dw2IoO
 A8GWvq93IIiOEZFbpnQP0sCsk3AqbN0sParWJ015Fa8WpOs11rKtaq3sz8AEgMUKwFGx
 at6YL24a/5LY0+DgOcaSHKndBIhzT+nBJDeeAkeCVrAKyHrObD62k0Bzhk/4Nq8Pul3r
 EoZeXWrXEY7OZfbEh6ExHE/yt2W5zxIX8KXe6Id3XhC40ExIv6oPerY/e9KXuN9YGvxY
 zZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711529427; x=1712134227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/7EaowtJXBz9w+90gjXpdaHouzzLrrXTFxKKtxK/ADY=;
 b=JWgkceuJie/TaPnm1dOD5t4UmFiRaGelKp9HdpxVYYzOAxe4EbiATM8Fr3fzAihbdE
 egTZ5I0fAYfScAwm24IOgiXpEsoLiCXfwBM7SmeOmn9aVgsDCOvBLRFlQ9FRf3opYhxo
 qj1N5pYVDmVAu0LI0FfNXHrQNOry/s8T4GTJ8iHAhY3JjX0TJqFiRzvR60bvnh+afBBT
 1MNdf8LxZy/oj4F6sIzuMhGoOaVZuIsRJpkAY5SPR78A+pid9+QGj5LZ5k2tO3d3ZFQO
 z7F4c7lXDBrRHeBnqiOcUwkWWoUvfNMTKVXsBoAP2PYMy7fbDWlcaKahT4BInNwd9TcM
 ui8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKu7wpnBeoND/zOOBAnQMD36nmZ6rQA4xCnyR3HXM7xOBOTloI7tjmko4H+N4oQsxhEAHrhKiJf4XXJ8dvcSAaV/bLfg==
X-Gm-Message-State: AOJu0Yzp98KbGmteEXBtXIkKeAChlC97BY6tczpOIzaMifwp+blLJ0cI
 LLXg+5B5bmwkPKpTY153Cj9s3SpNDfT6yBIGpK5GAL4Qcgs6qrlzU4rF57njF8cXIwTPXYy1ZPL
 v9iAd9dmncxPmzR5JtrRGv93FhwiDMaEe2zAYbA==
X-Google-Smtp-Source: AGHT+IHcgg06eh38KaVtyCx/QU/8SCEbfE3ppdn7T3UZCa+UIIaBE9EX97QmrK9A7sD9KrUsr0YcpFfZo+lFFINxnMk=
X-Received: by 2002:a50:9b4d:0:b0:56b:d1c6:66a5 with SMTP id
 a13-20020a509b4d000000b0056bd1c666a5mr3100911edj.6.1711529427033; Wed, 27 Mar
 2024 01:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240327023451.2288523-1-j-humphreys@ti.com>
In-Reply-To: <20240327023451.2288523-1-j-humphreys@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 27 Mar 2024 14:20:14 +0530
Message-ID: <CADg8p94FjRoYkvdSHJ=2MycXceXDOQeES1S6VCNAuJ5ZBZqDow@mail.gmail.com>
Subject: Re: [RFC] Makefile.lib: find capsule ESL dtsi file when
 CONFIG_OF_UPSTREAM=y
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

hi Jonathan,

On Wed, 27 Mar 2024 at 08:05, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
> top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
> the dynamically created dtsi file containing the capsule ESL DT node is in the
> parent directory.  This results in a build failure because the #include inserted
> in the DTS file is local to the current directory.  Update Makefile to have the
> DT preprocessing of #includes search in the parent (dts top level) directory
> too.
>
> I'm not sure if this is the best solution.
>
> I was also tempted to just manually include the capsule-key property in the
> board dts, and avoid the Makefile implicit inclusion trickery.  I would actually
> prefer this approach as everything is more explicit.  But this isn't an option
> because if CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled, the implicit inclusion of
> the dtsi file happens.  It would be better, IMO, if we only included the
> generated dtsi file if CONFIG_EFI_CAPSULE_ESL_FILE is defined.  Was only
> supporting the implicit inclusiong approach an intentional design choice?

I was not sure if users would want to manually insert the contents of
the ESL file, which is a binary file(a few hundred bytes at least)
into the DTS. If you prefer having such an option, we can change the
logic to what you propose. Thanks.

-sughosh

>
> Thanks
> Jon
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 12857316c58..62f87517c09 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>         (cat $< > $(pre-tmp)); \
>         $(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> -       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> +       $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
>                 -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
> --
> 2.34.1
>
