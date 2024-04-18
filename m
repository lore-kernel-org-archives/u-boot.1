Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4ECC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8694288691;
	Thu, 18 Apr 2024 20:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bc0bGwoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327138868E; Thu, 18 Apr 2024 20:13:12 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E323F87D8F
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-de47485532cso741461276.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713463989; x=1714068789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UGbhsnB4j/HhHkdmGEe7F2eMqCZUHqFXiyyPVBGSRZk=;
 b=Bc0bGwoe8lhHa3SPk/UXN+ULWBITgAHplCAhKkBzqvOJeePH7vQyRL5boffsAiCcMb
 D8n8cJLnbN+LIBICnnxjZVpTHhe+dYYSgVMgf8Gp9YyBwVqwxZSgXqjJf0k8Yk6scuZS
 CSVTan2nIs0izEW/e0G57H14OGONlwRxiF/mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713463989; x=1714068789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGbhsnB4j/HhHkdmGEe7F2eMqCZUHqFXiyyPVBGSRZk=;
 b=AmhUPV5J3Cf9OVePZ762K9rIFNHNZ9mnUilpBCK6cHnwaCKxPoV284wsmw37Tgbe3K
 QutC3O73FigjAxL7QPqI63rnrg3zFeryAHvf70K0JktDFhtRZ78zVfvDrq9ApxrvcxQH
 M/FqLX6Ojtf48H7gExp2VS59oJ4oXnjGCoAoIHyPvHcm0Q4TRRT2rWn/Re6a7RW6WCMQ
 MRi9EkaGsA3PdezSR5xi3E9gu09AiCfVEu425xmlVRIIcc7WLyKuD4wQ0+QRdICp80mR
 F44fxr0vOT0s+c6XOnqLfHOyCAdmAwxDdGrSndAp94WQihZ2GP9EaMaISsuOqvvXGV8t
 BSjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTifgq9vlvnHT7+MPupQ+gzpuGol9TrsPdfo6PnkAaJroHJ9SJDiuK4l9glxoExBRxLne7oNTFlU8C/rdRGC2Gqxy6+Q==
X-Gm-Message-State: AOJu0YyQSVnG/CEmnlPs/oEa+dS2zfzrZDWwWXlavaiqZPZVO02QDqqP
 65xLk/6LN4WoKaCxB+Nthu3QA1ZdzH7nF0bxXt2nXV7/B9TnXsPcMOg/NJOhGh8vk49Ntpa+o27
 QWyMeUA==
X-Google-Smtp-Source: AGHT+IEvsUJlbSNK5PNIM9gdVtfpFSvc8Pmy470ithltPNMINOWrn9A4AZYy3sFkZxVbmtTGRMtCXQ==
X-Received: by 2002:a25:e90d:0:b0:de0:f753:ad25 with SMTP id
 n13-20020a25e90d000000b00de0f753ad25mr3762753ybd.1.1713463988589; 
 Thu, 18 Apr 2024 11:13:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a0ce343000000b006a046fb192esm825449qvm.107.2024.04.18.11.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:13:08 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:13:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 00/16] pxe: Allow extlinux booting without CMDLINE
 enabled
Message-ID: <20240418181305.GI1054907@bill-the-cat>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <171279991820.196936.155872099351797064.b4-ty@konsulko.com>
 <50dfa3d6-a1ca-4492-a3fc-8d8c56b40b43@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oPr6HIH0awojahBO"
Content-Disposition: inline
In-Reply-To: <50dfa3d6-a1ca-4492-a3fc-8d8c56b40b43@kwiboo.se>
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


