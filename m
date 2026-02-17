Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB30EF5877
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7A88063E;
	Tue, 17 Feb 2026 14:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1TCbxu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A56B83CB1; Tue, 17 Feb 2026 14:32:04 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016DF80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so3500990a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335121; cv=none;
 d=google.com; s=arc-20240605;
 b=eSQyNy8DB2396sgsRQqTuUVK6NpSn5N50nafGJ2BzQPYXdrt5bICx8/SRykuTAqSOh
 3oMCH0Z1fJEGNtDvS1kXDKGfsxvPtMQ2z9gsm4+4oPJ5EHPwBOYmQBHMqwwtu9We+Ddo
 uhi/WfVNHG+DnovDPnBI6zzVm25L7yn+6YqeKBtnaNSGPmqFDBbNv1WzOcixSCR7LMql
 +CIzb3anPifXcEZlvCJOwkyzAq5AZ0n1QH+useGFwKl7FJFanqrAgVwDD2yIFUDMC94g
 emHDXLdHKvLuss8jTvgHm0JTjS/fGDeY3g5sudQTGulQNvvMltdjX+G5YYP4mBidjtfe
 tC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5QKb3Gp8qFp0P4e9zsCeTbx6R2lrlb/lvlgBf1GMFi8=;
 fh=Pz+/xznRHz1AookOF9o3WL2sPFhAzrhuxtPBg/30eMw=;
 b=JdHV15xuIj8QKhMUp3+4YIjZqJ/iACV1qu9gGPRTgNBG4/wX6wtZ5CS1mDfvm70nYG
 Me8bUC+/sklugDbUZqEctugpAZQwUlGzpeDdOBRLlzzgsehouUNJjd0+IPpm/5FHDpVz
 PdF0QjBfOm9ABvW/uW55pylkFljeLpeCZ8ni36+umFHU4ARTGiPGVaDywML/j/8YFkY3
 qL6PE4Zk++1c2ctbI0gLbVsFOpi/Ckbs4RrIFtb97pZQ5Ucy7fIT7XsF0B9+sZU+PkaH
 HUzIBDaEZ59XbBV7GeXC6QAJbMbRhovntOc/vR3wjSXoVnc7R3dKggZFRxtWDjN5NBlG
 oyEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771335121; x=1771939921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5QKb3Gp8qFp0P4e9zsCeTbx6R2lrlb/lvlgBf1GMFi8=;
 b=F1TCbxu3Cn+47IBgPu61eipcZrJOIK+nykdrsf03RYAaZHapgiRd1qZWjq00Ej6rE5
 lf++pHM2ml8Ogih6gklQNFliY7dWGP7NO/jhjtRXh7jWnKSHNeuCP5uE7PhzaxavZToT
 UCLILfmSaM9vA4Gcf72J8PkFLGKgCdyqbBNvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771335121; x=1771939921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QKb3Gp8qFp0P4e9zsCeTbx6R2lrlb/lvlgBf1GMFi8=;
 b=S/uBZbkB3nQUfJDzGL+VPjnbj0QpWDlkHZ0e29htzshZh1RwDd1HoxJkcmUISkVeRX
 jTrixYspB5hj/mnl6APzDtfWD5oML+KRcKdqen8UmFulAQcTASrcWyeTV5yH7Lw6YRco
 JXeVLCnSrIi0od9QVqmxiVZSa8oZEc130A58ea1YhGLRyvbNp9nM/i7N8X7TOEUVDdZr
 WkYWmFWG4Pz517F7KjlUe0hQ0QDFBFdahlKpEYVeDEjLtHPQeovG5gV5/QtW2wvrrIbx
 qk+afBOBNsp0tFKT9c966IMUw4QtiH1nyB2iJwQuHSQj4w/dqzeSv07pr/BvfONC1Xv1
 ufww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT2WDoyJYLKkqd8vMo2cvlSRTcXNESO4tPiX6qYmKi/gMM90q8LhpVJBDIMj4dgD7vWEGhkzE=@lists.denx.de
X-Gm-Message-State: AOJu0YwPeLSSxWuqK8FYqSnot7crbcClabInBJixOL9nMwhkbh3N+tXp
 L0kWHEnP97pbC0ivmkf+ibiOltiTy46AJR1uUTEHKbXrXE5dVON0avAgy6pvoB/+D3tpWqZ7ZJi
 qvS+ZacJbo9EXB8AioUi/ZyQkHAZwQzyvDDLWfONB
