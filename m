Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC90CC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E3DC40783;
	Thu, 27 Aug 2026 14:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8MPgskMQzIj; Thu, 27 Aug 2026 14:49:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787842168;
	bh=NvEbWBTHr4SD8399PhBWgxAo4QkVj5JbCk3dwC9ZYK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Brm8iAxkl2kzAyDkHI/syvg5Zq+kRhjB2N1BbqPfCDzI8l1sgr8Le2PdjM4UvP4Zv
	 Vq69N6rXaWQJqpRRY7OjlVOnnMEnKKgHIbuvhZfTB+dbwTk48YtaZowU9HbJEl6aZd
	 QMsl38Lzkm9bO24gQvGYJjcq8ATmjljz+j+s4jKPlIg1Nr6fR0qv1M+33/tjzFPqWX
	 tXlKLE8zp2tUVR5Z7cKOzD5CSdH6q3msipMWqVF2FIpMvZo4U3ErhXMrmhzRxAc/R9
	 iva7O0LaPDV3BncVjvQypyDpWJ1m/P/1MQJLSJGZPSFkv58F32mC49Cc6CgXxaE92J
	 AniABcdLpVoOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A33040765;
	Thu, 27 Aug 2026 14:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF2D8355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5D5280E5B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl1_UxIp13yr for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:49:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::b;
 helo=mail-oa2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aP40C8Ak
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF6FD80E51
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:49:24 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-45e2c1e33e1so13818fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787842163; x=1788446963;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NvEbWBTHr4SD8399PhBWgxAo4QkVj5JbCk3dwC9ZYK0=;
 b=aP40C8AkbhHuvsSvgQBP38TRXOtvuRURqicVGbC3fF7H6oqn9D1kYIvWpqLyMi9nGh
 of7Wm5zfJLnWBojFpD79rm5ZfycJCbftsnfX4H7/l7T1spHNTg4ZgyqvdEK8ZT6JT8+9
 AzUv80RXU/JQ0WbC3kfNOuV9ZP1vbj1jEsD4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842163; x=1788446963;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NvEbWBTHr4SD8399PhBWgxAo4QkVj5JbCk3dwC9ZYK0=;
 b=KrZvxTrLk7rWQvPO4bUosLTBgavflGjvQE83NvscSHFS3u4V5GfZmc4YEyYg1dY7S+
 xutZcwOOrG7BAp+6dV4cWrpdlluO8iIC3ZIn+/tKEcJmDm4tRXhNpI7DaJyulEEz+Oj/
 sH45wNStGTdGD6Rb0Upx9yT2NIUKywAVbktEGvLqOA8kwDpN5SBx0eXBpLOiLe0cvtHb
 FwV4ArLP9lQ0c62cXpgEcccq7/COi5FgTZfL7NCsMgxJETE52OlkGZBRdg1848knRiwo
 NzWnn5EEqXV9cPXP+mozMRX4tevGI9qnoKo+k1x+B1KH2NsNMFYWDRbClY7eksKxhn5M
 MRFA==
X-Gm-Message-State: AFuF++kUsEpmVKczDdgfAoJtKN8NzxHjaAZ6z+9U4FDDHfpKAqql0atE
 YmTOR3fRNVl/A08/dxZT9fCNCQWSBsEb3PEdfDJaEMXrvaozXSiTg7ARuOt8N7ct6LU=
X-Gm-Gg: AR+sD12lNmzY+C0tArL7JTR4iPs5osA6Csoq2oz4cYo9bGfefg/xeorbjN1nLxKDehQ
 21bOmGmg4r7errmFXa9qFGDMtma05wTKyJtzqK3vagPYM5p7ltErv33NLemY/uj5Q60Q2su2nxf
 8Kl1ECw0zbNE+WGXjv0DK4ETW41Duz1YLpvYedpC4Ea4HZcps2SWhS9bPmSYMAbpQB5SbNFFd7w
 V3g6gDQHFJY/Bz+2V+1AY5d2QZi05qHK+FdNv+NqXaMCgeS2uA0cTvxcaKGhOCXx0Lc41YSUz6d
 rcZ0MRaxoXDg+Bi4weY5fmi8sXXOgekAVMIIlqr4X0sI8TfpRzaRE7agfENDvISwnOVXnpF6+Fu
 kyfo2gS21m8LaUJMV1piwfc1MmduD5B9rQ9pvauU53pe7Zs6fxIKIyyfo4SiS2Q4IcMc+XjH6SB
 MfhAFL4Nw4B9b+lLF/lyWOfUQTnk5iPeE89fJyFE+6posNfSOJDMnU5mJUncX/dnlU6IXY1tv0r
 wp0XGN7qaueeWs53Pa2CSfKyvLAduUCI/LLBwCkfdR3hYzQm/87DI5eUfvbcTH77pDzfW1CRw3e
 gdj7W+HdxQ==
X-Received: by 2002:a05:6820:4de3:b0:6b1:2843:1307 with SMTP id
 006d021491bc7-6b1a04e359bmr15502680eaf.25.1787842163448; 
 Thu, 27 Aug 2026 07:49:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a268023asm4600899eaf.13.2026.08.27.07.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:49:22 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:49:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mario Six <mario.six@gdsys.cc>,
 George McCollister <george.mccollister@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Johan Jonker <jbx6244@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH] disk: part_mac: Remove the Apple Partition Map driver
Message-ID: <20260827144919.GD3959812@bill-the-cat>
References: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6CvJB0F+RHcxpCwT"
Content-Disposition: inline
In-Reply-To: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6CvJB0F+RHcxpCwT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:08:32AM +0400, Alexey Charkov wrote:

> The Apple Partition Map predates Advanced Format media by two decades.
> Apple never extended the format to cover 4 Kn logical blocks, has since
> withdrawn its documentation, and has shipped GPT on its own systems for
> almost as long. There is therefore no specification left to follow for
> the one property that matters here: where a partition map entry lives
> when a block is not 512 bytes.
>=20
> U-Boot's implementation reflects that. All three entry points read one
> block into a buffer sized after a 512-byte struct, so they smash the
> stack on any device with larger blocks, and part_test_mac() runs during
> partition probing on every block device. Sizing those buffers correctly
> is easy; deciding what the driver should then parse is not, and guessing
> at a layout Apple never defined helps nobody.
>=20
> Nothing in tree depends on the driver either: it has no test, no
> documentation and no MAINTAINERS entry, and the sole reference to
> PART_TYPE_MAC is its own partition driver registration.
>=20
> Drop it. Anyone who needs Apple Partition Map support for emulated
> hardware can bring it back along with a test.
>=20
> Link: https://patch.msgid.link/cb50976b-917f-4843-8b0d-dc2a32e59d65@canon=
ical.com
> Link: https://patch.msgid.link/20260825194528.GB523975@bill-the-cat
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6CvJB0F+RHcxpCwT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapBObAAKCRAr4qD1Cr/k
CqsyAQDbKW2AYsokK7d3J5FviufzP8rqwqly9jh508XCAm6YkwEAoXFZxncXadM/
Kn7L7J4oDIbxhWAd7aL5JNZG2PKrIwA=
=nHE2
-----END PGP SIGNATURE-----

--6CvJB0F+RHcxpCwT--
