Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2242D39000
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F57803F5;
	Wed, 14 Jan 2026 19:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V5soIXau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC64838BB; Wed, 14 Jan 2026 16:16:25 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE9283923
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45c715116dbso546656b6e.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768403782; x=1769008582;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOKsSb54j54aOcV6UuXOuqKvfEr85mZN2k6PQ4+UI/8=;
 b=V5soIXauuKlWcphBBxp179TAzpaZIKTxF8DxXaUxKu2Nk5m3IbdthKuLnmxm9R8Je2
 sbgRDbsMphnVHQFpdaRnCwBMrzxoQjm7Q06DO31C6tFGO+W5gGigu5xTVdGojaLYmCem
 svdXsm0YcZmKNxQ+Cif8cswD9z6ymAXGlgkiFaBltETibpzK+U5atk8+UPCNTmPStgXu
 CN7xdU3ZhS8sCD7y9wL3lAn9ik5b2v3pNxWeJCeXY/v79e0dKY5C4/kMSL1GhhEyho4V
 DZpaFB7ejMtw0kPIGbeTubNbBtBkDCVIIE/js091q/t8QSCl+3TBPnciKYJBluGcixOr
 /eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403782; x=1769008582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOKsSb54j54aOcV6UuXOuqKvfEr85mZN2k6PQ4+UI/8=;
 b=rdj0TDkji1qvicxU3K0LXQf7DCiYOVfA/wx6lQF82Wf8r+oYxx2nH53U+58g94+eDI
 3h+QagwprUx6VyG+yf4ul0iHH+6eJiwnLC1FTUplqQOFevcO2zI06mDqUdTVPuz9wDxc
 bioLTwXTiXTMPXLXVzaD5N+Knad0czbmypm5ASWBrRERWrV81CaFLZZ1cU+ux1T3FB5j
 wtalrK9sjlGq7GT/8Oy3WTkK0DiOwnxSwJ8/iSAj4ajvXedorafhjP2dLRc3YnnipTYZ
 Vl8Tsx4B7qOwi6m/r+/F5SY1mNZ09Nmbc4598lcWxrqt8dMsMXLTvhi4Hyqf+YuEKpDA
 2XOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnRqjsid0x4NqSNcbsUILMihb++1GfcmbiVKKFhJ3gozFBqpwjf/dviySjvisDx5i7H487L28=@lists.denx.de
X-Gm-Message-State: AOJu0Yxot29aykpmwcZ8oahz5GwVWoE+XEXJN8Nc6KW6p0TNM9AMOBjT
 9vvv8ZRdZkFPDRQnA8cgo2db/WmS5JkHeCVXR9YLnJVCOCbPtgQqYzzY+UxNBULrEcc=
X-Gm-Gg: AY/fxX7cAulUwhkOm4rsAE2Va+DCef1nrVWW+sTQXF9+LnT1DZkYXHjQjUN2Jts00ZT
 RqF6oS8AVUEnCDAQqw7JgXMIwJCmVXIlsz3TsEBRa7UXp5KclA09JyGgvfpgzgI5yiLSUJV0zex
 PIaSMJhqBMw9FLKTqqTg4gV14KwTnUhj9AzdbCJ6y1GaSKChxUuQC4PEnU6ORz8qanhuVFhFh/u
 1XHEAJ+stJAvwXLSsPBbsvP09/NJdGpRTBtqxobkXXQGtQ48V4rWluuLFur47oNqnc4uSvcN5Kn
 SpF6OWNwPVLmsi5v+POPOqELwiZcxfGSYisVElHkNY1056aLu3NHrfVuTuu4Pg/86pRR50yLarL
 JS7xyfmPUMO5Gi/cMulE5lS2k2L2V8SEjKRkjVvtoFDr3yFzBQsY3dFbT+Kf0HNBL9vanSJQiFP
 Rn53lMC66Je5QRZgir+NnGxGGBgISQFvbpgEHqG2k9TbKkIVkEQIEggnfa3EBq
X-Received: by 2002:a05:6808:1793:b0:450:b14:7a6a with SMTP id
 5614622812f47-45c715b8860mr2008003b6e.60.1768403781295; 
 Wed, 14 Jan 2026 07:16:21 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3ff3:5a3e:f89a:1938?
 ([2600:8803:e7e4:500:3ff3:5a3e:f89a:1938])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5dfb6256sm11499957b6e.0.2026.01.14.07.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 07:16:20 -0800 (PST)
Message-ID: <5f4663d6-e2ca-421a-b843-14a6da32ae33@baylibre.com>
Date: Wed, 14 Jan 2026 09:16:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/Kconfig: fix type in CMD_PINMUX description
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
 <91c5e702-d57a-4e1f-b634-252848f2b95b@cherry.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <91c5e702-d57a-4e1f-b634-252848f2b95b@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 19:01:30 +0100
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

On 1/14/26 9:05 AM, Quentin Schulz wrote:
> Hi David,
> 
> On 1/6/26 11:10 PM, David Lechner wrote:
>> Fix typo with correct spelling of "purposes".
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>   cmd/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index b71ac554c0b..94f3e75ca6a 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1679,7 +1679,7 @@ config CMD_PINMUX
>>       default y if PINCTRL
>>       help
>>         Parse all available pin-controllers and show pins muxing. This
>> -      is useful for debug purpoer to check the pin muxing and to know if
>> +      is useful for debug purposes to check the pin muxing and to know if
> 
> Not a native speaker, but shouldn't we be saying "debugging purposes"?

Yes, I think that would be more common, so I could fix that too.

> 
> Anyway, this fixes an obvious typo, so:

I made a typo in the word typo in the subject line, so would be good to do
a v2 anyway.

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

