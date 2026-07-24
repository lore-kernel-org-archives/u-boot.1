Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E87FC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21AC840AF3;
	Fri, 24 Jul 2026 09:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgzZrKO9mdlG; Fri, 24 Jul 2026 09:53:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 332E240AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784886802;
	bh=kvwZjWdznG6qlRGuPWWolBDueD+/MYGvmPduwEVe3kc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEGKxLbwm1c8LnrZtnMdzFfV0A/aM1bge6JhL/5X7a3l8m8cA/5kRShvK+XEC9S3j
	 GYigLDquMcjtT6MFgTS3dg7KpgyZERJ5aaZizT5VLvmtP5LsOgYrFvPMZWuEcwKKnM
	 U24AvdKAxSKYlQ/GZH8om0SctVWho7714jbNNiK8lblBd1wsTu88+RJA50Tyduzp5k
	 5fK4bS0Qq5du2hWMTkeOyqRhH3wt/dIysiqMcoDt2+NAl9DrrFI319my01OoryyqFU
	 KrC/0cXMizJpckxCweOChAWK/iySwUnt11fE4uLbHS4BrUckwLIa6+qIRIylj6BVe6
	 Ur1JwcRoSRGqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 332E240AE3;
	Fri, 24 Jul 2026 09:53:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A9063B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DA0240806
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTYFiYRqhVRZ for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:53:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 14245406F2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14245406F2
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14245406F2
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:53:18 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c160875e029so2138166b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886797; x=1785491597;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvwZjWdznG6qlRGuPWWolBDueD+/MYGvmPduwEVe3kc=;
 b=gycdBIFJxFjBtMDH/+QZRoWbCwusfZi5zCN/DEd/IuxTxHmZV2UKvLqcD1Tq3DqPxq
 x7T3XT1DJfyDfwIOCZRoknbVb35GT7FnimfG5f8Dl06Jcn1sL7RbVmeqaSuSLBMj216x
 GI/DUORO/wvXlQF3ba97jM39XahqFOlVOn5xW/C94S5neWoIOPDzUIQpjNS2QgEnypxf
 bgt1EWOfSva3jd43RFr4l+at05FDseZDe0Oe0vBmpgaAczhACXDY9u0E72qm78it9R2d
 3nOVPwkYBaiZfIb4QI2KNIROOutWAKtsHB3bezfqTV7H9NS9wGCzsEqEs69N6Ko9qI2+
 dRTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoORSC1bf/90SMt3JRFDguQNu2n/JNinnHpldeJiI3B2332yxz7yRmQ28AdMZpbmA/0ejzUm1k=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyzUnCJxroPhYCBu4c7MZSUJYFdpnBZFa5n4/1GVUGIKY5TrafZ
 4RVygmxP5OFLyNnxWCujYJ6STrlFFCZIQ7dzoMdTqMFHQieHj49rhWzi
X-Gm-Gg: AR+sD12dO5KRUiZ7NJwWCHEIPLjKMPM5wh/5KIPgKXHBTbk/DF9TAr+tooBpjOEPFPK
 qMKnvgdCH5RAg+GbBt9O6uzGf5+I9EilAW7mpN/9PTUGn8VjZnbv3b2JynbgawLrxg4QAREVyMd
 GRP9efJ45Rb4ZcgrBlNIaW/hAw9EtH5/Uap+CNNHyXyqVtrzsu34IAlVhEoTWpD+t7Vlm0HME6k
 qM2dIGOlXsOk/VbbYcYSshinvYUS/JLVperjjDVGgQlDQQjF7rWK+6T1u8ONDYWULJ7XXEPHudn
 jiRiq9upw7tPldX/4UYKoM3weCuqPWspsbb0gLI0TCqtUPYMfAb2Mm/wBhSqe22/5pisT37ju8v
 I9hFukMZF4SGcJ2y+pUF+YdG3IjjZGVyAMhRUieeO3vG69ltLTA3vcFcSb/MKC3beWysRc5CHgs
 n+52oYLI2gd+VfipJ9kZcfqMegCZEgH02nOkuOZ6GW
