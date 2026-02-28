Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE450FEE4F2
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE2F83EC6;
	Sat, 28 Feb 2026 19:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMUEV9mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DEC683EC9; Sat, 28 Feb 2026 19:41:58 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BD183E76
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3870902760cso45367321fa.3
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772304115; cv=none;
 d=google.com; s=arc-20240605;
 b=NrQ79QbCEY1fUWFBj9NjVqomGvD1fAUu99rVI/g5vdKJN8E1mcqJoFZza2GSEjNv2R
 +TYcESGbjuBwaJSOkz/H/JgUBl3FOmxqUWmESeHBN5EenpQDhqnzRGiYXK2+yaxV8JY9
 4LW7PG2mCjzQPqE/Ay/gS9MZKhVgzcBuyFvn6XNMrEdYuaQbXPP/0eJ6pZJdtPF0ytpC
 fFEXEUn/AC+DZGV9xt+bjuHW2uHNnbHXqL4Xmg1Yaw37suRUdxBsmN+3i2a59kC8F4HR
 CPxtyLCgAYhycmKBpoyt3iXM1UyryJSt59bw3dFZhNXdvHDGFMG+S6/wr1J7ErCeUpDK
 +OYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n5mp7gTUPfAEPty0sCoraUTlv4ZG/ST28oqoKGIDpkI=;
 fh=1WYUJJPfSqXOMqouGXR/2gjYs15n/kGiQH+u0iB1tKY=;
 b=N3057AFDhSUGMs2y2Sxq0JxwhEz51GADdYiY9SR/gEetDjfS9YHZrfghNS2urxWT7l
 WbxqyHAYoHKkNW/c/NLTEq21av9BWlseQK0WWO1lf1juJNyRdBGWPK9XK+AJhLdfZGcx
 nTeU+SvySzkuJtO/U9ntVrKNnUWMj1rITy67SM1wKjONwWe4cLyRutx7/dJax/S0QMf3
 yHPTvwKLEGxXmwt2Mgtwfuvtz5sXF2I6CAi3/hxWzTwEIQ3p0KZVEnC2pAZGoojNx9z9
 wKbQztScpC88cYFRVD2jIl8XSTiTE1/0gDHogAJ4QVV08EBfZw+y+MlMtvMLCWX7WdBD
 m0KA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772304115; x=1772908915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5mp7gTUPfAEPty0sCoraUTlv4ZG/ST28oqoKGIDpkI=;
 b=lMUEV9mj9jFL26ul00ouhb7ZBcQ+28hTivi990VWmaf0ySGAwzhjdoh3aqm6QGyQhS
 5Mc9CRK9fjL9uR9oiBwfcAJZr6fs1PNvog2e8pfbWNTy8nlzAlZWO68s0CnxTdACegda
 uTMIr840mm9nUf9oGZvmaB5ku4RXWLr9RwvIFzlVKZVZIdXrttL1smV8q5IgrVmDJpMj
 on25PN+KyMltbe638X2oplbWFMiqysVKrOb3am6F5nFQQS5fMg/UqCPnRJfaiar2Jwjv
 tXrm0IESdxiE54KvvlC7kFhRsVh9AYywReD2uuPkhVhnnGe7wDq1zdZ9CH7VaoLD5+14
 Gehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772304115; x=1772908915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n5mp7gTUPfAEPty0sCoraUTlv4ZG/ST28oqoKGIDpkI=;
 b=uzJmwyhmFKKx4Lv3cDoUYX1sT2JY1hpQfvVheO4p+DVN67vHrWQm0Bg5Vl9BTHFZiO
 mqtiCicC/jJMbmJjO0IWsJT5rGXYsCRN9jLDth27YXl8gvrWINMYhW0VT06dQ99ZUwYo
 4WbuQkJCmQcVxUt+GYVMsqBHKqQafZrq+eyi37AR9Bd9WXT5Y/YmAuJ/SXbKYeyvZUlK
 nuY7341iRPjX0F2yZ70i4p+tCCNy5WkoBNw3nNnmDTZjPVCic7hs94obhnNK87NBWyv6
 iXLLG6vJX5lbHr5xiVrTtXP3Ti8XCXkhUNkM2x/OJv7PL0vjlsN3RGVvg25OMDp/6VB0
 QycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUJ2wPazaAlTM61txvcdBg0+eqWaf35oTVfGvesiG1EEssJ2tbhYZcoHzZK/A7blrgyJ3b4Rk=@lists.denx.de
X-Gm-Message-State: AOJu0YyRNHYoaymm1tDJtJSvFXoqYPpvn5fhWReOtCTosGsyWsICTfVn
 7ZJlM7p9V/1gBIgCQHZ6fulv9bvm5+IPhdj5/668zbMxIarDmExW4WhRtBBGaaj7IQlY0GUq76+
 zHcptixU2gKR7C3NxXEhwYySKBvQeVh0p51dK
X-Gm-Gg: ATEYQzwnaXJQmpmAzANoa90bUTNcwZICoL8FsnUZ732VpfXz4u8h+86eG69eZnuutaK
 FHVN7v0awTM9+RXnlnCjNGLDBLHGxNvdy48JUJsLMVIv75qfyuLVuBTDSWWdT/Q/SHUJjwO2Nnm
 CTfL3M5lZpVhys8FUOegc7ivyBJpOFYptqIxyqDT5xPBN6hk3Tsi8AJdD5Iflx0bF8Lu25WGatm
 RkssxTQxzXYiXjoaWvmAmHvRc+/1HTDIEjqLoP1JXDImWamFR9d71PWSaiJk4KazYKRi+szSDCA
 ZR3uwIqx9mKcgdGkep0Zqyyi5zrIQpWVzI+qhWUcCSWdrFccdxNema3/AV7w95H1keEQ+Cq7
X-Received: by 2002:a2e:a590:0:b0:387:20:bdbd with SMTP id
 38308e7fff4ca-389ff15f2bfmr42960961fa.19.1772304114391; 
 Sat, 28 Feb 2026 10:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20260212082141.15539-1-william.martin@muxen.fr>
In-Reply-To: <20260212082141.15539-1-william.martin@muxen.fr>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 28 Feb 2026 15:41:43 -0300
X-Gm-Features: AaiRm50ISrGvf6mbnzeOy_4Xd9L3ktb7O_qkSHXBx1UDiCRo8EMZ3mdt5f0_w44
Message-ID: <CAOMZO5CDdoKW8J3SGdyVLMryYgqQ_FZcBiGEW3_SjsL3uNnDNw@mail.gmail.com>
Subject: Re: [PATCH v4] arm: imx8m: add boot_device and boot_instance env
 variables
To: William MARTIN <william.martin@muxen.fr>
Cc: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@oss.nxp.com>, u-boot@lists.denx.de
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

On Thu, Feb 12, 2026 at 5:21=E2=80=AFAM William MARTIN <william.martin@muxe=
n.fr> wrote:
>
> Some SoCs support 'boot_device' and 'boot_instance' environment
> variables to select the right boot media during boot command execution.
>
> The i.MX8M SoC doesn't set these variables but provides internally
> all the needed information to create them.
>
> Add setup_boot_mode() to arch_misc_init() to populate boot_device
> and boot_instance from the boot device reported by the ROM.
>
> Signed-off-by: William MARTIN <william.martin@muxen.fr>

This does not pass in CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1386916

Please fix, make sure it passes CI, and resend.
