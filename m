Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA82606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VSYVZaEc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J8dW00va
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EDC780E7C;
	Mon, 26 Oct 2026 16:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGT4PNPEag2k; Mon, 26 Oct 2026 16:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DF7180DEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030849;
	b=NvMoF0T//LORbV8+NY3oTLP8My+bxjSrtSVoJmhyYXS2y4JhcO6wCg04m6rSl4i0G70U
	 2QF2SGx5cgW1279SXFRRpvOfLoIiFx087MGk0EPSsE0SqdLyR3da2UBYb2hOsAEf/GRxu
	 bZSnqi0IRp6/iYXIf4hVfMZK82/jPk+Qkf/jHFgHjIBxAdwJjRbeqwgiW8XYU1aQCFrGW
	 QX5CU6fM7jWybNaGjxI1PLnJxaWIrQkTFcJCUt1Obk4Ii21l6jPA6X+gxFVGkMkr6JakX
	 NYKol2284wQS3AuxYc95lLsvPtFYqPlei3dhm+hAqItp/2UtyFEcHEkk9+AFF8HcIsw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
	b=qAti2begVeZWIDIPUusl56MOOWsfs4YUts4y3VepfEgFzCsdXwqZK/ehQpSGoMekzwdL
	 lzrEbXatPujGqcFOYPu7KX21bpyZhpVHe/VGYDMhDY7xspkvlHaWeMBH0QiTPt6ZkRtrj
	 j6OoC4QrZT5anTPoiwN4r8lASAeaCbcGRAmzb9aLMUAuF3Mr/wvKD1Xe1s1HPVQa+TE7x
	 x6WXZHB//sBeHmioGFUtdViWTFqW4rw4iTWJkuHNkozTbl4AfdjQaWRvaxj19gW9Olc5c
	 QTJoWQzhgjOoBx7Y4aihZUdFrL7jVZ3ZL/MocWDZdswVFX4NBt9E9peD+wNhRDygvZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J8dW00va;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030849;
	bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VSYVZaEc6Fpjpi9Swss2VU8V8m2N2LZG5XR6+KDp5AYsE2HWLD17UOV0pTWdn6jIj
	 sJQUcRpZRsX1n7xg0q+x2sgEOlWspxklDRtiJBlNjnNiafpDgbIVJhiosSBi98nnV3
	 F7utsIoF9W2deNqnnDNxmgNqNpLe4cUNTIc7ItVBVaHn7hxaeXTOH1MUeGzAMhLifo
	 bVWGIHytVQUO3leZwzp7T8bMIGcKbVO7FlDvqglaxLAHTevDYriGdK2KIVV4L8kDaG
	 SUR2Mf28R0bfb0Y2pWwMq4HUyHJWPG+q4jvnzH5KbJgUR3G3Nmsy11wX2DYKmWsjar
	 PZwkDPIXBuSfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DF7180DEA;
	Mon, 26 Oct 2026 16:07:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFF002F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5CF880E7C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4s_QkfwxPSE for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EACAE80DEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030847;
 b=Ps8wTqqwNZbGeGSrHw5gZ5/IlQ93KXIjJ4EmX7xROY6RVze9pntfte9EvB1/OxQ+9HUh
 tFamsVsbQ0BgJDgtVwU3OS0mGyDa2PMIM4SkeS/1ykzK0tPo5w4aoF+y61KxRtFEyj70Q
 Z63xFvytMZ71d13KM36XClecCoUfw+/OlYhVloUcCIQLXpRQMlG3ZpvA5fFFuYt97QwHB
 1AAyxJVQ4FpKjVazxWlygyRA7johIc3laRi/Nib5SirmlmU7xKr56z8LtayqItGLCCus2
 lopkgNeoxoDXr0VG1VLFdPXhEs5RXk0qLmgq5lAFg2AeXEMS/CfyVQ7m1+g2aQgOivw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
 b=qnTRXSCeJDwCmCSS1gtTJYxfDIqf9jf9ILEz5Ln3gNPVv0u9bgIrZBTQx7xRdwop5b6R
 ufQqcOINju+Idk5GFykzxP4fC4x058avtHrW44YNpsup74833NCQoCc5R3x8RosBeApId
 B4/7/DiMLhjZRp0n8akJ+EqPN7lTufpKG9iXUE7T4P9OQxCHSik34vYWl0voG5q4n0DqA
 gG5s+jtKdejlyVTsQwrAgHfYAkWFV5SjihfHcxr3Z73vmZNn+3Qsvy+qlwRh0rLj/HnDu
 NWnEZDCtMFhJ1/evaJ5HpQePAF8My41EZyiuNei+liMshag3/hTdfUXyy3xcascE6lg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=J8dW00va; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=J8dW00va
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EACAE80DEA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:26 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so1696284a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030846; cv=none;
 d=google.com; s=arc-20260327;
 b=mG1hm+8CGfq66coykFeYAcM5fBdzW7+T54lFh1gv8s4qnA28kT3dw/Px+jYFmQWAoa
 X7asESFAsO4C1zuheAxZtILHMsHVa8hQ401gtM8y13DTi/vCZKaKv3cBuIGZlzKqWx5k
 b5lK7a9YBLNtT5Y2BNxzRoA7+fOLOUb9BNFMNpcW9q0M1ZXocngkF6SGz0LF43QdP2Dy
 39mMXL4mv2wQLwOAC123yc4B+UfnKQ6oAbFysOb6hspaIzIgpEb/z7lBlQch0fTkIw5n
 WzXupExR20vHqcYJLNgmElzg//lQe5sBJRUGH9DkiHtTwrtM3io3qssQEoXxuUk3d4d5
 kwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=GauYjZEDQnBIY80siSL0OQhYOZlEK3NsyCufA6dY4uXlcKylMrjfgAmIfM75+FfWkk
 1Ox//XISYJmVADFZmatBtNfJkD6AZHUXIJy9wanKkkzLVm/gIya7gsKA5uZBs197dAAP
 vYzHO8uGs4LwABi71cyH1Zq3dwBrOrDOLRQGEbG6/Sy55LERhsoo/0xzrP31t6sEvg0u
 RNIvTVk8N5YFctddIwgCkNLFIxWyFcwcJcjSgolBhM8UygVFAMCKtuWkdw0nMTbuMrZM
 Ty6MugrDr9TOHB65SFdhEJDX5qBNmRuKeDYCXAJ3eN1HI6jGioQdXfMpppOi3y5xdF9B
 P/VQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030846; x=1793635646;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
 b=J8dW00vasOgWmmdlK+jnBWnzlPbmAIe3JECZXLllkV4wMrQUe8w1cEO+HYoYKUj6GM
 iiSYuNA98Kyg3Sb0ep5J5ZbEXgjc0I+yXm7edNy09w9XKdt1uRrbdqEogSNhMisob9GV
 TQgSpXo4HEnZ/2OslERZn8fdo16MQQxXDkjEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030846; x=1793635646;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xMrnejIIeNYd8AM7AXML+/sceD+v8vPpROOyRc+JXao=;
 b=hkDjJ6frep0BIrA/xOAYKjSmaOtG6PTy6AZIRViwZzvhaESQCpSrpmjSQPTDYG5EBN
 6ncRx2Jtp9uF86r+2oipyxT0a4jUYew0V6ldJskc7BqwqjN4FYbA2Jj+rfBEgIw4WYUt
 nXipf/ZkFxO0YIdT3/NpDBapJmjsJJr3IfKqv77Dh5YiVrxqMYljQX73ItTd0SbbU/Bi
 X8Wpga65SyqYaTRLBozOW+/v3fmZVNewrPk6rFH/mqV9ifai/+vLVes2BzTrpVF5tvyE
 TOwFOTFNpb6fDp7E1iwNEirDeHlisEPwq5aybRjmAQFEBKDBk5JPtWShInQBZTMQVJUQ
 tW1A==
