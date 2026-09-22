Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B2AC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14E9440593;
	Tue, 22 Sep 2026 16:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qPsbvcUAr8g; Tue, 22 Sep 2026 16:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F9184059C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094465;
	b=GPheik9aEqG50wtWGq/9web/ypIm12eu+dXG8bAhjisk+VOTLabpZIUqmVZr5ntp6VGf
	 FLqVpACwVLoMnYp8cLdHDNMSuqtV+fpdX/BKmI2avzrLn1c55ieUGBubMxuW2Nn/tqDSk
	 G6Udsu3PmrBP26+Rs2puD7qGHl+AaTm0lENQmByq/pSBDtRyIbqehphXrL619ThykyquB
	 pwIXCoNAfvHsLoL9hRYfeODAA0sRuXw47m6jfnHfip18GR0Lvm8QFA86pOqaF58LnQgvL
	 rErcp5O2LxkWV2+ydpIDUkTqDCKLLrdBDLaxRqeLj8xiMQvAofn4ygm1IE0s5tz2w9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790094465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9mrlv9zOD8WTR+QwM3vobqMpOn5bM5o8NZcwQtU3vvw=;
	b=oeFpKt5VHDvmOzmQg0tHOYA9FZK90wUVaIVxDd3jhiqoN94VsYcHSwyh61uHcWuB3jF5
	 RVGd2y+/cuhHU/tRmi6ZwXR+ql3XscG+6s/wSR7X9c8LO/fus3OCXJKYbf3Hee/VtIrzW
	 DVaZza+Nvc+PxwcKU9lNra0TenLgknR+RWTh1TV4AZNAJASzqud+U4UTUHrBstMEYW/57
	 lzYVvas3KTZcO9bawkey4DqtHDz5qU9DkmIruQmAKs5GACaA6tZoVuUu9Srv40AvuTVAo
	 TRVp0CUx6bPImAFEVrGnbB5svJ3BQlVduoVotP2/YoeqRFWIszmZil1MyhNF45u1PPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790094465;
	bh=9mrlv9zOD8WTR+QwM3vobqMpOn5bM5o8NZcwQtU3vvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4Z0d0+AjVZfEBxmZrU0CNh4NA0oJA6m09zV4OUTIlnfJ/qFlKAzVWnVr/tCIbE/x
	 9S7hH0QZCc/RxzJNtBzXc5fyyt8vloy64WCvQWhSucNF4Bynscq0Ia91Si7ru1SIr9
	 e8Zzs6iutFG71dlZT/sPn01ZyWaTktEdkh6ZUI7Sa7T9cI7/L0YzXeAYpGlzxTr+2t
	 UexUT2UlNsSxKsV1GIRtyF/4D/ohJPEl2xZKrsS53E7kW1guqsDu2Gl/9lxgdfwT0I
	 tqtR93SsQCpLJy0wMnHYIuKpZ869bdF6yFMy40ZTFJnISd4W3CRQDBPDB7nLE2NjBQ
	 +YO3XL30EemLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F9184059C;
	Tue, 22 Sep 2026 16:27:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1E4C12C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5C8180C16
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmDV8L3dLShj for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 93EDF80760
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::20"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790094460;
 b=nUP3WQm1WRr531ti6MjB9T2xP7LE5cXWP1HDz93GzejMZ1bTtsQo1Sky0OWfHElATGDh
 AMK7dWy7NEj0lQfBsulnuPESFevF/s4PdhBfMwICgSpx7gVnDQmcuY/jRmpllmwYLdqZ4
 BRrPTL8Yj5lDnqyBjtQ+5l3IzK/PIQMkgCW3+ISAK9CpHa0KzAVmseM+/oYOCy+Cu0p9R
 krP6QavhJGRvn64lDXI5uPIIYuNurJQEHgBfBaOz09p8z176f9RiKFgrZGdef+pZclnIk
 2RR7mLkmuT5liCXBgHvhy1pMRtF2l4K47IiIC6n2RkE3+SbI9bDJh8Z08a0P5wbMI4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094460;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=9mrlv9zOD8WTR+QwM3vobqMpOn5bM5o8NZcwQtU3vvw=;
 b=MnXcmORlGQjh4hexxT8Pu0EjGgswrbADGHIG04TheFxcZtZgbNxopPXqA5aPJR/7LGtO
 mssbmS+sI/DgFg2lwWO2avLiMYNF94t1PD8vYKYqWvJb6ao1+kSwMptoVl6lteQIvK9oR
 cA0PWO88HIx3CRD8dSYsbnhl7pB2DtPnOY0Y8RAZ4mnQ0lMALby2QM4Kid/0VlZHw8HG3
 GQSfftn+QCbWlJn9zVB3VEsppVYMWnulkYlPakW1GTZ/lNaz2eDEqJatbhls+vOoanJN+
 4z0re+EwJ4D6p2evl0uT4lp1Q12X+d1ugWb09QOjS0YcqJdP57boTQC3FOvMYN8Om8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VLEdSr+L; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::20"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::20; helo=mail-oo2-x20.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VLEdSr+L
