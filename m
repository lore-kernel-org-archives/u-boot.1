Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76726CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2B284CD2;
	Fri,  8 May 2026 19:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mwe4Ud8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 030E884D9C; Fri,  8 May 2026 18:48:08 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE0B84D6D
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so364405366b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258885; cv=none;
 d=google.com; s=arc-20240605;
 b=TU0M4Mb32bg/LESq7GQ77AEEME05B5jAk84o1ZqPeqFDs0CUmyC2Nj8s7UhwP1plM3
 ECjLAxjv2j1ZxUW82Zk5zWi5ZGvUlk9qwwQcuI5CFTH+pz23lUNfgIFWBP/Cy1c5fwn3
 P+WZwnRynA7Cy2uZH4xs/1S1vPxO4WuihUOI2r57YNg0mWTEjHJIOlplZehms0pHE/wb
 5NQddEVd9VSKIILxkQc/rfY/esN7imNrm36DOdkrfAnh18ZjgQKK4Vo96WtKdqmLIVFT
 VzImz0XxELGzZ/M8RMmcBM4tfywAXzjGshmYxR/355xlX+aHk4LhzM8ySGLZ4T235+7l
 zxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fz8hW0rQL2BFWDQ7fXs/tsxlHR7pJWzaFh8CCh2tyi8=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=I6hxR4JctjHZWOsXo8DOwkoLeiRgE3X3kj5LLNxt880ck44lxK4ox8v5LNJ74HBmhp
 c0QsxvJjcxunqPpAGDS55J1FuJtQHVWL/k8MrBhwlzxe355g9ri/08evUA2OYs1OAaw9
 wZPkwe7gTw14tQMNfYF8f03qZhb4TpYQawd1vzmw0yfHef8COGqVvY4yc/dOv1K1rVao
 1Mv8fGR7l4K6OwpFM499yf17ViCbRYTiEAehYHmXb77xQj7AlY/iFoh5mM/0nwirQVne
 8bdU9405L57hs5+Spr1Z4Y9w9M+F5ri8BOVIdWXLTu3SpNqeou0EbDsw782bRmxOimds
 TgLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258885; x=1778863685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fz8hW0rQL2BFWDQ7fXs/tsxlHR7pJWzaFh8CCh2tyi8=;
 b=mwe4Ud8dkdZbhwNiHVOJeHnWr0WCmsuTs+QGOee8kmYM1/Fk4cO4klBld0oxOD+oVa
 KZEuxoBYyLykXo6UlhN8zD9lZ3IYgwtmrZMm7WoKWsN/B4j1wdA4xbZ8Pv6gRSMnjvbL
 MTUEsIabspsAt+jwrUm6sSlzQnu8ZuObwRCgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258885; x=1778863685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz8hW0rQL2BFWDQ7fXs/tsxlHR7pJWzaFh8CCh2tyi8=;
 b=Yvbmwky3MFyt3xZdL5Ex3pkF8NK6xQ+barNV/AB3vI7uXygbYCy+q7ARTG4UP3w2FV
 FOr15YeynGGSvaw83rS5/wp8AoL0CI2TSnWaYbIJ8K/Ni+P6lAcdSLFE34wOztfntVLv
 narmlKcjXBnJLfezAqfC1aamCT50DfKHHMRcn7IgFSx7tDXGuf/qmEQGyUM/IKhzux/1
 d1L4AOwVDSi39ttgTDvrkGjmdLoEZbt6ECQp1U3KYvgANbzHNhNu8u9mW1Ka75ST3pKN
 +AoBmjXHlhZbTIfg8PNijLVrb/7JKS4pd1YVciruJrreHfuDzj2NLumA81jPXG/XhwQH
 ce8A==
X-Gm-Message-State: AOJu0YwRGWb7eUH7JnPESX3RkgYEF1RwPREk0v42UyrNAJKPsewbQUFo
 GgchZMt/5jSXd6/YpzWYjEVEJLSiCQm1i7AzFmDAJKYh56YGhbo79THXi0sOcX08VGwYf6MZGJ7
 nPBjNMzaG4E1pkRYIff7I8jn9NSGf6q7o7qrrQN22
X-Gm-Gg: AeBDiev2Hu+7YhKmBXLIjx1NmE30UDtyWQieOjjNYfh+tb/C4+D9KJcaR7RbVUEknJ2
 VsdB3UjelH3EhYloDgAHNPS1mVPyChs6j7vCZutS//LbQrPSP3JQ/XLy3y8n7yFxonkCLpI/NtQ
 ieQmdy9bpnMhfVrqHPUAwheYxq8TWALd/4U6w/ONBx2Qm0cHq2R9chbhE/ySbRnVmr40zchok3h
 Chhaz3P5Li0Gs+7C4KDxkokxFvSOmo0m7AzFoork7n6q773Z0uWkzPpmmpPNIRxUbm7rlvPhVLX
 p0BoUY41l8yFckYc
X-Received: by 2002:a17:907:84c8:b0:bc5:af1a:2b3e with SMTP id
 a640c23a62f3a-bc5af1a31cbmr509136566b.5.1778258884614; Fri, 08 May 2026
 09:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
 <20260508-qcom_spl-v6-1-aaac1ab17b50@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v6-1-aaac1ab17b50@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:47:49 -0600
X-Gm-Features: AVHnY4IvDzpoMGTC8wF7KEu8xaybpQu0YxiXCYgScLhpfTAWtS7-klwTemcFz6Y
Message-ID: <CAFLszTj_YDOzUs+JYFFMkyczNrK9W9cU9aEPy+Hwd_K9qmiNGA@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 08 May 2026 19:24:23 +0200
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

On 2026-05-08T00:33:28, Michael Srba <michael.srba@seznam.cz> wrote:
> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>
> Some platforms (e.g. at least Qualcomm) use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> Makefile           |  9 +++++++--
>  common/spl/Kconfig | 12 ++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
