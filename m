Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0352C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170F787855;
	Thu, 21 Dec 2023 10:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B5ncsrhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283A087855; Thu, 21 Dec 2023 10:32:14 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE603877E5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso3084254a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703151131; x=1703755931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jNFMqcP8vUGp0eLvd63kNyqWmd/HZO1HEOgKXOQT7bY=;
 b=B5ncsrhVRPvhVVXNs7tm00EnII1mzOm4yoo5EbsTY1eEpu3mUW9QG7IBzfxAD5ntqw
 SMBJQbPXPJyfCWOTU2VGIoivj7Z6SWFDWR7q7a8W7WY96Ojkuf3me6iodRT4PVVytR6/
 Bx7nq+dh/Knb+9aG0q78ie7EoFIwHkFKmc3UtTxFK/57N2ulYcLZnJ8tVIiWVxUpI6Ud
 f6sOH2KCuzh+xLU7NYr7worSsLZKGym4nhoF0Jd6XyOfsjmp8HVYyrhzpMvH4oWo+hey
 9k4kbYp8ezIAxGAhTrgRaxE1b14LZJlH2th9xzcDGIU4Iw4pazR7Cpbikrx4ugR5SFnu
 g6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703151131; x=1703755931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNFMqcP8vUGp0eLvd63kNyqWmd/HZO1HEOgKXOQT7bY=;
 b=pAfSN7oQLvj/SlgUUuyPTO/HNPdD9MV1A6qwd0ShCrjHErRL+G7zRyTP+m6kD+QzWN
 tP15YBhkrfsDAX9mdkVl0xQCwDmQXK83zkj6h63tN1WqpaPzqf/tYiPcvmlvDdAr/o88
 3GhrIU3POgGMwz4kBN4wdUSYQXByTrZtFjIvxujDZ/zMljSn3hNdckrEZ5t9rp/qDTxD
 I+hPaXKBJ/WmgnH/jkAqDBkYSUAxwFZis9hpxQJNvA+veOXz3JaAB9YhPq0rlHPrdmtN
 jn8Mdw1PSKgt9kz9aejSbV0q2Ltnz57+hv7LREhMumRLu4lITJrr6helz71GqC7hhJa/
 EJdQ==
X-Gm-Message-State: AOJu0YxDcavlGPVQgAbrV+a8ej7YEfgGAVBgUWl5Tp48WIHdVmLjn3e0
 Bf+AkxYAlAJjYQJicSIBFLlwlKW4UNtHOlIumxA=
X-Google-Smtp-Source: AGHT+IH4UK0Ghi6TQnMPQxTqtYnGzjscgjf56Ac1LA3b/HCoDOhb8YAkTpAeYg4KzeyN0SNpk1x8ibE0OWvxI8QqeiA=
X-Received: by 2002:a17:907:7e94:b0:a23:4d81:ac9b with SMTP id
 qb20-20020a1709077e9400b00a234d81ac9bmr534668ejc.18.1703151130971; Thu, 21
 Dec 2023 01:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 21 Dec 2023 09:31:59 +0000
Message-ID: <CALeDE9OaV_ik2KJtZmuohpbDnS6HtWoaeEs3zvqBuinzu2wong@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
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

> > > > Maybe we need to turn this discussion on its head slightly. What do you
> > > > want to do to get SMBIOS fields to be widely populated with
> > > > generally-correct information? What we have been doing has seen very
> > > > little adoption so we need something else.
> > >
> > > Well, who or what is actually using this info? Is the problem just
> > > that it doesn't actually matter, so no one bothers? I'm just not sure.
> >
> > Users are using this information. Peter has explained that Fedora has
> > been carrying Ilias' original version of this patch since it was posted
> > so that bug reports say (something close enough and that can be tracked
> > down) what device they're on, rather than "Unknown" / "Unknown Product".
>
> Unfortunately I failed to get the latest Fedora running on rpi4. Is
> this the only ARM board it supports a download for? (I must be missing
> something)

We support 100s of devices, I replied to your query there. Let's keep
that conversation on that thread.

> Anyway, so this presumably requires EFI? If so, this is the kind of
> vertical integration and legacy promotion that really frustrates me.
> If not, then what is the mechanism to supply SMBIOS to user space?

I don't know what you mean by legacy in this context, UEFI is far from
legacy and is being actively developed, it's widely used across
enterprise and numerous other verticals. It seems by legacy you mean
"Not used by ChromeOS" sure

> I believe we have been here before, too. What program is used to
> collect the bug reports? Is it sos, perhaps?

There's literally 100s across enterprise platforms, some open, some
closed. Two used in Fedora are:
sosreport: https://github.com/sosreport/sos
cockpit management: https://github.com/cockpit-project/cockpit/

But even in Fedora there's dozens more and with enterprise management
platforms I suspect there's 100s or more.

> > > The fact that on ARM you cannot pass it to the kernel without EFI
> > > might be inhibiting its usefulness, too? Usefulness is the key
> > > question for me.
> >
> > I'm setting aside the discussion of how one will tell the kernel where
> > the SMBIOS is, outside of EFI as it's not a U-Boot problem and belongs
> > on other lists.
>
> OK, but in my mind this is a concern.
>
> >
> > > Anyway, my suggestion (once we understand why we care about SMBIOS
> > > tables) is patches like we just saw from rockpro64, perhaps even with
> > > a few more fields filled out. This series seems like a backup for
> > > board maintainers that don't care, which is fine, but we should at
> > > least be able to disable it.
> >
> > The issue is that this series adds, for free, useful and sufficiently
> > correct information in the common cases. The "for free" is a huge
> > feature too. Drawing on the rockpro64 patch, I would suggest seeing if
> > /version (or /hardware-rev or whatever) is something Rob is interested
> > in adding so it can be something filled out or not and then pulled from
> > DT instead of a new set of DT nodes that look a whole lot like the
> > existing DT nodes and properties that already exist.
>
> The new DT nodes / SMBIOS binding [1] allows for the correct
> information to be provided, though.

You are completely ignoring the numerous points that myself, Tom and
others have made.

> I'm fine with this as a Kconfig option, but it is a hack. It purports
> to provide SMBIOS info but (for both of the two fields it fills in) it
> is not in the correct format. It only works with EFI. If someone comes
> along and adds the proper info for a board, the name will change in
> the bug reports.

Keep beating that drum and ignoring everyone else's opinions. This
patch set in my opinion sets two fields, I have ideas around expanding
it out to fll out more of the information. Just like DM or numerous
other ideas you have they start with initial useful things and expand
with time.

> Which system-info tool is used? I see that hardinfo records the model
> [2] and produces a sensible name for the compatible string [3].
>
> Regards,
> Simon
>
> [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/sysinfo/smbios.txt
> [2] https://github.com/lpereira/hardinfo/blob/master/modules/devices.c#L547
> [3] https://github.com/lpereira/hardinfo/blob/master/modules/devices/arm/processor.c#L433
