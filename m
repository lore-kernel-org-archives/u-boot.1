Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C99C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 03:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390AE879B5;
	Thu, 14 Dec 2023 04:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="df8Dl1wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2CA879BD; Thu, 14 Dec 2023 04:19:32 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992A38797D
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 04:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33642523623so909652f8f.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 19:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702523969; x=1703128769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EPxLHvz4jUBR9sn6RsDyaPq1VtFHoJXjqAMYkR9PJ88=;
 b=df8Dl1wcjWVOrg6pBWOPWFMMxzJsBfKdiwV56oyjboJCXC0OhKE80BJ5lyTyUjIkFd
 AcpMAoQIcsG8UWmDn/V8UxIvdopWzxjH/anhr0kCJQQsQlqvah8FS4TuKaYsPMVDaxbV
 K5zBVFTFZoh/cEiM/2saFVx+8Jxq4pZcTfxnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702523969; x=1703128769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EPxLHvz4jUBR9sn6RsDyaPq1VtFHoJXjqAMYkR9PJ88=;
 b=JTtElX0cjEC7BnSPKISWra2wKcsf0cLfsBhwV9YKoXpe7eSlvJafxU0w/Ah3rzSAfl
 pJiiSaRrrcj/jUk954Rx3G7w5Mg1g0sceQLPfrV7DH2GT5gMnE6NG5WDc8ORBfKVsqCz
 L+zFOETI++sI0YqfXKob+zBtuAAOovhIQAi3oYADFTQBn/rxakexdu2fsSNcWz+gxfXN
 VrJW6sTbHWTOF5CWaz4kn7UW063YDYJbX82BGAsBFrDP+lSvHosKJNTwpGh/w6QGU9vT
 h1i/Z/SfIr8KRc+doh13zzmSz8Z8JXZE4qyjbpnN3C9ODBOnOPEnofX8Gh0gBkHFYmpP
 VTrw==
X-Gm-Message-State: AOJu0Yz+ZHrUUditRDesppS9kuEYVA8IrKPbw9FkIg1XdLpr8obHeHKt
 kG3HgsIEVJfyyAqAEQkty5Mvbl8ZAK74d+9fgRV3RQ==
X-Google-Smtp-Source: AGHT+IESPqT3bhxcpP4VQUn27MJBMLRCZ9L9ZotQJWWJvzIanu6/cnttF2xW/8RiWxbR7pDv5C+yo5dgGiM09Zujdtk=
X-Received: by 2002:a05:600c:827:b0:40b:5e59:ea13 with SMTP id
 k39-20020a05600c082700b0040b5e59ea13mr4391388wmp.178.1702523968680; Wed, 13
 Dec 2023 19:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
In-Reply-To: <20231213230545.GM2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 20:19:11 -0700
Message-ID: <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
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

