Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D44DC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3812D803CC;
	Tue, 11 Feb 2025 15:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=arnaud.patard@collabora.com header.b="CnyiRqV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D49E8043C; Tue, 11 Feb 2025 15:26:39 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D7780077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.patard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739283993; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WUjH1xIncR4nSVuw/JxGcmLX1A3xctdhHu5uOyxn8Zf2lugYv7eRDlkHQEUt14BoZdTsKBRMnDwTTactXgKpKHcwaw3EaQW6GeYkiXkHW+5npLonx9i2CU5THi3yIg4Lx0SfOQKJk7YADf9Pb80IBAXQeJtd91UrIUoEzvJAjLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739283993;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ze/AkniVdGaSv9WPQeg1913fZBQwrhuG3wdEKy0X77A=; 
 b=U8aOho4QWYQLa2n6cJCFtk9Cu9bs8kUNGCEfljqbMXsQ7zMQm/AxYfExUa9GTVLjiuWAAxtp0XryMSH1kDczDHwVEUMERZfl+kx/jxelRs5gzLZR1Y9+PxMl8JWLQAVj6o54IBvVtg2LqUfQUVjo26NPVnaPIqA0mf0OCg56Cwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=arnaud.patard@collabora.com;
 dmarc=pass header.from=<arnaud.patard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739283993; 
 s=zohomail; d=collabora.com; i=arnaud.patard@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=Ze/AkniVdGaSv9WPQeg1913fZBQwrhuG3wdEKy0X77A=;
 b=CnyiRqV/ljZx7wqkaIgRuQe9640MM+IbVD10J0H3hGo9IXeMq1XPV0do6IXnUW/O
 U8LXvnMp7QeP6f+lT9Cli32IDKqnyHL3leTtdToGgImJZYhEby9KDKdh0f13lDlkYfU
 f6cx6FgDngx0s5L0Bef+HRgXbZrQgqWK8sKhWX98=
Received: by mx.zohomail.com with SMTPS id 1739283990426243.832476464705;
 Tue, 11 Feb 2025 06:26:30 -0800 (PST)
Message-ID: <3a5c03632aa3bab566c5e422b0bb3d530d603129.camel@collabora.com>
Subject: Re: [PATCH 1/6] drivers/Makefile: Fix TPL build with dwc3 generic
From: Arnaud Patard <arnaud.patard@collabora.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Tue, 11 Feb 2025 15:26:27 +0100
In-Reply-To: <efa4de89-4f91-41a2-ae67-380608979f7f@cherry.de>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
 <20250210155158.GH1233568@bill-the-cat>
 <307b64aaf037c16efde86ceb0b43d7a3d6db14c4.camel@collabora.com>
 <efa4de89-4f91-41a2-ae67-380608979f7f@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hi,

On Tue, 2025-02-11 at 14:50 +0100, Quentin Schulz wrote:
> Hi Arnaud,
>=20
> On 2/11/25 9:51 AM, Arnaud Patard wrote:
> > On Mon, 2025-02-10 at 09:51 -0600, Tom Rini wrote:
> > > On Mon, Feb 10, 2025 at 03:29:58PM +0000, Arnaud Patard wrote:
> > > > When building TPL with DWC3 generic enabled, the following
> > > > error is
> > > > occuring:
> > > > aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
> > > > function `dwc3_glue_bind_common':
> > > > .../drivers/usb/dwc3/dwc3-generic.c:527: undefined reference to
> > > > `usb_get_dr_mode'
> > > > .../drivers/usb/dwc3/dwc3-
> > > > generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation
> > > > truncated to fit: R_AARCH64_CALL26 against undefined symbol
> > > > `usb_get_dr_mode'
> > > > aarch64-linux-gnu-ld.bfd: .../drivers/usb/dwc3/dwc3-
> > > > generic.c:529:
> > > > undefined reference to `usb_get_dr_mode'
> > > > .../drivers/usb/dwc3/dwc3-
> > > > generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation
> > > > truncated to fit: R_AARCH64_CALL26 against undefined symbol
> > > > `usb_get_dr_mode'
> > > > aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
> > > > function `dwc3_glue_probe':
> > > > .../drivers/usb/dwc3/dwc3-generic.c:683: undefined reference to
> > > > `usb_get_dr_mode'
> > > > .../drivers/usb/dwc3/dwc3-
> > > > generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation
> > > > truncated to
> > > > fit: R_AARCH64_CALL26 against undefined symbol
> > > > `usb_get_dr_mode'
> > > > make[1]: *** [scripts/Makefile.xpl:544: tpl/u-boot-tpl] Error 1
> > > > make: *** [Makefile:2137: tpl/u-boot-tpl] Error 2
> > > >=20
> > > > Enable building drivers/usb/common.c in TPL.
> > > >=20
> > > > Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> > > > ---
> > > > =C2=A0=C2=A0drivers/Makefile | 1 +
> > > > =C2=A0=C2=A01 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > index 0e1f58c515b..7cee5750396 100644
> > > > --- a/drivers/Makefile
> > > > +++ b/drivers/Makefile
> > > > @@ -78,6 +78,7 @@ endif
> > > > =C2=A0=C2=A0ifdef CONFIG_TPL_BUILD
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) +=3D ddr/fsl/
> > > > +obj-$(CONFIG_USB_GADGET) +=3D usb/common/
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0endif
> > >=20
> > > Do we really need DWC3 in TPL?
> > >=20
> >=20
> > No, not really but I failed at finding a way to not get DWC3 built
> > for
> > TPL. I tried to modify the Kconfig files with no success. So, I
> > took a
> > different approach.
> > For DFU over SPL, it's obviously only needed in SPL for DFU and in
> > u-
> > boot proper.
> >=20
>=20
> Would=20
> https://lore.kernel.org/u-boot/20250211043335.92538-1-naoki@radxa.com/T/#=
m15a3058ef1ec8afb76528e1ed3edf864c8a77ef0
> =C2=A0
> help?

Yes, I've seen it this morning. After testing, looks like it's fixing
the issue I was having.

Arnaud
