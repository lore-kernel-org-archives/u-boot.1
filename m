Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B3CF34B5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7975283EDE;
	Wed, 19 Nov 2025 15:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bMfTfYB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FA883EEF; Wed, 19 Nov 2025 15:19:09 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9558388D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c701097a75so3056022a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763561945; x=1764166745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0KR88Bx/4GDhMOVQU8hOGB2BTa3/2XIOQhc2ZvZDY=;
 b=bMfTfYB27h2CtpMdzhQ+eGsiBOY8AVZJgsAM3fqGHlz5kF1QjfCpWvp4xjZ3kgQj9S
 Wt8Km4O/mkaLDu8AmBd2xSerHIzuAcuueH4K8BVWeqB173ovoKrzHCD8QJag31bMQv3S
 LjGSsHD2w8UoiHKxZ5fmsA91Dm/T3y3RoSoyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763561945; x=1764166745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ij0KR88Bx/4GDhMOVQU8hOGB2BTa3/2XIOQhc2ZvZDY=;
 b=j8KZTVVw28CjkVrpi18/wssPOL+uwHg8gpxh09OzcJCQ9V1v5zZF4ip6fsNssurA0K
 uvxv2UiY98574LZL1KYaVbvwP5DXjWZBnTgNOaSEFzw4WePJgZv5xbsNmyLfQoakiMx5
 cZE/utvs523inp7DHXQ+J7j9SpRfC5X/b07u3xlCaxaEViVQZgCBlKtCJqPnTcCkpFsE
 aMqo+z1jpRyrRweW2KSXfEA6ZWmYBpm4+h5IMQs3TvNFKAIMrl4Qs8rXgTlzLreVr2Nl
 FNnse8lss7lZXg+tlRWCBcuxAN6tCWMfjKrvLJ73j47ljVCpIaMwdTjcZu0ebEY6qMxT
 YoUA==
X-Gm-Message-State: AOJu0YxoVqRga+JHoZ9T7E5QLoYT0TMv9TUCMbbl0Uko2c9mL0AKCveP
 hWlP7yrWUg2Vfbv9cS4W4j00qL7mw8DnIM8tlVT1PDXtTbR87R+Lgfepmo8gJjt9qKw=
X-Gm-Gg: ASbGncsMT7TQDGK1h+0NMcgu7P13LJeGnt9TItAEaG67pyWGkMwkbwIefrIkN9mcxnP
 2Sgczfm7xi97Xa8XgMlj3n6SKvE87BFv/k/gCt+//3egfBc0owlOOHgGG7maFU1hdiKAwTgQDdK
 0Vj0sEFCv4fQhRyUgJo/rgnk9Yu4DnJmqk7zk1CtsHd2OGAkJi+EULqNMJbaA5XMCP4JvnjhZ/A
 mx0+jf8GzDT0sZ4aU8s+NKM3QBEt28jYRq7AZJWzZJLk2J+jXVr9qB1QTwfs4ZvwjK8k/LRcEOB
 u5YYBoDSQM+ftcg+yzb508iFT+sSlFBInYHTDR8dU0XWal+sj0zbHGZ2P4VIbCre6wSPBL/ThO0
 EY/Ki5959ML+0Rr6tl9kd5GteKJ5YLnqiz1a3ycVLFW5BIKOlV0bu1dq1hRUAlwWL7lqJETFtDZ
 z2AHBqtRoequ+ipK5nyaFPiVVEYAr174+un/w5OaxHmz6uC8jzt19SlVkawb/z
X-Google-Smtp-Source: AGHT+IEQ+llbBimaWuzMdVyGUhbPBwKXzdv3Jnnwd+DEbBk8JG0CBQuP15KbdZYnoubWEu/CgVuMPA==
X-Received: by 2002:a05:6830:3498:b0:7c7:620:b1b9 with SMTP id
 46e09a7af769-7c7828aa21bmr1471987a34.13.1763561945253; 
 Wed, 19 Nov 2025 06:19:05 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c764e49dfesm3364958a34.20.2025.11.19.06.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:19:04 -0800 (PST)
Date: Wed, 19 Nov 2025 08:19:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-01-rc3
Message-ID: <20251119141902.GY2125796@bill-the-cat>
References: <faafa443-e804-4506-ac4a-658c2b8cc339@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DFLbdsVj42/3WRSk"
Content-Disposition: inline
In-Reply-To: <faafa443-e804-4506-ac4a-658c2b8cc339@amd.com>
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


--DFLbdsVj42/3WRSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 01:52:19PM +0100, Michal Simek wrote:
> Hi Tom,
>=20
> please pull these two fixes to your tree. In CI docs part is failing but =
it
> has nothing to do with below patches.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/28=
413

I'm not sure what's going on with kakapo, I see that failure a lot too.
I didn't pause the runner since most jobs complete, and in general when
there's a failure like that just hit the retry button.

--=20
Tom

--DFLbdsVj42/3WRSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR3R0wAKCRAr4qD1Cr/k
CmNlAP4kI9NCmFe5eOkStIJ/weB5UNXwNqA+Wm/mlwpfwilufAD+PHF1WKWanpAv
g+9JB7fA8TmpErF3JABb0e/Kd3IKqw8=
=lnK1
-----END PGP SIGNATURE-----

--DFLbdsVj42/3WRSk--
