Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9E0CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FD9C40CB4;
	Thu,  1 Oct 2026 17:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zwigUSSB0LP; Thu,  1 Oct 2026 17:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 55078408CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875339;
	b=tKDH3g20T+3qnVOPz+i5R7zizkYVRQTSrVwGerL7CnvhJz3+OlvhsJWCCVyA9wCeKUOw
	 vB70o+3eB2TUKaMb8tNf0A97iL15nZbA5tAN9dYm4tqWrr/yePoN8ZzDeGB4m0xlSJOgk
	 qbt1N8mZ68/TIPP02eRXDDJAqOHuNA4ovXWm6JC9zxBtl7kfx99HD+rDzycJs0q0CxNeN
	 dVToZoYdnAr5RR+VsK4t9ndd3ZZthSXEvv/tjn9WpY5372rCXJYztaDDfBi+Gexcw+KCB
	 1Ad0UdyYoxwRrs8+zuYV3HvjBKzc0G2UtOZ8lZeYq6NZmOwjmyeHjewYXFtHOGhz1jw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
	b=SLYL3VIZK3k697ghwQw4ZdpjgfVmvylAuCjSSBTSVx/1OCBYDFOBk1NE8358lYo3HE93
	 Ft+liSqN5SohpHoFHe1PZPdYM1s8c8KENoUn3zwpF4asZZaE1c4mhJlgFFSjqnIAB1KUu
	 rGLu5fO+B7M9AJ6zs9ydpwjJ9YU9MafANWGVtqLtVHHCwRWdGG56Ie9tosOaYgiUVBA5E
	 fuSpVqdC00zXqdRpprDGJasgjz56+MjTE3gO2oFxnZgfnH8wNHOLSocahg/pJ3qe5QhgI
	 YYPgHSNLBUWASh4jrdAf4qSQj4u40pHfKCXkeNa+Wu3F25mAFhzI0jCCA0KTrt6Rc7A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875339;
	bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=le03aVkNlL6wesFj0cSWzz83v8XzeZ6Amj1ODdoqTjizDWRWsgAyIB6MV6M1DUP3N
	 otqBEslo7oz35sVVGf/TExOMRocFaAjCNPfDfkzRW5AsjUcUMeVkz6qldK2UHNVvef
	 QgOgpnYEL3PcBnGw18uG/LmyXNIJD37iUU9vpvu2c8fuGZdCNe6wqa9gb8Y+VQ8wTT
	 wPc1c5+D8GDMEe6KH32f6P4brJNzefTILpF6fWFIVcmNVB9L0GpTaQYlT6xeZ8E1Vq
	 GwzASb1/zcH3ZyNBFTpGorherfv0tFmh1exx43LNMWBtxqsI+Eb0Dw+RlcsKpdYV0f
	 GnJcDQ988Dd4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55078408CB;
	Thu,  1 Oct 2026 17:22:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F3DB1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D41B40533
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wI7YxiONsU-d for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6072C40098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875336;
 b=YXH/1UDQ8ivGkXq50O3yGxJiIVmjEA2sHdpOMjdkvAu9NXI4di6DVG9GGS3rEy7SENR3
 F84gsXIo5+7IyWctbEMnldVHOIcdTH1+BJelLqfHUtoJYj7eOiO/c7fSznep4f8CAN9nH
 NCY1G2VWw3K8T3kz/vQt/gXgpRWX4RMo/mj1mbJ5EgkBYaD5JC0hY+TR5CHs+v1oIABgR
 q+HbOuNp2L9wgIipTNxPN6UjvrhlJ3RoTOc/u0UKmOrDOq9HO5ZMTyeRKmO0q3JicMH0y
 glwT3ilgtcnwIYp1bhG/gxy2mvXS1fJxajKHkAQNWQL5CcezOZTKEGTwAd0AnM3NaPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875336;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
 b=Gw2OoPk4Vu6cdm8QtJGJGGoPBLu6LLepGFFQ4wozLg5k1hX4YfSqND19rt/eFqoUL+1m
 tipb8Qb0JeZuwt6XucYpmSITI9HQDMc6AdNKgD0M3TIeuna3BnW4oXAOynvHVlGJYiyjj
 eGoHNjoYohPgvBtzEL2ygkKnxksdqTsC1aICo9HohuYMxEnNvZCqobdn/hCjpHDD9Jh5F
 up5tYtgkm32E4mxuMKCmXabQ6+l8FqIMwKkWWKgLauEnPF5cdsiw27el9P5x8bqUlLkKq
 O6UFzZDfJfNM+qBEGewiMvNsqmZOijE9n77/kKWkvObUBc1E/IF2S2fEB+NMLhvZCmw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ERtlpROA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ERtlpROA
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6072C40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:16 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso10442882a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875334; cv=none;
 d=google.com; s=arc-20260327;
 b=pBs9R44/7aryI64V+Y7KBxjGMyrpoJfAQBJMVCf2/UWQP07EIUGrNl4jxETfU7qjyh
 U2HsLPCnFiutVsV/UqFVh56TtgHb5TZ7AfoaCXksCHhLIxiux0QfgqYrgMxxw9VHQcUi
 rrAcFct3/Zv1zqymhyf0WqPrgktvH4r41u/CvePevmNaB6lLWHKQ2Ksxs/O6sOdDhmc7
 J5ilIHcY7HYJljHjD8OWezH/mBf8Im3UhiXmgk2vk2XHATctmxgOVDChGpVcbvU3VEoo
 y+KKNPAsSeGhrxOCODxjBv51ZVUk8kIjbp9VXyUyLrLbLxJDf82g2vtz58Hv5YFgyWW1
 2+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
 fh=f+3YHrvj6jGhkBhPyVUqKuV+eWYFrOfCOWHRGid3M5g=;
 b=ZYFNy41KzTMyVAs9Cfgkyf6wI8BklsnHzLrxfA/E4egOjkXv5pfhT989rcKadvr2mX
 cgyEHsXSa2I1ukvWWZZzTnWbvj2zCn4M20LVXv3+wjsLK7K2X4vReX28Aia8dPsTCKJ1
 4FAmg1LOd5afgkIS4JGrCC0ZeiM4HIxJVk+e5ETOlCryqxcyAOMnjaf6G0f1zQr8iLaH
 TyIYm5qrrxP8vIlpsLt/ZrTJ7PpqxOrNrTzjD02rwrrVn8n9wgvq34Z4X4dOkp6iCvMA
 XgWU//xBmT6sHajRHOZWdZC/F6kF8lH10NEf99pWm0pUeSJ6IoIiZRZ99Ogldmfpjkel
 yhDw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875334; x=1791480134;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
 b=ERtlpROA0LfMosDuAqc6WVz8WEDFQJo1LE/nBhkzTsrE2GNIQLQKlyRhZiTwGyonMY
 hIQu2ovaEwAaD2w6Bmq9eDeK0eAj8mnCMAQ5uu0gepfYF85zweeK4oz36i8O0uZGAvB3
 UROCFhaTAtzhIazQ6WuPEgffRURC/QFY6tYlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875334; x=1791480134;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OsiVcCypBfx9GBwvkkMJRKi7+HOnoi6Ce8eErxF5G8k=;
 b=ak3yxYgeOXT1RuXn/fbgNiG2gLoZEELKX5sPeUrk/8QwyZMgXaAHHHs1jLb9Wt/HfM
 BfHRrEZPaDbz1Kvux/vio6aG3Ns0QWo9/rZe1M0/nkvCNnJYconrmVAoKAj5v/Ut1N1k
 hpL6P5jzijt+2qgmQj7q9VOmM3N23GfQtvHv3ANW6oxeCxxZPUEXo5L39MjUOvq70n8c
 +kuPrfKmXIHSvjag0U+A74MClAbVOPSU3wXlFZdY5dAwoWC1P9DBriPEvNWA43sN3hMS
 A1TNUCBC1DlH+9E//pYmqP0fe9C9wT5+hgPl2fzeLWo03b+K+Z+PUAd5UGcvUOzhmmEw
 9o6g==
