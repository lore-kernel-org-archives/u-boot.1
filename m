Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FFCC83F0F
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A3A88BF6;
	Thu, 29 Aug 2024 14:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T/mDrKx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFAC88BDE; Thu, 29 Aug 2024 14:18:04 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FB288B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bf66fe9d8bso2836186d6.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724933880; x=1725538680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+9YbW1aMHqTxTTY++Y3OXhsW056hNtaiQxmWNrtBWg=;
 b=T/mDrKx8iebTLfiHLW5eMHuCfTencKrGjrN3vi5a9NuyfQaZVfKaI+YV2cdsAnBm+5
 wJOlRXlJ6MwivE5pJ+dT0pt64Gh8hiItn6Hx/rm3/d4uRm4PrGdHL1SIphy91IwFrpsb
 Blq0U5tjLRGrl+cEmekWDDlF3kq1jvxCozejo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724933880; x=1725538680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y+9YbW1aMHqTxTTY++Y3OXhsW056hNtaiQxmWNrtBWg=;
 b=jppDEkRqVDrLro9ka9duET9/QrTPyRRoi4yxPfI3bJAj6eQ0AB0GS3QNALyq/x04my
 hz7/L0/d1iO/RHCUsOaNyNiwouJV+d2v3rudumr6HzVZQv0Es0zZsFQUhnXdO7dNzpBb
 K6uZReNSscXvYsx8MtFbbckW0Z4GozdgXdmikyNs4KOJsGsPFhjczQWHky5H1eQnMj/x
 BkBRXXdpDWLJ+/2KgY7n+PqHbu7RI+6qPW6BbXkS0wUXXlmk69b4vQOc/rRsdNs73Ft1
 OXrKs1+MLdPM9dSJ0mT4A82f8eFnKV11kPGkoT/Hs6Pj/2c04MA/xi/orUOOYKOHod8f
 wq6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh0rt2qANwJB7W7S68eRJUhKW9A6G7H2odHxtJ4tw5/a50oRK+J8PD0IOkzPYOCqQzVzr8muE=@lists.denx.de
X-Gm-Message-State: AOJu0YxvPpGNVwY+bRiED02m5zjgCv4rz1lFtrkpu68CFc5B3ZJb4Fs6
 daRcC6vjCslEsCURWBF5j81Scxx44SyT1KSY75OgAhc6UeEpVAFpVpuUQErPio0nqVqm8QRqMpu
 H18KAZDPeATJrys/nRZvx7FIg5vR28xs6rIbZ
X-Google-Smtp-Source: AGHT+IHbICqZoX8hRGTK9nLL82+b5NCypZSd0HrevLL415F/kQjdiiL8panyTC5kCSp1iQnP5nhBgdU9owOlOq11CJg=
X-Received: by 2002:a05:6214:54c8:b0:6b5:d9ef:d56d with SMTP id
 6a1803df08f44-6c33e61716bmr30617166d6.21.1724933880472; Thu, 29 Aug 2024
 05:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
 <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
 <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
 <CAFLszTgGhy+nY7MGDi19ZeB7ptstmXFwWG4NRUECtdjqPfMZSQ@mail.gmail.com>
 <CAFLszTiLsSA6JPBZanqk1wai9n109P87OO-wJJ=d-7-23=RWNA@mail.gmail.com>
 <4e3b907f-ed5a-4ae6-a533-d7cb16bb9775@kwiboo.se>
 <CAFLszTg0bVVWFR8WuxNia-XfoOnJ8YpUkFtw3L_8ZUwKsDAQqg@mail.gmail.com>
 <75bb8477-de40-4a51-8141-d84ccb7b44ec@kwiboo.se>
