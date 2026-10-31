Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57804606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yOE2MrdF;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PGrNmLXB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 307A680863;
	Sat, 31 Oct 2026 12:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6OvFijPUlnp; Sat, 31 Oct 2026 12:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AFA180879
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793450037;
	b=AeLXrgLOZN5VPCZqpJweVtwyqfV0+JPlYwsR1L1Qs38Dsen9pSnCyvjBjxpHxiBOPOT9
	 4Cs4QU/09Ci4SW24a4AxwQ7kG3tsgUTOaBEFYksgfWN3JXkXyo6s+cEXVDxg/+XcRHsGa
	 2Oo+a4g6EYd/mt8R0miH18+NCqLz9sNsQ632uhdFoZDRCsbJAXy5a1qQ3BCq88IaAHI+Z
	 oyBrMUxgMCV1bdbG2FJRS6YPpJdsOK392qtT+Erx/K8FyPpl63AxEmMj0BYjIN8fE2OaG
	 OK8FJJRrs3vA4MTbYPxAZdICv7RsqQrcD22CAUFox4OWljEFH/4EXyeQjqcSmmJ0GCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793450037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O/ZitCqUnmmf9W/KUGjEnUl0Wv1/bkoC3NNu4G9VqCc=;
	b=R/kxPENkwPGzKDw24GQwrdqQEQKJSN3CidP5M1gUv2YyIYgMNQuGrGXnen3iKR7zpR5+
	 7+1S5iiclMKx3iQBLMwH/6dR3cv5Rw5gEGhVhQ2YnOgJTGCUrBZaM6YpstSHJWpeSjsDW
	 UyXelmhnqrNjeybLIj3CoGyKrRySDMPOUookFCsYAdZyygytQyHezfHcqjm0p3FhzTiJd
	 lvjr6AfJdp9T0gHPzPQlfWNimcOYPiRgHoA3/t8Tt7rwJ+0oeJY9DVv3KYe1cBWnwO00C
	 ZikYH0nnaja4LjFQINfJm1RweSSVQh4fNY1HiWqvyNjBRGNC8M0qapbdlU1bpqhDysg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793450037;
	bh=O/ZitCqUnmmf9W/KUGjEnUl0Wv1/bkoC3NNu4G9VqCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yOE2MrdFwGvl4pFTnv37BG8H8YaO+OaRKnVFOLLKVcChwoLSQCU51KLzxQ6zK55+J
	 VNqBtmnP/B+T8ucpGUA0TdMWRMOV1gxpi4AQTAlsfZXyY2uME15CgzFU8W3PWQ2H53
	 EVkAuFI3+vDrLlmn4S6pSkgSlqpLxHQCFFJOxUsmOMEWEgkTC+nQbpaFxIaTqkzA4e
	 V8x/bbQ4QdRX5qVhLdcPUKWXOyq2RILHesJ/lI4F0BF43Joyh8NTOBR7hzwzc3XVIp
	 P5ghZHdwTspEYZ1SSsH4yvwOztDVmBm0cd7hd1cARmAX0xyipZqtb+tILLScjhvb9Z
	 KMV5AKQwcfpQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AFA180879;
	Sat, 31 Oct 2026 12:33:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 932374BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84CC160625
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qij0pd0drDSD for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 12:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A47846060E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793450035;
 b=gxPe3gXpiPDLM4k/sP7Zk0UoS3q/k+8qa/e5vqam/TaI8cnsXeY0Fd2UAVgYNv+JPMcv
 XNaiM8PPjfVNC1m5312OYIL2FH1fa6X0Fi4O5i38Z5rzKaWm1WcA2ywbybgcb4CbtgPoF
 q1bwqLRFPV34Gs9zyn9Wvzn3zL2k1zIzQoRq71q2JC7+sGAtZFwTQ5lyfQUlsQeSL1WF5
 BAoKiJbJQIO4esyZ9spgYRwfPHfmOzwUxhUx1DlfKFx11tdk1t7aGwZoC6Aum9Y2Be1PU
 AsjHSJDSdbENojLAyLA1lAMaLJuYhNXAh9gWLgmKzK/xe+wS8KSuGN4AihhZrvoPDVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793450035;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=O/ZitCqUnmmf9W/KUGjEnUl0Wv1/bkoC3NNu4G9VqCc=;
 b=fIofFA0IDLmNuQPaUwKpOkQMYlb8GMB3Xlmv2YPp5prsi+RBrg3O2FORo2jrBli8sxIu
 Hw0MPHvsMd/JBKqMXlbqHmYhLthWLL+Vh8WZPoW21ULUxVpCbXT4UmDj40Mb2yJwpooIx
 3y3BcROiqG+SQ3SKp93BB9Q/CucCBmxit2cYx4Wt/Mph2x+3GImBwNzg/u/7vzm9Wb5Bp
 5t/VkHw+/XqeLcdz9TrVydthrQQnZe/k2gU85BW1roJLJV2OijnQ2yKKFYwWjBYha9Hvh
 H63M4uv1vVImg9pQ7L1ytAXk3Sn/asZgDy1rBH2AG257/fzqpPKaJbk0FXSNxhuYQCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=PGrNmLXB; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=9261=iw=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PGrNmLXB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A47846060E
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1793450033;
 bh=O/ZitCqUnmmf9W/KUGjEnUl0Wv1/bkoC3NNu4G9VqCc=;
 b=PGrNmLXBVGeETMSepAZZUXYnvkEpz/PBnK+9kUT9siis/aUbSDEOD8J9eQUi/q0QcTNHP3hiF
 xNeq+VfQdazd5CBzeb/qIff1LOzC9ZEo/4SX3HMPgS2EW1otGZA6Vv74SQWqrXELEoUICx9j97Y
 Hpya/YGJi7DdltBSnESLvqKIpfNyl8Jk1t33NYeNV1Pg73dAue0Cja9535Et3BemSanRWYENGaR
 sXSVf25KjgY6Nd2Ns/pafL+V3WAega4vGT0bSJfAAkxJOaxrNYM2YL2J2bYUkv39XO2CYFZHCgR
 yEK4PiY0nVXhryZB2XqbjKSAe3QKeqYfpzhEUUWz7rNg==
