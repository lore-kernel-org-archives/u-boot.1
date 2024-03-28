Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E00C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 14:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A32C8816E;
	Thu, 28 Mar 2024 15:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fYULiN2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979D288150; Thu, 28 Mar 2024 15:53:30 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FAA987ABC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 15:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-515a97846b5so1048831e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637608; x=1712242408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sb7PgpwanrbXFcMOPnRh6QqkWEyuWfJTJGC8dHyzYjw=;
 b=fYULiN2XepDUXZ02sPCfdhmPU6rG/JHP8+xbT0FGJpJp8/Ujui9aROHz0h0ZWPlxcV
 BcYTj9+ooU88e6zjx3kDOS5doUHUurQ7ZAEF50BgfDD+wD7XMN6gTWyhPc1c9m4+wtD0
 9m0sCz4VsWIUu17hWC3ZIg5FKF240057qMLcEoG7iZ0il6m+urJ/pc4I/TDkW2B1z2ng
 Wmtjlge5cnlu/O9gWTF8EDqpszFn0BaN6lT5WBwpOuLbnvnkjatE+cyItQJOx3jfuJuh
 K84SUKYb+X/dotY8iR0oL3MvnWHHbuDTMROW+DyyMdy7Xk8EdIeDKwo/qA1zMJKSrsvR
 BFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637608; x=1712242408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sb7PgpwanrbXFcMOPnRh6QqkWEyuWfJTJGC8dHyzYjw=;
 b=PWDOkFyhEWJV+FgjH/zzz6tVALsHC/KWp6T1nVLgCL3BSweIEYHB2o+B326Sicxa18
 0zJkXt+Y5c7O+Z6heEGKrySK/Yoh+CkeLPcGkRhRoSkD9HRKjPpcIv27N+P2RtdvWeR/
 1W4Oyl3eUhfyXe3UM93M0W4llJsTwW6LdAVlPCETBh3fDrt3DT8tayH6FquWS2VESUY1
 09Cj/mMkUnAjr0Ml8/xW2y5ktjJd6CnAajPpdYhIjYOOxHppffYcxC7YdnYB5DFOmpTk
 RY2FesEqXqXxpQdUvtR1reuSPqj2VnE9fqRMPsfJzU9yyD/966w4lyZa1IA8dbgfjiIw
 FxMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBcsPhcm+rlsN6pczAx8uEEDmJVsMEN1OgvmRl0zQwAcyjkXKwk+o5MGgiaQSxiY12m6TPViwkJ2qMVNQa3y9R1wT2oA==
X-Gm-Message-State: AOJu0YwGK5bCrenzEQvSGGNJk/1WeqU1xapbSbqiZoMim0Qq2+0kxrJ6
 Dqe8ubhc7SCkqIFBbi5fMl/sgf4iK9uDf2Ly5pjZsElhGesc4vKc6rbAmEMvW6bBZSvkzdc9S4I
 A9OacvkfSgzXWnpbupE60rdpuYlXAjPWtiSOYaw==
X-Google-Smtp-Source: AGHT+IGj/n6QB3o262gS1nSOaBPDcLSbgJHp85dAcQ8CItbuoCrFegvl9GQyBQDtAGLM1pHI1dgL63FbYLrKvojHOZQ=
X-Received: by 2002:ac2:5e67:0:b0:513:d4a7:bdb9 with SMTP id
 a7-20020ac25e67000000b00513d4a7bdb9mr1821310lfr.30.1711637607713; Thu, 28 Mar
 2024 07:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240327023451.2288523-1-j-humphreys@ti.com>
 <CADg8p94FjRoYkvdSHJ=2MycXceXDOQeES1S6VCNAuJ5ZBZqDow@mail.gmail.com>
 <86jzlnvw75.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86jzlnvw75.fsf@udb0321960.dhcp.ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 28 Mar 2024 20:23:16 +0530
Message-ID: <CADg8p94omjw63-K1VkzLx2ohZQpj9t2gxNxhH0_f2zA9-GLtOw@mail.gmail.com>
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

On Thu, 28 Mar 2024 at 09:34, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
>
> > hi Jonathan,
> >
> > On Wed, 27 Mar 2024 at 08:05, Jonathan Humphreys <j-humphreys@ti.com> wrote:
> >>
> >> When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
> >> top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
> >> the dynamically created dtsi file containing the capsule ESL DT node is in the
> >> parent directory.  This results in a build failure because the #include inserted
> >> in the DTS file is local to the current directory.  Update Makefile to have the
> >> DT preprocessing of #includes search in the parent (dts top level) directory
> >> too.
> >>
> >> I'm not sure if this is the best solution.
> >>
> >> I was also tempted to just manually include the capsule-key property in the
> >> board dts, and avoid the Makefile implicit inclusion trickery.  I would actually
> >> prefer this approach as everything is more explicit.  But this isn't an option
> >> because if CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled, the implicit inclusion of
> >> the dtsi file happens.  It would be better, IMO, if we only included the
> >> generated dtsi file if CONFIG_EFI_CAPSULE_ESL_FILE is defined.  Was only
> >> supporting the implicit inclusiong approach an intentional design choice?
> >
> > I was not sure if users would want to manually insert the contents of
> > the ESL file, which is a binary file(a few hundred bytes at least)
> > into the DTS. If you prefer having such an option, we can change the
> > logic to what you propose. Thanks.
>
> What I was thinking is that one would explictly add the capsule-key
> property to the board dts but do it just as the generated dtsi does
> where it references the .esl file.

Okay. In any case, that can be done by having the addition of the
capsule_esl_dtsi to the dtsi_include_list under the
CONFIG_EFI_CAPSULE_ESL_FILE  conditional, isn't it? That way, we have
both solutions. Users can then define the config flag to automate the
inclusion of the capsule-key. Those who prefer to explicitly include
the node to the board dts can do so on similar lines to how it is
defined in the lib/efi_loader/capsule_esl.dtsi.in file.

-sughosh

>
>
> Jon
>
> >
> > -sughosh
> >
> >>
> >> Thanks
> >> Jon
> >>
> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> ---
> >>  scripts/Makefile.lib | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> index 12857316c58..62f87517c09 100644
> >> --- a/scripts/Makefile.lib
> >> +++ b/scripts/Makefile.lib
> >> @@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >>         (cat $< > $(pre-tmp)); \
> >>         $(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
> >>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> >> -       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >> +       $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> >>         $(DTC) -O dtb -o $@ -b 0 \
> >>                 -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> >>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
> >> --
> >> 2.34.1
> >>
