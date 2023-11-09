Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4737C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4138765C;
	Thu,  9 Nov 2023 22:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YiCWfyU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E7C87677; Thu,  9 Nov 2023 22:35:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3742E87507
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699565745; x=1700170545; i=xypron.glpk@gmx.de;
 bh=ZKMSXIiQJm6Zel/o9F/sMnqkHY4hETJz/W/v6bLHoSg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=YiCWfyU7pvl0juJiApJMn5sq8eXo4tEqk4eyrPZAVs1Y1hJI1Ifww2HseljwBsGC
 PvnBWLh5mWmwDJ+Usb+F5ppALiR7mZYpBPHVqyAG+SiiizhgyBt4mkdr0lZtvSWwg
 TNNFMgHxnuYiIDYjUdFFdBASMqWUDVnY7zb2WAh66xhNB88Fr+uteCAl7Q1Y/DFHZ
 L8w9VtW7nE5/RzJTpe5KzXjkqVi3csrq1mqzGFZRPW7seUlWzflRfJeP0ni8Kd/At
 +Y0yerQWuwSJvmnxgjN0resNtowg9Wb5NX5qLjE4NKsJ4LEHTeBJC5T0U2zGfKva8
 BamRZUvF47ZWpK926w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([65.132.165.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1rcSJU1XPF-00gDr6; Thu, 09
 Nov 2023 22:35:45 +0100
Date: Thu, 09 Nov 2023 14:35:40 -0700
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>
CC: Sean Edmond <seanedmond@linux.microsoft.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
User-Agent: K-9 Mail for Android
In-Reply-To: <20231109210440.GJ6601@bill-the-cat>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
 <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
 <20231108002342.GE6601@bill-the-cat>
 <CALeDE9NBpwUXcuURx-JKsRNS4C+6OBTz8Nfi76kRY_3ZSays7g@mail.gmail.com>
 <20231109210440.GJ6601@bill-the-cat>
Message-ID: <44F1509A-E73F-4DE5-8885-17025FCD5E18@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EepnjWpQZVwd2coGP86xeaZt/bbMPpZT/0x0IJSf82c53Ia9SDP
 GQdPxNOc1AlAHZ+P7HOm7JlGEEoy/DHVZB0YjsV53XZGlB+2cOslsNoQKweXf2RPrlkIOlh
 vc2yFUlB/3bXoUbdgG4QPsjJgYcWdZrfrtcUoUPk/+MSV3uoR2pJzQsYwhquj+V0vfamU8n
 cc6UduqX4I3l8Y1hfFbGg==
UI-OutboundReport: notjunk:1;M01:P0:/Dk9wb4fymk=;5cAibE7wE8lZ6w/F2IDw01ZyBI9
 +DZLsV2G35mPio98vfYttAyTG2lCFGhDZMy91kJU31oeHbS/7XArXhAVECm4VhrAT2bhw9fHN
 eJrKpPwnUz6HqeIKzyAGk6ONlX3/bMgwCaup09uT/94LsQtxiRM9pHUM7FlGLfC8V4ZVtX3A7
 wjObomFq0ymNF/gYQ/mGpaTgemg+FCFZsd2RFchFqV9YyhHP+HhN/wLLn6rv/fqCDo0O0cHUb
 Cdd5f0SHNhBf3m4RtvcTztlfdDSTbvY+QtpHDhC1GXlYii2K9Z02vcvgvbhoIW/QgsMOyfYrI
 BOgg8ZaxgpLoYjMxplMWYJhaRwNn1OPFCgHwvFEZNd2tpLv33cDPtbzxydg2UqNawhIXY3uuJ
 g8QaMT4GKvfG+h/LYiJX5v4/65oWKp3WlIuTBDcXKS7MSR9v7rJsWdFDO0f+cimFsmlZ0lePM
 u/1QG9ChE5hmK53iOwRAAx2X5AIdVtOhZI4Qqltx5aocBjTcO2FJyysTO7Qzs3oavQ8wO+LDH
 kwWFayAU8ezEWLj1kSrrROT3JYlbZ4+hCKvswY0Mp3RDpe4iP4ANjBPHWjfhajrgxigwvFIAs
 ctmHe5It1m6m/I5XsfYscyWKbWJEUWYCT5aKz4zuBIdlHoFBv4iHsZp/+3LUjY7QnhSVKsUZn
 Cl5RZOlyOrQ1o7c7KUuzXbKp4tYa3KtCwYS7QdFi4TsI+w2k9LL0ZjDdlUt8G8J1DfMCz5OsW
 QsG8sKQLY1RgI7HUXYgdT4DnSHqTjaibQzGkI1L2YfqAlouMaXpKCGnmMxCk+LAn+VF/ERdg3
 KZA4EuYQD/wNllpqozoZ61OE0VpZ5vb0F7T11IKg3iaSye8oqOnbbcAN4oxS3h5KedE3NtkFw
 /SGofa3jHD5NuoMjll+QwVyD00uR1JvxmWDjwT1YFHA1w4IWiPCYMUf04+uIuB1Ic1b5+8A8v
 P6GpvQ==
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



Am 9=2E November 2023 14:04:40 GMT-07:00 schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>On Wed, Nov 08, 2023 at 12:24:24PM +0000, Peter Robinson wrote:
>> > > > > > > Allow dhcp server pass pxe config file full path by using o=
ption 209
>> > > > > > >
>> > > > > > > Signed-off-by: Sean Edmond <seanedmond@microsoft=2Ecom>
>> > > > > > > ---
>> > > > > > >   cmd/Kconfig |  4 ++++
>> > > > > > >   cmd/pxe=2Ec   | 10 ++++++++++
>> > > > > > >   net/bootp=2Ec | 21 +++++++++++++++++++++
>> > > > > > >   3 files changed, 35 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
>> > > > > > > index 5bc0a92d57=2E=2Eadbb1a6187 100644
>> > > > > > > --- a/cmd/Kconfig
>> > > > > > > +++ b/cmd/Kconfig
>> > > > > > > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
>> > > > > > >       default 0x15 if ARM
>> > > > > > >       default 0x0 if X86
>> > > > > > >
>> > > > > > > +config BOOTP_PXE_DHCP_OPTION
>> > > > > > > +    bool "Request & store 'pxe_configfile' from BOOTP/DHCP=
 server"
>> > > > > > > +    depends on BOOTP_PXE
>> > > > > >
>> > > > > > Why should this be disabled by default?
>> > > > > >
>> > > > > > Do we really want a separate config variable?
>> > > > > >
>> > > > > I expect most won't use this option to get the file path (they'=
ll use
>> > > > > the default paths as per the PXE specification)=2E  It makes mo=
re sense
>> > > > > for me to keep it optional, like many of the other options?
>> > > >
>> > > > RFC 5701 seems to require this option=2E Hence we should make it =
default
>> > > > yes=2E Boards that have a build size issue can opt out=2E
>> > >
>> > > The PXELINUX specification
>> > > (https://wiki=2Esyslinux=2Eorg/wiki/index=2Ephp?title=3DPXELINUX) d=
oesn't state that
>> > > option 209 is required=2E In the abense of option 209, PXELINUX wil=
l try the
>> > > following default configuration files (this example is provided on =
the wiki
>> > > link):
>> > >  /mybootdir/pxelinux=2Ecfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
>> > >  /mybootdir/pxelinux=2Ecfg/01-88-99-aa-bb-cc-dd
>> > >  /mybootdir/pxelinux=2Ecfg/C0A8025B
>> > >  /mybootdir/pxelinux=2Ecfg/C0A8025
>> > >  /mybootdir/pxelinux=2Ecfg/C0A802
>> > >  /mybootdir/pxelinux=2Ecfg/C0A80
>> > >  /mybootdir/pxelinux=2Ecfg/C0A8
>> > >  /mybootdir/pxelinux=2Ecfg/C0A
>> > >  /mybootdir/pxelinux=2Ecfg/C0
>> > >  /mybootdir/pxelinux=2Ecfg/C
>> > >  /mybootdir/pxelinux=2Ecfg/default
>> > >
>> > > If 209 is requested/provided it tries the provided "config file" be=
fore the
>> > > default paths=2E  RFC 5071 should be seen as an extension for PXELI=
NUX (not a
>> > > requirement)=2E  RFC 5071 only states "The Config File Option MUST =
be supplied
>> > > by the DHCP server if it appears on the Parameter Request List"=2E
>> >
>> > We also want to be careful about overall size growth on common option=
s,
>> > even if someone can opt-out=2E Those are usually last-ditch stop-gaps=
 and
>> > it's better to make sure we really need functionality X/Y/Z by defaul=
t,
>> > for everyone=2E Especially with all of the work going on to make HTTP=
(s)
>> > based network installs a viable option, how much more do we want to
>> > change the PXE case, for everyone=2E I'm personally somewhat looking =
for
>> > the use case to be well defined for a "this must be default"=2E Netwo=
rk
>> > provisioning is a thing, yes, but for whom/what, and in turn how broa=
dly
>> > do we need this to be in the vast majority of our boards (since it wo=
uld
>> > come in via BOOT*DEFAULTS or DISTRO_DEFAULTS)=2E
>>=20
>> If PXE is being enabled I think it's useful in that it means the PXE
>> client can be largely stateless because it can all be provided by
>> central netowork configs as opposed to either hard wiring it into
>> firmware or someone having to manually set them=2E This is likely also
>> useful from the PoV less reasons to have a shell if it can be dealt
>> with in code=2E
>>=20
>> From the PoV of defaults, with or without HTTP boot, I suspect it
>> probably makes sense to review whether PXE as a whole is enabled by
>> default=2E That said a number of silicon vendors are actually actively
>> removing PXE from their reference FW in favour of HTTP Boot due to
>> security and a number of other reasons (easier for firewalls,
>> caching/CDN, edge use cases outside of the data centre)=2E
>
>I guess I don't understand how frequent a use case PXE boot is, on the
>types of platforms U-Boot is usually found on=2E Clearly, some people and
>usecases use it=2E But I also think part of why it's default enabled
>within the "distro" frameworks is because initially we didn't have
>"parse extlinux=2Econf" entirely split from "do pxeboot" as the conf file
>parsing started there=2E I guess just something to evaluate down the road=
,
>and perhaps make it a regular thing to evaluate defaults and provide
>some notice when we might disable features=2E
>

For security reason it is preferable to disable PXE boot if it is not real=
ly needed=2E So default no would make sense=2E

Best regards

Heinrich