X-Gm-Message-State: AFq9FYKfL2X4Cj6TGMpMDK5d0iBw0jFRs1QIX73Z+p7eMEIQ0ANJOUsw
 OXR2vpQr/TX+TlX+MdzIdiiKjCEEMhJujnS4WzJHJD/2zF6C6KZ0boDROrn4HH4Wr5IC0/6gBS0
 zhtEy0zkkBwTLFI8g/jCGQplqe+XdSKNpTyDN0vsq
X-Gm-Gg: AYBFou0mvb9LVvUAz6nK+auhXnrzP8r+OFZv0M/wWpPz0HegfVz1sBvTDoC1VgTuBCg
 xtaHLT7+KUqRlT1CPNRNvhLYQwsZm4Cj48+u8FK0jcauqua7M8umM5CH/9Oj30MPh+SZIcfCOvv
 o31ADBsR+fMvx7CnfPCi5ACfmRlZmGQd/I0yu593cRLoMiGJDzCdMAJ/pZ3PopBHESh/rnPdm+f
 keydZjn29d1S+PyH4WoImNI5VTcqPvy0iiOVtc92zv+bAKrENwcfzmiS8+HKZTbJAh1HNMJWJr1
 kXtmMQKoiNR0jL5Etm3yy5BBtSEA2kP6t8N6ZotMDnGlwTKOuRf1FP54gA==
