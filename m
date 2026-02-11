Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB0E9E311
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12C7D83A47;
	Wed, 11 Feb 2026 16:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LRIe6DkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA6483B30; Wed, 11 Feb 2026 16:07:24 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD60883015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7962119ff2bso55707677b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770822440; cv=none;
 d=google.com; s=arc-20240605;
 b=hB36XCfqqTzHg11jGaBw0Exd7/MN0zq8gc99r9S0dkWOBeaGp06095Gqw15DB3qPQG
 r/0Se+mlYHh428TnhKZRMoZt1HMvQMgNwtvudSODX+sWo1/EWd+2+wOz6LUiUXat0gR2
 4290NX8ltXbfHHX0SzYDMp4KDeamY8F5XStGhrqCnk+eYLqyVJ5560wP3mfDLaXfcPHK
 /nF2cEXLQXLUSFSE1+YxlpO72wJ9Slo2Gop3qSOullX2rSIGtayx0e9PcN68xEKHyeNq
 f/UpMsSevj2PvmbHMa2O5wJdX3ZoL6Xb4pfc+0k+2AsYkmcDhaVD2MVFXk9KEIA+2aCj
 M6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VTuwixV1pZJ/4Uqo5BgUgwxUiKPMgqDJyRte6Njnbtc=;
 fh=wrhZen22MtbkREBrqvGymwuHbf+JYQB1yPUxtoA5vm8=;
 b=LE9EvNJzMvNcUHp6Pa8uHZaByGPKGOjnc59FsLo5svSuZRSwGfFJyUCnSTekyoZv+K
 eI/QbdQJVtlrey9kqbO355z5oz8xGok2qKoFSWLfbdgbO6mwGOwQH57hkhlAod5mU/fs
 0SNMpDE8yFwqh9XrcLDNS3TfatAF2mHc05I4pT89/fiUZ4jS5EVHizNMmh775RQ7C2CN
 U1lWn/N9kUje2nryn1FzQamc7t2lTE9AHZnq7+Fb98fIyc3BS+eALUB8MT12QUfvkpGU
 vFzdIIT2dUAqzHqRlm6OKvndJ3A595LOjDuAIlFIl7EfxP1uqofqo+tsisyPj/H6EbYy
 mRJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770822440; x=1771427240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VTuwixV1pZJ/4Uqo5BgUgwxUiKPMgqDJyRte6Njnbtc=;
 b=LRIe6DkJoNxbMn/J5Kiip4ccQ5jVWHArF/s6qIcCTIsfxcpE2GbZXWIdo07L9Hr26s
 p3rkFuu56q/NDzdEdvHlH4rXaczqwYB7+y3qgkB11UlzvWPSLHsy53tx8aREr292iZgu
 Gsd7VigFTu18ajcx8J9jaA19OwoLx/Wqp/51F3xwKHVV69tQ8Gvqc2pi80u7a0n2GyNt
 ZbwcBeHjLmggVGcDvgI9JmtP9X9JLUmt1uZwJWmrBhKHuSGYPKHSb3kKN/WICBW2LBoF
 Yw0rCTRYGu5VV3puw9H+C0/klELpR9s++62Kw6lUpzPcmUkeI+0MB6wZ81TU5AvlTYuu
 dHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770822440; x=1771427240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTuwixV1pZJ/4Uqo5BgUgwxUiKPMgqDJyRte6Njnbtc=;
 b=BfBP4zt/Yq3HU82uAQUcqckLYPO9mUAg+urpprdK+gVmwWNqH9bElDjeCcZ1soRoSP
 ZZTD5O5DrzMHdh4bb8oaUBS0EpqncPPOXFRnUMjY46HdshNHb3kj1bqgTKtuhkzZkg/U
 mV1kWLi3NsXDc58Ch4CDn7SYVzmsfJAh5XFRIQlU9i5+Nu8JKGf99nw6Xo97jNGI0bnH
 QX/Q4lWhWa5SNzmQscRucGJC4OCybtW3ECOjWeuw0xPp8/KHdStRqIeJXuwk+UvADMYx
 OehimuFY7Vq7/dW+THaMZyFn1xycHWi90kIqTHyw8DSRLtcO2qY8ipGBw9BrdW89p4fY
 5SDw==
