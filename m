Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE2FCD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2B7848C5;
	Wed, 17 Jun 2026 16:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="djXor7q1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8C5848D8; Wed, 17 Jun 2026 16:02:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17ABA846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68e5f7c1131so9959926a12.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704965; x=1782309765; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WqUWgfrEzqWE7ObU+rfEtLHGYDgvl0QLe9ZFcI3QkME=;
 b=djXor7q1kKxb1aLtXZT7B8jhbjfwimstQtfIsQaw2DTAEiK90Kr6id1hsazlYCIMZX
 HpJuTbg4+cAUkyj64PS5HObDyBgXOyfbjEXGgZbU4NzN4sNMTUKvrh2ZK7uT7Ai1hrWL
 6z5Hx46N2rDVkQSzT/zck4KXZE3w4hBiobGdtFmJW2dKgi2htjBya+4CVaeSN1yhR3fL
 L6d8cwDyj1PxFSmeL0ZlzT8xI8uwAxbw+0CW7ajq4yqZ7dfKEM28zjpek4SGtcbtVBbO
 kQmyhFfz/gKUiHkSNWN2YYqm2h6wUN8O3DM9vBNtmY4bDX3OyGPaAGut884r7asqcKiu
 7q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704965; x=1782309765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqUWgfrEzqWE7ObU+rfEtLHGYDgvl0QLe9ZFcI3QkME=;
 b=KuchSkZvLdnGyJ7GBGF8jzcffNgNOlzh64VR5TjtttuZBbmcdXotf7Zd1ojo4DLzq3
 pYYYUwGip6mOyXkPiNiOmCn625RACMiTpofC3z51k9s//l1c4DD5GgXP1ket+fVttlNH
 QweWL/iYJ9GhQibz3TUi9EdfDxwS+N8TMLCZa3++d/6/FiiS1R4n99uC0ZmgoYBJAE72
 qPYuRcGXwFMhOstBU7MtKucDq+vBa62VY7lnEqnkKmFLYVi/l/IiNrU1FRrPwif8DAun
 G/EQxNy8Xl/wkT8kgd8HQkBnRPWkVSe9RzJs1SETE5oqnAQB9Y6f771lE+cBXF6OgeR6
 6k0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ89pn+s9mpDt2+QKhrKpytMjB/wf+dfDZHXkMBzSLQZCaRdEH7QzplbnZMYqh8Di6nQdCdA5uM=@lists.denx.de
X-Gm-Message-State: AOJu0YwaGqrmuBYv1oKtRTCsdjEGihKSHtVQfnGazi5jtJbVn7L3Trbh
 AOTpmiCvUeQ6QF7SFfIx+fkeX/ierwSp01xG5l1v7n39mzTWhOJkx6OVH++z+RwiYAI=
X-Gm-Gg: AfdE7cnmTRlgRWm+oRPXDtzQr98/kJOCnLzeNAg/sTePtHAHjTSAxn6Vu9b4kt7Cwo6
 ZBGUT1Vd1ExwMHaQdynwnEc+U0L7MJZ7GhVd2M2YIt6SfEV886YYbC2RyyVGNo8KkKFzGKxQGqt
 n2O9gtf/qSIAAIOkXmBXF9/eD58LlSrV+TtctFYTkGIVom71qy/Kcg9xUvQqXlI6PfsvBgbPmb5
 QanKnDSEssd8LTg0Mij7OK1OU7AdwwaAUA7iZdElAuWDuKLWNwLEYKUvyvic0ytmwusJonLGv9U
 VO6LpsuoJvQBK2wz39o2MrhFuV9cKDyN4aY4mOgl2W0BBDCnii/vVISc/sHslQxxScuw9Xrn7m+
 7EIsAeb1bl+i5MNzdvDxtGqHggXMiQ3DgjuwA0PSPqM9ZAftB8X/lU5BtUqpWzTUb+g3PGF6AN2
 alQczLc8k8txLG7pNm1Pmju/HYmnolCdqz+DWMibKUx1xB+W4V+yZW
X-Received: by 2002:a05:6402:380c:b0:681:2472:4b2d with SMTP id
 4fb4d7f45d1cf-69547400044mr2159728a12.2.1781704965267; 
 Wed, 17 Jun 2026 07:02:45 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937938a0acsm6983961a12.19.2026.06.17.07.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:02:43 -0700 (PDT)
Message-ID: <6f8b07f1-ae42-47f6-9ad0-ab1d03e85f87@linaro.org>
Date: Wed, 17 Jun 2026 16:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] reboot-mode: reboot method activation support
Content-Language: en-US
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-9-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-9-170c9cbe5099@samcday.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sam,

On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> Until now, the reboot-mode uclass didn't wire up a producer path to
> allow arbitrary changes to the reboot mode. The current impl only uses
> reboot_mode_ops->set to clear the reboot mode once it has been read at
> boot-time.
> 
> The public API is expanded with a dm_reboot_mode_activate method, which
> will instruct the given device to activate a particular reboot mode.

The new user for this API is fastboot, and it iterates over all the
reboot mode devices to call this. Could we just move the for loop into
this function and remove the udevice parameter? Then it's just a simple
API for setting the reboot mode of the board. Returning -EINVAL if the
mode isn't supported or -ENOENT if there are no reboot-mode devices.

Thanks,

> 
> The first producer, `fastboot reboot`, will be introduced in the next
> commit.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/reboot-mode/reboot-mode-uclass.c | 18 ++++++++++++++++++
>  include/reboot-mode/reboot-mode.h        | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
> index 7cbe02eb4ed..c47d11b681e 100644
> --- a/drivers/reboot-mode/reboot-mode-uclass.c
> +++ b/drivers/reboot-mode/reboot-mode-uclass.c
> @@ -9,6 +9,24 @@
>  #include <exports.h>
>  #include <reboot-mode/reboot-mode.h>
>  
> +int dm_reboot_mode_activate(struct udevice *dev, const char *mode)
> +{
> +	struct reboot_mode_ops *ops = reboot_mode_get_ops(dev);
> +	int i;
> +	const struct reboot_mode_uclass_platdata *plat_data =
> +		dev_get_uclass_plat(dev);
> +
> +	if (!ops || !ops->set)
> +		return -ENOSYS;
> +
> +	for (i = 0; i < plat_data->count; i++) {
> +		if (!strcmp(plat_data->modes[i].mode_name, mode))
> +			return ops->set(dev, plat_data->modes[i].mode_id);
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  int dm_reboot_mode_update(struct udevice *dev)
>  {
>  	struct reboot_mode_ops *ops = reboot_mode_get_ops(dev);
> diff --git a/include/reboot-mode/reboot-mode.h b/include/reboot-mode/reboot-mode.h
> index 5fbd7c801af..6510141ff89 100644
> --- a/include/reboot-mode/reboot-mode.h
> +++ b/include/reboot-mode/reboot-mode.h
> @@ -53,4 +53,16 @@ struct reboot_mode_ops {
>   */
>  int dm_reboot_mode_update(struct udevice *dev);
>  
> +/**
> + * dm_reboot_mode_activate() - activate a reboot mode by name
> + *
> + * This will read the given @dev plat_data for a named mode, and write the
> + * magic value for that mode to the device.
> + *
> + * @dev Device to write reboot magic to
> + * @mode name of the mode to lookup for magic value
> + * Return: 0 on success, -ve on error
> + */
> +int dm_reboot_mode_activate(struct udevice *dev, const char *mode);
> +
>  #endif /* REBOOT_MODE_REBOOT_MODE_H__ */
> 

-- 
// Casey (she/her)

