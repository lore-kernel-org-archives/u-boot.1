Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1A8C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 13:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F3882952;
	Mon, 12 May 2025 15:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O3yRTQl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395B8294C; Mon, 12 May 2025 15:08:28 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 413C482162
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fd0d383b32so2836014a12.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747055306; x=1747660106; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHnFlq4nc5uAOOBm7bSLhd9tKDsDBFG0HBPyl233vks=;
 b=O3yRTQl0BVhc5SHSTh4HphKWKB+WSSfbaD3nBtGgGZtMSlendGC5BTuxW7jkjAbSt6
 iIFMw8Zc+dT0R5imqcfdZAMcPMRDdNT4E4QNmApZ5xktpPa2n85QwWbbZGsC05k7ThEg
 ZK0qb2Yv4MAsboLnKe6AStXZm+FBO1jqy19Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055306; x=1747660106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHnFlq4nc5uAOOBm7bSLhd9tKDsDBFG0HBPyl233vks=;
 b=SjNaor149hoMD0VyhbIRk9UgTTHXAGDHsu4tGIRAU2gomyXvgaOutrAlY+JfrfX2qS
 gzR7XKHLG6+snrHTOB29yaEt8hHQ36KDMcBfxDg+rNR3xABoATjIO0Mc/7PcHvC3Vs39
 mnyENYvATB4tL001JJFdd1DFEDTlmSziFxCttOTxX7SO+v5urQ40KZUXOfaGL2eKZbOD
 UqKUTd9nJUNGFTMrxJsaumIhZi0u8+aay1peIH07hosIfT/+9XWMYn4CkAJVmUPFbMk8
 sQKI7y7ZXm8P38rUEnACk8I5sa7yIOybWPUXpTIq2CPZP4M9ib0wwG1F8FC28B2aJnbt
 DQIQ==
X-Gm-Message-State: AOJu0YwL0qD26+CPfb6Zbi6IK2HqCv7my+Bx2x1cEZCl+tvQME0ssVNn
 LXvBydlMcaZuJ3aqaNlfPlr5PrvuMqIGXO5GR1aEfNGOW1JyEqszwijtrDzbCaTmDrtjTG/HvKi
 mVsRzvGmNUg8LHdQGqL/jFRp1g96VZ4yWQaKyBQK6hDuw0u7vD0SJcD7tszlA
X-Gm-Gg: ASbGncv50Uflrf7JtnW2PVIQ4zcPl+l7xIKUsRbpciebHx9Va7HflNGMl4EtYbMlKi2
 PPLI9RG3XawciNzjGJe+CRYO+zIuhVkKdfkKeN9gX3odmQAhNCCeQZEzjnQtKkYbKIRBPaMSmjf
 ZtvIDixKQerk7o0Mqlq867bWV5/JXPzoviMDMg5FJBEicK
X-Google-Smtp-Source: AGHT+IGIZBgoegmLE6Vo2pOrP6lIXswnUiuggC94dIVYHMA5W4ctE9EwuFjuHrXZA+mli4XgvxKuk0T4hTFTqbEktOk=
X-Received: by 2002:a05:6402:13d4:b0:5f3:7f49:a4b6 with SMTP id
 4fb4d7f45d1cf-5fca080a80amr9514968a12.23.1747055305506; Mon, 12 May 2025
 06:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHYLw-ReP8avjX8gKdpJJxus1u7FC0KVtzBRy594M1x6XfxPUQ@mail.gmail.com>
In-Reply-To: <CAHYLw-ReP8avjX8gKdpJJxus1u7FC0KVtzBRy594M1x6XfxPUQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 May 2025 15:08:12 +0200
X-Gm-Features: AX0GCFudr2GS1htxa3hyqlicvphe1wgFDunm1dRkyEf-bd_r059LrHM7ZTvGVHQ
Message-ID: <CAFLszTghZ+wXCHWMKodc7Nhp4RLkx954RfjxqR+xJBWuXF7xog@mail.gmail.com>
Subject: Re: u-boot on x86
To: Michael <mep.sw.dev@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On Thu, 8 May 2025 at 14:51, Michael <mep.sw.dev@gmail.com> wrote:
>
> Hello!,
>
> i'm currently working on a project that could use several architectures
> (arm / x86).
> To have a common base for all systems, i want to use u-boot as unified
> bootloader for both platforms.
> At the moment i try to get u-boot working on x86. These systems are more
> general pcs than classic embedded systems and can have intel atom / i3...
> etc. processors (for example advantech mio series) - All of them have a
> uefi bios.
> To build the whole system i am using yocto. I have made some minor change=
s
> to u-boot (v2025.01 / build as efi app / binary) to fit my use case (find
> env partition via gpt part uuid / A/B update mechanism etc.)
> The kernel and initramfs are packed as fit image (
> https://docs.u-boot.org/en/latest/usage/fit/x86-fit-boot.html). I can boo=
t
> the system and the a/b update mechanism is also working.
>
> The fit image contains kernel / setup / initramfs - (
> https://docs.u-boot.org/en/latest/usage/fit/kernel.html)
> The current boot procedure is: "boot uboot.efi" =E2=86=92 "load fit image=
 over the
> efi interface" =E2=86=92 "bootm"
>
> My current problem is, that i can only use one cpu core. I think there is=
 a
> problem with the acpi tables ("smpboot: Boot CPU (id 0) not listed by BIO=
S"
> / "smpboot: Allowing 1 CPUs, 0 hotplug CPUs" / "smpboot: SMP disabled")
> I already got some hints on the irc chat (thanks for that!), but i could
> not fix the issue yet. I also tried an "EFI handover" patch for uboot, bu=
t
> with this, i cannot boot the kernel anymore (exception).

Can you use the 'acpi' command to examine the tables and see what is
there? These tables are not created by U-Boot in this case. Also, I'm
assuming that U-Boot does not have CONFIG_SMP set, so it should be
ignoring the other CPUs.

I did think of one issue, though. The ACPI tables are expected to be
at f0000, but when booting as an EFI app, that is not the case. There
is code at the bottom of write_tables() to add a pointer from f0000 to
where the tables actually are. So you may need to put that code
somewhere so it is done in the zboot case.

You could also try dumping the ACPI tables within Linux for the two
different scenarios (booting via U-Boot and not). That might provide a
clue as to the difference.

>
> At a later point i want to lock down the device with enabling the "secure
> boot" bios function. I have not worked with secure boot yet. I think i ca=
n
> only get it working with the fit images (fit signature verification)?

Yes you can use FIT, which is good if you are trying to be like ARM.
You may have seen this talk[1]

>
> Is this thre right implementation approch?
> I am grateful for any advice!

Yes it seems right to me. I'm hoping to get this into CI early next
month so it is properly tested.

Regards,
SImon

[1] https://www.youtube.com/watch?v=3Dhte60f7I9j4
