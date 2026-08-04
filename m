Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB903C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 08:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A744406E8;
	Tue,  4 Aug 2026 08:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fw81j9bBj79M; Tue,  4 Aug 2026 08:59:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2854406EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785833953;
	bh=vTzt7gTB364Y7cCH1bLBVmmlVXmyoPdgylnlYBqVunQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vgkpn0ziWQ246Cw55nbDNEJn0nXMaEO0wl7f+Rtwwo6vtfxMU2BC4Um/CNLy1rs0D
	 Gtq/GtJpNOeRFvuCpBCotESt1z7diPP57gzUABfrD08Fmd+Ol27D4hPZp4nfTP7yFE
	 ZLM7c/OhFC+x/rTvgGkrauKkHcIIJXbnZIyvsa+DsTiBTzSmUV4zb7z5CePYErOtBO
	 7yRupQ7KNPKqWtri6w2LF9dxRYdaZPRaVPh0WdGMhWInb4M85VNLlWyUVGQMQTexmO
	 FpDeJxOvGzgCp1rL+Oc6aojNjhN7CdIQYV7g739CJd5Jy5x1kSehMJ/r79qcnF20rd
	 X+iYkT1Tm9k7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2854406EA;
	Tue,  4 Aug 2026 08:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A859C23F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5FFD406EA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPGmsGkvtIPo for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 08:59:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D9136406E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9136406E8
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9136406E8
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:59:10 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66899c7b57bso6479237d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 01:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785833949; cv=none;
 d=google.com; s=arc-20260327;
 b=G+a9GSwF20JG5Kgxx3wIdqqBlnByXFLwE3N0c+e6YEkBKFjMyUGdSoBJcfIScIMhsE
 TpSSPatykekc4Kf40fIW4lSyR/dOQwWbSh6I2FoQr3dUJBGi7wk8DBcRLYz5UUlGeIjD
 sxrfck9BQZ4SnSlKh2OKMtBbrTdSH27OTSEC+xNWmu86LnS0YwWGGa0M8IEuWOvbCUFu
 OWTW4bgmeZkwEIvwiReu/qGGv/+jyfIFoRkQ10A+RxapaqlDDqpaqW4uibQmXsJvjIlt
 QakkVW5xYcVBkq16b1TBXPZM2Tyzn6AcEE0w45gn+E88qxLKC7DTZsymi7cGI8APNCm6
 qlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vTzt7gTB364Y7cCH1bLBVmmlVXmyoPdgylnlYBqVunQ=;
 fh=ljxBvtK9pKLqimmAAFMeBw6hsHidow9/hJ3Jbv7MK0s=;
 b=YfH4o4lZ3CXyle1swPQNrlQjaZpqPnGouYLJe51a3ke47gQjcwHBt+BQawt/NFWFZM
 idgPnCxAI7WrtDW+wH3NkxaiQGGIKi0IP3pRfrnVZ/ZdgKLNXekneLucpj28NC/qp8Zy
 v4ftv1Ray9ztGApVI7nEzuOuzr8ndRxgwGekINIydzKZRFTYZzuS15fH//NDApamr1Tm
 NRckTONDZJwzOoHByeAJJJ9QnZLp+mCHg6R5CMRR5X7CWyw0DJx7KZnYVK8INZ+cKfAt
 tFxhMm5huJgFh2bhsuo/nkrlnn+ZDITv4LxI7/uMj/Av6dq1YYVEs3vvJkOgaaw3wd4i
 0Cww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785833949; x=1786438749;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vTzt7gTB364Y7cCH1bLBVmmlVXmyoPdgylnlYBqVunQ=;
 b=MO0sCGrZLW0MCCj/t8lmaA3uuQPkBuPKOwrbZUF7LG8YHsQiENfViqLI3hhkW8xPx2
 zux3+EdyOQTEZVJrnJDNVfJZGkuaSYTyQkseovFP3KC6uNufuUqs648sJdUlNIcKSFYf
 BQhTtglq0UniIfR1J35+5F0qBFHpLvtVJF8N8mQhcf/O+WTRBvEiGtqz3ks0MyjL9GiI
 6wX13Z44Ne7M6sORxR+/P+2rksFKzyvgWPpGdwhQs6bCEruMsd8JWSXEFBcQ9GmVR9Ul
 rPQOr9CdxqG/5vKQ3OMpwRqiAhATyrsxAIYgEkTcli0wiYI9pFtRDLYbIu/Bg9YaZ6sZ
 rLIw==
