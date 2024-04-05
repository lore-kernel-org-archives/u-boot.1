Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC16CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710C688444;
	Fri,  5 Apr 2024 18:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dL6+i97C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D76588440; Fri,  5 Apr 2024 18:50:27 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2821188444
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a2fbbd6cd6so336014a91.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335822; x=1712940622; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCm9ziP1yAp8Nr84lDAn7DO5AeOUFdU/xc69tF/+WpA=;
 b=dL6+i97CyMEAlVD3mM8phxCievBDlHNY5D4r9RWPVEOTJjb+P1I/RECR7U2p1SFOmF
 +o2wKWHbpp0z/qbYXXCzll0AVK1nHcwVb58LYGsB3Y4ehtdKJHR7gTeR9w0avm1PVyNO
 uqzg0vU55iuoBn2JekLNvNhcn2kkI5UBo9TH2ypS524y4eBpWdi3Vib5RX36lhyei5aL
 YYogf1oGuiae8mTo3zLKpQ1TszZmqKMR6Y8yOzhCwjDOOzdwNZ1laD6v2Le4T+Ld9nBi
 Y340cq/S3d5bAI1X4is50NTP5LwL5Mjy2M9aQKAg0WHRaX74UD02NnbOrfUDrbFrILxC
 dzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335822; x=1712940622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCm9ziP1yAp8Nr84lDAn7DO5AeOUFdU/xc69tF/+WpA=;
 b=mAQ3FCtJvKra6mR/CUiJA95U11jAi/NPGHpJwD27EzDOtO67sYowmDGhG7IS5AIwvL
 xb8tqXYwnD+lMpXHpftKRNzcyiMAnWWSZ71qQ8n32GP4QnoWEdWXOe4FZC5VVCWrp7vr
 NgAuj43XYEhOa3cw4H0+Dw7hKxT22vSN8H5b+VLuK4GP/bMC1QTQWLCfMDl5M30TMgJb
 zNA0zUSkPrF33H3wgKY9woXPyYOZWTJOZ5FGQuDDP3EYCXBiFaunMvNTL2mw3gkJB9yg
 zQl4tHSnwWJBsMJozkc2BBiGde2gHtJlimgj6P4TnwflvLTIsXG1SmhSbXoRQ7Zv1o9c
 svuQ==
X-Gm-Message-State: AOJu0YwUUyQmx7VgLS8gseIPs/RV2SEPqIy5o1FM6a2GuZ6/TXvJbPp4
 G//n83N8PV2gxUS2sU+dETFsdVBhkzsN/GijdmIuq3Zmix2uzsgNKZrm1bisseiP24gYEvKRxJS
 Uld9zQCuO18yaIHKErqGQuqIiWxg=
X-Google-Smtp-Source: AGHT+IG4iRy55KZWEZRaKKA4CrYI35wkutOPmzlFFsW+xaMy7i3Iu5NcQxcnFf+xjad50iBL//k+6Gi5fWzKZF+8S0o=
X-Received: by 2002:a17:90b:244:b0:2a2:666f:966d with SMTP id
 fz4-20020a17090b024400b002a2666f966dmr1918736pjb.1.1712335822638; Fri, 05 Apr
 2024 09:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240403071555.400843-1-marcel@ziswiler.com>
In-Reply-To: <20240403071555.400843-1-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:50:10 -0300
Message-ID: <CAOMZO5Cz9eNmo5ayMkNe9JJTu8O+XiNVEvvbVYtkQekkmePauA@mail.gmail.com>
Subject: Re: [PATCH v1] verdin-imx8mm/verdin-imx8mp: move imx verdins to
 OF_UPSTREAM
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Adam Ford <aford173@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gilles Talis <gilles.talis@gmail.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Patrick Wildt <patrick@blueri.se>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

On Wed, Apr 3, 2024 at 4:16=E2=80=AFAM Marcel Ziswiler <marcel@ziswiler.com=
> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Move verdin-imx8mm and verdin-imx8mp to OF_UPSTREAM:
> - handle the fact that dtbs now have a 'freescale/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>   *-u-boot.dtsi files
> - update MAINTAINERS files
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks.
