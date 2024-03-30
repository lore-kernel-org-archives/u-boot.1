Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B2CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 10:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B2087E2C;
	Sat, 30 Mar 2024 11:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dvwPBl+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7371387E53; Sat, 30 Mar 2024 11:48:15 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F64187E06
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 11:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-515c50dc2afso2910872e87.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711795692; x=1712400492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uXC3E1YZHcWWiem8um4/baKu/rItZ8yriznqYFtm2JE=;
 b=dvwPBl+U9YK7Wl3/SM4DF0970JTYwr9T6YBs3KN9qWX1VqNSp6MR5mcv9LnL37YUDm
 LMmLEePnOK4qIuFaiP+AMtvvGHY/z0Kasy5QwkMz/kCrBIcV0l7rrdZK8sL6laEviqby
 eONGdnULz4XuxDAl39XkNkjW+Nf2T4aCk51AZZT8rMtwqN0pACDrxPOvGfgi/aHiKgVr
 EB11BXoM+sVA1tQ+gPXkYnG48l+Sz4bZU402oMwncA1OWLEMcucJ7CYfIXEqQfYLqpF4
 cxWzRTLSgBg3ChDxmCK7XxyYjyDbo+evkh/zeqsnJWDt4DEYKIxPGPSdwyjAL9pyt7R1
 xTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711795692; x=1712400492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXC3E1YZHcWWiem8um4/baKu/rItZ8yriznqYFtm2JE=;
 b=Q3ufeDw5z2SlOr0YVWG9KARxcF47/twJOi7fTXqRo9zX+vT0vcUM6L4oWBfd9Z9iFp
 U+KhkCDHcTjvaeBum6YszFas4OGZ+tiWvxhV3qVSXWn6ATxuROhkYTOSqPk6Mg8Am9ax
 GWPEqPhIxYrbtmtOICj3ZrJU2QSh10qIQod9pAducH+DrpRuEzu3hQO31Q2lNAod24CL
 qvuFWohmXCt3LLl5h0c0qnzWj0qAzEhkjKdlAM5tQw571WIVYUCcGFia1gwDEwnKm4XJ
 kIq/tk5sg+r1Dq8eedLL511pTmrZzn5ZJYqcL1adUZa/kAXKQ5sqJyYKL9VeRNBr79Zi
 cp6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqf7hXMAAcIrnNXVc16FKeKeD0TkSBumLE9Pg45+1d7C63wokBjx+57cTRmVe3zLKdhe3QeCXW1QRa5J1TYPGLLj4YYA==
X-Gm-Message-State: AOJu0YwF0GJt5qTtoYO5x03L+MRDIz/1QaCyVyNKkrmsRzbys8Mnk8RQ
 uBfUVjnVvxKhxotH57UFZWtyDRORVzgoBQIj/7h08gbZ7vB88m3R69a+N8QtX+bp5dxeI21nABP
 DkcyQxzizmxxO/4rogUiR7zjdptuSnkzSt7NO/w==
X-Google-Smtp-Source: AGHT+IGUK+AOy/1F/kHWAh2XyBM+q86skFg+HEsek0bkImKwDVA25kmoNQEBkP1E52tdTVXp2UuCbHj6+9IW7t4vqG8=
X-Received: by 2002:a05:6512:3052:b0:515:a8f0:221 with SMTP id
 b18-20020a056512305200b00515a8f00221mr4034266lfb.37.1711795692359; Sat, 30
 Mar 2024 03:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240327023451.2288523-1-j-humphreys@ti.com>
 <CADg8p94FjRoYkvdSHJ=2MycXceXDOQeES1S6VCNAuJ5ZBZqDow@mail.gmail.com>
 <86jzlnvw75.fsf@udb0321960.dhcp.ti.com>
 <CADg8p94omjw63-K1VkzLx2ohZQpj9t2gxNxhH0_f2zA9-GLtOw@mail.gmail.com>
 <86h6gpwi58.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86h6gpwi58.fsf@udb0321960.dhcp.ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 30 Mar 2024 16:18:01 +0530
