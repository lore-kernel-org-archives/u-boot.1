Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EFDCD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0B8849C9;
	Wed,  6 May 2026 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ltXEUsuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B53848BC; Wed,  6 May 2026 14:21:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A044383AC5
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC8B1A9A;
 Wed,  6 May 2026 05:21:00 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.35.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D3C3F836;
 Wed,  6 May 2026 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778070065; bh=Vtw6TqHfScDqHG2qPjIZiWktQrYopZ5lqC9vBiAthsI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=ltXEUsuPLRY6568X2h74B5/nkSe4yJyz1eu4994px1TQ7bv1TCjTxGTrLV6Ctx2Jk
 aMZaBsdCuFciIjX0IICEfiXRZ8Q7zt0UiaHwD7EaYTCTaGGoa6GQmIUhWcOoxCesjG
 /6ofin17Ifz6wmmJVchqRH7pL3uymLvPMDYfhO14=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/12] corstone1000: enable bootefi selftest
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszThtGo1n_fpMF4S8EYvUGPpaUu4mDwbjt8P5RF++pBo4UQ@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-7-harsimransingh.tungal@arm.com>
 <CAFLszThtGo1n_fpMF4S8EYvUGPpaUu4mDwbjt8P5RF++pBo4UQ@mail.gmail.com>
Date: Wed, 06 May 2026 13:20:58 +0100
Message-Id: <177807005852.1171074.13649548036204819845.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

On 2026-04-28 12:01 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > corstone1000: enable bootefi selftest
> >
> > Enable UEFI selftest command in Corstone-1000 defconfig
> >
> > Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> > so the board can run the built-in UEFI self-test suite during
> > development and validation.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > configs/corstone1000_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> > @@ -63,6 +65,7 @@ CONFIG_SYSRESET=y
> >  CONFIG_SYSRESET_PSCI=y
> >  CONFIG_TEE=y
> >  CONFIG_OPTEE=y
> > +# CONFIG_CMD_POWEROFF is not set
> >  CONFIG_USB=y
> 
> Why is this disabled? It's not mentioned in the commit message and
> looks unrelated to enabling the bootefi selftest. If it's a stray
> byproduct of 'make savedefconfig' please drop it; if intentional it
> should be a separate patch with its own justification.
>

Thanks, these two lines are intentional rather than stray
`savedefconfig` fallout.

On Corstone-1000, enabling `CMD_BOOTEFI_SELFTEST` causes
`CMD_BOOTEFI_HELLO` to default to `y`, and `CMD_POWEROFF` is also
pulled in on this PSCI-based defconfig. I wanted to enable only the
selftest command here, without broadening the rest of the board command
set, so both are kept explicitly disabled.

I can make that explicit in the commit message in v2.
Does this sound reasonable to you?

> > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> > @@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
> >  # CONFIG_CMD_CONSOLE is not set
> >  CONFIG_CMD_FWU_METADATA=y
> >  CONFIG_CMD_BOOTZ=y
> > +# CONFIG_CMD_BOOTEFI_HELLO is not set
> > +CONFIG_CMD_BOOTEFI_SELFTEST=y
> 
> The commit message says only that selftest is being enabled, but
> you're also explicitly disabling CMD_BOOTEFI_HELLO (which would
> otherwise default to y once SELFTEST is set). Please mention this, and
> ideally state the real motivation - that this is needed so patch 7 of
> the series can run the runtime variable selftest on this board, right?
>

Thanks, agreed.

The explicit `CMD_BOOTEFI_HELLO=n` is intentional. On this board,
enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
`CMD_BOOTEFI_HELLO` default to `y`. The goal here is to enable the
selftest command so the later runtime-variable selftest patch in this
series can be exercised on Corstone-1000, without broadening the rest
of the board command set at the same time.

I'll make that motivation explicit in the commit message in v2.

Regards
Harsimran Singh Tungal

> > Enable UEFI selftest command in Corstone-1000 defconfig
> 
> >
> > Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> > so the board can run the built-in UEFI self-test suite during
> > development and validation.
> 
> The first paragraph just restates the subject. Please drop it and keep
> the second paragraph, which actually explains the change. Referencing
> the runtime-variable selftest added later in the series would also
> help, since that is the real reason for enabling it now.
> 
> Regards,
> Simon
> 


