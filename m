Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8369BC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 20:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9762784C39;
	Wed,  1 Jul 2026 22:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lW1Ipa8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DDB84C3D; Wed,  1 Jul 2026 22:44:18 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AB584B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 22:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so9853595e9.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782938655; x=1783543455; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJT5v2y7eUYSYd4KSk4BJMvbKPDR03HN8u0M5P7RK94=;
 b=lW1Ipa8ZUK9/KsX8piC9ovMoR7C0273bclF/C82O1sAZm3I9YMAYilRfPNvO3r/js6
 Fs8t6eBQOO5PH8tgFDmbjnCEVBcruxaSGPnEN30+duwBkSXBJm9eE5lSFFaC7ipt0rNA
 QMKoEdId7l8nzo44/SZtnjBtQmvS16WPxo1W+sn16PF/evLC6ckMwgRqBKUJE1qsjDHw
 3SSpB2Z+55rvC20T7Vj5T8AkqHXYsiq400mzPowi297y9OS3pEnPUM1VtJaF+eXPw9KC
 sQ8pMa+wkQKBiQBD4hCnvgiE5m5w8uRJnMHBBqzBEYi9ioydl0UIzYcu/LTKP6Q8P2zu
 ncnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782938655; x=1783543455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJT5v2y7eUYSYd4KSk4BJMvbKPDR03HN8u0M5P7RK94=;
 b=tQiCkus0MPhlJTt5yMWZGtLM3HNFEPoSfeY3n+prZvzVFyolr7yKlKUxh9MUksP7Jx
 n33S3Os9djfgR42Ac8N2hkBjYWHgiHy45VA5aK5MDIHa1266j4Zh6iZ2H4ZTiOqhKzeo
 hn2IgidH9TbyDUZXQdHYfTpEJh+xgA9AvObeJbBfCSQpCI7tvSBosx9i/e/3wXBCpyFU
 f+6BVH2CtbnEO0iucMDJ28M99/CKFEBvWIySyq2/5Tbyr+TE3CX5C6hGl6X8yhg3Spti
 UW2195TVMvTJ5DIQrQfWTa5/LuCy/j6abcHLiItzWsQ957ofBMbxWsQ8Spam5rXkgu6F
 uTcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dluert2Zcwypk4OHNZkg10GeLjZ3o5fNmANLUcMNusBDWTg49AYVWjbRUwOD/f98ZPty/f3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxayKkF/QBWCWyArRLulnIuoy//+4l4w8Viy/3K2Zv/WqHAjdGX
 hn4Zyk4lUt/wsPniZqPHyt3w6mjiBaoVrD0qiMEt8+DLi+X71trMl4kSxygA349hhnw=
X-Gm-Gg: AfdE7clRYQlHU3vj5TScLpu6iwDyaV7ZVDrdJcnSAA8dW+t1HpINKVInD/fS3oYSX/O
 QRhb0ilVLELVEWh8ol09MntNclsXz6dnb12jWbqsyR1G0ebZFD6Tw6jrmgBcaAqF80KAoYqGiKW
 sUz2CNymd4uVlSOu4wZ7uv8gWOfEMr8kovjfruaGZw7Y101viA+1JoFGOB+OKZt7zrvqgWl2vwz
 mMEHVc53gJxJvKbAYvCVhFFAZJzygoTp+9k4a5ngtOWOtdcxW4lffZGqZKaALOA/OY91Gc6RXZ+
 RUl2ePseHdL3FBI0N6aoUQh3iAi1Qj6Gn3G9BvlTvuLs3si1mvOWERCDYnBycZyKHP0WGGoG3WQ
 YMWDZcH48MOl3YVZkSLu9/RBuXNfkVcoPU+PZoS9V2kJXL3RqZ/MTYiK5IjVbEcX3HcMkajRiYT
 E0QRFBUZdjqA1/CmdnvQiJn00MW8Bg0D3vyyAunsF/IZfbGpsJEyeEwUHrzIYFvTQ=
X-Received: by 2002:a05:600c:828d:b0:493:bf86:85c5 with SMTP id
 5b1f17b1804b1-493c3df3495mr33193685e9.36.1782938655594; 
 Wed, 01 Jul 2026 13:44:15 -0700 (PDT)
Received: from [172.18.178.88] (ip-185-104-138-128.ptr.icomera.net.
 [185.104.138.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0fb15sm2181116f8f.29.2026.07.01.13.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 13:44:14 -0700 (PDT)
Message-ID: <6368ec86-04d2-4c07-9841-0a16be606181@linaro.org>
Date: Wed, 1 Jul 2026 22:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: qualcomm: Add secure boot config fragment
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nicolas Dechesne <ndechesn@quicinc.com>
References: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Aswin,

Excited to see some interest from Qualcomm in enabling secureboot, but 
there's some issues here we need to discuss.

On 7/1/26 14:22, Aswin Murugan wrote:
> Add a common configuration fragment for EFI Secure Boot and the
> required hash algorithm configs to reuse across Qualcomm boards.

How is this meant to be used? what other steps are required to 
successfully boot this way? How are you testing this or expecting it to 
be used?

This fragment alone won't actually make booting "secure" since the 
console is still enabled along with all the non-EFI boot methods.

So what's the story here? Please give us some insight into the bigger 
picture, propose some ideas or plans for implementing a full secureboot 
chain, ping me or Neil or Ilias on IRC about it or at least offer enough 
context here so that we can discuss on list.

Sending random patches isn't gonna cut it and I'm not gonna just keep 
guessing what you're trying to achieve with a given patch or series like 
this. You need to engage with upstream and work with the rest of the 
community to figure out how your goals fit into the bigger picture 
(hint: why is this under board/qualcomm/ and not configs/?).

Thanks,
// Casey

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   board/qualcomm/secure-boot.config | 6 ++++++
>   1 file changed, 6 insertions(+)
>   create mode 100644 board/qualcomm/secure-boot.config
> 
> diff --git a/board/qualcomm/secure-boot.config b/board/qualcomm/secure-boot.config
> new file mode 100644
> index 00000000000..21f567e1a45
> --- /dev/null
> +++ b/board/qualcomm/secure-boot.config
> @@ -0,0 +1,6 @@
> +# Enables EFI Secure Boot support
> +CONFIG_EFI_VARIABLES_PRESEED=y
> +CONFIG_EFI_SECURE_BOOT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_SHA512=y
> +CONFIG_SHA384=y