Message-ID: <CADg8p97zotfZj_XmkDx1egFAaksZ=bjYMAvx2w6C67AARNyicw@mail.gmail.com>
Subject: Re: [RFC] Makefile.lib: find capsule ESL dtsi file when
 CONFIG_OF_UPSTREAM=y
To: Jon Humphreys <j-humphreys@ti.com>
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

On Fri, 29 Mar 2024 at 14:04, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
>
> > On Thu, 28 Mar 2024 at 09:34, Jon Humphreys <j-humphreys@ti.com> wrote:
> >>
> >> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
> >>
> >> > hi Jonathan,
> >> >
> >> > On Wed, 27 Mar 2024 at 08:05, Jonathan Humphreys <j-humphreys@ti.com> wrote:
> >> >>
> >> >> When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
> >> >> top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
> >> >> the dynamically created dtsi file containing the capsule ESL DT node is in the
> >> >> parent directory.  This results in a build failure because the #include inserted
> >> >> in the DTS file is local to the current directory.  Update Makefile to have the
> >> >> DT preprocessing of #includes search in the parent (dts top level) directory
> >> >> too.
> >> >>
> >> >> I'm not sure if this is the best solution.
> >> >>
> >> >> I was also tempted to just manually include the capsule-key property in the
> >> >> board dts, and avoid the Makefile implicit inclusion trickery.  I would actually
> >> >> prefer this approach as everything is more explicit.  But this isn't an option
> >> >> because if CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled, the implicit inclusion of
> >> >> the dtsi file happens.  It would be better, IMO, if we only included the
> >> >> generated dtsi file if CONFIG_EFI_CAPSULE_ESL_FILE is defined.  Was only
> >> >> supporting the implicit inclusiong approach an intentional design choice?
> >> >
> >> > I was not sure if users would want to manually insert the contents of
> >> > the ESL file, which is a binary file(a few hundred bytes at least)
> >> > into the DTS. If you prefer having such an option, we can change the
> >> > logic to what you propose. Thanks.
> >>
> >> What I was thinking is that one would explictly add the capsule-key
> >> property to the board dts but do it just as the generated dtsi does
> >> where it references the .esl file.
> >
> > Okay. In any case, that can be done by having the addition of the
> > capsule_esl_dtsi to the dtsi_include_list under the
> > CONFIG_EFI_CAPSULE_ESL_FILE  conditional, isn't it? That way, we have
> > both solutions. Users can then define the config flag to automate the
> > inclusion of the capsule-key. Those who prefer to explicitly include
> > the node to the board dts can do so on similar lines to how it is
> > defined in the lib/efi_loader/capsule_esl.dtsi.in file.
> >
>
> exactly!

Ah okay. Then I guess we are on the same page. But you might want to
figure out how you are going to provide the path to the ESL file.
IIRC, providing the path relative to the u-boot tree does not work
with out of tree builds. And I was told that the paths used in u-boot
need to be relative to the U-Boot top-of-tree.

-sughosh

>
> Jon
>
> > -sughosh
> >
> >>
> >>
> >> Jon
> >>
> >> >
> >> > -sughosh
> >> >
> >> >>
> >> >> Thanks
> >> >> Jon
> >> >>
> >> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >> ---
> >> >>  scripts/Makefile.lib | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> >> index 12857316c58..62f87517c09 100644
> >> >> --- a/scripts/Makefile.lib
> >> >> +++ b/scripts/Makefile.lib
> >> >> @@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >> >>         (cat $< > $(pre-tmp)); \
> >> >>         $(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
> >> >>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >> >> -       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >> >> +       $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >> >>         $(DTC) -O dtb -o $@ -b 0 \
> >> >>                 -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> >> >>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >> >> --
> >> >> 2.34.1
> >> >>
