Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36004C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F10E87F96;
	Tue, 20 Feb 2024 15:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Barok5wV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CF287FCD; Tue, 20 Feb 2024 15:20:15 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DB987F5D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so4202992a12.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708438795; x=1709043595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ujyIGiG+Mnu9vRmCk3UiNbY6tf+5mP0r6fuz88Ietk=;
 b=Barok5wV9Jp0GK7GhFXXzIJiWypyJbmq2+qHZ1J7qH9h5gYzsO+7Os26MI+izwoPGB
 wzhtmywR9Wex2UkBX2oq3H/ZpVAQUP6EwLtvz+O42p7krfkfKMsaDE0Yl32TXBO6WYis
 Beu/eb+HACMTCCy42yIJbH61kMfJ+GRwcmKMEb90zK0gjLDQ4dOBPIhap8PkaAjXh5tm
 FURjLMjqh413X2AQjr/cFPsIF0SzgkqjsnA7On3WHOf47/MQTrk1y8nXQJqKjzlYasqi
 koYn07eo+cPr9AnpZ199GhynUYlBFm8EP+v0igrb/tY2WHfTkJhQ9PhLaTg1PTA04LEn
 OhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438795; x=1709043595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ujyIGiG+Mnu9vRmCk3UiNbY6tf+5mP0r6fuz88Ietk=;
 b=fQYWSnfBqiQQgdH0e/pHrh+LRlpGBJ2eqpr8k0yLb05rwaP+rPzyZQjOJAO3u2YETq
 M6IUXeUCIa5kOvtN7wT5UMjL5TDZB/Xy5a3ZbSbVxiXjB2h0MLs5qeWbvC9717nEStH5
 5JkZmPvmDM+P8z5tdSqSAV0Lgn79RR+2GPryrw6wAvB3xCUAT9geLe1LkmTkZY6u4K35
 h0U5kBaEiPu+o3DVMHWvco3wmn1RdVoMFL+gM95/sJ6ysZ3fW+fj+4xQLt9jFZmNR7Zo
 3vroVlLeLvgzzzcc6g6+jbXYt6siOEkE7vmL4GtpKCuSrnERDxzAp1kgBAETBqHm5Epz
 yzuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFQgMM4ooSTa7oqeOr+JtovxuM1YHyvZfzJPNKYwZWktSnYIF1RLezK1yxCiWcf8PZ6JDiNEsYXQL6yBrwtd257ov0EQ==
X-Gm-Message-State: AOJu0Yxsvqz9dOX97XGAqfxSPUmdsohMxBRRMK1kOvU+47xTUZVugbNW
 E4A2ZbPAxJgSzAgXvjJHf0oL6zvfCuWzLt3mrL3djppe8TO8C7rhWtdUQ45MDZdaFZIToHY+na5
 JY2OGqAjiXw5Ec2+1gzeofBBH7oU=
X-Google-Smtp-Source: AGHT+IEsHx4PxPpGdAWocwu/SiFcKBk4AAK1gJKqYJA8Y/NlS/Ad7Mg/mccWVO4FyU2/wOw+6W+CdS6Sz9B8lIcSkM4=
X-Received: by 2002:a05:6402:514a:b0:564:dd12:841c with SMTP id
 n10-20020a056402514a00b00564dd12841cmr476260edd.30.1708438794944; Tue, 20 Feb
 2024 06:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 20 Feb 2024 14:19:43 +0000
Message-ID: <CALeDE9MzcnEBR-McJvJo8FPf8ad=8ytoU0+HkmpB4s-bLEDAwQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/39] board: dragonboard410c: add chainloaded config
 fragment
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
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

On Thu, 15 Feb 2024 at 21:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a config fragment for building U-Boot such that it can be
> chainloaded by aboot/LK rather than being flashed directly to the aboot
> partition.

How does this work in practice? I think a lot of devices, one example
I see is signed vs unsigned, or emmc vs other storage, have to
configs, how would a user choose with LK vs the other option here?

> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> new file mode 100644
> index 000000000000..3fd064924a1f
> --- /dev/null
> +++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> @@ -0,0 +1,7 @@
> +# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
> +CONFIG_TEXT_BASE=0x0
> +# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
> +# CONFIG_REMAKE_ELF is not set
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_INIT_SP_RELATIVE=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=524288
>
> --
> 2.43.1
>
