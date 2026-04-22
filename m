Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204FEF94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A1983FE9;
	Wed, 22 Apr 2026 03:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ogsT1TsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102DF83FFA; Wed, 22 Apr 2026 03:54:26 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBF583AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-38ea6a5a0b3so47317571fa.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776822863; cv=none;
 d=google.com; s=arc-20240605;
 b=PRRg4j4BBsK6IMW0TgvKeMc//cHHDj8b/lof/pIxU5ZgnzWt5lJV/MKHtJelt9bFcl
 UDZPXHYgLbsH2yYkoHOSYRBrQmTjQVfJir/fTtXUzEOcxwgJIA9E4k5TWuqbGDmOkVVl
 GkVpayvEd9IwbFlNuKCmVOsXu+uQbfD9MMrbMTk6ejBquTleUgclD7xwlt7eGJjrOmVP
 V9h8B+ip7pTHzAqx7eSYTkPNMsV29Unk4PKnVbZFdV2pDlrJXi4pDHdgp7Z1lAc/X9hr
 Aac77a5bNElQx1nBLHWldJKiTQFEtBGbZEemrQ/o9qN4ylPwtnNNgogn4sPqPCRvGs1E
 WseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wM9E/qjtFu5JLyt3UodFSBxPqIANqe4EbbXTiVj5ies=;
 fh=Vpi6q4idWyRDptJbJQM/inoXD/NHpqcfgnOAQiyxf2E=;
 b=i91hz61q7vKmCURH2LsFrQiJlF4leXvFMwXiZwSte53Uescr9OOfWwUgcLlQq1I6ri
 LGruTQlfzPUSRczYt3GcgN8A9zJ6zCg+Fb1YJW7yJepKPGp96QPR1fDo4o5CyhBduEnW
 Yt6hhBKupgXWvMU25esYRUs1Oq6wrMM0sPD33fsvubuvs+B2/iiVgEBVq7YjHjLJSzKr
 SCubtIkOSqLjW669epEzDK4WmJtdXXsgQwWvQu7U2VgkKn093oHLF/zfL0UAilPNTqdT
 8FTFL2mHq/FSkYqQyrzqsX1bNpIS/02GjoOmIabaJun4sqboZW4q5HqCuHX+9gaEhGns
 Kp6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776822863; x=1777427663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wM9E/qjtFu5JLyt3UodFSBxPqIANqe4EbbXTiVj5ies=;
 b=ogsT1TsCD/nlFYNCIx/35r5m7U1LyhR52ksprRbFzYf9oXwREPjn5nGZNtEvjc+HaI
 yJk90Jebk7cZgw0BYceEJw5+mqTDhIz3gx3lVq2UDi1TP3yCLHPCyN5VIEoGJCosGD0e
 rm5aBUsVhCVmVMAtQoFXXRJdPujSpOD66xL/JY0xUnxzVf1C2YaDY4LPDjvpsAf5D0M+
 1zP4TQw/LPi0d/fqCIFHlS70/O2CNiMi+KD53fc/3ShN90KrN6nAOxtTbjgmuQb1baIY
 xe5cc5/9IGCuN1gpx92h/SAoLHI3vZG+18chxwk+8a3dAUbCebgbDTbXeRmZsduvPdZi
 lgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822863; x=1777427663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wM9E/qjtFu5JLyt3UodFSBxPqIANqe4EbbXTiVj5ies=;
 b=d94XviR91C43L2Mldpvak6v4ky7yxsQuLVnLRENE4mDHmIT49f9DHimxOyXftx5Gow
 1zfd0CYNtsnxybF2QQr4oIm1LkyL0tRwuR47YPDCI5OEar947+YpZCuvSmXQaVWTgyA/
 uUt6znTRin/rM3JwjbILh8sTKYG2ZNCdprMzJ9kii/+MOvR9OpRtuTWmp8WTxN0Rx1V0
 a7dWN7j5nRrrcaeSsOaszMbUAIEsNG6ZKH22W1K7YnVO2RF1yfVBc5nzTaJ05viZZ5Fx
 Js2O0rLhFomFnH9SifrpRZ17q4xwdhxmO8DMvugPKUwT+xj3X9tHcTETowwV1HXGacz1
 1IHw==
X-Gm-Message-State: AOJu0YxwmsqKD91rRrQw2QWcXijfRKLuQtwaAAmiR5MK1+ZEGgUFXiLi
 YgpAHyJsYsWbT1w8e7a1fw4A25GhDEMAsXkUNpV4JqE6FVIMg2JhUPliLVApPrn3GqjFAvcDUdf
 gd2jggpO8FgB51/uryZMepAJHQKZoG2Q=
X-Gm-Gg: AeBDietZBriL7yToEeIFPLd6fdLRs9Mc+vJBNTQnVr069KzHfeulyHRW91+dkRVdagi
 Gv0NRIJlee9tb7C/W5d8JqMa1biaE+K4OOs0fjfH5vN4KGRWlQK/eMYkEpQySIxOxj7jcHs6MoJ
 uHf+EEu7sfkzXPOO9o96qRm3CurcHix+Jz0orLVIrZE/52AoCuVjZtTIHkS1pI7AAUIHNeMkB9c
 KvB7P7Kz9OI72RiMs/bRIrpO8sbCUjeoobADW8Ayi51AU8BSUY3R2XN90DdLXX5l+/8wvp89yd5
 4WM8JLYgOfaAaQIj5mPcLXhnh7hyLXOA7u49YrtWXLScPw+SJUq3CGbXYOi6stU1vgryzSLRt21
 VcpiO02rGb+3kKQSuMA==
X-Received: by 2002:a05:651c:1604:b0:38d:f09c:8607 with SMTP id
 38308e7fff4ca-38ec7b2f39bmr69907961fa.25.1776822863204; Tue, 21 Apr 2026
 18:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260421225111.218951-1-marex@nabladev.com>
In-Reply-To: <20260421225111.218951-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Apr 2026 22:54:12 -0300
X-Gm-Features: AQROBzCbx-SGYMwqLhLwfXG-cg5Y9UU8om7Hm3yVa0xxNQ2hmRrNtJmG9cCyr7M
Message-ID: <CAOMZO5AgST4gobvq=2WYG5cPL94inw9XQ5zPoaf8AHWpf687Zg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Use N: for NXP entry
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 21, 2026 at 7:51=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Reduce the NXP MAINTAINERS entry by using N: entry glob.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
