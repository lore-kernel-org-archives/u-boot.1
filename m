Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA11CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 02:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416B9846D3;
	Mon,  1 Jun 2026 04:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E8gdlgSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62EDA846DF; Mon,  1 Jun 2026 04:31:53 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2B9846A7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 04:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec354815b9so72535866b.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 19:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780281111; cv=none;
 d=google.com; s=arc-20240605;
 b=Lf0WICtuIihxjLKpux716CZPTmhxH54j1TmpFHZgovf5z60nrido+Uq8qbnwwbjHXN
 CiUc0Ab3Csia74v1l5tZ3Ac1vo+nigyegV7hkFQ0hvFFnc4b80keZAne6FkQed9CqBgc
 WOSIXjT3sSOwClZURhcurLXcJKzRMkiCaEuXDqaHf9QH22pUQJH7bM3sXE5mCr3Ie6rY
 mi2dpF5u1yRMGrdGFkYOP0JROEFKo0FR4D9jcEK3B+/FnnIVBaMJi8hWgnErLM8y+CjM
 2/npFP9SB6VaLI3NcoHIdixsn6RJXLjnsZ1GwlAzpVPMS9pC5pNBDZ/5LSQVPdTEVIq1
 hxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=/ERCnrLKgXjyXFzxH85zj4Vaf/N1S65+VoOgTBuMm4Y=;
 fh=TET5S8HdstBeL06m3rXC9+5+vcIZu0AKXAJUdHpBQK8=;
 b=BK5xaOTDteKxI5uv5Q8qy2tZEstSH5DF8lrbUUA0faatutG8zJNoXYm9GAINk+I+LM
 lNYTbfNF6yaG1sFbVqOS3S8m9LK2KCkrsKLyYbW1frfXNJHkCkK9WSVfIAcFVWR2RVHZ
 Oy13oPO1e4KJUF/ZzP9eCKxsAOOeeqEZ0BlsnJO4Vpw134pgNtiuTSqzkx7NZ8ZMA12V
 mXbUcJsovCLHPfFDnecgW8iM5dL6ECkSvul2/SP2htgqSn6Jk5NKmYnypdYYhkhLgnPw
 svx/rtF7CFwnnF05KY+DZWIOoFffuj0WnbPhX/pQ5jnm8OJI4+J6WyddkGqWVoekygJs
 mihg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780281111; x=1780885911; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/ERCnrLKgXjyXFzxH85zj4Vaf/N1S65+VoOgTBuMm4Y=;
 b=E8gdlgSMvhtmWcT1+JROzUAXdyFR2uUhJErmN425z/uY2RCItJMGTQZ71mznh7/OHx
 +PZbgF/1QjEjhkms7W8kOKQZi3eDh1R/mZ8TBF+c+RDU8IuBsyOpKAjG+Ak19tTOtCHC
 axF2CpiQQ7QHqpu2uywfX3ePzBbuOrJZ1pFzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780281111; x=1780885911;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ERCnrLKgXjyXFzxH85zj4Vaf/N1S65+VoOgTBuMm4Y=;
 b=L4Zbu67qUps9RFG/lpDzZZBpwMuZqv93MPLJtPL22fLdhlb3ozXzZ3DsPKj+y/GOu/
 JnXXdzvxECg2kZxh5tDUsw8Kq3WMy71aMvFHx3C1CXfzAOe1TJZbTknPgY26G78uq+MC
 DmMZmhkT3/2UKVwn+pswUlEpkQzsVgi7IdOCV7i6iznAnBw1tGdZeo5XDP5BT6wGguS4
 W+7eciCEEHtOR4B1ufyWLb02iIKwr4CUPGEYPl6np/yBq/I/ep2YF7m5Zdlz3YmN2P+M
 qoGgRiW6/OwJcyPOEDsuJP0UbEel5NMpsLFZRV4d3MrCY52X4w/StHVRlIde0jkmGEd6
 viXw==
