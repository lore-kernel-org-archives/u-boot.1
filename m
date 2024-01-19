Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93FFC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A793587D13;
	Fri, 19 Jan 2024 17:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JocHQ9cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F0D387CB6; Fri, 19 Jan 2024 17:08:28 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D40787CB6
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff88cbbcceso8637317b3.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680505; x=1706285305; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TBiD+TtELk84eN/ouaWLI/jcS9vEwni+p2hKVCdkEDk=;
 b=JocHQ9cbu1RswWQtW8rZsMNTq0Y6JnY0e92hpfA5GzzFR8K1H0eabvmsd+2sbv6hZX
 D10p6/weiySS/yZkx90Gzl03uDP6YjFcnfPrs9hlyMiJvzl2QWs8PiInW8Q9R591YKAh
 qTNB3FFvRyiwWRnQFzh5fZ/9JGrcbAaIQTkjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680505; x=1706285305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBiD+TtELk84eN/ouaWLI/jcS9vEwni+p2hKVCdkEDk=;
 b=Ponc2EyV60+Dpjj8kPdqTO6GgwqEQh0MzsbL99HdhVIJ2wbvcnxtLyoSTlPwkqd5OM
 X7yZCbEbyGUqaZMU31QQRu4k+Z231ENeIMlqO6KVInNugnV+y5hh1msWDuKqiKd7+MDD
 HAqm/SUWxdnvnyRjAIVHyvWmPZIRwePC8/ezsed47mjlBFtuTOGSUvU6VbxP7oVLJC16
 DagofeH1tOZ5mX7RPRpom8mMU1UDN5WGJ587EtMfROxHWqKM3nAC0jJ1b1rAg1u6WAQk
 kOdGkxrHeuD8vFUe+fWx3sASsLLKoH6qzUNDw4/1Akvs0WMAO9Nzkh16qkzWOnNoL2lk
 pdWw==
X-Gm-Message-State: AOJu0Yw7axpowNuwHJNZvMTbGYa/JBoFh1g1pmuwNzfp/T5WLaDNKFSh
 /vox5k/DZISW/OfI51v6yO5E4w6Y13EsmNcNN8oA0HM5seEZHinMmdw6QhwIxL0=
X-Google-Smtp-Source: AGHT+IFnnRk3Vosd5QWXXw9v5OKk412P6O4weXEJzvIwkkPPFzErpBYVIh+KFFkuEwvXMp7IpSC9Rg==
X-Received: by 2002:a81:a20b:0:b0:5f6:e8c8:9b6c with SMTP id
 w11-20020a81a20b000000b005f6e8c89b6cmr123454ywg.46.1705680504991; 
 Fri, 19 Jan 2024 08:08:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 gq8-20020a05690c444800b005ff992b46cesm716403ywb.36.2024.01.19.08.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:24 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [resend PATCH] bootdev: avoid infinite probe loop
Message-ID: <20240119160822.GL12635@bill-the-cat>
References: <20240104160346.285881-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bZwgcxBQ1CDavKPF"
Content-Disposition: inline
In-Reply-To: <20240104160346.285881-1-caleb.connolly@linaro.org>
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


--bZwgcxBQ1CDavKPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 04:03:35PM +0000, Caleb Connolly wrote:

> Sometimes, when only one bootdev is available, and it fails to probe, we
> end up in an infinite loop calling probe() on the same device over and
> over. With only debug level log output.
>=20
> Break the loop if we fail to probe the same device twice in a row, and
> promote the probe failure message to log_warning().
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--bZwgcxBQ1CDavKPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnnYACgkQFHw5/5Y0
tywVkAv/RXz6IGaep7lkL2HhghSXG1ykNO42fp0nf3RM5MguwsLsNYwrtd1t1dvQ
2RNJwK+pKh8rKfddaPPHhrT4N+zyR9LV9K+SJ9zF9wKyYDVStmSh9tLcMwDfkUqO
5sXYIJIL3d1LnjbWNbIMP4a0p52CXpwjgg24JYrlU6B7ZqIsME/+2n6q0FcKTU8+
mcqju0Wol3XxOCa+4s6tehIj7+riEJ6T+FyvC86Zc5p5AE1+JATaIsQH0ocnIflD
Q2olN6emNLgHxUtDz1iFv97eo9OliZXZLI18ZlIPspG+yJGRMjMXlxbsSASrtOeg
Oaif5EEy3Wm6sajR+vVgGi83+AhnF4pyhXWibV9kcRoH32Jb7lCJUPddLivEW2ir
1mXQsxoiZO7KX+8dOv4XoDkPwWXdCLUqfOgwKgZsRpos6cEkvClPQT5Hd9hMApaJ
vr1vxARPfBbc2mFE0IBx9zPy5cn71rgeam93lfZFo6nSnMDTFFyqwXssWBtNTjV5
/5v4nMrl
=tgCv
-----END PGP SIGNATURE-----

--bZwgcxBQ1CDavKPF--