X-Gm-Message-State: AFq9FYIGbqgeEa3m1f61QOQ/pUnQ812+0EvY/2ogtC4W7p5u53UZNzgD
 Z96f2y0XeJ+zzygxiUcIMKGMn0jNAKzKpGmUm4/4zcFVH02OaBhMKWRrsE7UXSzCUMoaXClBxE8
 tiUnr25EQ+Je3TssWLR2c9I0gRP+oi68Cpi8/9a0z
X-Gm-Gg: AYBFou1mkaO6HQJ3vOiWKAVd2h+5BNlEOifIdjujDN6SXU+uYs+1y6gYqsFG5N/48Uq
 xkdBifdom3kLPi+9rYcXjW3EfGnlJ+nb+sOIh1RSCsLRRZuahEthV8g02H62yiAYferPnSJ1ExK
 3CXa/AG2hPkXojpLfSmMT9kewQ4jWk9UPZRV/240HqsO4F79yi6WDOUJNTfYZsdGoVK4qiA4dla
 YKfEvCXkIVnFYXrk0NMWIRR5jmU0cRXBj9Mq/cpRqKyzVW9QbXxIx0iyKnojSrFguWyCMSRgzkm
 hKUfSJZ9d56VQh7hy9BQyfV7jxPkKwGpjynSZUZEB8+bmscsoBuZ7AKJml6tYngyD4c5CecQKtH
 OojlEenxKqzPXxP6aeZ9KHie6KXxXDMBy3b4=