X-Received: by 2002:a17:907:e1d2:10b0:c16:688c:87c8 with SMTP id
 a640c23a62f3a-c1c50e0c484mr112368666b.6.1784886796558; 
 Fri, 24 Jul 2026 02:53:16 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a7986bsm326845066b.7.2026.07.24.02.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 02:53:16 -0700 (PDT)
Message-ID: <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
Date: Fri, 24 Jul 2026 11:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
 <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
Content-Language: en-US, ar-EG
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784886797; x=1785491597;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kvwZjWdznG6qlRGuPWWolBDueD+/MYGvmPduwEVe3kc=;
 b=gU3AHcTlce96Z7dGupFBRUstluOqPSfqCRaVdIJlymusYi1Rqj3Lz3sMIHmQef/frX
 W5CxLG0iOoJurw6+Xhssy6CibXpZZJ4sYMyynwHqkXvfVaLZHUEq2FWFtwLPk31MaTvN
 T91l35q0JWkmtuyrCWjbvFfx724LM8h6rwwkKmiVhHURJoLNNt5jYM7+fv/1qLaDkboY
 deC4fSkoEuoJ444u7TYkbe8GgBirqeh3w+AOHIwpp3YotRbx82P0hQgppdMkzsP3FxSd
 sFHyWHmAeqS6r2yCW8Ybvd3PSQoD9GuC1XFE03fJl5bdGMQE4PqhU5PtorvluHz/gtiD
 RJdw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gU3AHcTl
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/24/26 10:45, Quentin Schulz wrote:
> Hi Johan,
> 
> On 7/24/26 12:17 AM, Johan Jonker wrote:
>> Not all Rockchip SoC models use the ARM arch timer.
>> Call the function timer_init() only when
>> CONFIG_SYS_ARCH_TIMER is available.
>> Replace the ifdef call condition by IS_ENABLED
>> to increase build coverage and make the code easier to read.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Previous version not needed for serie, so resend separate.
>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/
>>
> 

Hi Quentin,
> You didn't answer Kever's question in the linked patch and I have the same question.

Yes we end up the same code. But...

> 
> This is essentially the same code, so what's the benefit, are you trying to fix a specific issue? How does this improve the situation?
 > How does doing that increase code coverage... etc :)

This patch originates around the time this concept as introduced.
We are changing all code to the new norm and we leave this as it is...
Fix this as well as a favor to Simon as part of the review. As we are there then fix them all as this is the new norm.
  
https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-6-jbx6244@gmail.com/

The concept:

Currently with #ifdef the compiler sees this code:
============= 

	rockchip_stimer_init();

	ret = dram_init();

=============

Now the compiler sees this code:


int timer_init(void)
{
	gd->arch.tbl = 0;
	gd->arch.tbu = 0;

#ifdef CFG_SYS_HZ_CLOCK
	gd->arch.timer_rate_hz = CFG_SYS_HZ_CLOCK;
#else
	gd->arch.timer_rate_hz = read_cntfrq();
#endif
	return 0;
}



	rockchip_stimer_init();

	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
		timer_init();

	ret = dram_init();

============

By using IS_ENABLED and CONFIG_IS_ENABLED the compiler is able to look further into code and catch possible errors or warnings.
There is even a warning for it in ./scripts/checkpatch.pl

============
__weak void rockchip_stimer_init(void)
{
#if defined(CONFIG_ROCKCHIP_STIMER_BASE)

#endif
}
============
There are exceptions like in rockchip_stimer_init where certain defines are missing, so that's still allowed.
In all other settings we use IS_ENABLED and CONFIG_IS_ENABLED.
Hope that explains your questions.


Johan


> 
> Cheers,
> Quentin

