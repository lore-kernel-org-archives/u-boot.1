Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB92F30298
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0001D83DB6;
	Mon, 16 Mar 2026 03:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TqT5+x7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DBF83DB6; Mon, 16 Mar 2026 03:44:02 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2903B83CEA
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so650770766b.1
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629039; cv=none;
 d=google.com; s=arc-20240605;
 b=fcS3pCfZmVrljEwkVDr+Jx1rer3TBdJ2sehJi/pHnLl9a8lJiLQ5tYXCgaYqoPXJ07
 N/eZsO7kN0TdwNAcqjtRu6W5yDKkiD3xiALJilj5HXNfUlEsuK946TN8lB9w+lee4v5I
 maycQI65TE/e0Pbo8Yb5APGK589TeOp2EHdC7VP+dxv3KYBYWvwOlaHr/3DM+vwH6yuI
 MsDeyvFjaLFTvCn1XaSdvr9Z/Rw0dJdxusUmSTMtb4UoMA1dZRuFixH5R8aO2uj0yaPW
 6zs1fLhpwAnKR4lucpISvCujaQ0nfvvW3ygCN6Q7qk9tlnnWdnpKYW7tRzIKBH0vWA2H
 SDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A07KLkzIP6JCA2/bFrUAYYLZHEk5eQXuK0V7shJoS6Q=;
 fh=7pdiee1jKzaRe36jy35XVla7olduQscCYLs8Omno5xc=;
 b=Sq2x3hziPUb5AA9qscjxOJI+ObY7k1oN+P2jUBJXQUgHXTanKBq///0hVBNksnZLhq
 5LpbpnFRe5ICRiZi9E257jTiyVP4zZ23Rdb4He0Ma6rF52PHxjZa21NzePUc6GM1HW02
 pyCPfc+q+D52NgOebjuro++S24+CnTzqeO4Q8t4rxIxOHhxVufL1OcHbywd1KMTvVwle
 hmiPjvuiv3PXMNyzrPJx8oMhwNIFBwVwrSNCJqlS2Gy5cc4KiYBjJoUc3N47aEGuTpSB
 c6m324ctCdrAEOnfjMtVpXk9Z/zSOqX4zFnBXP6TwCUOSlAANx4P6AB1pZ8toL/wysFC
 v5bQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773629039; x=1774233839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A07KLkzIP6JCA2/bFrUAYYLZHEk5eQXuK0V7shJoS6Q=;
 b=TqT5+x7r23HL44T6BunwEYjKbrxdz2RhBcvA0WxU+5IhcoTWvQrT4uHd8T+CROI9V3
 ujw1HxqWLypeiSuxeU5m0IMX3ygLL6PdhYd3PC6DPWhPlPGscTavr9vKwqsDkQri+eTw
 5Nf29huHz5xBUMXWEONIDlx7j/DWNJUuY/lUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629039; x=1774233839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A07KLkzIP6JCA2/bFrUAYYLZHEk5eQXuK0V7shJoS6Q=;
 b=NP23KUS7/7EoRwwhs2GYt9+kHzx6BsjipjBTkcpULFnKLry2c+Wj8uKnm5PaLkmZsp
 nqXQWbxk1yHg1NruFUn0OWT1PLx/IqNUG2HiUzt1/jDaWcGEt5WqsHoWhkvmf82gl11F
 A7CmojF6eXHt0ipHzxQC5FeH4OZ11M4c+vXmPvtr3vTftpmdoWEsJpHqHX3Ny1mB08iv
 zfsTSOSuu2i1TycDuwzhaS1Zg5xklFSsZP0zF9NlkFRku4/X63+K5cZxxdgyLcu451hQ
 aXxr08mo6pnLHaBbw7uS9LGVS7eDHGn3omwedsz6cM3SeXgeeD4YbOCb2IfV202FiDFO
 3yYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8WlP0jtZE8Cj2tUkL9WIMWrHN/oyxZU5hJTm3ubk1y8rhgJU5eg2ByTGUI6Pr1koOXy94ez4=@lists.denx.de
X-Gm-Message-State: AOJu0YzT4xZemiWwm2zVGGUXnzb38cj/zdVZ9v4jNbP3NcdW2kvDhfXC
 Psx2cWgo3EgGAaGkW61rVOsY6BA7McuuSu6daDy1qirC8AdBSjd0ReDy7EGFV0o0yUNPPLHfu9Y
 bKqsPlrAy7RSiiOjy5Z/OmCy8bNLgapKPo94VZz/R
X-Gm-Gg: ATEYQzzWc2T4+59TlJNXLhJVIWyCmLF2CMILEGmjtTsbjlk9stv0PZ7eQf0zYcBftXm
 /BIP52EBVrA0m9qDhM8mKmiMi9GQeesvEaW0C+DYXEQP3bYMnEN/id7OpYe9V0+Y0gLoZL8bwov
 IPEqgZGEcSI3ObaYqax7R07a5ivtRvCFJAjXMB6UHeJMLidNW54afPJyNZpQdn+SUALhzV8T7ay
 SczefvEtEOc0MKFFu1JcxeNsdnHNVv5j+cfk/Qjq8tt8bMLWWWqDTt1TzCqqlfQeUYX2VgPaGcb
 wRYhbxz2hkUxtCzc
X-Received: by 2002:a17:907:96a6:b0:b97:a35e:37bf with SMTP id
 a640c23a62f3a-b97a35e440dmr233829066b.35.1773629039551; Sun, 15 Mar 2026
 19:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
 <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
In-Reply-To: <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:43:45 -0600
X-Gm-Features: AaiRm50Ggz-WQvxZucu9BnXWwBjNe9zQFVPCaQj3mbKbSeANUSnHcHZPwSq-os0
Message-ID: <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Michal Simek <michal.simek@amd.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, git@amd.com, Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi,

On Fri, 13 Mar 2026 at 09:50, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/13/26 16:47, Peter Robinson wrote:
> > On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Michal
> >>
> >> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
> >>>
> >>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
> >>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
> >>> during unit tests. Extend this mechanism to be runtime-configurable via
> >>> the 'no_ansi' U-Boot environment variable.
> >>>
> >>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
> >>> at the start of efi_setup_console_size(). This prevents
> >>> query_console_serial() from sending ANSI escape sequences to the
> >>> terminal, using default 25x80 dimensions instead. This is useful for
> >>> platforms where the serial console cannot handle ANSI queries.
> >>
> >> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
> >> It really means don't use ANSI queries to detect the console.  So
> >> before creating an ABI to the cmd line should we really call it
> >> "no_ansi" or perhaps "no_detect" and in the future clean up the
> >> variable names as well?
> >
> > I wonder whether this should be a Kconfig option too, a maker of a
> > device likely knows when this is an issue on their device and
> > explicitly enabling it via a config as opposed to an environment
> > variable would likely be useful when there's a menu enabled and the
> > shell possibly disabled?
>
> There are a lot of Kconfig options and variable which can aligned it.
> It means we can create Kconfig option for it but likely we should also have
> variable way as common way in uboot.
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It might also be worth reconsidering this old patch:

https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-11-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-11-sjg@chromium.org/

Regards,
Simon
