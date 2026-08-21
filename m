Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88039C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17E964098B;
	Fri, 21 Aug 2026 13:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6CfmbKRy6p8; Fri, 21 Aug 2026 13:04:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317459;
	bh=jk8AlTLZcvxlVK9ie7LtA/pAR6DoegAtCCePz+YepgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0hZ/zQVZpJXLL0B0y4gj7iwNeYmAKuNCuWNgGjqVVaOQEieflQaB1LkL7iD3kJcFi
	 X1WTFTPMK/rWs5niy7hyDk4kZuVfkrGuQmLqoK3VBDssVmhcG7JJgEmoB0tD4gscXv
	 rRtgXSXlcBuj/uvpb4HS6OIHIrP4moF7T2KjjNX12leFNlF9WjjNNPz7eO9N6EXtNW
	 JIvIYkQ8cncPtLSi55pjqHBS4Y20eJxC8bIDTX6JuEKJlNQQ3LzSQ22B28oaIGJOHC
	 1eqG3HgOP2iGKcd72WPElM6uTVdYdW+1Y2i6qEMZQTQpiI2KFcZuAEe9Bgb3+2olB2
	 jbdB6trctoxCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C30840962;
	Fri, 21 Aug 2026 13:04:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AB17EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61277400DC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pX8GSGkg7mTx for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 13:04:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=conor@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=njHTyr1k
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89FD440026
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:04:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E059F60008;
 Fri, 21 Aug 2026 13:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB291F000E9;
 Fri, 21 Aug 2026 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787317453;
 bh=jk8AlTLZcvxlVK9ie7LtA/pAR6DoegAtCCePz+YepgM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=njHTyr1kYR9hrgmnKmWoKf1uqbSfewUqRI9tvJXbZcLOpsq2Bc0olvxXYLOyXaSGK
 5wUPGvo7Ff8Ttdt+wD5f8qv4U8aiQ0FD7K6z6ZIlILuB18qbYoZr3yU+lypCcojkQa
 lcYz3nRX6oUVlhJk5JVepUkWIOgi1Itriq5O22Mj9mRUBa0Bxl02MTEFHJqDR1JZur
 PQh1xlqMDd35kqGRfLprn+SLh0PvGzDaYoPpjQIuCnmiB540EKflItDSN754+DetsW
 xjtOkS19O6J5mF+Tfk6EVIUvPghpVgIUyAyJSCjic2nwfI5TWB5u2jaJe1HugFZtKW
 RN67MDnBETrAA==
Date: Fri, 21 Aug 2026 14:04:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 Jamie.Gibbons@microchip.com, Conor.Dooley@microchip.com
Subject: Re: [PATCH v2] riscv: mpfs: Read and store FPGA design information
 on MPFS hardware.
Message-ID: <20260821-clubbed-wildcard-e645eb5c9584@spud>
References: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XAQq+ZVq3/R0wjfi"
Content-Disposition: inline
In-Reply-To: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--XAQq+ZVq3/R0wjfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 08:48:15AM -0400, Nathan Whitehorn wrote:
> When working with systems with multiple FPGA firmwares, it is sometimes
> useful to be able to use the same U-Boot and script conditional behavior
> based on the FPGA firmware ID and version number. This, allows, for
> example, flashing new FPGA images without flashing the bootloader and
> letting U-Boot and the Linux kernel adapt appropriately.
>=20
> This does two things with the information:
> 1. Prints the FPGA design ID and version to the console as part of U-Boot
>    startup, which is helpful to a human working with the board.
> 2. Stores the same information, plus the already-acquired FPGA serial
>    number, in a new set of environment variables (serial_number,
>    design_id, design_ver [the version], and design_backlevel
>    [minimum-version backlevel]). These can be used in a U-Boot script to
>    load different kernels, device trees, etc. depending on the currently
>    installed firmware, which allows U-Boot and the kernel to adapt
>    cleanly to FPGA firmware updates that change accessible peripherals
>    etc.
>=20
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> ---
> Changes for v2:
> - Rename environment variables to remove the pf_ prefix
> - Remove portions of the patch that added properties to the device tree
> - Style changes
> - Rebase after a5f93037f28624c612288e2d97604d73e03af5a3
>=20
> Thanks to Conor Dooley and Tim Ouyang for helpful suggestions.

This looks fine to me modulo some formatting nitpicks. I'd like Jamie to
take a look here but in my book this is
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
with the following changes made:
diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/=
mpfs_generic/mpfs_generic.c
index 4423dd1e38c..408fd031c5d 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -151,12 +151,13 @@ int board_late_init(void)
 	memset(designid, 0, sizeof(designid));
 	memset(serialstring, 0, sizeof(serialstring));
=20
-	ret =3D mpfs_syscontroller_read_design_info(sys_serv_priv, designid,
-			&designver, &designbacklevel);
+	ret =3D mpfs_syscontroller_read_design_info(sys_serv_priv, designid, desi=
gnver,
+						  &designbacklevel);
 	if (ret) {
 		printf("Cannot read device design information\n");
 		return -EINVAL;
 	}
+
 	for (idx =3D 0; idx < 16; idx++)
 		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
=20
@@ -167,8 +168,7 @@ int board_late_init(void)
=20
 	printf("FPGA Design name: %s\n", designid);
 	printf("FPGA Serial: %s\n", serialstring);
-	printf("Design version number %d (backlevel %d)\n", designver,
-			designbacklevel);
+	printf("Design version number %d (backlevel %d)\n", designver, designback=
level);
=20
 	/* Update MAC address with device serial number */
 	mac_addr[0] =3D 0x00;


Cheers,
Conor.

--XAQq+ZVq3/R0wjfi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaohMxgAKCRB4tDGHoIJi
0lAWAQCxMc08kThtivJQqogZfLGhjiCacEUjZXJR4oqANNTnCwEA3APj6Qr16/qq
xCLclR2iWWvjWAobjfYj8nnU5f2kRQU=
=uFhU
-----END PGP SIGNATURE-----

--XAQq+ZVq3/R0wjfi--
