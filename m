Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F109C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 21:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D44088A4E;
	Mon, 22 Apr 2024 23:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHiK6vlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E5988A46; Mon, 22 Apr 2024 23:11:42 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6E188A4E
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69b59c10720so21112906d6.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713820297; x=1714425097; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfbXGzd4uha5dzyZHM4RU134vy3j/ktITPtjbjvP2DM=;
 b=tHiK6vlSa35k/kh+lTWNCKTY3Em2phz62nRbTOhCjksXPCibz6j9DpwVUr2KnKE5U6
 j4wr6ySSPh4T/mW2gfHFXg2ZcscJmhzKBKKM95/sHAI4S36D0N1dV+j1RvSpXz7zHTO8
 0MEvSni6XbegE8BMVz+pL0y52D3y4BfwmqoGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713820297; x=1714425097;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfbXGzd4uha5dzyZHM4RU134vy3j/ktITPtjbjvP2DM=;
 b=lL1tcKJviLHCoN497B+dGJy34Q7Eq+ucvTlHVQi/Z9iYasjxwvsQ8Y+phOlodgxvrZ
 PigkQUWww87hDU3NvQRKoIgKxC/Y7aVPluQw7fgKhLQSQhBw89OJfnMogNzdLiId+SFS
 K48/YQxrBLlZiaDuWsUEtr516XfgHKU7ycphcSDgOADgvFVMt0C79B2jk7Rz1lyf0BZ3
 9mK+THrn/YOARagnMOxlITTRC0eLUTwq/77OFIx/did5oobJnM1MkOREW39q01pzELB8
 jN/mQdnkarzMTmXc8Kak5Bhx3O1VZaJchEIVd0ST+2Wol5sd9ifj1VwGsA/zGuksYEFg
 5zJw==
X-Gm-Message-State: AOJu0Yysi0yF6YSeQ1XeLwQoCaI9jQsjBKKSLCGKaB592gdqO129Kl+N
 cKbcLfjMTccGaqvtQIUNnvhNjPfY3mj+5beYLHt3062OrLsgoG2vGMXCZIopjIJ7oQvKN13Q0Tn
 aEh55WA==
X-Google-Smtp-Source: AGHT+IGJz9vFy5F+r6R2kUwVg9jIdtkjB2lH9e/Um+WvXAQJhzPzNbKqOPI+BdB+84p7lMlJle3YzQ==
X-Received: by 2002:a05:6214:e4c:b0:6a0:7a38:6e83 with SMTP id
 o12-20020a0562140e4c00b006a07a386e83mr7911915qvc.37.1713820296808; 
 Mon, 22 Apr 2024 14:11:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a0ca68a000000b0069b432df140sm2117670qva.121.2024.04.22.14.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 14:11:36 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:11:33 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07-rc1 released
Message-ID: <20240422211133.GX1054907@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IoXg7I5f59bjRXDk"
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


--IoXg7I5f59bjRXDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc1. Looking at my own queue, I think
things are overall good. There's a few changes I want to pull in still
(mainly moving more things to OF_UPSTREAM) but since they were recently
posted I'll wait a little bit.

In terms of a changelog,=20
git log --merges v2024.04..v2024.07-rc1
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday, July 1st, 2024. Thanks
all!

--=20
Tom

--IoXg7I5f59bjRXDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYm0oUACgkQFHw5/5Y0
tyznKAv+JFyxCFn9QdcAG+Gu3FADgRTEdQlMwa5chWD1zmnhDw8Cgm+Hwq1i8bP8
ivSKv0G0mGx61Jx93ywIuBByL5jMazPFf5f9/thEpFJhXZNdImgziQ9CL9F5EHUQ
tTaQ3J7xFBmoF3O1FiVY3oCEglBARToBgBTy58kMVlzzfECHrJO4WqCaKz2rHkev
zSvVO83UfvYYg6akm99xx/7f5XjAmF6Js3S0D5rjxTYXs3urMETs90G0roZm7jEG
OLjFpP7fn/iZPw5VstK8k8ax1IRmoFYsRCxjhHElsQ+rsHtMrMU+qshLYpufCJzj
WbhTP3hZh4h/ONGAhCB95N3/a1EshGGHzifzlg3plzWenHZYvV1Mjs1f9FEaXuxt
dd+FFGs4SvtOFsXm86c/6VxMbDoO7mVPTfTreo+R19kjNH7eK4nyBKVmnf33cAX+
tMUvHf3jmGo+GNftdT64ojaKDcnJgYQOveUABMblkVyGCV9pH1zQobJzVdBNN/UA
PVvfFGtV
=7BJ8
-----END PGP SIGNATURE-----

--IoXg7I5f59bjRXDk--
