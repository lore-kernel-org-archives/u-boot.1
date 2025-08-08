Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03BEC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 06:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E3F845C5;
	Fri,  8 Aug 2025 08:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KA4/7MH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673F8845EC; Fri,  8 Aug 2025 08:58:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C314C84559
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 08:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18E113F56B
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754636255;
 bh=WPMO88p2kS6f/CMleNM5k1mQdwvRY3bqWyayZCRuLkQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KA4/7MH4ABsqhQfW44QMopHR56XrHjmU+ZwmHQ6xY5UKsU8Bh98LMgT99fEy4ubB7
 rgFflGeTsEq8wt7J0GODJ06DIx1HY4EEYbXiYxoCwXAAiFJA7TLbwD2bqUrEkx0mJq
 IREsp9gFtGWGwxM/2dbpRrely65unvYIMDv7FWjemOSMGLkkWSaP6JVYb3vmUSht+b
 +KS8xjobfP8+PoqVD09XRdmkCeapzw1zaKCNW+Nca5iT0dsSDoJVXZtpRH2+pTogNr
 3PcYVe2H6a1CksFogJ4CJb3Gc0Xq2q6mhpG1g/oQP53BkVO8vcXzouwnJb1tZgEHKs
 xJooLob4tpgBg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b782c29be3so852302f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 23:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754636254; x=1755241054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WPMO88p2kS6f/CMleNM5k1mQdwvRY3bqWyayZCRuLkQ=;
 b=ovpYyQz3TUKedjipN+YuykyfCZM8PvymrpACwdg5yLYuapuj5Jr0EaB9t/cl8AkPpU
 BCCvvS01dpACTWgxfSHRSi2wiSa+rWkcCzPGWvPexOsw5pJzWAMRzh225Tv9VTAH6GRz
 bW2/EMtOSFEPpNeYYv6L+CXHpENXr1s5jBzL3OyN37jBGqVqEiGExCVMeq6I/7pYggrX
 +fZrEC9w5onLHoJkwsfXjmERdR8VBB2GRlGXkGx+OV9e2J6DJy+2/3xA3bR4JoMokcN4
 xlWmZuhP4Ed6QPF0gnjmfF7SmxeKyfhqoY+OwpUPT7Z7ySK+gypOPtHH2pVAjiJL0YRt
 Dl4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPR4Ng+1kxNk81vNZcFTwQ/A1ZaDWVgkCONLPUQAjOdQzgG5Pba2dxc9XiIhof60I7H9Svo9M=@lists.denx.de
X-Gm-Message-State: AOJu0YySftVI5ZhPrg+bBQBcNzPNLMmjNk07hFnBGVpn4gUCWVhONG1l
 7aCpATALYfJsNtC3PQSz/mdURUyJ1lvmp3JkToTWDV6fURN+UFN1t9ljyrTWzhwJ6mjmeAigivh
 tEGggrApOdt14Pdyes99Hdw8X6RZeyD5ixrbj6vQMSSU/XL596UkVvy6BmBCDgxyv/pptN5s=
X-Gm-Gg: ASbGncte0n3hIeL87CLaoDGPAfhupm2vxuZc20L5ck2uwsiMhTRNmn7qWryTvIwXOVM
 r6LrZxMuMfar8stzxX6NHAifclN77ASmU5cR/qyn9xR4wMKk344WCmDiVQouGWN0mZYzZTIckDh
 12Bc6YVSgbzfS8q48H3WPAgRd+7QPoltAa1kRBpxUsQqfwpOGYQ0LJJFmx7WnW+nFJbsVU+6Qa4
 nEldAu63As5tFumz7fJiDlAkHU9p86SBS5yIlX9QFffXyp4zcC6aV0+r7NL9wzPAHzl5b90VCcZ
 IAxNDOdVbyfwX3UtGiKZvfQXV4voSM/IT5dkFcJd0uAfdd1DbueDajrc2P5b3Y+UJXX2ymylhdp
 3E83KFhqdtfkZSJSYEek09ON0jax9PzBFMEyO
X-Received: by 2002:a05:6000:310d:b0:3b7:6828:5f78 with SMTP id
 ffacd0b85a97d-3b900b4494amr1354476f8f.4.1754636254660; 
 Thu, 07 Aug 2025 23:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfj4XbI2EUbhKfwwLnA+F9sIks4d7KxBlXVzancfZQwB8wcQbN+zcsl1NWNvpyLH65/N3b8A==
X-Received: by 2002:a05:6000:310d:b0:3b7:6828:5f78 with SMTP id
 ffacd0b85a97d-3b900b4494amr1354459f8f.4.1754636254284; 
 Thu, 07 Aug 2025 23:57:34 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5885eb8sm123519115e9.29.2025.08.07.23.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 23:57:33 -0700 (PDT)
Message-ID: <f1ad0910-ac5f-431a-8577-752063b62d64@canonical.com>
Date: Fri, 8 Aug 2025 08:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: spl: fix typo 'TPL' to 'VPL'
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20250806113912.3404244-1-ycliang@andestech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250806113912.3404244-1-ycliang@andestech.com>
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

On 06.08.25 13:39, Leo Yu-Chi Liang wrote:
> Fix typo: change 'TPL' to 'VPL'.
> 
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

The documentation change matches the code in
tools/binman/btool/fdtgrep.py:

  81         elif phase == 'vpl':
  82             tag = 'bootph-verify'

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/develop/spl.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> index aa6d28fa333..7f2eac50806 100644
> --- a/doc/develop/spl.rst
> +++ b/doc/develop/spl.rst
> @@ -142,7 +142,7 @@ fdtgrep is also used to remove:
>   - the properties defined in CONFIG_OF_SPL_REMOVE_PROPS
>   - all the pre-relocation properties
>     ('bootph-all', 'bootph-pre-ram' (SPL), 'bootph-pre-sram' (TPL) and
> -  'bootph-verify' (TPL))
> +  'bootph-verify' (VPL))
>   
>   All the nodes remaining in the SPL devicetree are bound
>   (see doc/driver-model/design.rst).

