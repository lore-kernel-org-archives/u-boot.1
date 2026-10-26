Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBC606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0FTids/V;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aQg7SdfH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97CA980993;
	Mon, 26 Oct 2026 09:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZzx9A-fCxsX; Mon, 26 Oct 2026 09:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDC228096A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007255;
	b=l0Dr8zov8E2EuKPONb96eOfKjinlf2/o9bUTzNICl3JONesczFXochPgCToYGwICiwvo
	 Ye4U/REfOEoyW5F1V3AhMYMag5UHQp/qN6mErWMkRREjAj7Wn/ko55Je2f2luvnnKuiYR
	 TX0val9swuQ6vblo1cFsBpxvmqzJE0DbK5QEB0lAgVICGiNwHYJglcdvs/B4VF/8t8IIP
	 HWBdbxvIEzm/qEygQF6Rtk/s0hPAK4JScg5Qbx9GvtPQmFOVpQ4kes9StpFUsr8HcxFJ8
	 ovG7E/2DyK4lVv4oJILgq2ru5faOfgUfWf7LWh4ZksXOIF3l8KrNnZ6oPzxSaVg2bxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mx2DSBJks3ertiT0FSvmezmBqBOgLf1dtbwQdpuQ2tk=;
	b=YYsYYP8C2eruBmZQQIqWHnPOf66E4TNd6l+fwUdvHOcz/+DSoJj3cIFR8Ftqp4l5RA7h
	 isWeJ5kM68lNHhfylXxnV1ymyeELWALuRrObRUu3wKGFcMh6IBB3aetjOl7fkAiaNuRlK
	 O5p5i45P7K1qN019HdsTY90RTOVmBSbBYc2qzhUGJ6sEmRAZkhykj3TxtiMLZVpf/gJFx
	 v8AC8cmx75+ycxei86BxiS1qIRZTjW8vZJNyyDSej2M0RfvG7iQGSLYCJc+CcZNsTIxyU
	 qQA4WWzq7LLt7vk4EbLN9L8UIow9xkRHff7p45t2NVkqdXxkcYsqz7rWBADtoG73xbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aQg7SdfH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007255;
	bh=Mx2DSBJks3ertiT0FSvmezmBqBOgLf1dtbwQdpuQ2tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0FTids/VvLQ/df/mkWX8W4730m7LPt6OZTam/UNsQvW7qBkYu6cK0TF60Q3yKtn9N
	 Zy3ywBmYKzq+wvQWHAgi4agzvBzaDNMmU756fgZYo9wtBp8VSYP7xrwLsZfM9TxiCJ
	 44pA5IJAsQTzu52s/LHoaHQHD89WybzOJM0bbtZk18cDuxrif0ec5X/Wxw+YQdMGCJ
	 urpRVl4z7VO6m7UXZtOtUQUO1hkq/8K3g6G4VuzAJY6suFaTyakorCTgr54QORklHh
	 8KBrB0pDzHYJbgKgZu3ySeKCim5lKF3Et0W/Qau4oKNYl+mkEe8xpkGN38k/rc/Ais
	 XyjxUXfeN6zMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDC228096A;
	Mon, 26 Oct 2026 09:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C4BF279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 130CE8096A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0P6QChcBg681 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D863808BD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007252;
 b=PzjdZ8eDQU7nRxBeX50F7X+KjckoO5yo/GJKha5nkgEFef1mDO5jhB4MBfz0SRPWgYVw
 ARA7H6TtCZQ6ZRUxG5k2T6sBJmn2g3APybB5zQp5jX1zoNFYOm7CFLflFgVLKa+XC2KoQ
 VAh3PKxEczffiB8JqbKRLCH60EZ1UrmKCT0fneY0m2MNsX6XiLsN5ZDtfNZsHqzgmJVhA
 QQu2Bu9FlZdAvbW77HCKVpMwKJWBdCkuikl904icmMnyGlefQm9Qi51SZEyFk2dmWOUdw
 m4M1CHHCj/2TamnNzmjGse6TzBqvFaKof/MCKIBUK50m4zj5xDaZoKH6JSLDkZ6nZJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007252;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Mx2DSBJks3ertiT0FSvmezmBqBOgLf1dtbwQdpuQ2tk=;
 b=TW72h9MiCJzZBYzNshzra9UQip15SMc+Y7bciOjtLwEv6V4ry1n9geipH5/Gt4azENQx
 O7G0KS59zBm2kFYcgmYcjVdJ+XxAxIV2yRmR8z8aojuwYf36nVW65b1zHMiVzxqshymNU
 aJHm/pJC5mpi6cva3ON/33q/z4JNWTlvqQ95bdRmVMRyJw8AONBjsT75Tfjmr7xbM5DI6
 tKgkR6oRqwNypAupsGKrg6C2EwlMYQyimqNtLis4ZTyl2Newl74uwCJW3U7EK+hVOseul
 ErgFtY51D2wxiN7o6O283B/Cndsl9UcrG37tTTUxS1B0yUyju8vhsWqaRwchVaAtHsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aQg7SdfH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aQg7SdfH
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D863808BD
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:11 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2836942f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007250; x=1793612050;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx2DSBJks3ertiT0FSvmezmBqBOgLf1dtbwQdpuQ2tk=;
 b=aQg7SdfH5SHjiYydduZ/9Ak5+CiNsNxiiF/Uy7hCzEZaPRMOi+47jp4soUF/AagwlB
 yDy04N0nSb6HmXNwmAHjKWaELRDG7BCsC7EyinQaYxyDR37pau6YZj0dXyE0omExtRKP
 NmzFsQvSSY1SerPkd2OYjyftvgOafoeEIw98hGRyFvwlT56mUn+9w8EIt6FRKbLX+mXn
 02ROassdXClf5hl/KxBX6oMaBC+f+fYFIQIbM+yMD8FksUXaHPSNhvRBQTtj7nJw8AI3
 xs/YwmMmjlH8zbxhw6Yg71I3G34uUUDDuHLYpeAMyhUMJUV8YgkZYjg/yK9Qutc7fwtM
 yPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007250; x=1793612050;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx2DSBJks3ertiT0FSvmezmBqBOgLf1dtbwQdpuQ2tk=;
 b=w3W9eLQHv5Z+PUHyIcvEi8tmtjo2CtYKolXKBNo6hfCjtu7Aq+10qWz9TsassZuIvb
 cQQEARGfXG1dmmjAYCuFKhOyXde/NDuOuhbH0uageMg05a3Jx5uATFvTJwR/0TBAafVP
 QVXDPqLSvz/x/Ztn7bK1h24Zs5VKlLur3jWiSJe8SvgXpDNRXx4WrYnEAvJ1A7rrN57D
 CO3As0Fi911ML7ZjEh4TvxpgoKZumBptNsnIk20kJNXBHlRaPUT4ej37LBuXE6wdeK8/
 pjQKKK98Hfx9GlSPbBwIEtmvj8kvjwXxthUlF34mKO2vc4m9zoDU/ycdCrwV5LIEuhmu
 PKaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH09/klolYCVb4LqZGcPzjinh9aBkDGRH2iQ3XU90d5ZQm+SedFMF0LCuBP0tZMSL8c77eg04=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJpPs0lRKHvsBZ74gkjvMsTHD+v+k7IlH3faam2h/HfFKz8gAb1
 RgCkdBaXu1JZjaZ26iYxq/O+l28xJBGheYUoUEs6YMsAPrY14BJL1wxt7cUGudHaTek=
