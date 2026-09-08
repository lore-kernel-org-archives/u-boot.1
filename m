Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252DC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 13:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 847624056B;
	Tue,  8 Sep 2026 13:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mfoHjgPIU4pX; Tue,  8 Sep 2026 13:24:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A613940546
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873859;
	b=WdNUc8YKVkedGWsATT3weqquUzt5bzO39NTYjtOWjF6QKnfFaJ8mS3nKVjoLsKTmfYAx
	 DYA25HjCCUAG0zBKpxOJjI7vxtano6Zy2rQRZcMdz5delHdKaBfWow3yDbHaE3w6OLENZ
	 kFxoE5OyHvrPEiviYbHQEXHTL0sMtkU03iK1LtpbbOTJcosAtT4hinG75j1UoJC+MwUWt
	 30EZHjgggn95zRT62lhl7S8uc+T600vXUPKtVozKw+ViZB7msuwLRgi1BeubZ2LAmz/7C
	 ZpURPclRIF/JE94iJVBHUqNExJXwEuz4jhwvnzyCpdApRU2gjMaCLiV34wfIHiRWqHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZQRlEHUJPfJhJti1jUxeb/LtY9oKMjQFXC4WRiNaWN4=;
	b=PPACY4euTcpZ/pgD79rgH8DwBqmcLg8XYKk0tjAv8AXlYB23/hqnJxjDtxDq2GzW0alf
	 mgjCgMrJ3SLy9dUecBoMokmKpCxaDcYndRWlrOG09r/+g4kPJrET/1J32p2xhi4R8WAqQ
	 jEegAamyqQhPAyTLW3d2tywp1fmjAqH46rcap6qb3Pt3YpaVo8rjq/daxJdWuamtRfLRv
	 /6q7xr85RLN8BG/gXpVsU3nKASYclrS6kmTy+tqHlsFhJ7197GqtOcSDqN09PdWCSe9YH
	 y7A5elrfdHpgLfz2+hDBT0Van1hQgens1RSfWtnDBcZArXg5s4F9pHQ0TosKQBPwOww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ji8skqJO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788873859;
	bh=ZQRlEHUJPfJhJti1jUxeb/LtY9oKMjQFXC4WRiNaWN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XCRVbPBxXnhCk8gTEDeaYYpyYn3BAZCY9GzA7J1OWjhdK6OhNt0nDC8WGJCpaL1yB
	 7eq6tmytll37wy9oNjqfV3ZDtrDOOveX6NbMxIwqHzgLgIAefbBEmdpsBCkXvSYqb5
	 Pf/YBTclpNm1ZgfvujJJTf62yJVoIjvFRPOJnRq1ojay0pDeZ6A/Geo8y21ZsUh+TT
	 fk8ZZUqForYl53mQQ0yM+U3TtZfgRPPcJmx81uLKc3l5TK/37tRqB3wqTNcSIyn8Pk
	 hnJcf4Y09OrGXf7EF6HFFAJzr4jdjCFbxqSVJTkfV93xF9by+t4jiNChCEP3ZVSiT7
	 ZOPNj7D91GVEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A613940546;
	Tue,  8 Sep 2026 13:24:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3560372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4F3B40546
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWpIObIBP5eE for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 13:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8BF8340538
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788873857;
 b=kLh8NtKDoxKWwVIDCd6E7AupFwuJK03WLwNwm8C7GyZm/r367qJ/FgpSwUHnfqeaTMHb
 1PQDpNR7TeTQKkmK5k30pGgIliVow1r2PJOxW4F67zZcQe7FCPpscQWIUg9ZbMty7YP/I
 2jUbh1PcpYNjCOmz22SWs8Ajm9XjQQRKYxkfvzEfaMXO1W22AaaIKn+tODTcEJOgxm9mk
 iPfVGEGzTySVxrFxOQAw3jgfrEpyN4XC1eDU622vnbxRwFuuZB/siUE/Jlt6GLlxZZRmh
 4HI50tQ3j5cuoaTxBMpcE7mLSbnuz48z6USkZ+lTcfvPcoGjxc7VRhFH7/75b3tsQVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ZQRlEHUJPfJhJti1jUxeb/LtY9oKMjQFXC4WRiNaWN4=;
 b=px6m2Xm1/2by38thz+ZCRhuAgHrR2M8/n3UgRKRJDcVU/f77casaSD267BvYVWFzjr/m
 l5VEPRJ5Uo4QLJ5607VJ6yrUNtuVMyVPLSdqlhgTJEZkVpP2WaufZsoCmHjARec7nzFq5
 tNT4RGu1yAtENnOnrLU+rqxMZ10iezXKQkx8hm1kzLpogiAzajm/tKQc79RVncoBnIwvm
 +yvyKruFKTcjiAYOlAGqKhUExfrCSUUg4W45s3+fMC1EmwlknIvhcTqKoz/jKeItGhH5X
 qYD7p6iiLS5HOUIPPCMMVJrsfSKK/cWyWmS912l342Cq1MGpZg+79UfpjAww/tWT+ag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ji8skqJO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ji8skqJO
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BF8340538
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 13:24:14 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49557167508so55307975e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788873852; x=1789478652;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZQRlEHUJPfJhJti1jUxeb/LtY9oKMjQFXC4WRiNaWN4=;
 b=Ji8skqJOvqraRBY0TxyhYTEezQg5DvGl2EMBUILjvk4psZ9SAJcHyZYctHKx+LAwiV
 yAmuuMEXn4s9EQk2pWmgKxxJL0UTsjW7kc6NGBN8Pisj1+E6KgGZTPfesKHKDbzeu9Qr
 0f++SKVpBWDOx2o0bAfOqGeS1BHTy8TxMhYPkEvJlZ50mQgL7jTMcnYYI7IdAPDPdSWS
 bU3sw1MwWxxN/CIO+4t/GDURANSalNUIE2jke43PnF+pCKk2Fcm3hw62zTimG6NgCuL0
 M/zQ846oFALn28Z6lfGk1Xhrkpy/YWv80HIl3Elte+rMkaj7ne2lXWQW4y9Y5GFps5fK
 3Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873852; x=1789478652;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQRlEHUJPfJhJti1jUxeb/LtY9oKMjQFXC4WRiNaWN4=;
 b=Vl4DuPvFrHknsAP5wMYC5ypwyLgnnTXOMxfr/66fycF3TPNNexh1tuRDQeY+QzG9Al
 x7tXQl0KDRrJ169kVhT39WaJgp2d1kdKcd3b6EyzNvNWwqV04fvZ6Vjg+uLanXLX7SmS
 JSIRzHxquKc7AMKYV1CNT9o+Re25+/pQ+UlaeydhafS7B/S3PUMcsGEi5AXjLWP34PEv
 8ClP/lJsJZ4sXE9HL7l5JnQlA8q/JE2c2R8+x5ozf3gLEG+vjaar2YmBOdYNH+tn95Mq
 v0BQr27LLdM/1M5W4m4UoC8btbT1+720nMLtF2NAGdYwf4xAoNV0RMGO4oAgv7dHkx4b
 w+0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn8fy6pb3nxKZadJY7fpkv26vpZeYtQzhjlRuIj3EWiY4/peFtPGrSahokCu0WuQ9Pk5LJ1s4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++modEbQ/szayfvC8Zxyo+2TpJtrBmJz02JaemJhcW8pCiuI+Fyp
 0xtPa4aaGVQO72Dt9XG4TTljRWJlRiAmy9btWGcVRGaTOSlhI++1uRsMBuxPoZpaWYs=
