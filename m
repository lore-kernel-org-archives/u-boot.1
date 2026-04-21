Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A62F8FA86
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37756839D5;
	Tue, 21 Apr 2026 16:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L5d2cqOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729A283A91; Tue, 21 Apr 2026 16:47:20 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E20801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dca4debedaso3083212a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776782837; x=1777387637; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pz/9j0gh0uxD9p4wTH9bmHRifWoWoFDBRHPMAadB4Zg=;
 b=L5d2cqOnbpnQbMUQ6do6BsCcGeIG6PrxrHrIrE1E3xEOSLC4lm3H1YhJsID33BiG0i
 GF+jVe4W2Xt1uofyfJqAegcD4RorZ9vSKq0iCHz+LIVCZPlhdLa2dWyosgiaS8ZGd7rS
 qB9HRmpuo3LJDk0ASstIO1CMJUuqUeCsb0Tio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776782837; x=1777387637;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pz/9j0gh0uxD9p4wTH9bmHRifWoWoFDBRHPMAadB4Zg=;
 b=cslLjjLmUV2FTgdCIGudRwZ571+6LINwPHds7B3xahC9KnHOcQ+J0BJmGUNOxObrZn
 x/w291sEJ+4IPzF0pADZoRbNAS9nkizf676qNtMAA8xxKaeYGec2iBui6CIw0jpeN2Gy
 dLy1RDwInK3evu1GWeIAiHte24xn/A1C4RDcmPGbXCks+5Ao7mj4j9O327KA6JUYKxq/
 wsalGEcnmbJxvDxc4n/EqJ2Pi/zQ8LIRzsRh10sEG+nfFx75tthazzxSn9FyM01nwUfm
 oe5ev/QBddMDAAraGW9uCLRwChy9bFHAXiPFCa5LGwCM/dam4Lt9lif0rAKqnVk0w/0n
 TBZQ==
X-Gm-Message-State: AOJu0YzDDdXdQT4KI2Qwtkf+6PZraYMxg4HfEOTTmG5lEEkSEyWqrC4D
 ypHxvF5oCIWPnpdbmnQsGu7guPSDZgCxeu+GzPUIQmjxmmDqVENp+6womqRv2ls7jZ8GtgZV4KL
 Cs02tDH1MnQ==
X-Gm-Gg: AeBDietQnYhfH/vJ4GsGaHJxw2Z5RdGZTX23/cfUZh4dm4bnZbmzdR/5/S5F4vMsalA
 WSLIGx/nEZIzogTtoUH/boMYHlctOIUv6/lXhhtNIgh6Eebdo8VC6pMX1DIsaJQmb/d6iQio8JM
 Dil4FgONzrpD2ezoy7DHw7kbwKzFmTVwSyhwlEAH8actBxLxaBXGOWxg3ZBmqkAfrvYhAUqFXY9
 Ruy1vSv2v+oA2Paj9t87yw5yeOt+dQvl7DDJzofTf3X9iCn4riYYSpzeHrppVHKuGDOknl+Xm3j
 mnZa+bgRYBvD2R6CKtwN+oMZtsM7CHo2gz0L75g9RL1cDA/Tkwc68xTw2XzxWOrMxgJ9atV5fx+
 sWIrInln3adyQhyI6DfzmOc6GZlph7xHXQdzcX8e9rrB4Qqu4Js2poIOvUkq/PnCA2Koqru/JYQ
 5Yoz0uUC6LAy9CAc7XBoGmYiTVTpRvZQkRWCmaFUmnQaqLAhw2dNNG6i4nZX511kQgPJRXz70Ua
 9TFq0A8oTKzPKZkFh5YQZ1yB6VDRGQ1HR3j0NTQNXUXQnaW2G9rp+pAr/FrvQ==
X-Received: by 2002:a05:6820:561c:b0:68e:6182:3eb2 with SMTP id
 006d021491bc7-69462f35472mr5737383eaf.47.1776782836934; 
 Tue, 21 Apr 2026 07:47:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9304b7f6sm12124130fac.1.2026.04.21.07.47.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:47:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:47:14 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Updated dts/upstream to v7.0-dts
Message-ID: <20260421144714.GY41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4HcDVqjfkcrHwMKq"
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


--4HcDVqjfkcrHwMKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I have updated the dts/upstream subtree to v7.0-dts now.

--=20
Tom

--4HcDVqjfkcrHwMKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeN7gAKCRAr4qD1Cr/k
CpM4AP9BBTV/1Y2d9tOmgtkxf7OphgyYe/IOD1fD4fOTm7/W1QEAq29AZ49yb0FH
MrM3NgqlhquxYXS+PacPhXUBzuNrLQA=
=h/g5
-----END PGP SIGNATURE-----

--4HcDVqjfkcrHwMKq--
