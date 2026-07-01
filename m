Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CDBC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463D884C25;
	Wed,  1 Jul 2026 14:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iowoNdJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D4A84C2B; Wed,  1 Jul 2026 14:03:28 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC8E841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so1348869a12.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907406; cv=none;
 d=google.com; s=arc-20260327;
 b=YF/xd5QrzBFtP1GE70XV29OH/QNNA6MP4Af/8TWrBBRY9vcdumrgsBxsOqd2bJqz4B
 WK3NO/YVRDGusUhS6vUiHSipKzqnZa1zcoGR2CpK5J9uZL6LvkgfcvuNUjx1Dqv7Dzgh
 XDCd33WSnb56yq8IzwUgRTivMxR1WA2YFwq2ox5ZV6zCrkYu5zYEShgbTJCujQIXevy8
 f5dHqkj7e+a4Oq8V1IRRY0ugQbItGUnTFd6AoXYlkuhFjH1PyB7Onh4GG8KoGRjIExNN
 ORuj52za9zcDzqM3qoo9gBb3nK1i6F2uAOiCfoGQdzzzZj3b9Qx6zvaPTorRGHumMdFw
 BcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WLc6SDNTi/RbDAOSuM6sNKu1+xLbxs3U2ATW1DvDBhs=;
 fh=MePKN2nkrdEpMLpwbdBjPt+rtUsk5mUHX+dnJtXiw2I=;
 b=TmlY0B3B09XrNy3uhagE6MO1ivmGOFzz36sE45UQguyvnhMUDcNocIdWMOUE2mfhsS
 i7lVHPswyflx8qP7fY8IVmUfb+AEwWh09uPOuyRhlj/CM36iw+9Y4p5D000HrJMcEHt0
 J/XHO4E7QsskpSAJxsqHZg3YV1qBwr465hUetNkh89hY66TcTp2GAypUBaPAty+5usxn
 wCQ3hCcHRtukhbcyyEkqsRaWWEjim+ZzuTgrFKCIrbtmdwUWJrbxIZexxHJL4uUFg3ZD
 +Ay2y28u5RIQ8NxAWURndI2HPH2mfivmDFegFi0z2+yhV4mooesoBXGauaT2+NtS2x3h
 TvAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907406; x=1783512206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLc6SDNTi/RbDAOSuM6sNKu1+xLbxs3U2ATW1DvDBhs=;
 b=iowoNdJ899kioZ50IRVWO98mC0lD1c9rSYXtkR4G6Vz7NUe3mfbTzawk86TZnTs7Uj
 iSCtzv9LHW8r3u7peUC5wYOqmGNzJkQKeT9f7DzIpc5OsDWLScxNqYa2ZbcOiI1FTYY9
 aYOzLY470f0dp3tUHtUEWXTtJuVhvHtbVdWUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907406; x=1783512206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLc6SDNTi/RbDAOSuM6sNKu1+xLbxs3U2ATW1DvDBhs=;
 b=SE95GYOr28W+WoKdyLq8fantIa4wMQMLew+ECbeuzIdFjn1HssNehihAf5kbCQRj6L
 g8u+xDb0rVq+N+gESAqpAXp4+GyRZzKO3elZqaZpJcSrd954X8z++PnGqDT3h+IOzI6n
 RZX3XRvNsJ/Xm2lfP4Mu7a8gjtXJoK7Diy7aNj+7U/wMIwQnBz4OWVw4MEreI7IRHpV5
 Ub1ceM6iJVbSHRBYzi1Z3AjRhJGPzwrrgSteJfy/Bi0yJMYFiFM5hnJ+DiMb+sEOa/Xw
 c/F4if0RRasugXu7yuWvlYb4cpiunIXvU8i0GZ5V02P5w6KAJDMomw172MW2TvluhInG
 oSRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEAzGHPXiPHHXDgEss3xC/XkIReX2oo90bHB7jGC+P0c+Hbti0YzLwdhfiOOFR+yvC/HFbNrk=@lists.denx.de
X-Gm-Message-State: AOJu0YzF1/eYmHHYQKVFvghTa78w7w7aOqq51SAWysi/BHF4wbwk6zeF
 CcY/GZIBHTaZwsilslzsRAEvf63e0w1ORauHPkojDq1TQECKJkih5coh7S8ccP6dPFsLDPAPyP3
 bYPR+KrY3BscoZ7zJjQngmwwww0fQruTcDSpLzt9p
X-Gm-Gg: AfdE7clVl3sQ9GnYPOTTPgwUkwAbVGUxI7UYSg0LCWZlYTeGuau79eGTH20GxVVYhc6
 vJHJ9hPZMhz8nuoOVNDmGNJsjUS6AA+bwfQzdaiqJr5WYsOwui2mCRNVvn5zP2AC3kgsH3WwURZ
 M17M7dekAD8hdhygNNjh5DYK/TH/ULtG7Yj0JNofNtOXm87LCu7IVnjrXVBfAGs/UykYGsOpwPG
 7CEuq5IJ8g8zBg1/1aNWST8K0iCGdfqHDjaIrFeFaU7hrL2MhMzDAFraUuWUdwwic+MfUYbAQ==
X-Received: by 2002:a05:6402:34d2:b0:698:3b7c:3b43 with SMTP id
 4fb4d7f45d1cf-698a2cf2b5emr155418a12.34.1782907405618; Wed, 01 Jul 2026
 05:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-10-heinrich.schuchardt@canonical.com>
 <CAFLszThopRDCMspX9yMC3f72fOj9mzqDcFmDVDO-UmucCBUMiw@mail.gmail.com>
 <b852fb2a-00d8-4e91-a82e-001b86a3e189@canonical.com>
