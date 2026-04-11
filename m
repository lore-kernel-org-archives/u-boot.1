Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A3CE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AA384207;
	Sun, 12 Apr 2026 15:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VtpfFFVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AC08416F; Sat, 11 Apr 2026 17:40:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADC780077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b941762394aso362175966b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922055; cv=none;
 d=google.com; s=arc-20240605;
 b=DAvaSQMdUcu7g6k8w3/d/0anXC/TjN2u/eGJM0WWKlWkPMOm8Up1278TH2LXTDG1Cd
 P4Z6aoEl+PtEV//IWUZygsZH/nk3RnFgBIgFuPeNS60TCzr0EB9olsZ56q6j0l+OhFmy
 BiDyhg7hMBftRjDIod9TgYdozbh/38bsG1a4vu2XBQaYTtiOMEcsy3II3hoLcXpUG6nf
 MFVwfoETsd/o/Q5nHQLnNPgtkSYjrBYniU442xqqeV7LmOUSIO8xHQooNK2lZNJ9eTGQ
 E9qBXr3ftbmfLi+mBf9En8lWJ5DvOczBrOj74rL2U0a3gXgnWi6VSJ8g8EATfwrvFHAH
 ahGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gE+AvNUcfLRVvm7tg2N+YgmxqiOZOg/Iqlzom4tjc+U=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=cnCXi5rklWarNPRhBFQWWgFlvZF8MppR5sNeNm7UaBd/IQaQ0cd8mkBwUDhJz+HaNt
 v/wBJ+G4P5k2NDMtSAo0zKlUlCC88QSgCS8xztBVYWvUPn47OayLSE5zW6cAHA7SArjn
 uCWdV0gsYkSYvQOwx+d+0hQVeSZ9l2qZMCeNvEtLVaoFDfSo0VzGRP/yxIhXqLHfcXys
 iAWFcNsl//TYibvsPezkzmfXVVtbkdTKIDnCkyx9KP5eLStXo+2PBW+lfc79NSlKf212
 mnSgT3c9AwOEzfyObcbByU4Pz5cPKPdnDlXpewTXKOLj62K5ZG8RXS8LjdAPXR7eg1hq
 xeMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922055; x=1776526855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gE+AvNUcfLRVvm7tg2N+YgmxqiOZOg/Iqlzom4tjc+U=;
 b=VtpfFFVPDh0BIKjL3dXTG9PxVFRQ+QQiR6Yvt6N8ZudHxpvLaoCPY7a4e9YbG4twRV
 0pzKAuUh1Pcpcdho/X2QXXhSby6NFfI2axehDFEk3iaqlNr9ygdVoIlVBshOfEBh/pw1
 Xmur2gkY1Yl7RgjFLuVmXT9hnZSjcEdijHiFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922055; x=1776526855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gE+AvNUcfLRVvm7tg2N+YgmxqiOZOg/Iqlzom4tjc+U=;
 b=rP/fZFwA0snPiiHaJrVpZuEn0FuOiCKkSBYXanWNK8RC9J+VJlePJk76lyn5QK6AaE
 4O2witRee5mutyGUZS78w+qnAcieS43ZheZCvOycYOD1sCPoGfDniO4FqX0jwbaS1vX8
 BDD8zRxNJOn1QgjpLD7nXutFjz1TlHr+McuPVW6uaNr4NtxN1i46w2f+JBjNDBckQRpd
 6834fsUJ5Tvrs4Y76P0DahBonAaSgAXfsVL3ORHo/PaKmPLlN+V3CT2sU93OTFrLXid+
 5gLhXtYn9S5+EHA0kOV4eL0K2oz6Vwjz5sON0KAYgnrxmyb2Z9lvORsk/s2/psWy4cLx
 HtSg==
X-Gm-Message-State: AOJu0Yy5qG6hNC7M8XxWhAuBx0EvqRDe5ArdBYMj/j/plFhVRx24BN7O
 VDvhyesxSy6wZd97QJyk1AURAt4In6/qVmmhvKKDny4qAOZAIh26z9A36f/qNk1ZEUL6sLqOnW5
 SboSCHb3lSLaAzW/nzyQRbEh426mKu8Oz3nzdZXsn
X-Gm-Gg: AeBDiesR7IUcv4Dg+FZsH9NlDK0KU0ceKIpiyF7wWkL5yiHYImU5ZCsw1NMrRqJitgS
 nXUbuul166cpd4bdsdXJIPkJPXTrPuk+5Y2YSsD3T0pT48UlWsnfbm3D0jLDi/tbP/FT2ji/Tu5
 rGyKTCu4+pfxw0tLgD7YvnVca00/lzo5F5ofmdGlVtLQpi19PEMfdDZ25uAth3+J/Ifc6Djezp1
 8v/tsQ5wOVjfiQ81Df0istE4jpBjm0h5o1AjA/jwTE3karZLwpEW/MOaexSAhB/PE3hbtBDRb05
 3k4YJA==
X-Received: by 2002:a17:907:d0d:b0:b9c:f69:598c with SMTP id
 a640c23a62f3a-b9d725ebe50mr416442366b.22.1775922054813; Sat, 11 Apr 2026
 08:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-7-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-7-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:40:42 -0600
X-Gm-Features: AQROBzAE1a4BMy9hrQBeMCD3Yz7xVgAZzLrlknIg5n-oX-ZKOizWn8LZYEH9iso
Message-ID: <CAFLszTicL2M709+Mm3g1bdnVcYwcuX4SOEPKjbqW1SuJ8LF+2g@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
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
> mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
>
> On sdm845, running u-boot SPL in EL3 requires escalting by using
> an unintentional feature in old builds of xbl_sec.elf. We do this
> in boot0.h so the rest of U-Boot can stay blissfully unaware
> of XBL_SEC. If we are already in EL3 for whatever reason, the
> code is skipped.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/include/mach/boot0.h      |   4 +
>  .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++++
>  2 files changed, 124 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
> @@ -0,0 +1,120 @@
> +.macro movl Wn, imm
> +    movz    \Xn,  \imm & 0xFFFF
> +    movk    \Xn, (\imm >> 16) & 0xFFFF, lsl 16
> +.endm

The macro parameter is named Wn but the body references \Xn - does
this actually build?

> @@ -0,0 +1,120 @@
> +.macro movq Xn, imm
> +    movz    \Xn,  \imm & 0xFFFF

Similar issue to above - also please use tabs to indent.

> @@ -0,0 +1,120 @@
> +el3_payload:
> +     /* disable the mmu for EL3 too */
> +     mrs     x0, sctlr_el3
> +     and     x0, x0, #~(1 << 0) // CTRL_M
> +     msr     sctlr_el3, x0
> +
> +     /* jump back to our code, but now in EL3 */
> +     movl    x0, CONFIG_SPL_TEXT_BASE
> +     add     x0, x0, (el3_ret_point - _start)
> +     br      x0
> +el3_payload_end:

After disabling the MMU in EL3 shouldn't you have an ISB before the branch?

Regards,
Simon
