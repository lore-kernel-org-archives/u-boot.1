Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796FC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 20:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA4683D77;
	Mon,  4 Aug 2025 22:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OW44OlVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CB083DA6; Mon,  4 Aug 2025 22:36:50 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8888283D40
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 22:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-55b8bf653dfso4783150e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754339807; x=1754944607; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQbnhqv6K0IyjY8h3mJm/SsJrDWPg28Vtha8yK2OtVI=;
 b=OW44OlVS5VMPSw5IO8TIr/W3ez3Jrib4zy31Eh4SXm0MxkeVGYaWp0oLfzISAEzXoQ
 D6NlS3o3XkxW9KFi7LyOSG2iKykeKBASSZCMdII0uJqO/61XvlJdhXPnmsvxsb1T7zZI
 1Tiv3fv0Sc0wwJkew/bnCR+8Vmy7a3yeWUnXQwqn8aFaNPalnwTRTZ7RH4DRIWkhATqt
 SpuBZ7yDleoYWMvs2fGV17GwKbh/TV+MU+pA86P9WFl7gYptxA5TW4Gqj7m9iKvpc856
 Ag93bJi1PkUrPg7/LFIb2kHqKYmXFnUyo8xIlnokrQeUwEFzTCbDFu4K5kLjB5UJQKKw
 3AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754339807; x=1754944607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQbnhqv6K0IyjY8h3mJm/SsJrDWPg28Vtha8yK2OtVI=;
 b=tt3nd7Wfy+VjN5bklSFxNUsmYR79g6ozHzXZmS8sJjD07lIJF8tfmP7O5Z6SpEqxu6
 Trj+lIuzkzLPrHn7GXW0MBlCwHiXTdaHa00RKqUKNzppCPSRXODm4UiLXxXI8S4RgSJ9
 kzDuiCptVDesQzSabM+Z4esUZpK3sVYFQoN+JP4yzlu8bH64y0Uop9s8BNnRTXB+KlEG
 ZKfMz+6tnkriAELHAEZw88zftoDS+0RNEPmQQDitp2NKH6EZAY3BmIbDXtNiynXjy3vM
 E6jhELoF72an1m07yLEcBb95ML5f5h6lTKxIjzKtIPJnF0YdSiguX6m64rbH0j4o7osM
 AqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU38D6zcv7Mprqo/ET3gIcmsMwkrf/WXNbiP7xR3ZUXr+ftvlDB9yHGN9c61YXlNWhzg47XIyw=@lists.denx.de
X-Gm-Message-State: AOJu0YyJa34FMrjlQaQNkl10+FhvUbu95kkMQsPTPltRHxbvs39WgukT
 dQzhJQE1apCrQ9qfAoKYfZL9CGRjkEXpEp9jr5cOFH/UwKLpzxGoDiOaw3rkKeWzFCNmbekD8rX
 K0RFhWJJzOJO2znCEnuJgLrPIdaRhbcM=
X-Gm-Gg: ASbGncvMLT0AaSuZ+BnnKD1hUTknJTJ+f8fMOobzfozlrQ6Fa5yfGJHzekWsJ3fJg3i
 tvsXbbXYjL31+KQH50SBKkZcqsyPD3OV9TO9U0+8NXdYb0326Z4tH7yXQHCSaTcsVqXe2T1iJE7
 tmGjuM0AUGyAROlFCP626z2TmVNgrZ3gI+C73Nk7qLkTWF9qc1CULgJYzVSeBjSmk4TfI8LI75l
 QJPlPStTArs0FtI15XsnijaG77/ynVO+NBVjcQ=
X-Google-Smtp-Source: AGHT+IE+/fNFGPX2mr2XT1r9LrgDcluSJnUZ/JvBH5jON4rQCwYEMhkiZTzd5td5pkZIVvJ1yrOMNRR0vD+FrrTgmX8=
X-Received: by 2002:a05:6512:b26:b0:55b:9424:ddb9 with SMTP id
 2adb3069b0e04-55b97b6d40cmr3483538e87.44.1754339806368; Mon, 04 Aug 2025
 13:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-fec_mxc-v1-1-1ed9b5df2828@linaro.org>
In-Reply-To: <20250804-fec_mxc-v1-1-1ed9b5df2828@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Aug 2025 17:36:34 -0300
X-Gm-Features: Ac12FXzuJLmnraYZKhlc6upcJOtTPuWSVkJ2slOYp-c8r4vx4y0KxmTFZqV-h58
Message-ID: <CAOMZO5DdypLP+YMagDm5Xa6Jk2+a-8qb69QtGsgfgdtHc-m3MA@mail.gmail.com>
Subject: Re: [PATCH] net: fec_mxc: Set error code on error exit
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, Aug 4, 2025 at 12:44=E2=80=AFPM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> In fecmxc_probe if a timeout is detected when resetting the chip no
> error code is set before taking the error exit. This could lead to a
> silent failure. Instead set an error code.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/net/fec_mxc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
> index 54b08482b91..ccd5589318e 100644
> --- a/drivers/net/fec_mxc.c
> +++ b/drivers/net/fec_mxc.c
> @@ -1344,6 +1344,7 @@ static int fecmxc_probe(struct udevice *dev)
>         while (readl(&priv->eth->ecntrl) & FEC_ECNTRL_RESET) {
>                 if (get_timer(start) > (CONFIG_SYS_HZ * 5)) {
>                         printf("FEC MXC: Timeout resetting chip\n");
> +                       ret =3D -ENODEV;

'return -ETIMEDOUT;' would be a more appropriate error in the case of a tim=
eout.
