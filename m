Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A190FCD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D3C8498F;
	Mon,  1 Jun 2026 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="xNbSIKcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734DC846D3; Mon,  1 Jun 2026 10:16:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743528466E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so1875115e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1780301815; x=1780906615; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xKYliG9TQlh461JhpcB0Yiq3L+b9gutQb1IEtJzA+M=;
 b=xNbSIKcLgDWUwFzrePSviLslxRJW+LP6BChdfejcjYyzIz5MpZlF/5DAeez1pZ2hs+
 EroI23T9WJS26ujD0B/xOqAIOdfTNdb6pOojUJ/widJ6dnu4dZfVJ3/cv0Q+MibdnQFu
 dRpN0K3mvodWKzCeauw2Pel5L9Wlge3FTprVpr7fgmZ0AEVfEPg08kSo9nMSej8bpiOK
 42HrMZNgZxMG/KeAOel8TaRrJVnsfwHPStb1YW3TZOlu/39t83Y5IDScNaMhT1A2f6EV
 szPfSe3VmH8zUi8O3zm3VRES3DfG2xFryGae1fXu4X3rZ2zdRQd4gffjQOLO5bMxD1IU
 0aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780301815; x=1780906615;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xKYliG9TQlh461JhpcB0Yiq3L+b9gutQb1IEtJzA+M=;
 b=PjXsUP0zniN/esX/hV5ZP55rRhgcW2mXSp7rHW9N1kzpYM7RS+cPkD9VDI1q1pMm1Q
 m+jKTN9x6+5SsNslgYhnqW1PXkPcu01RsnAfWa5aCbnXqqgf6BFnhKJplM2NUFp2KJOm
 InMgOZRcQ9PytdlcZWhWlKXlxqm8AZz8rnTbhzYuzowaOHQsoADT2QCDHvtq/hAhTRwX
 2ftMLwMiA1hLDXX6oGa0iRlGzlmNY/rW4hxHx42b6pvsEIHafQaoMKaNUN9RD8TTunAW
 NAk/jttjRisGGpic7DlY0hOfTaAdcOgu2qCodk94csKdhrBrUAty257MvfN3zpc/9q0z
 7Cbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QGigs+05xbe2jiMAoKKsTiH0yYFuX2DPKS8mUx8M8rwpX2aO4F74eJK+AqFLfueVYE7O+L9g=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq5xEGZW99+Oatsgmpx+QiWktbWhZWBv6VFK9GOLRhDUgC1JHd
 8TWiLoykmJM6bfoWOejYzqM25SxLRCQ8K3JOaDXG4JxYYzithXjsMWTZenRo1uAn4cU=
X-Gm-Gg: Acq92OH4xLuhvt60UJGD4PTpK/clxXfzpqfcMwU/lG6bIdYoaO9n4oQqYFz94XIwsmK
 Dv8ufwDXHJBBKeh/i08Ar5F++RYKQ7hjivNI5P3hkZmJrDGHllxhIs9FrytvtpPnz8cMtKg1ben
 opmNscXx89GRtKfCqC4KlhrCqNJykOS1XHGyNUeD197OEK75EkbkCV4xf/f9VD1kRinMAZRiE9g
 QEA/341l4tEJlWOrCW7P1pCG70wPaC5eeHYhITOIIt1+1k5KE++dZgdMqLG7qswaTZwhSdkmV+0
 N1LpPqSNQkIXFMxj3NOZLThPixDPtGEeWewTcrqmldLe/00E9n1ZuOjBkdgnhYJtwbQpf1OYVyI
 /eAhiE06fG/RupPU51RHW0QONCSu+oMKcNtA6zLV8Lfl7vX1QUNO+L9s4OOgmaH9/mOC161pBEr
 ojuTwjyMFiPcvZnFVAATHv+HFk76Cgps7Bb2Yj
X-Received: by 2002:a05:600c:16c4:b0:490:50eb:b753 with SMTP id
 5b1f17b1804b1-490a294b7bdmr109864415e9.32.1780301814890; 
 Mon, 01 Jun 2026 01:16:54 -0700 (PDT)
