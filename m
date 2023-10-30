Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B2EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 08:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5190E8722B;
	Mon, 30 Oct 2023 09:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ysmlwllI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A37879AD; Mon, 30 Oct 2023 09:53:07 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5AF8871D4
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 09:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so7091679a12.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698655985; x=1699260785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4bph23jEeIgkR9FWSADfasy54dQTeCRttzg9E3H3abw=;
 b=ysmlwllIT8wJ6Bwjqh4RIz76ExEqKSpOxEFZuDJ+EdNJnukhhH1b1/h+YKR1gtl2FR
 YymsUKHtVNJGwcIC7bDVNkj1PNshcHbUTo5lwBCXzpVneoqCQzkzUxgqw6rF31/5yQU4
 2cJbp+ocKAJT+oQrustPZuVt69HcwWZkBBl79+0FtRV2iIbKBpRAoc0lSwaAsLLqSjTU
 YJq38+M84qaZf6LRWHz44VWvwuJ0er5zzmOvE4AeFORdo+TyvqLvoZ+NOS8Q5kvK1NXN
 OTyt9j0R0AeAB+YzDo9P9NTWqeH+xZ1UEXkUnXSO/KnD9C4g9m1V/2uyiCI+ohwkSP3F
 xZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698655985; x=1699260785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bph23jEeIgkR9FWSADfasy54dQTeCRttzg9E3H3abw=;
 b=aR4qGt97ZW6xkPAdgPQiIHpXRy7GV/3T/3zbnVsjSTKCm2Rl8QyhuhZPehopplESua
 Xd/Rnj0KeVZ+9ZuKIjrxnibV+r7xjFB7g/zWu8/gML9Z9tdf9ZliSyY4+9kZAYSjnHlk
 zd/Ow3P6/iBofqWQOPKpt7yfzM1n7tWaU9kfdE8CtYlXOH6Cg6YHzwHEVf4ad077ovjq
 spFLgEhpkkAESFwx7N9gSzsIxtlnpwa/l1SAY3TiTRUSvCw2KBD5/ZtJgmYTwiKvBfJt
 DRpr/Tl3flFllEaKPhGpK//S4ToFpusSgcl8j5QaWaFaLcH6wZ4Py4+p+rnoPNenGlao
 NNIg==
X-Gm-Message-State: AOJu0Yxl3xd8/OTXc4c/5y8D9aMrb/tsCcYqD8Jj+0QYFaFzMoi9aMhb
 xi3F6bNuUf+fwMRYstrY235AuucsDC8kPirv2gE=
X-Google-Smtp-Source: AGHT+IF9Pjgf9Wb53XUJF+N8xUHtHyUe7g9ieWVWTkXoQlcLIoUjmMT1rtVL2j+LQON/TClYvfWr9Q==
X-Received: by 2002:a05:6402:cad:b0:540:1bc0:65b2 with SMTP id
 cn13-20020a0564020cad00b005401bc065b2mr6577013edb.10.1698655985273; 
 Mon, 30 Oct 2023 01:53:05 -0700 (PDT)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a508d51000000b0052ff9bae873sm5899018edt.5.2023.10.30.01.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 01:53:04 -0700 (PDT)
Date: Mon, 30 Oct 2023 10:53:02 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] tpm: sandbox: Support self-test continue in emulator
Message-ID: <ZT9u7mIvbduGu6Vp@hades>
References: <20231029042817.3938657-1-sjg@chromium.org>
 <20231029172813.1.I2fad865da519b36eb7d5879bb9ab552db8055e1f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029172813.1.I2fad865da519b36eb7d5879bb9ab552db8055e1f@changeid>
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

On Sun, Oct 29, 2023 at 05:28:12PM +1300, Simon Glass wrote:
> Add support for the self-test continue command in the TPM v1.2 emulator,
> to match the functionality in the TPM v2 emulator.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  drivers/tpm/tpm_tis_sandbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
> index 7350e1c4d525..ca992eeb90f9 100644
> --- a/drivers/tpm/tpm_tis_sandbox.c
> +++ b/drivers/tpm/tpm_tis_sandbox.c
> @@ -222,6 +222,7 @@ static int sandbox_tpm_xfer(struct udevice *dev, const uint8_t *sendbuf,
>  	case 0x72: /* physical set deactivated */
>  	case 0x99: /* startup */
>  	case 0x50: /* self test full */
> +	case 0x53: /* self test continue */
>  	case 0x4000000a:  /* assert physical presence */
>  		*recv_len = 12;
>  		memset(recvbuf, '\0', *recv_len);
> -- 
> 2.42.0.820.g83a721a137-goog
> 

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

