Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07060EA71A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 15:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CCB83E81;
	Sun, 19 Apr 2026 17:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eEgmtIch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A62384181; Sun, 19 Apr 2026 17:09:28 +0200 (CEST)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC77E83B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so69967c88.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 08:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776611364; cv=none;
 d=google.com; s=arc-20240605;
 b=P9DlkTPMlPRUIn5muTMgGNnHDwUbjM3zayk8G2YpiPezNih87f23dEC7Kf7EJ2LGMw
 hGaXOGbdFKMfwQ4YM+paRlkNkouWQBrKR27fkqpiEXF+BEagrHqk6JGrw8SQfwb+xntI
 ilN3boKGFHEZE6YHQjl2YY+u5sjGTP96QPF1wtEFKm68fTXexPzXs8Z+VLK7m7ZMShhW
 I/ANuPgBhb+i9h3JGav5SsXBxkzC7mCt9VuMJqM9fUiHbb9wF1q3JnVm3GhVU/4is3wz
 3g2+UZaAwCUUAsigLyGeyX3rDS4hTI9h1afE0NI5R0t5BYGwOcRVUeOK74jU49pXYF1J
 KurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KHP9TCo2OyTWoSg1kfi9h4AOEi+Cx6aMDUFO+Ofiat4=;
 fh=wPAQiU5bNRhALx3XO3MiVreLKa/Z2UwbbPFZJCeu2KQ=;
 b=UFDaWhbWdGFH5jGB9TheDQxgXcncjA6T6kmzwEa3mj2wPS2y0Tf5SsKeiOX2kiPnhM
 ohfU8bwookOHE3LvivbX+XROptMvTBUhBw/EEJhDbt698WghSjiRYEpq1usLjVkYIFFr
 iQShoICuvGtAcAWZ3VdqrVWTdd+8xdvY5x5VBZeazdxdfQo6fkgQeYQBueJJ5cYY0hxu
 V5TjM2/6j2ercTS58+tCaDpv6FK4IK45vlC1cV4KQ4ATZ8se0tW/uX5lmlywz6Tqzf7I
 sZ87+QHUbQXk0VPrrVaA6slzswCZ1W28Vwjw8efI0waWcUCdefTNcSNkD+eyzPFsGmNc
 Uqiw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776611364; x=1777216164; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHP9TCo2OyTWoSg1kfi9h4AOEi+Cx6aMDUFO+Ofiat4=;
 b=eEgmtIch0Nu1Q2NOJSf82mukCDSx+D3P9ToNoM3MjW3X1Hdq87GElXIvonNHDwCKah
 moU7dsPY94SWiPdOI2vlsZbIj2JXwAd7Ym4iQSh5+2D7UL1xrQwoFnCVQGCqPQjqBHpH
 AD4VDuebnBnMjTD60AVUgHStwdZBfUuenSU+/1fzH8ozomZfr34+ADmAnX9SBHTuNw5f
 NKZO70q9EB8/6ftqurgqXPJAAIQeh4ahlF6fg0Meernn87qhSTSZ7DD6tbamIX9WBFYK
 Pd2eRos4Cby9FzbQKMFfnR7V8298I0kM/8+HJ2t6xOCsGdOBAd4KMN3m/WGOstlebwZK
 EMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776611364; x=1777216164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KHP9TCo2OyTWoSg1kfi9h4AOEi+Cx6aMDUFO+Ofiat4=;
 b=amLbUkM56T5C3+IH9TCHugLmsarGnaPQhEm8QKQAWR8bpOuAW+YI96lXWCe+Unjux2
 PhUhBI6kZU34rK24XKPBFg3Cqkgvb9XdDQQBWlnHlc3AL18DoyzKZ3s/v51TjmKmssPU
 kucyo9BSC4XijlLjAD5/VFjTE48ikhCcX3lasfN7mdgz0SbywPl9z4eeNkSZvD7laG4L
 R3MR7ICyZOA9PRKA1CEkTX3QxPN7FDskPjZqOfm3WGdoFsnK7JctO4yPvva8wTq0Q6R4
 cuARNvYde7W+8Md61QAWNcx0IpwNoQojGiya8ZIYVzn1aCMAcmkraETA8kB90w7PN7+J
 IhOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IPLk8waBGxKPUigfoDwf5w2e5GPVymaOYiTUdE1+NcPuycPsgOAkUfBgn/QZHSgz8j3LbYzA=@lists.denx.de
