Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1730EC636ED
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755FF88913;
	Wed, 28 Aug 2024 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3Ut4ADQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987B4888FB; Wed, 28 Aug 2024 20:11:15 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2877A88744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1df0a93eeso414354085a.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724868672; x=1725473472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=040/5zpMUW4hIpiSlzpCYPIapZoYwtvLLpQBzNJP4h4=;
 b=j3Ut4ADQvUhrExNHIIBtrzLvVbnTLBO5gQmI0Jhea1rT2ORyHvK5BW/+eANXJi35uv
 FAxOfqG9BnAmi0Wje4Qyz3M7ci4lT8e6AViKhjWj1YjbDWVuqc+yYjTMWuXikkstoIur
 JXWVGR3JgJodxWZDXMBcQOBS5LBQcLfKPoVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724868672; x=1725473472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=040/5zpMUW4hIpiSlzpCYPIapZoYwtvLLpQBzNJP4h4=;
 b=dpwlksfSUzUbHTfO6TSamLCLAgeEWrFCiRvCUBDf2TpxHm0b/xq6qHnuCetoQZWbYt
 0pSQII/3qDD4M68OiBmtYsAZaZFq+S3BqO+qkfigggGxyfWiVLpyxR+s0CtMJ3JRrBRn
 QaPD4LbSz70UvUUWu+/rK38V5HLa8oUI4KKeae6kHbTcwr7SDgD8949cjFxNgat4pT1H
 3ISXSS8QH1hf3thV27b2ir4BCEO2FbqhjZPoyFl3XBZQdeeXLKavLUG7iEa0RJnxM0Ra
 tEvHdMI12tGtXZi2XEci4Z9qzwf72Za8Rd8zXSI2IaYJZGH0upTwE+L2BLhyDhLqcH1U
 fmSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+K9zAsu4AycKSfvIz+AQaQTjD0Khmy4AuIyAV0TQS1Nezc6l7vnxtjSNTIx/jLwrWlznHhos=@lists.denx.de
X-Gm-Message-State: AOJu0Yw08ibqWPPIiwzWEtCqcSEbseEiVpiqFO5v/kSRLib4byQN5L3y
 yyZ3seNHIeOpAwX0JU3EkKLfhZh5BijxYKOnzXc1MN9v5k4S75sOfDVc7ruE+xHbUmxkR3+Sm+7
 t/TqSYYyU3bd/aiu3oJviEEfZHO3jZ1vJd5eo
X-Google-Smtp-Source: AGHT+IFXqosfVxxFgT0/pnKLyNwKrQgT2Mo6Fa4s9yj0I5QMLif+bjxENk63D5910We/o5hcOrv2W+FUlk0D6fSCRao=
X-Received: by 2002:a05:6214:5882:b0:6c1:76c6:b673 with SMTP id
 6a1803df08f44-6c33e617151mr4030026d6.22.1724868671764; Wed, 28 Aug 2024
 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
 <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
 <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
 <CAFLszTgGhy+nY7MGDi19ZeB7ptstmXFwWG4NRUECtdjqPfMZSQ@mail.gmail.com>
In-Reply-To: <CAFLszTgGhy+nY7MGDi19ZeB7ptstmXFwWG4NRUECtdjqPfMZSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 12:11:00 -0600
Message-ID: <CAFLszTiLsSA6JPBZanqk1wai9n109P87OO-wJJ=d-7-23=RWNA@mail.gmail.com>
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

Hi again Jonas,