In-Reply-To: <b852fb2a-00d8-4e91-a82e-001b86a3e189@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:03:13 +0100
X-Gm-Features: AVVi8CcAa865sAL1FCr2bUXKm_EZqP9by75pgejTINjPGgNiJ9DFNcvSKx34_-Q
Message-ID: <CAFLszTj1WFu9nd=+w91vK0BDpA9y-Ex=v1PFvbmL4mYXtGEPpw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] efi_loader: move efi_main and command loop to
 efi_app_common
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Sun, 28 Jun 2026 at 07:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 6/25/26 10:54, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-06-21T08:19:04, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >> efi_loader: move efi_main and command loop to efi_app_common
> >>
> >> Add the remaining shared code to efi_app_common to complete the
> >> refactoring:
> >>
> >> * efi_main() - common entry point; calls efi_app_init(), prints
> >>    app_banner, calls command_loop(), then clears the screen on exit.
> >> * struct efi_app_cmd - table entry holding the keyword, help text,
> >>    and a handler of type void (*fn)(u16 *args).
> >> * command_loop() - iterates app_cmds[], matches keywords with
> >>    starts_with(), and falls back to efi_app_help() on no match.
> >> * efi_app_help() - prints each table entry's help line plus the
> >>    built-in 'exit' line.
> >>
> >> Each dump app is updated accordingly:
> >> * efi_main is removed; command_loop becomes non-static.
> >> * app_banner[] is defined at file scope with the application's
> >>    title string.
> >> * Per-app duplicate state (bs, handle, systable) is removed; apps
> >>    now use the common module's state.
> >> [...]
> >>
> >> lib/efi_loader/dbginfodump.c    |  95 +++++-------------------------
> >>   lib/efi_loader/dtbdump.c        | 109 +++++++---------------------------
> >>   lib/efi_loader/efi_app_common.c | 111 ++++++++++++++++++++++++++++++++++-
> >>   lib/efi_loader/efi_app_common.h |  31 +++++-----
> >>   lib/efi_loader/initrddump.c     |  91 +++++------------------------
> >>   lib/efi_loader/smbiosdump.c     | 126 ++++++++--------------------------------
> >>   6 files changed, 205 insertions(+), 358 deletions(-)
> >
> >> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> >> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> >> +extern u16 app_banner[];
> >> +extern struct efi_app_cmd app_cmds[];
> >
> > Please move these extern declarations into efi_app_common.h next to
> > struct efi_app_cmd - inline externs in the .c file hide the contract
> > that every consumer must define both symbols; putting them in the
> > header makes the interface explicit and lets the compiler catch type
> > mismatches.
> >
> >> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> >> @@ -118,20 +99,27 @@ static void print_info(struct efi_loaded_image *info)
> >> -static efi_status_t do_dump(void)
> >> +static void do_dump(u16 * __maybe_unused args)
> >>   {
> >>        struct dbg_info_header *dbg;
> >> +
> >> +     if (!device_path_to_text)
> >> +             bs->locate_protocol(&guid_device_path_to_text_protocol, NULL,
> >> +                                  (void **)&device_path_to_text);
> >> +
> >>        u32 count;
> >
> > Declarations should be at the top of the block; u32 count lands after
> > the locate_protocol() call. Also, the locate_protocol() return value
> > is now ignored, so a permanent failure silently leaves
> > device_path_to_text NULL with no diagnostic; the previous code printed
> > 'No device path to text protocol' on error. Please restore that or at
> > least check the return.
> >
> >> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> >> @@ -164,60 +152,9 @@ static efi_status_t do_dump(void)
> >>                print(u'\r\n');
> >>        }
> >>
> >> -     return EFI_SUCCESS;
> >>   }
> >
> > Stray blank line before the closing brace.
> >
> >> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> >> @@ -156,16 +143,13 @@ static efi_status_t do_save(u16 *filename)
> >> -     ret = do_check();
> >> -     if (ret != EFI_SUCCESS)
> >> -             return ret;
> >> -
> >>        smbios3_anchor = get_config_table(&smbios3_guid);
> >
> > Behaviour change not mentioned in the commit message: previously
> > 'save' refused to write a malformed table because it ran do_check()
> > first; now it happily writes whatever is there. If intentional, please
> > call it out; otherwise restore the check.
> >
> >> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> >> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> >> +                     for (cmd = app_cmds; cmd->fn; ++cmd) {
> >> +                             if (starts_with(pos, (u16 *)cmd->cmd)) {
> >> +                                     efi_uintn_t len;
> >> +
> >> +                                     for (len = 0; cmd->cmd[len]; ++len)
> >> +                                             ;
> >
> > Isn't there a u16 strlen-style helper that exists here? Also,
> > cmd->cmd[len - 1] below assumes len > 0; an empty keyword would
> > underflow. Worth an assertion or comment documenting the invariant.
>
> Neither efi_freestanding.c nor efi_app_common.c have one.
> Maybe in future we could add one.
>

OK...we can likely progressively move common things to lib/efi

> Let's check len below this line.
>
> >
> >> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> >> @@ -0,0 +0,0 @@
> >> +struct efi_app_cmd app_cmds[] = {
> >> +     { u'dump', u"dump - print debug info table\r\n", do_dump },
> >> +     { }
> >> +};
> >
> > The original help text column-aligned the dash ('dump       - print
> > ...') across all apps. With the new table the dash sits right after
> > the keyword, so 'load' and 'save <initrd>' no longer line up in
> > initrddump, and likewise for dtbdump/smbiosdump. Easy to restore by
> > padding the help strings.
>
> Maintaining such an alignment in the app definition does not seem right.
> If we want to restore the alignment, we can do that in a future patch
> for the help() function.

OK

Regards,
Simon
