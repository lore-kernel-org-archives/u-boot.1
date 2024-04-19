Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57680C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D578088766;
	Fri, 19 Apr 2024 18:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBafv/ZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A1788751; Fri, 19 Apr 2024 18:54:10 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261F188766
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a558f2ea763so50615766b.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545647; x=1714150447; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nBxLNpTa6465l/NP4KAl0YfmQiwJRu/pnep++quP5j8=;
 b=WBafv/ZWFnoqbPD0P/FVV2/TOneIscyDr7xgWIC8zz0NTPr+VYuJuqiPooVhyVFNwS
 QjYGEQgwDu+uWjCmmVDYffKc216NbErHZBuqVaVUekxoGbzBX6LyT6DjH/mELwik90+k
 5FIKIOekNKFScCkvqhpR83061E2/kl9pSZISChpRCQHu2eFUM2lX7zbDAjW7WAOHNb0/
 jxgayRBcqmBdCCtLCirEIJmplo/6eXYQIzbiljCdrStIPbLSy7c9lYmncE7SSot4lD7x
 q5MCxVhcRU+lIE5BfSWMtBsR7MfksTJQG0oOcMM67ABUA0WyrjgVhCj6/+s4vX6LYAVY
 0CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545647; x=1714150447;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nBxLNpTa6465l/NP4KAl0YfmQiwJRu/pnep++quP5j8=;
 b=e7j7fA1kixAHJnbo3pq7BvhwoIrMOP4fIky5BHEjHfZS67QzXgajach9LFouJj6sTO
 4eSoliRVB7oMuT+JL/zmSWQHiciotMOhaBzxiw5bjkPwAMbNja8wG84VEjeDfLlKEvhA
 610kz4g6AFWQkxMUfBnG8x4AfqJoLhI36zcMHsBwy6rm6oxoYoq7RfsH7Sv1tzCOc0r5
 RBXEm9j+tjKzMndueMOchXloubOKQe6z6ldLQqDJ1nkiiL4dQsVY226C2N0oUVLZd8xa
 p7HbPFa+bK2KkdsNI9qCZ5pur2DCheENNmkrLoXARpq+SFfnyXs/mG8xU5IvbDFxiPEU
 2raA==
X-Gm-Message-State: AOJu0YyR+uyfGprhQH0P+aERmv0x6nIFgXo/IJoWaB3tZlHKLJ/t5Rj8
 bd2EJ8cuIZBPz2nwOGTrhmV4HbrQYkr3jagZzJUXPs6yQY/DfehF
X-Google-Smtp-Source: AGHT+IEaU6hvwPhi1asFZc3i4vm+C60/tKudV4lCTPz+/FDha2v8m4BJZRhZj3MlUxw/6QoWwv6f+Q==
X-Received: by 2002:a17:906:ca50:b0:a51:cdfd:8ef7 with SMTP id
 jx16-20020a170906ca5000b00a51cdfd8ef7mr1813321ejb.39.1713545647442; 
 Fri, 19 Apr 2024 09:54:07 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a170906344800b00a4e2dc1283asm2401251ejb.50.2024.04.19.09.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:54:06 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=b3eb29ae2260f5f84151080e61f2c556940696e412e5c4d679bf01e24d33;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:54:06 +0200
Message-Id: <D0O98IL71YI5.QWG3ER9V1ZX6@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 11/18] video: tegra20: dc: clean framebuffer memory
 block
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-12-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-12-clamor95@gmail.com>
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

--b3eb29ae2260f5f84151080e61f2c556940696e412e5c4d679bf01e24d33
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> Fill the framebuffer memory with zeros to avoid visual glitches.
>
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 5 +++++
>  1 file changed, 5 insertions(+)

Makes sense:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--b3eb29ae2260f5f84151080e61f2c556940696e412e5c4d679bf01e24d33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYioa4ACgkQ3SOs138+
s6HwFQ//QE2kie5fwalHLHfYQqblC7xi0pkJO2Z/06K/BVdsRjfr+EIoHfk8Jl6M
DAb/kthCiPjhodxhg67bnPWTAz16bn6oOAfZaj8HqWWH7fO5bb+3QP1lf6VjHzsx
gL/lF1Ue8CtqRZ2lu8dgGZncTjO/QbAtcDmL/aaIK/eNqHnyADirhRX37yhJPF4y
wq0D+esx5IThgSg6j8PuWuZzEqKkEvoQfqzR9Qkd945/Lez6YcuG2kjGF3TaPY/x
a2Kff+hGNGGRGvs5JIVa+7uMbIAaT/AlYdy8SRmeZ86p0Mp8n2EDp984bgkeInR7
Ay7AmFbCMyeYpDZ3Lu1/4K2GQf1bp2tveJ6j9AWYY1Xq0JZIUkqJlNPqoNr4izUj
+ee6vlrv9pzxO8Nh46CGV+nxbNiFM53QfSc9phQxDsTEdg34Orq2H5avlgpyg0nV
cMoaLeqpOO9oiRutQkXUrGVjKgT+yNZ+ZEn7mcNeV1utsqUdOS0C/NSrz3t1g+V2
ejxtHA1TnRJG/+vzZbn3Bt8kP792XFqVS4CjHHT38MaqHm1znQQZfQynGUwVHW12
r355Seq/tA/itEuYiPgVmhEzYqivVFWdxOAb2YTieg3KpNxmLJNIyby6x8x5VRka
4/lGCH9u2boLImQdDwhYyTqCTelHu85oq5yOPNXeMCa7NsZl8y4=
=FZIM
-----END PGP SIGNATURE-----

--b3eb29ae2260f5f84151080e61f2c556940696e412e5c4d679bf01e24d33--
