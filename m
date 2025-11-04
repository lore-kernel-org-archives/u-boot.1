Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A4CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABA68004F;
	Tue,  4 Nov 2025 19:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G7TbM0EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666A28391C; Tue,  4 Nov 2025 19:07:32 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A34C8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-378d50e1c82so55904811fa.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279650; x=1762884450; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzYuACR2Bj9StxNvQzsY8e7TYLBY+hQ0BFBsnTgyCXk=;
 b=G7TbM0EIKFJ0I9fXQ4Qur8CP5YPUqqAzuis2nrf5BMDz3U5ftnii4vWmLUYLiy5c25
 Gyf5yWQmPoAPrMx/ZeOCRIc5uKcAZS/0Ztluqf+rfc04DIT4aj48RIlI6Ympu/MnFWqa
 URutret132NlgTUCOaTCiyL850ot3SZZTmO7Rf4B2XC1mCVnMli+JJVQ3mePtWe89VVM
 s/97omr3Q3vDNVWXHdapjXrV2/10Er5hO1Y57G1qNnbRMjq3Ix/eJssSLC78d/WHMWsN
 IFFzxbz2BQC9OxrXUa7ULQgHHdMrEJgngj/02JXFvgvF8UdkEmrLycVQdMgC+DfCmL90
 eSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279650; x=1762884450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzYuACR2Bj9StxNvQzsY8e7TYLBY+hQ0BFBsnTgyCXk=;
 b=lR9/2UA2p52V3pXOxkolBnwvlYPXNM9bvutMYJDxSuSDK02+T6/6AN6pUIqcQNTet6
 OVC9RMP4DArlKkxlair6fYVtAaigvrGuzJNEMczSGyUS2OAxqbcaXlmnQgrvBA8q33Ic
 8KHmygS03G0yRaylDb/ObxNB76wRCiFbKpMcKbx/8YjU1a0jGCSRDWkgIdDfgJheWmlk
 2ACXLY36EGOCTD3WTbXqG/vK7fZUAn9z2d1X4HGBNjob1eeWWoiOzw04yl6L3MgwlMqb
 7ovZb/+QFfXhkLSeZClOTLlxJBvclWLHCl/fTw7NAjglOub8b4qULXNrbq1mPMDGN0L0
 Xvuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqoi9DyxheOeCYLMlRoswkfe8m3f1djOpPU6JRORqd72ROAl/bRDNhTkmUz8/Aq99PJmvZvE=@lists.denx.de
X-Gm-Message-State: AOJu0YztlY9tKNspBF3W3DrbYuv8HVZSxOhS9A/tls6nWmIMLbV9gyor
 XHvXEczzhmxCzM4b3640FyWHCcHGRfLZfwnPWILYYhCkA26MUFmZZpiaXfVpBrOEDkTnq/i5bg5
 0mvuHp+eEV0mq9BayAEgya9UMz1xmKNZoZkRm
X-Gm-Gg: ASbGncuJ3tYGfsf6y8ez/4Elv+SZqlx+PW0rSlQDEeX3/a2uvZ2GucM/taMpudQClYh
 OP0dngYWPaLTFS+NEuLv+OVhf4yACCEV6V3fuajiAJ5FiFE+hKAr6vRSN5dKRaq4BAK024WVfZ2
 a2LbMB7TmidGuIWu3dc5G2RV2HQlkEx/64iIGPTlU1bahtzqjDFxADShKFp03X/vLcMRsBV7nF5
 2AcUQh2C4198hmB0UKjXwOHi0h6lK7+TorcrXAeh4RZuvM2/GZMaGw7453l9yqab31Z6aLQhk3p
 MxxAU49tJpM+iBOP
X-Google-Smtp-Source: AGHT+IFfU7hcgGfZ/izaA7tmjZhwLb/mPJ/r1dcgvrOH3cGnsbJxq1iISIXNskx17A2wdel06T/PO1oI1nTJh/0xsyo=
X-Received: by 2002:a05:651c:234c:20b0:37a:31fc:1d47 with SMTP id
 38308e7fff4ca-37a513e718cmr585471fa.14.1762279649474; Tue, 04 Nov 2025
 10:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20251104103010.43702-1-frieder@fris.de>
In-Reply-To: <20251104103010.43702-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:07:17 -0300
X-Gm-Features: AWmQ_bmhDC1sQlWc3aRQCHA6-LuWh9Pa6q19M7XL2U91BX67q-AANDuS-arAVyU
Message-ID: <CAOMZO5DaiHrM-M7TPqnoeiYVU1G+J_LQASi5fEPjdyi4YQosjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx: kontron-sl-mx8mm: Adjust offset for U-Boot
 proper in case of eMMC fastboot
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Tue, Nov 4, 2025 at 7:30=E2=80=AFAM Frieder Schrempf <frieder@fris.de> w=
rote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The image offset on SD/MMC devices is 33 KiB, except for eMMC boot if
> fastboot is enabled. In this case it is 1 KiB. In order to make the
> the bootloader universal, check the fastboot OTP boot fuse and adjust
> the offset.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied the series, thanks.
