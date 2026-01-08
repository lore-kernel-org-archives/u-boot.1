Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C21D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D9D841E3;
	Thu,  8 Jan 2026 18:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BDJMl2Yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0673984261; Thu,  8 Jan 2026 18:42:04 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBD683B4E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so4972502a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894120; x=1768498920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2V+JoY4dFUfLGzSjhE4onXGxPNY27ErHcHGt4GU3uk=;
 b=BDJMl2YyzPyxLjX0erIninJZrRnpnE51m7VRZoobf4tzhMv995GJN6D5T2DscsjKrA
 F0JBwa1OFI+ZwdGskbbm5I5lkc/4iUU0zjIpExUQLozyYqVRezGNqXYGyb3zl+NHmNnK
 //rot6UdBsOu8HkRsbCFu3Xy3GL/IsM3zKhrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894120; x=1768498920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2V+JoY4dFUfLGzSjhE4onXGxPNY27ErHcHGt4GU3uk=;
 b=MnDQH6bursmY1vl3fhVL+KyfP8KHanvnxpnWqsWthRu8NCPzT0zpSo2C8+DHBh3K7L
 88jLx1zRWHLV/4G0Qw8T0hmp0ZrFDfjVt62Sjyvs0zpA8HHxb44A1JUl9VoHJAuKjjVN
 AJxHVYq5eBxDFDnpUW/yVxqIMcPZyGYjfCxu6eAvroD3vJZQNijlsFCZWOSBZ6K/hQGv
 VdJ9lNRVNrL0EPhxyTwifXJwin5bOBInlxHkxlKyOLmfWiFFd0w4d0Zvy+skCPpM5P0p
 otX7tWwbajmpHkap28qrXnwu3XRmzilLVpCJe8tJBYqHriwfDBqDXpewP3qhJFJig5Se
 Qz7g==
X-Gm-Message-State: AOJu0YzxD7mw4auXlQ+yw1f9UiiTbLQVlMiJ6oiML1GJhaCS7GNk2UcG
 spVh+R2MXgZP2dpqhG4u04RZURZAYmVIACcn8ZeQ1LA14TNn7DOXNgycZJFKW+IdGcA6+Z8eQ3m
 TbKJ7EdX5NfilP7dE9owKYCh9dpUWcp/v+96wWWNE
X-Gm-Gg: AY/fxX7FWAQ7fC7Ccvjm+3gITUt0N/yp5fUAs1514L940Yf0A+zAb9NQuZhTnE5oyEW
 JgiVLPnHdfirDKbnfT37EbR22IXqrU5/axowed4KKvXKH1yQtE3JE7+c9qcNjb/HIUvLXdpaK2p
 XKws56y9SO8pztqn4a3o1G8NdDs9LNrs5Cr1uegVPg5Ojv14khJA3fMpYyHItUlvtqk1L5uT5NE
 uDBqK6COiZpLOVfnJEV67SC/SDcmjTNQc15x0IZxdiJ0KL5cmwyxZWR+x9DHd75NLNYIg==
X-Google-Smtp-Source: AGHT+IE0pV0gP+t/d6KXUuceowGhMTesC1twC87KL6Gz0bJnEWsXKWZpOnC1blkDpLOuCRpM17UIx7Adz8e47ulBppU=
X-Received: by 2002:a17:906:fd83:b0:b83:95ca:23e7 with SMTP id
 a640c23a62f3a-b8444c5a96emr627008166b.4.1767894120254; Thu, 08 Jan 2026
 09:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
 <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
 <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
 <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de>
In-Reply-To: <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:41:46 -0700
X-Gm-Features: AQt7F2rTsoR4ffQYwzfZqJi3dU8DGzxKGfOkMrAtPTZuzwyWcyzKUeUVL9Poe24
Message-ID: <CAFLszThUvfSqP3oMP6HPB4zyWch7WfGVtZag7EuhFMA2ZpNXdQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Heinrich,

