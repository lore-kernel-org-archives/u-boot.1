Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78949E6ADF9
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 22:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FF584131;
	Mon, 22 Dec 2025 23:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FeOwMovV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB96783F4C; Mon, 22 Dec 2025 23:31:46 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339F9840CC
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 23:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3063835a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766442701; x=1767047501; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5uu6hbNDqgm26iROgN7LSUh+EIqHpiZF9NTowIK9Lfo=;
 b=FeOwMovVSGMg24k4KUEeXk++ofUkl7j9DX0yccVM3Lk1jjs1whUlADAuJ1nbKLm5tX
 oy8HxLjIHA6zQBzDiQtHVReBO3KdFA/lhmNMkAV1liA16JDtw0u9yHM+skCbK1W7rb2Q
 wJgLq2gl8lLEU2+w17RBL3fGgAGc/8jXWRkc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442701; x=1767047501;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uu6hbNDqgm26iROgN7LSUh+EIqHpiZF9NTowIK9Lfo=;
 b=IO2TkLx7uFL6rx31GRQS9TuScBppfkhGkV6Ec43Y0P3nVev4PKb+JK3YcRC1bxhKN3
 1IWfE1Fds/iH9yIUcmZMfx2WL2qKK3B89OQQHUdvxabd48MlmbD+VT9Lg7YzYcJBvFlU
 Fn8EgAM3tXiltlHAKrcjnaBcm2vskytQwqg93D/ndqF6N1KgonjRENY07zCprd1CC5l1
 vpgzRezUZMQjM6KxJ57L5wyz2VXl+miM2c0z/L6E6Dj6I6TnD3jMpLm87r2Y30Pmlx7+
 k2f5vhx06EzReBacKsq73BSpJJOokGpkt3c96kCx60ddGRl21LRJ5Dg1obVxruxJjw79
 nOwg==
X-Gm-Message-State: AOJu0YxL+CmbprZjEZellnsR3scjiFhUclokIvxEaRy0PAJX5KnCAJm+
 mQ3c3R4aBhiApeYV2CJVmFejL3AwqFI0qt2IJ2hJL5BlBV00xcXK6Mn8oh7AbRECCjpy+pVAcAW
 V8MAneNg=
X-Gm-Gg: AY/fxX5HihES3wgz0CGF+RJbwkW/mdQjiJJGlNQN1WWBpX7AaCHJ0TAaEXYpXSBP7hM
 TqpLNDv62ZAYqDO/T5VIDqKdi/ir2+TLg+ASVzX3vZWQgZvW+SI7znwc+ma5btyUK+BzoYkqs8y
 28og1JFKm5uHIX74IGCUEceqAqYPCbJ0jfYZfwEuSej6e4fzfImY4lp6EmeQvsBJAOU5/2jDH7T
 AnlKju+BOyZy0r3DP0pBsN70m9Lp6BUTQtMoOsnLLzQgIPC35hgez0ZUeLwhhd80/OycRs/q4iu
 mj2MpV3IHqio+ixG2vLhfqYf0Q3He4YNNAZY+U9QwdTgFYpPfA9UorOrzkpCNJXLXTwbDRT44It
 FjyBZ+1HFrKme4nja1FMILwF+xuTM7hQ5H5nxp/LeYlwilhJEl5xsCp5VSb/iFdoZ5X2qZdsZLO
 EOcLhhAeB4U8sNkQ5yH3xQOCMVx3oJShcDizFUzJS1NlolQOjwhg==
X-Google-Smtp-Source: AGHT+IGfsxHdwhfhRGT7YXnMDoGcer8feI5ognCVu/QUFInzdLvfFCIDVyQnjKo6yUZqSA+UR+8m8A==
X-Received: by 2002:a05:6830:4410:b0:7ca:ea23:f851 with SMTP id
 46e09a7af769-7cc668c4a26mr7095644a34.13.1766442700932; 
 Mon, 22 Dec 2025 14:31:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d7f1dsm8185415a34.15.2025.12.22.14.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 14:31:40 -0800 (PST)
Date: Mon, 22 Dec 2025 16:31:38 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.01-rc5 released
Message-ID: <20251222223138.GD847766@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6qFHos5mICec7U4H"
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


--6qFHos5mICec7U4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It is once again release day, and so here is -rc5. Given the upcoming
holidays between here and release day in much of the world, I'm hoping
for very little changes between here and release. I'm quite happy to see
pull requests for the next branch of changes people have outstanding,
and as always if people know of regression fixes that haven't been
picked up please point them out to me.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZGNsNT=
h2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfMjAyNTEwMjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
December 23rd, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Assorted minor to us security fixes
- Scattered code corrections
- Some rockchip and stm32 and TI specific fixes.

This is the last scheduled rc before the final release which will be on
05 January 2026.

Thanks all!

--=20
Tom

--6qFHos5mICec7U4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUnGygAKCRAr4qD1Cr/k
CvnaAP9RHoRwVoflrBf9FQbPrDdQLXGs2bxWg0skbnMeZftnugD+IdXTxjt22zsj
vzvex/1wkfzaTIrMqRQyn/Uva+U25wU=
=Ie/N
-----END PGP SIGNATURE-----

--6qFHos5mICec7U4H--
