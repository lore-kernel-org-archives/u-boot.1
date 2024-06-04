Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B604C25B75
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 00:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F24883C8;
	Tue,  4 Jun 2024 02:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="spljgtsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E67187CFE; Tue,  4 Jun 2024 02:44:14 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6480C883C8
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 02:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b970e90ab8so3289702eaf.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717461851; x=1718066651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P/OvScn9XUon3IK2t+hpOehL+HW+e57xEMtXYynzPDQ=;
 b=spljgtsPRfAKuLkvKkcxBLxx2j8FDS1UN3EyoFHKAQzFdHibe+nX/E+pDmSRKhjb0x
 mdIYWwu1kYqRrw0yxa4glAsLl+KOAOQQXc+y0owdjuOP9ZhkgtgWIVoZHzypMggPNw3l
 7KJUD5luY0jcwSwedj3emC38A2u3MakYSz2Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461851; x=1718066651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/OvScn9XUon3IK2t+hpOehL+HW+e57xEMtXYynzPDQ=;
 b=pKottgHaW2VI1OiQUuNzDHy8Jl9PbkHhFZ4J9kNfg9cso5DgiZOSlEd+yzqvAlMOl4
 VOyRUmEkQXoUIi1G/5xdHL2wEslOYCKfH+rEj10q4TkozDN85Bh1tczBW4IszWh/yalq
 QSUUATGPOfpbxVe7e8+D/fcnEj63OFyMuur7FKM1fWaEQsAb2b5wMTSXnUm63ttJh2HK
 Fp21BlfA8LdBd3OqZKP9fJINsvyFPmeKh7AWsQZufPdORhy2e1nmu0tGioNg9dvqbhfB
 /FNXmR8XHu4sjsBgL3764uxoXx3xOqE8Gp3e0r9G2ung/KTGmV6V8q8UmTTuvB7CC9vM
 1J/g==
X-Gm-Message-State: AOJu0YzLp13yvsuf1A/c5tTYaWU0oz9fed+rtcF3pzTNJm2F0XAciUUk
 9M0QAZTVoZlHxZwfibs9pID+OuYy+/Zbkndvjc7LOc89DBCm+qUkA0KwrFqL9pY=
X-Google-Smtp-Source: AGHT+IE3wkOuSAykYf2nebXGg1a63Q4+8NF5DJ1qquJYeLQwDG2V9xxo/JX4oL4sLYbD9eFug8lRNw==
X-Received: by 2002:a05:6820:1c91:b0:5b9:ff9c:b889 with SMTP id
 006d021491bc7-5ba05d7e00bmr12499151eaf.5.1717461850946; 
 Mon, 03 Jun 2024 17:44:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba004f12f5sm1697756eaf.46.2024.06.03.17.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 17:44:10 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:44:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v6] test/py: net_boot: Add test cases for net boot
Message-ID: <20240604004408.GJ68077@bill-the-cat>
References: <3dcb3163c4b685d4ddd5f9d4149ac82a43955fe0.1717425151.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/qqI92f4pVnI8g1P"
Content-Disposition: inline
In-Reply-To: <3dcb3163c4b685d4ddd5f9d4149ac82a43955fe0.1717425151.git.love.kumar@amd.com>
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


--/qqI92f4pVnI8g1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 08:03:45PM +0530, Love Kumar wrote:

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

So, I get as far as this with the PXE test:
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> setenv autoload no
U-Boot> U-Boot> dhcp
Waiting for Ethernet connection... done.
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address 192.168.1.100 (254 ms)
U-Boot> U-Boot> echo $bootfile

U-Boot> U-Boot> pxe get
missing environment variable: pxeuuid
Retrieving file: pxelinux.cfg/01-b8-27-eb-fc-64-a6
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'pxelinux.cfg/01-b8-27-eb-fc-64-a6'.
Load address: 0x2500000
Loading: ##################################################  64 Bytes
         0 Bytes/s
done
Bytes transferred =3D 64 (40 hex)
Config file '<NULL>' found
U-Boot> U-Boot> pxe boot 200000
Ignoring unknown command: <9G??0????`@???p
U-Boot>

--=20
Tom

--/qqI92f4pVnI8g1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeY1gACgkQFHw5/5Y0
tyy9igv/RB9KPV3434oSzvaPBT9geblKwR08EtdQfCA7WP43ep8mkfqXIcPpUwP5
bhJLuOn4aynag6LbqOqM9TrfaoP70o5+YcGBwGtkQZ/0tSunBJHQZJMdcMQ+4nlT
fYuv+46aJOA5Y5UDI/JMiJnN/5zA/LVNohIUbsrTOgteMK7MjOk6RJc40G6YLT3m
XTXMh5FpjcAoMrqx05am5sqfyXoXadCFqvwAYxTUQdiHi3llYZEqn97adg1wPbHb
J6toIkKdMqVzrxa4aB5Tq8nJouj8QbrYBGLcCxWZrWQfqNWsgr+5TcsHMMbV8zxl
xjj5L5+hYJP8PjMM31PLzN5JMx4x+8KTfAs9sWLtXtXfJvzHSQp9YB2Hg+3KFeyH
y0y5ebsTeTL8vGf/xIG6sF5C32vLIq5EpqrLu8TK6FeuIrMVUPATR/BcLF9kZkT/
JpLgcXTH4nkbnxgyb6pntS81I9Lv3FZWBlMdjjliQSk6yXXlKvp9om566NWbzGtI
1s3Bsa7k
=YvSK
-----END PGP SIGNATURE-----

--/qqI92f4pVnI8g1P--
