Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F626F9D0EC
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 19:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C6E841CD;
	Tue, 14 Apr 2026 21:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MJ3/U+Ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2868421E; Tue, 14 Apr 2026 21:23:09 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E4680086
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 21:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbb6c072f1so5513814a34.2
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776194584; x=1776799384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Snp4KJmF4JmJdmdPscmWpvyS6Wd5mT9ZExYJ1soyMU=;
 b=MJ3/U+AdoJQ4H6Pa01vWETF28IQPCZTD1DUtf8OlpzERXsg7VeIdb8IStcZp41Z5SW
 SDIlqEFPsANZX4CpVwZ7AAORgdZ9XQI/bQovHttRC/QQ1JteM47nAym2N7zM4sI/89bU
 PqzXScY3Vl4AuhmWqovFkW+YPu6bPEbtT9KXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776194584; x=1776799384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Snp4KJmF4JmJdmdPscmWpvyS6Wd5mT9ZExYJ1soyMU=;
 b=GNfs94IXqTJhV1iW3vYNinBVIF7xn0zX1mtQqlcU15dsemlQFocZxCkqnA05GFUPwr
 8QCWic7BSL3J7g7hk797q+ut9s4hhyZxGvPQGjgPndiUaw0DkbD//3GsSBrFXqWvXuwK
 QDBkGr2IwHDdDXpbhzALOY2EPYKdN05+tf07QnAm0Z4jHpmFkqpPdkHNyu5ED92/mRIG
 ot2XJZAWM/J4U7F+hygYlZl30AXVMMbbnwcQC21OVztliYeU1oSbrcyZQh56bZ/jPP7M
 vj9w214sYgpwNR7sMdk8INH425Jo5hGhO6NmrJ1VFT9aTmzFfc3xZQcNzYtz9Vk8jvcV
 r4aQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7qlPAflZCD10ML+dfTX2XLvb6ZWpREWAiq5foyV5zj9FiSU2bWc6Xos+iTRZSd3jmLX1QLE8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8GSvJ9ndxK6+7f3++ujPc872QUi9eKcHjMXR3/djoFMA4w2Ai
 LMkmb9SUDBAI0XutaYnu/pQICaXWn3suPPEYZ1COtLg+O+5UOnY7sl4/36glafX0Iv8=
X-Gm-Gg: AeBDieuaYV/5ZmX7o9U9xKNBuaBJvZYQfBNl87ZUZ05FL21gROaoGE21acYtF7IBVsV
 Bi840j/+eteSYImtHyu3+dILZuhZ6sWgrZlWctv56Xjmbsx+50dLr5acG8OUJf8ciV7a572tECy
 CNKysSVb7cbLgwrKyTAmdM24QoFWS3kxX69B3VlxN2KqrR5t+02X+mUZCZnCedU2pC4kA+wTFG/
 imKF1v8Bm6t2H9jL0tJ4izqLGV9PJyW2b5mi/z/ZZHKubDSfmpxMlDSn84OJ7lEaX7xoy59VY6u
 kmX3xcvclGL4w5sCASzu6WcXfstTSa3FyGwvbzfcgUBA1qLdlUNz/y3eTVDX86vCVygR4wXTLqs
 WbFUa8OUAeAfSXo5m9Izq2KByhGRE6bWW3Ko1cfppmEGylp3XriPVUm5R2GNvey3X/ui1/cMfQA
 TRSVbXnI7/fho+OPEqBQDYi8I/Se7y4V7Oj0ieBxn+d3+AZ5C3V1WrUsJaARxUL5rQ0r4JPZs7G
 bI7zuUHV9p1U+rviHmmoYK0P2XYH0ccPtYkpEiYMaLoEZ2ghlxF6QiLt+aw3w==
X-Received: by 2002:a05:6830:358e:b0:7d7:fbe5:e9be with SMTP id
 46e09a7af769-7dc27e0f792mr11853395a34.20.1776194583543; 
 Tue, 14 Apr 2026 12:23:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm8680484a34.9.2026.04.14.12.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 12:23:02 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:23:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v4 4/6] virtio: cmd: Depend on VIRTIO_BLK
Message-ID: <20260414192300.GN41863@bill-the-cat>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-5-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AmbPdUT/rinLToVr"
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-5-daniel@thingy.jp>
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


--AmbPdUT/rinLToVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 06:22:38PM +0900, Daniel Palmer wrote:

> The virtio command is calling virtio blk functions but currently
> depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
> causes the final link to fail.
>=20
> Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
> on just CONFIG_VIRTIO_BLK
>=20
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--AmbPdUT/rinLToVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad6UEAAKCRAr4qD1Cr/k
CkVdAQDMCm+9ej9nBJORkS5R2KEcYSFsRbgyt57A83sKZid7CAD/e0wPf6/21IyO
kk6Dc3jicMmCbSp1kJc/+2JdXU6jygk=
=WiyZ
-----END PGP SIGNATURE-----

--AmbPdUT/rinLToVr--