X-Gm-Message-State: AOJu0YxTvuGt1ymg+XcazdVaPlQARb/rFkGi4bb9HO1TWDsUUPGi44ez
 4m+9pMJAn9MYhYuIcCY5D6fkKQ6FoutcvaZrw2I6pUcn6XTjPGeq6cGacmb75jkWAtJGxXdldBG
 IXMfSj60VigZeq2qbA5/x20amUE7dMSg=
X-Gm-Gg: AeBDiest5wwxDITQN0KkimRJvQ7mZ7n50lBCL2yUy+7kZj7ppLoyO9mtWPTUftQ5gqj
 +mwickNHVJ94SbltzoyaO/N7whC80YxpWow5ZesRooV54uei6rGpLP0ur8DUcbQjTA3eVSkfcAi
 KviWhCacw1IvJDuY8PFI4r/sfFZwFpXs5EryrSEbZESA9f4m4uyngXBygzXy3ioixXPkRUa/T+9
 WxNL1BTmBxmYZQ9fl2ombxMFQDorbk4/rIJ6Est0Izg9NVAW7danmeANGWyLXTcwuFoPq1LKm97
 yjqiwOSMXdvf+cJHadqie09f1BoQkxkY0O6M/XNpLv1JVvSCfhi+iW3LkkTmSVIH8CpRLdnNmOg
 /w2p4O3+Xof2v0Idiqu1tJOeLU4EJEhlA5lEYog==
X-Received: by 2002:a05:7022:6ba1:b0:12b:ee92:a60e with SMTP id
 a92af1059eb24-12c73f6c422mr4017664c88.8.1776611364088; Sun, 19 Apr 2026
 08:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
 <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
 <aeTeiZER1IJar_w6@kehys.lan>
In-Reply-To: <aeTeiZER1IJar_w6@kehys.lan>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sun, 19 Apr 2026 10:08:56 -0500
X-Gm-Features: AQROBzAeQepBmCE2gdH0OdUldTCr9MaswlsK386ankioaT2s0voK6JsCIk3my-0
Message-ID: <CAOCHtYin=6r86ThsagZrdFu5+_b2ACGmMZs3yK3tPd45PXJw4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>, 
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
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

On Sun, Apr 19, 2026 at 8:54=E2=80=AFAM Marko M=C3=A4kel=C3=A4 <marko.makel=
a@iki.fi> wrote:
>
> Hi Robert,
>
> Sat, Apr 18, 2026 at 12:53:59PM -0500, Robert Nelson wrote:
> >Please don't upgrade to the 12.x.y.z0 branch of ti-linux-firmware
> >
> >After this commit you can't even upgrade to `v11.02.09` without other ch=
anges!
> >
> >https://github.com/u-boot/u-boot/commit/7403d26bea36315f2008ed3ef80125b0=
94c0bafb
>
> I downgraded to firmware 11.2.5 "Fancy Rat", but that didn't allow me to
> see any further messages.
>
> >I'm pretty sure OpTee 4.10.0 is safe, but otherwise this is my current
> >stable branch:
> >
> >https://github.com/beagleboard/u-boot-pocketbeagle2/blob/main/version.sh
>
> I tried to choose the same versions: OPTEE 4.9.0, TI-firmware 11.02.11
> (strangely, also this one identifies as 11.2.5; I should always build
> everything from the scratch), and TrustedFirmware-A v2.14.0 a.k.a.
> lts-v2.14.0, because I did not find any tag for v2.14.1. The U-boot fork
> that I'm trying to build is already the same one. The boot process would
> seem to always hang at the same spot: before switching to the 64-bit
> u-boot.

it's showing up in this repo

https://github.com/TrustedFirmware-A/trusted-firmware-a/tags

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
