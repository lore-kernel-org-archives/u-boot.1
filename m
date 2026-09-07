Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06954C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD64480AF5;
	Mon,  7 Sep 2026 08:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94CbAaxr8YTi; Mon,  7 Sep 2026 08:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B133D80974
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770182;
	b=n0MTkL+neywSNQv8jyYiUuVGoJ3gIqnsPv94jD2OU+7+jQ9Btu7eeA14VP4pIm9xNHlD
	 UPqNPcaoDuaAzj62zmyt2JVH9QjMCluu7X6yqaIqdk7a43gtMhQCUK8Cb7yHnvjvbJzQ/
	 B3Gu32dyixg2C+ivdWwVp2jwGpwtiHnV2CK3uMAedlejzv4oVcr9tXw1yyYkPUUVCpR7E
	 jBafBcpSLldRHav7Um8r5mbi7D870VpX6+QJwkYS2iejXj8icnzWpI9MUkHRyhSxKWu9O
	 +tTEL/J92+t6bJ28V0k30216RjZGzy4TCp0B7wp9NVBtyjMNKdbEbtcijBG7Pw6cEMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7xHEYw1p8CaT1ipP5D3ebRxBbmAR+TvvEb/1C22kO9o=;
	b=LqTj4d4hY9d4bkL8Y8xX+H9oxgl+4078sVB6KoiUF3gv0aW892xrk1I4J37Y+lY02HdZ
	 u7AyFbTuoTHC/qqYOGPYHtMnBmTyF6kFd0GOKYhfO/sYv7ZEDn4rJV79Urfnm+BzyvhNg
	 TlVg2Vz6nxQ57MK2rqXI4RpY/Suzzn9YUge0PKm925ZL1hLiXyH2Pn3GY/yYbGPLZK/Oi
	 s0y36z0Lw/1qbK+mzy9+H6snnvGrjoW46WOTKz8sAKYZIgCSVXeBomEPnquc3Y65Hshjq
	 hFd4za/Wgy1eNVKfcJJnDrKCanBKrRxMV8PX/wre2tcekufObHfI2Ly5wAU1SvUsu7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770182;
	bh=7xHEYw1p8CaT1ipP5D3ebRxBbmAR+TvvEb/1C22kO9o=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVWdId0bHvey2wbUqV/EfYNztHEswI9byguC3yRV62ANoU+TS6hBIiJhFXiMhi29W
	 ave/15HNuYyW73Bb72LoLvrcndb/eVO3I8RAr9/kAgoVtAfxNnoqvCh+hwZ25+YvvO
	 unhWTKACTxj0IVuDElHUqgQl9HIR51nRnXTHwVAuW4jIG5IYdX5QjVN8LniyHd9vfj
	 dFs+k4r7XtlPirlwsta5pTnjTWf0T/VfF5BH2uu1PTZleDmI/GolGa2teEIxYz7gmO
	 O7RRN0DVAURwBMRLjmvum9z0ri8JOM2tR6KyeoO7NRzwdUZNEbKGm4OwMDgSU1kXRL
	 jzch7OXQO59bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B133D80974;
	Mon,  7 Sep 2026 08:36:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 948E9970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A4EC4050A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZXMO5VSvzrB for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF6B240506
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788770179;
 b=SF3yxC92yg83lei9r7ZsdhCJqyyp82bLinw2MOqQn3yp4WYWyq2uXRDG2UYe+GUP+/E2
 UZT1XL8sWRY5RdnqV9LBGQjw3dxIkxsY/twtyUtU6X6sM/18exL4ck4wc82yNMYpgE+yb
 A/mySMTm90xcvad2Bm5Dvfitn/ncEg1V0wo5EfbBCE2/LcKuaNM4QJmHPPbncn8TsWEtT
 U/DPGL2zovIUOW6KkjTENq9seHlSQmOBC4Yk+HAmvKm7DS1JgsXX7KVCwSYMEUtFWHarO
 4Ye3P4U/BUMBBnDrKM/j02ol0RHybDTc9mMhyUOcj426q3BmlVdTKUJUqu1KEesncQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770179;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=7xHEYw1p8CaT1ipP5D3ebRxBbmAR+TvvEb/1C22kO9o=;
 b=KzaVWuh2TjND23fG0eUaSm4/Z1pjhaF2qXmAe3027Y/UgGer7gY92Sye5IjDpF15OLZX
 DpkNzA9UGzW9Qc3XvrHee4vbGDefUDwbgz0ltVyg01KuIkTP38JIi9gDqnRrrMojGqOQj
 SQh9RDSdRQKkOK2BQNaCDXhdbggeKTfOE0uhtudyNhVj45qP+Yz8AaWqPnW6jOuY7WLGS
 V65UjvLpuZ1vLI26oav+ZGuTgRPC2pbKfCiMJgxjMLGQB+tp6euLz3yf8i4DiWto+yqwf
 5ihjF98jYF44HXlRqTsloc3Vp7GF7AmeubNoy55NK/U/CO3APv+L42Wx87QNRCV6bqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="Gn/sTec2"; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Gn/sTec2
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF6B240506
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:36:17 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74ECC3F28B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788770175;
 bh=7xHEYw1p8CaT1ipP5D3ebRxBbmAR+TvvEb/1C22kO9o=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=Gn/sTec2d9Z1ppcOfduMpI+3+dNzKh81huLWNeik4+gCDWW5vxZYiM4grmGNgPd5N
 5GeHmu1ssgU2aCsbEi8/jAR3QCQwWzVRsEzbO0dOoYTu25wVRfESdcW2nEpjMV/bjs
 NnxwR86aagNFBwdhj18TgLI3bBypj9Jex5ESez2EqeFvjc8M6Q1+4+orMgVzKKppzr
 PoIW0H1Qk2yaodal6YzOkov08JYtQtTRsjeGL8tuQwoU/IyG2Vfq6Pj2U+2fy7P0U+
 IVowbGdqg/XNtrKqIU0noyk98NRBI0A/tEKcbs6quMNxN211I/ntKMV8k5D6mYnWwt
 g04tzTyju/sHTV31eXDDQrENb5B7W0mUz3RnyLW0NZokbtU45KWC6uOMBoBYXEvnfV
 MMRPjxwN1i4TUGHbbNjURFnt3ymqjoBeS+27FP+jw66qd2D8H3uOjldrSpeXsMQ0su
 d+Oko1ZyDD/Ybd6c1nJ3oe+QA0nqVSLoVFgPdptWqbO0Hr077YDXRMgm0XbMV8jJu6
 oL+Hm2dDQyqZsXKlo/Jw7y+fiqvXMyykC7UbEMeNzXQ58BtQSEY3F/dGNWs2QzOfb3
 ZSu14qP3Eah0sWF/Xj/tx2p0VJfztb6SuO47lg3GiaHFyzqfq8OE85CFnIfOBrJyR1
 QIX+GNmOYYJ5V2Ne0pSsV23M=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482f2b8a116so2858181f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 01:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788770175; x=1789374975;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7xHEYw1p8CaT1ipP5D3ebRxBbmAR+TvvEb/1C22kO9o=;
 b=Rp/OFyOs/hH/H7Wm9q/wQ1TnuZlRyTq70UM2QiqsoL5dptuDIeyl3Qm6PTsF5YyvsQ
 7JR0xPCYbawsKZkcTK8uQTnRirqnNOTzE28HDl35UIBqHXnUtGdMotEycZ6X4dYyp5wK
 +wQ8zyrP85V2fA5UqyWdOe4pk6lC20FPLDgagNf3AayIkwX7pfNoKG5c25y1u4D4qlS2
 YM6CHxs5iel7kIMHkuImel+DERZkMCKgcp/7KinnfBf/YYeZyjEHDG6w3aphQsHqI0Mh
 ln9lHHIhGmh+R044Z0KH7Ik9dQW1rKqfdENSAfOOo5OOAwjQLM6LT3cbGmYWcr5fmuzo
 0TKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiBqCDnTrrqS9153/Ona51Az6iuaiUE1R5rPMiBy+MkCvgYz0ePC5spjWt284+DTQLJc2kQaE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mRooLTv0HmMM+bD2B9L3PvZYtvYtx8y9GUuSsF1Y+KhUYCxcxw
 nHGu6u4tr4NG5A4x/8Jt+CAdBPdJLkUlYYdjmL/qWm14JMkV+/b/Ni9TRqWCRDVvGXqeI4UEl4f
 B/dt6PIRh1urekDb4+0t/ieHyekqPc2Is/TtHO3XBhvlIwfC9bzKlAqFtci8CapmSaJZ1k0845O
 JQG7cJYwuPfA==
