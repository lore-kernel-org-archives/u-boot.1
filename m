Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FA1C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 14:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44145832F0;
	Tue,  8 Jul 2025 16:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751985301;
	bh=jlUK/r1SMwenBWdhGsrhO+qIhSRo7AnLaDigTN/Rf7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZaGF7V+14mEjUko5npEsPdEf7eah0LNX1V1r6bolx92l/8pjx7fS0tyAx9CfPhM3
	 uA7rs9yywFajKdxwfPuX7mZKFi8aGCPgyTt3YHfyzTa0I5fyGDR8kojri9m7SiMgqr
	 OgcKRuu9ruTbds4hpDwFm3sLHt5dP32MVwr3ObLzHcTpMQwkpC4otue7ez/EqWFwUp
	 K/o6aC78f4ISdQ3Fq+dC2gEjsKKFLox4Ud0K+lP2SVrsy39fXpPS9rlmYugq6sn0aW
	 IcCZzRwiomG0O2vv4IRelSMx4U9J61MSblEl3mUfpHcnNn81mR96F0WAZ2My2mNciL
	 wsyOuHP+9SFFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C5F8331D; Tue,  8 Jul 2025 16:35:00 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416C783297
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 16:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="b5mELbRE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99B0D10380104; 
 Tue,  8 Jul 2025 16:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751985297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=jlUK/r1SMwenBWdhGsrhO+qIhSRo7AnLaDigTN/Rf7M=;
 b=b5mELbREVKm6ZW0dtJKJxubGf/K3dR5XNVNSfXizI9aEjPa5iRn2/qZ/WoopFVjejJ4IIf
 1mbQWyvtAcTjqSLNAwXgzoEvRHENeJQlPysvzENcQYK2SIVfNV1g0y0UncFfdyUYlycA7j
 pPQd39Dun2E8XKCE4UnbBLn4aBWazjVUcNIe3dLmkcD68gV6sW+hkBUKpMnLt6U8mCHt4j
 I8B/Pi/7Tm5QXjoKpuxAoLx3OEyG2KerZZDZo/2xe7XrOvsjjNueSDqvsFcTGGhKhVjmGT
 833lGLEZs/URNZD4OyulBDU6X4l6QC74e6siTFNyFqs1dBOrLa/B933dhhOx4w==
Date: Tue, 8 Jul 2025 16:34:52 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <aG0sjC1h5ggy-THS@antares>
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
 <CAC_iWjKFBJRG290byhLj0cZjdLKhWOD+7NMZu5OY1sokgNb8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKFBJRG290byhLj0cZjdLKhWOD+7NMZu5OY1sokgNb8Lw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Ilias,

Thanks for having a look at this!

On Tue, Jul 08, 2025 at 02:31:37PM +0300, Ilias Apalodimas wrote:
> > diff --git a/Makefile b/Makefile
> > index fa9ce756083..791c00713ec 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1545,6 +1545,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
> >                                    --pad-to=$(CONFIG_SPL_PAD_TO)
> >  u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
> >         $(call if_changed,pad_cat)
> > +       $(SPL_SIZE_CHECK)
> 
> There's a rule in the Makefile
> ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
> else
> SPL_SIZE_CHECK =
> endif
> 
> and
> 
> isn't this running?


Well, before this patch it only ran for the u-boot-spl.bin target. But I
also need it for the combined u-boot-with-spl.bin image.

I'm not sure if this answers your question?


Just for reference I'll put a link to the previous discussion with Tom:
https://patchwork.ozlabs.org/project/uboot/patch/20250527121049.106825-2-pro@denx.de/


Best regards,
Philip

> 
> Thanks
> /Ilias
> 
