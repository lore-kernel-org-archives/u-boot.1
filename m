Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84696C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 324F7608DA;
	Tue, 28 Jul 2026 15:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQN1dipNTIGi; Tue, 28 Jul 2026 15:57:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EBC360891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785254250;
	bh=kxYAUtUnR0MJObYgsA526hQmQ77XRxqHa/aAEe+gAWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJ3TY9zRwthKPpdz0Eldojbh8gapPGVFZeymvPge/oHaCqlDElAUufpJWwrHF8kf/
	 OpD4xAajA/do5LSnbXwCQn0x4RW0vdYqGWh6tWg1t1ePwZ4pWg7T7KH0vvYimmUX4B
	 46V5RecRMyz4oHYxhmgcvTZ5Z0V0KyFBbzQU0sZTSgT0UsI1kTBhaFccpyN2brguDQ
	 czBgS4GGfwV1J0Lc394iQtjUDk9Xok1QnKXHUw6rBZlpf0ZktvIbOpEEdzOTzXES77
	 60ExETD11v6KWSappOP/sAgd7OGTrVCtNEDG7uMXzk9o699mqn3olNjMrr29lUloV/
	 cNJ8v7cxzYYGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EBC360891;
	Tue, 28 Jul 2026 15:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD2E7490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF29A60891
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TRurosCxjnt for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:57:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0A8F660846
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A8F660846
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A8F660846
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:57:26 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so224666b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254244; cv=none;
 d=google.com; s=arc-20260327;
 b=cSU8JkOKXfzp0iEhv5nFnQvTEKkfdtXxCT7+9n8tj3bhStmd94YP7RjF+qG2OI8dFs
 BqMgtWCVlk5t8/P5wxNa9G4eTMX/vMHdzRAI2nUNxcywxOanTikmhSQBwOZ0MfDTpo/M
 jHRPmfn3VZo516T+jSjmnQddItq4iZDYqDNvkVp4SrcDzK/mDqNIOyWJKpoyx83PfZcB
 Mbs9dnR5S/QTLbfA1wgQhwIwWc+oo4FMFDmne/KG2EXxEgwSteHX7+JtgPRjtEyJa21g
 YBdvlGjTShsQkEAG7Kuxrt7cZ7Ce7jH2IW85Hamsyyyh3BHMCCePhSQTf8mkovBT5LZw
 j56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kxYAUtUnR0MJObYgsA526hQmQ77XRxqHa/aAEe+gAWo=;
 fh=AY0XC5iGL3lSUsmVP4rLtK0/d9nf19rbE2yQddkszIM=;
 b=AJlzXsYircF7kK/GLweWwZqCVnQEsZX3slMKqChTEgzaP+X4QQYH2NtgN1hXKl6wPw
 h00MVJ0PUgogO/19piGQRTlGzUqgIJvhfH+MwcC8vEwrb8Ns4qlm7aa+TSEYzmQafVbz
 ZiosXQ0iCfZgPk0Y4dgDSYDB6c7Qkighu1S60C4n0+XQ7b7UeK2sr0q2EHyTKa0//DGy
 Oo/1iVGnb3zkPgBBHmBpIWuo6w5Chck+77iwU7Vi0EzSL2/6bqi4dPpQFdK9MMR2ixcm
 flQPuQ87866aY4ze6Lzv+TnFfAIMf1x8zlDBB0ABlEQe4A+oSv4cin6/sYZl0mi6UkEt
 selQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254244; x=1785859044;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kxYAUtUnR0MJObYgsA526hQmQ77XRxqHa/aAEe+gAWo=;
 b=lIciLiuaG/6npAfgOajFBGDsHku3RrPF6oSOqm6tXomoEqlPZAQn+WP+HmbjPP08z1
 4BHfLGWM202REFyPkmk8GmeXSidrO45KSS6lmTBifdvN28JNBllFqBFoG5g4zPO64py8
 tnvo6qFV7vNXjwQ9Cv+wapUK9FflM7MJrpOqw4f4U+uvif/SY7CV6b49PRXsH7eU452t
 auzTQ52nnBagYVkyYo6foQlVa3NHtsw6kXM1Ns9BvDN+evvY0II51RYhNUcL1057PFsY
 rh7DD0Buqcz3UzSQibgA6pC5WSEUItt/vLNviega3aSYb8FLG3i6LiN4UaVbfyH6jZ3N
 LoOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqzj4VYMu/gjreOntAurxqiRJT5MyagaNbzUEJmLEWiXEj6uaTsWY1B+aV0K8GCREAwz5MSa90=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7laSTKbQXuhPSDsdjdc+zLcpd1GUo0HLmIan2k+lgGcpt4z1N
 fz7YMiruyjkrFdVmoZt32gkkgWL69KjwmHd9DDFVfaTWjR5g1vw+bl7x4EZIM08YJvll/ICPqaB
 Jk9KfhdTR3izPwW5+X2K8/HEg1S7zJUDM0WEUw/fE+A==
