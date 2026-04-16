Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14DCF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107EE8438A;
	Fri, 17 Apr 2026 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m39WcxHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED2784223; Thu, 16 Apr 2026 23:10:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9296F83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so2973966b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373797; cv=none;
 d=google.com; s=arc-20240605;
 b=FW6gpgJux03i1LrrZxnvgp4WCTttt6Cp8rkcfBFIgCxZhTJajjcvqNR+E3L/auq3jr
 7SM95SWzyEHy+AeDziuvUL2Z6HQNUtE5fyl/NvaOVkXcypMGODD0shF4NsQ2flrQzcHl
 Ve5plGr8/xTG0klMXaCwoV8NB1/A8ITryiEwsG8EqilWhUbdijhVzZIfrAGons/zgrzM
 Bz1CYKmkX6OJt5nfnK6OtSsRRHTmUMh6Nu39o5lA/WbM2CkQlD81ulhgkq2sb+C+Nz3b
 belUPCYbLwyMOwvGHS0pFOlmxsa6Ed9DzQ2mC8CQpEgnYpx7bAPrexBhlDNr2e1cFMzV
 sQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zp6ukd6qqzrO96Wdhhm74wcmu44JiRbQTDcMVI9iUG4=;
 fh=Y05uyWvlWwHALZhvTxBHJSAYJ7MfbO3/NccAhjMa4nk=;
 b=EBtj8kLJ3p/SGhQGKQOfg6hc62wfpgG8naNTZ/TcJuOw/OLwqZvUDdhyDjDYvd+5mn
 9PKDKTVbSjcDaJhk9lDM6yPfxCXgRN0NZgzlIb3Ksg8HUizv4K1gAQrq95GM+e7YIH7X
 WIkEJ0UUkFFbrN0Q92DqEh2WacAvlyszjt6dF4nJBJeVEm9fiKG5tGEEYR+Tn42LYsG5
 IKTQuYNXvsGPveYvMTen8uB3gSgAyBMl/YFOE96broksdQdb+8BHirw0NcFVi4L+3tKi
 NjUpqlUyGMLJ72MzKE71cFvmf6FjZZXXCExooMEhe0Cl8gX3wlG6JolAgauSdLNctoTx
 6N0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776373797; x=1776978597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zp6ukd6qqzrO96Wdhhm74wcmu44JiRbQTDcMVI9iUG4=;
 b=m39WcxHFDJpCRuXSqfiUI/BR7ujYuadcaxkXxra4gEImA0t8l/M9PzBsVQLbpSFbLI
 wMu4hn6FEzeQl7XzQug9+5P1YInx8661xVD4GdXM8ABsL+gOyY+rSaeQnts2GRhNXIT5
 Pg6NLRYKCDfX1ew5+WwZPFyLrWo91Zij1C/hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373797; x=1776978597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zp6ukd6qqzrO96Wdhhm74wcmu44JiRbQTDcMVI9iUG4=;
 b=YdxjLU8ZrJRi7jTe4gvmiLtnx3hlX+doE4u9nKCTNMmf932C05tvx6SCRyoArnJ0fJ
 wEtvpu9CXqswTPl6wvPMieFqyiRPU0UN/ot9Z9m3tRTsGFegV+/NhVeQG2N0XV6CJEVA
 fvDNz85v29ZkEds1WIsIF/dM+DDMaZJp1uAEnb0SYoL9bsiCa7/Yc9cAsL13pmEzYnSO
 D5nbrp0qG51nuFT/ecDJrwBbq6Ia56pF2YOELmefDUOkk39herGdEWk9ulFJV/m1Gqa5
 VM3epAU3rxbbp34ktUubZzTqvHhc+SrdZiEfLpwASFxdJaebs10KK1A+bm4hukXXAJB3
 AmFg==
X-Gm-Message-State: AOJu0YxrEHP0RZE8BldLiqbw5IkXYPaza950NpE/FFaUP5LLWvMRj032
 2a9t8DyMMV29B9zZuXbc7qfyn1SOsDF15HVf7CekpnoxcdIGXLfAI7N81gqwtn/Q4F3yfuUdgkA
 HVIosfx2Rl6lbaEkrfPLnzoYr4SqtB/dodo66FDaW
X-Gm-Gg: AeBDieswC0Fh2Odv509IW7mrjjRUffj1VOB5NCRh3VLXaeZyMAxvEEKr5cpqJ7OrwMU
 F+4cL7XXXykzYfOTzorqWZZuHKRRPVvoW/saGUwR4cCDQm9GX+AAyZ0R+Y0bCO6xJF5ZqtbzRZJ
 xb+JpQhhUiziMybreYik1U1Ms5Zavp0Q67mx8bH28ogsbGG8QykVPl7Bra56WN8nE/x2Cm+51kV
 k7/c7zBCvU/ljHQgTg5QulNFJpH9ty2KKQaZ3chOJPMlPrAo2+dUimb8DUA99Bo1CsRbPzObPrm
 QlCsjdAS4xlc4GVWOQrs
X-Received: by 2002:a17:907:93c4:b0:b97:c684:57db with SMTP id
 a640c23a62f3a-ba4191702f4mr5264366b.12.1776373796920; Thu, 16 Apr 2026
 14:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-7-9609557cf562@seznam.cz>
 <CAFLszTicL2M709+Mm3g1bdnVcYwcuX4SOEPKjbqW1SuJ8LF+2g@mail.gmail.com>
 <c2f3199f-480a-4d28-840d-f29bd9e5f0b9@seznam.cz>
In-Reply-To: <c2f3199f-480a-4d28-840d-f29bd9e5f0b9@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:09:44 +1200
X-Gm-Features: AQROBzBSB6NSs7itqsvHiZchlhCFVb0xA1HGNMQur8nkz1YDtQs4mfBvsrfYDKU
Message-ID: <CAFLszTjKzDFt2ZHS04pCxYyEBFFsS0r1_WrafL+GSr74e+Lcpw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
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
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

On Fri, 17 Apr 2026 at 07:15, Michael Srba <Michael.Srba@seznam.cz> wrote:
>
> Hi,
>
> On 4/11/26 17:40, Simon Glass wrote:
> > Hi Michael,
> >
> > On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> >> mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
> >>
> >> On sdm845, running u-boot SPL in EL3 requires escalting by using
> >> an unintentional feature in old builds of xbl_sec.elf. We do this
> >> in boot0.h so the rest of U-Boot can stay blissfully unaware
> >> of XBL_SEC. If we are already in EL3 for whatever reason, the
> >> code is skipped.
> >>
> >> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> >>
> >> arch/arm/mach-snapdragon/include/mach/boot0.h      |   4 +
> >>   .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++++
> >>   2 files changed, 124 insertions(+)
> >> diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
> >> @@ -0,0 +1,120 @@
> >> +.macro movl Wn, imm
> >> +    movz    \Xn,  \imm & 0xFFFF
> >> +    movk    \Xn, (\imm >> 16) & 0xFFFF, lsl 16
> >> +.endm
> > The macro parameter is named Wn but the body references \Xn - does
> > this actually build?
> I'm not sure why it displays like that for you, both for me locally and on
> https://lore.kernel.org/all/20260411-qcom_spl-v2-7-9609557cf562@seznam.cz/
> it displays correctly...

Yes I see it, thanks.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
