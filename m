Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BBD0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF8983869;
	Wed,  7 Jan 2026 20:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="I9Tc55uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E8D839A5; Wed,  7 Jan 2026 20:48:28 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CBA802C1
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d834f227-ec01-11f0-af3f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d834f227-ec01-11f0-af3f-005056994fde;
 Wed, 07 Jan 2026 20:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=BAiaDgaaptAya4LwI1YEEN4SHwF4dyAjrvCwD3bswOU=;
 b=I9Tc55uvP76MuZLUCVoWXymTUREutQz00qCRnkszsd69UvUH6QJDWxhL0GZVZ/7QL5sX43RjCh55n
 3ke9fxZ9U5sS52qIHRNLHd1XollPHMsZbMTQVJLixXGbz04DBmrb8B9Awgx9jXS5q567n3gAWcAdM/
 k6N+2ey4IAewloWCqooDAVVZYSDSjk81GbEEy5qnlliUq7uynDv6876BDDJfk7A8nblPeWlLtGda+5
 GOk5OkS5xH956rSb6AF99xknCQA5X2YtemCNQ7vN5XHLIoMNAvQYcafld1oaP2d/QlfwlZEpa9T6T6
 QzcuAFe2/f4q84s0TQWCupRNu00rTeQ==
X-KPN-MID: 33|pO6IgeE9hZ5CKb06hr40eskv75FhKzfWU6GVz8Rp8UbMNO+TsybQlkfTB66bfeT
 mCfjaI77+D/QM1/qjy+gdFw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3rPCcQFmCMf5RKmYSwbyCczmqsFve2w2G37UW+Y+TXSRhCV2k7yDgylnY7JNvtz
 eIsJ2bvAhgLVNInCe3GUx8A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d41f6211-ec01-11f0-9bf7-00505699d6e5;
 Wed, 07 Jan 2026 20:48:25 +0100 (CET)
Date: Wed, 07 Jan 2026 20:48:24 +0100
Message-Id: <87ikdd9pbr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, u-boot@lists.denx.de, trini@konsulko.com,
 simon.glass@canonical.com, jerome.forissier@linaro.org,
 kory.maincent@bootlin.com, mkorpershoek@kernel.org
In-Reply-To: <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de> (message from
 Heinrich Schuchardt on Wed, 07 Jan 2026 20:14:05 +0100)
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
 <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
 <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
 <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de>
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

> Date: Wed, 07 Jan 2026 20:14:05 +0100
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
> 
> >
> >Starting kernel ...
> 
> ExitBootServices is called in the middle of the Linux kernel EFI
> stub and not when entering the kernel.

Or it is called by the OS bootloader.  But at that point the OS
bootloader is in control of the output and U-Boot shouldn't print
anything.  In fact none of the EFI calls should result in U-Boot
printing something (except for the EFI console output calls of
course).

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
> 