Received: from localhost ([212.133.41.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b7d6bsm24722414f8f.10.2026.06.01.01.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 01:16:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 10:16:51 +0200
Message-Id: <DIXKBLJOKXKW.1XUJDRJ3V5PY2@fairphone.com>
Cc: "Casey Connolly" <casey.connolly@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Tom Rini" <trini@konsulko.com>, "Stephan
 Gerhold" <stephan.gerhold@linaro.org>, "Michal Simek"
 <michal.simek@amd.com>, "Angelo Dureghello" <angelo@kernel-space.org>,
 "Eugen Hristev" <ehristev@kernel.org>, "Kuan-Wei Chiu"
 <visitorckw@gmail.com>, "Yao Zi" <me@ziyao.cc>, "Simon Glass"
 <sjg@chromium.org>, "Sughosh Ganu" <sughosh.ganu@arm.com>, "George Chan"
 <gchan9527@gmail.com>, "Antony Kurniawan Soemardi" <linux@smankusors.com>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Peng Fan" <peng.fan@nxp.com>, "Alif Zakuan
 Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, "Anshul Dalal"
 <anshuld@ti.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Tingting Meng" <tingting.meng@altera.com>, "Alice Guo"
 <alice.guo@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Aswin Murugan"
 <aswin.murugan@oss.qualcomm.com>, "David Wronek"
 <david.wronek@mainlining.org>, "Danila Tikhonov" <danila@jiaxyga.com>,
 "Varadarajan Narayanan" <quic_varada@quicinc.com>, "Lukasz Majewski"
 <lukma@denx.de>, "Balaji Selvanathan"
 <balaji.selvanathan@oss.qualcomm.com>, "Jens Reidel"
 <adrian@mainlining.org>
Subject: Re: [PATCH RESEND 00/16] MSM8960 / mach-snapdragon ARMv7 support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <me@samcday.com>, "Sumit Garg" <sumit.garg@kernel.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

On Mon Jun 1, 2026 at 10:12 AM CEST, Sam Day via B4 Relay wrote:
> ** Resending because I found new ways to dislike Proton Mail (it failed
> the series midway due to "spamming". Sigh.). **
>
> This patch series introduces support for ARMv7 Qualcomm SoCs, starting
> with MSM8960/MSM8930/MSM8227.
>
> An overview of the changes:
>  * serial_msm reintroduces the previous packed RX/TX software mode
>    operation, as this is compatible with all UARTDM versions (1.4 and
>    older). It's added alongside the newer single-char mode for 1.4.
>  * A timer driver is introduced for KPSS. I don't know if *all* ARMv7
>    qcom SoCs lack generic ARM CP15 debug timer support, but at least
>    MSM8960/MSM8930 do.
>  * mach-snapdragon board code is shuffled around a bit to build cleanly
>    on ARM64.
>  * prev_bl_data support is extended to ARM32 (which uses r2 for passing
>    FDT/ATAGS pointers, rather than r0)
>  * qcom_parse_memory is revised to support arm32 memory nodes (which are
>    1-cell rather than 2-cell).
>  * Basic ATAGS support is introduced, so that the memory info can be
>    used from previous bootloaders that do not understand FDTs at all.
>  * PS_HOLD sysreset and pinctrl-qcom needed some minor tweaks to handle
>    some nuances that challenge the current assumptions.
>  * A pinctrl driver is introduced for MSM8960.
>  * Initial MSM8960 GCC infra is introduced.
>
> I tested this series on:
>  * Nokia Lumia 520 (msm8227). No working buttons yet as these are
>    exposed as GPIO-over-PMIC-over-SSBI (drivers will be proposed at a
>    later date).
>  * Samsung Galaxy Express GT-I8730 (msm8930). Volume rockers + home
>    button are working via the new pinctrl-msm8960 driver. Power
>    button not working yet (needs PMIC driver infra).
>  * I have no msm8960/apq8064 devices, looking for folks to test those.
>
> To confirm there was no regressions with ARM64 and/or newer devices, I
> also tested on:
>  * db410c (msm8916)
>  * google-sargo (sdm670)

Nice, I'll need to try this on msm8974 & msm8226!

Regards
Luca
