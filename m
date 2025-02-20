Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891C9C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154F3801BE;
	Thu, 20 Feb 2025 11:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cU5e+ARj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8612D806FE; Thu, 20 Feb 2025 11:33:12 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B828007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C60403F2CB
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740047576;
 bh=oixu+ZtiPBQXlGzaNM7jfryhk9bxMjNdbZdysZcvpKk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cU5e+ARjwsyYXA7xqTssE3/lpyGseqpyCNNEOM3IXDhdRs7JP/Z+/lgAkZycS6khZ
 nkfeAW917qpDYcPp5emc6+XTz5iPDgF7+YG/+pL47pBk0HaxcyfxlMni+h8uJnrRwb
 k+tyE61LNUpKbvo5d94G0Kr6L/azZTu9g1pf1GiaOWKgJWdiuOMiHooEIo+cGAhZzE
 eDuQyrmbeZclA5/7A99zav302I1T92TrEhOdB4IEQ9mNLFBlWyeukEODJ2KZcZA5F1
 2HdALtmQrGdXk7WE/rE1DP05mGtsetE+s/YhWpmXLzKcaHg+lfdYhtGnd0IL5FVOkx
 YPU8t/E1AW+5Q==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f28a4647eso376798f8f.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740047569; x=1740652369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oixu+ZtiPBQXlGzaNM7jfryhk9bxMjNdbZdysZcvpKk=;
 b=jVCU0YOBv+ciEPsK2vwO9xKPNUOrdMDhyS5ubsiXJ6lCLSejf273vxb8m9zRMp6YXk
 s/g0wLNIkVx0caFaxWHbmjFS5nFdYIQrYKdU47oA73hbE9ggF+8ABAcTrkBj6lw1PFaG
 jtW6gmEJlYdR8e73U9b+2BgHq/Xx6mthLwh6Tjc2lKQCzPNTFKVQDs5xCl0vGDr+B3UW
 iMulilM04vG8hMFHUG/0OPe7+W87pxBC0ZxIHCrNDKGsk/ZRjow1vEQNT4Pdzn8WFYXe
 9BauHOHrKg6k92ejclt+UkrNCSqq0+6HmnbfVbBonsyUxlnJqc81VqAoh/hxlhNGsxqX
 RgWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1cT1ldrAffgflyuzxmp17QNhC1QzSbrrnwVdSWzYsOeOzkPNkZRmKmqTQSbDM3xYW/5PWZ2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0BGWK5PweMWqjj62+IbIVtkpX8EGMUhFBs2sk1PvtS/neUlLy
 /aeS85ITbYfD8nKIngygUgY8EdPuEWhXx+/Kgfr+kXKAnFoCPgJzb8+QjNL9nahS2Ui7xbWgnl2
 cnX6Xiwjc7HDN2Sz6LKePbnm3if6Ky1pUiMacJkMWpaUEnBzn7NDquuntrnEO+1BADZA=
X-Gm-Gg: ASbGncs4Go8m3R+TQTymjCvUcrYW1LqPSmxf9XXlwDmgteMmUDdRdQDITac1riTELWY
 nxcO8uJ+s7tCHbbNlAOVDnaLrpyGu8/O0nAGUYbIYfP03MjQIgT7pnZk/YB4fqeDDzfzeJr/JUP
 EzgHI4fNv543M6uA1/vh7M8veZE6xFvKoMXAqsK/kbsNbn/sy8bvKjadyb4WCzGfap9qY+j3wdD
 c8GkP5Gns0uWi+NvwoaqKDGBxekpf4XK4BWF76uE3R+6vZxsJf2UaqokeFOg+DDM2Kvs3/3eMdb
 uBTL9NI68mBw3Tqj1KvJZ2r8LScVJAzOlZKe1FjQCFsG1tVmkzVBpJyilly1FExNgesE
X-Received: by 2002:a5d:6d06:0:b0:38f:4cdc:5d36 with SMTP id
 ffacd0b85a97d-38f4cdc605bmr14220424f8f.43.1740047569325; 
 Thu, 20 Feb 2025 02:32:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFELOI9k1k/vfLAcZmP+7aeDZ1Pnf1miiljwJ4ZecrszZXNnXDqLJivNNscd4JlcoIfAEeo0A==
X-Received: by 2002:a5d:6d06:0:b0:38f:4cdc:5d36 with SMTP id
 ffacd0b85a97d-38f4cdc605bmr14220397f8f.43.1740047568979; 
 Thu, 20 Feb 2025 02:32:48 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1d2:497a:3557:382b:d853?
 ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5ee2sm19967703f8f.80.2025.02.20.02.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:32:48 -0800 (PST)
Message-ID: <d5b84ba6-a627-41bd-85d5-eacdf98f88e0@canonical.com>
Date: Thu, 20 Feb 2025 11:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] lmb: handle scenario of encompassing overlap
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250220095654.121634-3-sughosh.ganu@linaro.org>
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

On 20.02.25 10:56, Sughosh Ganu wrote:
> The lmb_fix_over_lap_regions() function is called if the added region
> overlaps with an existing region. The function then fixes the overlap
> and removes the redundant region. However, it makes certain
> assumptions. One assumption is that the overlap would not encompass
> the existing region. Another assumption is that the overlap only
> occurs between two regions -- the scenario of the added region
> overlapping multiple existing regions is not being handled. Handle
> these cases by instead calling lmb_resize_regions(). Also remove the
> now superfluous lmb_fix_over_lap_regions().
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Use lmb_resize_regions() to fix the overlap instead of
>    lmb_fix_over_lap_regions().
> * Remove the now superfluous lmb_fix_over_lap_regions().
> 
> 
> Note: To be applied after an A-b/R-b/T-b from the original author of
>        lmb_fix_over_lap_regions().
> 
> 
>   lib/lmb.c | 30 +++++++++---------------------
>   1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index d7d2c8c6dfd..207f059ceb9 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -100,25 +100,6 @@ static void lmb_coalesce_regions(struct alist *lmb_rgn_lst, unsigned long r1,
>   	lmb_remove_region(lmb_rgn_lst, r2);
>   }
>   
> -/*Assumption : base addr of region 1 < base addr of region 2*/
> -static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
> -				     unsigned long r1, unsigned long r2)
> -{
> -	struct lmb_region *rgn = lmb_rgn_lst->data;
> -
> -	phys_addr_t base1 = rgn[r1].base;
> -	phys_size_t size1 = rgn[r1].size;
> -	phys_addr_t base2 = rgn[r2].base;
> -	phys_size_t size2 = rgn[r2].size;
> -
> -	if (base1 + size1 > base2 + size2) {
> -		printf("This will not be a case any time\n");
> -		return;
> -	}
> -	rgn[r1].size = base2 + size2 - base1;
> -	lmb_remove_region(lmb_rgn_lst, r2);
> -}
> -
>   static long lmb_resize_regions(struct alist *lmb_rgn_lst,
>   			       unsigned long idx_start,
>   			       phys_addr_t base, phys_size_t size)
> @@ -239,8 +220,15 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>   				lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
>   				coalesced++;
>   			} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> -				/* fix overlapping area */
> -				lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> +				/* fix overlapping areas */
> +				phys_addr_t rgnbase = rgn[i].base;
> +				phys_size_t rgnsize = rgn[i].size;
> +
> +				ret = lmb_resize_regions(lmb_rgn_lst, i,
> +							 rgnbase, rgnsize);
> +				if (ret < 0)
> +					return -1;
> +
>   				coalesced++;
>   			}
>   		}

It would be great if in a future patch you could document all LMB 
functions like lmb_resize_regions() which lack a function description.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
