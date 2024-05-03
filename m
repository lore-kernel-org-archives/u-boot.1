Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE27DC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 20:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C0F882A8;
	Fri,  3 May 2024 22:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qH8Cypqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE7388317; Fri,  3 May 2024 22:18:48 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F81B88270
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 22:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-439dfa27003so122621cf.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714767525; x=1715372325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzSublXQZWmOhzLGCeHiNS4ZMOfHDh5m/sxg3V+Qb98=;
 b=qH8CypqiUL8PYpEwvBLIBkctPdia8/hbSwLmEcvPMYxoeqZD02Z3XJ6NhZeySjHSTD
 bSAK1IZetwaF+N47MqsiEEWe7/kjhOBn+vAYRtCaGiPTcg5jzeL42j6BblsJMBsj8ICr
 vN11h+bYzfqpdmIu+inVk5m5H1qoHGzxqvnz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714767525; x=1715372325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzSublXQZWmOhzLGCeHiNS4ZMOfHDh5m/sxg3V+Qb98=;
 b=IJCPjeaJI2LhF2QywUjyguVq4RBYF1pCEPs6kS6iJXLpRaBJscoUU/H6bMjjVXrmp2
 acEe4uSZHwgq3XyxCwGF11R3PFJNaAvFAfE158BM9YcnjltZH700jiyj2vbMKhRAfArL
 MgF/0mfVDpt9se2ydt3nUjDTb1C9RYabjN9JzfmUpFKxfLZoJR69QX4GtZp+SrUgbLwP
 T4Sroifg+Ylqa3x2Jn0RYpWeke1OL5s9jTusfWQa3H9SIZV8tV2MwSX/bl1AXM67VgD8
 7oFP39SM/g9SPhFsRBaeHk6plBf1qlInE1UF7qsiEMbunUqOwc5B8XQ6grSxBK2ZlXvI
 hVzg==
X-Gm-Message-State: AOJu0YxeTGSZ0hKv+1dqztHVO4qDG4Sfz5zmdqr2l5+wwrMHe4vUYgHH
 SV4wOduXHylwmUSRltvprHS928rc9ovyNB23EGWLlwj0Nr0fV+Q+7SZI2nW2rUc=
X-Google-Smtp-Source: AGHT+IHW+JYcP2CAQdZifmD71TzBxsSC7nVeBea8xnZXsnIKVY183/WMGqo1KDwQQSj3XGi+4uecQg==
X-Received: by 2002:a05:622a:144:b0:43a:b7da:ec97 with SMTP id
 v4-20020a05622a014400b0043ab7daec97mr4592518qtw.50.1714767525361; 
 Fri, 03 May 2024 13:18:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 eo11-20020a05622a544b00b00436eacea78fsm1901952qtb.65.2024.05.03.13.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 13:18:44 -0700 (PDT)
Date: Fri, 3 May 2024 14:18:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
Message-ID: <20240503201842.GA2560583@bill-the-cat>
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DegsGmJhxjTJTQ3/"
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


--DegsGmJhxjTJTQ3/
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

I'm not quite sure where the problem is, next. After enabling FIT image
support in my build so I can use the image I have on hand:
U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'v6.6/image.fit.nocomp'.
Load address: 0x200000
Loading: ##################################################  82 MiB
         3.2 MiB/s
done
Bytes transferred =3D 85984256 (5200400 hex)
U-Boot> U-Boot> crc32 200000 $filesize
CRC32 for 00200000 ... 054003ff =3D=3D> 754c839a
U-Boot> U-Boot> bootm 200000
## Loading kernel from FIT Image at 00200000 ...
Could not find configuration node
ERROR -2: can't get kernel image!
U-Boot>

And in u_boot_boardenv_rpi_arm64.py:
env__tftp_boot_test_skip =3D False

env__net_tftp_bootable_file =3D {
    'fn': 'v6.6/image.fit.nocomp',
    'addr': 0x00200000,
    'size': 85984256,
    'crc32': '754c839a',
    'pattern': 'Linux',
    'config': 'conf-852',
}

But it's not trying to boot conf-852 but instead just passing the
address. This image lacks a default config, which your example has and I
think is why the tests work in your case.

--=20
Tom

--DegsGmJhxjTJTQ3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1RpsACgkQFHw5/5Y0
tywGOwwAqERdaEIOQN+ePa9AGbqNlxBJOVlO7B3mS0hdETRFxad3ZJjv+6IxxZcC
S6Ag80hlMaFKGYyxAQkz3j9K9biLdGCd44myIwgno6FiMIDHmuZSWXY02TiTMUV5
tSB3PuzK2S0N/tkVEH51jT6FAoAg1x8ItxpaNRi32JADBt4GXZ8dws2LB4IG+nBr
G7PFAj5/rMpJQnXCShXeurneczyzq0BbpzWgT1d/bedHu2dpzkIlcXXqraTefzMT
0Hj3hgUWy41MpF6OB3gg+4G63jrFM0ULxO00nNd8WH/xOWiIv4DVP7Frr6laUdnL
iqWLJNi6JIq94HWutlwo+gPYJlNZ4/95Ey2gVjXD2Kvm7yZPxnbxZzxy+6uL8IiP
BeVAKEVHAOzmByKaAWCjgvmUCumvSG1gaosLbebANkbCgI06DhNHg1wgjND4RwwV
ZJwOvwFJp9YZPMNvnxJcPLICauBEX8FkxHdrmlspQdwBHRNGz4eLuzesA7dU+fxn
UhJxGMI5
=Jqmd
-----END PGP SIGNATURE-----

--DegsGmJhxjTJTQ3/--
