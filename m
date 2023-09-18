Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FCFCD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07EDC86936;
	Mon, 18 Sep 2023 16:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WVSCc1+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF238869A3; Mon, 18 Sep 2023 16:12:54 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BE98699B
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59bc97d7b3dso71817177b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695046370; x=1695651170; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kh9vXeXwomOtJc+naNSMZLc3gogQJ3/Ui8o3FaeaxAc=;
 b=WVSCc1+D4ONaqPutXJo+KOtvOhddXVMossHlg9rxbVg70riJx0qCKQsecNnPqjbG93
 bWATkSNNgyl/BeUqCxVoS4NcBGApo6N+e+z73uA/u5cbcEh1wmTVbtuQyzAs/R8y8BsE
 l4yoWktcCCHQs1MmEk7/ovxjACEoYRplEnS7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046370; x=1695651170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh9vXeXwomOtJc+naNSMZLc3gogQJ3/Ui8o3FaeaxAc=;
 b=dw7I7lHCIs15XdIQX700HOPv7+7ypJ5vusY1aCrN396iSG3wdLDKtgcgvpByz+7JHq
 Vo82m4z83DtGHbhYHJ3vLSZztGQ/wrwf1NGIPvzSJEPsc5UaFhPuGUyj+NT72hVKJuxF
 6RPKLRX1+TuE8znpeqfGfrMFrLD4Vu7faGYAdU2imF/kt2Pu0W8CBo0Ty+kiovzZ/ngh
 Q5RgA+RM1KD48JzCqSJtQsgVF5CBZM5giQiu/+RL5hIu8s3jQRgsMRsYaYzEf6a9dpbF
 3gRjehSJr5iJbf0J6Oa4HrFtFU0X/rc2bS7vFAMCFaC5Z2/TqOeXjY2wrAUiH5XuBBVV
 /n7w==
X-Gm-Message-State: AOJu0YxQFYYEjQtX/MR1UblpTLTqliHAHVM/UXpKhlYT8QlAADMAm5fH
 xWEXfw2dYaV6wD+yfAjFSnBYYg==
X-Google-Smtp-Source: AGHT+IGYFA5kD0esyO23Etvv0fRW2QQcRCXPfzLqoJqlByBgP04BBu8qZrZyaSYVoiRpEgM16+gA1w==
X-Received: by 2002:a81:918c:0:b0:589:e815:8d71 with SMTP id
 i134-20020a81918c000000b00589e8158d71mr10350967ywg.11.1695046370608; 
 Mon, 18 Sep 2023 07:12:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a81a54f000000b00583f8f41cb8sm2528923ywg.63.2023.09.18.07.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:12:50 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:12:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, sjg@chromium.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 rfried.dev@gmail.com, seanedmond@microsoft.com,
 tobias@waldekranz.com, sr@denx.de, john@metanate.com,
 git@xilinx.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH v2 1/2] cmd: thordown: Add proper dependency for
 CMD_THOR_DOWNLOAD
Message-ID: <20230918141248.GL305624@bill-the-cat>
References: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
 <20230904031528.11817-2-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CZWydAjvAqkfnTct"
Content-Disposition: inline
In-Reply-To: <20230904031528.11817-2-venkatesh.abbarapu@amd.com>
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


--CZWydAjvAqkfnTct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 08:45:27AM +0530, Venkatesh Yadav Abbarapu wrote:

> When CONFIG_CMD_USB and CONFIG_USB are disabled some compilation errors a=
re seen as below.
>=20
> cmd/thordown.o: in function `usb_gadget_initialize':
> include/linux/usb/gadget.h:981: undefined reference to `board_usb_init'
> cmd/thordown.o: in function `do_thor_down':
> cmd/thordown.c:68: undefined reference to `g_dnl_unregister'
> cmd/thordown.o: in function `usb_gadget_release':
> include/linux/usb/gadget.h:986: undefined reference to `board_usb_cleanup'
> cmd/thordown.o: in function `do_thor_down':
> cmd/thordown.c:41: undefined reference to `g_dnl_register'
> cmd/thordown.c:48: undefined reference to `thor_init'
> cmd/thordown.c:56: undefined reference to `thor_handle'
> gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-ld.bfd: line 4:  8485
> Segmentation fault      (core dumped) $CC --sysroot=3D$LIBC
> --no-warn-rwx-segment "$@"
> Makefile:1779: recipe for target 'u-boot' failed
> make: *** [u-boot] Error 139
> make: *** Deleting file 'u-boot'
>=20
> Add dependency of USB_GADGET_DOWNLOAD for CONFIG_CMD_THOR_DOWNLOAD to fix=
 the errors.
>=20
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CZWydAjvAqkfnTct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIWuAACgkQFHw5/5Y0
tyzsAwv/UTjRPKo4c7vezu324zShhDQIAg/2zZQxm+VHM/6XmgtI/aGkf/TrfTIc
FtljYIRdbGh/ZJeFHwsJdDkYciI1EkIYRx2FDBax3pXfTD0OIUo5IlRf7TTaG/OM
fU9LMr2IooN510e6UxQAwJuoNd5/H+FJclDSG1gPHGgtAqKr2Qe+ohDbwUmTe0vs
mTbYys0GnnUewOPV9dUc+lq6GluSh86HXtLTxKa8DeqSKgI2CzEPGjJP3uYBWyY7
B9o0uLmITcAWoy3Aobc4Ndv79eQqTU14a6FMm0od3YI59IoPYUjpuJrT6deUL+/E
/WiMKoaQ/txE93MwfvFQdg+/4x0lAnzAVoCwTNX5gAuqWpdPwKmZreO1hxCXJopF
VvZtKue8sKOUgucqjWJ8US9uWYxgWOnjeOWp4pYFgJeoB8906mjY1EE/J7jyA4hX
dzxC3zaU9xBBa5+j9dzHaevFebqkdZSL3+nC5T+rgJJUa06WnozAsdizEKM0/08P
6OzWR+TZ
=WLiN
-----END PGP SIGNATURE-----

--CZWydAjvAqkfnTct--
