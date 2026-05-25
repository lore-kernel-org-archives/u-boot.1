Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E0CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63910846C6;
	Mon, 25 May 2026 16:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JlXwgIVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED90846CA; Mon, 25 May 2026 16:02:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6AF38460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd2d8bb1068so1813334666b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779717767; cv=none;
 d=google.com; s=arc-20240605;
 b=lz9JkHcuxjLH6A8qCPMvXQj2rEOqnHfU7UXVsFYk0YAEG2rgYM9+BOyQRxDiiyd/NM
 exIynAchCcD/d+aj/pfOsKCe8tC+bfog6ZKaBY3pik/m2AXODaEV8+CFUtCo9GBeuQW2
 6riJiDNiDWFOWqeIx3o0sMOgeS84vwQB3w/yBv20NOI169Kq873J6OvKB0VaRnFrESrJ
 xYKIOiGsdpwKQkRGZfR3MAgvOViM54MY8/AwcI1qoDHdCabYRVvOQ4kixyjnzbFLScZ0
 BmxuZeEoGWpGQEKYmJ9XrP66KBdYS5yV7Pd69nngESRpNsucMChXEudIP2brNj4TnVT/
 CoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eX5T5ipumFBrt8kPJn4rKIcVP2BsafdXZ3HpYTEHSkY=;
 fh=y0Up2JdwvYNqdz5SAQkrJIiXkx7lXVC2IH/yylZz6i0=;
 b=BiKSIyE40SdkLJKbs9Z+L0fmubgX+AGK+7s1N3QgOW9KGb7DPwhbHXdvls2rI1uqMp
 YTFyJY/mTQb/F1uLLMlvrwVx/8q/EJYnNnVCPsFRzj2drWWV3utn23LvDiRCncssmWWJ
 m93SMkXl8Tk4Fd8kuNdJow6qDeowvk5pIALxzP0CiXuy+kG3Y1QSYPifNbyZQkSrNndy
 O5njKKziwJchlB9dqcJScuGlgkTt27II2sSrouR6s9XRHbyRRpvKHhLXh/E8E/wR344C
 VixotOe4grvLXjVtBd2hmieTQOj5HMLTQPCLEvHD/9HnXr4ycs5nsx8ZC+eA/wIHQ7mV
 OIBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779717767; x=1780322567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eX5T5ipumFBrt8kPJn4rKIcVP2BsafdXZ3HpYTEHSkY=;
 b=JlXwgIVVE1/q1Wo3uBk6jyH6KOVb/Q0eFoYtXpnvWFd+v5ZNg/KHx6oz2SSTXyWGYC
 l7AUF+yiHSafrRCOSNVf6kziMIrZfyas4vhHN1WtnOLvf7D2DLaEa6eaJqCehtaJvluk
 k7rd9aepAlfdJn93yt8ASB7HzvNNucBt6Xdtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717767; x=1780322567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eX5T5ipumFBrt8kPJn4rKIcVP2BsafdXZ3HpYTEHSkY=;
 b=cPbw77Thy5f84ttAe6WmLZ9Q+UQDFGvNwJWem8uDrC337Gq88Mt8FtAMnY1wRN8qv0
 HKfYEVvB3JCQOuyOgQ2YrBPm4tAxqw86/hsNvsR4tHVXBGNCJT+w0QoDqamxr4NYVJtB
 Cw4sOeKpCtFcxrepFBNtmTZ58cAKJ/ptG5WL0CR0AqEg78FVo0gX8aj0zksOUhJxC025
 tFIp5MfJpBeUMSVvCe7bsW3tanIEOVa1i/ZSo0QiHDYHFClxKAd5RImaBjDeEMyhJJKg
 bYx+HMMCxPBwO3XD8aJorbQ95Xt+ij2o6jyWfn2z32T54VWRHuIl+V+TpDHG4rOc8bcW
 bHOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+adyLlg3mo9baEfhx1p0U/tDFa1jNGXCRBVoRp3B2mgKk1SLHMA6j1fAlVe3YXjt6lpAkARkA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzat0bKlkVYCakNIzJx4nuTMdarSQlrcH7gJTEz6VI1CxU7aJhk
 dYyKBbMS/7L9Nbj7o4CsvJi883GRivPZCRGmLqKeEoLtksUb+CWWg0fJWKRrzBvHCLWKKRY9BuY
 AZ1lcqUBG/R3BjKMs5NAhFNFg39qfGRbHK/ISBRkrbr/g1lL0GYQ=
X-Gm-Gg: Acq92OFebUwnzc0AwcwNVcdURIH7bJftXFSCt6ZUKb5R/VKPJlipkDfx7lnxJR23UZS
 i52+Z59oOK0o6tpz/dDDykiPb2iA5kKDLNPIDS0A3JOhMAwuUSXgWeLTejFM7O18pvNAOptca/p
 H8B1HZCAjHPLIOL6ZOhF5lC01YmIwOSUPxyyo1UeuIl/qwVPzldzsF7Z/6fABHB/PlicMrurbzX
 87f1vwp8U4GTjcaCEroFekZL/pfzNwGq7y0/7PUwMGxhfN+HYsV6xCbZYS7F655MnnEQ85k6NvA
 alDtAw==
X-Received: by 2002:a17:907:2d29:b0:bd8:f776:6980 with SMTP id
 a640c23a62f3a-bdd25138390mr839699966b.10.1779717767178; Mon, 25 May 2026
 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
In-Reply-To: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:02:34 -0600
X-Gm-Features: AVHnY4LHC5EQixRNT3ovQKQPAYZkC0NwSfKgSSli3TbtzQUFqBylZCggDC5RZjI
Message-ID: <CAFLszThnMCc8turfy-y3S3DJ+mDbHm5P1dgCf0JtUiD7xy+G=Q@mail.gmail.com>
Subject: Re: [PATCH v1] misc: qcom-geni: add DM_FLAG_PRE_RELOC to geni-se-qup
 driver
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, 
 gurumoorthy.snthakumar@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Gurumoorthy,

On Sat, 23 May 2026 at 23:03, Gurumoorthy Santhakumar
<gurumoorthy.santhakumar@oss.qualcomm.com> wrote:
>
> The GENI SE QUP wrapper driver (geni-se-qup) needs to be bound during
> pre-relocation to allow its child devices (such as the debug UART) to
> be discovered and probed before relocation.
>
> Without DM_FLAG_PRE_RELOC, the qupv3 device is skipped during the
> pre-relocation DM scan, which prevents early serial devices from
> being bound. This causes serial_find_console_or_panic() to fail with
> "No serial driver found" during serial_init().
>
> Add DM_FLAG_PRE_RELOC to the geni_se_qup driver so that the GENI SE
> QUP wrapper and its children are bound during pre-relocation, enabling
> the serial console to be initialized correctly.
>
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.snthakumar@oss.qualcomm.com>
> ---
>  drivers/misc/qcom_geni.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..cbad7bd3bd2 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -576,5 +576,5 @@ U_BOOT_DRIVER(geni_se_qup) = {
>         .of_match = geni_ids,
>         .of_to_plat = geni_se_of_to_plat,
>         .plat_auto = sizeof(struct geni_se_plat),
> -       .flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +       .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> --
> 2.34.1
>

Should this use a bootph tag?

Regards,
Simon