In-Reply-To: <75bb8477-de40-4a51-8141-d84ccb7b44ec@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 06:17:49 -0600
Message-ID: <CAFLszTjz9dX2UzUHgbmsr2no4seK07oo2PC++hS2t7CP7z8khA@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Thu, 29 Aug 2024 at 03:25, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-08-29 00:17, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Wed, 28 Aug 2024 at 13:01, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2024-08-28 20:11, Simon Glass wrote:
> >>> Hi again Jonas,
> >>>
> >>> On Wed, 28 Aug 2024 at 11:06, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> Hi Jonas,
> >>>>
> >>>> On Wed, 28 Aug 2024 at 10:15, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On 2024-08-28 18:01, Simon Glass wrote:
> >>>>>> Hi Jonas,
> >>>>>>
> >>>>>> On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
> >>>>>>>
> >>>>>>> Hi Jonas,
> >>>>>>>
> >>>>>>> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>>>>>
> >>>>>>>> The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
> >>>>>>>> the bootstage records to be printed out of order and with an incorrect
> >>>>>>>> elapsed time.
> >>>>>>>
> >>>>>>> Eek can we just fix TF-A? That seems like a bug.
> >>>>>
> >>>>> TF-A is vendor blob, so we have no control of it.
> >>>>
> >>>> Can we replace it, or is it one of the ones that has not been released?
> >>>>
> >>>> Can you file a bug with the vendor?
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Fix this by not sorting the bootstage records.
> >>>>>>>>
> >>>>>>>> Before on a Radxa ZERO 3W (RK3566) board:
> >>>>>>>>
> >>>>>>>>   => bootstage report
> >>>>>>>>   Timer summary in microseconds (12 records):
> >>>>>>>>          Mark    Elapsed  Stage
> >>>>>>>>             0          0  reset
> >>>>>>>>         7,436      7,436  board_init_f
> >>>>>>>>       164,826    157,390  SPL
> >>>>>>>>       375,392    210,566  end phase
> >>>>>>>>       423,909     48,517  board_init_r
> >>>>>>>>       472,973     49,064  eth_common_init
> >>>>>>>>       476,848      3,875  main_loop
> >>>>>>>>       477,003        155  cli_loop
> >>>>>>>>
> >>>>>>>>   Accumulated time:
> >>>>>>>>                    7,181  of_live
> >>>>>>>>                   14,739  dm_spl
> >>>>>>>>                   15,029  dm_r
> >>>>>>>>                  315,150  dm_f
> >>>>>>>>
> >>>>>>>> With this the records can be printed in chronological order when the
> >>>>>>>> counter is reset and SPL and board_init_r records show correct elapsed
> >>>>>>>> time.
> >>>>>>>>
> >>>>>>>>   => bootstage report
> >>>>>>>>   Timer summary in microseconds (12 records):
> >>>>>>>>          Mark    Elapsed  Stage
> >>>>>>>>             0          0  reset
> >>>>>>>>       164,437    164,437  SPL
> >>>>>>>>       375,023    210,586  end phase
> >>>>>>>>         7,437      7,437  board_init_f
> >>>>>>>>       424,390    416,953  board_init_r
> >>>>>>>>       473,515     49,125  eth_common_init
> >>>>>>>>       477,402      3,887  main_loop
> >>>>>>>>       477,571        169  cli_loop
> >>>>>>>>
> >>>>>>>>   Accumulated time:
> >>>>>>>>                   14,734  dm_spl
> >>>>>>>>                  315,646  dm_f
> >>>>>>>>                    7,339  of_live
> >>>>>>>>                   14,977  dm_r
> >>>>>>>>
> >>>>>>>> For the tested board external TPL and BROM take ~164 ms to initialize
> >>>>>>>> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> >>>>>>>> proper take ~477ms to reach cli prompt.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>>>>> ---
> >>>>>>>>  common/bootstage.c | 12 ++----------
> >>>>>>>>  1 file changed, 2 insertions(+), 10 deletions(-)
> >>>>>>>>
> >>>>>>
> >>>>>> To put this more strongly, this breaks the timing output on other boards.
> >>>>>
> >>>>> Please elaborate, I cannot understand why not sorting would break output
> >>>>> on other boards, are other boards adding records out of order?
> >>>>>
> >>>>> Do you have an example of how this change break other boards?
> >>>>
> >>>> Oh sure. The original reason was that the array was ordered by ID.
> >>>> That was changed in [1], which I forgot about.
> >>>>
> >>>> The other bit is for coreboot (or potentially other prior phases) we
> >>>> receive timestamps as a block and add them into U-Boot. We want these
> >>>> to appear in the correct order with respect to the ones already adding
> >>>> to U-Boot.
> >>>>
> >>>> Sadly coreboot uses its own toolchain and I seem to have deleted it,
> >>>> but once it finishes building the world I will give it a try.
> >>>
> >>> OK I gave up and just built one toolchain instead of every one known
> >>> to man, which is the default.
> >>>
> >>> The code has seriously rotted and is a somewhat fascinating window
> >>> into what U-Boot was like 12 years ago...I will send a little series.
> >>>
> >>> Anyway, the start-romstage and device-xxx things below come from coreboot.
> >>
> >> Interesting, so coreboot is not running before U-Boot on this platform,
> >> is it running in parallel with U-Boot?
> >
> > It runs before, but U-Boot picks up the timestamps once it is ready to
> > do so, i.e. after bootstage is inited.
>
> I just tested using coreboot.rom picked from the docker image
> trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024 and using qemu:
>
>   make coreboot_defconfig all
>   cbfstool coreboot.rom remove -n fallback/payload
>   cbfstool coreboot.rom add-flat-binary -f u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000
>   qemu-system-x86_64 -bios coreboot.rom -serial mon:stdio -display none
>
> And can now see that coreboot is run before U-Boot, it also shows that
> coreboot or U-Boot also reset or use different counter, so the records
> added from coreboot should also not be sorted among the U-Boot bootstage
> records.
>
>   [DEBUG]  BS: BS_PAYLOAD_LOAD run times (exec / console): 210 / 4 ms
>   [DEBUG]  Jumping to boot code at 0x01110000(0x07f96000)
>   bootstage_add_record: name=reset mark=0
>   bootstage_add_record: name=board_init_f mark=32182
>
>
>   U-Boot 2024.10-rc3-00061-gc6b667a71fcc-dirty (Aug 29 2024 - 00:11:45 +0000)
>
>   CPU: x86_64, vendor AMD, device 663h
>   DRAM:  127 MiB
>   bootstage_add_record: name=board_init_r mark=129405
>   Core:  19 devices, 13 uclasses, devicetree: separate
>   MMC:
>   Loading Environment from nowhere... OK
>   Video: No video mode configured in coreboot (err=-6)
>   Video: No video mode configured in coreboot (err=-6)
>   Model: Standard PC (i440FX + PIIX, 1996)
>   Manufacturer: QEMU
>   Prior-stage version: 4.22.01-2ff2409037
>   Prior-stage date: 08/21/2024
>   Net:   bootstage_add_record: name=eth_common_init mark=179706
>   e1000: 52:54:00:12:34:56
>          bootstage_add_record: name=eth_initialize mark=238014
>   eth0: e1000#0
>   bootstage_add_record: name=start-romstage mark=14867
>   bootstage_add_record: name=device-initialize mark=146126
>   bootstage_add_record: name=device-done mark=172344
>   bootstage_add_record: name=selfboot-jump mark=432299
>   bootstage_add_record: name=u-boot-inited mark=471225
>   Finalizing coreboot
>   bootstage_add_record: name=main_loop mark=251887
>
>   starting USB...
>   bootstage_add_record: name=usb_start mark=256733
>   No USB controllers found
>   Hit any key to stop autoboot:  0
>   bootstage_add_record: name=cli_loop mark=260244
>   => bootstage report
>   Timer summary in microseconds (15 records):
>          Mark    Elapsed  Stage
>             0          0  reset
>        32,182     32,182  board_init_f
>       129,405     97,223  board_init_r
>       179,706     50,301  eth_common_init
>       238,014     58,308  eth_initialize
>        14,867     14,867  start-romstage
>       146,126    131,259  device-initialize
>       172,344     26,218  device-done
>       432,299    259,955  selfboot-jump
>       471,225     38,926  u-boot-inited
>       251,887    251,887  main_loop
>       256,733      4,846  usb_start
>       260,244      3,511  cli_loop
>
>   Accumulated time:
>                    9,222  dm_f
>                    9,102  dm_r
>
>
> Above is without sorting and the records added from coreboot
> is imported after eth_initialize, however all the coreboot
> records should have happened before the board_init_f record.