X-Received: by 2002:a05:6402:21ca:b0:6af:82b2:902 with SMTP id
 4fb4d7f45d1cf-6af82b20bc9mr1521873a12.31.1790875334140; Thu, 01 Oct 2026
 10:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-4-ayoub.zaki@embetrix.com>
In-Reply-To: <20260918172127.66014-4-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:21:58 +0100
X-Gm-Features: AclHuK8v-k9GutdrVUJPsHH10c_kII6NzX_SvpAP1iJfJABv7AMqe4ujVark2FE
Message-ID: <CAFLszTiR-WMjsD2bRx15Pt9J7k9EnOEPY1ojCCHRrptQ-anP7A@mail.gmail.com>
Subject: Re: [PATCH 3/4] test: add ML-DSA verification tests
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 mkorpershoek@kernel.org, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, dlechner@baylibre.com, 
 hs@nabladev.com, xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Ayoub,

On 2026-09-18T17:21:23, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> test: add ML-DSA verification tests
>
> Adapt the Linux KUnit coverage introduced by commit
> ed894faccb8de55cd755e093c4b0971f190d384d to the U-Boot unit-test
> framework. Import its fixed vectors for ML-DSA-44, ML-DSA-65 and
> ML-DSA-87.

Please can you use the usual form, i.e. commit ed894faccb8d
('subject'), so that people can see what the commit is without looking
it up? The same applies to patch 2.

>
> Use deterministic mutation positions for reproducible U-Boot tests.
> Test valid signatures for every parameter set. Test signature and
> public-key length errors plus a changed message length. Test malformed
> encodings and every valid UseHint input.
>
> Add an invalid-algorithm test beyond the Linux coverage. Test SHAKE128
> and SHAKE256 against FIPS 202 known answers.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
> test/Kconfig              |    9 +
>  test/lib/Makefile         |    1 +
>  test/lib/mldsa-testvecs.h | 1896 +++++++++++++++++++++++++++++++++++++++++++++
>  test/lib/mldsa.c          |  383 +++++++++
>  4 files changed, 2289 insertions(+)

> diff --git a/test/Kconfig b/test/Kconfig
> @@ -75,6 +75,15 @@ config UT_LIB_RSA
> +config UT_LIB_MLDSA
> +     bool "Unit tests for ML-DSA verification"
> +     default y
> +     select MLDSA_VERIFY

With 'default y' and 'select', any board with UNIT_TEST now builds the
ML-DSA verifier, SHAKE and about 9KB of test vectors. That includes
QEMU boards (qemu_arm64, qemu-riscv64, malta, etc.), not just sandbox.
Enabling unit tests should not silently turn on a crypto feature.
Please can you use 'depends on MLDSA_VERIFY' instead, as UT_LIB_RSA
does, and enable MLDSA_VERIFY for sandbox (e.g. imply it from SANDBOX
or add it to sandbox_defconfig)? Then the test runs wherever the
feature is actually used.

BTW the tests all pass on sandbox. lib_mldsa_use_hint takes about
150ms on my machine there, which is fine, though it will be much
slower under QEMU emulation.

> diff --git a/test/lib/mldsa.c b/test/lib/mldsa.c
> @@ -0,0 +1,383 @@
> +static int lib_shake(struct unit_test_state *uts)
> +{
> +     static const u8 shake128_empty[32] = {

SHAKE comes in patch 1 and is meant to be generic, so its test belongs
with it, in patch 1 or a separate patch straight after it. Please put
it in its own file (e.g. test/lib/sha3.c) controlled by CONFIG_SHAKE
or its own option. At present it is only built when the ML-DSA test is
enabled.

The coverage is also thin. Only the empty message is tested, so the
absorb path never processes a full block (168 bytes for SHAKE128, 136
for SHAKE256) and shake_update() never handles partial blocks. Linux
has lib/crypto/tests/sha3_kunit.c with vectors you could port,
including multi-block and incremental cases. Please can you add those?

Regards,
Simon
