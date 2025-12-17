Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079DCD65C69
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 15:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A45083B32;
	Wed, 17 Dec 2025 16:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TYmNWq5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8B083B7F; Wed, 17 Dec 2025 15:47:26 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2549483B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so151662466b.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765982842; x=1766587642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UtP2kmOemr9hGQDVQhiFwj1QddfJNodVYhE9Su657SM=;
 b=TYmNWq5jai1Qo6BOViehxMebGXy1ypbphtPI2uq+9vUA8rCw7wsvKeFFih2NisBuFm
 RRNANeLV4+STT5m3zWcGly2jZmoAA35bTFxsmRdEdkJLI2qPN0pazlu2luv+exKBDALA
 /9ApXBnL5DwWUqFYnEV+3oBqanY/eZXm7+8nZ/jkge5fM5Pnu/RblCbNdBtHTJMw7a7T
 L+VpevIM6v9LtGXF0SsIYn2Xv8JN2VDvPz1S4l9baGhsUtI85tzpsjkrvvMZINbczpvC
 lQqtHttZVIe3hBu5RanFqCrzfSr5n2xjIvSgoXvzUxDXVuxPGXei7lHrZmja4F1zkWnZ
 ixUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765982842; x=1766587642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtP2kmOemr9hGQDVQhiFwj1QddfJNodVYhE9Su657SM=;
 b=Xi0L3iNwVceRTbvvJLiukp07+qJnY4Va+w/vhuTMywdtwk3nukjaZatGY8y/u6bINA
 oN/pmOIwhLGTXSonD31ZmfEO2/EHiTh09uGV/ogNHCwdJM1/3EiC/zzoxHV4h1WT/Q0X
 U7g04h/NGjRUVpdMPMoVv8eq3e4JfwCPVIkUUst47C+NKCHfEOB3ZhsfBlgswTLHogI7
 BBrelUgJwxqSwS93mmj+E9H/0MpUQOMeqIqz8JSFhLD6tpEpE38c1TBSnEvl9Do9NS5V
 9vAEfiGpcx1C/77ZuXj9e3urtMMnyidIXBuJv6MfNAuQ53KjVVI6y1HV6l9KKvlAl9gd
 js8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF6etL31HYwW+Jhwg45KZjQuPJCK+hJfiwmocgt7A9XislPoJ/nJh4wl+Ud69mqciuunNGhYg=@lists.denx.de
X-Gm-Message-State: AOJu0YwlNtmUGmJ9gU1gPAqJ5aAKbHK5ZPtiO8NWl5Ww+GEtfq5i+mW5
 sjD94MbDVgTfBiCnAHszJTomayMYHXDAUNK/t1jNwomlsQ3ifxPE7vciCAW1NvTQWE0lt9KurIx
 6icfot0KGX91ADfhfiCJ3dO7wGV5BA0qIAF1Rv3dZJ5AQ3mQ4welkWz0=
X-Gm-Gg: AY/fxX7kHuizbp4wcUygYWuLQ0g424iOwDLbmxwi/aH5s6QlBYiXc4NRjxiCatgzysR
 RmIWnuDillwwnP7RCCnPQWx1HRRJjL2qLnRJ5woEnu/2ODcxQin7BIVsGjK5uYbz/FsmfC4hWJ2
 D0UQIfWBy4tyeHU7csCPUrYHwYsuke+gHYrU81sZKLk40e6Cm170PRcAdASYijGp/wr1oeM9gIz
 WGybdLPLLRGCuXyttdJecuht1E6K503wZhJVzv3ZT2Y9f5CtBqOY9eR+DDas1+9utTRtw0=
X-Google-Smtp-Source: AGHT+IFyhIiqDAtWGtIo/16aCv/rbjBmx5rZZLAtWdgrBi8rlgzw1LCM93GcLYiCDsvOmhWlRC3RUhlRlIjEvLMloQE=
X-Received: by 2002:a17:907:1dc7:b0:b7d:266a:772c with SMTP id
 a640c23a62f3a-b7d266aaa99mr1357641366b.21.1765982842431; Wed, 17 Dec 2025
 06:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
In-Reply-To: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
From: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
Date: Wed, 17 Dec 2025 15:47:11 +0100
X-Gm-Features: AQt7F2oU-Nh8xlogbbSBQyi3bxgRtuC9cOIExQHQdYXdGvFOXYfnc0E93I1ak_A
Message-ID: <CA+NB=mZ-FTdpGQkZ0JjT5MnhbLUfX60-gOj8MNgYOhfp9jV2CA@mail.gmail.com>
Subject: Re: [PATCH] doc: pytest: fix typo in multiple config options example
 for buildconfigspec
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 17 Dec 2025 16:45:11 +0100
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

On Wed, 17 Dec 2025 at 15:02, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The option should be 'net_lwip' and not 'net lwip' (see all usage of it
> in the test code base).
>
> Fixes: 2bac578c5aba ("test: allow multiple config options in buildconfigspec")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/develop/pytest/usage.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
