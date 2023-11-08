Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF3DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5365887009;
	Wed,  8 Nov 2023 16:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Mia5flVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1F787073; Wed,  8 Nov 2023 16:05:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4866286FAC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mripard@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699455936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4HuI7rrewD1XmA3k+R00172FfqV7N2MAth0xd7TBgUQ=;
 b=Mia5flVM1Kg0yJP6SkzSxblEbLgnlamAX130++MgEkQYz2IzmIC2GI8g0OEa8GgI1ruUwO
 VXyMMfPC56pd9Cwnh9dSfhWNIsIzar4XyrPn0Wji0u2tZ90RDWzh6Y4rpTWYBnzZHl5WC1
 IhB9fdMrxJVy3C93TeO0FzyU6HubhP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-TTF_N_9fOrG8MdZAO7Q5HA-1; Wed, 08 Nov 2023 10:05:33 -0500
X-MC-Unique: TTF_N_9fOrG8MdZAO7Q5HA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f68d3b788so3502173f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455932; x=1700060732;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HuI7rrewD1XmA3k+R00172FfqV7N2MAth0xd7TBgUQ=;
 b=L8Mh+LoY1/SI19oRJ9Y991dZ5Y9eO9CahnORrNr85palRQjlj2ZZbDergX3FoVOs03
 ogTvhYqFqP/+sz89ZE07zaoMJmNRzoOdxpqijOnzABH9o6vuTaX0MmSPWn43amPD/7GT
 gY8mULQlnE+n49MaesIPgxy0QKOPtgaWM+9/EFvEgrwpvtVD8s9b/Im19xS2zBj/V4FY
 wW3uWPO3AbamW7yr4yfDMVdoOZqz15JqOqmhp2Kf0aPxv6VFVHSxptAQlpm0RXRNzKQV
 /hDsxRa+MivS6zNUlCb0Yvz135yfWgLmHLMVzHETQK/y4uO1W9R04C4rMzL7vDomoZ1u
 nYYw==
X-Gm-Message-State: AOJu0Yx/n8026763B04qDGwWMhE91Hj2u4hmwHXIGZsThaXUCPUZYJGO
 89ytgcKYPi+cAhxLObxxr5gpsT/ldo45VkVG8X7r/Pi7qbomEJ0WoitLulAQ8T8w4ugcJ8sDk9z
 AxS/53CEogfJ1LA==
X-Received: by 2002:adf:9c86:0:b0:321:6005:8979 with SMTP id
 d6-20020adf9c86000000b0032160058979mr1527472wre.17.1699455932570; 
 Wed, 08 Nov 2023 07:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqKhdKHoM7ujp0lQkQinbwTbSYzyxwmfkLG32M2qiJMmVE0clFB3mvq1W5IPBpQa7nWtbtXg==
X-Received: by 2002:adf:9c86:0:b0:321:6005:8979 with SMTP id
 d6-20020adf9c86000000b0032160058979mr1527459wre.17.1699455932182; 
 Wed, 08 Nov 2023 07:05:32 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d4011000000b0032da87e32e2sm5189423wrp.4.2023.11.08.07.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 07:05:31 -0800 (PST)
Date: Wed, 8 Nov 2023 16:05:31 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: eMMC broken on SK-AM62
Message-ID: <hsk5wejuf5maoer3aodjyndmyft56gag4cepfjep7lfthmwrcy@r2yoebb7stk6>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="piceaf3ozo7zu7fy"
Content-Disposition: inline
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


--piceaf3ozo7zu7fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nishanth,

I've been trying for the last few days to get an SK-AM62 to boot from
the eMMC user data area.

I finally got the jumper configuration to make the CPU boot from there
thanks to Mattijs, but it looks like the 2024.01-rc2 release doesn't
support booting from there:

U-Boot SPL 2024.01-rc2 (Nov 08 2023 - 14:11:12 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.5--v09.01.05 (Kool Koala)')
SPL initial stack usage: 13368 bytes
Trying to boot from MMC1
MMC Device 0 not found
spl: could not find mmc device 0. error: -19
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

It looks like you tried to fix it with 0f1c1e8b368b ("arm: mach-k3:
am625: Add support for UDA FS"), but it looks like it's not enough.

Thanks!
Maxime

--piceaf3ozo7zu7fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUujtAAKCRDj7w1vZxhR
xXw4AP9A2pbugpgx0/gfxP+YuEfpGpBrGa7UXMoTP1gDQbwqqQEA/uEP6eC/cWlL
xnZF73d+UJJwqq45WR6Jo66BDYe4sAE=
=ccNp
-----END PGP SIGNATURE-----

--piceaf3ozo7zu7fy--

