Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8DBE77376
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 15:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA9D86284;
	Sat, 30 Sep 2023 17:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GnTvCz69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C5F85423; Sat, 30 Sep 2023 17:22:58 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFE486284
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 17:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41983b83e53so7852971cf.2
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696087375; x=1696692175; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FNEgJXOIPz31V2Ca3rVtukfEjVSZYOiuPCnjBS9Rnzc=;
 b=GnTvCz69AXVQLkdd5/Zo+A/ax/D298o5/0hJHhLjfhqU+GUUJMS7g8G6iXfQvMME2C
 R+Of7QITRNw2kTalVKsppEBiAOXlO38mUhl8uxmQDF8dJ6jLEVch6CcUAxznyTQebj15
 rX60H1+YIBH/WzPegZOO+lyOjDZxUoJXbGBIQcp183V7tkc8Q/Ju+Uu0cYV+JdSUKmsM
 6sxuVjnluHaYzj2s4lCKSodq+TC4JxULVfUhdorFkPQ5IM+DdcR4JJO5S9K9clp/fM+U
 mj9Nm2aLN1Us/US68IFBDUylxx3AZDyVHYD+9UOLi1VflwLZeL5H7T5NkIcYIHWRlY1M
 CTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696087375; x=1696692175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FNEgJXOIPz31V2Ca3rVtukfEjVSZYOiuPCnjBS9Rnzc=;
 b=JTAjr8XkH7UzwJMgvGfaM745DPGMYvWpyCCDVzvu6IvXaRHeRqA2+wUfqDt/H7v8QO
 by0Rba99Elj0Um8ljf+rEn9m25tjmoICHpUohlZYiIHRaZacStIX+u7/KtiABBzmmvEV
 4zrX9OEWwudIUeUyxzCnc2ONZxEcvHu6vvwPGlr3ATrddm29Xz2YdwEXWC7FQMLZ31/3
 UvAEvciB/6K/NEf/fdW1E46IKO9OT6BwNzHlr6oR6HL58UszrWysgM705bBpLsDqKuH1
 H4mhX6S20afmJr7ZFwR+WEf/oZZ/ivGlfiF7bomeZXxvbEZ8Kibx58ncnWJLI1qqwoOn
 MpwQ==
X-Gm-Message-State: AOJu0Yyh7jOFCxf5TJV3DU5qWfoupWAE9b2XRQz4GW+2P2GknD4SLeH+
 vA5LfBMP7PfjAT4RVjOqO8Bc6pPh9Jc=
X-Google-Smtp-Source: AGHT+IG0nd3ZJ87qPCNSVnSBujody+Yb+GVjs92vg/ePUU8k/p8LpAD/DuZ5pP0ZLB2f3lLpN3Lk6A==
X-Received: by 2002:ac8:5952:0:b0:418:f005:3a18 with SMTP id
 18-20020ac85952000000b00418f0053a18mr9674606qtz.64.1696087374885; 
 Sat, 30 Sep 2023 08:22:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 x14-20020ac86b4e000000b004181e5a724csm4096330qts.88.2023.09.30.08.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 08:22:54 -0700 (PDT)
Message-ID: <e3663767-0f99-aadc-924c-5295dafc1e6a@gmail.com>
Date: Sat, 30 Sep 2023 11:22:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] linker_list: Fix ll_entry_get alignment
Content-Language: en-US
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
References: <20230930143623.318903-1-seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230930143623.318903-1-seanga2@gmail.com>
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

On 9/30/23 10:36, Sean Anderson wrote:
> When ll_entry_get is used on a list entry ll_entry_declare'd in the same
> file, the lack of alignment on the access will override the
> ll_entry_declare alignment. This causes GCC to use the default section
> alignment of 32 bytes. As list entries are not necessarily 32-byte aligned,
> this will cause a gap in the linker list, corrupting further entries.
> 
> As a specific example, get_fs_loader uses DM_DRIVER_GET(fs_loader) in the
> same file where U_BOOT_DRIVER(fs_loader) is present. This causes a crash
> when walking the driver list.
> 
> Fix this by adding appropriate alignment to all accesses.
> 
> Fixes: 42ebaae3a33 ("common: Implement support for linker-generated arrays")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>   include/linker_lists.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linker_lists.h b/include/linker_lists.h
> index f9a2ee0c762..e0c8a01b9ba 100644
> --- a/include/linker_lists.h
> +++ b/include/linker_lists.h
> @@ -209,7 +209,8 @@
>    */
>   #define ll_entry_get(_type, _name, _list)				\
>   	({								\
> -		extern _type _u_boot_list_2_##_list##_2_##_name;	\
> +		extern _type __aligned(4)				\
> +			_u_boot_list_2_##_list##_2_##_name;		\
>   		_type *_ll_result =					\
>   			&_u_boot_list_2_##_list##_2_##_name;		\
>   		_ll_result;						\
> @@ -229,7 +230,7 @@
>    * @_list: name of the list
>    */
>   #define ll_entry_ref(_type, _name, _list)				\
> -	((_type *)&_u_boot_list_2_##_list##_2_##_name)
> +	((_type __aligned(4) *)&_u_boot_list_2_##_list##_2_##_name)

OK, so this causes an error in clang. And it isn't really necessary
because the entry is already declared at this point.

So I guess the right fix is to replace DM_DRIVER_GET with DM_DRIVER_REF in
get_fs_loader. But this seems like a really big footgun. You can use the
wrong one and there are no errors except at runtime. I wonder if we can add
a warning of some kind?

--Sean

>   
>   /**
>    * ll_start() - Point to first entry of first linker-generated array