On Wed, 28 Aug 2024 at 11:06, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jonas,
>
> On Wed, 28 Aug 2024 at 10:15, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Simon,
> >
> > On 2024-08-28 18:01, Simon Glass wrote:
> > > Hi Jonas,
> > >
> > > On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> Hi Jonas,
> > >>
> > >> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >>>
> > >>> The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
> > >>> the bootstage records to be printed out of order and with an incorrect
> > >>> elapsed time.
> > >>
> > >> Eek can we just fix TF-A? That seems like a bug.
> >
> > TF-A is vendor blob, so we have no control of it.
>
> Can we replace it, or is it one of the ones that has not been released?
>
> Can you file a bug with the vendor?
>
> >
> > >>
> > >>>
> > >>> Fix this by not sorting the bootstage records.
> > >>>
> > >>> Before on a Radxa ZERO 3W (RK3566) board:
> > >>>
> > >>>   => bootstage report
> > >>>   Timer summary in microseconds (12 records):
> > >>>          Mark    Elapsed  Stage
> > >>>             0          0  reset
> > >>>         7,436      7,436  board_init_f
> > >>>       164,826    157,390  SPL
> > >>>       375,392    210,566  end phase
> > >>>       423,909     48,517  board_init_r
> > >>>       472,973     49,064  eth_common_init
> > >>>       476,848      3,875  main_loop
> > >>>       477,003        155  cli_loop
> > >>>
> > >>>   Accumulated time:
> > >>>                    7,181  of_live
> > >>>                   14,739  dm_spl
> > >>>                   15,029  dm_r
> > >>>                  315,150  dm_f
> > >>>
> > >>> With this the records can be printed in chronological order when the
> > >>> counter is reset and SPL and board_init_r records show correct elapsed
> > >>> time.
> > >>>
> > >>>   => bootstage report
> > >>>   Timer summary in microseconds (12 records):
> > >>>          Mark    Elapsed  Stage
> > >>>             0          0  reset
> > >>>       164,437    164,437  SPL
> > >>>       375,023    210,586  end phase
> > >>>         7,437      7,437  board_init_f
> > >>>       424,390    416,953  board_init_r
> > >>>       473,515     49,125  eth_common_init
> > >>>       477,402      3,887  main_loop
> > >>>       477,571        169  cli_loop
> > >>>
> > >>>   Accumulated time:
> > >>>                   14,734  dm_spl
> > >>>                  315,646  dm_f
> > >>>                    7,339  of_live
> > >>>                   14,977  dm_r
> > >>>
> > >>> For the tested board external TPL and BROM take ~164 ms to initialize
> > >>> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> > >>> proper take ~477ms to reach cli prompt.
> > >>>
> > >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > >>> ---
> > >>>  common/bootstage.c | 12 ++----------
> > >>>  1 file changed, 2 insertions(+), 10 deletions(-)
> > >>>
> > >
> > > To put this more strongly, this breaks the timing output on other boards.
> >
> > Please elaborate, I cannot understand why not sorting would break output
> > on other boards, are other boards adding records out of order?
> >
> > Do you have an example of how this change break other boards?
>
> Oh sure. The original reason was that the array was ordered by ID.
> That was changed in [1], which I forgot about.
>
> The other bit is for coreboot (or potentially other prior phases) we
> receive timestamps as a block and add them into U-Boot. We want these
> to appear in the correct order with respect to the ones already adding
> to U-Boot.
>
> Sadly coreboot uses its own toolchain and I seem to have deleted it,
> but once it finishes building the world I will give it a try.

OK I gave up and just built one toolchain instead of every one known
to man, which is the default.

The code has seriously rotted and is a somewhat fascinating window
into what U-Boot was like 12 years ago...I will send a little series.

Anyway, the start-romstage and device-xxx things below come from coreboot.

=> bootstage repo
Timer summary in microseconds (20 records):
       Mark    Elapsed  Stage
          0          0  reset
     25,322     25,322  board_init_f
     32,175      6,853  start-romstage
    117,158     84,983  board_init_r
    208,409     91,251  device-initialize
    293,286     84,877  device-done
    547,606    254,320  selfboot-jump
    621,050     73,444  eth_common_init
    699,570     78,520  eth_initialize
    744,210     44,640  main_loop
    761,030     16,820  usb_start
  3,988,265  3,227,235  netboot_common
  3,988,330         65  eth_start
  6,316,294  2,327,964  bootp_start
 12,286,385  5,970,091  bootp_stop
 12,297,353     10,968  netboot_common
 12,300,596      3,243  netboot_common
 28,327,263 16,026,667  cli_loop

Accumulated time:
                 8,600  dm_r
                 8,659  dm_f

Without the sort, I see:

Timer summary in microseconds (18 records):
       Mark    Elapsed  Stage
          0          0  reset
     36,582     36,582  board_init_f
    125,775     89,193  board_init_r
    642,577    516,802  eth_common_init
    721,321     78,744  eth_initialize
     31,357429,427,733,2  start-romstage
    247,602    216,245  device-initialize
    333,879     86,277  device-done
    596,043    262,164  selfboot-jump
    765,897    169,854  main_loop
    783,397     17,500  usb_start
  4,043,423  3,260,026  netboot_common
  4,043,489         66  eth_start
  6,371,702  2,328,213  bootp_start
 11,609,247  5,237,545  netboot_common
 15,476,116  3,866,869  cli_loop

Accumulated time:
                 8,639  dm_f
                 8,923  dm_r

>
> >
> > >
> > > At the very least, this should be Kconfig option just enabled for
> > > boards with a broken ATF.
> >
> > I can add a Kconfig option, but would like to understand why other/any
> > board would need to sort the records in the first place.
>
> OK.

Regards,
Simon

>
> [1] 03ecac31498 bootstage: Use rec_count as the array index
