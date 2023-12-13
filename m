Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D3E87909;
	Thu, 14 Dec 2023 00:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="SwaCiU6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756FB878FF; Thu, 14 Dec 2023 00:14:25 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7445787909
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 55fb8f03-9a0d-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 55fb8f03-9a0d-11ee-b94e-005056992ed3;
 Thu, 14 Dec 2023 00:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=ReUcYqGu+mQHCz8Af5TEkxuSOTeUH1mo8T+ggMEk3RY=;
 b=SwaCiU6ZM1JRqsEUyLX+9lXJGTLOavCW2t+jSs1o20Sr1Nf+nze1eM1VEjYDqtSLQNYjlqAnQzqwE
 w8t63beywe80ziMGi7MaDa0HXu2XvgxUP+bRPKkdrk/hQ/V8D53Teki+rbIQ4Wd91CYpvFgfGy4LYz
 17kqP9ldJDH3ZCzeq6o+3G41PkgQCGkue7BJ1h2N+pFAP5UgX6bNsGTeantrAJiUmuJ2QekuccapQX
 mS8/cJObrPkJqelwVBlfd23tIIGgT19YwV39ovvLj+2A8Q+YhhuHHW2B59R2Jmd95CcHhmwTICkrVx
 GsmOv8EHcxFVFlSDqwtRE2D9VkT30TA==
X-KPN-MID: 33|aUz3iy15y5/fOsrr9p41RuGwWifgSN+kr9VxCeyR6DfnjXcKRWprP9YpaxCCYlu
 bfxlHB5Drep4b+m5jtjRhDH1XDXPp/wTqVuutW6YYS3I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|awvi+yb3bNEcCK8sojiU5RW7S74sf38rqUvzGfZ6loOEaOG8IU5pTdp+u7iKhoo
 BLWhb8X1gzKqxXd92Cpt+sw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 58cb0137-9a0d-11ee-ad2d-005056998788;
 Thu, 14 Dec 2023 00:14:21 +0100 (CET)
Date: Thu, 14 Dec 2023 00:14:20 +0100
Message-Id: <87wmth66gj.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org,
 sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, u-boot@lists.denx.de
In-Reply-To: <20231213205634.GK2513409@bill-the-cat> (message from Tom Rini on
 Wed, 13 Dec 2023 15:56:34 -0500)
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
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

> Date: Wed, 13 Dec 2023 15:56:34 -0500
> From: Tom Rini <trini@konsulko.com>
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

One possibility would be to have a script that maps the board
compatible to a vendor name using
Documentation/devicetree/bindings/vendor-prefixes.yaml

That would solve populating the manufacturer field, but not the
product_name unfortunately.
