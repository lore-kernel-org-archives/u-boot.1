Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3005C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 16:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151EF887F6;
	Sat, 20 Jul 2024 18:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0xFuPvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A64887FE; Sat, 20 Jul 2024 18:19:57 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C62886AF
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-79f178e62d1so172237185a.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721492394; x=1722097194; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PeloQCrFcAA8+vUy7W9gWutJf0/0rKiqNceBvdl7Eo8=;
 b=G0xFuPvN/7D5orSCQvy+6NY5lo5JUMDw2K2bQMade/6CmzV8AIELNrEM98t66d+gRA
 RoB2ybx5Zmr8zRUdcoM9kGnXe8cdWfHi+r3a9I+M58NhnQJyfLuOF9Nxb59avzr4Tpis
 heblWZi3qX8kmpC79dDBlUN9sMuXXGVrTYXQHK/8kk2luHwzMW3fINac34Qo6oYrXHNx
 J3UYN1I2oBRNcUd+qHtx0rdU4kgVSudQom98etFzkQrB3ZDGt/VlDUmMtlWZcN6i/jX0
 fQvtyPKrVkWalNi196po1sebYpjRFcFWCHpQ5vTeL5n4+vjiJq/LukH1W3y9/p+Yos/c
 hY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721492394; x=1722097194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PeloQCrFcAA8+vUy7W9gWutJf0/0rKiqNceBvdl7Eo8=;
 b=X2fikgkBKeNxEEorRxm5y9QqNuNv2+iJ9SHskHGmA4b6ZYLN+sUaYphSFBlsVDfxXQ
 aYFubtbTyu4IR2P9I8+hHDHcNKRkv6uzsYeCSUGwP9MI9PbI3xFZOXhwFuaZ4nhSEtvP
 +/dG724q38GqWxkSrKSDy0DtCxklt2FKQ5CZOMXNWuxKrQlih3/mmB5W3jVewxj4Fo/H
 /lSCLsBHE4oXOS+G5LMDdyo7xH9oCIacGIl07jILRJWhVfLyV7dNRtugl/JbNgB8ANnU
 +F/kySFLE013MBiVnzlkIYrLvJlDdT0s1w+ztpBthR5HEGbxMaFpAh3tqw+aYZ9hMYoQ
 /Wgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRih4Rc+5nDeSsroadVUvmP3+g5DyhGNIg5JpuO1YHWdFbHi+KqmNz2d/bfScNj4fF/H1s1kqaq46ZB33uwWw/yLXd3Q==
X-Gm-Message-State: AOJu0YyufJZ4GgSBYR94Ap5D/eKxu9gdUWuj78WMoYA2M+eSRc1vqwV4
 Xc5EB89IyN9AmTPTC7RGWoJkIAfqVrhWm7QVTPVudXy5IpYUfJ7C
X-Google-Smtp-Source: AGHT+IG4M+OpwU/t/WrAJjUVR7p6LdhUp4GN0+PKJaWvl71M15BWZS2xpJwNG7GqnUvQoFohd5csgw==
X-Received: by 2002:a05:620a:1909:b0:79f:735:4cf4 with SMTP id
 af79cd13be357-7a1a130a719mr409081585a.4.1721492394476; 
 Sat, 20 Jul 2024 09:19:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fbfb9csm196054585a.52.2024.07.20.09.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 09:19:54 -0700 (PDT)
Message-ID: <c89c5f45-edea-bdb3-466a-f6aa2e4894ba@gmail.com>
Date: Sat, 20 Jul 2024 12:19:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 14/14] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng@tinylab.org>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-15-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-15-sjg@chromium.org>
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

On 7/20/24 02:17, Simon Glass wrote:
> Update the comment to match the function. Fix the indentation while we
> are here.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/blk.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/blk.h b/include/blk.h
> index 7c7cf7f2b10..1fc9a5b8471 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -650,7 +650,7 @@ struct blk_driver *blk_driver_lookup_type(int uclass_id);
>   struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnum);
>   
>   /**
> - * blk_get_devnum_by_uclass_id() - Get a block device by type name, and number
> + * blk_get_devnum_by_uclass_idname() - Get block device by type name and number
>    *
>    * This looks up the block device type based on @uclass_idname, then calls
>    * blk_get_devnum_by_uclass_id().
> @@ -660,7 +660,7 @@ struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnu
>    * Return: point to block device descriptor, or NULL if not found
>    */
>   struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname,
> -					    int devnum);
> +						 int devnum);
>   
>   /**
>    * blk_dselect_hwpart() - select a hardware partition

Reviewed-by: Sean Anderson <seanga2@gmail.com>
