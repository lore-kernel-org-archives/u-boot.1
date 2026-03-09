Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A8F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5A383F1F;
	Mon,  9 Mar 2026 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxCZzkmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279DA83A8C; Mon,  9 Mar 2026 16:26:11 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAF383F1F
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d741f61ee5so1252819a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069964; x=1773674764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sJX77lhRTqnE54nYAjn1xPUIqwVxjx6ApwOY4recnzM=;
 b=sxCZzkmLA2/OfLYJkzdZgRfjTL61dLC29Me9zjO48WGOSlkOEr+GmY/zissQGRmdFq
 fk3fiHWrciVTLpll8mhfz65xBhKPlvGTo7l+8f3fQHopQI5GNThWW5JrbZMBfGMkaSM5
 63ZYnHkC1hucHGcoGxG+tft86U4p9izHjvN5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069964; x=1773674764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJX77lhRTqnE54nYAjn1xPUIqwVxjx6ApwOY4recnzM=;
 b=GsanNPJWrP1tPcb+8sy/gu4OeIhuu70gm02fA6zubTt645+2DzyQt/OwH3Z/AYwjz4
 ahpPzxvhgEVyou/NpGiIK00BtQTahWdOWtEfSS6st5nTbhb291dJQ5mZs2FUJL/K+ZuZ
 QiViVKz+gClA/vfpqM3X+WWGbtxDvdqQhTucOJ5zErFIW8wLMhuEoxQYZMZUQlt3r+Xv
 3LzPK0Y4Ol+PZAw9iIodf3RZR2mg0XK3h2J87tpgf340u3DvUsNxRrgMQCFZ1QtI6wUE
 RiiR4HWg4DbCUB9o/jseYDhH9TybNcc+4GITkYuLZPdCkCVZBKrepgdCOQjYHV619X43
 IKVQ==
X-Gm-Message-State: AOJu0Yw6F/GMHHRdLyMUMHYra0VRkQL/ngjnXiuK4AOC8mpJVA9wJ74Y
 7AEcUTFKbioarHCSESb5kULbGM+9Ts9BahncLA7sghGHJKFJnvU9lrNHldtYAOnS22qdCGphhdb
 HkUyV8J0=
X-Gm-Gg: ATEYQzxnBwpXWiBMT/WfIoib613jJcxdTsecgc2VAtC39k2vvlH76oXF7TatzyLsiDx
 rs5pMRmY9TDF6xgq8SmakussNywX8QFS6nBsc9zCGVRpVQPKV/PvBuyfatlt/i8a0aHbBSvvPsE
 iPEvxzS8bxETQRDvDzPwY5V54YKoCzcyUcqRTE5Jtp6AnRtAwfvVvX+pjeWpnhLBVexGmOmbI9w
 XmWB71mcSdAz87MkVDVWqThlkSVbyYd3G+voqMUuTYpqCbgt2d+WGnPhm8wD5AKojY28cS0pG/4
 3lbi6HokiEwaK2hxXZTNCHgVar3ycDgUxfXe+2aUqZj55PuyTcnT8mfrj/L1CeyrmCSa8E9EVdk
 YT8ecnf0LEKCOgunw0Fzk9bDtJBFSekbC0I3YzjNChFFK5IrcoImgkZaH6V57OAXaIgczwK0MnJ
 mo3CXSRJPy1tnNyX+bMDzy/tlk5MNVzQK6gcpdYerZBjqtLNhyOGoXPL+6s7f3SYBpz7y1Pi9CX
 isV5PqX/NZsk98qiCYVOpTN5XXE5Gi63uqy1tUVUwpuKg==
X-Received: by 2002:a05:6830:81d1:b0:7d7:48cc:ccdb with SMTP id
 46e09a7af769-7d748cccd6emr2392272a34.19.1773069963960; 
 Mon, 09 Mar 2026 08:26:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74062da77sm3625497a34.18.2026.03.09.08.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:26:03 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:26:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 1/5] test: fs_helper: Allow passing the image filename
Message-ID: <20260309152601.GZ1388590@bill-the-cat>
References: <20260309151307.831537-1-sjg@chromium.org>
 <20260309151307.831537-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVAH6KclVVEZ6BtF"
Content-Disposition: inline
In-Reply-To: <20260309151307.831537-2-sjg@chromium.org>
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


--PVAH6KclVVEZ6BtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 09:13:00AM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The mk_fs() function always generates its own image filename from the
> prefix and fs_type. Some callers need to specify a custom leaf name
> while still keeping the image under the persistent-data directory.
>=20
> Add an fs_img parameter that accepts a leaf filename. When provided,
> it is joined with persistent_data_dir instead of the default name.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PVAH6KclVVEZ6BtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa7mhgAKCRAr4qD1Cr/k
Cs17AQCtdhGjXBpD0d3Ep+WlvlcTZcHXc4GCyaB2Z0iV+WZ3HwEApNH19tdZKvID
f+qXbHPunwJFr4E8zf9TnG3YSx9yGQs=
=XhAw
-----END PGP SIGNATURE-----

--PVAH6KclVVEZ6BtF--