Yes, indeed. I will need to have another look at this.

>
>
>   => bootstage report
>   Timer summary in microseconds (15 records):
>          Mark    Elapsed  Stage
>             0          0  reset
>        15,918     15,918  start-romstage
>       145,553    129,635  device-initialize
>       172,201     26,648  device-done
>       423,150    250,949  selfboot-jump
>       461,836     38,686  u-boot-inited
>        31,925     31,925  board_init_f
>       135,370    135,370  board_init_r
>       181,557     46,187  eth_common_init
>       235,974     54,417  eth_initialize
>       247,009     11,035  main_loop
>       250,549      3,540  usb_start
>       354,321    103,772  cli_loop
>
>   Accumulated time:
>                    9,041  dm_f
>                    9,354  dm_r
>
>
> Something like above would more correctly show all steps taken in
> chronological order and with correct elapsed time from prior mark.
>
> >
> >>
> >> How is timestamp_add_to_bootstage() called in U-Boot, I cannot see any
> >> call to it, what am I missing?
> >
> > Yes, it was deleted. I just sent a series to bring i tback.
>
> Thanks, tested with your series.
>
> >
> >>
> >> Guessing the records need to be sorted after/during that function call?
> >>
> >> Also look like the sorting is done in bootstage_report() so the report
> >> is possible logged to FDT with an unsorted order.
> >
> > Yes, although that shouldn't really matter. Perhaps it is worth fixing?
>
> After testing with coreboot I still think removing the sorting as done
> in this patch is still correct. However the coreboot records should
> probably be imported into correct position of the bootstage records
> table.