X-Gm-Gg: AR+sD12Eh4FJu4PHz4NBSOz/M0netI5wA967SSGMsQO0NRj02xVINNTuTAgjlAkArlm
 lp9bfpH1t6ne/9dZ8p6JBO0VUnT/IMkjV1IJKOSd3orP6GSHJ2gH1atRtXyFULAcH4scV3MTYI2
 xQrtGnj7DWc7goMZd0dtSi/3wwWqH9nC1R9jkvBOTrjVx6JQYjv/wUY70WJtvUdLc5S03iZ4MZV
 RUriA/Bzun1pWIA9doiJ+UGiJvQjW3bGoHUSqMDx4tkiin5X3YWVdrGnkr6iGde61yRRDxI0SEj
 EjrWrVhuoCeGa2GmvyV5tpOjdm+N7eayNCO/8U+PQmaJUDGVSrciea6YCuJ1vC5q5l6z8Qmkct6
 g/Mt6AQ==
X-Received: by 2002:a17:906:c10a:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c1f7215d95dmr171022666b.10.1785254244262; Tue, 28 Jul 2026
 08:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
 <20260727-serial-mtk-clock-fixes-v1-1-1d5542de3d28@baylibre.com>
In-Reply-To: <20260727-serial-mtk-clock-fixes-v1-1-1d5542de3d28@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 17:57:18 +0200
X-Gm-Features: AUfX_mzaDUmFmoMFKmkEakm7wOwCur4KZpUdAIdZUsNBWuk-Z6nCxGcvZbZjMdE
Message-ID: <CAEHHSvayHDYp9+4SKOhYKk0j5ya2gmXbJSP7zVQBx344P1jS-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: mtk: use ulong for clk_rate
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785254244; x=1785859044;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kxYAUtUnR0MJObYgsA526hQmQ77XRxqHa/aAEe+gAWo=;
 b=k95YH+2+bgjv04C1YqgVVpMD0AIX0qfrVFqGxhIbEwNvYHC8vmjtfckdPtjZFoItWA
 i+pD4RG24lNVoWC/YnjaqqYZab4yqTvMagN1gRrBs5LjvUeuLHScorR+Ai33lETIJz6R
 6nwc2d25QB4OfneneutDx7si+XoeSHF0N2AKCuKEdY845xQQART6OdhcbLS+J6KJM3qF
 +JyXinNSYYETJlIHcY6vkdJfDyfE7klgBpKPysUr48j+21VxCbPLuJQuC6pQQ/5TfUUU
 HBirZxemWm3YCuoRkGFlX+apO9+OfT9cKG1HKTWGvpwGRyPAmOx7auU4xXOOTQ/ayMri
 tLuw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k95YH+2+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mar. 28 juil. 2026 =C3=A0 01:25, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
>
> Use ulong for return value of clk_get_rate() in the MediaTek serial
> driver.
>
> IS_ERR_VALUE() does a signed 64-bit comparison against the range of
> possible error codes. If clk_get_rate() returns an error, assigning this
> to a u32 truncates the top 32 bits making the value smaller, defeating
> IS_ERR_VALUE() and producing a garbage divisor that hangs the UART.
>
> Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clo=
ck souce")
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/serial/serial_mtk.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index 01cc415efdd..64b3287f8eb 100644
> --- a/drivers/serial/serial_mtk.c
> +++ b/drivers/serial/serial_mtk.c
> @@ -213,7 +213,7 @@ static int _mtk_serial_pending(struct mtk_serial_priv=
 *priv, bool input)
>  static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
>  {
>         struct mtk_serial_priv *priv =3D dev_get_priv(dev);
> -       u32 clk_rate;
> +       ulong clk_rate;
>
>         clk_rate =3D clk_get_rate(&priv->clk);
>         if (IS_ERR_VALUE(clk_rate) || clk_rate =3D=3D 0)
> @@ -266,6 +266,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
>  {
>         struct mtk_serial_priv *priv =3D dev_get_priv(dev);
>         fdt_addr_t addr;
> +       ulong clk_rate;
>         int err;
>
>         addr =3D dev_read_addr(dev);
> @@ -282,10 +283,10 @@ static int mtk_serial_of_to_plat(struct udevice *de=
v)
>                         return -EINVAL;
>                 }
>         } else {
> -               err =3D clk_get_rate(&priv->clk);
> -               if (IS_ERR_VALUE(err)) {
> +               clk_rate =3D clk_get_rate(&priv->clk);
> +               if (IS_ERR_VALUE(clk_rate)) {
>                         dev_err(dev, "invalid baud clock\n");
> -                       return -EINVAL;
> +                       return (int)clk_rate;

Hello David,

This is a functional changes, maybe deserves a separate patch?

Cheers
Julien

>                 }
>         }
>
>
> --
> 2.43.0
>
