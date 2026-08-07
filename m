Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA10C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 09:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6962A40A87;
	Fri,  7 Aug 2026 09:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VfHOCxYqi9f8; Fri,  7 Aug 2026 09:49:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A65040A6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786096145;
	bh=tAitYJ5kipY8MMXeyNLWiWG0nuGTyzBSVsaa4WiLCoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0etkpAsU4sjfHx8Wfu68P3lkVO5NHid9l1iBV9aP08v/Lp8QHWoLBx2y/T9crAjF1
	 +dO9s+fPYKN7zDzOmkQDUpYL/VU0YV3vjQHuYNMjEjxdj7u2Ks2H5aohiHkt4Fpxcl
	 mTeNiuWZc418W8ZGO+c9NYK1zWvl8TQ64kcQqx1JwA1CTnVn8h+16yQEQkDMYgh0qj
	 o37OJTlwQAJ6giWIOBBS5r8N4eDpGz7+aGDD5Jr/Qgv6Ks4uqE2lmcVfPmGHSMlvwF
	 vfw4v542rtSjudCM8XN970uLg2nrc1jz5ILg6QbvxYSAKSHv1z8RZ2T/E2PBIBBvcE
	 LQOqw9VB8KDdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A65040A6D;
	Fri,  7 Aug 2026 09:49:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F68F2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 450D38125E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzGuyeTD4FIY for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 09:49:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 267AD8125A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 267AD8125A
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 267AD8125A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:49:01 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a15d54ac95so4624897a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 02:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786096140; cv=none;
 d=google.com; s=arc-20260327;
 b=A6ZFouOEsqbAQZxhoV9+8PpmAMTFk7fyqy8SSSsUgg/zccUd0TOjCws6iH2xpZZhou
 5PD3IHbm32m6xirwKd7QnIO/48bBbwGs/tQJdfwwzF9fE1SaUFb0TfszqNl/19nMEd+/
 jWTIZhFmglpq+Ognz4QdnIv3Pj6SVRfQ645oC60CRP2u6sL4lrgCG7bjIXMZQKY076Qr
 WALPgStdrhGkbWgCnMHSpX1CmXgd0rUj8O1KzQdGp7JJe8z+E8Z6gqtLJcWG9btJYvAE
 OLbOQkc0CzPVdalRSbv219Wx1dZNMbMUZKn1XT57B4/nDtDiUwpRJcw6CzoHrJjhxMJw
 RICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tAitYJ5kipY8MMXeyNLWiWG0nuGTyzBSVsaa4WiLCoY=;
 fh=sL3mYJdh9FxxRiBYc2BM6OcqxRcdxsE086ag0taETrc=;
 b=WXkUgcBYffD87fs9C6rQqJfXUNqW2M9VHh1necbrXy7HG8JC7/C/x2PDdHZJqK2Jeb
 qL4I78VRWn2+nKZeYVDG5YiLZSveT897es7hWlEdFxt2cXKEqAPkFaM6zytAiAnQtvip
 4ikM/X68+gr/9sd+flYmrrrb0gsUfo3rD3W9i5flo44z8rn9gFwDMbPdoFkv0pJQoO5Y
 Nkejx0nwm8Yad/1BFZfuV9OgIHLs3+wXh3B3uNu0GDYKN2NxqjnMZwDeSMql+e4V/v6s
 KRe2vURwYCU9YO30FSM138rHkZyPuut7fz6CGFqO8ddyTE2whPgFcTxBHJh4J7LAlCYx
 NyMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786096140; x=1786700940;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tAitYJ5kipY8MMXeyNLWiWG0nuGTyzBSVsaa4WiLCoY=;
 b=CrD74Lyj51Ji8tMMM4K36FMmqw6nnbNq6GGfnkvEd9Q0z7DbyoXCi40F0cWgbvrZUo
 BR4FPjEh94foWh7MpKXb+teJ50b23tSusadFQfYIsMSQaCLBg+1MytZGXAFeED8jVCPf
 /RgEFyF0WW8Wk1AY3kubFvOQ5ftVBSmn8QPn5pBtwCNw4HjLVZycnjPDQ8UugkfqLQA7
 BlK9H6s6P/aMYyZ4/FwFeA3a/SEoWsG+MRBOKyvM2bPWNgvG1f9D86c7+9MmCvbvysDJ
 IXFtFt0Rdr9owlrN2Dp/xntSI3nC3FH2Pkd3Qq7FmFrOjwssBNrucLMV5KpisqUBQ7C4
 csSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkORPMgmHH80/1pxyPYDuP3JG7ydm/qWeAHUXG1Gbb6MFjGLSiR+UrBm7a5qhaJPSmP9kS3UA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyJhdpemVddL+vje6hqejhVY9jVsNlJ0lUPSx7UFyKhqeAXvKkm
 RN5/guH7UfzwQVzSiCKV1xqkirW/5V6huYjnaOQnuEL1zeDm30Vpg4OQDKla0hEPyO+Uq3ZT8K1
 8bVq2AITUv5ZEul1cFGnXdRIz9qOJKXuQ2pwIXTpKhw==
