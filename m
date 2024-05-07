Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3356C25B75
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 13:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0930B88784;
	Tue,  7 May 2024 15:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="OdfV+ycO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0633886D1; Tue,  7 May 2024 15:26:34 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5CE88778
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 15:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-61df903aa05so34259727b3.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1715088390; x=1715693190;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vcAlsYR+ZBX4KKujostuJc6RbWI9ZcTBUfszA8SFpYA=;
 b=OdfV+ycOyY+agLeOjbDBSF78P9WIVq4aOgLwXAyYqXjCH+Bk4VJdyrNnSRYDez/CDk
 JfweZ1uWAKfpKx6gy/O7iZ3NJWH2fURvpAkbGsyeVfZyrVbYc4+IWVrY3cNCebu6fTOy
 f9KNpy2SOW9lhxy0PnMpg3JEJG0+d/thhcVfJP9A3E/HHFGXHTePF12+Qtsi0BsBVEhI
 qc4yWrSDYDZOwuvcZR5GaIGxUu97K3gnZrB7zbIRpAGoFJkyq3EbkYbgTKHRH24p1epY
 rVq34MVJ/xc72EIYdVIJKL4EmOMY7166S0emZKotkE9K0VI4lwmN9tVh0XWcRXTEWx/I
 2FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088390; x=1715693190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcAlsYR+ZBX4KKujostuJc6RbWI9ZcTBUfszA8SFpYA=;
 b=vbml93O46BLF9XwlSIz2NJGa5CN0erwIxwzEJtZXtKl5b4s/KTdYOsWliCZNUv0V9o
 jjlmigV52Wz64EMqWqK6+2oamhfjFhS1oG7VTCYnZIaryfmpfYEBfJ+9lyj9TASXtik9
 6DgjteoGLbMp0J75Yc+yEIXQNkB6p23Lbu0M4/u5tIp7Q5ApkCvVXFj7cg7KlkC479on
 s1oB1Zyiv8J8Xlzn556L1Hv0EecINzx92UhEQo/YOOY6TNOjudqqQgKXkxSpAH8Gkfth
 m2xQtD9m3GzEf5NgxMOr0O0x3F+FgwoZmQ+R2TZqmfJm+D78vnojUZgTN90i5m71EW/w
 gmqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEGVdNwtJc0F35Pfg3j0dd14zeaf8gL/UHZhqeSZUFFz/dJR6aIi3PqVk9tbJNyeh0IXm7e5CVkiZGfvVW9kvsrBqjHg==
X-Gm-Message-State: AOJu0YzYgMF+VGhgjfk6G47So0U6KoJe5mqF1DQygwikzoPN9j+ZaGSI
 78Y+1EoL5avdeomp3Zk5wBsfjprESHti5DPchGD2K7vm6fHFl0c4WXDPm/VvlCvjMFKwnqj8IWW
 IkOCIhN9XRNGe2Dip//EeWGpsBLKNpwubThFt
X-Google-Smtp-Source: AGHT+IFvB2i7clbEc5r+eacaJjLGUMEZgcDT+TH9iryUI3dYU6+TH13t6uggIMcGb6xrCRWKU1Lh5eiUTClvM4N7Bvo=
X-Received: by 2002:a81:af09:0:b0:615:800d:67b2 with SMTP id
 n9-20020a81af09000000b00615800d67b2mr13939511ywh.29.1715088389252; Tue, 07
 May 2024 06:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
 <20240503201842.GA2560583@bill-the-cat>
 <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
 <20240507132001.GR2568172@bill-the-cat>
In-Reply-To: <20240507132001.GR2568172@bill-the-cat>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 7 May 2024 15:26:18 +0200
Message-ID: <CAHTX3dJ3ZyUs4r4POKG7m0Ud6hCLW4bH9rwTFW1oABdtYL3qLg@mail.gmail.com>
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
To: Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, michal.simek@amd.com,
 git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

=C3=BAt 7. 5. 2024 v 15:20 odes=C3=ADlatel Tom Rini <trini@konsulko.com> na=
psal:

> On Tue, May 07, 2024 at 11:22:45AM +0530, Love Kumar wrote:
> >
> >
> > On 04/05/24 1:48 am, Tom Rini wrote:
> > > On Fri, May 03, 2024 at 05:39:46PM +0530, Love Kumar wrote:
> > >
> > > > Add tests for booting image using tftpboot/pxe boot commands,
> tftpboot
> > > > boot case loads the FIT image into DDR and boots using bootm comman=
d
> > > > whereas pxe boot cases downloads the pxe configuration file from th=
e
> > > > TFTP server and interprets it to boot the images mentioned in the p=
xe
> > > > configurations file.
> > > > This test relies on boardenv_* containing configuration values
> including
> > > > the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux
> till the
> > > > boot log pattern value is matched. For example, if the parameter
> > > > 'pattern' is defined as 'login:', it will boot till login prompt.
> > > >
> > > > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > >
> > > I'm not quite sure where the problem is, next. After enabling FIT ima=
ge
> > > support in my build so I can use the image I have on hand:
> > > U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
> > > Waiting for Ethernet connection... done.
> > > Using smsc95xx_eth device
> > > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > > Filename 'v6.6/image.fit.nocomp'.
> > > Load address: 0x200000
> > > Loading: ##################################################  82 MiB
> > >           3.2 MiB/s
> > > done
> > > Bytes transferred =3D 85984256 (5200400 hex)
> > > U-Boot> U-Boot> crc32 200000 $filesize
> > > CRC32 for 00200000 ... 054003ff =3D=3D> 754c839a
> > > U-Boot> U-Boot> bootm 200000
> > > ## Loading kernel from FIT Image at 00200000 ...
> > > Could not find configuration node
> > > ERROR -2: can't get kernel image!
> > > U-Boot>
> > >
> > > And in u_boot_boardenv_rpi_arm64.py:
> > > env__tftp_boot_test_skip =3D False
> > >
> > > env__net_tftp_bootable_file =3D {
> > >      'fn': 'v6.6/image.fit.nocomp',
> > >      'addr': 0x00200000,
> > >      'size': 85984256,
> > >      'crc32': '754c839a',
> > >      'pattern': 'Linux',
> > >      'config': 'conf-852',
> > > }
> > >
> > > But it's not trying to boot conf-852 but instead just passing the
> > > address. This image lacks a default config, which your example has an=
d
> I
> > > think is why the tests work in your case.
> > >
> >
> > Hi,
> >
> > Yes, this case expects to have some default config in fit image as it
> uses
> > 'bootm <addr>' command to boot, below change in fit image should work.
> >
> > configurations {
> >     default =3D "conf-852";
> >
> > test_net_tftpboot_boot_config - This case will boot from the given
> config:
> > 'bootm 200000#conf-852'
>
> I wasn't clear, sorry. The problem is that since we define the config to
> use, which is good, we need to then use it. I intentionally have a FIT
> image that supports every aarch64 platform and I'd rather use it for
> every platform and not a per-platform FIT image.
>

What about putting those two tests together? I mean if config is not
defined used default configuration,
if config is defined use it.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
