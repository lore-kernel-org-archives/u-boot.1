Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B26CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C45B84D5B;
	Fri,  8 May 2026 18:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bH9slB2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4245984D5E; Fri,  8 May 2026 18:33:33 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6658B84D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67e9b3037dcso2313659a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258011; cv=none;
 d=google.com; s=arc-20240605;
 b=Q8+ZmP9DHmqUC9Vs0nS7NHSE0uScHH3uDHVJRY1zvJvQoqupW1f2eJx888NkGBimN2
 s0Mw1xLaBuABfuk7JAn2m+a73ZWj2ZY8UM7/3SBRTf0WxECJNh2LEQ5G3j/5mcY3VD1Y
 5pEDtBU8j/aIZu/JGAaMgUzsyQMGRYRtp6eAGNwFO/7lojOvRs2s3N7sxactwIUGIa0Q
 PB2KEmNERfv+NzwSiFab+RAflNRYBklWfCTrtHkged09yHMU1kNnkqhl/iEYzf+SqeyT
 UkGMj8Jpo7HhuPHF6m6AnyL6MGrD9/eArK/Sz9G1Izd421UqwKjjrSEE4kJ3JXtlMmbh
 YSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5TTPZDK1uuC0hcTeq9y+dpFLZJrchm5tqllgkOSNo2o=;
 fh=RrscOEuqNWG7RNbz9cdSX0Wgt+LjOhN0bm7MfOUSrDc=;
 b=FN8cDZGwttlJ8EE9otPY9XgKyGe/ScpDp+y9Hh7OZcnnc1vLJ0Vu5BfOyE8u9k7PZ8
 daByces3f3xm98jcKB7+P/2WNqA2iB+Ag0egzcad+zJ5Vdg5Pi2EXHHI2XoOtJHjLIZT
 3wNx4XfUDRRFa4RFwg+0m/Jdk6ewMWJnY+IpDQjV4kWa5ZyimNX3z9j0RaGdgoi7emob
 hlaufhf6AX3jOwkvmLNs0l0Kqa2DNhVWDqmyHHX8UoRfBd0wmSAGcYIxrD6VsDPJGrD2
 lqAmVLE8HFTXtqmmuAZxNLtDxF0Yun/6bH6tRH+D2PnBh2ltp8wX44IBUjUriq5ynkm8
 932A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258011; x=1778862811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5TTPZDK1uuC0hcTeq9y+dpFLZJrchm5tqllgkOSNo2o=;
 b=bH9slB2CA1ZrmoomDS2rJk+EvpS0rzFrzjNrp7XDyCMRnynP3/tkkboS+SLFRDZED/
 Zye/PHXOCXinOphV+vITbKxEixvpMvKGcN7RHHaaZZcTPints06b6WE2Is1Veyhkpr/p
 sFIZH+v8ucLbvzSNeXx/HKm+qC118s5DGIyRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258011; x=1778862811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TTPZDK1uuC0hcTeq9y+dpFLZJrchm5tqllgkOSNo2o=;
 b=GSzcEK5hFA7MZJnwY/rR7ilzLMVnWkOiiu7SCLIRt6WXEkY0XJwgMLsii2xq9iKg3R
 I4nGGa8muYBFKd6Giw95dVH79ZtfMxeiDGkYfBLAejDNGi0VHRZabKpK4XKRVWFwpAGq
 Ww6zzbSzbPgkV8GSwzPitaeE2imegceYSrn4l757xp/eINTfbT04ZpSU2Xk3+JZmv+pr
 02ouPRlhozfmTePDgFLG4e/XeEHob+r6p0E3oXudaTxBfVm0DL3XNh11WNk+gvHZ/k/m
 ohqD5QZZ6lVpY2em2dMtOdK2BOx+yhTkSRcQvebYffsBuCWNRX34vS08djex0W3Se+Nc
 3dGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kLKDJYeM+jWoEJ8OFLfHYfv49QfG/ziqW/QmyxSLnOg0JDnlDv0AYxy12VmSo+Q6cFGF2lk8=@lists.denx.de
X-Gm-Message-State: AOJu0YzaJeV067sdE9T6BZbQBAYMwk4nhmCacQTmyV5kJJWn1R9aW8W+
 sI0GtdNVuH/Z02mIgr0SKnpbNxdW1LKQ2RXOgsdnXL0IKMP9GqThVBGTQO5yxLmGJJanynRT+96
 Fp5Sh0XtnPqew1/70THmRXPEmfihtyi01Wvr+lCN1
X-Gm-Gg: AeBDietzUNanSoD5vNT9OgrrZmezDDR6OwnthsubTNvi38ucNSYzRuv5kJmqVUtW4fc
 vSS8NFTfO2GOdaRQ+tocQrjCmGme1CBFh1iOpMbUFhGAi7KGq4ILF9QpMM02jrSzdrhMlr/Lh/5
 hXul7TSC4hsENvfR5rKJxJe5P7KwwR8aJbLhfJ5s8IkXLSYrCxDDmu20D12CmNvlwGr7huKOR9l
 LM5tSyBx0H3NYf2QFb6RLqujZVUzlLAeIM4o1vzdUaR7OBpko/AjXs5tl73rOB9Ki46nwq2WDnh
 jDMxvQ==
X-Received: by 2002:a17:907:a186:b0:bcb:8b03:9fc2 with SMTP id
 a640c23a62f3a-bcb8b03a05dmr58485366b.15.1778258010767; Fri, 08 May 2026
 09:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
 <20260507-doc-sysreset-qcom-v2-1-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-1-37fef7a9cf92@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:33:16 -0600
X-Gm-Features: AVHnY4IRQa-hA1FXaP3JQ7MAFsl10QuzLE-5Wh0xijxsJh2BjWwu1x2dL0jM9FY
Message-ID: <CAFLszTjqrfQiNGjk7JodYz-6XTk-sC8reDUKg+g2a+YRJQkr2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] cmd: boot: fix edl being shown when not supported
To: foss+uboot@0leil.net
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-07T15:04:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
> cmd: boot: fix edl being shown when not supported
>
> edl is implemented in the sysreset_ops.request_arg callback of the
> qcom-psci sysreset driver. That callback is only called from
> sysreset_request_arg() which is compiled only when
> CONFIG_SYSRESET_CMD_RESET_ARGS=y.
>
> Therefore, only show the edl option if that symbol is enabled.
>
> It is in a separate if block because any option but -w will only be
> handled when CONFIG_SYSRESET_CMD_RESET_ARGS=y as seen with the
> implementation in do_reset() in drivers/sysreset/sysreset-uclass.c.
>
> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/boot.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/cmd/boot.c b/cmd/boot.c
> @@ -60,8 +60,11 @@ U_BOOT_CMD(
>       reset, 2, 0,    do_reset,
>       "Perform RESET of the CPU",
>       "- cold boot without level specifier\n"
> +#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> +// All options handled by sysreset drivers via their sysreset_ops.request_arg callback
>  #ifdef CONFIG_SYSRESET_QCOM_PSCI
>       "reset -edl - Boot to Emergency DownLoad mode\n"
> +#endif
>  #endif

Reviewed-by: Simon Glass <sjg@chromium.org>

Should SYSRESET_QCOM_PSCI select SYSRESET_CMD_RESET_ARGS ?

Regards,
Simon