X-Gm-Message-State: AOJu0Yx4bLaoVUMxFk2WbeSLu8o4Sco4UoXglEU0tTxCGq5h+ig792H2
 /RGN/OpnmsFNnxW/LI7LOhEngyAbFU3b4xmu9fQupfnzJbQ/Pn7ZvMZUea88InkxuTKmQwMeI87
 5qpUI4XcIZvONqXM4Rfh4ZXZxki7lbnro8uZM4NeCcw==
X-Gm-Gg: AR+sD13D6b+02kmkx51mwsSUPQlY4WMmDuyS3L0a7FiO8ZlTa2VQjxw7IcU0N0lXijX
 pHrAhFrvK1oQ60oAtAj8XzddrlhCND3pdwpi7o92RMOakqDTg29fNYrUDl/SEKm0PnfJXI5ZHsH
 fz3OlhaHR8ZcxojV5MdeAJZr8OO3PpiFW9PbT1+lJnf4aLzM8gVlgB3a8vkh4+dpd5N6tQTXGq+
 GqICxTdOp/GWroLCqZ1FtxjSlHrrafINUWhsAm7ja/Q7WLCAaIb80/DvIfsheIQR9ULKMQOisCx
 wOaUFqB/wGBYOJElB+OmFtZXWHdfAMtwlai4Cj5WM+nV96SG7rBMUnc7kIBUkhvmAD1efnpxzfP
 VrU4wwsnVHFRdEWFgAbJeyz1HDZuj9MBrKy1tAdXhp37qftKriZaoZ4xhCZ4evd6px87DMvTEs/
 2PZ9IAuUw9u//e7UeI97XLhjVZwuvkgzWZNuwqjhJiaSHpwCCzDyoLDqPln/s9harS4vDiHS+Fq
 wUFScpdcMsHAnvB73+FF5nZMDrRF6FGRGfB3tExhHp7g/lfeSfOswh2wpSZ5wB6DNd02nuY7Qwi
 fNiPtd7Sn6lLwLpQboBJ1jwe7v0h7LV+5gxp7OyhZFXA4xtrL12c/IFV+EfDPSnRfI8pWPKbWH0
 BP+9bnDmqIAFMxaZ5hQYeyFPJhpTSmR8/R2T+7TkTgRc=
X-Received: by 2002:a53:cecc:0:b0:668:a57:2b0f with SMTP id
 956f58d0204a3-6694f1eaec3mr11780138d50.45.1785833949145; Tue, 04 Aug 2026
 01:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-2-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-2-4efb529140d6@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Aug 2026 11:58:33 +0300
X-Gm-Features: AUfX_my1sf4DvF2K8XbddAb3kGIx4Mpf4RnLbQ3e2jKkbbu6zH64ktaxn95DiNM
Message-ID: <CAC_iWjKu1bj8ru18xmiqfp3rZ5SHoNy6OuH4=jPH=zvRRT1fGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] boot: add a firmware-owned devicetree source
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785833949; x=1786438749;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vTzt7gTB364Y7cCH1bLBVmmlVXmyoPdgylnlYBqVunQ=;
 b=rsX3Efqlp9UcPD51e6g9BEvqHCkas5KISgiZ3UCXuR/mhfamZmfwJEcUlxcAnldVnt
 7zk/z5ETxt4svrNlnU6T0FT+DI0NeyQeEwg+Fmv5VhXCAFj+kLxMVKtEflFztDGs5/sA
 1jDkg5SSxx3vtGFj6DNUEEUYASwm1a/2FUkPnW9hnnxv2yngEqH6RCphLmdTdk1EGKnR
 IJZFAnOArMGkuauA3o4DAKrnUasnTpkrUr9Nk788Ua013qMnJsFVY0fTh31+RKpqwcKl
 MabLsz1vmEwzpQtawwwoxtZT3vu6LoMpITxAgKDbhSmHO7R5huqpt6aLa8MHgUdUWiXF
 TmDg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rsX3Efql
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

Hi Carlo,

[...]

> +
> +int efi_stage_firmware_fdt(ulong fdt_addr, ulong *fdt_sizep, char **namep)

Is this really limited to efi only? This seems a pretty generic way of
loading the DT that's defined somewhere in the firmware. So perhaps
remove the efi prefix? Or find a more suitable name for it.

[...]

Cheers
/Ilias