Received: from mail-oo2-x20.google.com (mail-oo2-x20.google.com
 [IPv6:2607:f8b0:4864:31::20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93EDF80760
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:27:39 +0000 (UTC)
Received: by mail-oo2-x20.google.com with SMTP id
 006d021491bc7-6ca35deb7deso8285eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790094458; x=1790699258;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9mrlv9zOD8WTR+QwM3vobqMpOn5bM5o8NZcwQtU3vvw=;
 b=VLEdSr+LrYM6ZJ6myaAuMsbWWqw2232M5lAtb5y6uI+xbk6SkxjsmbLhz1tMy9Gydd
 xErzZopr4jUZ5AcE2ykgNTAhGi/a/+C6NYzcxlu1QvQ2erE27tJq+bdTePYTmq7LdW8R
 GatHEiEsDVThufvIatdWObsLYjtsipfepQgBqk9fqXrQpcPeYrDzLZDmtc7pnx0J6O4x
 LtQbvme3mrKvcdaEjfcVgqJ68pSkFX2sSbebI0kDqpAJsP/y1dEsl9kAxzHdx/AhGQvw
 4gZlDjhtowshPhFqUK2DgRvL6MUmHNA++CtAl7JOSQlaUSfWTplwTU8BXhwg7RmNuxzD
 Twqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790094458; x=1790699258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mrlv9zOD8WTR+QwM3vobqMpOn5bM5o8NZcwQtU3vvw=;
 b=QwUq+9JO4HAFenE0Lim0qcxql/IVPvtwx6ZMfrL6l9d3EeGdTgvrxOMmlUvgcAXCu7
 FbaIhLMbmUQPaPm+QtnTEq2NtAkKXevuEV/SQgZfykiSCITETJM6HgXKnZ0cHi1wMjce
 9ijkTAm5e78aweXpMDIe0PD/FZYO4PVno4mZQtTFRDA4LpVOm782nGfz95Wa+sNXFPbt
 BBEPm7SDsGveMN9zB50MP6gzg229Qp+uwY3Vpx6ungCkrH3ewxFsWjse4CIdYeqyAXEn
 CQcQwKonr/mPVdKzn5NJsD5auU4v1dFciv0IGXFX7dvplAh8i+lL2hPZMtKc84AHWYO1
 WcdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykeni5aLSUO8OBumQmQrsiM9gLYV/gqURz4UuZXEKNOHm+uvaWbd3VmUHrg3kQsFNPvcQI9VA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ncquCPeLRDyW6c4hECICaq3DTQ4brn4Ycp7D7p6wu8z9TWl1lD
 niR4SYVm7TS9vGbPZDD29viVNCzxlhoXJ+giVPDI7BZqLuzqXWVWkD3kt16wYOqJ1Ws=
X-Gm-Gg: AYBFou11UjV9HzOqaFAoKwONTNNR6jBIx3auOpiRgBPXgJ0C8J/K+AE8RPBrDKXyvmx
 NkkNUjAfs3TDtKrB1ROHiOiXcu3aQMWcfCuLwhTFWUt3aJTG+GhB9YyzrDwoO1jtzuo+dThgo4Y
 1cRJpx5wlXRHv6Tqv2+oT/rSZViEA5eI0BB5S/AaWsA+j6jZZBdZ8LYAU5gCDZUrekW1yxBtT00
 tCQ7duvdOoJRXy68gLPXqmTrF9fFMxsfvsf1wwBOHQjJYcmPO6u2gno9LlS9lBQ+vrgt1xAUJb9
 kul1AzdryWHJVmswfRbb0zaa6QeTGuH+/v2BGkYXNRBHmDpud5FSPUmb70rBjr9BWzkiClTZq9H
 xVBOsm9Ru1XPVqhDApMoObkhq6APUoECuz9SXaqRJMXPH7YCmjiHLT2FoChB56KrbbS43fBsUve
 rdBJNycxbDNzIRcm+mcSTNfw2sfJ31H8i/osIDySy6VNoJu6we+EhtnT7TvrDHjxlmLG84UheIJ
 gXSLLWyrHTJbwCteUEFq1mqM+QfV5rt+IU9JJnUo5O5N1L0
X-Received: by 2002:a05:6820:2213:b0:6c7:b623:1f4a with SMTP id
 006d021491bc7-6d15af696f8mr2679430eaf.34.1790094458194; 
 Tue, 22 Sep 2026 09:27:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e?
 ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d1de9e140csm1817821eaf.10.2026.09.22.09.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 09:27:36 -0700 (PDT)
Message-ID: <6070e105-ef8c-41bd-9dcb-29f6f0b92af2@baylibre.com>
Date: Tue, 22 Sep 2026 11:27:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 9/14/26 8:35 AM, Carlo Caione wrote:
> Some provisioning flows need U-Boot's command support in addition to
> fastboot. Provide a U-Boot-based download agent for Genio 510 and 700 so
> these flows can run without relying on firmware already stored on the
> board.

So this is providing the same utility as in the previous patch, but also
uses U-Boot proper? Why do we need both?


> diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> index 6f1ec052b95..75b51f4986e 100644
> --- a/arch/arm/mach-mediatek/spl.c
> +++ b/arch/arm/mach-mediatek/spl.c
> @@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
>  
>  u32 spl_boot_device(void)
>  {
> +	if (CONFIG_IS_ENABLED(RAM_DEVICE))
> +		return BOOT_DEVICE_RAM;
> +

It seems like this could unintentionally affect other MediaTek targets since
they all share this code. Should we also check one of the FASTBOOT config
options here?

>  #if defined(CONFIG_SPL_SPI)
>  	return BOOT_DEVICE_SPI;
>  #elif defined(CONFIG_SPL_MMC)
Should we have a precursor patch to clean up the existing entries to also
use CONFIG_IS_ENABLED() to keep this consistent?

(And I assume in the config from the first patch, this would fall though to
BOOT_DEVICE_NONE since there is no u-boot proper in that case?)

