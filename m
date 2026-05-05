Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C9ACD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4731849A8;
	Tue,  5 May 2026 17:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STqbVzlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D57984949; Tue,  5 May 2026 15:58:51 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C5F848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso2991128a12.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989529; cv=none;
 d=google.com; s=arc-20240605;
 b=a0OXiFwiB5SxW/CWZxriZ5SbqjbeJSh4G25jSxyIFgTtw2N8MoBiEkXbR7UsT7CrvP
 Z2TQrKVIrC71os4HHZJ1me6cFZR0KmZss89E/MFEOdvyaLSOlhJzqmtyxxFDC+Uv0PfI
 pGSVTcPzXQfZZbmY9cgpGJiq9PW4koihnm9JonbjqVzSx+meSKdAjiLYsCKGE2+EYVxa
 uPrxASj8+hVxq84/OX0OVNxx8FkHIhKHEnjKgU0mq0o89ZMPWg+f72GWvG1MlfmJf0mH
 jtOJHlaTvPf6BDskdkRxHIVHTcBqEbZQWJbFiAIofAOpnDV75L4Vt+fWWkALa5loJRlW
 BQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I0OLmYKyF0zquofKxWrSol32T/HUiDSvMMd9kx7DM+Y=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=LBFeF3L1NH+aTzBS1IUK1zOodEpPGya6ZgJkjUh+JF33WY/zRKoclnvxayqNCvggRM
 ZD67GfMV0gRJBLuZiMfVkftdBdZdCP9sIbqA/puCoDaHt4vyJXuVGrrpvt5f2iLCZBr1
 3cJAZIKGDCI7U8ycST89MW+8LPjwvqP39JZ4SEdDh95uE72fYDL3UG6wSAda6LXYlhyO
 z42vwVORnIQplAfjzefr7ZjeVbYzuDisA7nS5RqEVMtlvgapi6ZTUFMrhfV6nm4g07pj
 /DfSKQpo77Loos6jLRqxyJCG31SkiQvOVhHEES3uvi1wXch1Lkmf/KS+8LfIZA8j3S7J
 pfyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777989529; x=1778594329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0OLmYKyF0zquofKxWrSol32T/HUiDSvMMd9kx7DM+Y=;
 b=STqbVzlzSHuB973oNKcAJQi12smJKJJd1TwnxWv91Pe3Dl1bjj95B9yMTaNu97LQSs
 QbHe2lXdc9hsq0ETxo3B1i0lnUiXjtpqvr6lJXtQhSbYbW7Dk+Va6Fwh4gigg91Tm3Km
 mWSbV82KEjKcbyfW+p/9sT8swaM+fMI+Yw1hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989529; x=1778594329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0OLmYKyF0zquofKxWrSol32T/HUiDSvMMd9kx7DM+Y=;
 b=Rmc5hRiyqC3bYY2bHQN0G4qRW7ii5PJ0c41UZMA3h0zrdoofEPlKr3dNPumpuLc6aG
 U0AJI1Qr1Lny/u9RYojzmdxhsy8RbvHZ75oa9WTYqbrl8pzcGaBOGJck4FBpbnNf48PD
 /nFjFdzO1x79xMbO/HMXShiJmdnQ6GuJBaEYW6MMEViekZlW5YxNJw4+q48nbqYz4sH2
 3vQX8ujmVPmmSFlr+y7HW2KqUK+9qn+p+fwAd2YdMIVEkdDIStQ7W7xHS7T/YxQ4Y0HE
 CWJ4nzenf2C676XqnYCb4RRNLgSmOJB2ugvU31H0Eaj+LYaYpDz1KHc9JWiRUZ5Yj1WU
 dp9g==
X-Gm-Message-State: AOJu0YyvJYBnNSAHV7QeVueBD0lAiDQ4xTnfLWPRnU/zOKvOzw4UL0av
 g2CtA/5s9TFXnawHj0cNNxj1NaHaWE0E+GSdldgsS5n0Jz+foV5NA1Sg8tF9Y9FLdxeJW/SlBS2
 Lwip4UKCosBc2ZocVH8Gxv1E9xCg97OFsyg0M03sm
X-Gm-Gg: AeBDietWPtr/p9dnGj0M4McJbHQqvFlocm0O+IaZI4kzK3VFrPuTdcqQmk4/VYQ0KDZ
 25kb6ttqFNfuEj4C6tiURz22A/Idu2R7ggdMEipL5hEFKUhLIhYiB6B9qA5GV93SjxbP2hCBsbG
 dX1kr3KW/iGGdpEEopS+EVobh/EMIcRiIuQd7FwcvIyZ0vwm4ImuwCH6wuFwUowowoxTgbr0HwK
 ZGvUVqyL+NpG/5zobftQCUi4Etm6GP8+TDrvVHe4DI2noAW9MRJHaf0s+R8wbfPiD97eFcAC+W4
 gZXf03nuUu2WMnLi
X-Received: by 2002:a17:907:9623:b0:bc4:a75e:1abb with SMTP id
 a640c23a62f3a-bc4a75e43afmr111022266b.21.1777989528544; Tue, 05 May 2026
 06:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-1-11817415d664@seznam.cz>
In-Reply-To: <20260505-qcom_spl-v5-1-11817415d664@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 07:58:35 -0600
X-Gm-Features: AVHnY4IMh-iLDUOnWaoTNBTe9VwHSTM7fbaZL2MFRLXKeOGvvIM-zmcHIATLHRc
Message-ID: <CAFLszTj83hXz+mWj4jfJa6p5RY-yXCbpV0hrD2OFLgr0LPXz0w@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
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
X-Mailman-Approved-At: Tue, 05 May 2026 17:49:47 +0200
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

Hi Michael,

On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
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
>  common/spl/Kconfig | 11 +++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -238,6 +238,17 @@ config SPL_HANDOFF
> +     help
> +       This allows specifying a linker script that will be used to re-wrap
> +       the SPL binary into an ELF.
> +       Some platforms (e.g. at least Qualcomm) use the ELF format in creative
> +       ways, including in the bootrom. For such platforms, you can change
> +       the default linker script to a platform-specific one.

Please add a blank line between the two paragraphs so menuconfig
renders them separately.

Missing file, as mentioned by Michal

Regards,
Simon