X-Gm-Message-State: AOJu0Yy0kVl1rQzFGCHDrclEJsckmxkm3rA7X6bpK3WOFoirTlcyiOrT
 Eg7nx1YyJW1TQ3fqAKWshq58GugljdYoHRK9BppcHySP9DfOUMFHgeubGk7CdP5seWJ8DBxhgSI
 T1fFx0U1n0iZ/zbgBrfca1CvBV7KFIKRbIsdI2mqu5+6vL5924hwNeg==
X-Gm-Gg: Acq92OG7xuivH1ti5uUAXY3/ZmzLNSzV6z3yOdzZQvktqpp843gaqPmWCqtOoNN/ADg
 opO64xTOoo86IF3chujAOc9jD1XOcNtSkWyL94jvHWNhWZAdU+TwCtV4/A637Bn18cPzh0ka5aQ
 YZKnOpOjHaLQ+2vk0k/0C11ewfYAMI3JLRc8YQdk4DNP0+PMNZjapZ0LbTNUUeS0HmFKvVIsmVY
 LuiOSQiAiWng8e8B1GXHrLnEBeUe653BERNtEVyOGQRSapHCmD3+363ZaefumlDZTlPYk7xYbMT
 cM/6vWo8OmLbcaOs5FU33t0sdn8=
X-Received: by 2002:a17:907:984:b0:bd3:6ec5:f141 with SMTP id
 a640c23a62f3a-beab6bc537amr420859266b.30.1780281110633; Sun, 31 May 2026
 19:31:50 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 May 2026 20:31:38 -0600
X-Gm-Features: AVHnY4LMmd7_02b1AKpmc3XJ86CrNDF0rnLW36_So0KfwwqfSMICL0uWZVAnnPM
Message-ID: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
Subject: Flashing Edison
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Hi Andy,

I've dusted off the Edison and have confirmed that it starts up:

# ub-int -T edison


******************************
PSH KERNEL VERSION: b0182b2b
WR: 20104000
******************************

SCU IPC: 0x800000d0  0xfffce92c

PSH miaHOB version: TNG.B0.VVBD.0000000c

microkernel built 11:24:08 Feb  5 2015

******* PSH loader *******
PCM page cache size = 192 KB
Cache Constraint = 0 Pages
Arming IPC driver ..
Adding page store pool ..
PagestoreAddr(IMR Start Address) = 0x04899000
pageStoreSize(IMR Size)          = 0x00080000

*** Ready to receive application ***


U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)

CPU:   Genuine Intel(R) CPU   4000  @  500MHz
DRAM:  980.6 MiB
WDT:   Started with servicing (60s timeout)
MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
Loading Environment from MMC... OK
In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
Target:blank
Partitioning already done...
Flashing already done...


******************************
PSH KERNEL VERSION: b0182b2b
WR: 20104000
******************************

SCU IPC: 0x800000d0  0xfffce92c

PSH miaHOB version: TNG.B0.VVBD.0000000c

microkernel built 11:24:08 Feb  5 2015

******* PSH loader *******
PCM page cache size = 192 KB
Cache Constraint = 0 Pages
Arming IPC driver ..
Adding page store pool ..
PagestoreAddr(IMR Start Address) = 0x04899000
pageStoreSize(IMR Size)          = 0x00080000

*** Ready to receive application ***


U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)

CPU:   Genuine Intel(R) CPU   4000  @  500MHz
DRAM:  980.6 MiB
WDT:   Started with servicing (60s timeout)
MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
Loading Environment from MMC... OK
In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
=>


Now I can see the instructions in doc/board/intel/edison.rst but I am
not sure how to translate that into a lab. Basically I have:

- UART
- Relay hooked up to the RESET button (SW1 U15)
- power control

The instructions in edison.rst are quite complex. I can run the
xfstk-dldr-solo tool but I don't want to have to download and install
a recovery image even time I want to try a new U-Boot

Basically what I want is to be able to send U-Boot to the board over
USB and then have it boot into that U-Boot. It seems that once U-Boot
is installed the board behaves differently, but there must be a way
around that.

Any help much appreciated. It was nice to meet you in person!

Thanks,
Simon