X-Gm-Gg: AYBFou3lkLPuJz6thnB3cTSiXWWKPU9BkIJgHhslY5QvMjnFdSgp0hFBQUfglnYbGKF
 +oCHgl03F8nvCT4///gkWJm/XpY9LyWljdFxacIzgjj3JkRXOYOu0Y1coprWbTIXwWG4Dfb0iYu
 NDkcfEVnw1DtjmHjY1EJLLUIlP14vsMQ871b6wrSNyUL5wJez7+aNi9pP1UgLzgNuPpPRTMWilK
 xESeE1asbrzm6lu92kE1i0pyiAyJFZFlilZFlsCgYRNkJRoOfje2ZpCb7uk0Xig13euRA5eybzt
 2S/JJBIUoio/X5AoIC4XWKdkQIWX8Zonck/KF/LCm/ROoOUrei3+nFsKUIEEC1sXwiSswEhOHC8
 34xD7d8FNUdq18rTDRQJyGbbM6o2kREksgPwwgSwCBGu4C55yd1hXoH2crMmN6qtfxbo3Ap4YVK
 NjkAsp
X-Received: by 2002:a05:600c:190b:b0:49c:fc6c:be12 with SMTP id
 5b1f17b1804b1-49cfc6cc0acmr161562115e9.24.1788770175026; 
 Mon, 07 Sep 2026 01:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:49c:fc6c:be12 with SMTP id
 5b1f17b1804b1-49cfc6cc0acmr161561655e9.24.1788770174528; 
 Mon, 07 Sep 2026 01:36:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:7bcc:7a41:774f:ba2?
 ([2a02:908:1242:30e0:7bcc:7a41:774f:ba2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm389175335e9.4.2026.09.07.01.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 01:36:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <4383b225-e91a-4c09-959d-1abe115ed00f@gmx.de>
Date: Mon, 7 Sep 2026 10:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib: display_options: add snprint_size()
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, michal.simek@amd.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260828042828.3421664-1-padmarao.begari@amd.com>
 <20260828042828.3421664-2-padmarao.begari@amd.com>
Content-Language: en-US
In-Reply-To: <20260828042828.3421664-2-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/28/26 06:27, Padmarao Begari wrote:
> print_size() formats a size with a binary unit, but can only write
> it to the console. Move the formatting into a new snprint_size()
> helper which writes to a buffer and let print_size() use it, so that
> callers which build up a string, e.g. a boot menu entry, can present
> sizes the same way as the console output does.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>

Hello Padmarao,

Thank you for looking into making printing sizes easier to use.

Please, have a look at lib/vsprintf.c. We support a lot of specialized 
output formatting here, e.g. mac_address_string() is called if the 
printf() format string contains %pM.

We should move printing memory sizes here, allowing us to print a size 
using a postfix to the printf code like this:

printf("The size is %zZ\n", (size_t)0x100000);
printf("The size is %uZ\n", 0x100000);
printf("The size is %luZ\n", 0x100000UL);
printf("The size is %lluZ\n", 0x100000ULL);

printf("The size is %lluZ\n", 0x113000ULL);
would print
"The size is 1 MiB"

printf("The size is %.3lluZ\n", 0x113000ULL);
would print
"The size is 1.074 MiB"

This will enable code simplification in > 100 locations by completely 
removing the print_size() function.

Best regards

Heinrich

> ---
> Changes in v2:
> - New patch, replaces the open-coded unit selection of the v1 patch.
> ---
>   include/display_options.h | 18 ++++++++++++++++++
>   lib/display_options.c     | 22 ++++++++++++++--------
>   2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/include/display_options.h b/include/display_options.h
> index 66e59607737..2baf6859917 100644
> --- a/include/display_options.h
> +++ b/include/display_options.h
> @@ -11,6 +11,24 @@
>   
>   #include <linux/types.h>
>   
> +/* Maximum length of a string produced by snprint_size(), including the NUL */
> +#define SIZE_STR_LEN	32
> +
> +/**
> + * snprint_size() - Write a size with a unit to a buffer
> + *
> + * Format sizes as "xxx KiB", "xxx.y KiB", "xxx MiB", "xxx.y MiB",
> + * xxx GiB, xxx.y GiB, etc as needed. Sizes below 1 KiB are formatted as
> + * "xxx Bytes".
> + *
> + * @buf:	Buffer to write to
> + * @bufsize:	Size of @buf in bytes
> + * @size:	Size to format
> + * Return:	number of characters which would be written if @buf were large
> + *		enough, not counting the terminating NUL (as with snprintf())
> + */
> +int snprint_size(char *buf, size_t bufsize, uint64_t size);
> +
>   /**
>    * print_size() - Print a size with a suffix
>    *
> diff --git a/lib/display_options.c b/lib/display_options.c
> index 2c15cc5b5c4..287eb247061 100644
> --- a/lib/display_options.c
> +++ b/lib/display_options.c
> @@ -93,7 +93,7 @@ void print_freq(uint64_t freq, const char *s)
>   	printf(" %cHz%s", c, s);
>   }
>   
> -void print_size(uint64_t size, const char *s)
> +int snprint_size(char *buf, size_t bufsize, uint64_t size)
>   {
>   	unsigned long m = 0, n;
>   	uint64_t f;
> @@ -115,8 +115,7 @@ void print_size(uint64_t size, const char *s)
>   		 * We have just checked that the size is small enought to fit
>   		 * unsigned int safely.
>   		 */
> -		printf("%u Bytes%s", (unsigned int)size, s);
> -		return;
> +		return snprintf(buf, bufsize, "%u Bytes", (unsigned int)size);
>   	}
>   
>   	n = size >> d;
> @@ -138,11 +137,18 @@ void print_size(uint64_t size, const char *s)
>   		}
>   	}
>   
> -	printf ("%lu", n);
> -	if (m) {
> -		printf (".%ld", m);
> -	}
> -	printf (" %ciB%s", c, s);
> +	if (m)
> +		return snprintf(buf, bufsize, "%lu.%ld %ciB", n, m, c);
> +
> +	return snprintf(buf, bufsize, "%lu %ciB", n, c);
> +}
> +
> +void print_size(uint64_t size, const char *s)
> +{
> +	char buf[SIZE_STR_LEN];
> +
> +	snprint_size(buf, sizeof(buf), size);
> +	printf("%s%s", buf, s);
>   }
>   
>   #define MAX_LINE_LENGTH_BYTES		64

