Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89921C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 22:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F20D878E9;
	Wed, 13 Dec 2023 23:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S248QGxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFB0878E2; Wed, 13 Dec 2023 23:22:41 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6D8878D6
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so47085975e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702506158; x=1703110958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x+pL1igjT6Pp9uV27Ny8exuJJP4spsrAlS2iIPvKEUE=;
 b=S248QGxVCTLJR7fN348kzIyEhEAnHFPuuY3MFMByfEVoBRJ/WkcS9+DKsoqG4jhWbL
 HrZ6iJgQtYpm2hAAVyLCaj64VJVVEb+6YzBfJyIVqM6Cya/tMfQCaxfH5pPwzTF1/je5
 i3FGi0IoA/+GNj+D06BtHpto0vmiaakSV10jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702506158; x=1703110958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+pL1igjT6Pp9uV27Ny8exuJJP4spsrAlS2iIPvKEUE=;
 b=WkkyqJ2bmKgVdZ5wyJdIngRKXs1iqAkNek6iCSrbQfB8tMh2hPV8FDZXrhRWoBPnV/
 IeASfLGAR0kAlpyP6H8ZdsF2wCBjQM3FGiKu54jh2bzDoVHBZgQElQUyo7txFGiZpsaO
 DB/mmfUB7bkUd48N8cQBsDj3qlE4NtIM79roFMKa1zqU/zbrPsCW1eNyrcy8MX4ommFL
 42QLdgXnskGCtgsx5WWeV09jk7OsXAJS42hThbGeTOCEY5XMVFd96yQmZykT/PWJArv6
 2pbfqGbCUPaY7/hix7fOgn5vV1MA8+EVkDJj+qrUS3waqIrLr9CBI0yDXkEjacpgx+Fn
 v5gA==
X-Gm-Message-State: AOJu0YwDznKwVajT1rxThsZfHVudTC/AvDTXMyxhEHdu27sGGggXrZj0
 sFEUK3vF6bBl4xRzhdUoY8VaHK7dhgS6gwcGZeqY7Q==
X-Google-Smtp-Source: AGHT+IGhKMEnHtF5wRsCjQCQcUWHxGXh4eFLkd9xOGMKAlAMQvYlgyRResZ5TExs8SYh2GGBYbK4UiHYp8325f+JSUw=
X-Received: by 2002:a05:600c:501e:b0:40b:5e21:ec0d with SMTP id
 n30-20020a05600c501e00b0040b5e21ec0dmr4621253wmr.63.1702506157463; Wed, 13
 Dec 2023 14:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
In-Reply-To: <20231213205634.GK2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 15:22:25 -0700
Message-ID: <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
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

On Wed, 13 Dec 2023 at 13:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 01:41:04PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 13 Dec 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> > > > Hi Ilias,
> > > >
> > > > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > > > > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> > > > > that already include such nodes.  However with some recent EFI changes,
> > > > > the majority of boards can boot up distros, which usually rely on
> > > > > things like dmidecode etc for their reporting.  For boards that
> > > > > lack this special node the SMBIOS output looks like:
> > > > >
> > > > > System Information
> > > > >         Manufacturer: Unknown
> > > > >         Product Name: Unknown
> > > > >         Version: Unknown
> > > > >         Serial Number: Unknown
> > > > >         UUID: Not Settable
> > > > >         Wake-up Type: Reserved
> > > > >         SKU Number: Unknown
> > > > >         Family: Unknown
> > > > >
> > > > > This looks problematic since most of the info are "Unknown".  The DT spec
> > > > > specifies standard properties containing relevant information like
> > > > > 'model' and 'compatible' for which the suggested format is
> > > > > <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> > > > > usually lacking the manufacturer so we can't use it for both
> > > > > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> > > > >
> > > > > So let's add a last resort to our current smbios parsing.  If none of
> > > > > the sysinfo properties are found, scan for those information in the
> > > > > root node of the device tree. Use the 'model' to fill the 'Product
> > > > > Name' and the first value of 'compatible' for the 'Manufacturer', since
> > > > > that always contains one.
> > > > >
> > > > > pre-patch:
> > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > System Information
> > > > >         Manufacturer: Unknown
> > > > >         Product Name: Unknown
> > > > >         Version: Unknown
> > > > >         Serial Number: 100000000bb24ceb
> > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > >         Wake-up Type: Reserved
> > > > >         SKU Number: Unknown
> > > > >         Family: Unknown
> > > > > [...]
> > > > >
> > > > > and post patch:
> > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > System Information
> > > > >         Manufacturer: raspberrypi
> > > > >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> > > > >         Version: Unknown
> > > > >         Serial Number: 100000000bb24ceb
> > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > >         Wake-up Type: Reserved
> > > > >         SKU Number: Unknown
> > > > >         Family: Unknown
> > > > > [...]
> > > > >
> > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > ---
> > > > > Simon, I'll work with tou on the refactoring you wanted and
> > > > > remove the EFI requirement of SMBIOS in !x86 platforms.
> > > > > Since this code has no tests, I'll add some once the refactoring
> > > > > is done
> > > > >
> > > > > Changes since v2:
> > > > > - Spelling mistakes
> > > > > - rebase on top of patch #1 changes
> > > > > Changes since v1:
> > > > > - Tokenize the DT node entry and use the appropriate value instead of
> > > > >   the entire string
> > > > > - Removed Peters tested/reviewed-by tags due to the above
> > > > >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 89 insertions(+), 5 deletions(-)
> > > >
> > > > Can we add a Kconfig to enable this?
> > >
> > > Why? This is the default option that we want moving forward in order to
> > > get the fields populated.
> >
> > The model name is fine. The manufacturer is in lower case (using the
> > DT vendor name), so not in the right format.
> >
> > It only populates two fields, so far as I can tell.
>
> Maybe we need to turn this discussion on its head slightly. What do you
> want to do to get SMBIOS fields to be widely populated with
> generally-correct information? What we have been doing has seen very
> little adoption so we need something else.

Well, who or what is actually using this info? Is the problem just
that it doesn't actually matter, so no one bothers? I'm just not sure.
The fact that on ARM you cannot pass it to the kernel without EFI
might be inhibiting its usefulness, too? Usefulness is the key
question for me.

Anyway, my suggestion (once we understand why we care about SMBIOS
tables) is patches like we just saw from rockpro64, perhaps even with
a few more fields filled out. This series seems like a backup for
board maintainers that don't care, which is fine, but we should at
least be able to disable it.

Regards,
Simon
