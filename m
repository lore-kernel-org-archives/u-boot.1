Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA23D3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B10E83B27;
	Thu, 22 Jan 2026 14:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="dL0KjwLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F9483A1E; Thu, 22 Jan 2026 10:43:37 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d501])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D5980077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2646:0:640:add0:0])
 by forward501d.mail.yandex.net (Yandex) with ESMTPS id 675D382C37;
 Thu, 22 Jan 2026 12:43:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id MhYWTEIGuCg0-ug1U5TzZ; 
 Thu, 22 Jan 2026 12:43:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1769075012; bh=iYzEALBYukdeCZm6yPuihI0rnCP2blru9tF9y1KPY9s=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=dL0KjwLv+g4JDIvN+2vKS6Ha4T4kZh4T18YpDPLMMEBs3xDcwTJ1SDKKAlRAqayuZ
 HFH/HdPeH3d075JMLUtVCXvqG/oSmUGe1Wv6ay13VN0sA4qs4YJwmDZUfV3OhTLH7y
 TwQG3jGZxrf7D8stc0aTtFmPzAjniu0kYPru1Cf8=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <0e10d672c1cc068a1d68b5dc237b594a0a07d227.camel@maquefel.me>
Subject: Re: [RFC] opensbi options from FIT image?
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: afd@ti.com, ycliang@andestech.com, alpernebiyasak@gmail.com, 
 anup@brainfault.org, linux@yadro.com, mr.nuke.me@gmail.com,
 n.shubin@yadro.com, 	sjg@chromium.org, u-boot@lists.denx.de
Date: Thu, 22 Jan 2026 12:43:24 +0300
In-Reply-To: <f65aa26d-6c98-4b08-a94a-1e56f6871d1e@mobileye.com>
References: <f65aa26d-6c98-4b08-a94a-1e56f6871d1e@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
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

Hello Vladimir!

Thank you for sharing this!

On Wed, 2026-01-21 at 17:21 +0200, Vladimir Kondratiev wrote:
> Hi all,
>=20
> After commit aa0eda17cf98 ("spl: opensbi: convert scratch options to
> config") it is possible
> to specify options for the opensbi, as in struct fw_dynamic_info
> "options", in config file.
> It is better than hard coded value but still, it is fixed at the
> compile time.
>=20
> Can we have this options set at image load time? This would help to
> enable, for example,
> opensbi debug prints at the runtime. I see an option to do so in FIT
> image, by adding
> property like "opensbi_options" to the opensbi image node or to the
> configuration node.
>=20
> While bootloader usually flashed on some raw partition and it is not
> that easy to
> recompile and re-flash it for every run, OS FIT image can be stored
> on the partition
> formatted with some filesystem so changing FIT image is easy. Also,
> if it is only
> matter of changing .its file and re-run "mkimage", whole process of
> changing opensbi
> options became easy.

Generally, I like the idea. However, there are some issues we need to
consider... See below.

>=20
> I see even more value in this for u-boot proper, if we teach it to
> run in M-mode, so
> for developer boot sequence can be
>=20
> PBL -> u-boot SPL -> u-boot -> opensbi -> linux

Not this, but:

PBL (M-Mode) -> u-boot SPL (M-Mode) -> OpenSBI (M-Mode) -> u-boot
Proper (S-Mode) -> linux (S-Mode)

OpenSBI is earlier in chain than U-boot Proper, so additional options
can be passed only via U-Boot SPL.

>=20
> where u-boot will enable network and load FIT image from TFTP; then
> changing opensbi flags
> will be matter of seconds
>=20
> Examples, proposed modification marked with "=3D=3D>":
>=20
> for opensbi image node:
>=20
> opensbi {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	description =3D "OpenSBI fw_dy=
namic Firmware";
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	data=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D /incbin/("fw_dynamic.bin");
>=20
> 	type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "firmware";
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	arch=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D "riscv";
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	os=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "opensbi";
> =3D=3D>	opensbi_options =3D=20
> <2>; // SBI_SCRATCH_DEBUG_PRINTS

"opensbi-options" looks more like Device Tree to me. Also if we refer
type as "firmware" may be naming it "firmware-options" is more
convenient.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compression =3D "none";
>=20
> 	load=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D <0x8 0x00100000>;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	entry=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D <0x8 0x00100000>;
>=20
> };
>=20
>=20
> for configuration node:
>=20
> config-1 {
>=20
> 	description =3D "config-description";
>=20
> 	kernel =3D "linux";
>=20
> 	firmware=C2=A0=C2=A0=C2=A0=C2=A0 =3D "opensbi";
>=20
> =3D=3D>	opensbi_options =3D <2>; // SBI_SCRATCH_DEBUG_PRINTS

Same here "firmware-options".

If you are using it in three places what is supposed priority ?

Recently similar issue was solved by Alexander Sverdlin for linux
bootargs btw:

https://patchew.org/linux/11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gm=
ail.com/

So order can be SPL_OPENSBI_SCRATCH_OPTIONS -> opensbi node -> config
node.

> 	ramdisk=C2=A0=C2=A0=C2=A0=C2=A0 =3D "initrd";
>=20
> 	fdt =3D "fdt-1";
>=20
> 	loadables =3D "linux", "initrd";
>=20
> };
>=20
>=20
> Comments?
>=20
> Thanks, Vladimir
