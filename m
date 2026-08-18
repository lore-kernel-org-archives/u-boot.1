Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E76C5DF80
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB87180C73;
	Tue, 18 Aug 2026 09:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nc95QZJQpYf2; Tue, 18 Aug 2026 09:29:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A94F480BE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787045360;
	bh=FYLLW6PPIaJbMDkG6tWmyGPJx6WAVvITCnXIYFBVYkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+gqu8uW4cA4xPlL8Tmh8fd3tyjxiD5SdyF0J9U6GiNTdz28S0wkLx1pP5iAciwnG
	 6CYTV5ja4iiN/ztVLKiaKOrpnxaHOZO6gIG3TIcsEP9ZZP21k9Q3vL8dMoygCYMjqi
	 yYSOxVcOnoDtAjhKK1wRa2DIRdHqgqnd2TRD/CR3a1l2CTAX5R/tvKiJ36IELT6SsM
	 bjwSwUQpLTZpTjcH+nYzI1jU3Pbj6w+mHyWfAcioX4oINABtT4OyTID5pqa78vWF3T
	 Y0loHooOK0xBngkbvzINVFXWNeTyqjejBjZQ8wknt8+Mjb5at6s6CvytkfAVsyIDv0
	 Vcnxe5Y1602ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A94F480BE6;
	Tue, 18 Aug 2026 09:29:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D06672EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B62D280BE5
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ql_wJ56St3vb for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:29:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=conor@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DD1F980B36
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD1F980B36
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=G3J604dC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD1F980B36
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:29:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99E2160A5D;
 Tue, 18 Aug 2026 09:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C63B1F000E9;
 Tue, 18 Aug 2026 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787045356;
 bh=FYLLW6PPIaJbMDkG6tWmyGPJx6WAVvITCnXIYFBVYkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G3J604dCESgVua9xHImVG+ERnDgP9II0SvXUXBHovlwXe8RC4n/kHXbeM30XSc7d/
 SRxg8IfU25dn8SqCEvxhsuCgx5P6RmEQVlPFzSdw/tsricYz4qetKZPGjrXF5sQgk0
 96MwJ6aDQC+uH+qoEe5vdqHfiagQswJj7aav4s5Vx9lXD+iYnfXYndo8XXgntEO/H5
 X/BBCd+bVvD//+S5QrpH8P2gyBPRCkHypkGymOJcLWOwaCCdnI875hvTydrru3oIww
 DEOZGTJMmzpOYVZ1hy+mJfwBAP0vWD1ga8wdX1KomTxRfiquMpdbpCsZH7LJ4TMlar
 z8UufjQWLOvwg==
Date: Tue, 18 Aug 2026 10:29:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: u-boot@lists.u-boot-project.org, conor.dooley@microchip.com,
 jamie.gibbons@microchip.com
Subject: Re: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Message-ID: <20260818-rehydrate-gurgle-27ca628f2c24@spud>
References: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rW7FbuOFq2fluTvI"
Content-Disposition: inline
In-Reply-To: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
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

--rW7FbuOFq2fluTvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nathan,

Sorry for missing this originally.

On Fri, Jul 24, 2026 at 01:33:50PM -0400, Nathan Whitehorn wrote:
> When working with systems with multiple FPGA firmwares, it is sometimes
> useful to be able to use the same U-Boot and script conditional behavior
> based on the FPGA firmware ID and version number. This, allows, for
> example, flashing new FPGA images without flashing the bootloader and
> letting U-Boot and the Linux kernel adapt appropriately.
>=20
> This does three things with the information:
> 1. Prints the FPGA design ID and version to the console as part of U-Boot
>    startup, which is helpful to a human working with the board.
> 2. Stores the same information, plus the already-acquired FPGA serial
>    number, in a new set of environment variables (pf_serial_number,
>    pf_design_id, pf_design_ver [the version], and pf_design_backl
>    [minimum-version backlevel]). These can be used in a U-Boot script to
>    load different kernels, device trees, etc. depending on the currently
>    installed firmware, which allows U-Boot and the kernel to adapt
>    cleanly to FPGA firmware updates that change accessible peripherals
>    etc.

These two I don't really mind, I can see the value in it.

> 3. Stores the same information in the device tree (under /soc) as
>    fpga-design-version, fpga-design, and fpga-design-version-backlevel.
>    These things are also available through the Linux system-controller
>    driver directly, but it is handy to have them in the device tree as
>    well.

This I don't on the other hand. If linux needs it, it can go and get the
information itself and if userspace needs it, I'd rather there was a
small driver made to expose it on a dedicated interface rather than
buried somewhere in the devicetree portion of sysfs. If it is just
informational, the info has been emitted by U-Boot already.
I'd also rather U-Boot didn't add undocumented properties to the
devicetree.

>=20
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> ---
>  board/microchip/mpfs_generic/mpfs_generic.c | 31 ++++++++++++
>  drivers/misc/mpfs_syscontroller.c           | 52 +++++++++++++++++++++
>  include/mpfs-mailbox.h                      |  1 +
>  3 files changed, 84 insertions(+)
>=20
> diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchi=
p/mpfs_generic/mpfs_generic.c
> index f57f5f4046b..469e914e083 100644
> --- a/board/microchip/mpfs_generic/mpfs_generic.c
> +++ b/board/microchip/mpfs_generic/mpfs_generic.c
> @@ -114,7 +114,10 @@ int board_late_init(void)
>  {
>  	u32 ret;
>  	int node;
> +	int idx;
>  	u8 device_serial_number[16] =3D {0};
> +	char serialstring[33], designid[33];
> +	u16 designver, designbacklevel;
>  	void *blob =3D (void *)gd->fdt_blob;
>  	struct udevice *dev;
>  	struct mpfs_sys_serv *sys_serv_priv;
> @@ -144,6 +147,24 @@ int board_late_init(void)
>  		return -EINVAL;
>  	}
> =20
> +	/* Store design info and serial number in environment */
> +	ret =3D mpfs_syscontroller_read_design_info(sys_serv_priv, designid, &d=
esignver, &designbacklevel);
> +	if (ret) {
> +		printf("Cannot read device design information\n");
> +		return -EINVAL;
> +	}

