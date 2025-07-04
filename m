Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9169C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24839801BE;
	Fri,  4 Jul 2025 16:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cR5Pwdbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A746F803DF; Fri,  4 Jul 2025 16:11:49 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C61800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-553dceb342aso918065e87.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751638307; x=1752243107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBBW/4T4iqfw+1J+xA3wLVDfVsTNhMrtRzMmg4VNuwA=;
 b=cR5PwdbxfbpLFdYTn3/dBvl/jVy/SDIbyUVcr53zmKSI6z+QC0u9yY4kq6d1Yp9NbX
 ukEZom6ERt9Exo/b4lUUa1RJ6fKc5J+HDBlokSEaS1nmju/b3xN+MdnTrBHoTn5eIYRU
 NkyBLeMLfArCzZlof9sAo94ha9k5mAuDc0WtGd5AtFEZ89aLyfm6H6dj+2BXpAiopnaf
 Grr6U9+NHWy2dmvTd9ChM4eoHflCfwzas6qIK2N6zDtSElIaEDaQepkM7Wg6Ah0qsnSx
 6cYa23zzSkqZqBHTQTzOJi9hS65LxL5iTBKs1V6VQShxodGGpYiGder8qZytf3AEgSUK
 EyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638307; x=1752243107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBBW/4T4iqfw+1J+xA3wLVDfVsTNhMrtRzMmg4VNuwA=;
 b=nBsuHseFyeYKUqyMIPiiuhArguQwp1YNQXpYQntoTF/r1TO2SiJ6cXMOm9uwRuAcWE
 qKHbAGjN68TqJw4Ne2JIdO+DdP8n6ZMa4NxIgBrBkc+IUFqZxsaoP9HQCoTEGRkQqH+S
 hnBJzrkULIyKbNQXGN/xsqXEEQspMJv8PXC+CmVCwWBm/ubmo9KBijX4dHh4g1+zTG9V
 D2hGdKAE2U2vzIxBIbcD9I8+0eWDzw9tUnD1zrzE7TGyxkxN1OjL8kPeeKti3sPwWBhK
 //5GQuzgQxpUNsBwbKg9NGpSZ6T2Gn0hOx6V06ZChdLZ+Khev2MtrP5TspHB2G6EJM24
 Vm+Q==
X-Gm-Message-State: AOJu0Yy5mprQ1dD+vMqBaGU76kbYHUxh9wnuZgtI4MmR4GnsXbsfR6aB
 zRs/3t09r4wLlAuJnhkAd8+SG11+SzXeqVQqX2Glf23757pAKbW7DlmHMrik+m+4MZzwJSj+tId
 OrJY6cAol96KuHGnOA+5HuVAjRcYShZ8=
X-Gm-Gg: ASbGncv5+GUO2ThRJ5e6kOtqFuD6Wu1qL+tQj9y3mTgixvEshH4c2iXVbvPKXRbmUgW
 QB0Njgb4/9tBNxggI2Hyg4OjxVhVS1ILJ4aXx8mr92EfPFJzAoZwcWzWCRBG4F648JWGQf5czJ2
 Fp498EbEVh1deOqZXkKtG4+AjFx45BVxgNfODHfyS2nO87QN111TfIrQnX0yVTF2/+r3Qa5VGjr
 w==
X-Google-Smtp-Source: AGHT+IFSa/9lERdQrxrbr8yNvfPKgKO6a8EsQfKCAmIJTaiKEZEwJY0x4+JH0Ez1RJci5/UHn5rvaV4CWJ50/bgwQZQ=
X-Received: by 2002:a05:6512:3f0e:b0:553:ce07:de8e with SMTP id
 2adb3069b0e04-556f1b653f6mr968529e87.42.1751638306772; Fri, 04 Jul 2025
 07:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250704130319.3814676-1-festevam@gmail.com>
 <20250704133105.GD6424@bill-the-cat>
 <CAOMZO5AtVXOxWjMQeVeUtbU1Z_D_DvQ+0a7OzzHUskSK8wFJ6w@mail.gmail.com>
 <20250704135338.GF6424@bill-the-cat>
In-Reply-To: <20250704135338.GF6424@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 11:11:34 -0300
X-Gm-Features: Ac12FXz9tHuY7Sdwq6N5OeAmrSd7OomPSEezYqAtJIV-s_54znu_WnH810bU6ho
Message-ID: <CAOMZO5B+EV-PPhT0pExj6TFYWNw4OAepob_M2k7RiHX9O_b_Uw@mail.gmail.com>
Subject: Re: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot
 regression
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com
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

On Fri, Jul 4, 2025 at 10:53=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> Yes please, thanks! And I would like to explore a little if some other
> compression algorithm (that we don't have support for yet) might be a
> larger win too, for v2025.10.

Ah, I manually tried this change below:

--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -40,6 +40,8 @@ CONFIG_SPL_WATCHDOG=3Dy
 CONFIG_HUSH_PARSER=3Dy
 CONFIG_SYS_MAXARGS=3D32
 CONFIG_CMD_BOOTZ=3Dy
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
 CONFIG_CMD_SPL=3Dy
 CONFIG_CMD_SPL_WRITE_SIZE=3D0x20000
 CONFIG_CMD_GPIO=3Dy
@@ -65,7 +67,7 @@ CONFIG_EFI_PARTITION=3Dy
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=3Dy
 CONFIG_OF_LIST=3D"imx6q-sabresd imx6qp-sabresd imx6dl-sabresd"
-CONFIG_MULTI_DTB_FIT=3Dy
+CONFIG_MULTI_DTB_FIT_LZO=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
 CONFIG_ENV_IS_IN_MMC=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy

After running make savedefconfig; cp defconfig
configs/mx6sabresd_defconfig, I see that CONFIG_MULTI_DTB_FIT_LZO does
not get selected, and CONFIG_MULTI_DTB_FIT=3Dy is removed.

According to doc/README.multi-dtb-fit:

"Usually the DTB is selected by the SPL and passed down to U-Boot. But some
platforms don't use the SPL. In this case MULTI_DTB_FIT can used to provide
U-Boot with a choice of DTBs"

mx6sabresd uses SPL, so MULTI_DTB_FIT can be safely dropped.

I tested it on a imx6dl and imx6q sabresd boards.

I'll send a v2.

Thanks
