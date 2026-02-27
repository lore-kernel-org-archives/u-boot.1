Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BDFD5304
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 07:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEDA83AA9;
	Fri, 27 Feb 2026 08:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tC35LyoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E1083BB1; Fri, 27 Feb 2026 08:07:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81DC83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3DE3C3F85D
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772176073;
 bh=y1zsC/UmjuQ/ss/4ykSlWi4v+mSZN5BdPkUGxxFA+Uk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tC35LyoOOW/eD3ArNw6Z6aXoGl9YiO3brftzTIeg0zYXDjU4qFb6PRWxLhxJJR3AA
 JzNI+Vd3EoXoVS9dRsla/xdDJ13f1rLyFybpk7VbURE9t94c074TWRgD1YaRA5KCaR
 Nlqu4Mhh40j0Ac+24rX0J/l4aRk1g78rsrYgW6I11kYOYz5eV6SNb4F5RbcNWDGWRL
 nLeorCMva76n/Pxwpgfdj7R13j5iO1PbWvdIGRgzjrGX9x+4APr1qZJX3HgYuVtO2O
 xp/Eh+cF8SqlRh5QwU5quE+jzhfHOQyqCej7FDZqCTxEXVk3cYX2epp/xSv/pVAwPb
 O9zcGsZMjpJlg9sFXzOYRVwj8S3kxoikg3r+/oejJlOj36XP+R6NCNbPUR95mR1oNb
 t7JqbTgslPtzDZRxw68a+IFYGsM8KIhD1AKInA4Tt/CZZsBF/jqLNuD7A2RUOxDlP7
 FEKlNdvQsfkG9cYr4IUQyI+Jua9L+PhMN91NK3gWGm7iy887Tab0UZAtiPsDHmxiuG
 1TKvqearv/bRgdMIyiCMWUCHU8bKUPTvfQqMa2Nm6wrzLBbkWvpRVNOWtSx0vsP++s
 stDR5rg45Nqk3A7vO+/jCQ2DsbY7zQT32i3WvsOZYoLv7GukmckTG1IwL32XbjoB1u
 WigFy061WLElZrUdzT1Kk8nE=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48071615686so11809385e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 23:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772176073; x=1772780873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1zsC/UmjuQ/ss/4ykSlWi4v+mSZN5BdPkUGxxFA+Uk=;
 b=R7+bVCVbQD19ha3mzGeVdmRDHtymqccMxKNROInOXGWhW55cULaQj8lfNmwzihrNCk
 75Edd30wQn/fE7d+vO8oVNLdcoOwC7UqpdnRgnyXFw1r0n6yxso8Qm9kI9NZXlD2pNmK
 7agZPqlBJezLyuKGs1aX7qg8Xmfig3cH67BqP+bXlgqvxhP/rDeK6cFmNEYJmS6AFRD7
 O42N9TH0N0o/15mCtmTelwHcC+ysSqXkr7UiybfdT+eygfAYnKUUFLBnd85FWzHGb+lW
 I1zN1+A/3MJ1WUuz2klzcMTHSLvmOLL8SMGH1GSW+kjhpPlOcbmk78yS18NATtcrBHYK
 rh4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjqQ33/mTju9DU4/quVCBBWQuw7qcCGgXZ/4B3hMB2ha2kcf62jiB3O23OxpJXh3rfrLbByGw=@lists.denx.de
X-Gm-Message-State: AOJu0YwD3UbDkr3qaYoVh3WpN9xleYzYnx7nBIQD8Di5aP3thYZhzLAY
 uCMs2d17gV+Y9BetSYfanHkivkh/hKQ6nT8YIjBsl0VRqiZQ32+NA//rpoGh8iJ4GcNve+rcWKU
 O6OQqt03J4jfTBHifK4CltDWq/ZumLU9g5A72nCt+KicrmQB6w1rLpsIsX21+6Ty9xHL2T6c=
X-Gm-Gg: ATEYQzxFepl8EX67sERYNn+EOnDboASQ/2n2K95v0yMIVh65lgrVncf7EyJLhUDix/6
 TvicaHJHahJTWNTLAQPlJ8D+uOq8rjNfe50F4kkdQkce7/u9KwYPF/XpSZSfFHvw77/496YSi9l
 wj3u8hRM7K3n5/uInCV/mCTsWslopgNLwVDIFltp/hz/fJ0aQ20LwPwOA4VEJ3eu6lvpeWUrIE5
 5pZqvyquzakYANJ60tuVk2XvYgfmUynEEBYSJdhIl+JHuT9tee0YZ3Pv3Nq61ez4fXCJ0kmHsH6
 icl9uXJpTqK9gXHI8h5f1s3ZBBmXwAsi2FWqx2dKwzffLPUEbLAX/+arrqBf+lXLcwcSrN7nOvR
 OQfPhq9skxbgV/uzLdnQ+4GNdFD25KpEgghO8ps31QK1CvZY1zdzUr4GAtC3757Bw36vUbpvfC8
 6XTaOUnMoQ0xDhA0ZiRKdy+XqxqFCn7kdRsXLRHirpSeLsJvR3nQo=
X-Received: by 2002:a05:600c:8289:b0:483:6a8d:b2fc with SMTP id
 5b1f17b1804b1-483c9babda5mr23412255e9.8.1772176072682; 
 Thu, 26 Feb 2026 23:07:52 -0800 (PST)
X-Received: by 2002:a05:600c:8289:b0:483:6a8d:b2fc with SMTP id
 5b1f17b1804b1-483c9babda5mr23411895e9.8.1772176072268; 
 Thu, 26 Feb 2026 23:07:52 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm134610065e9.0.2026.02.26.23.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 23:07:51 -0800 (PST)
Message-ID: <07592347-7a35-43e5-bc05-4afb0bcdd3c3@canonical.com>
Date: Fri, 27 Feb 2026 08:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] doc: pstore: fix typo
To: Aristo Chen <jj251510319013@gmail.com>
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.denx.de
References: <20260220031841.15708-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260220031841.15708-1-aristo.chen@canonical.com>
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

On 2/20/26 04:18, Aristo Chen wrote:
> Use "parameters have been set" for correct grammar in the pstore
> documentation.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   doc/usage/cmd/pstore.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
> index 63a437135ec..fd3425a1dc2 100644
> --- a/doc/usage/cmd/pstore.rst
> +++ b/doc/usage/cmd/pstore.rst
> @@ -80,7 +80,7 @@ For test purpose, you can generate a kernel crash by setting reboot timeout to
>   Retrieve logs in U-Boot
>   ~~~~~~~~~~~~~~~~~~~~~~~
>   
> -First of all, unless PStore parameters as been set during U-Boot configuration
> +First of all, unless PStore parameters have been set during U-Boot configuration
>   and match kernel ramoops parameters, it needs to be set using 'pstore set', e.g.::

Thank you for the patch.

Could you, please, fix this too:
%s/it needs/they need/

Best regards

Heinrich

>   
>       => pstore set 0x30000000 0x100000 0x2000 0x2000