Yes, that would work.

>
> >
> >>
> >> Let me know what you want me to do with this, I will drop this for now
> >> and just keep carry this patch in my local tree.
> >
> > Hmmm step one is to complain about the bug. If it exists in ATF
> > upstream, then it should be fixed. I can have a crack at fixing it if
> > so. If it is a vendor binary, then they should fix it.
>
> Not even sure how to go about to report such bug to rockchip ;-)
>
> Have also not tested with the recently merged rk35xx support in upstream
> TF-A so not sure it is also an issue with upstream.

How about emailing Kever Yang about it? I am sure they will be
concerned about it too. That is my main concern...dealing with bugs in
binary blobs.

>
> >
> > Step 2, I suggest a Kconfig option enabled for these boards, so it is
> > clear it is a workaround.
>
> I would disagree, seeing how the coreboot records is also affected and
> incorrectly intermixed with U-Boot records, doing any type of sorting
> should be avoided, and instead the intermixed importing of the coreboot
> records should probably be fixed.

I suspect that we are still missing some code and that the timer
really should always increment. I will take another look.

As you say, we can add a new bootstage function to insert records into
the correct position, instead of sorting. We don't support
multithreaded things at present, so don't have to worry about two
programs emitting timings.

>
> Regards,
> Jonas
>
> >
> > Regards,
> > Simon
> >
> >
> >>>
> >>> => bootstage repo
> >>> Timer summary in microseconds (20 records):
> >>>        Mark    Elapsed  Stage
> >>>           0          0  reset
> >>>      25,322     25,322  board_init_f
> >>>      32,175      6,853  start-romstage
> >>>     117,158     84,983  board_init_r
> >>>     208,409     91,251  device-initialize
> >>>     293,286     84,877  device-done
> >>>     547,606    254,320  selfboot-jump
> >>>     621,050     73,444  eth_common_init
> >>>     699,570     78,520  eth_initialize
> >>>     744,210     44,640  main_loop
> >>>     761,030     16,820  usb_start
> >>>   3,988,265  3,227,235  netboot_common
> >>>   3,988,330         65  eth_start
> >>>   6,316,294  2,327,964  bootp_start
> >>>  12,286,385  5,970,091  bootp_stop
> >>>  12,297,353     10,968  netboot_common
> >>>  12,300,596      3,243  netboot_common
> >>>  28,327,263 16,026,667  cli_loop
> >>>
> >>> Accumulated time:
> >>>                  8,600  dm_r
> >>>                  8,659  dm_f
> >>>
> >>> Without the sort, I see:
> >>>
> >>> Timer summary in microseconds (18 records):
> >>>        Mark    Elapsed  Stage
> >>>           0          0  reset
> >>>      36,582     36,582  board_init_f
> >>>     125,775     89,193  board_init_r
> >>>     642,577    516,802  eth_common_init
> >>>     721,321     78,744  eth_initialize
> >>>      31,357429,427,733,2  start-romstage
> >>>     247,602    216,245  device-initialize
> >>>     333,879     86,277  device-done
> >>>     596,043    262,164  selfboot-jump
> >>>     765,897    169,854  main_loop
> >>>     783,397     17,500  usb_start
> >>>   4,043,423  3,260,026  netboot_common
> >>>   4,043,489         66  eth_start
> >>>   6,371,702  2,328,213  bootp_start
> >>>  11,609,247  5,237,545  netboot_common
> >>>  15,476,116  3,866,869  cli_loop
> >>>
> >>> Accumulated time:
> >>>                  8,639  dm_f
> >>>                  8,923  dm_r
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> At the very least, this should be Kconfig option just enabled for
> >>>>>> boards with a broken ATF.
> >>>>>
> >>>>> I can add a Kconfig option, but would like to understand why other/any
> >>>>> board would need to sort the records in the first place.
> >>>>
> >>>> OK.
> >>>
> >>> Regards,
> >>> Simon
> >>>
> >>>>
> >>>> [1] 03ecac31498 bootstage: Use rec_count as the array index
> >>
>

Regards,
Simon
