Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC4DCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 12:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE4C807B1;
	Mon,  6 Oct 2025 14:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bCZktOA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718EC835B3; Mon,  6 Oct 2025 14:26:36 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2B3802C1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 14:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso755105466b.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759753594; x=1760358394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jOJtgKaUak3vZEv6eLSw++geEwuYVpXsL3a+Fpj9hQA=;
 b=bCZktOA1ZSNrT6f/kc0QIS2lZitARYQoFanVDX+ryXC3YffZYwigRc3QUcdWCdkorz
 41pJjgQVsxI4uc94jiteQ9jy/a7wBxcqoCW+qEu9GQCRMT3GeMTpuSLR5fZcPXH5u809
 fObGbIoKiM5wp0gSTOOMlpzEIAN2BSM2JZWO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759753594; x=1760358394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jOJtgKaUak3vZEv6eLSw++geEwuYVpXsL3a+Fpj9hQA=;
 b=BOoMZTzNT6QaqrpBb+AlnQMt9yXWLBxVhokqhO9jIOK888m0fhDI/DEptErU1IBiBr
 x+J3InVHV4PEHIKGyT3ovBfm2y68aAS+DgxtM7u+wlQQGgyzDrPe5AhM9M6ido0gXfiy
 E75Jba8zz/Mk4o9fG0B3b3LbZ6cct8O0aMr4K8Vmipqkl9NfYWkpKokXe1Lfv3yvyZR9
 NUby/1pDHd07LFYziOPDaMwsLVbTLooiBSiDIBN8l6Qg/jNSXYt4NvpwX8q+plEntx/T
 Co8KyQed5eSYy1QZxUbiBae4CCdSK9iWOmprNm3zrA1SPXi1sYc0Ra+eRz8L9bzAVsvc
 OauA==
X-Gm-Message-State: AOJu0Ywfv6QRcCRmBnURtLCIe4zsks4elOMgxr19Qxodn+p/PBuPHeWH
 s80jZJRu6w4FsUpRopsNmwzD4NcRpxbyC4eB/AvKoq8m4R8JsL2DxBvs2X9uI0Yj7HVgHREpaQ8
 p+e5DrJdyjLrYMj8PdQr0nDO3D6yACQ4nqyzOIggB
X-Gm-Gg: ASbGnctdKPbXofsJtg4XA0bABV2u64sNKCnfY9ousPSp7mjBj/ElA+m5nsy60syCBeU
 MVDWO8z7B6O5qbIwHeR2T3mBVdsmdWmdM5mjd1k99vBTJzenvVsFSTmpxkM/y4b+m/enTsq9yMf
 WTwSfawUfdNXyYSosAwvAUm8PSnLSiJOZ1M21ZxjpNsSevClRR8cdJhqznzPGz6NbKGIsCP5kEg
 r7tqqJxzLXX3plrJ4HIBoY8SnDW8PC2OFbE+oHh
X-Google-Smtp-Source: AGHT+IFJNMfUUulP0HS6M3/U0QKbSqylwPqfEsaepD6/a+3lpUFA15oQ58zWlmht9dQ4JsGQDkxBCio8Wy9C5HACh+M=
X-Received: by 2002:a17:907:7286:b0:b3d:c47c:7ce9 with SMTP id
 a640c23a62f3a-b49c40815bemr1616076866b.54.1759753593768; Mon, 06 Oct 2025
 05:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251001203059.2828551-1-trini@konsulko.com>
 <CAFLszTg8BFgpeYj7Gz-9ac5TVLaJJ5fs87oSeOfurSNT6dCa3w@mail.gmail.com>
 <20251002170352.GM6093@bill-the-cat>
In-Reply-To: <20251002170352.GM6093@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 06:26:20 -0600
X-Gm-Features: AS18NWBjuWdplERMg9Fo4rbDkUTXdjdKCYd3oHFJ9m92NMUV5N6jI42-mbYM4bE
Message-ID: <CAFLszTjbcnUXzph86i4H9SUU8gZB32yUKMVZzAges_jo9BA16A@mail.gmail.com>
Subject: Re: [PATCH] boot: vbe: Make BOOTMETH_VBE_xxx a choice
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 2 Oct 2025 at 11:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 02, 2025 at 10:29:58AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 1 Oct 2025 at 14:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > It is not valid to enable multiple BOOTMETH_VBE_xxx methods
> >
> > Why is it not valid? That wasn't my intention.
>
> They fail to build because they both declare some of the same binman
> syms:
> $ grep 'binman_sym_declare(ulong, vpl, size)' boot/vbe*.c
> boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, size);
> boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, size);
> $ grep 'binman_sym_declare(ulong, vpl, image_pos)' boot/vbe*.c
> boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, image_pos);
> boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, image_pos);
>
> Enabling both leads to link failures.

OK, thanks. I'll need to fix it at some point...

Regards,
Simon
