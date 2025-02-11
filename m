Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E1C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 20:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6F0809D0;
	Tue, 11 Feb 2025 21:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ra+zuLbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E876380B9C; Tue, 11 Feb 2025 21:55:33 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAAD180842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 21:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5de74599749so4309788a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739307331; x=1739912131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpGUGyh2J2phj9dI85TQsXjjneNi582JwksDTK2/d3E=;
 b=ra+zuLbvAXcB/VMCbxXmqPBy6rEmOKmPmITyXsKJ4eT2XPxpPJLJfK/J7T0DyW8F5u
 EDr9y1xr/QYYnt+LycAf6VH/qFq8391gl8cegvU9JGMBxf7yufRTmCqC5Bpb42Vs4GwG
 GJK+50rZSLPAub+YYqvBcTBtHTqb316wEJ1S6Iu1EJmAzk6tXwnx0uSvkXlvKKqX2rOZ
 q8jQcxe4nnbaOLxQRSSX1T7Ln2fCEHPkZ5LOAJshPj+v98pcIJWvXhUqn71ZbGdukWWp
 huSHUfuaoqYtlSa/JdOP/vb4/J5j8sUIHbNSGH8hafrEZJBdEffhP0Z/Y13lf5kNW0Bk
 suhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739307331; x=1739912131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpGUGyh2J2phj9dI85TQsXjjneNi582JwksDTK2/d3E=;
 b=jq9C5vquFqDmrzTshJsL55onSzF2OzhWERJOQckBsetTEAbAQDk1I7kD57bkZ9K2sr
 32kdyM9P059MvJuxz2Wurs9uAg1HH7DRTzPE0GJ0rLXr6jG8QEIZNwPdhCQGxAr+GOCq
 DJV3oTP1Oxu7USsXkwqBunhu9x2Uq9OeyPUeiH3WDFRj1K1ddxBw5TirMzMVcvxip7Y+
 Oy8bSctTy4H37SB1UwC0Ct3sATTLhAOlXMYuu7U8ybK+DUXHl8BQeTRm37J8/B23Z6MS
 o31oHK6o1Fe4sZhUjBnQ15gbSx+dKTktJ4LeGS25i/G0Kjb7VFSODt+KixfntoO3bTlS
 WcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdN050ZYHUrM8yoqSRblgAYSYyEx+PUgBIazz92cv7WcqhGRuZxvB7KbBuVk5cRaEIbOkZtOo=@lists.denx.de
X-Gm-Message-State: AOJu0YwsfcMNvz02VAL2Zb5vNFhR7YHoE4wPVGkXPy2yJeeodobkIZwC
 tI29WilsIqMZvdRfkCxwDn6MuvIy162GXrHRSCWb6rHVchFkoPrdXiCoa6qXEBE=
X-Gm-Gg: ASbGncuqfzbeU6Xt2Diq3UaNAxom2QF3XLUH7P3uNB6dKchKbJjQBxEn7NFsOiUSbRC
 0nvICc8zqNhFTOGg5aiB9wa7uwdtu/OdrP4KCF5YVXlHA0wIanomiGB8HXAi6kc5QDNz2rsdUPh
 1Pss30KDTUr0x73cMMP795pRJxAx4sGI9p92wiSTB9FfrlxTdgvlxd7FB1MwAGSihX/nirrxP5/
 xs6I15Ov4xSIyBO3sF2wvfUfAtNLNT9DH21R2HEEmV7TTuhnCMCaT+YJ+67GIdZ3MEAiGgNvWNP
 6llPoj+eugeTjuJuvz39yn8f/bpFD0Hcq3W3mURJzgD2zmHUmJgRZpt22Fti6/jIg3e/Mg==
X-Google-Smtp-Source: AGHT+IEsHJ4dnsXKiGbCbz4UUtjRe7L2zsRJIdMk6rrKgSK3rs4mB9GTNoZJcl/mEDDGuULXx6lhEw==
X-Received: by 2002:a05:6402:34d2:b0:5d0:bcdd:ffa1 with SMTP id
 4fb4d7f45d1cf-5deadd72192mr668667a12.2.1739307329652; 
 Tue, 11 Feb 2025 12:55:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d?
 ([2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de61657531sm6767914a12.52.2025.02.11.12.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 12:55:28 -0800 (PST)
Message-ID: <04bd7097-975d-4981-b04c-54fcfcf576f9@linaro.org>
Date: Tue, 11 Feb 2025 20:55:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] video: Use a local mode_info struct in the EFI
 driver
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-4-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250209020136.4108987-4-sjg@chromium.org>
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



On 2/9/25 02:01, Simon Glass wrote:
> There is no need to use the global struct provided by PCI. Declare a
> local structure instead, so this can be used on ARM without including
> support for PCI ROMs.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

This one really threw me when I first hit it :D I like this fix.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

> ---
> 
> (no changes since v1)
> 
>   drivers/video/efi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/efi.c b/drivers/video/efi.c
> index a7b6d47f9a1..94d4c93dac3 100644
> --- a/drivers/video/efi.c
> +++ b/drivers/video/efi.c
> @@ -183,6 +183,7 @@ static int efi_video_probe(struct udevice *dev)
>   {
>   	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
>   	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct vesa_state mode_info;
>   	struct vesa_mode_info *vesa = &mode_info.vesa;
>   	u64 fb;
>   	int ret;

-- 
Caleb (they/them)

