Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE4CE937E4
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E6F841E6;
	Sun, 12 Apr 2026 15:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G43Ze4bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58D78416F; Sat, 11 Apr 2026 17:40:32 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66D480077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so429279766b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922030; cv=none;
 d=google.com; s=arc-20240605;
 b=BNQ9gQIlwYsYXbooHbvDGinGWSgdd9K+W1fYrKBwgrqx1PXDm9tD0PvMqR9WxlN/au
 8rfhvz2OS+z3a147Duxa7t5OkfrtVyOuLm/ZyhWzSgeSLJ6b9dPxTWVZvk4n1hSHxciK
 f294l1qnwlw1Fbv7HAUKPn29u6MAvi9eobpM0IVbSIjg+DQRxDGoqkYyhzk0huDx7hI/
 Sv0KOTz5VwFYcTtCT7Oj6TlcY1ZZWlc0cxCVq5pg56RrOudPzKEISqwMGsz1GIEcXItQ
 ReQ3pyGfFNfemrHPGjq+e1KF/Nq7eQVeGsInXzLchB0fuxRqw5CA51gzE4p9PBpiTnnC
 Rxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0r42ofB0eMuhhT15xLRsqkFbyqh9OfuigWoGXdZR7Cw=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=Y2d/4Ysifc3p5iZJyE9W0T7sec/G9ABIBKrjMl7xS4H3HkzvpZtARJAmsPRblsREHI
 rQfbktisg5ia5pafURSkxXhepo2gYW31pF1zPOkiGcel+9iPJzxnCqTXfK/So0ZFFkgJ
 sVY/W2oK2dmSivoAy3F3lLEeKDbEiHlhMCCZRf5GBWeut+7TXJ0uqaZf+fLL2ZMIMVvT
 aQntO2vSldE9eCRR3wRsltREzUOcYfHJkpGCxP3W7vEckV7By6Fg+L9HyxP99PMUgzk5
 1ZPnQTEak4i77pYmGmFOsFyHRIo89wy88LfcF+jggXGjf1t6lFhPn/kRCEfO363C/SII
 7ieQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922030; x=1776526830; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r42ofB0eMuhhT15xLRsqkFbyqh9OfuigWoGXdZR7Cw=;
 b=G43Ze4bQPnarRPdDS0oBQPtaLogaYvZXQZAxIIn/djkJ7gc9mjtUT/M2PzthLXdJtc
 jabG+uzVGXz3iFHUP6Z1x3Qovb2Cj4yrxS0pQLNi83NhM3Wd0O5kyU4huRqeBLJsQK5y
 VNN676dNVu3WXYFbdneGCkfPvxOQssCsH/26g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922030; x=1776526830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0r42ofB0eMuhhT15xLRsqkFbyqh9OfuigWoGXdZR7Cw=;
 b=hbkWeKGcGCRZ2Gba/Nt84xtXsyUFYyjlR9L0SmmqugBYevINbt43MnX/OiuW7FvlDA
 cjftQw43XuEL5cnyN38MFhGtKYnX3K0B9pk48l18GbFAeba6lVTaGXrmzicNUbop2dED
 cZ4+0UZ59JAayVsQZGjV/hTIfvQ8Es8JQA4uUGB8KuHweKHnw70z/UMGZvmeokcENWfU
 NCyQfZsjXPvkOLckaaA6pAEl45n2oe8mytGlGcLXX4SA/hCZ7fPbyO87Ahq5QeZ9iy3t
 LRxVEjKjOUJgs+7rFYet+oPVvIwM0ZghgLF6B2AbsKReKlT2B4PaVcz1vhcSZoAzwPjq
 gXxg==
X-Gm-Message-State: AOJu0YyGNN72MNqXw7TSWRy636+uLFfWsMTUhIL6/+/JDG/YXI9NAOQc
 Nd+LVXaaJmc9Xq5oqlFs51kN0ZXBuJ+UJkg/aDrXL5eAK/EyzjkAauWqNI13HQpTXv125HJTIzY
 o28Sfbvi+Et8475j3WcfoKeKjVfBV2/XIOLIWdsqi
X-Gm-Gg: AeBDieuyvj2U2VNRNEIHHby8y17Df8/RNgzjq4zzHKF0H+Uz5UAaBwQoAjI1Fm9z/HD
 MC97JsgWOYdV6Jw10fbuWl1dkcINn/MSa7vIso2QhkYNZmmC+qnUVPD7TmBdK9pvgh5nuleD43k
 TzRPT1iFsDkoI3mS5CiJJc80CDgcLR7R+SecWQE6f1h6kOZd05kNRb2aNIrirXmY+oVcHaUNkO6
 cGmLInsnjJvWDwVDhvxI/xNuM+Y3Rz189pct8CaOY962xLxS8cSI8C4Wli0o04oP9dxI6kU38Z1
 M0M2Es7NCeHf2PNh
X-Received: by 2002:a17:907:1b11:b0:b9c:b8b5:2dad with SMTP id
 a640c23a62f3a-b9d72499671mr402394966b.8.1775922030135; Sat, 11 Apr 2026
 08:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-5-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-5-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:40:16 -0600
X-Gm-Features: AQROBzCwMNDuLQM22zSB1vh-mttZzaYejODb-57TOHnS5SJdPeuAiGvEnouWPX0
Message-ID: <CAFLszTjYqRuZSnV2=Ra_2SkW=AdCHuJUmnJzzob39F_QK2PaHw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mach-snapdragon: add u-boot-spl-elf-sdm845.lds
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: add u-boot-spl-elf-sdm845.lds
>
> This custom linker script is required to produce a bootable ELF
> for the sdm845 SoC. An xbl_sec.elf must be provided, which will
> be put in a section in the ELF as required by the boot rom.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds | 25 +++++++++++++++++=
+++++
>  1 file changed, 25 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds b/arch/ar=
m/mach-snapdragon/u-boot-spl-elf-sdm845.lds
> new file mode 100644
> @@ -0,0 +1,25 @@
> +TARGET("binary")

Please can you add an SPDX licence header? Other linker scripts like
arch/arm/cpu/armv8/u-boot-spl.lds have one.

> @@ -0,0 +1,25 @@
> +     xbl_sec PT_LOAD FLAGS(5 | (0x5 << 24));

The FLAGS(5 | (0x5 << 24)) magic number could use a comment explaining
what the upper bits represent =E2=80=94 presumably some Qualcomm-specific
segment flag?

> @@ -0,0 +1,25 @@
> +     . =3D 0x0000000014699000;

This address appears specific to a particular XBL_SEC build (cf.
XBL_SEC_DONOR_SCM_ADDR in patch 7). Please can you add a comment
documenting where this comes from and whether it applies to all sdm845
devices?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
