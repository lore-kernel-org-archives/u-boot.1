Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F3CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 15:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BB9846B4;
	Thu, 14 May 2026 17:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="IELcu8pT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6093F8468A; Thu, 14 May 2026 17:08:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2339384683
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3565D1477;
 Thu, 14 May 2026 08:07:56 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A473F836;
 Thu, 14 May 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778771281; bh=On5pzxUI03xNVbhW58OFodzQE0QdKHwrY1r/J/+zX1U=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=IELcu8pTiuKvQx+FQrQrqBldPOUgox8TENv/EevI0cgD5HvZarTXGQVlp4o/POhWU
 d9ODbpDttUSnIGX+fGcH9wZFaT0lDOjkdcROu12zWxFzcqzsCvucUkCHc8Q1rhwxv8
 R7V6So9/6V7g/XBoLkqiGvASLfXXSuG+V6zrA1CE=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 11/12] doc: bootefi: note two-phase runtime variables
 selftest
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszThZM7CRO3shhMOMYTipehB7HS4GjfK0SadZCSzhdbLz5g@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-12-harsimransingh.tungal@arm.com>
 <CAFLszThZM7CRO3shhMOMYTipehB7HS4GjfK0SadZCSzhdbLz5g@mail.gmail.com>
Date: Thu, 14 May 2026 16:07:53 +0100
Message-Id: <177877127336.2318147.9763458222006836722.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 14 May 2026 17:20:09 +0200
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

On 2026-04-28 12:14 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > doc: bootefi: note two-phase runtime variables selftest
> >
> > Explain how the runtime variable selftest runs in two phases
> >
> > Document that the "variables at runtime" selftest runs in two
> > phases when CONFIG_EFI_RT_VOLATILE_STORE is not enabled, and
> > show how to select it with efi_selftest.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > doc/usage/cmd/bootefi.rst | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> > diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> > @@ -167,6 +177,8 @@ To use the *bootefi* command you must specify CONFIG_CMD_BOOTEFI=y.
> >  The *bootefi bootmgr* sub-command requries CMD_BOOTEFI_BOOTMGR=y.
> >  The *bootefi hello* sub-command requries CMD_BOOTEFI_HELLO=y.
> >  The *bootefi selftest* sub-command depends on CMD_BOOTEFI_SELFTEST=y.
> > +The *variables at runtime* selftest runs in two phases when
> > +CONFIG\_EFI\_RT\_VOLATILE\_STORE is not enabled.
> 
> Please drop this addition. It duplicates what you wrote a few lines
> above and the Configuration section is for build-time CONFIG_ options,
> not runtime test behaviour. Also the backslash-escaped underscores are
> not needed in rST and produce inconsistent rendering compared to the
> plain CONFIG_EFI_RT_VOLATILE_STORE used in the paragraph above.
> 

Thanks.
In v2, I dropped that extra Configuration-section note
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

> > diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> > @@ -160,6 +160,16 @@ environment variable to match one of the listed identifiers
> >  Some of the tests execute the ExitBootServices() UEFI boot service and will not
> >  return to the command line but require a board reset.
> >
> > +The test *variables at runtime* runs in two phases when
> > +CONFIG_EFI_RT_VOLATILE_STORE is not enabled. Run it once to create a
> > +runtime-accessible variable in non-volatile storage, reboot, then run it
> > +again to validate, append, and delete that variable.
> 
> It would help to also say what happens when
> CONFIG_EFI_RT_VOLATILE_STORE is enabled (single phase, no reboot
> needed) so readers know which path applies to their build. A one-line
> note is enough.
>

Thanks.

In v2, I added a short note for CONFIG_EFI_RT_VOLATILE_STORE=y saying that the variables
at runtime selftest completes in a single run and does not require a reboot, so the doc
now covers both paths.

> >     Explain how the runtime variable selftest runs in two phases
> >
> >     Document that the "variables at runtime" selftest runs in two
> >     phases when CONFIG_EFI_RT_VOLATILE_STORE is not enabled, and
> >     show how to select it with efi_selftest.
> 
> The first paragraph just restates the subject - please drop it and
> lead with the motivation, then describe what the patch adds. Lines are
> also wrapping well short of 72 columns.
> 
> Regards,
> Simon
> 

Rewording is done in v2.

Regards
Harsimran Singh Tungal

