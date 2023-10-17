Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844BCCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AD186ECA;
	Tue, 17 Oct 2023 15:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XW+0rh5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCE986ECA; Tue, 17 Oct 2023 15:17:33 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B961C86BF2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robimarko@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so9898789a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697548651; x=1698153451; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ygv/ZyaJ7BGBvhVahW/C8ypKIwVD8zdSCr26PoXrvgA=;
 b=XW+0rh5sw0jlnxsISuZGTMte/triFmHUcmtTwTIIf2u5/cODQatAuzbOBH5Ue31nxe
 BWIEYZOCT0MXkLeLrskYd0DGgF+59CY1ZrqkBKb4JRVWSvTA8I2G8qzPoVc7hb6qMS1G
 tLVmlM35uaSPgmO4bMYIx3Zrv+hY3YnfVpzvn1xpRnvV7sR351gNWHWYOIXaIvEV/RuY
 oCCahM99xbzqeIqo+dWpKpSLl0N1NBtY0msNvx1noY3msJEgunIpRiLX8p+EU40DarIW
 TjtqzdIoDWGmGcLqcvDmW/RDjDsTUMF0Gn/4PlWqtGyoEVyUQ1GzhJdJgeccaHfxGjx8
 Ce9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548651; x=1698153451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygv/ZyaJ7BGBvhVahW/C8ypKIwVD8zdSCr26PoXrvgA=;
 b=oqhTL+lS+wz8mOGhNoZeeb44bhgl91MK+9j3QchFLQd5P6OeVtb7nFpHkubJs3IgCh
 uddTWGbgUyjkmqkomI342x84uAjNsBV0gKSMrR/vXbosAWBCsvPp5G4WmEgmn7R4S79f
 a+u4TbSQA2G+HmUMPQ1ZDftceVJCTFQi4oAoAaHz7JgoIY5HPcoWDb8FwhK391SSLdgg
 TtswP8Sgw1qwnzRNZISxk2j6hX6CKRaN5dcY33GjfZezsMbuYTwg+i5zYAPE8lzI1j1f
 xvbz09uvn4JcP6oWYXU3AN/r8gejeE7jH+vCYmoxWq6FaWhymLwu4rImOCOuf5cStLQB
 5v3Q==
X-Gm-Message-State: AOJu0YysOCgFOJcy3LpjZ0tNjuR8eECLA2yIa9BzPvw6iEw+TVaoCLav
 C728egAOyl+pIgbrhkalnwU=
X-Google-Smtp-Source: AGHT+IH/Zha8icsSPBHECfUn7k0MZXiKTPhaJe50ZQElytxqioM+x46iIlAxAciYW7jyVwLBLRb/+g==
X-Received: by 2002:a17:907:26c1:b0:9ae:4eb9:e09b with SMTP id
 bp1-20020a17090726c100b009ae4eb9e09bmr1612164ejc.27.1697548650984; 
 Tue, 17 Oct 2023 06:17:30 -0700 (PDT)
Received: from [192.168.3.32] ([188.252.220.210])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a170906358200b009a1dbf55665sm1231527ejb.161.2023.10.17.06.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:17:30 -0700 (PDT)
Message-ID: <5e667106-74f6-4a47-93dd-509abadcf611@gmail.com>
Date: Tue, 17 Oct 2023 15:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: use which $(DTC) as a dependency
To: Richard Marko <srk@48.io>, u-boot@lists.denx.de
Cc: rasmus.villemoes@prevas.dk
References: <20231017104453.2121276-1-srk@48.io>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <20231017104453.2121276-1-srk@48.io>
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


On 17. 10. 2023. 12:44, Richard Marko wrote:
> If we try to build using external dtc using
>
>> make DTC=dtc
> we get a confusing error like
>
>> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
>> needed by 'dtbs'.  Stop.
> Workaround is to use
>
>> make DTC=$( which dtc )
Can you please use command -v dtc instead as which is not part of POSIX?

Regards,
Robert
> which gives make a full path, so the dependency
> is satisfied.
>
> This was introduced by commit
> d50af66 kbuild: add dtc as dependency on .dtb files
>
> and we extend it so it calls which automatically
> (similar to scripts/dtc-version.sh)
>
> Signed-off-by: Richard Marko <srk@48.io>
> ---
>   scripts/Makefile.lib | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 8dc6ec82cd..04fc9b0752 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -351,7 +351,7 @@ endif
>   
>   dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
>   
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> +$(obj)/%.dtb: $(src)/%.dts $(shell which $(DTC)) $(dtsi_include_list_deps) FORCE
>   	$(call if_changed_dep,dtc)
>   
>   pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
