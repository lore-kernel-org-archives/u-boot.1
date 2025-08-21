Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A475CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 07:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1D082998;
	Thu, 21 Aug 2025 09:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JyNUKnNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22D582AFC; Thu, 21 Aug 2025 09:09:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849B981FEE
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 09:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 60B753F723
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755760146;
 bh=leHQwS8ymjexXtANhWOEmlYxUxp/FGgpiE72AfK9+Fk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=JyNUKnNIJrxTu5ke8Dt1MY5BmJXQlUv0aRzbvyafWhsU4PajGJ9jl2mDuoMIMjFw3
 GyNy4+cc3buaz18wnuY9nD/EnTrDTxfkfL5fIoQorg0sKHXPRgVwdfIbpfXYOVc9Hp
 G4gVhtzqdIeZjwQ5ohrkV5IrAQcPx+mEQfPj+U3rCVR5iNhbWUmArqI45jOS5BCiCY
 GVuIsCy5BOWH9PZUUSh2Ya+q7Zj/FdOF5CzNSULv99OgWC9sLwuZa49Xi4chS16R1V
 BjaN986PdRX1mXK+i5FEmyMhOvjfQT2k52xwyhgILC3w5P0XApTdivO1doh9q1ZqJe
 V+GQguSToWmVA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0c5377so2932005e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 00:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755760143; x=1756364943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=leHQwS8ymjexXtANhWOEmlYxUxp/FGgpiE72AfK9+Fk=;
 b=Wlzl7q6WRbF8+Euy2KO5qPTk6blhjX/VLJLE3xDnu6YbmI99ydTa6+9eqFLlCmfMBg
 lV4iO6ZckA4qK0dYqXTsTJ3Wcv6v4B1P9AvxDcceU70l7ky+g+XASiIAOWGjqkn7cPvz
 AZRfmSgoQgtM/oQR/r2N8dwSqXmXCyc1EPbcjZmIFnnkRfB1b/6xBuF6EclgDfYccci/
 Ma/d08mzlUfqegnvnqslR5CIoT5Fuhx0Eh3ZOF57ru7+0VSku+Mi0FQCAsL1QUuCJI8C
 7nLDlhsjVmMsVhikyBskx2prC+7+pF7lUWtxH1bnXPPo4YgPtDbjzqmRCjkyhE8UAI6j
 DXuQ==
X-Gm-Message-State: AOJu0Yy7zNUNUmPBM73W9bIgvOcYkelx1tBO/0bGsbhS4rDCTCgEIVx/
 Pp1TZ/aA+vRtpPeES1Pntg00ONkf1qaNfAmgYNsL0L25SfhCyGk8LaSwYpfQjN3LldB3szUGmhL
 SWPoV6CGi9X1df4gLVYDjbdYsKnQcrBHd1d1z54DSHYbPNG2sLRN0UBeBb1sLBGc59ip1FztAUF
 qN+44=
X-Gm-Gg: ASbGnctHsaEqp76PDBcqtaVCM2NBSfoL2Ws3H1t5Iwd+YT0wrQzT2OEk43/0TWUBPjF
 8VyVw3XjqiVu0Pa0HcEKixn0UpTZGdPIvlT43qP1amoh9G7dvzJ1UpXuQiwyb42badZr4h14u0A
 x0btJ52VrcpBcwEzlcLwDoPth7NY6LQgGJIhofn8v7b1grm/WUvkI8hMPi/nApGDRPN+MYRyXil
 jaiVzkDYgpqsVkaNch8lHBc8lyuxT2B2pvj7uXJQ/xg59BKRwsGzR7LGPZqmme7nB4RQTUfjA1r
 K3YIYs1Ye0b0mEJE4iiAd2vBeDdfl6Y6CRL1VSATF5Gc+kuzWC96jkmJiJBwyT1Mns5LKOBuCbN
 ihWoyldwVwMKAWNeJ73adfAwJ23Wdnq3jqYhWGA==
X-Received: by 2002:a05:600c:630d:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-45b4d7f59d9mr8568815e9.13.1755760143573; 
 Thu, 21 Aug 2025 00:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLFkELpXyvDY9ZmEESGAGrBGPvF0TExEGJ2LbHKDfUIVk2yNFMp0Gp7TX8z6NE9rQugvCjPQ==
X-Received: by 2002:a05:600c:630d:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-45b4d7f59d9mr8568605e9.13.1755760143154; 
 Thu, 21 Aug 2025 00:09:03 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4de5b52esm14112505e9.20.2025.08.21.00.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 00:09:02 -0700 (PDT)
Message-ID: <df457055-aa0e-417f-b9dc-d35a9d5c5a0d@canonical.com>
Date: Thu, 21 Aug 2025 09:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib: use utf-8 as encoding for C includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250820231711.45677-1-heinrich.schuchardt@canonical.com>
 <20250821002223.GJ124814@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250821002223.GJ124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21.08.25 02:22, Tom Rini wrote:
> On Thu, Aug 21, 2025 at 01:17:11AM +0200, Heinrich Schuchardt wrote:
>> Correct spelling of name 'Joan Lledó' in copyright comments.
>>
>> This avoids warnings in CI:
>>
>>      Skipping file './lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h'
>>      due to unicode error
>>
>>      Skipping file
>>      './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h'
>>      due to unicode error
>>
>>      Skipping file
>>      './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h'
>>      due to unicode error
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h  | 2 +-
>>   .../lwip/contrib/ports/unix/posixlib/include/posix/sockets.h    | 2 +-
>>   lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h            | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Which test does this and can we just tell it to ignore what are
> essentially untouched upstream files?
> 

One of these:

tools/dtoc/src_scan.py:629:                print("Skipping file '%s' due 
to unicode error" % fname)
tools/dtoc/src_scan.py:654:                print("Skipping file '%s' due 
to unicode error" % fname)
tools/dtoc/test_src_scan.py:87:                         r"Skipping file 
'.*' due to unicode error\s*")

The patch only changes the encoding, not the content of a comment.
Why would you want to use codepage 437?

Best regards

Heinrich
