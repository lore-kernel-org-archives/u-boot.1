Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F6EC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB27C812C8;
	Thu, 27 Feb 2025 17:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3qmKtA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445668141A; Thu, 27 Feb 2025 17:31:42 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAADC81113
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so1587597a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673898; x=1741278698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d/SLZAn8g7tJ0u3mLY66Ijx7bxlgU7KtGyWfm3HgDrE=;
 b=E3qmKtA7zC0NQCuUEmGWH4xuDE00A5VodMeugaLTH0sLv8x4w5/PiEz/X2qaXQTFOC
 79Kjzhu2LAzX3AvTYtln3jPMcizJjY5gPbx1VSHMVygkcvMOajDL7W3C5wGUYseybY3J
 GqOITxXYA3mkcX/lDCnzRcEqUIWeF+kvHqoEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673898; x=1741278698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/SLZAn8g7tJ0u3mLY66Ijx7bxlgU7KtGyWfm3HgDrE=;
 b=xL9eQwPhO0kcMU8F/v4VITckkVoaRwPeprcnRcYC6TU1lNmI5x7S4nkfcUZ/7KVu0c
 p8lZaCAGA7SAsNFrkCD0TblEKrdvgGsdFQjsbZUZM31tYBtuUOHEkRQqvHLouHQICXVF
 rxfuhTG/lEOl4b6x9vFgxq4sZLPBa6k6KVPLZpiTuPyHx2Ho5vgY9H8xM4QloPrsCWUs
 CwlYgWc+U52zDLeR8zX+9Dsle2hf06OmppAv72vQ/BxaESadiLQ7sLwqnD6yH6eWydWn
 60PlPBmPL0MldexX63jrr8hTaK5nDQL++xAbIb5dFHAda0Xp2/JP3xLnsxjlQVgsznwV
 qSnA==
X-Gm-Message-State: AOJu0YzORpldTfE7phMbfcldKdZJlJ0XBsbkIOimkYDAEL14ptOSWRoo
 rDByB4D/yHY+Y6cwjHMl8tTtLiCjwMkCckWaPDEPOrwddKoxCIeEUCmyc7u7y5IXRgcFn2oNd7c
 pLjz/SiTb7AlDL8zaP4ZbWVWXHgWS8H1rriyZ
X-Gm-Gg: ASbGncsaikaCETayjF1gLQYZfnBJFv2uzeNqxAZ24EQPqGCaeblk/OZNVhVZlmoJ/Qf
 LytnL/aAxqLVZ5jpdWC/kGk42qZA06hVJxmskhg1ICbTHfkZy5uDm0u8/sTarIk0yzxfueisJu+
 b9y4FZKu7b
X-Google-Smtp-Source: AGHT+IG7OdDpdkZKbrzQCUBdr9HF5XLqrpowHnL4nheLFSPGxTJsC3sjqLbXAT8ZXDYCPw4SxPi3noVZNN9QHJZ+NdY=
X-Received: by 2002:a17:90b:5686:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2fe7e30045emr14887880a91.14.1740673898330; Thu, 27 Feb 2025
 08:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20250226162621.2681677-1-sjg@chromium.org>
 <20250226162621.2681677-3-sjg@chromium.org>
 <20250226211335.GM2640854@bill-the-cat>
 <CAFLszTjCQUb=vcNt5m9TqJC0AGcpEOanYwf7kOZoBS=DQDoK_g@mail.gmail.com>
 <20250227162613.GY2640854@bill-the-cat>
In-Reply-To: <20250227162613.GY2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:31:24 -0700
X-Gm-Features: AQ5f1JoRjbIdLKsBztjLZkzyouLEj1-iul_tpXTw8ldW5m8YG7rrD2FaMUuh4LA
Message-ID: <CAFLszThCnF3ijMKp3PP_U+Y-a6XNczGbzPz9eSnw07qcJZXzQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>
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

Hi Tom,