--oPr6HIH0awojahBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 06:58:03PM +0200, Jonas Karlman wrote:
> Hi Tom and Simon,
>=20
> On 2024-04-11 03:45, Tom Rini wrote:
> > On Thu, 14 Dec 2023 21:18:58 -0700, Simon Glass wrote:
> >=20
> >> This series is the culmanation of the current line of refactoring
> >> series. It adjusts pxe to call the booting functionality directly
> >> rather than going through the command-line interface.
> >>
> >> With this is is possible to boot using the extlinux bootmeth without
> >> the command line enabled.
> >>
> >> [...]
> >=20
> > Applied to u-boot/master, thanks!
> >=20
>=20
> This series is causing boot issues using extlinux in bootm_run_states():
>=20
>   ERROR: booting os 'Invalid OS' (0) is not supported
>=20
> Following extlinux.conf was used:
>=20
>   label linux
>   	kernel /Image.gz
>   	initrd /initramfs.cpio.gz
>=20
> Before this series booting works, bootm_run_states() is first called
> with states=3D0x1 (BOOTM_STATE_START):
>=20
>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /ex=
tlinux/extlinux.conf
>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>   1:      linux
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   bootm_run_states(): images->state: 0, states: 1
>   bootm_run_states(): images->os.os: 0
>   bootm_run_states(): images->os.arch: 0
>   bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
>      Uncompressing Kernel Image to 0
>   ## Flattened Device Tree blob at edef8410
>      Booting using the fdt blob at 0xedef8410
>   Working FDT set to edef8410
>   bootm_run_states(): images->state: 1, states: 1710
>      Loading Ramdisk to ecdfd000, end eceb274d ... OK
>   bootm_run_states(): images->os.os: 5
>   bootm_run_states(): images->os.arch: 16
>   boot_fn: 00000000eff2b83c, need_boot_fn: 0
>      Loading Device Tree to 00000000ecde8000, end 00000000ecdfc97f ... OK
>   Working FDT set to ecde8000
>=20
> After this series booting fails, bootm_run_states() is first called
> with states=3D0x1710.
>=20
>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part /ex=
tlinux/extlinux.conf
>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>   1:      linux
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>   bootm_run_states(): images->state: 0, states: 1710
>   bootm_run_states(): images->os.os: 0
>   bootm_run_states(): images->os.arch: 0
>   bootm_run_states(): boot_fn: 0000000000000000, need_boot_fn: 0
>   ERROR: booting os 'Invalid OS' (0) is not supported
>   Boot failed (err=3D-14)
>=20
> Looks like booti_start() -> bootm_run_states(bmi, BOOTM_STATE_START) is
> no longer called due to changes in this series.

I think the problem is with:
commit 6d803ec9cc757bda0c48f2fd419cb6878eab92c4
Author: Simon Glass <sjg@chromium.org>
Date:   Thu Dec 14 21:19:12 2023 -0700

    pxe: Allow booting without CMDLINE for bootm methods
   =20
    Use bootm_run() and booti_run() to boot rather than the command line.
    This allows extlinux to be used without CMDLINE being enabled.
   =20
    Collect any error but do not return it, to match the existing code.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
[snip]
@@ -641,23 +644,18 @@ static int label_run_boot(struct pxe_context *ctx, st=
ruct pxe_label *label,
 	if (!fdt_addr && genimg_get_format(buf) !=3D IMAGE_FORMAT_FIT)
 		fdt_addr =3D env_get("fdtcontroladdr");
=20
-	if (fdt_addr) {
-		if (!bootm_argv[2])
-			bootm_argv[2] =3D "-";
-		bootm_argc =3D 4;
-	}
-	bootm_argv[3] =3D (char *)fdt_addr;
+	bmi.conf_fdt =3D fdt_addr;
=20
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) !=3D IMAGE_FORMAT_INVALID &&
-            IS_ENABLED(CONFIG_CMD_BOOTM))
-		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	    IS_ENABLED(CONFIG_BOOTM))
+		ret =3D bootm_run(&bmi);
 	/* Try booting an AArch64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTI))
-		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret =3D booti_run(&bmi);
 	/* Try booting a Image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
-		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret =3D bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
 	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
 		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);

And this doesn't seem equivalent really. The logic used to be checking
if we had bootm/booti/bootz and now it's always checking for
CONFIG_BOOTM. Jonas, can you please share the defconfig you used here as
well? But I think for now reverting the series is the best path forward,
unfortunately.

--=20
Tom

--oPr6HIH0awojahBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYhYqsACgkQFHw5/5Y0
tyxtmAv+OjX+lrdFJIw4qrXmnUBH3rZYFQy6S+Ntwlzo15TxT1Sro4FDzB4fa2k0
afT+2O3Rodro1+Z3DOUy0O1SBsiSghNq8gCGzKkHSojiLSlmrCbXA3Kqk+R35Csh
Q0PS4e+r7xgnIgGQgluzM4QFiWuQy/bzqjYYkMyMoIAIlZapC9+5qpuztKdKVS0N
8S+MSA3iCPUJsf3qdwgakDhiSMVGWjKo7Nb5zv1gmNvnXyY8x7i8ZvkbY6IhBvKu
OmAhiRkEVQRnnqTCjeZD9md+fym6p0H76a+GFFG+B6fXiz0IXaBvoJ2AUiyXDixI
du9/lF+ndgO45Y1iTzCI9DQ5kHmp8HgjAN5G3fvf4+mqrFi/2zXSFK/Ov+lRtS4i
zW71F9U5eQM4n26ACDMp/lLSXsCIBOafCNhD3ug1pKkVmjwROU/F/NROO44r96Yf
HtNT6NJ/4A7YPG/Gxmm4L0o9o+MCKpThb81k8nnCmIMi/+BK+Kj0ef+1+WlEBHUX
n6Xb1ytp
=stF1
-----END PGP SIGNATURE-----

--oPr6HIH0awojahBO--