X-Gm-Gg: AYBFou1jqDsWu3JE0oY1AglLY4gAFhFTYuRDeIHKLp9FvUeGa4Y8gUpRPwr/MiGtH+o
 T1BfeCszxYjGBSRO+8qY12tortSTj4LWWILYYgYNJ43Hm38AbXV5hsAj/LIgICTdnBo3CRJXRZq
 eu0pZB2QWyZ65N6E0MFkcRk/fxgelvMluaEDMJOGOn5m+Gj8o60h/+W/UxQoYufB2OP//ich/rA
 5mdRl0EWIwx3fU9UX424wQVMteQbvrrekYZI8Q5234BctFNdjx7RLt2BAq0FqfFoi9nwFuRnUna
 qXdGNK5lO80648BSg/g4qfgz4g67QHJS35HSXBQbpEmCPURNzTZdtbUd9XftFxHUsecBjqn7yIa
 mpT0pLvpspq7C1G7EFPba8cM9SOuDKNv2Mq30Vcy3s8jUjkuEsKyBU7EXu1Okf8/Ouno6bPYOyC
 FmKxhy951ucTUVJWhs9uadrKcRxeAq6lmTUoot4HRWbcWi/Jhvs9H/MQLxcBZ/v4Aj5k6h0K09+
 Sj4SNjQSNMsAzVPg+m06iiH4rxiUpEchIVN8x/2RtlbqYwUm3nAVVYCldiheU3rwH9Dly43Bwut
 aU40gFVHoWW8r0ky8tEOBSKWj+w8ltbmC2EpqYPPyMdcScwGdT8TSYR1WJIaeZz1KXnC/Gar
X-Received: by 2002:a5d:5d0a:0:b0:48b:f92:1f67 with SMTP id
 ffacd0b85a97d-48e3eb6eff8mr9011978f8f.21.1793007249626; 
 Mon, 26 Oct 2026 02:34:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm14479474f8f.43.2026.10.26.02.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:34:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:34:08 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/7] arm: mediatek: mt8189: use phase-aware PSCI reset
Message-ID: <at8eiMobGa8XvYlv@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-2-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-2-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:08 +0100, David Lechner wrote:
> Make reset_cpu() use PSCI only when it is enabled for the current phase
> and fall back to the watchdog otherwise, as already done on MT8188.
> 
> SPL runs before BL31 is loaded, so a PSCI system reset is unavailable
> there.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  arch/arm/mach-mediatek/mt8189/init.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
> index c0b7050c6a3..a0de674c452 100644
> --- a/arch/arm/mach-mediatek/mt8189/init.c
> +++ b/arch/arm/mach-mediatek/mt8189/init.c
> @@ -7,8 +7,10 @@
>  #include <cpu_func.h>
>  #include <fdtdec.h>
>  #include <stdio.h>
> +#include <wdt.h>
>  #include <asm/global_data.h>
>  #include <asm/system.h>
> +#include <dm/uclass.h>
>  #include <linux/kernel.h>
>  #include <linux/sizes.h>
>  
> @@ -32,8 +34,15 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  
>  void reset_cpu(void)
>  {
> -	if (!CONFIG_IS_ENABLED(SYSRESET))
> +	struct udevice *wdt;
> +
> +	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
>  		psci_system_reset();
> +	} else {
> +		uclass_first_device(UCLASS_WDT, &wdt);
> +		if (wdt)
> +			wdt_expire_now(wdt, 0);
> +	}
>  }
>  
>  static const char *mediatek_get_segment_name_string(void)
> 
> -- 
> 2.53.0
> 