On Thu, 27 Feb 2025 at 09:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 27, 2025 at 09:17:15AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 26 Feb 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 26, 2025 at 09:26:15AM -0700, Simon Glass wrote:
> > >
> > > > Snow requires a fixed bloblist to operate, so re-enable this option.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  configs/snow_defconfig | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> > > > index 7a1dc80b1cc..f9fd76daa67 100644
> > > > --- a/configs/snow_defconfig
> > > > +++ b/configs/snow_defconfig
> > > > @@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=y
> > > >  CONFIG_SYS_PBSIZE=1024
> > > >  CONFIG_SILENT_CONSOLE=y
> > > >  CONFIG_BLOBLIST=y
> > > > +CONFIG_BLOBLIST_FIXED=y
> > > >  # CONFIG_SPL_BLOBLIST is not set
> > > > +CONFIG_BLOBLIST_ADDR=0x43d00000
> > > >  # CONFIG_SPL_FRAMEWORK is not set
> > > >  CONFIG_SPL_FOOTPRINT_LIMIT=y
> > > >  CONFIG_SPL_MAX_FOOTPRINT=0x3800
> > >
> > > I'm not going to NAK the patch, but:
> > > - "snow" does not require a bloblist to operate, just to run the
> > >   bloblist tests on hardware
> >
> > That's right. 'snow' is the platform I chose to try to run more of the
> > sandbox tests, although I haven't done much with that.
>
> I use a Pi for trying to run more tests on and yes, good to know.
>
> > >   as implied by d985f1dbddb2 ("bootstd: Add a
> > >   test for the bootstd menu"), which also don't seem to run anyhow?
> >
> > The bootstd tests all need sandbox at present, since there are images
> > required. If you were interested in my idea of building the
> > 'image-setup' stuff into the pytests, then we could change that.
>
> I just mean it wasn't clear that test/common/bloblist.c was run when
> BLOOBLIST is enabled on snow. But I didn't dig too hard and compare the
> output with sandbox when we pass stdout through pytest output too.

Yes, they do seem to run OK...I put part of the output from 'ub-pyt
snow' below[1]

>
> > > - We could just as easily continue to use an allocated bloblist if
> > >   CONFIG_SYS_MALLOC_F_LEN is increased to say 0x800 from 0x400 (which is
> > >   the same size as the requested bloblist allocation).
> >
> > OK
> >
> > > - This very tiny SYS_MALLOC_F_LEN is just the old default value from
> > >   when it was bumped up to 0x2000 for most platforms and is also safe
> > >   from a quick test.
> >
> > OK. I didn't get time to look at bloblist last weekend and this one is
> > not looking good either, but I will get to it.
>
> OK.
>
> --
> Tom

Regards,
Simon

[1]
test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
Test: eth: bdinfo.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bdinfo bdinfo_test_full
Test: full: bdinfo.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bdinfo bdinfo_test_help
Test: help: bdinfo.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bdinfo bdinfo_test_memory
Test: memory: bdinfo.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bloblist bloblist_test_align
Test: align: bloblist.c
Tests run: 1, 3 ms, average: 3 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_bad_blob
Test: bad_blob: bloblist.c
Tests run: 1, 3 ms, average: 3 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_blob
Test: blob: bloblist.c
Tests run: 1, 4 ms, average: 4 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_blob_ensure
Test: blob_ensure: bloblist.c
Failed to allocate 3e0 bytes
Used size=30, total size=400
Tests run: 1, 11 ms, average: 11 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_blob_maxsize
Test: blob_maxsize: bloblist.c
Failed to allocate 3e1 bytes
Used size=400, total size=400
Tests run: 1, 12 ms, average: 12 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_checksum
Test: checksum: bloblist.c
Checksum b3 != b7
Checksum b3 != b5
Checksum b3 != b2
Checksum b4 != b3
Checksum b3 != b2
Checksum b3 != a0
Checksum b3 != 64
Checksum 64 != 63
Checksum 64 != 63
Checksum 64 != 63
Checksum 64 != 63
Tests run: 1, 34 ms, average: 34 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_cmd_info
Test: cmd_info: bloblist.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bloblist bloblist_test_cmd_list
Test: cmd_list: bloblist.c
Skipping: Console recording disabled
Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
snow # .snow # ut bloblist bloblist_test_grow
Test: grow: bloblist.c
Tests run: 1, 4 ms, average: 4 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_init
Test: init: bloblist.c
Checksum 0 != b3
Checksum b3 != b2
Tests run: 1, 8 ms, average: 8 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_reloc
Test: reloc: bloblist.c
Failed to allocate 400 bytes
Used size=40, total size=400
Tests run: 1, 11 ms, average: 11 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_resize_fail
Test: resize_fail: bloblist.c
Failed to allocate 3b9 bytes
Used size=68, total size=400
Tests run: 1, 11 ms, average: 11 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_resize_last
Test: resize_last: bloblist.c
Tests run: 1, 4 ms, average: 4 ms, failures: 0
snow # .snow # ut bloblist bloblist_test_shrink
Test: shrink: bloblist.c
Tests run: 1, 4 ms, average: 4 ms, failures: 0