X-Gm-Gg: AYBFou2dvqDr9qLXo1TgyiaNFK/CPixf7M46nTcvIzfaFdA/tgesrgUAPmBGFtrG2A8
 MZXxLzrttv6KCP2qqBQ9Wvk0xPKaalhb4gQf7g5A9JbPplrHuYEfCxRWz7I28exsfIzvENCAgyQ
 pt3hUzzJONnTkxtlACdXVseW1TKtFto3jEktBJsNCor33914VaoIo51H3YXlJvh8cJ/DiLmBfT7
 XATqdF58lb5pyhrAQyVZkuatQYGd18O7PnSjfd9BEgUHHYLGHV9mMlTKPJ9azSuEDotjPP04q9U
 8yfcQxlsk5Iovgryt7PolwBJYn3eJ9iJoCBkLHhUt8Nl4IC9wMXhoGGefSD/qaayhJ5Juqc/Ys3
 Ahla04uP2nZjKFPO6m51Vnf2yQljB5cNL3VftGDd+QRDqlWXzya2efhHa5q5MZ/UER4OTSw8MDB
 mGgEwIDuGiJy4pAdijITN+7RU/RPbqPUnodeCWLzpYE6X7YLE5Fmlh7fjkSWkbDoirtz+LSS42D
 WbHX4ZUdA==
X-Received: by 2002:a05:600c:6306:b0:49c:f5c0:aa76 with SMTP id
 5b1f17b1804b1-49cf81e366amr706896705e9.5.1788873851928; 
 Tue, 08 Sep 2026 06:24:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm294097755e9.0.2026.09.08.06.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 06:24:11 -0700 (PDT)
Message-ID: <da0e98d7-becd-401e-b7e0-310456ad4d9b@baylibre.com>
Date: Tue, 8 Sep 2026 15:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] boot: android: Add AVB verification support for
 different bootflow.