X-Received: by 2002:a17:90b:2642:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3adead4c63emr5992570a91.39.1793030845817; Mon, 26 Oct 2026
 09:07:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:41:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-5-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-5-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:21 -0700
X-Gm-Features: AclHuK_EfSIGw4SQg_U_sBJ4zEB-8vwCAX3dIJiSB_uTs4oHl9b4-RjtvfYfcCw
Message-ID: <CAFLszTgYVqecfgvEbuBvq+Vtoa3pOd1mf0JnA9Y6T1QhWKJEmQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] watchdog: max6370_wdt: add get_timeout operation
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: max6370_wdt: add get_timeout operation
>
> Implement the get_timeout operation for the max6370_wdt watchdog driver.

It would be worth saying why this is useful: the device only supports
a fixed set of periods, so max6370_wdt_start() rounds the requested
value up to the next one.

>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  drivers/watchdog/max6370_wdt.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

> diff --git a/drivers/watchdog/max6370_wdt.c b/drivers/watchdog/max6370_wdt.c
> @@ -65,6 +65,44 @@ static int max6370_wdt_stop(struct udevice *dev)
> +	switch (val) {
> +	case MAX6370_SET_1MS:
> +		*timeout_ms = 1;
> +		break;
> +	case MAX6370_SET_10MS:
> +		*timeout_ms = 10;
> +		break;
> +	case MAX6370_SET_30MS:
> +		*timeout_ms = 30;
> +		break;
> +	case MAX6370_SET_100MS:
> +		*timeout_ms = 100;
> +		break;
> +	case MAX6370_SET_1S:
> +		*timeout_ms = 1000;
> +		break;
> +	case MAX6370_SET_10S:
> +		*timeout_ms = 10000;
> +		break;
> +	case MAX6370_SET_60S:
> +		*timeout_ms = 60000;
> +		break;
> +	case MAX6370_SET_DISABLE:
> +		ret = -ENODATA;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}

MAX6370_SET_MASK is 0x7 and all eight values are handled, so the
default case is unreachable. Since the setting is just a 3-bit index,
a lookup table would be shorter and drop the 'ret' variable:

    static const u16 max6370_timeouts_ms[] = {
        [MAX6370_SET_1MS] = 1,
        [MAX6370_SET_10MS] = 10,
        ...
        [MAX6370_SET_60S] = 60000,
    };

    if (val == MAX6370_SET_DISABLE)
        return -ENODATA;
    *timeout_ms = max6370_timeouts_ms[val];

    return 0;

max6370_wdt_start() could then use the same table instead of its
if-else chain, so the two cannot drift apart. What do you think?

Regards,
Simon
