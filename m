Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B03AEC1123
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E6E83D8A;
	Mon, 23 Feb 2026 20:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YE8G/Gix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD5383935; Mon, 23 Feb 2026 20:17:48 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2A683C6E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c307db9aso2414595a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771874262; x=1772479062; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4g8l4AlmtiWSwA9Tg6p1SqdO5CGYOM9T322LPojmhqc=;
 b=YE8G/GixDDCKJwk8je2U16Xs7xGt9y+oWUUhpBIBhzWjfi+jaXLSCG7fKOMW9nDk6N
 6uY9yLC5OFzsPk0AgrchZIZf62L0aWuK+cZVy7zk3vTYlqB5xPJNVvRRvobytqK5CRzh
 skEpIQqUFeLZNMWz6SVDQC4fKzuWDGSlnpd5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771874262; x=1772479062;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g8l4AlmtiWSwA9Tg6p1SqdO5CGYOM9T322LPojmhqc=;
 b=qrhOiXPWD2PdTEnuwRIddIDGD5TOGTKEoo0GxPZ8g6Yg/IfyLNYIJUs/ruoo6PJgBu
 iF0Ht41IbBHVLEBaZ+/4u0xqbzVHi4Bm1qKqkfTISMEfEkU/kqWFMEOmEniGlZ/RmCDT
 uE1m/+wLVb2KVbtHOqEWbCCmYEHaYexogu5QnBqGYWFR0ArVPM8RF5e8d6rvH/k3MrN8
 WdGiqowVC6R4st86OC5fVTGo1cRNg0JVRtQu3hLr+BIqt2n2QRec6MrH9+LX5PgEror7
 MlMA/EwH96WLA+NrVCrfM6uvVH6GUoiqyewayK8GtaMRyIs1iDxT3AsIW9GbY9ejQNTM
 ijsA==
X-Gm-Message-State: AOJu0YziNxD5YoqHvpEc5HT6zgvHmdmpJf7yg4dKWwf4wOrAHIStJC+/
 N3vca9a9XhNBot/GE9XHmk7rnrtg45yhcDs496uJQF6tDRZZgWvT+H8djiq4/u72mVNTBqtw/0K
 xkyWtQfo=
X-Gm-Gg: AZuq6aK8vLNp8bJDPWdTn0Ga45I9rkmi0tKxQXIa2mKzasxjfmSUK4qgXnQU+a/bebr
 v9c+JjbbYwEtTUtXobzR0xQ6v7oKWgW6+/2eG6Tuse22y228NNhH3/tC0VbRae6IuMjCIX4ox2m
 sjFyAKny3bYmoSGcOmPzovF/UL48nt1KyXBKy2OV2p2bFkukqeJnx/NZ3UjlpqMmN/wYmfYFFoa
 2nXSD0Wk5sDbL0oK8FMOBswlsuDSW4S9uri8VkGeDbUIHGPMj7g25JpxDzZh5NHbdkclcoCYI1b
 e7/cv+SYyOE2cKGzbmnOUtI4dk5K3tRqNbhggH4cPOaDKBtHPGqtM+hiuOF/B25UjZrrgGBCtNP
 5IWI6t1QDRCrkKFtvkqtpKEGpx1Ue/1o8akGQdmLuRUkZHpejqdMPyQeZ3WlWOfu2O641fQo4Fs
 Hw7MlkH90/4EXcxzu43AJ6MLK4WKUfCMUCXeU187gqnAY+1FmoQHDFqcx5/2gxP2RXcYnA3D1Pd
 3Q9Huafm9WbJYw4mdPAMsb6yCFVz84lBxqWxisT7Wy4c/VE4f4=
X-Received: by 2002:a05:6830:6f81:b0:7cf:d119:92ab with SMTP id
 46e09a7af769-7d52beabb1cmr7085811a34.9.1771874262484; 
 Mon, 23 Feb 2026 11:17:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d072598sm7913649a34.27.2026.02.23.11.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 11:17:41 -0800 (PST)
Date: Mon, 23 Feb 2026 13:17:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04-rc3 released
Message-ID: <20260223191740.GE3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ejNmlxQhF+KUs4Za"
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


--ejNmlxQhF+KUs4Za
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. First, I
forgot to mention with -rc2, but the next window is open. Second, at
this point the only device tree alignment fixes I am aware of being
outstanding are the SCMI series, which I expect a pull request for. With
that said, the changes from -rc2 to -rc3 are fairly small, which is
good. There is a known regression for TI K3 platforms and smaller DRAM
sizes that's being looked at and will keep an eye out for the fix.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/icv-nvmv-dbf
February 24th, 2025. 9am (GMT -06:00)

To join by phone:
https://tel.meet/icv-nvmv-dbf?pin=3D5493171900556

In terms of a rough changelog:
- Platform updates for Samsung, TI K3, x86.
- Subsystem updates for USB, EFI Loader
- Device tree alignment fixes for handling overlays.
- A few more tests are added / enabled.
- Some Coverity Scan errors resolved.

I continue to plan to do an rc release every two weeks and the final
release will be 06 April 2026.

Thanks all!

--=20
Tom

--ejNmlxQhF+KUs4Za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZyn0wAKCRAr4qD1Cr/k
CjSoAP9C3tM5ev7TtaOZDdM92rzityJ7zkxcCGzGipZKMT5UfwD+I0Ik3mRrWiWA
mklMwk3XZM4nelu64vpqhykgGmnRcgI=
=R8Vn
-----END PGP SIGNATURE-----

--ejNmlxQhF+KUs4Za--
