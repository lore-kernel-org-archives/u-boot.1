Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB471C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 20:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF4C88263;
	Fri,  3 May 2024 22:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qZ+AP9oB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC808826C; Fri,  3 May 2024 22:07:27 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B168825B
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 22:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-790c36dcee9so101185a.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714766844; x=1715371644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VxVwtm7F2qN7ArSttUnOLSEamHPna7SxEANCwVShSH8=;
 b=qZ+AP9oBZ1FoDMDvXrcOhkXRtzVDorDrmLWX5Fyd4AXZ3ONmmMICY/FKPtd2cBWM1n
 5mcxZdAtH/qdw9JMNfP6ihWyZWBDwlwMP1QoIM/fxxC/AlzRaIgFcHtqore4Jt80OMJu
 B4V2XtEzaGeJWjrBI9UVF9Inx07tT2qGFGTng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714766844; x=1715371644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxVwtm7F2qN7ArSttUnOLSEamHPna7SxEANCwVShSH8=;
 b=p3SLSCAnktzO01bd7eS7EqI7nGpV2BDCZMo1IK4DqrfWa3tijv6qbTF+Z+j64+y1Qy
 H2G+T++dwDBAQaxLSrDkqX3VVuJ9jTz9vnT25MNHBURW0qMco5PnQgSt+mQ/CLJlcqcK
 hDPTxjHM11jf7Mlvt9QBMOcFLi1/ExxnZiBDDLEMrlRK8dIjf5l6gxJ+JzMw/Zl5DSig
 oJx7iAFAqddc5EQN5zUQ66cJ4Lo9E45v/yTFWBEx3W7cs934HBx9/CTcPlTvt5PsaTEe
 vdfxBh5dJnGLSXwgwl7AnQ6vMF7ZGcNJnxUZtgTbH8XyRSEjkNjNsvrC0bILwYffW1qz
 H+rg==
X-Gm-Message-State: AOJu0YxpOfKTTAl86I53KHJzq/nzrJCW64RFWMoQe6cOaEJGSdC//Xik
 7ZYdZDTFt0mc50xNtBvDA1z6RqzG0WYq2jALuE7tq/5HsgeckphR3IzZKgA9wUE=
X-Google-Smtp-Source: AGHT+IEi/iqj0E3U2hD1xCZ1Jpg8v2HpKQfORa4btJxM+J+tFvxxwgpmq/PIczR8e5wuJ3ERufL22A==
X-Received: by 2002:a05:6214:23cc:b0:6a0:99c1:541b with SMTP id
 hr12-20020a05621423cc00b006a099c1541bmr4114383qvb.9.1714766844285; 
 Fri, 03 May 2024 13:07:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 jh20-20020a0562141fd400b006a0e94eb3e9sm1472502qvb.34.2024.05.03.13.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 13:07:23 -0700 (PDT)
Date: Fri, 3 May 2024 14:07:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
Message-ID: <20240503200720.GA2559049@bill-the-cat>
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Fn0048eUHYJKKNe"
Content-Disposition: inline
In-Reply-To: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
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


--/Fn0048eUHYJKKNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 05:39:46PM +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
> This test relies on boardenv_* containing configuration values including
> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
> boot log pattern value is matched. For example, if the parameter
> 'pattern' is defined as 'login:', it will boot till login prompt.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>  - Expand commit message
> Changes in v3:
>  - Add the config option to skip the test
>  - Remove imi command to check FIT image config
>  - Configure static networking only if DHCP fails
> Changes in v4:
>  - Use configured timeout for tftpboot

Getting closer! Can we make this more robust and check for failure strings =
too?
For example:
U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'v6.6/image.fit.nocomp'.
Load address: 0x200000
Loading: ##################################################  82 MiB
         2.7 MiB/s
done
Bytes transferred =3D 85984256 (5200400 hex)
U-Boot> U-Boot> crc32 200000 $filesize
CRC32 for 00200000 ... 054003ff =3D=3D> 754c839a
U-Boot> U-Boot> bootm 200000
Wrong Image Type for bootm command
ERROR -91: can't get kernel image!
U-Boot>

This only fails when we hit timeout.

--=20
Tom

--/Fn0048eUHYJKKNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Q/EACgkQFHw5/5Y0
tyyKhwwAhBWKxPXW1GeZFeWT+a5prJHioi/iWF8X9p8hpJT3u/MmxYTcgu0mz6AW
eLeJoW9EoulDAa9lvtx29Vwp7CbDM2clj99jxvhs/s2g4cUcNXguuFZnHvifhHT5
FJc0VdBr5a/Cysul0yaTr/n3eU/8ip77O73vDOMpHBbGYSpcq163NQckYTm1m7Av
eQrQmyfU40lu2oAVlMeP3eWgChHpnSJJOe/tJLZaoi7+bDdqBrj5Nb71LVE4obTC
vvhx8qD1YD0u1tq36JUCoAG1ccqPpZfWKOcEQWRGcpf8/sCEcu80JoUsm4kR7U2X
BomxEuyhCW2OYXtbIB62/ii3/ns+CFaDbtYT2UT123mLdYLi90v8piy7THLJvkuG
5Z8V7gX602U/N38DMb1Nf0/NHtbtOtyMvKM6rqKoSo1Pr1+Kmfypsu0+BCchS+7r
+6Ndr2rRKaLpMPO5ahEHf7+1ukTF7GUUQzU01yZVRVhO49cdybP3iqkgq5b9dKdv
t6lsKt/M
=AFAl
-----END PGP SIGNATURE-----

--/Fn0048eUHYJKKNe--