X-Gm-Gg: AZuq6aJf2/XRiXaNXzqX1AQS+KyQBYhUs0ZDWOWovfBlui3iu9BSLx/uBrDGD1HOacQ
 olmVRlA5JqJU8F0Ce24Ai/W5XtsLzCvzx7PER44fqTwvL3W67KZk5GIlySya7ro/jG7ACUqHB/v
 TuJy32UngZumh/ZBa3pIHEWSHUkjVNtKvgrB6uZ/BLPirvXnxOUVqciiOUgmT9ZHc4atLMrc546
 QLqk5f+i+l44K8iSXQbDZe1naAu4yXfqX2Lr7CvA/NLcgJVEEda1cllsc7Qxfqzqiaqohye80p3
 yQih9A==
X-Received: by 2002:a05:6402:46d8:b0:65c:3361:5339 with SMTP id
 4fb4d7f45d1cf-65c3361657amr2414512a12.18.1771335121258; Tue, 17 Feb 2026
 05:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
 <CAFLszTjB5OsdDRbSg7nduFtxzUT0jesvA7+dtU+op=YwfV+jqg@mail.gmail.com>
 <aZPtg7dllBavk/a9@hu-varada-blr.qualcomm.com>
In-Reply-To: <aZPtg7dllBavk/a9@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Feb 2026 06:31:48 -0700
X-Gm-Features: AaiRm53hSCAraEKXDaRff3w9qu73jF18rqN5xfrpqsET-ArhuZ4vbFrFT8Apt-c
Message-ID: <CAFLszTgAz37O7ANBCyT+aaeFfA=z_x360-WgO=G6dFeBDO0n1w@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, me@samcday.com, aswin.murugan@oss.qualcomm.com, 
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi Varadarajan,

On Mon, 16 Feb 2026 at 21:24, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> On Mon, Feb 16, 2026 at 10:19:48AM -0700, Simon Glass wrote:
> > Hi Varadarajan,
> >
> > On Sun, 15 Feb 2026 at 22:31, Varadarajan Narayanan
> > <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > >
> > > On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> > > [ . . . ]
> > >
> > > > > > > > I haven't been following this, but what sort of args are you planning to pass?
> > > > > > >
> > > > > > > As of now, an argument to indicate reboot to emergency download mode.
> > > > > >
> > > > > > So how about adding a struct in sysreset.h where you can include a
> > > > > > flag word and create a single flag for your case? We should be able to
> > > > > > handle reset without the cmdline being enabled.
> > > > > >
> > > > > > There are other cases where this would be useful, e.g. an EFI app
> > > > > > rebooting into setup boot.
> > > > >
> > > > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > > > option. This was added to avoid bloat code size for platforms that will
> > > > > not need this. Please see [2]
> > > >
> > > > Sure, but you are adding a new method, so you could make it take a new
> > > > struct instead of the string list, still behind your Kconfig option.
> > >
> > > Sure.
> > >
> > > You want 'request_arg' function pointer to take a structure instead of
> > > 'char * const argv[]'. Is this understanding correct?
> > >
> > > If yes, this string list is what was given in the command line. And is
> > > passed to the implementation specific handler.
> > >
> > >         Command line -> do_reset -> sysreset_walk_arg -> *request_arg
> > >
> > > The implementation specific handler can interpret the argv[] as
> > > applicable to itself. Not sure how to convert/parse this to a struct
> > > that can be used by EFI app. Am I missing something. Please advice.
> >
> > Really I'm just trying to have it defined (in the uclass header) what
> > the behaviour actually is. An arbitrary string list seems too
> > open-ended, as well as being less efficient.
> >
> > So I am thinking you can add a struct, define and document the fields
> > in it and then other people can use the same approach when they hit
> > this problem. For example, with the existing request() method, we
> > created an 'enum sysreset_t' to specify the reset type, rather than
> > using a string arglist.
>
> As I understand, sysreset_t has a bunch of reset modes that is
> applicable to majority of the SoCs. However, this string approach is
> to accomodate situations where we don't know what the possibilities are.

Can you explain the situation you have here? What specific type of
reset are you wanting to do?

>
> > String arglist is good for the cmdline but not for programmative code.
>
> I'm not very familiar with EFI and EFI apps. Can't an EFI app use the
> efi_reset_system_boottime() API with reset type as
> EFI_RESET_PLATFORM_SPECIFIC? Presently, efi_reset_system_boottime()
> invokes do_reset() with argc and argv as 0 and NULL respectively.
>
> Instead, 'void *reset_data' can be cast to a struct that has int argc
> and char *argv[] in efi_reset_system_boottime() and pass those values to
> do_reset instead of 0 and NULL. Wouldn't this be usable for
> programmative code?

Yes EFI can do that. But here we are talking about a driver model API
for sysreset. What operation(s) do you want your driver to do, for
your soc, in addition to what operations are already there?

Regards,
Simon