X-Gm-Gg: AR+sD10f2FQxQjlUNmvgVJzpV3HMQXCTEdfdAQ6nshpmzZnc07PUMquGqFZ3enBVtL5
 i9pDSPqjz4nOMa6Ro8czOMCMekMZC14MvQBq22uYbaBDWAweKk6LCsfNtj8w3SJlQto2aDAaJ0S
 vjbTARA1D3XsZUjpAnI1/bM7PjjCyEq29fNkDt6PphHVFHWAWNamrw8Oh/eKtxZ3amaRJbm0czb
 uWkxT1nr60l+FWtCMzrakvVCFMbJOaZqCwIvSO7cS+OD2anDS3mCbpzOXJ690w3rQ9DZba9d7AW
 udv0XLaRtGWN5cesGmZzDqRPAvk+V8ERAWiyaXPHXO4A/hmzqTUV34Y1LRCJ6yXnSZPK8nh2XBC
 x4+30nvfa3NKXD6V9WoHl2ThZ0NZ2qbUxCyxz7UtxjKZY9Ywz9yWckrTmIc5FeH4=
X-Received: by 2002:a17:907:a88d:b0:c1c:4d59:2b03 with SMTP id
 a640c23a62f3a-c2039afb035mr1037281066b.3.1786096139702; Fri, 07 Aug 2026
 02:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
 <20260731-serial-mtk-clock-fixes-v2-1-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-1-022110a9ec3e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 11:48:49 +0200
X-Gm-Features: AUfX_mxWY55WmJuKzEQK0chaQ4eU5m7cfqmkQz9p4srAh3qJw40uxaUhwYr3Slg
Message-ID: <CAEHHSvZKMF3rN0ttOStEL0vR2eRDXx3wZsnuQX_k6=sNwKZDyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] serial: mtk: use ulong for clk_rate
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
 d=baylibre.com; s=google; t=1786096140; x=1786700940;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tAitYJ5kipY8MMXeyNLWiWG0nuGTyzBSVsaa4WiLCoY=;
 b=bWSaIcGUlx7x6QiYLRO/si8nPfikHPXQXfHRaoIH8YqmD8CnqRGpGB1mdkC5+SSY/Y
 uTUWAE7/jK+JmjzVz3RNL2BDPtKw8RGQPLIPWUrG3CX1fQ+7r7fSD+y2c5Zq+KRlaMEm
 HVgjmWIX1CNCMbfusMoMnXH4DJgsyjTpfiWD7bDfhR0roDd92uCNUteXWT/gNNVrr3hC
 U1LhczH4W2EdrZTzs+ioAbmT5u0D7njTHVuGSjcs6I3aWrJatKu5F4DQHzdcBC2rDHGi
 220U5XqOiRNxmnsK0Xz/aQa1kupvux+dLgGRRrR+LFfhpNDMk+ZpRIPiH14XhYL9F7BK
 LPSQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bWSaIcGU
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

Le ven. 31 juil. 2026 =C3=A0 21:39, David Lechner <dlechner@baylibre.com> a=
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
>  drivers/serial/serial_mtk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index 01cc415efdd..28e87f485a2 100644
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
> @@ -282,8 +283,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
>                         return -EINVAL;
>                 }
>         } else {
> -               err =3D clk_get_rate(&priv->clk);
> -               if (IS_ERR_VALUE(err)) {
> +               clk_rate =3D clk_get_rate(&priv->clk);
> +               if (IS_ERR_VALUE(clk_rate)) {
>                         dev_err(dev, "invalid baud clock\n");
>                         return -EINVAL;
>                 }
>
> --
> 2.43.0
>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