To: Valentin Liu <valentinliu@icloud.com>, u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, sjg@chromium.org, trini@konsulko.com,
 igor.opaniuk@gmail.com, alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <20260818175301.818739-2-valentinliu@icloud.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20260818175301.818739-2-valentinliu@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Valentin,


Le 18/08/2026 à 19:53, Valentin Liu a écrit :
> The different Android versions have their own partition layout,
> so the AVB verification process should be dynamic.
>
> In the new verification process, we need to use the header version
> fetched from boot partition, so we need to check the boot partition
> firstly to avoid the downgrade attacking.
>
> If we didn't check boot firstly, just use it, the attacker can
> bypass the AVB verification by flashing a boot image with header
> version 3 or earlier.
>
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
> ---
>   boot/bootmeth_android.c | 43 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 904640d360b..55cd99f3043 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -479,11 +479,12 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
>   	return 0;
>   }
>   
> -static int run_avb_verification(struct bootflow *bflow)
> +static int run_avb_verification(struct bootflow *bflow, const bool boot_only)
why create arg boot_only which is not used ? android image version 
define list of partition you need to check so have possibility to force 
look not good for me.
>   {
>   	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
>   	struct android_priv *priv = bflow->bootmeth_priv;
> -	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
> +	const char *requested_partitions[4];
putting a hardcoded number look not futureproof for me, i don't have 
special recommendation right now but not look the best solution.
> +	int requested_partitions_num = 0;
>   	struct AvbOps *avb_ops;
>   	AvbSlotVerifyResult result;
>   	AvbSlotVerifyData *out_data = NULL;
> @@ -493,6 +494,28 @@ static int run_avb_verification(struct bootflow *bflow)
>   	bool unlocked = false;
>   	int ret;
>   
> +	/*
> +	 * Always verify boot first.
> +	 *
> +	 * When boot_only is true, only verify the boot partition.
> +	 * Otherwise, select additional partitions according to the
> +	 * Android boot image header version.
> +	 */
> +	requested_partitions[requested_partitions_num++] = "boot";
> +
> +	if (!boot_only) {
> +		if (priv->header_version >= 3)
> +			requested_partitions[requested_partitions_num++] =
> +				"vendor_boot";
> +
> +		if (priv->header_version >= 4 &&
> +		    priv->init_boot_img_size > 0)
> +			requested_partitions[requested_partitions_num++] =
> +				"init_boot";
> +	}
> +
> +	requested_partitions[requested_partitions_num] = NULL;
> +
>   	avb_ops = avb_ops_alloc(desc->devnum);
>   	if (!avb_ops)
>   		return log_msg_ret("avb ops", -ENOMEM);
> @@ -562,9 +585,10 @@ static int run_avb_verification(struct bootflow *bflow)
>   	return ret;
>   }
>   #else
> -static int run_avb_verification(struct bootflow *bflow)
> +static int run_avb_verification(struct bootflow *bflow, const bool boot_only)
>   {
>   	int ret;
> +	(void)boot_only;
why create arg boot_only which is not used ? android image version 
define list of partition you need to check so have possibility to force 
look not good for me.
>   
>   	/* When AVB is unsupported, pass ORANGE state  */
>   	ret = bootflow_cmdline_set_arg(bflow,
> @@ -617,9 +641,13 @@ static int boot_android_normal(struct bootflow *bflow)
>   	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
>   	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
>   
> -	ret = run_avb_verification(bflow);
> +	/*
> +	 * Checking the boot partition firstly because the standard AVB
> +	 * verification is rely on the header version from boot partition.
> +	 */
> +	ret = run_avb_verification(bflow, true);
not sure it's the good solution, so you check first boot partition and 
in a second time you recheck boot and vendor and init_boot so you do 2 
call to this function.
if problem is about on which android boot image version you are , it's 
probably possible to have this information because you check it in 
run_avb_verification to know which partition you add in list , so one 
call is still ok not needed to do 2 .
>   	if (ret < 0)
> -		return log_msg_ret("avb", ret);
> +		return log_msg_ret("avb boot", ret);
>   
>   	/* Read slot once more to decrement counter from BCB */
>   	ret = android_read_slot_from_bcb(bflow, true);
> @@ -631,6 +659,11 @@ static int boot_android_normal(struct bootflow *bflow)
>   	if (ret < 0)
>   		return log_msg_ret("read boot", ret);
>   
> +	/* Standard AVB verification */
> +	ret = run_avb_verification(bflow, false);
> +	if (ret < 0)
> +		return log_msg_ret("avb", ret);
> +
>   	if (priv->header_version >= 4 && priv->init_boot_img_size > 0) {
>   		ret = read_slotted_partition(desc, "init_boot", priv->slot,
>   					     priv->init_boot_img_size,


Regards,
Guillaume

