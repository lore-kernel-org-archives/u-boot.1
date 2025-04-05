Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E69CC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A28A8215B;
	Sat,  5 Apr 2025 16:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AITzQTr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DD882A53; Sat,  5 Apr 2025 16:40:16 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38C382063
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-601a8b6c133so1774654eaf.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743864012; x=1744468812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ck02CWuqskEKt/dIH/AiOB23hW4reGGbROMh9mRXc/U=;
 b=AITzQTr8V8DZZqLEnzmNwT91e+ZY2rjZSo0IqPg1gOecqGIwUTD8JT/3cuCB2C/NO4
 TA0wCO4F2Z9Hm9qHe42b51nJa2MoLLQQ2i2xVPWJcQDZVxetiNf0VEvVlqc7o5bkj1KS
 G0cEYzJ3sX71Dic11t6/abt9/ffZLuTv87opU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743864012; x=1744468812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ck02CWuqskEKt/dIH/AiOB23hW4reGGbROMh9mRXc/U=;
 b=jeO/GdWzoHCo2rVGwBfaUxUpl1S9O7UJ49JWy1aF9A9D46Yb3wS6zfHjDY4ldK4+En
 /TDZthe78Nbodnab34ODgQP04x+of8Ew9wzEJ84TCv+Tn2ElXwXEnRDrCtavGF5Grei5
 VLNXDKI3AiQGKP3pU0LOjHf00tacwzhnCiPIaH2UAa8AsaNhz90VUEPx+ora1MY5egmk
 1qBo3MsNq1dyko7zmdyBkQ4UvrDYO6gIHohT7zqUOjeInAC/moi+wztwcj4tvC43Z1cO
 PehLGQtx2PnsY+L3zGiS39xqjHli/PgNLzGAoaVGRx3lNAK7ucZKzqgVho/7ADO82L1E
 g2mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX28eyAGXnax44JEb+omJQjFSu/ADgBHJtMCnTvpPR0PPIT4qJandtRlIMuWlJ0vLreUGFuV+8=@lists.denx.de
X-Gm-Message-State: AOJu0YzSSdAyuqiMy5ohRmJmCT3HfJ6ne6HyV1bBG2cY0dQlsnaXsIko
 P6N+prht5Co357CS/oQICdEamayPZJp7Fc1RTDaEwzv3PyDW7D9sIhCXJlVj/9I=
X-Gm-Gg: ASbGncs4e80DdiBT/sgaBqULg7xYxlamMYzQol9Fv8GrcKFX4H0MZVJfdV9v7orNgil
 BGjQ7IULLkGKhRz6iEjTBF5UXLPL1AuT/vZO3enTZtoScD7BFWrGTe1xCDsoEF9wYQhngsR4eKx
 ZxszSShfBETdNpofH55U6Wt9pXTQNEJJ6efJ+V7PfqFJ3u2a5NYbCMyCcC4DR08TN0jh6KiggOP
 UcNXm3oH6BUGKDSFpXG4Z0z6RRF9XKFpRfxHJL9aRLBXTtb3M8znOACLOUBoxgdR0fs1tChQ/t+
 lOndK/kTWOWpyzUQj3k/Zc2R/xvmtQdHW6hFuuMutovtpr/tax4Ve96tRuAet8V3RbXL4UyAe93
 +xDHg4CS5bQnHYN7p
X-Google-Smtp-Source: AGHT+IHMyQU6Xdr+nMV0ErwoUlAvk3CIiNzlJh/W285t2hqoSOET5pNXCAVk+50n/YPGvXWjKKnudA==
X-Received: by 2002:a05:6871:a4c2:b0:29e:1962:7a23 with SMTP id
 586e51a60fabf-2cc9ee4eb23mr3966535fac.4.1743864012377; 
 Sat, 05 Apr 2025 07:40:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8454c669sm1209548fac.3.2025.04.05.07.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:40:11 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:40:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
Message-ID: <20250405144008.GY5495@bill-the-cat>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HlsUNZdFvmHD7ocy"
Content-Disposition: inline
In-Reply-To: <20250404224801.GV5495@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
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


