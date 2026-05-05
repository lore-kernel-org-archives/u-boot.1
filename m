Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEFECD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3995849AD;
	Tue,  5 May 2026 17:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OHRS6U0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFBA8494B; Tue,  5 May 2026 16:01:15 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E39C848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so838807266b.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989673; cv=none;
 d=google.com; s=arc-20240605;
 b=LbSt+bZnTTKqq+0FmfanqTcgt1xZqdAYJBd1zR9VhLkVo/uzUGMkh2iUFg5Xml6iZL
 0w2SlXwdrAoBt/cY3uq/5P6QpKObvrkpUjA0rAviJvdm8fKbjanfCXjC6AdVshwlpuf/
 OkeGhF67dXv38rXHQDRIYqEDiSqEjWXS/nFLj3/Sgo9rV3Iv79jSGN42PywREkcbAj4S
 3K3/XWRWFlSAjsNrqTny7e7Yx79RDyhBwt4OabgXu+hJ7dy8sYUdkOchsroVnGYlyPa8
 lUnr4t5dQAOTCukkLRMKvCMckq0WSUogSOo/wS+R6Up2CemTohqEJJgFUykrqeSnWK1Z
 HkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IEr1X+AEq4NYb3E3owmDUy8jhHx+ItQjpnL+d13CAR0=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=aotA9CRelKBdL9je3FT1hlETmpBqCj4rdFylxM1o6Qs5kd/GCTn2E0zItRd+dPhpJs
 Nm61qdlkiSj3wXc7IHDM5JNSQZ2XFa8guTtoOpA0mU3EE3nCBQnWuUtlCwqDWIEx8stl
 aBrfb3QXoTUYAgnHrCpwAsQJSKRjQ1Qcf6JWAvAQn4rGpHKQ/wWDKgMgFL4VYZj09Dvn
 9U1F3sOh4+W6OZnLmQDYSHqHpH2znKQWWZ+4b4sJspM1H9Ij5HLIkWSlCI6ShoY0HKjx
 tu23q/Ps5GrwPhYAJiVKC0j8rbM2GuiBFCOCV++LMXPw79KssXr4l0723KzcHpmE0E/I
 GTYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777989673; x=1778594473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IEr1X+AEq4NYb3E3owmDUy8jhHx+ItQjpnL+d13CAR0=;
 b=OHRS6U0DXcipQHZN/HK5oUZ4QaxkoxN7Gw0PwP5ZxNYsdtfdPZlujJLnZ0O/nOGWp4
 VpJcHW3w+fGfVSULc2i58vuA80ZIkxkB9hkqcCqehYvcY3dYHMtu1qwkJPSzfndIBgcE
 ZfkTHHXntzqMe/UtHqXkQqRoXFOc/xkqss4Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989673; x=1778594473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEr1X+AEq4NYb3E3owmDUy8jhHx+ItQjpnL+d13CAR0=;
 b=mW0pUVYMantr3aAswuwO6O3hEyepyDXsEWIZF9sNSvDp5cbJV5c3Jwh/LqrLNsFOR4
 dXe0csthrupLjICiHh5X6xnNdnh6Pm2YGh+o5NgO10przKwQh0DIKEASRRs6lu5dPnNQ
 TKWberQ8OXVeaWAWKub/x0hZj1HBSS4VufGsGZXIuNfTX495Ygojmdhv1djAB89UoFKg
 +t4gjiG7/qu/b+cvCaA/zmnFuQjxTp9V06U4p+TsgpSsMkrEcbuLdWP+f31QienIwZqu
 y1tPDZ/fiRuH2LxAEw+mYcjYmnI0xNQU6xVE8II3UY6/Fwv7dmAPwOgtUpYVzdwJs284
 iKYg==
X-Gm-Message-State: AOJu0YwdW7SOAxp0xBBkCnzaTe3lEHpraebmLaVfAjX4HhtTdxRID3h0
 Lcdp0nEp/HKPg3lqg+MbYTiTiuPwl8aNggm0ZnOfko+d+ugzvuypWZEqxAUSIliijPWDSaN2u4k
 YhHMI8q5UvsCmg85rdfK5jwZpEU14jwJF9q43qEyW
X-Gm-Gg: AeBDietW+2ShDCVGGQxtOYryFrTNI8i1ODkxoBlKUeXmd9MKFzkePF1Uf5YyYusfkEr
 vZaDbabkMD5RRutbWIFp9Nf0OpJJ14SjpWb8yEnnJde+mQ2pt8pfaHAeiNnUFkIRPRaQNYJm+2J
 /61lxi6AjBIFi46nSKtdx5dYTEGGZ0VatfvTPbDw/Gp9bP+jE7O/8yC9Ft1BHhdH4JbOtwBoVwZ
 pNsYijGlvepxSoz2eAQmeuHX1fjO5VIHZ6JoCauXluBBy8EwWnQFCUdmH9YhLWnhO3haei9tHOA
 kB4jcPzHva+JyKBI
X-Received: by 2002:a17:907:c06:b0:bc1:6ec9:453f with SMTP id
 a640c23a62f3a-bc16ec95210mr606369066b.8.1777989671639; Tue, 05 May 2026
 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-4-11817415d664@seznam.cz>
In-Reply-To: <20260505-qcom_spl-v5-4-11817415d664@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 08:00:58 -0600
X-Gm-Features: AVHnY4J7YSGcH43jmZTJ_z_eJdc4QDPo6V46JUTDE4f1sJuvnANrWNKPRN-h6Ww
Message-ID: <CAFLszThNdiVOs5+q=tVZLxfr14_vxrjYA6rZ-=4J=9T6MAQfGg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] mach-snapdragon: boot0.h: split out
 msm8916_boot0.h
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
> mach-snapdragon: boot0.h: split out msm8916_boot0.h
>
> Prepare for supporting alternative boot0.h per-SoC by splitting out
> the existing msm8916-specific code.
>
> There is now a selection mechanism to choose a specific boot0.h
> in the Kconfig. BOOT0_MSM8916_PSCI_WORKAROUND is the only option
> right now, but more can be added. The toplevel boot0.h additionally
> enables conditionally performing the include only in u-boot proper,
> or only in SPL.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/Kconfig                   | 16 ++++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h      | 58 +++-------------------
>  .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 ++++++++++++++++++++
>  configs/dragonboard410c_defconfig                  |  1 +
>  4 files changed, 77 insertions(+), 52 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
> @@ -1,54 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> +#if defined(CONFIG_SPL_BUILD)
>       b       reset
> +#else
> +#if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
> +#include 'msm8916_boot0.h'
> +#endif
> +#endif

When neither CONFIG_SPL_BUILD nor BOOT0_MSM8916_PSCI_WORKAROUND is
set, this expands to nothing, so start.S falls through into _TEXT_BASE
etc. Is that intended?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
