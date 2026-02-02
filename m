Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F14E73165
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 19:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65DC83E76;
	Mon,  2 Feb 2026 20:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aiF5T7VG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860EA83F2D; Mon,  2 Feb 2026 20:29:26 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779A983E69
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 20:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1890f7ee4so2957091a34.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770060563; x=1770665363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sibaI65mLM7WcseMyxbEceIMEqcKuGJk9nqvEEmO2/E=;
 b=aiF5T7VGJKoZFtbvYN3oFqCdyiiD1nVKR4laB1OLBxBpdV4LE32169ZzfdgAFsK/tx
 HCVkxvVRsAtWwhXcRa1oizEnOOr7CxWNoZT7kb8YnYe6q7FH6iy+q6+RKbaohknApL8m
 0qAphjvJKSsDXPExTcUXygsdcSKZ2odXZHTp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770060563; x=1770665363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sibaI65mLM7WcseMyxbEceIMEqcKuGJk9nqvEEmO2/E=;
 b=NYXLD8WDSO8aK73RyzsjNhy++/pvvVNSm8LTFwQYr+4cKPXOyQEypAIYQ7iTikBx+T
 v1Q45Gpx/Ggo2Mvwc0WlT9AK4Gj0mP96l/TGssbytMXmdrprYZZqok02W6xILzhRfgP7
 TavogNjVc1D3v3ggbYaoimrdTrzg+NwlWRW7bOpSgSpbrv6F0nfJUlR52/y+M6GGdkuo
 0504E+KyScIrijJzEaAZOosHKi8XOAtFgP/DEi9QXyEESUO+t6bVl33Kgg4qWJpiSRxa
 rpjkC/ylFbD1wsNEbxf6FpIfgUVh4hoGveN35nEc+PQ2E3kTM+RAukx2YoM3lLz6RM9/
 oecg==
X-Gm-Message-State: AOJu0Yzg3vKS6ETw9aG5cICr0vkFfgymGfNxs1niRsDkBhzZaBypQcwk
 YEjxXapm9Uyu5mm3x4pBbRBidjJPXTLEf1O4J1VZLYb6fKxp/dKAnepIXHnTebmcRZJEufCa6aH
 irgJmZ64=
X-Gm-Gg: AZuq6aLhAJUdXTXIEWpuqD+68xvE8IhFIzKrS24xyRVhiuS95LxNfYRlK2zLGrU37H2
 19D8J41vqH2udPamTSrogUCbJTTxb4mdMYD1DFJTKkxMdKvza710QHitvm0I4kMPE0XgJTESLSE
 LZVpf7oaPoz6rC5ZME7Ey6UXdqpTfTF3U9r8IldHBDWatBLmjJlVNlPNevLXoaRx1wt0RCHC95R
 Aps06ZIO2Iu00iwEAPH1uixxwFepdQO7//7N/3jVcmzA/K9lAPsosF+yM0VX0syEUpsHCZla+L0
 kvU5pjQ2JuCLI3NZtn6S/epGAOwWlHpQWdtldKIvytnqNTpDu8SovblqDMrfrnPBGBztsiShExi
 AlLalvXdoGKyNx8n3ZeZhV36WWCRVIhQNv9hctwWITkQIcfLy5Ap6mQG/nxuZ6lwwPh0iX2NNl7
 A+0fiy6wXMv2cv9Qz5euAypLHGGS3CJ23JDCk/x3MmIPgekd7p1/2aPhJVd8Z+orzdlpsddjRmH
 X0GUK0gdiL9CKK/zYMmHCREFC8qDbS8ToW9rc4=
X-Received: by 2002:a05:6830:828c:b0:7c7:1c91:1258 with SMTP id
 46e09a7af769-7d1a5328dc4mr6314457a34.26.1770060563138; 
 Mon, 02 Feb 2026 11:29:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c67065esm11083659a34.6.2026.02.02.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 11:29:22 -0800 (PST)
Date: Mon, 2 Feb 2026 13:29:20 -0600
From: Tom Rini <trini@konsulko.com>
To: vagrant@debian.org
Cc: u-boot@lists.denx.de, Green Wan <green.wan@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 1/2] env: Provide another work-around for unquoting fdtfile
Message-ID: <20260202192920.GD2603314@bill-the-cat>
References: <20260130040424.472735-1-vagrant@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JenhFH5JuZcIh9jU"
Content-Disposition: inline
In-Reply-To: <20260130040424.472735-1-vagrant@debian.org>
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


--JenhFH5JuZcIh9jU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 08:04:23PM -0800, vagrant@debian.org wrote:

> From: Vagrant Cascadian <vagrant@debian.org>
>=20
> Some boards use CONFIG_DEFAULT_FDT_FILE to specify the value of
> fdtfile, althugh the quotes get embedded in the value.
>=20
> Provide DEFAULT_FDT_FILE with the quotes stripped.
>=20
> This is a similar work-around to the one provided in commit
> d085e692c98d0d7b57cc577ed9befda159cd4a40 for
> CONFIG_DEFAULT_DEVICE_TREE.
>=20
> Signed-off-by: Vagrant Cascadian <vagrant@debian.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--JenhFH5JuZcIh9jU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYD7CAAKCRAr4qD1Cr/k
CgTTAP9Y+HZ7rtwcUdyNTrMp8tOMAZEKB66uT6Lc2mMQdKWQ+QEAp8iqHvroZ6u/
Ecs4NWqN4a1RwbBBjxvd4KU/tkkWzAw=
=94ZA
-----END PGP SIGNATURE-----

--JenhFH5JuZcIh9jU--
