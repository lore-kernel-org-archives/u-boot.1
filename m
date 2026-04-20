Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55959F5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACDE83A91;
	Tue, 21 Apr 2026 00:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="IdTok8Fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F1483BC4; Tue, 21 Apr 2026 00:58:50 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22429839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4756e74f8edso2527624b6e.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776725927; x=1777330727;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wBwb5DHnaw6Kqy1D5beE2OV+bmsjw/VjFy+XD1uTLM8=;
 b=IdTok8FpK2UdQfcbx9KqRuwU5KFs03nY4PobEf5QLwyHgwP17dIcyNHXy+lj5Xm3ds
 eVfCTzII+yyTXsEqfm3rQKJDbJC1UM+63jhrlB+2l2k0qv6N504AKSeaP/ZEl44Q5uYx
 C5ja6MTuBtPZ/jPwjQ6aofJSqa6KRm9u4YCgCHFl7hFupnQXxstqaSG6+gbTfHW2+MA2
 nfhZdzWMwu1zfWY4CXP8Nv3GNZWwn/5pgwE9dFvVsvI9Yq3+WCbgqVD/GxbXF0kMxPeH
 +WBKA0Ty5eJdi50XNRbAM5I+Yh47mHW0QVbR/ge7eyciYAdI+GTP90MjB7mPtNDAB8AS
 Cd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776725927; x=1777330727;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBwb5DHnaw6Kqy1D5beE2OV+bmsjw/VjFy+XD1uTLM8=;
 b=AtDca91wfjSReSABO1HjBjoqXe0NnM8bfcvqoDxrm8gBjSKn9X1KavUwVv5ZN1UrON
 NHhtT/8F/KEbC1Vh5pJIvDifZANy8vhAWguczTpiOciKNIlheaT3/4IbpdoAi9DKvBFb
 BDqZuQ6oy2Ucpk7Vrs2+YTtF9UhlcbKy6ho6vji2yc7FUFH4TCrNB6M/1GhcmELDtSXn
 coSwXslP1LluMRTvDFGd0HqijkmM9ddrECQJuUi5oIpaiSeOn6Ya8fr2O/5oeGB/Ebvn
 oZCB2k5EazAXQpJ1MsuWUwcnwdm1M0J95ltDMvIipAdmbPxNF6AuPk7QxBIIIGys1pg9
 IznA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kkNXFj83ZoQwAqBWhtcgN0/X0hBKAaNTl+FFIdunbkwQTTVcAq2awEVGnalFojwz1Ix/5WY8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi8Hz65lDwHVh1eqTPqp6H+uPvAsJWhzKD7djcaZPgo5/BZnZS
 YjganwFwPvMdJ6j14TQhGizUU5r1RPeGSMxs90Th7OVmQlW5I6X/ZGIUAngh8fOn2hM=
X-Gm-Gg: AeBDiet8JVBdnGrbOoHQ9jpwA9RYZ5mXtWQTTNBtSpF38bnn6UFkFZgSZUyp5oi63tN
 q62QEIlhmbPj300n3m7jXY2rBriJZmRFNTkCxeoktoUG6A/8tgJAEB0U8G/JjNxNEJF6u55qtjr
 GtOmdpcIg6wqSdIyElys1fcW+JHd3uCcsb/UcIS5uD++LYDAooFLxB7FlBAonQoBGuDlVdoZzXx
 l38buraI4yZPowdHZ7my2I/suNCxKYKZuZjfZqKjmVkltdgK7C66kMzCc1/ZCpuiOkm6ghj0mNA
 si2TLzkLYdLmQr6XD4H6Xl989dVFSGxG7BYQcApR6+nRzo2KNmXrvt/BDSx5MFchMbI+RRwCMZ8
 TwpV3LULMk+UQnNalQ5kRfx0P/e3MlvocxhNgbBmcmyD52qLGwoHq0ILw70NMIGZioW4betL4mE
 c187gwsxrceBeD/K/mLkbxhTf4ubn4l3aF1Ae22cP3AS6qZ4zqbf5HMLn/CjjL1SKz6AcntoMfc
 UHYC8JEhkl4
X-Received: by 2002:a05:6808:50a9:b0:463:faa3:8dda with SMTP id
 5614622812f47-4799c958f2fmr10259586b6e.13.1776725926821; 
 Mon, 20 Apr 2026 15:58:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7?
 ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-479a02097b6sm7750684b6e.14.2026.04.20.15.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 15:58:46 -0700 (PDT)
Message-ID: <ec9b6639-00a0-4fc4-aee4-f57f9cb26a5b@baylibre.com>
Date: Mon, 20 Apr 2026 17:58:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
From: David Lechner <dlechner@baylibre.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
 <61daa047-74f0-4a76-a61f-de54ca4b716e@baylibre.com>
Content-Language: en-US
In-Reply-To: <61daa047-74f0-4a76-a61f-de54ca4b716e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/20/26 5:15 PM, David Lechner wrote:
> On 4/20/26 3:38 AM, Wojciech Dubowik wrote:
>> Some distros are using gnutls library without pkcs11 support
>> and linking of mkeficapsule will fail. Add disable pkcs11
>> option with default set to no so distros can control this
>> feature with config option.
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Cc: Franz Schnyder <fra.schnyder@gmail.com>
>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>> ---
>> Changes in v2:
>> - make use of stderr more consistent
>> - add missing ifndef around pkcs11 deinit functions
>> ---
>>  tools/Kconfig        |  8 ++++++++
>>  tools/Makefile       |  3 +++
>>  tools/mkeficapsule.c | 17 ++++++++++++++++-
>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/Kconfig b/tools/Kconfig
>> index ef33295b8ecd..ccc878595d3b 100644
>> --- a/tools/Kconfig
>> +++ b/tools/Kconfig
>> @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
>>  	  optionally sign that file. If you want to enable UEFI capsule
>>  	  update feature on your target, you certainly need this.
>>  
>> +config MKEFICAPSULE_DISABLE_PKCS11
> 
> Options that disable something instead of enabling it are confusing.
> Can we make this MKEFICAPSULE_PKCS11 instead and invert the logic?
> 
>> +	bool "Disable pkcs11 support"
>> +	depends on TOOLS_MKEFICAPSULE
>> +	default n
> 
> I think it would be more convenient if we did not require PKS11 by
> default. Otherwise, everyone using Open Embedded that doesn't have
> the "p11-kit" PACKAGECONFIG option set for GnuTLS set (which is the
> default) is going to get a build failure and have to research this
> and find the option and modify their config to fix the build.
> 
> It seems like it would be better to make people who actually need
> PKCS11 possibly get an error by default instead and enable the
> option. This is pure speculation on my part, but it seems like
> this would be the smaller group.
> 
Or maybe we could avoid the config option altogether and do something
with `pkg-config --libs gnutls --print-requires-private` at build time
to detect if `p11-kit-1` is used by gnutls or not?
