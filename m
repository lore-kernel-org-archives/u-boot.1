Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9485F53D6D
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA0E840CC;
	Mon, 16 Mar 2026 17:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KHbVYkkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E48840CF; Mon, 16 Mar 2026 17:29:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2BD840CB
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fZLC95k5nz9t9D;
 Mon, 16 Mar 2026 17:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773678565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4tZLXdK0XKBiWwuxTZmLSb2dgfb3hySCwf/M1AkWJo=;
 b=KHbVYkkKaDt70XdfUnbozWSAdmpFMSZ0m9k25Bncqhu/KW6akWuLDxt+zByYEqxZrOv1Sy
 2NLGdsd6DxBiqpsEG+3qjhYQZD40ROUOXQRMNj2LHpA2MGMY+bt0NnQQ3xoCNQpUwAfmhc
 Lo9a82Lc4qyOEGoZUY4IzUNWPq9V2u6I9v7UcJJNaouVez9qiKLzlyr2bHzCBYqQFza5wL
 18RCZwG6aTOn2NapQfk5wu/RipfV+mY90k/OTLWG/96ruxqQmLQPVlI7/9auSPPM4h5ZCt
 2Z81LvhEoztDHtQBjr8DfXAroVjklPI4mGng6+Af/zV4nIO8sCJzb+HGUu/7pA==
Message-ID: <8b27e0db-b5aa-4f6c-800f-aa7c63b13183@mailbox.org>
Date: Mon, 16 Mar 2026 17:29:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] console: Prefer currently selected serial console as
 stdio device
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Andre Przywara <andre.przywara@arm.com>,
 Tom Rini <trini@konsulko.com>
References: <20260315235353.304637-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTgRms-_m+Ws9JN+KU3UpjF2A+R3zvr_O5SWybMS+Hi+aw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTgRms-_m+Ws9JN+KU3UpjF2A+R3zvr_O5SWybMS+Hi+aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ygy1y16bish15amwetc9ypu4ysnfp8mr
X-MBO-RS-ID: db014d2f491ada0d9b0
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

On 3/16/26 3:44 AM, Simon Glass wrote:

Hello Simon,

>> +                               inputdev = dev;
>> +                       }
>> +                       if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
>> +                               outputdev = dev;
>> +                       }
>> +                       if (inputdev && outputdev)
>> +                               break;
>>                  }
>> -               if(inputdev && outputdev)
>> +
>> +               if (inputdev && outputdev)
>>                          break;
>>          }
> 
> I think you could have a function like is_suitable(), call it on
> gd->cur_serial_dev and then go into the loop failing that. It might
> give smaller code and avoid the extra loop.

I'll be sending a V2 which is somewhat different. The rest is fixed 
there too.