X-Forward-Email-ID: 6ae5e02f5d5bce0054c5c5cc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <55a3a6c1-dc00-44ec-95fd-8c763e57634a@kwiboo.se>
Date: Sat, 31 Oct 2026 13:33:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/37] adc: rockchip-saradc: Use 3 MHz clock rate for
 RK3528
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-38-jonas@kwiboo.se>
 <CAFLszTg+5j0F=hg_gVDNg59PmW7Ni_2Lwo+X8xTnu_KYjKJW0w@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTg+5j0F=hg_gVDNg59PmW7Ni_2Lwo+X8xTnu_KYjKJW0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 10/31/2026 10:36 AM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
>> adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
>>
>> The RK3528 CLK_SARADC divider field stores the divisor minus one.
>> Its three bits encode divisors 1-8, allowing rates of 24, 12, 8, 6,
>> 4.8, 4, ~3.43 or 3 MHz from the 24 MHz oscillator.
>>
>> When the driver requests 1 MHz rate, the required divisor of 24 is
>> encoded as 23. This value is truncated to 7 in the three-bit field,
>> selecting a divisor of 8 and producing a 3 MHz clock.
> 
> Just to check, is this really just truncation? rk3528_adc_set_clk()
> calls rk_clrsetreg(&cru->clksel_con[74], mask, (div - 1) << shift) and
> rk_clrsetreg() does not apply the mask to 'set', so the write is ((0x7
> | 0x17) << 16) | 0x17, which also write-enables and sets bit 4. Bit 4
> is in the CLK_TSADC divider field (bits 7:3), so each SARADC probe has
> also been changing the TSADC divider. That is a better reason for this
> patch than matching the rate, so please can you mention it in the
> commit message.

The motivation from the saradc driver perspective is that it should
request a rate that is supported by the clock, not to work around
shortcomings in the clock driver.

I do not think there is a reason to mention the internal clock driver
issues, those will be handled in a separate refactoring series that
changes clock driver to use FIELD_GET/FIELD_PREP macros and make
set_rate fail for rates that does not FIELD_FIT.

> 
> I suppose you could rk3528_adc_set_clk() clamp the divider to the
> field width, so that an out-of-range request can't corrupt the
> neighbouring field. Bad for code size though.

I have already converted all RK35xx clock drivers to use FIELD-macros in
my local tree. Such refactoring will be sent as follow-up series as
mentioned in cover letter. This series tries to fix issues that were
discovered when the clock drivers were initially converted/refactored.

Regards,
Jonas

> 
>>
>> Request 3 MHz explicitly to match the rate already used after value
>> truncation.
>>
>> Fixes: 6ef723af18b9 ("adc: rockchip-saradc: Add support for RK3528")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>>  drivers/adc/rockchip-saradc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

