Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E5EE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 22:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A883C805C5;
	Mon,  6 Jan 2025 23:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sb6qid2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9B0805D5; Mon,  6 Jan 2025 23:05:05 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74E88058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 23:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6dd01781b56so79627926d6.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 14:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736201102; x=1736805902; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=chXraDiw1yF28wptL8r/fKCI+V4WD90o7aTR+0nQmcc=;
 b=sb6qid2zBZbBtavRV9xnDXWdfURRMtlcxPdeZjoNoy5K9rkbZ+MlYmTs+SFAV1IbPj
 RvYCBsse4mqLnohIL6NZC1XFmFI4g5sA/KSlT+DeP3jDg+t/B+9jEuB2bHLiXQ7XoqGJ
 yHjke3zB47R40eWrnJzEEdIhZV1gyGp1e6hKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736201102; x=1736805902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chXraDiw1yF28wptL8r/fKCI+V4WD90o7aTR+0nQmcc=;
 b=CvH4wk+z0C3fKKrMuXpNHvpZCQiofB5MQeldzNV1jaNPZaiC1ZAwsVC/o6g0tyHGfJ
 zPrggyZwgDov0f2lLW6sN5VFVUVQcsYBS4lEuLNNDWFrGu3Z/8hcYzycMj6B9Ti8JT4P
 0ASNpo+HRGrB8AQNBNV1Xkh1zhvZ5eNj7vk2Pp9Hn4Id1ZvhEmbecV2a8KxusOj0QLfS
 VXkcZb0VImUF10J7svCl+pCpz7jJ3Wj998CgbFU4y5kxjJldWXytAjWj4bhzLvONrcHp
 7whSBIqJli0sCGR95+bqEYQB3KyuUAr0TtCcbhxMei6S3jK5GMKjSFjIS/U/MJWeOQft
 hNsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQxWcESAGHDJ/rBf/t8KRJf67oXQJVKzuuIOQFUgt+X4b9O4vBcld44vuXs4jFv3395L/q6A=@lists.denx.de
X-Gm-Message-State: AOJu0YxYAh6VoxIFMCuRK80txb7zFaLc9PCj/yBjpvWA3GGTu4VWCO6v
 SMsaq0WhBWhBRWzipfmeZUC0jOe5yZ86FwiAAwc1B5PwkiHetgWerB8cSzjqL7U=
X-Gm-Gg: ASbGncvzfHUeYJrqggalUy1tYCmZVueMQBGHN+zlAekjRdQv8mgRslmSznx5N+Gio6g
 f4YqkOY9l7J18LYp0FlHlU8/XRUTFy0HtPOUhIWYW4l9I+uK9/5iWuF0uRFO//0vB/bzyOMdQg/
 +JsKjkCFBvZSTA2g1FvUgA9Hf0lJnuI1BG8mIdQz8yGBdk3v3sxClhijKNXr0Zz9o3sb0Dcpz0x
 8wBXb6IzGm0Vr8GaC+p+0Bawjk1G1sea48RT0ry+osmUE/G4G/Ms8U=
X-Google-Smtp-Source: AGHT+IHwxliUMyRvn1UpP8aMcTJkLv6iFeQsnXD8bJr5uILey38p4N507qHVkfC9+d7pgcOHN9ftHQ==
X-Received: by 2002:a05:6214:407:b0:6d4:142d:8119 with SMTP id
 6a1803df08f44-6dd233a8158mr980019466d6.42.1736201102442; 
 Mon, 06 Jan 2025 14:05:02 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181a7c13sm175268946d6.77.2025.01.06.14.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 14:05:01 -0800 (PST)
Date: Mon, 6 Jan 2025 16:04:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
Message-ID: <20250106220458.GE3476@bill-the-cat>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
 <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
 <3EE77A40-CD92-4330-B66D-7F00CCEA7BE4@gmx.de>
 <3a7f8b43-288c-4951-a781-c9d7139bab2a@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mW3nWcU1rOYX8Rnv"
Content-Disposition: inline
In-Reply-To: <3a7f8b43-288c-4951-a781-c9d7139bab2a@rock-chips.com>
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


--mW3nWcU1rOYX8Rnv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 02:46:53PM +0800, Kever Yang wrote:

> Hi Heinrich and Simon,
>=20
> =A0=A0=A0 I send these two change because I want to fix the build error
> below(from[1]) which is for disable the DEBUG_UART[2].
> Do you have clear suggestion on how to do this in efi_stub, since I have =
no
> idea about this module, so I just follow how
> it works in other serial driver.

Can you please remind me what got us going in this direction to start
with? Is it related to (in the rockchip tree):
commit 968c5682c14fe26bcabccf925157b5afc4427ad0
Author: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date:   Wed Sep 18 15:01:53 2024 +0200

    ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG

And in turn, why is that even "default y" ? Having something that
required DEBUG_UART be enabled sounds like we're a bit off in the wrong
direction. Thanks.

--=20
Tom

--mW3nWcU1rOYX8Rnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8U4MACgkQFHw5/5Y0
tyxpUQv/SXRGy+bp/LyvmeUs1Mn65WEngKckO8ms2LANIPRaQU0jkWInOwJwejXg
Un0vJ1a68eff/hP1+2jP+fTHnDeHqaWbDPhPVUH61QhlViZkQDN7CaB5B5wsy/w7
0uenbTIl9XgQjhA5hTxD88obwrnLdgNXnMb3Zkm5t2dxIGasrKAdAOmf1PQb8wNH
sZ9Gu7NOFZsMTnKsgxFmX79P7lbHZAV2H3kxu1VKSylER9gk1+vhwKTp6wsuphs7
ahQbCdaNWXvgRDGd571CmtjC/hwCnE5d4wt+7dhwasfM6iqawYWwRV0Hx5sO1xGg
1/Z+ML9z7dukbL2Hj2zRLcaOxOj1HUMBbTNJt7E1Yn6+CEYe791fr3yZm2pGvyXl
grg2nswdpML4OBl0iCcxc/QMqNkc3bNLpft1qPkY2EYmI13xHqC8i7BfTIJgS5Bm
Hl2NqAivAla+kPb3WdmgbWiKG9zMGkOVo9gwH/abf7sRGOKzmdRv1kowhM7iue0a
LUXZXJcB
=nw+J
-----END PGP SIGNATURE-----

--mW3nWcU1rOYX8Rnv--