--HlsUNZdFvmHD7ocy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > Hi Simon,
> >=20
> > On 2025-04-04 00:30, Simon Glass wrote:
> > > Hi Jonas,
> > >=20
> > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >>
> > >> Hi Tom and Simon,
> > >>
> > >> On 2025-03-19 00:21, Tom Rini wrote:
> > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > >>>
> > >>>> This series includes some patches related to allowing read_all() t=
o be
> > >>>> used with the extlinux / PXE bootmeths.
> > >>>>
> > >>>> These patches were split out from the stb4 series, since it will n=
eed to
> > >>>> have additional patches for LWIP, to avoid breaking PXE booting wh=
en
> > >>>> LWIP is used.
> > >>>>
> > >>>> [...]
> > >>>
> > >>> Applied to u-boot/next, thanks!
> > >>
> > >> This series broke booting a compressed arm64 defconfig Linux kernel
> > >> (without module loading) due to changes in decompression buffer leng=
th.
> > >>
> > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 M=
iB
> > >> uncompressed.
> > >>
> > >> Before this series the decompression buffer was 10x the kernel_comp_=
size
> > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
> > >>
> > >> A broken boot using current next branch:
> > >>
> > >>   Retrieving file: /Image.gz
> > >>   Retrieving file: /initramfs.cpio.gz
> > >>   append: earlycon
> > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x0600=
0000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > >>   find_other type 2 os 5
> > >>   ## Flattened Device Tree blob at 3df16350
> > >>      Booting using the fdt blob at 0x3df16350
> > >>   Working FDT set to 3df16350
> > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > >>      Uncompressing Kernel Image to 8000000
> > >>   Error: inflate() returned -5
> > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > >>   Must RESET board to recover
> > >>   Resetting the board...
> > >>
> > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
> > >>
> > >>   Retrieving file: /Image.gz
> > >>   Retrieving file: /initramfs.cpio.gz
> > >>   append: earlycon
> > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x0600=
0000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > >>   find_other type 2 os 5
> > >>   ## Flattened Device Tree blob at 3df16430
> > >>      Booting using the fdt blob at 0x3df16430
> > >>   Working FDT set to 3df16430
> > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > >>      Uncompressing Kernel Image to 8000000
> > >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > >>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df .=
=2E. OK
> > >>   Working FDT set to 3cb3f000
> > >>
> > >>   Starting kernel ...
> > >>
> > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> > >=20
> > > Are you using the 'booti' command? Can you post a bit more console
> > > output or a script here as it isn't clear what boot command you are
> > > using? For now I'm going to assume booti
> >=20
> > Above was using an extlinux.conf with bootstd, not using the booti cmd.
> >=20
> > Use of booti cmd is not affected as it continue to use a 10x multiple
> > of the kernel_comp_size env var for buffer size.
> >=20
> > The change this series introduced was instead of the 10x multiple of
> > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB).
> >=20
> > And because cmd/booti.c was not converted there is now two different
> > handling of this decompression buffer size.
> >=20
> > If the change to now use SYS_BOOTM_LEN was intended this need to be
> > changed as it has mostly been irrelevant for booting Linux on AArch64
> > boards prior to this series.
>=20
> We need to clean things up such that the path which is using 10x
> multiple (and we lmb_alloc an area iirc) is used in all cases.

Looking at the code this morning, I was confusing this with what we do
for compressed FIT images, oops.

--=20
Tom

--HlsUNZdFvmHD7ocy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxQMgACgkQFHw5/5Y0
tyzfAgwAmi5ChiSazzTWCOLA0k5hx+7LnKRECu6VfKx5Ih+0MAOfuVyE7aNJbh7R
pFxa6L1v+fomrjOfhC1aX5yX8UBuojswAQ5oXx+ZCabsyTNugkf7WHq1tnMBwUTT
Mx34fwYSIKlVBykFphgxu7Ko6Hqb8dqEiwnyDFXTG9W7/JwNNIeyyOvqFC6br1Y0
Vw+gsO9tYtcATrpBmhbh07JJJL/6BHTwLtWTN16HqOmJ87XhCsCle4K7734++zCp
9m4U8bN8tt0YokK9ygXpehrqDev9Omx131SDYQY5zRtKVgJlz9tHh0Qpfp4u24uM
AQMgIMA/2Itg68LptOTHCn2ZsFMvK3JbXNve5qWhBoV4/OKwpw5rKYhmNU7lZm+9
V7VoQw/Vuw4ttQb50bVnCl/4tKo8+OGdQ2b/VmWJgWuNt04256lu8ZHfgFucZHFw
oll3Cmc3sw2XnfVuDc3lnw/s05TUBN6uQ2Y+9/uLFiKGHvnn9TvLTRDSEr7YJZ2G
GR/FaKpF
=CXND
-----END PGP SIGNATURE-----

--HlsUNZdFvmHD7ocy--
