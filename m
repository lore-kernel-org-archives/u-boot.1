Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D0D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 14:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D79B836A3;
	Mon, 29 Dec 2025 15:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQ+CwpbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DF883DE4; Mon, 29 Dec 2025 14:27:36 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C9583DCA
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 14:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a09d981507so66733385ad.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 05:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767014838; x=1767619638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4T+9o336SkmuAk1EyKQ8ulFneKs66tn8uOB4VD4m4Xw=;
 b=QQ+CwpbFYNMS5ZHhf9/BzODJ4hfbwCYAdYXh2XaklTaTnq1RfuDNdel4wcm+nzkRCe
 X24QNmLcNfY+1PohWjCvyTeHcvRNdRYkGLvnpPnWNsV85yHhiaGeWXOGs0wYyr6sRpPg
 484v/0y8O7qhKutVvonsdm4dsVBPqrFnWr/ArAYdrjEsMygqEHHsHUFwoN7rBkOJHttg
 LO8KYmoBnWROV4X79Zs9BLhoATY6QZoMRzFsy/ihJ9eRQyqHrCN0/G+rMSYU3cwV3YJK
 Id4hYs7AQpviG3xy9jn0Qu/weyNzB0mpo7e97OJLpwvKFHwCOublb95ZdH47sEymQqH2
 70Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767014838; x=1767619638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4T+9o336SkmuAk1EyKQ8ulFneKs66tn8uOB4VD4m4Xw=;
 b=FHQeBCJotcdM2c8vhiK6NfXuEzwa1xegnIQp5q7A/nZJF1PFvPxIe188YMo8cDcKzl
 n1QP0jPFJMdPWtmhMEIw3nWPrXy4O/bcDCWSCamMv2qMQV+UgJuAUSlZ0jGN6QyCgySK
 JbIw3OEhlOCjV9r1d1qUlk8C8MrUPFEd43gjuGPXYkdakGNdwYoZSunliHlzzzAybd9b
 wrBQwTCE474n6cM16z4dFxUwnckn1qNpk9y0Kw1NB0AAnVlrn60Ja/HbUlLtCh8mJq9x
 hQZTytMm7NL4JEKdrrpqE59lMPmZvEmA0u527NzySVjvHeLA2XCQWluHptTmZa+fmSSB
 bNrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzx9mzsELQrywV8Zkj56pb+8G0qEi7HJXN5vZGBMkT/YuKuegkFiC4iNPXOgLV70m9yraR6c8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5N9PxdSVSN5lqjTCzOXVQ1b+H5claBNNKzwAr3bJm++PNQB8W
 BuWF38/OVNqhrdXa9Y9JDd0jnmR6/uxqcGP3OOyKomcgnjv01bR5wsBl
X-Gm-Gg: AY/fxX4ddZsOpHaD/8FKl44xrXHJFJRhjfMtkwkyIomVlNcGe81weRqNcKGRRQrV0oR
 m1IOIKzeKtQIq9AYiS54kEzYOJM0CDh4wpDTE9nvOWjJ0B6+q8qFQt6r7qrC3wENGZs9Pd1KnWr
 GySMxHQCL9iRvRbSNc95vnQ7wrOJKn7b1f1riuysOotpG0oDQ71l2S6QoQBpCe2yzlLlfXwt/+1
 6wt2J5FRzuEv2QIKNMRmvST35BRooKddSS6ntyn1CrPzul9ltjkLtAYIKuefatLLJz+jrgRTFA0
 UxVouktFPv15REcQl5fs7iytgwFhn6NMmjI4SrCrcgWEqXyu/tti9a6J1kCKO/pn65gyVnnarD5
 peX3Es/Kc800Cd35bbZk1yJSq+lSV//YMLj0SQ7r+JtKPoQiyqLhMRtMcF5KCeUpYvK+vnbn2to
 cVXlJz2DnIvvtrlslUbqGM/T3y
X-Google-Smtp-Source: AGHT+IEYzY7e9Iy7rnvDwasiwKfhEzGQ58Ihh0U1EmZtPt0XXU28eRITrHMeW2N9+0mXY5TkkfXUYg==
X-Received: by 2002:a17:902:e845:b0:2a0:7f8b:c0cb with SMTP id
 d9443c01a7336-2a2f0caa42amr344756215ad.4.1767014838324; 
 Mon, 29 Dec 2025 05:27:18 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:39b1:7962:379a:1a23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d76ceesm277575085ad.91.2025.12.29.05.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 05:27:17 -0800 (PST)
Date: Mon, 29 Dec 2025 21:27:13 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] m68k: Add support for M68040 CPU
Message-ID: <aVKBsTYOxu82pFHs@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-3-visitorckw@gmail.com>
 <CAFr9PX=JzXVa-HTvV-Cbw3m+kvwYP_7RiG_jE8+WW+KKG59unw@mail.gmail.com>
 <aVGFEFCFKsmYIT0b@google.com>
 <CAFr9PXkL8pDrtM86pmaw3U9RXCH2z-33X4hjqKUiJQAnQk-K0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkL8pDrtM86pmaw3U9RXCH2z-33X4hjqKUiJQAnQk-K0g@mail.gmail.com>
X-Mailman-Approved-At: Mon, 29 Dec 2025 15:45:36 +0100
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

Hi Daniel,

On Mon, Dec 29, 2025 at 10:54:45AM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Mon, 29 Dec 2025 at 04:29, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > > Connecting GDB and single stepping to work out where it is going would
> > > be helpful.
> >
> > I did attempt to investigate this using gdb, but unfortunately, the
> > root cause remains elusive. memset itself appears to execute correctly,
> > successfully zeroing out the global data. However, using it seems to
> > trigger a side effect where initcall_run_f() returns (which should not
> > happen), leading to the hang.
> 
> Maybe a QEMU bug? If I get some time I will try to reproduce it.
> 
> > > Since there is now a goldfish RTC driver upstream
> > > (drivers/rtc/goldfish_rtc.c) we could take the timer part from my
> > > version (https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c)
> > > and supply a real timer to the board. Right now I think anything that
> > > uses delays will get stuck constantly reading back 0?
> >
> > My original plan was to focus on a minimal boot to shell support in
> > this series and add rtc/timer support later. However, if you prefer to
> > have them included in this series, I am fine with that.
> 
> I looked at adding the timer parts of my "goldfish rtc" driver to the
> upstream one and it's not very clean.
> So I have removed the unfinished RTC bits from my driver and moved the
> whole thing to drivers/timers/.
> That seems like a better way to go. I think having working delays etc
> would be nice even for the initial support.
> I guess if you send your initial stuff and someone asks "why is there
> no timer?" you can tell them I'll send a driver for that in the next
> series?

Sure, I will add rtc and timer support in the next version. Thanks!

> 
> > Since the timer driver is authored by you, I assume I should add
> > Co-developed-by and Signed-off-by tags with your name to credit you
> > properly. I wanted to explicitly ask for your permission first.
> 
> If there is anything in my branch you find useful you have my
> permission to just copy and paste without adding any tags etc.
> Credit is nice but I don't really mind.

Got it. Thanks.

> 
> > Also, regarding the tags, would you prefer I send the integrated patch
> > to you privately for verification before posting v3, or is posting it
> > directly to the list fine?
> 
> Can you put the branch on github or something for me? If you send me
> patches I'm going to have to import them to my local checkout to look
> at so if you have a branch I can access that's less steps. :D

Sure, I will push the series to github and share the link.

Regards,
Kuan-Wei

