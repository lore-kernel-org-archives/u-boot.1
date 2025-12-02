Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B007D1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B10683EA6;
	Tue,  2 Dec 2025 19:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2bin2Z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DA583E9F; Tue,  2 Dec 2025 19:24:12 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A388983EA6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75387bb27so1885012a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764699846; x=1765304646; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWZOGhq0uky7S/1EfdCkrAAeN58MHHPjJcbljiD97VQ=;
 b=H2bin2Z+FOK0yC8UpOA+jwByDRX9xP7ueRt4IDENA7t4kOfscM2i+Me+z7wu3nRrZ/
 8Zrx5G3CzryDfdYPDSm1BrSexu8NlSrfP+HvbrD/a5Hi+rnPZFCuL7D3WVLoSUg7skw9
 Zscz6ArbREyuojdjKdrsRqIM1KAJ83/Jh29jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764699846; x=1765304646;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWZOGhq0uky7S/1EfdCkrAAeN58MHHPjJcbljiD97VQ=;
 b=rpYeyba/HZsnIHioo3ptTeM5ylZ+aY1NkZ3RFxUGeuPmJAbisE20BQHwIDi/wEwKdu
 4I4asuyYJJNNXDVFlO6Liwpo27zDZxvHaNsBN7duAF5EmUz/ZgDb+4oiWof5vXjjF8J+
 uBa0TX5JyiBb9DH+4PHzfLzTsngJTswdHXRhyseB+/l1MYSG3D8v8fp2Xv2s/xodohP3
 RZ1M9ZfKXrSNvdftCSAxElHUxkeZJQXEOlo6L5NE5/6YahtuPuRMtZrtDLg5mTlWHjxu
 SHJnFo9ynAVk/CmsD3EqO6Jmdfappb8sB8bL973+dVD1UXXCw3Rcf//rNm52+459OQS9
 bW+g==
X-Gm-Message-State: AOJu0Yz8kl4TVQxVDJwsocKN8TjdMu4NaWgDW/fG1ZzwjrKZPX/io4HI
 H3lpGq0sIOl9pAy9oAiAkmzjKy0Wwu35JRkfmwOpaqoTzz+MTb0h3XzId0biqv8tHguC7shnqH1
 IYR+KCSU=
X-Gm-Gg: ASbGncs7dhEB345jQm/+RrxQYH8SRvxJT1AwKIA2P/ryskW5o6+GgDTHa5zcYIK78ZF
 CPoXknIeuLCLNO6Jt9Jh1tG5VLufvslXMeSAeAQyqMFKoTDT1SsWaY92qfaJwm1K+km2dndNz8P
 Y5bp3rOPgwpH0PUeaQUUa7yCJj3Sn/cKTm+mg6RerG/Xc0QqCKAjc67j2CJiGaC3hhekPFjl3I4
 xxTs4oLSCWD7OC5irHLZJJU0AMwJA8R3vZ1FOFoUN3SBq3ywg/A+TtlnTPgZfb1NCEoSOeXaOes
 wIJpnpgURJROcYJiIK/u3jCFPfGhPjuzubqA7qQAbXAGTKiNvrSBFviNyMwawbzdnKVqQfC3wTL
 0Uz3LESIP1KcQMkhPSAEh9fRi5Iub7mdqm4dcCkyl0ZFKNzJDzEQTGv3y7pUPhsP2Dnxz8cJIXU
 /q8Z9UGO79dyWgOZK6Bf68FnOrlTNX4Nnn+sa7R0Hh7uAiAreihjrtOQzyZY2D
X-Google-Smtp-Source: AGHT+IEvnNsK3h/0rjuWq7W7FGq0KypNwef9ybN6HQYqCnsUPuuKtiJUh5Ke/u+sz951jcvUV6y3LA==
X-Received: by 2002:a05:6830:674a:b0:7c7:62bd:7fac with SMTP id
 46e09a7af769-7c798b02758mr18286431a34.9.1764699846250; 
 Tue, 02 Dec 2025 10:24:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7d73sm7015962a34.3.2025.12.02.10.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 10:24:05 -0800 (PST)
Date: Tue, 2 Dec 2025 12:24:03 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202182403.GF303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hpg8Af27m9+BG5ao"
Content-Disposition: inline
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


--Hpg8Af27m9+BG5ao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I am wondering if at this point in time, anyone still builds our host
tools (fw_printenv / fw_getenv, a few others) to run on macOS or
Windows, natively.

I ask for two reasons. The first of which is that a reason we still have
to support Azure (despite its slowness) for CI is it's where we have
macOS and Windows hosts. But at this point in time there's so many ways
to have Linux userspace running on Windows or macOS that I don't know
that there's any value to these builds.

The second reason is more macOS specific and is that with:

commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date:   Thu Nov 13 12:54:51 2025 +0100

    boot: Assure FDT is always at 8-byte aligned address
   =20
    The fitImage may contain FDT at 4-byte aligned address, because alignme=
nt
    of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be =
at
    8-byte aligned address. Make sure that the DTs embedded in fitImages are
    always used from 8-byte aligned addresses. In case the DT is decompress=
ed,
    make sure the target buffer is 8-byte aligned. In case the DT is only
    loaded, make sure the target buffer is 8-byte aligned too.
   =20
    Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Which does things we must do, we now don't build on macOS. Why? As best
I can tell (and for a general purpose OS, is a good call), memalign(..)
doesn't exist and you need to use posix_memalign, a not drop-in
replacement. We could spend some time reworking the code here for that,
but for now I've instead gone with this workaround so that CI can
continue:
https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/

But longer term, unless people say they need and use these tools, I'm
inclined to remove them from CI and remove this workaround, for the
v2026.04 release.

--=20
Tom

--Hpg8Af27m9+BG5ao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS8uvwAKCRAr4qD1Cr/k
CgEoAQClpOMloGwS5nqRv0Hb60FGH2eNgYPuETw9vI7QspaiegEAxpi7pDo1dqLu
D3BtUHbjSDdVfuKavCk5mJA7QPNBTQU=
=sAYd
-----END PGP SIGNATURE-----

--Hpg8Af27m9+BG5ao--