On Wed, 7 Jan 2026 at 12:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 7. Januar 2026 20:02:39 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Tue, 6 Jan 2026 at 20:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Am 7. Januar 2026 01:31:22 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >> >From: Simon Glass <sjg@chromium.org>
> >> >
> >> >Mark kernel start before booting. If enabled, show a bootstage report.
> >> >
> >> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >> >Signed-off-by: Simon Glass <simon.glass@canonical.com>
> >> >---
> >> >
> >> > boot/bootm_final.c   | 6 ++++++
> >> > test/boot/bootflow.c | 2 +-
> >> > 2 files changed, 7 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> >> >index 71661334e11..dd7cac55f1e 100644
> >> >--- a/boot/bootm_final.c
> >> >+++ b/boot/bootm_final.c
> >> >@@ -6,11 +6,17 @@
> >> >  */
> >> >
> >> > #include <bootm.h>
> >> >+#include <bootstage.h>
> >> > #include <dm/root.h>
> >> >
> >> > void bootm_final(enum bootm_final_t flags)
> >> > {
> >> >       printf("\nStarting kernel ...\n\n");
> >>
> >> This noisy message makes no sense for EFI booting. The kernel in not started in ExitBootServices().
> >
> >Can you explain that a bit more? I believe that's exactly when the
> >kernel starts.
> >
> >>
> >> Operating systems like Ubuntu tend to boot the kernel with argument "quiet" for aesthetic reasons. We should not disrupt this.
> >
> >When I boot (with this patch) I see these messages on the serial console:
> >>>>
> >Scanning for bootflows in all bootdevs
> >Seq  Method       State   Uclass    Part  E  Name                      Filename
> >---  -----------  ------  --------  ----  -  ------------------------
> >----------------
> >Scanning global bootmeth 'efi_mgr':
> >  0  efi_mgr      ready   (none)       0     <NULL>
> >** Booting bootflow '<NULL>' with efi_mgr
> >      try_load_entry() Booting: Label: Ubuntu Device path:
> >/HD(1,GPT,eccaac1c-b634-441b-a788-ab0f959111af,0x800,0x165800)/\EFI\ubuntu\shimx64.efi
>
> Here GRUB is running. If you don't see output, then because purposefully it has been quieted.

OK, so there is no problem, right?

>
> >
> >Starting kernel ...
>
> ExitBootServices is called in the middle of the Linux kernel EFI stub and not when entering the kernel.

Oh I see. To my mind the kernel EFI stub is a bit like a bootloader
tacked onto the front of Linux. Linux doesn't properly start until it
has control of the machine and actually starts its init.

So we definitely want to get bootstage output (for example) covering
that period, otherwise there is a significant uncounted time between
the EFI app starting and Linux starting.

Regards,
Simon

>
> Best regards
>
> Heinrich
>
> ><<<
> >
> >So it is not silent today. The last line is the new one. Every other
> >boot method writes this line.
> >
> >However, the video display is silent once grub has finished and I just
> >noticed that this patch draws some pixels on the display, as if the
> >EFI display is set to a different mode from what U-Boot expects. I
> >suppose this is understandable, as grub has run by then and has
> >probably changed the mode.
> >
> >So I wonder what would be best here. We don't support dynamic video
> >sizing right now and I don't feel the urge to implement it just for
> >this. Perhaps with EFI we could disable the vidconsole when
> >exit-boot-services is called, on the basis that we cannot deal with
> >whatever has happened to the display in the interim?
> >
> >Regards,
> >Simon
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >> >
> >> >+      bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> >> >+
> >> >+      if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
> >> >+              bootstage_report();
> >> >+
> >> >       dm_remove_devices_active();
> >> > }
> >> >diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >> >index a56435d053f..80adc074070 100644
> >> >--- a/test/boot/bootflow.c
> >> >+++ b/test/boot/bootflow.c
> >> >@@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state *uts)
> >> >
> >> >       /* TODO: Why the \r ? */
> >> >       ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> >> >-      ut_assert_nextline("Exiting test app");
> >> >+      ut_assert_skip_to_line("Exiting test app");
> >> >       ut_assert_nextline("Boot failed (err=-14)");
> >> >
> >> >       ut_assert_console_end();
> >>
> >
> >Regards,
> >Simon
>
