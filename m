Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7EDC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 14:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EECC83F7D;
	Mon,  4 Aug 2025 16:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dpyBgJym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A3B83F7E; Mon,  4 Aug 2025 16:15:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC9983F7B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 16:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso5080295e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754316954; x=1754921754; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0er6ACDfQmR/FgIgcm0Ne3oncNIr54fc4FXT1qwdDAg=;
 b=dpyBgJymKR6TAraCVunMEQpXfrtIpramb16jVBGMLNvUBAmAzhCIODikc8oOqFKnyY
 k5xkYvOzUi13Wxct2JqiwkvN16x3Q4OWDSHlb+RlSMEwI4ytGb8ftLdBsWMldQj0Kl6d
 k7oC2JdT74Y+8ThKzXDk7OBMn4lH3K4CfqYqQFjCyy9bb27gaCYDEuwIRNSbPKyjJRmm
 8zrFZcL+1nYkwWHMYaS2vyQxd02RXN8m7GoPkPXSQ+ZVyfWASmDiuOT12u0rBqi+3UC/
 j+vL5QlpWAzI+Vt6umT4/dfH2KmknHN6C7KYka5hZ31TAfg8UI7rLxg4LHarcxWOSPm6
 /ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754316954; x=1754921754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0er6ACDfQmR/FgIgcm0Ne3oncNIr54fc4FXT1qwdDAg=;
 b=DyUhU98RajI8JspBgmXuUwlUcTzzDYDQx+1LL8EDq9gQ6f0Y6F8uWahfFPxzIHEA3/
 8rM3/VfdDsTGP2mxINt+LY+UcG0D11PQ4Q/VbZfM4Lhy2xYSrbRdmXABGQZ6OqXpC7u/
 uGs3H/LjYioDMlmYn089LgM1bq5vLbkXrzqv3HZBVdayAcUuYfW0WhySA3AqWdyU5po7
 r3KO71JAADA+Qt7dTuo/f4dQCcQVVlhxfDb++pz2tZk5GzNPcp6nAofFmITARQ3hpogH
 wuYXqe1bnWFRJMiHMI/212GC3HwG89bcg8ySu+w5A1YVnhoRzzt/gQ2LOpTEbeA2CQnc
 SsnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmwD6QCu/1DgAFRkZ07FD+CgkxroTfG2KFjahxmgsbt6mdz0sp9LTewlmZBUVvD12QWHsTGys=@lists.denx.de
X-Gm-Message-State: AOJu0YzAHLqmIfDBSXhi0bikBtu68sehUP4nC2reJ6luLyCExIE7lKCu
 bvouryg1Dj5GQrITGhL8gtjpnNxX5Ku6owtw2sMyVSKtHnSFVMeFoTYW6Vq+VpsXlOE=
X-Gm-Gg: ASbGnctJd+NssL5t4RIvbhDGxQzw+C+UY8o48DfEkV/vZ/WWV0hPvP5M66uFCYsppOI
 OENDmNbpHuzLjuqd81kFpqYwp+P2CMvW5G/jMhhjFCZPjARdQD/2PhidnMejiWjkUKKt/Y9H2Lf
 Cv2B/C31GkUcpzFjZwp7TrsAJ4eZaelZDc13nD7kD8Fw0M1oY/F+Fhg+ZqPzU0b6Ilx8RGmosSv
 YDKzNYISDWupcdxBD3Q1xLxLERjcD7/LNmGdYkAS/b7G4d6sCYbJQTQwT4pprrGudqKQIP6C8Ml
 aGLrJc3q9NkJbuWa552X6V3XRV7lvN1hpPRpxT977Ri65T/bIDOjaIEfh8VhDdCzR6KyrrG8RLg
 d37iFZdcjlRbjyMpZHkFv6NdenM+L8dlKavR/B1TwXLismBNhATRpP72XTmbaAxvS07RmKWSYY3
 OrwlkcYmiWzzrp
X-Google-Smtp-Source: AGHT+IGLlwdRiXQwLjzplYB8HBlXNgddPN9WBB6tGVod6QsjYpqaasRe1GItcyJjlF5Th5Y9d0pN+w==
X-Received: by 2002:a05:600c:a30c:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-458a222c260mr108925385e9.10.1754316953978; 
 Mon, 04 Aug 2025 07:15:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948?
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536acc9sm215884905e9.6.2025.08.04.07.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 07:15:53 -0700 (PDT)
Message-ID: <2cd6f80f-310a-4f8c-8089-4e9abd1bd04b@linaro.org>
Date: Mon, 4 Aug 2025 15:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/mtd/ubispl/ubispl.c: limit copy size
To: Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, John Ogness <john.ogness@linutronix.de>
References: <d34b63c9-4fd1-46fd-a984-a22cc0dd3e0c@linaro.org>
 <20250804133736.21846-1-b.spranger@linutronix.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250804133736.21846-1-b.spranger@linutronix.de>
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

On 04/08/2025 14:37, Benedikt Spranger wrote:
> The fastmap VID header is embedded in struct ubi_scan_info. During fastmap
> scan, the header is copied into struct ubi_scan_info, if valid. The former
> code mixed up the amount of copied bytes and copied more bytes than
> nessesary. This had no side effect, since the affected struct members are
> uninitialized at that point and overwritten later.
> 
> Limit the copied bytes to the VID header size.
> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/mtd/ubispl/ubispl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
> index 9face5fae15..0143caa051d 100644
> --- a/drivers/mtd/ubispl/ubispl.c
> +++ b/drivers/mtd/ubispl/ubispl.c
> @@ -779,7 +779,7 @@ static int ubi_scan_fastmap(struct ubi_scan_info *ubi,
>   		 * that already so we merily copy it over.
>   		 */
>   		if (pnum == fm_anchor)
> -			memcpy(vh, ubi->blockinfo + pnum, sizeof(*fm));
> +			memcpy(vh, ubi->blockinfo + pnum, sizeof(*vh));
>   
>   		if (i == 0) {
>   			if (be32_to_cpu(vh->vol_id) != UBI_FM_SB_VOLUME_ID) {

Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>
