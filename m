Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172F9CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870AF8004F;
	Tue,  4 Nov 2025 19:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fJhWnGXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7504A838CE; Tue,  4 Nov 2025 19:05:47 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7BF8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-378e0f355b9so26145831fa.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279545; x=1762884345; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FIoRPeGCINfDDhGVo57w21CYYDTOTWjgfEBSTyP9YM=;
 b=fJhWnGXlw49+AAqHi5lWxQk3WdWjPk3IVf1t17PZbnAlXcaFqpGyV6T8CuNpgwUIdw
 iWd/ki3tP/yXFbj4OdadlQn5vSoHHjvFPRKcVp/sPHiWKFIVF0SvXFAfe3TQv6C1gETo
 guDjWzCiG1AAy8BbBnqgaXv7tNV2EWE2ZKgKxd+LSIlNnma0EM9NAEoeGDLOYVNrEAZ4
 vrQnYFeBaYs3yFEjVzxYmLLR7krhze4FQNngZXzwODJxSEu7xcAnzAD8F879u/gAmr3z
 qRxQEoWccwyq7n4E1YGDXWTqKA9W2dOpcM1hdPoxoLIghKTGjGRpFvo5d3DVCgqRyXDD
 WcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279545; x=1762884345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FIoRPeGCINfDDhGVo57w21CYYDTOTWjgfEBSTyP9YM=;
 b=cNHdkFCu4cIpHafHVHO7FdaaM6d/AUWNXRhP9TRUSiKd0F2s0eq8f6tGTVQsQ6X8TR
 Jrd5ELvc06DIUbH+1wKzER2FjNvPjUmpxZVxuin84a94lMhFGYJCAdsP0gDD8BNxwyvQ
 YXNpbV6ZSp112Nqyst5zHlJ/OimngM6isyqWEmaDcIc9M5ji9V6gTEvKLcy0FeUfl2GB
 xzM3uWffeKEYo+fSfnsQ51+XRHMVwlKpupjxIcS+S8T59L8+lAFxJAwppZ/b/F8GvO0j
 tOOXkDWyLneVxjQwTBtJA9NCzBOJ+0iGvDzpEZLmK1Dvi/PGvvXq8k2D3RqyKl0FIA/f
 oxdA==
X-Gm-Message-State: AOJu0Yy/ZYrptnHTCW6lSpZtXmESUdBJ0dZPM0SWS7cN+JqVZE3uXVDs
 J1Uvn9wj3qtmnbWVdXZGmcmU+sJVucYAUdE1nmDGWMObh6o9AABx5p6zdsRepwGFHKRy/Ij6ONZ
 QHiA0PpR51sPcQYJomCRIxb993Fswdhk=
X-Gm-Gg: ASbGnctIqLcZw+bbCpMp5dUS+PNMZ/xtBUF2BRGq6nOeLTH9iXe7LoGwZLN5oWzcKtC
 3454pi3IjGp04c4ZUQXBfkEiRYok30/J9jBoiLcU3yoQbMpVXP7xvkO0TXgObBoCAVO/nVBIAAG
 AJ0EjknYGmKX2r34U1HJK7jJGJWAKVn8Y6c3kP8pb4E15FuBWN8rSCEin/gZ9K/nCd8tQi0QWh9
 3k3QR1Cje+sILbr7RpQBZAMpeqIzXGdXu/8C+5ybZuTMnaJVLpl9EQmrpfbK4eZSxORdA8XYUDy
 +Rs+gN1/w7E0zfDD
X-Google-Smtp-Source: AGHT+IGuhh2K/tcckZNMpYLdv+itY0rEPODLf6H3l6GM3CMJ7uGN/uUtQ6Z3Kt5XSgVOjmCJk2KVvD3INZIlWtAgwSw=
X-Received: by 2002:a05:651c:2127:b0:37a:3494:7724 with SMTP id
 38308e7fff4ca-37a513db5admr696301fa.6.1762279544568; Tue, 04 Nov 2025
 10:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20251103073654.2106782-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251103073654.2106782-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:05:33 -0300
X-Gm-Features: AWmQ_bmtyaV19A3SMg0sOYKOL3q9lM1w78wNs9Dstzw9igKZC1soROFTNjRlCFA
Message-ID: <CAOMZO5BE2S8ffUAYbuPEwJ7S1XhgrqEvD81hQAnVBEkPTpkOFw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: imx8ulp: Split SRAM0 mapping to isolate the
 SCMI shared memory as non-cacheable
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com, 
 trini@konsulko.com, marek.vasut+renesas@mailbox.org, davidzangcs@gmail.com, 
 sjg@chromium.org, ye.li@nxp.com, peng.fan@nxp.com, alice.guo@nxp.com
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

On Mon, Nov 3, 2025 at 4:37=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> This patch splits the 2MB SRAM0 mapping into three regions:
> - 0x22000000~0x2201f000: cacheable normal memory
> - 0x2201f000~0x22020000: non-cacheable device memory
> - 0x22020000~0x22200000: cacheable normal memory
>
> The change ensures the SCMI shared memory is non-cacheable, which
> avoids cache-related issues after removing
> mmu_set_region_dcache_behaviour() from scmi_dt_get_smt_buffer().
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Applied, thanks.
