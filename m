Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74230C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EB487F19;
	Thu, 25 Jul 2024 20:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mfAxjrm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD4C881C1; Thu, 25 Jul 2024 20:16:55 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7AB831A1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7035b2947a4so94202a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721931412; x=1722536212; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j6DLzhHMD6UbwRmXUZSP1wPGYzEexIUJc/ntdHIKHw=;
 b=mfAxjrm3x3ILjPs1EuemEKj/6vi/OpoqG1arwS0VbmIzLWj6Fpn/ecqHgXhESu0F62
 sIoH9157NAZO0UQIPfcTxo0iumcxnpPXXb44YyNpDwUkPjPthto0Iucfr3eKPaZDtSdV
 FJc/49T388vOn+ukEQa0Q/sPPh3SipVmVTnjypNBx8iZsk+K8Oz3G48OplEr41Xr9Qrj
 /xys+UHPbiCWcZf2tBNl4qNqfy27LZCgtQ+f4wShAFSRF4tjlXx7DrpGxABk5244918p
 SfxstwU2Y7KUHJNXtQiNy44EKzwsZNnzqYEQILHeT8Eo3q2cegY0pGSQlzgvsZED5ZfS
 MShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721931412; x=1722536212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j6DLzhHMD6UbwRmXUZSP1wPGYzEexIUJc/ntdHIKHw=;
 b=SBWkQWhcoF4dKMiYtC5kC+R0RgEDeJKXzmrFhuBhtx2vtn1iP1B7aRB1pB/k4MU6iq
 6NVFqdhCUSb701XgsZrrMh77k0Klmrn+lMF0R0pvm/fmcy8q7rMU7tfY3zlu2L8w359r
 o5rV53iE0c/BE5K5+p0GhnesWknw3CLfnSQg7UNKfRcmSAmY395kupAFS7QemqLqd5G9
 sxZcnxC9AU77D+O/LrI0Lv24wrFjoys4Bo024k5FPNlzVUER95hbhrcsQl5f42Ybepob
 +mkPmBsiXXJVoo9vrIj/jPVeGBuqklNrZV3vFUYIqrOTwcGUMio6J6HKvc75UBQlV7Ex
 bWDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5h5SppCFEI/Rt9NtBo0PjCdHZZzLdnozyzMNOimSMdjN9S0wv4vkgDsNFscQlOYTjENV0iZwRDp4wKEtjRw57/tBlcQ==
X-Gm-Message-State: AOJu0Yz8ynTaOV+mSIVH/ogyfzKE4hf90CI/xxLQ8kNTyoxkL9z1fr3W
 hDC4/FoMbQ2xJ1HeCI7Yc2AJHC5Gl1yvjBqiAfu8j1px1sItsUMAc51fD6fq+au0IrJ7xAgZTfy
 7vzd080AEu3McuFUw25eajRmy0PPa7dbKXsb1pQ==
X-Google-Smtp-Source: AGHT+IEdEMUCcNJ3T5Dap6YZvNPrkjagP9/jCUxASR6bj+BKCxTcfKnLRBLfy/LNhD2Xu9fJ0co6YaVBgODkt/hfGMw=
X-Received: by 2002:a05:6358:71ca:b0:1ac:2b8b:a18d with SMTP id
 e5c5f4694b2df-1acf887cf64mr501092455d.14.1721931411705; Thu, 25 Jul 2024
 11:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
 <CAPLW+4mR1BPE5YX2dUvOekEQvqoh1asb9abD9EVMxHJV8DcdtA@mail.gmail.com>
In-Reply-To: <CAPLW+4mR1BPE5YX2dUvOekEQvqoh1asb9abD9EVMxHJV8DcdtA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jul 2024 13:16:40 -0500
Message-ID: <CAPLW+4=vfnVsv6YnBfpjpR6HMBMXQAvBCXT-DhYfkqbO4YkK7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com, Minkyu Kang <promsoft@gmail.com>, 
 Minkyu Kang <mk7.kang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 24, 2024 at 11:30=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Hi Jaehoon,
>
> Can you please check this series, and if it looks good, apply it?
>

v3 doesn't apply anymore, due to the recent changes in U-Boot/master.
I'll rebase and re-submit v4 today.

Thanks!

[snip]