X-Gm-Message-State: AOJu0Yx6cSB85X/RtUpQ7qELxLQTduMSnTrgAjkvZeRlmNMKcZwRw2JI
 CXwrXvQ6R0Zy0idsqudnc+xvJTNrGTj3o6XO4v/jE8bEYcfFYrMsmfYPdeNBIbKvY2gi8CvE8YQ
 5EfqTg4NEw+A7FDOr3PGISDj5YO2ffubPQ9R85NMxWw==
X-Gm-Gg: AZuq6aIWuGZw1HImNgNfGrvwo6j9nKZvY9u/wrwarBFAarFWZEXPNP+F5E9TvynMl9p
 qit3LGoIQ1A4Bt4wyOrmk+WRfTjvj7zjeEsWQXrdwJzT/dwKQ+MOWuI7E083wGEGX8vinMf6GdJ
 7o9bsf8ifr1JErbd2GlKG0DdkVPOXq6neNo/tMJimvRYh5T1QSS2P1GAbZw3yKIFoq9sLY9VQPV
 qxPhJiBnia784cn0S/HlECPh0MJyHtNHJJtnlAJIJUsQQkLza2fX4naUYIXATKEnCst0B4QiUC3
 YwJ2pVi3c9FhdLhKSoRLlHSwIh4v4yARLaDfSPZehQpqmU4m+VgfyTMjmGFXjQfGsVCuATI+dNS
 HOiDwWAe9vbKn360Sbrkw4OiAO12oihCCVMsMPb/GxobD47BUivAGADlTUw/vGrqeUNA/ZGA2oO
 FVdcNzkZAkMuqKlzodAjHNeuoKb1nacvXSUZjqoptbn6ao5MzEOEyOgFsPWL2wy5kCbK9NO2QAo
 BWa/F+TGrhBBKb9yPiv+cOx+U/mup7aGwpbbCCtDWPU+jjnL5i/bLF3ZsdeOn7ULtIC+Q8ZgOjj
 bXbnc+lm98xMd5w21bGhotJUPcdVjeuZQQQ3GsjdYRkg
X-Received: by 2002:a05:690c:f95:b0:796:d680:7b86 with SMTP id
 00721157ae682-796d680877fmr4599017b3.5.1770822439676; Wed, 11 Feb 2026
 07:07:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <f56553cd519b768f8febba0b8d807de3cad14739.1770119483.git.michal.simek@amd.com>
In-Reply-To: <f56553cd519b768f8febba0b8d807de3cad14739.1770119483.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:06:43 +0200
X-Gm-Features: AZwV_QglbitNS8u3VqKjY4JHNlZVkaVYU-3q-rDhp73o0aQ6ymMomm-v2x8PR_I
Message-ID: <CAC_iWjLHCPVDTTqV9F8NiaLGkV_PP3M9OPC3dDzozSEk6FRFTQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] efi_var: Unify read/write access helper function
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Michal

Since you'll have to send a v8 a few nits.


[...]


>  }
>
>  /**
> - * efi_var_to_file() - save non-volatile variables as file
> + * efi_var_to_storage() - save non-volatile variables as file

it's not 'as file' anymore right?

>   *
>   * File ubootefi.var is created on the EFI system partion.

And this needs an update "If they are stored to file..." etc

>   *
>   * Return:     status code
>   */
> -efi_status_t efi_var_to_file(void)
> +efi_status_t efi_var_to_storage(void)
>  {
>         efi_status_t ret;
>         struct efi_var_file *buf;
> @@ -85,7 +85,7 @@ out:
>  }
>
>  /**
> - * efi_var_from_file() - read variables from file
> + * efi_var_from_storage() - read variables from file

same here

>   *
>   * File ubootefi.var is read from the EFI system partitions and the variables
>   * stored in the file are created.

and here

[...]

You can keep the r-b tags, as it's just comment updates


Thanks
/Ilias
