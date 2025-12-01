Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB6D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2B383C23;
	Mon,  1 Dec 2025 17:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="txgkK9mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFCC83C39; Mon,  1 Dec 2025 17:51:27 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC30F83BF4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6d699610cso1022418a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764607884; x=1765212684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1JiugMQjI0q8kX8uYBEw+of8tkY7YGqhsYCSh0zlyo0=;
 b=txgkK9miJe5r+HPGWHl8cULC9pqQlemt4A1OeG1nUVXo/iwAPvHd0XYbn+bSIpRHH/
 NRpSXw6ED2Gx9QpibYt+dr3x7uiSR6CQjtNORRpjmZIjMtzerU7g/+Z1+H3u9YZ+uPQJ
 Ybfxnuhd94qNfg6R3ENrOjUOfb3AG3fcJ8Uq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764607884; x=1765212684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JiugMQjI0q8kX8uYBEw+of8tkY7YGqhsYCSh0zlyo0=;
 b=moE3P8Z09HP9ijAuCHdbO00LjhDizCTrzx+Fl9AboSdkm83n6Z/72ckLrWaYtc4njj
 vguI7CQo3ODGyPGCS5EkWpPazonhPjfW8urABDxNiNMChU0vJoNvfcpPJi8CR1Sbpf6Q
 u629L4U3ewLOJAGNB+CWOlQ+7rwE9EpDTwBAZxH13URX8NUew0Mm6cQnjouG9rfAcGWi
 1ptJexhbzL4U7tx5g9kUe0bxoHr7MurLlXvu20gGdnDjloj8Ct4pgpuJbPAJXjtdfoA7
 6xDrv/Jx9kHN7WbnLxqLxsrrKmXeKWLALhyuvC291M5FL/RtPo5nIDzfmvmVI1fwBN32
 fybQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Gk4rrWAUdwXKonWR+4bntKfd/8rVHZSrkYlu+5XacHyq1hjff31oLSyV9VUAsFPy1KHJXlk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfE/Ost1QWv8THm7mVB76DCPAXKBq9eBdEqA1KEU0uGCSjrSb8
 QzNEsxUBzRpnuyPQ8U8Wfu5+zRFTda0gvgl/LtIUH7d+/YdzNwjseSXO8M9Cm1Z0hCY=
X-Gm-Gg: ASbGncvduef2M9J71X5IZFxbDwETGjHrXpMZgNfijksDmVlu3U1ulkt8tkQ9noUVmP7
 12u0YFZS0e47JyaSZJtnGWdAZTIzCbRi8G2zjYcGcOHETInyxCY+go6AMB3iKwmhLKazatrDy4i
 F1AoXZ40cExJGOOeNztHmtBVQAGdEbuJcL2s51Y5LzFybDDmR0RFAnnnbkKtEf5FbY1ztbuJorB
 kxIya4714dtDum/9FMLEWrwUM+945Hp299u18cfsY2MPV3sDsqwdFnCXzyhQ594Dnkfpbmda4nA
 HsSe4LOaXUfJApYs7hcIjjrFu6ZjEVd1enWqLnW5GESQNpKmGLQVxLeU8Kyl6A1WKCMfIdhOEJa
 8LDEHfDoO+LSMcHr75IsX8qBYfMU/rJyYfx3qPG1Ukj4R0BUFQrMRrq2onW1guBokdX7FziyN1u
 18tMdlTehF29yMDXj01rE0iREQUBMJz9oN3rOgsZeHusBCS9ulf9E9/EqRGFR2
X-Google-Smtp-Source: AGHT+IFlUbae+NoDbaaTnETnk0Lmv+DlGzZkZScAZTxDmNFqhB8HPe+/Par4qsAP+9iQQ6m1tSMjRA==
X-Received: by 2002:a05:6830:4126:b0:7c6:cb39:adf7 with SMTP id
 46e09a7af769-7c798f6199bmr18834788a34.6.1764607884521; 
 Mon, 01 Dec 2025 08:51:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5fedbbsm4810151a34.10.2025.12.01.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:51:23 -0800 (PST)
Date: Mon, 1 Dec 2025 10:51:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
Message-ID: <20251201165122.GH303283@bill-the-cat>
References: <20251129064818.1587-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ri9XMpKZfqpVtWFP"
Content-Disposition: inline
In-Reply-To: <20251129064818.1587-1-briansune@gmail.com>
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


--ri9XMpKZfqpVtWFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:

> Thanks to Jan Kiszka had provided info on
> u-boot is not able to boot by u-boot-with-spl.sfp.
>=20
> All three TYPE, NUM, OFFSET mode methods
> are nonfunctional on combined raw boot.
>=20
> The major cause is spl+u-boot structure is
> defined as 4x[spl+zero_pad] + u-boot.img.
> Deal to this configuration since GEN5 is used,
> the spl would require to seek by an offset
> on top of the spl offset. This means for
> each spl=3D0x10000 the offset is 0x40000.
>=20
> However latest u-boot do not consider this
> major structure on GEN5 socfpga.
> Meanwhile, the default include file as Jan
> pointed out is completely wrong syntax and
> caused issue.
>=20
> Combining both concepts, the minimum fix
> patch is provide as follows.
>=20
> 1) Offset is control and default set to a
> proper offset under:
> SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
>=20
> 2) Only GEN5 socfpga will be affected and
> minimized contamination on other devices.
>=20
> 3) Only one compuatation adjustment is made
> on spl_mmc_load. And simply introduce the
> offset adding by the kconfig offset control.
> It should be 0 by default and gate as well.
> So no possible harm should be done.

This sounds like a tricky problem to solve in a "nice" looking way.

The first thing that's unclear to me is, which of
SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?

--=20
Tom

--ri9XMpKZfqpVtWFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3HiQAKCRAr4qD1Cr/k
CvesAP9p9Fbxl7KxAEWos60QQ+D3xhnjNTBmqdsISAkkWFp4/gEA2Dt7h0GVzSt/
EAtiWlHd/DJAB5Tpop6r1bASShvaZws=
=pJaN
-----END PGP SIGNATURE-----

--ri9XMpKZfqpVtWFP--