blank line here please

> +	designid[32] =3D 0;

What is this doing?

> +	for (idx =3D 0; idx < 16; idx++)
> +		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);

blank line here please.

> +	env_set("pf_serial_number", serialstring);

Contrary to what I said yesterday, why not just make this
"serial_number"? Not like the code is going to run on a non-polarfire.

> +	env_set("pf_design_id", designid);

Ditto here and below.

> +	env_set_ulong("pf_design_ver", designver);
> +	env_set_ulong("pf_design_backl", designbacklevel);
> +
> +	printf("FPGA Design name: %s\n", designid);
> +	printf("FPGA Serial: %s\n", serialstring);
> +	printf("Design version number %d (backlevel %d)\n", designver, designba=
cklevel);
> +
>  	/* Update MAC address with device serial number */
>  	mac_addr[0] =3D 0x00;
>  	mac_addr[1] =3D 0x04;
> @@ -182,6 +203,16 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  	u32 ret;
>  	int node;
> =20
> +	node =3D fdt_path_offset(blob, "/soc");

Putting in the soc node doesn't really make sense anyway, the soc node
is really the devices on axi buses.
If this were to go anywhere, it should be in the root node.

Cheers,
Conor.

> +	if (node >=3D 0) {
> +		if (env_get("pf_design_ver") !=3D NULL)
> +			fdt_setprop(blob, node, "fpga-design-version", env_get("pf_design_ver=
"), strlen(env_get("pf_design_id")) + 1);
> +		if (env_get("pf_design_backl") !=3D NULL)
> +			fdt_setprop(blob, node, "fpga-design-version-backlevel", env_get("pf_=
design_backl"), strlen(env_get("pf_design_backl")) + 1);
> +		if (env_get("pf_design_id") !=3D NULL)
> +			fdt_setprop(blob, node, "fpga-design", env_get("pf_design_id"), strle=
n(env_get("pf_design_id")) + 1);
> +	}
> +
>  	node =3D fdt_path_offset(blob, "/soc/ethernet@20110000");
>  	if (node >=3D 0) {
>  		ret =3D fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
> diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscon=
troller.c
> index f608d5518b0..ef03ce7b262 100644
> --- a/drivers/misc/mpfs_syscontroller.c
> +++ b/drivers/misc/mpfs_syscontroller.c
> @@ -129,6 +129,58 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_s=
erv *sys_serv_priv, u8 *devi
>  }
>  EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
> =20
> +/**
> + * mpfs_syscontroller_read_sernum() - Use system service to read the dev=
ice serial number
> + * @sys_serv_priv:	system service private data
> + * @device_serial_number:	device serial number
> + *
> + * Return: 0 if all went ok, else return appropriate error
> + */
> +int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_p=
riv, u8 *designid, u16 *designver, u16 *backlevel)
> +{
> +	unsigned long timeoutsecs =3D 300;
> +	u8 data[36];
> +	int ret;
> +
> +	struct mpfs_mss_response response =3D {
> +		.resp_status =3D 0U,
> +		.resp_msg =3D (u32 *)data,
> +		.resp_size =3D sizeof(data)};
> +	struct mpfs_mss_msg msg =3D {
> +		.cmd_opcode =3D 2,
> +		.cmd_data_size =3D CMD_DATA_SIZE,
> +		.response =3D &response,
> +		.cmd_data =3D CMD_DATA,
> +		.mbox_offset =3D MBOX_OFFSET,
> +		.resp_offset =3D RESP_OFFSET};
> +
> +	ret =3D mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &=
msg);
> +	if (ret) {
> +		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, =
abort\n", ret);
> +		return ret;
> +	}
> +
> +	/* Receive the response */
> +	ret =3D mbox_recv(&sys_serv_priv->sys_controller->chan, &msg, timeoutse=
cs);
> +	if (ret) {
> +		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, =
abort. Failure: %u\n", ret, msg.response->resp_status);
> +		return ret;
> +	}
> +
> +	debug("%s: Read successful %s\n",
> +	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
> +
> +	if (designid !=3D NULL)
> +		memcpy(designid, &data[2], 30);
> +	if (designver !=3D NULL)
> +		memcpy(designver, &data[32], 2);
> +	if (backlevel !=3D NULL)
> +		memcpy(backlevel, &data[34], 2);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
> +
>  static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys=
_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
>  {
>  	int ret;
> diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
> index c0ff327a4ce..5c1ade3e918 100644
> --- a/include/mpfs-mailbox.h
> +++ b/include/mpfs-mailbox.h
> @@ -59,6 +59,7 @@ struct mpfs_sys_serv {
> =20
>  int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_c=
ontroller, struct mpfs_mss_msg *msg);
>  int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, =
u8 *device_serial_number);
> +int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_p=
riv, u8 *designid, u16 *designver, u16 *backlevel);
>  void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv=
);
>  struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *d=
ev);
> =20
> --=20
> 2.34.1
>=20

--rW7FbuOFq2fluTvI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoQl5QAKCRB4tDGHoIJi
0vSyAP9NmTFKAin3XY2fYbdqITinq9UHTPh+2pMpy6G7ol+ndgD+KMIVr9FBXz4q
fhroh4tYBrj1IOrv8OTP2rSsjKUfYg0=
=Iijd
-----END PGP SIGNATURE-----

--rW7FbuOFq2fluTvI--