On Wed, 13 Dec 2023 at 16:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 03:22:25PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 13 Dec 2023 at 13:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 01:41:04PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 13 Dec 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > > > > > > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> > > > > > > that already include such nodes.  However with some recent EFI changes,
> > > > > > > the majority of boards can boot up distros, which usually rely on
> > > > > > > things like dmidecode etc for their reporting.  For boards that
> > > > > > > lack this special node the SMBIOS output looks like:
> > > > > > >
> > > > > > > System Information
> > > > > > >         Manufacturer: Unknown
> > > > > > >         Product Name: Unknown
> > > > > > >         Version: Unknown
> > > > > > >         Serial Number: Unknown
> > > > > > >         UUID: Not Settable
> > > > > > >         Wake-up Type: Reserved
> > > > > > >         SKU Number: Unknown
> > > > > > >         Family: Unknown
> > > > > > >
> > > > > > > This looks problematic since most of the info are "Unknown".  The DT spec
> > > > > > > specifies standard properties containing relevant information like
> > > > > > > 'model' and 'compatible' for which the suggested format is
> > > > > > > <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> > > > > > > usually lacking the manufacturer so we can't use it for both
> > > > > > > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> > > > > > >
> > > > > > > So let's add a last resort to our current smbios parsing.  If none of
> > > > > > > the sysinfo properties are found, scan for those information in the
> > > > > > > root node of the device tree. Use the 'model' to fill the 'Product
> > > > > > > Name' and the first value of 'compatible' for the 'Manufacturer', since
> > > > > > > that always contains one.
> > > > > > >
> > > > > > > pre-patch:
> > > > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > > > System Information
> > > > > > >         Manufacturer: Unknown
> > > > > > >         Product Name: Unknown
> > > > > > >         Version: Unknown
> > > > > > >         Serial Number: 100000000bb24ceb
> > > > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > > > >         Wake-up Type: Reserved
> > > > > > >         SKU Number: Unknown
> > > > > > >         Family: Unknown
> > > > > > > [...]
> > > > > > >
> > > > > > > and post patch:
> > > > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > > > System Information
> > > > > > >         Manufacturer: raspberrypi
> > > > > > >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> > > > > > >         Version: Unknown
> > > > > > >         Serial Number: 100000000bb24ceb
> > > > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > > > >         Wake-up Type: Reserved
> > > > > > >         SKU Number: Unknown
> > > > > > >         Family: Unknown
> > > > > > > [...]
> > > > > > >
> > > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > ---
> > > > > > > Simon, I'll work with tou on the refactoring you wanted and
> > > > > > > remove the EFI requirement of SMBIOS in !x86 platforms.
> > > > > > > Since this code has no tests, I'll add some once the refactoring
> > > > > > > is done
> > > > > > >
> > > > > > > Changes since v2:
> > > > > > > - Spelling mistakes
> > > > > > > - rebase on top of patch #1 changes
> > > > > > > Changes since v1:
> > > > > > > - Tokenize the DT node entry and use the appropriate value instead of
> > > > > > >   the entire string
> > > > > > > - Removed Peters tested/reviewed-by tags due to the above
> > > > > > >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > >  1 file changed, 89 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > Can we add a Kconfig to enable this?
> > > > >
> > > > > Why? This is the default option that we want moving forward in order to
> > > > > get the fields populated.
> > > >
> > > > The model name is fine. The manufacturer is in lower case (using the
> > > > DT vendor name), so not in the right format.
> > > >
> > > > It only populates two fields, so far as I can tell.
> > >
> > > Maybe we need to turn this discussion on its head slightly. What do you
> > > want to do to get SMBIOS fields to be widely populated with
> > > generally-correct information? What we have been doing has seen very
> > > little adoption so we need something else.
> >
> > Well, who or what is actually using this info? Is the problem just
> > that it doesn't actually matter, so no one bothers? I'm just not sure.
>
> Users are using this information. Peter has explained that Fedora has
> been carrying Ilias' original version of this patch since it was posted
> so that bug reports say (something close enough and that can be tracked
> down) what device they're on, rather than "Unknown" / "Unknown Product".

Unfortunately I failed to get the latest Fedora running on rpi4. Is
this the only ARM board it supports a download for? (I must be missing
something)

Anyway, so this presumably requires EFI? If so, this is the kind of
vertical integration and legacy promotion that really frustrates me.
If not, then what is the mechanism to supply SMBIOS to user space?

I believe we have been here before, too. What program is used to
collect the bug reports? Is it sos, perhaps?

>
> > The fact that on ARM you cannot pass it to the kernel without EFI
> > might be inhibiting its usefulness, too? Usefulness is the key
> > question for me.
>
> I'm setting aside the discussion of how one will tell the kernel where
> the SMBIOS is, outside of EFI as it's not a U-Boot problem and belongs
> on other lists.

OK, but in my mind this is a concern.

>
> > Anyway, my suggestion (once we understand why we care about SMBIOS
> > tables) is patches like we just saw from rockpro64, perhaps even with
> > a few more fields filled out. This series seems like a backup for
> > board maintainers that don't care, which is fine, but we should at
> > least be able to disable it.
>
> The issue is that this series adds, for free, useful and sufficiently
> correct information in the common cases. The "for free" is a huge
> feature too. Drawing on the rockpro64 patch, I would suggest seeing if
> /version (or /hardware-rev or whatever) is something Rob is interested
> in adding so it can be something filled out or not and then pulled from
> DT instead of a new set of DT nodes that look a whole lot like the
> existing DT nodes and properties that already exist.

The new DT nodes / SMBIOS binding [1] allows for the correct
information to be provided, though.

I'm fine with this as a Kconfig option, but it is a hack. It purports
to provide SMBIOS info but (for both of the two fields it fills in) it
is not in the correct format. It only works with EFI. If someone comes
along and adds the proper info for a board, the name will change in
the bug reports.

Which system-info tool is used? I see that hardinfo records the model
[2] and produces a sensible name for the compatible string [3].

Regards,
Simon

[1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/sysinfo/smbios.txt
[2] https://github.com/lpereira/hardinfo/blob/master/modules/devices.c#L547
[3] https://github.com/lpereira/hardinfo/blob/master/modules/devices/arm/processor.c#L433
