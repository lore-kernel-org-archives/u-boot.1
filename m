Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC85C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4D98083E;
	Thu, 27 Feb 2025 11:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740651059;
	bh=RdNShEAGhQtdWKMEJie70CUfh/Fwve3Du8xDoqfmoHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dTdgaZnbyCAk4hoDWYXMwjVYZGP4AlaeAyILkmMMpU9/+zCK8zvKoYKOcLegyDK37
	 16hI0Kz0Pz0DlzNVCZDIYPaJCsjxNhBP3TvOkx6aaBtbyOAxH+vZYuuXTBmQpAppM5
	 Kn1vl59JAia7kUPITl3opO7qnH0quzh1fnXubCaRVJ62KeI1vtSrHdYTxR9D8cmr4n
	 kZ4yw6THE1Th3FzcqAHzfWR/1jsDAktO2bH75wtwe5S2SAJ5f5IQgWh1ffgl+lZxnW
	 6GTLzBsKvq6xS317NjpFbE6vnLFyVvjOt9fbEa1qJvo9IpitAaDZbRbeNM0fz496en
	 UwA8Xk2dwYdCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7347880F12; Thu, 27 Feb 2025 11:10:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD6F807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fji3EDbb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 147E710382D2E; Thu, 27 Feb 2025 11:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740651055; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdNShEAGhQtdWKMEJie70CUfh/Fwve3Du8xDoqfmoHk=;
 b=fji3EDbbqIxhxZJnibCA2uQKe8NcXCK0AyHpYygQ/IU/n5LNtAo3vCxJI6AIJSbd8Fq9db
 RjdP6cLcbPh/Y9ynZ19eirq5GMQ9F4JSo2Q86qqaad2im4uC2RJQko813oLECc1AJ445oc
 YoWY8yrmmp+CENDLSMNoRLOS/R6/Gtti4R4Pi0At6Lj7rgBgTeWTb6vdB3Dgsq1XoHwA11
 /NLzlGShmlySssOYGmnnjdKt6Hj8yPerNYv+jDa3zGgeML1aaavXqbeNkUB27o5k1U9u32
 gMcUUJkCeRlHLrfdNclQsD8OZEUCSIaRlg5gNgK6fnfh9kEVtgMNDlscKYuAuw==
Message-ID: <19e777d5-6c09-7a2a-6ccd-01fa556bdf2c@denx.de>
Date: Thu, 27 Feb 2025 11:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
References: <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250226143541.GI2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 26.02.25 15:35, Tom Rini wrote:
>>> Yes, and as I've shown, you can also use labgrid without going down the
>>> same path you took, and we can also support other lab management methods
>>> too, which is important to get as much testing as possible without
>>> needing to centralize everything.
>> In summary, I suppose we just have different visions and ideas, which
>> should be a good thing.
> So long as the project can speak with one voice, yes. Which all circles
> back to why I do not think what you're doing with u-boot.org is at all
> helpful.

dummy question ... what is the plan for this webaddress?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
