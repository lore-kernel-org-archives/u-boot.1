Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75C5E937E4
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AE284214;
	Sun, 12 Apr 2026 15:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sgf9FR3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514178416F; Sat, 11 Apr 2026 17:41:07 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F79080077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so412291866b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922065; cv=none;
 d=google.com; s=arc-20240605;
 b=We7NLzbk2gXSRgbkwzB8W338M6q24L9Eqb2SXWpJYGGohC06rJ2NxMkIImieF2EnLD
 s4rXf8JUsoUX9gA72avVdaIx01YU+ZLTH4NoqFQOSaTQSxsBMeNUJvj9oeJdzzmL1HjE
 oROgA0yp5XAVzL0VelZFBfqicMrNaJjIi5pMqq1zaqwts3t4RKm09mXZnPpApJhp0KHZ
 oFrIX9ScMG7sEwVXtfvOEFRMaemu4KZZfJE/Q8RM20sauwjWKn+R2qCTaurM3qJRhNVn
 CFusdPQlDljh7Kcpj5W6Syifdms/dci/0pjzMrWSZU0hN7wv7YKV4G0Gn9YTxGPkn5Zq
 CRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tH2J385Gf8UKF2zbIgRfPVoF3cnxj4ZroUQFm9KDYZY=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=BqiJem2Gkkuoeq5bDxSSu5M7p90pDk6qDZcjh0BoU2kNSQbgP8CtCkBB3DyBlRbjeF
 cD2cH0B6R1OfHvOHRsfZ+OHQ2mVV4vMx7hruxuOO6z/cBnCa2PvGp3SwP6jaojS7sK18
 6A5W4OWLUe/mcOO23eNBDWv8hd6VqScjheF5ewseBXolcawyVSL1BDAkE+DN7thQPb0F
 YmVnolnr5MBu5osMUesjVtmMhOu32peG+86bJdHeffV5oBvfrffxCKN0YpFk1vSU963i
 X0dNB2SjyRZ30c5IoumtudLGPMtaNpbnDW0CBgNNmOloI9Tkmajh8sddg1L1fR+ua5Lx
 qkpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922065; x=1776526865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tH2J385Gf8UKF2zbIgRfPVoF3cnxj4ZroUQFm9KDYZY=;
 b=Sgf9FR3Y4HeTvKEBMbbFeD2UTXsmH+W/Hrv5EHrL7azFY8Mv5ex06jwpLf70jKRtKB
 FclKYMHG90bbtHrQ0S95FHAspkmW3P0YOWrgRpa0ZF9SdHeBZBRU2RGmQE+g4XsytkeZ
 7elFvvWM1tyc5lJDyropht87O5w/g8GeabJyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922065; x=1776526865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tH2J385Gf8UKF2zbIgRfPVoF3cnxj4ZroUQFm9KDYZY=;
 b=cWKYmSTJ/QWv6M6PfWSFEUwIkN+B9epYmBWGTcyLZ00HcGc3Hu9dHFqs5bfNUL5bqd
 3a/UBzDheDpz0VF3EnsHJ4jFNSH8wlgQ53ZXy02By3qcRncT5RnZq7KM5mYhbdAasIEb
 nMCDEzvorzmp0PrvjS3+Qwjn0lHTzXqpqHHdTwr16mR7WvjymtJ1EmoJqPzrqEw8Jg3R
 u+KnvOvgOJHxOgk1PSMaoow45l7VhWb0/V2uXbho3CGqgSy/KsmfXykHwdgoY7PbQT8j
 cV0sfFtipvSEZkstwVE/kPyIpzrs/xZVF0P56dI7nCLROM70so0fyQUCJNqZSxW9zeeU
 kq8w==
X-Gm-Message-State: AOJu0YxVO5nTEq8fE2GTQo32WwHiPyQxfs2jvWh4iVOeMQs3sd/UmrbY
 OAMMhN4yqGZh0uVzgysuAWKfRmEGbXvCN5Bm+/AdHxL5SdvHT+BoxeyBvJd9OIo+9ASsq/o0ftt
 4zul7/1OaNbjt0BmuCuq1rlNn0xeuGtB87YSeWY2X
X-Gm-Gg: AeBDieva08iA5iVwhmQKxWdxYcILhKvLepWZHOZ/W8oaDWcJLdZpze5zk+1KW/JqTGJ
 YdalBi8vFBCrTFRy8UVLLryp/md9HUld1StvCYpv8IAWX0g23qDN2IKIU7FLILXfKTzQkijzQ3k
 BoAc+DofnLXCagu3dU2tzRAxaRONRGJ+gjDHJ+bdYfzJIBHO33myAxPlavkJ8eYfbHRsG7AnGM0
 t6zMO5bfM7rlnjvUBZ2rIZXDKzPIriumqPR7zqdiAm4tNXJmuFljzYN2LvuQUHr17CR4F3etlvm
 llsSOQ==
X-Received: by 2002:a17:907:7284:b0:b9d:9741:4ef5 with SMTP id
 a640c23a62f3a-b9d97415fb0mr213616966b.6.1775922064543; Sat, 11 Apr 2026
 08:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-10-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-10-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:40:49 -0600
X-Gm-Features: AQROBzCix0nP8LIfTd-y6PntMyOiaWiBBzhwvtYW852vHjsY5AR0bTo3mKSH2x0
Message-ID: <CAFLszTgD53TWNH4XM0gFgg5D7P-5MS2mOy+HmH60+xg4cbwbfg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] dts: add u-boot specific sdm845 .dtsi a .dtsi
 for shift-axolotl
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
> dts: add u-boot specific sdm845 .dtsi a .dtsi for shift-axolotl
>
> The board .dtsi just includes the SoC-specific .dtsi, which
> adds bootph-all markings to upstream dts nodes which are
> needed in SPL.
>
> Signed-off-by: Michael Srba <Michael.Srba@Seznam.cz>
>
> arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi |  2 ++
>  arch/arm/dts/sdm845-u-boot.dtsi               | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)

> diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +&usb_1_dwc3 {
> +     bootph-all;
> +};

This relies on propagation to parents but should be OK.

The commit subject is missing the word 'and'

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
