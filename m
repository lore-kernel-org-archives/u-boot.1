Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C8EFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0870A84927;
	Wed, 29 Apr 2026 23:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WisL67Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501FA848BA; Wed, 29 Apr 2026 16:18:40 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4AF84897
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so1693459266b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472318; cv=none;
 d=google.com; s=arc-20240605;
 b=Q1/Gs0gvn9l1cCzE43eB18Y0UHSBxRDgVEq1Ka8/bLVzjRaZ/muztO+nXa7WqYDAIc
 4dBLMis3GyZhPNUmwZD80WqLgPINwQNwca92zFnhysKj3EFXKdVM5spx9zXhnS+xDTTG
 X1noB1vEPR2MeP572NMxL8vbvVfKfrQonl7PKDG4vUo4uyGbbDYT9zVbWlwRSamSo2Yr
 Ldb0HT+CmYcg9IxFVybKACEZnaJVoHFOM83g/t0ChxmgKGuZD+JzmjAPFXIXCwxkvL4X
 7Lmth7W9P/rVaDXLV0vfnN5Eo9xcu0BDdlVKW2w4fyOJ4qjmevtBws33BhO63bW/gUuu
 yvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S0RoRKsRpu7dWVDBkGoIxFc0s+4+fsMvQnnKI2MguAw=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=GhNCPP7m1Rlc2p8XUMJ5ep4zcHrM//UohLVPF8AbmOwy/cCKtFi40c9v6Ls2v9Lc6r
 ONP7AHIG4oUrvodGC3nsfpByqEBGpV9E3DuOy6zBjzO8Ui42oYngKXzg8goEplWEG+UG
 qbWQc+crbk9gfoULtTMX5jllAFrl+rfC2xqPBZGcwJyMTauWGxeuEAIR7FQPtQ0tgaVI
 QUWcoCeM05JgR48uy4ueFXFLdROLG/YWHq42oDRFdf4MUm0FHXof+3zlcTYlKW355xS6
 lrQ5AcnLOa1agkSVg/SZLeZ5jXWBvz3z9Zaeowjj/+mYxxcwfw7nkIMlW2A9ktKH2sVw
 vyAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472318; x=1778077118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S0RoRKsRpu7dWVDBkGoIxFc0s+4+fsMvQnnKI2MguAw=;
 b=WisL67SfzJuR3VefK2SqJSsVvExsvvFXJndjuoKyJf0RrFLX8WHGOwTHkf/lekQY6y
 AC8JrHPVq5mNtucWR3vS5bzR6wlfHf2UVtWE6HpQCo5NnmqodBwApodqUgKhxemGEyUF
 iD/GXPU66lbpexH+vmFnxKNu3ueycXIpyno1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472318; x=1778077118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0RoRKsRpu7dWVDBkGoIxFc0s+4+fsMvQnnKI2MguAw=;
 b=Kc4YXgOArqJrC6syERtxekzPzIY30jo4VYgvmE5Kp1XH7sbFoDZDtoDR3nesV7fQSg
 mhSKqDG9BgjlJMS4zxlF6aPdFUWzRedwVfkmjkM2AUj63b48suLq9ZLroeEWUhff3gH0
 TvBdIQ2WwtvVhckvJw7DLBEBlaVnAYBgPHr1l40GCsK4DqA28oOMwhkGc2yraGFYCdw9
 8R8K+Q8d0GVQN3lJvV1s0i9Ms5UXOTz+QMZUFg/6PB6lNY37ai+ltt9kR8BYAgswGO9D
 S2fPW8BWHWPPgPND6L0+Gyf3rQzO5rMG9864Jp8G9z/zzpIo82Uhp/cUwFIVp6K7faFz
 iLng==
X-Gm-Message-State: AOJu0YxpG2CoXP4fOxE0x9eldJ1fU+mJWZZy3qM5qwQFyRiB8ko7rhtw
 rxJLRF74f6mlAAnNrS9ss1BIqKTaTDJ5CsQCWEMpMKpouLa3s+wHIdXNmfDp9qI5SSt7ju5INVS
 /cS4cEWKm4wtC0EAE3eQby7ToLEY+DnNAAOkgD/Hh
X-Gm-Gg: AeBDiev2K+C6GsREOVItrwJ8NnRFzPwtIyT+EZdcNbqz5vPMELpODBj/58PPgOVG+4Z
 H/+PUFQonXpSUkDitc4X+jQFloxHi2qJVJL6+kWZdjT2QubN/C4dJGaYUoFnTX8OzOD1jbWRP1S
 2eOhUDcvPJinxBuAna/64OQjVkMG5tH68ZJ5NPaHhm9swKxJ8Bi3fFFm7kDWnxBmOoouHC903mB
 zKypNsiQWY3ZCkIdurdWZfmb1NireGeB3MnKRe1hUA4aVOpSKRxSoOrUk3nsYtCSF439YDSnQHl
 0priDaGOb+KUvZDk
X-Received: by 2002:a17:907:d11:b0:ba7:34cb:388b with SMTP id
 a640c23a62f3a-bb93ec4ae1dmr239608766b.42.1777472317778; Wed, 29 Apr 2026
 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-3-8cf4133ff883@seznam.cz>
In-Reply-To: <20260426-qcom_spl-v4-3-8cf4133ff883@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:18:22 -0600
X-Gm-Features: AVHnY4Il3BGAZuRIHnDiU_8QrY0cUMxnBKyChuwQlawE1GS08TPR7X2FxGDqYGo
Message-ID: <CAFLszTgv=ShThTd9zqA1Gv3FpEanuKN1PE6iy67_eGS+CKCwvg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] drivers: allow clk_stub and spmi in SPL
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

On 2026-04-25T23:26:13, Michael Srba <michael.srba@seznam.cz> wrote:
> drivers: allow clk_stub and spmi in SPL
>
> Only Makefile and Kconfig changes necessary.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> drivers/Makefile      |  2 +-
>  drivers/clk/Kconfig   |  7 +++++++
>  drivers/spmi/Kconfig  | 13 +++++++++++++
>  drivers/spmi/Makefile |  4 ++--
>  4 files changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
