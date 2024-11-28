Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070DCD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8F3897F9;
	Thu, 28 Nov 2024 15:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6WAQknx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E7E89D27; Thu, 28 Nov 2024 15:49:04 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B6E88F28
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffe2700e91so5408721fa.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805341; x=1733410141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrVjcKfbjtNA/146pZyuh7wram+7vKIcO1hZ1lJuwIE=;
 b=O6WAQknxP3hELzb0dhS71Pw1+9eNv3PPSzlsGI47EZ3d0kGeY178vWRPkaldylBqlY
 pJOXwBRv6mLCljX2fN8ypo4pTx7GvsLloYoC6ToFvnnhHUWpVtAQHQzNYTvAuW2QdCxV
 FmI5nKf33L1611Z6LFtwPz6QmF3n1W8yjHeBnBDUjiVEQHU48u0v7RYNkmmiWVw/7JD1
 zAdpVF2355wiW4I0e+NXdkLcbiXOxPoWQdSNfwbBV0HUtV2k/bA0iZfu9JKUTaVpwjFU
 +u1NTCYFkohDGaY3TFK4DmFPp/Zo5AZSaPksMg9SaMqx1aPE1F9YAU9ZX8MG/Ld7vsqr
 /0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805341; x=1733410141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrVjcKfbjtNA/146pZyuh7wram+7vKIcO1hZ1lJuwIE=;
 b=Kp/m1sD6sjV7YI4uFUGAii+g8+mRu3cjHfu/Q7K4kqvivHURbgeBFllxkLOFFJ/3Mv
 rYezkWJoStzWnN7gFD/0AMtGWoWQ/BpA2oLNMXtTw3VPLejCKGwg7Inlr4qUx2PlcgGG
 MDTaeZPmSEUUA2zv48au5PzSI/a8avA9y66Fq6ch+os97Cu+EBiYMkHeyuLVpqztBaiY
 1/OWMdsxVrnbbJ8f+2lrEQhMstj7R7Lh3uHartPQeN/05rpyv9bOst4fksUzFpxrDc5K
 8egzJ7OJx3YXcxIBECijJzKPPlPcaL2PGFRShVfJEI6R7dhu2Bh84Zbf3ug4Rx48bqMb
 TsvA==
X-Gm-Message-State: AOJu0YxtmhEVLVPzf6kVWhC5RF928gZ2srfR8VKqxGDL7XsRWliYvJIc
 motHO06usk2dlg8gNJbffpnzKENBX78yQdrC/lJgt6YKjy78c1tsTcbvAt/2PW6stwjvRoZgAhh
 1BDuSqWSEKzFtqsE8qJOKy2wTYxs=
X-Gm-Gg: ASbGncv1//Noy3wMDaGfowaIdyIgtxWML2qgav7hYsk+1jaydd9reGTdmAjMC4ZSdsk
 APq/LywaxH/dFWBCwPLs7f5vmbJ5WeTg/HqBvw9x4YGUw4j8KOXQHM/RMrDlc93Y=
X-Google-Smtp-Source: AGHT+IE0X0GtlHMgwQ3BIxEQMCXbwRxGGowoyreUl/ZPaWWFAzm/z6k4zn36+mllHSBR1+pP6MLZdZ4G28NQjQYuqzs=
X-Received: by 2002:a2e:bc20:0:b0:2ff:97a9:9302 with SMTP id
 38308e7fff4ca-2ffd6050952mr36546301fa.24.1732805340797; Thu, 28 Nov 2024
 06:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20241128032623.269459-1-marex@denx.de>
In-Reply-To: <20241128032623.269459-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Nov 2024 11:48:49 -0300
Message-ID: <CAOMZO5B+W2m6VzS725SBrfgWq7FguLbD8EiK21sacj0_hVGFAw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: imx: Make DRAM coding GPIOs available in
 all phases on Data Modul i.MX8M Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, Nov 28, 2024 at 12:26=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> The DRAM configuration GPIO straps must be accessible in all boot phases
> because the GPIOs are sampled both in U-Boot SPL as well as early on in
> U-Boot proper. The already present bootph-pre-ram DT property made the
> GPIO controllers available in SPL, but not early on in U-Boot proper,
> which made gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
> fail. Add missing bootph-all DT property to all GPIO controllers which
> are referenced in dmo,ram-coding-gpios DT property to make those GPIO
> controllers available early in U-Boot proper as well.
>
> Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schem=
a")
> Signed-off-by: Marek Vasut <marex@denx.de>

I'm getting CI errors with this series applied:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/962602

Please check and resend.
