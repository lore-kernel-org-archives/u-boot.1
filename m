Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4C8C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02467806D8;
	Thu, 27 Mar 2025 16:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZpEU87hU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9048070C; Thu, 27 Mar 2025 16:20:00 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516AB805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so599662f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743088798; x=1743693598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M+BhzJ144V2PNazl+Kgh/j+N2fFkExxpSdJR3OpPrxo=;
 b=ZpEU87hUCv2eg/Zu4b19qfbvK9j9NZ1S7ahoLQD7we8Fnk372M6f6NvdPyYIr0+e6l
 KlCGQMpULTNmaQrb0ySOQlGsNO82nvaGJiSdnCJHinlA32W8CkjloLcrbjzUYFECs5yk
 E98sMQnrcXIU77aY/TTYO1EQaMC7l22OHRanHQAtz3Ps8UDBXbd5tn7pSfv4Kfd0zDdS
 tQHkUG5RoA+oz3ziavtBjyjYee3I8jbxwRZr+mDVVEzhogFICU3t7NaugOPwlIiW3+2Q
 zvH+B0KEfoIslbpWUZAHYkl8SFKLT1JRemFk3f4je00LJEV7wKWaQRKSffPupIXxFiBd
 wk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743088798; x=1743693598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+BhzJ144V2PNazl+Kgh/j+N2fFkExxpSdJR3OpPrxo=;
 b=fVmFeoBb0TsLpnpjrSbFUfPklUyDxZUS4ScyHZv5PGt8pt/sHEiM802rO7rHK9JjkE
 dRt6N87v4nP0dLet5e0X7hSAhh7YBdBRws5cUMj+uxeYgVYgmF6zkKEtg/bYZ0bv1d+R
 4zS+5bwPzxQvxudXD2xNnh6b0RM1xFwoW3JiPnI/JVJSQQttAogFGHVTNsdHBLPCfg6E
 D2OmuMX7e8S3Tx34gbjvFuU0gTkjpkRRSKwbKlZEf0NabUKVmOzYqziylFioWCvebwzl
 rX+Y8rD2jPtl9PhrZ+vRcd3Qhu0Qpt/NDYrKRIgMC/P+JCPYi0+HvbAQgl5v+I+PUcq5
 c8Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyBZYFQWoBEpSD6uM5iLRZZ9biFboQo/Xsm2VLg+f+A/swSQ3dbQPOo4vgLjq7u5BPvuA8xVg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjw9bmSe2YnsdKYgWlJVrfcMGgLoqS5RM3SMOZ9rOpwBt6hVqU
 zEAnUiB0x9HEkC7H4DNH9TiT98e08K1x51JD7mTA5FRgMkKwEvSsvPoFKZNeLKo=
X-Gm-Gg: ASbGncviIwzDYkRAy5TVS3zzJWfWU+Lxg2xlcUSHy1GL4sEgII4j1mQy4Jc/+nQ+yZ4
 cE3tmWABQRmHCRuS8CaGCqOquPM8+di3bv7JXL9E3WmiZJPtDm/9aoY9FccZaUmQfmgjurVHqRE
 a9rbX/cyXBNNV8m3BRquyU/OrRizWCL65m6DwzuNYDd08l/JCxfUKbe2rqrQKEig4U3DK3Tyioz
 Tj/Ucq8k1+D25GCsTti+pYU5dAwyC7lLpb6BYbkgp6IN1o5GlIZAKRetfcMggg7MC85TktQEQ1W
 c7mK1xm/2CTUj+VAV6HxsLoTvEfOoBI2Aj6NOXijoYBwYF2PWRvziKowoG/ZEPS4zYkV7vNejcK
 Lx/oaYd7F4A==
X-Google-Smtp-Source: AGHT+IFA3AzXv9yUt7JTPzK3HCLnUSVLjB/afymekXlY9294a8EyHvkJFFEH+rsqFsfmc+MddcRN2Q==
X-Received: by 2002:a05:6000:1447:b0:391:30f0:1704 with SMTP id
 ffacd0b85a97d-39ad173facfmr3316355f8f.4.1743088797705; 
 Thu, 27 Mar 2025 08:19:57 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39bedeb82c1sm1321854f8f.3.2025.03.27.08.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 08:19:56 -0700 (PDT)
Message-ID: <8182f876-6916-4ad0-a360-bd18e9f737b7@linaro.org>
Date: Thu, 27 Mar 2025 16:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/29] video: Use a local mode_info struct in the EFI
 driver
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-4-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-4-sjg@chromium.org>
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



On 2/15/25 04:22, Simon Glass wrote:
> There is no need to use the global struct provided by PCI. Declare a
> local structure instead, so this can be used on ARM without including
> support for PCI ROMs.

Honestly this solution is so obvious I assumed it wouldn't work when I 
was hacking on this stuff heh
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

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

