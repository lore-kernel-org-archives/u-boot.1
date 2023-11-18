Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D42C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1E1874A3;
	Sat, 18 Nov 2023 18:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FEEx6s7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A47286DEE; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A82B86FED
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso30057397b3.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327495; x=1700932295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A3Kv9zqad8q8LZvFpTWo7SxC9LOvZPGMFyklSlv+JKY=;
 b=FEEx6s7FKKuDjl8cxBDTxt5rsE6l1PxMMHXzFcuyUo83jCKQlpmJgG2KcP3hUdp3Ox
 0bURY/Zs8rpyrIbFQjZK1R/SiJmg/slO6BHuPz0BUcz6ku9TkUgL8xW0YaPRcWC7feYv
 7vjazurMoiqP5xv0pZ6RT2l0VdxjWJiznPWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327495; x=1700932295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A3Kv9zqad8q8LZvFpTWo7SxC9LOvZPGMFyklSlv+JKY=;
 b=hUjoGt3wQVVp4V3Jpfo/CdVEZHNLnac/ATvVUsvLfsKcsQoBl0UenhnfjyLPER9v9H
 SkFzNtk1sEYFFV5BZDQJnoQtcj9S1OzN568Y6kaF8uoqAp8zlVjL0SxKTQVvuiY60i7x
 FfO/ZkskIhHMgEg5+fNTvCj5UBUCDgO8kkR7f3BsJvZyZhGLWAdlA++P4StvIralAlgf
 277jYuREaEELdu97bXqe8dLqFPWeNVW3kLemJ7WcgH8W0lGIYHug1Yz8hK3Ys8h/PVoi
 Uda0Np3WWGoY6TQ/nnbDIbDqYeXjB/sqNrssz3woh1fb7gWwf6BXfo2qDsn2v2fCckf5
 MXhw==
X-Gm-Message-State: AOJu0YxmdYlVWciY+XsDyAsAt9Bfe/F4g5uzi2em4BK2f1CHdcu48GT0
 T3shEv3AbrrFK9B17kY/wCREVHMfGygBPoXm5tutTA==
X-Google-Smtp-Source: AGHT+IE/HlVcLoaSnBDmZevKy0vSPdr+T2KFghJOI5A0MgC0rSHeh5ExAuEurh333Ojwos8Nhgtjob/PGzWjdge6Rt0=
X-Received: by 2002:a81:6d0b:0:b0:5c5:9f98:8b6b with SMTP id
 i11-20020a816d0b000000b005c59f988b6bmr2311895ywc.38.1700327495535; Sat, 18
 Nov 2023 09:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20231117154757.777827-1-trini@konsulko.com>
In-Reply-To: <20231117154757.777827-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:50 -0700
Message-ID: <CAPnjgZ1fFC7QW5xWXrqDEptOOfKeYNERM8BbA8FWeg28VYYi=Q@mail.gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
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

On Fri, 17 Nov 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
>
> None of these platforms enabled a networking devices, and disabled
> CMD_NET. Given that we used to gate network support on CMD_NET rather
> than NET, we disable CONFIG_NET on these platforms now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Matthias Winker <matthias.winker@de.bosch.com>
> Cc: Philip Oberfichtner <pro@denx.de>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sergey Temerkhanov <s.temerkhanov@gmail.com>
> ---
>  configs/efi-x86_app32_defconfig     | 3 +--
>  configs/efi-x86_app64_defconfig     | 3 +--
>  configs/imx6q_bosch_acc_defconfig   | 3 +--
>  configs/origen_defconfig            | 2 +-
>  configs/s5pc210_universal_defconfig | 2 +-
>  configs/stm32mp25_defconfig         | 2 +-
>  configs/thunderx_88xx_defconfig     | 2 +-
>  configs/trats2_defconfig            | 2 +-
>  configs/trats_defconfig             | 2 +-
>  9 files changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
