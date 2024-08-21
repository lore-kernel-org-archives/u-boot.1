Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCABFC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 17:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E143A88B3F;
	Wed, 21 Aug 2024 19:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D27A88B6D; Wed, 21 Aug 2024 19:35:30 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936BE88A7E
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni246.in.jkvinge.net (ti0116a430-0074.bb.online.no
 [88.91.110.75]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 47LHZNnv014968
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 21 Aug 2024 19:35:24 +0200
Message-ID: <ff64557053d3f00d42c1b3a8c0d9237e870b30af.camel@opensuse.org>
Subject: Re: u-boot on raspberry pi with secure boot
From: Jonas Kvinge <jonaski@opensuse.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 21 Aug 2024 19:35:23 +0200
In-Reply-To: <311e1dd1-a887-461f-b984-bfc1807c63e6@linaro.org>
References: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
 <311e1dd1-a887-461f-b984-bfc1807c63e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=88.91.110.75;
 helo=ni246.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
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

On Tue, 2024-08-20 at 16:29 +0200, Caleb Connolly wrote:
> Hi Jonas,
>=20
>=20
> I don't know the details of how this is implemented, but the way to=20
> solve this is by doing EFI secureboot in U-Boot. The trick is to
> embed=20
> the securebook public key hash into U-Boot, there it will be
> validated=20
> by the bootrom stage and can be trusted to validate the signed kernel
> EFI.
>=20
> The kernel would then need to be booted as a "UKI" (refer to the uapi
> group uki docs), this embeds the kernel, ramdisk, and DTB into a
> single=20
> EFI image which can be signed and verified.
>=20
> Hopefully this points you in the right direction.
>=20

Thanks, this got me a bit further, I have managed to produce a UKI
using dracut on openSUSE, this is written as /boot/efi/EFI/Linux/linux-
6.10.5-1-default-69b6602716a8442d94a79481993e2ded.efi,
I verified that it works by copying it to
/boot/efi/EFI/BOOT/bootaa64.efi.
I've also signed it now following the instructions on
https://github.com/u-boot/u-boot/blob/master/doc/develop/uefi/uefi.rst
So it produced a signed file (/boot/efi/EFI/Linux/linux-6.10.5-1-
default-69b6602716a8442d94a79481993e2ded.efi.signed).
So the next step is to restrict booting to this signed efi file.
But I'm still not sure how to configure U-Boot to only accept to boot
EFI files with my certificate.
I don't see anywhere to configure that in 'make menuconfig', of course,
if I copy the files to the UEFI partition, someone could just replace
the .auth files.
Do I need to use FIT image like described on
https://trac.gateworks.com/wiki/secure_boot ?
In that case how do I configure the .its file to include the efi file
and the certificate instead of the kernel, ramdisk and fdt files
described in the wiki?

Jonas

