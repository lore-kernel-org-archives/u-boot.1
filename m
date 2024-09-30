Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88034CE835C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A37A88E56;
	Mon, 30 Sep 2024 17:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N9Pwc6gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC2688F53; Mon, 30 Sep 2024 17:52:30 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A95889E9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so27313135e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727711548; x=1728316348;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=inoeM5C8JN4l9dKW7Yan/PfYFVO4Eft9vY9gzk3iWrk=;
 b=N9Pwc6gvyudZNhXNlq8spztLSUDAoePOaOSaidwviKqgAdlr/huZg3bj5WNobcOq7q
 RRkNNGV63zOlLCmnpY2n/Nvaj91u0yDt684JkDOOC3p64yyUT6AaF8PoSigfPQkB2LPY
 KvMhNr4sp6T/kP8HyH/dQGUvitwValFgUf0AdV20Sd9unMUibcrDfge9yGzMeEYBLIMb
 hMe5H0IquSZ5PEG2w7yySJL707O0DvPSMrAcmON3mFfEOHErLWUWuqk/pGE3eXBrb4/+
 ITMsANbfK5t4OND5FmIlq8FC6Et+Ax5KpxIRw12ZX2MvqQWv3FxmyOHf0BFMuBnkrD4X
 jYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727711548; x=1728316348;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inoeM5C8JN4l9dKW7Yan/PfYFVO4Eft9vY9gzk3iWrk=;
 b=iUrO1Lr2onfHXIul9oo7DKL/q5aCKDnM1CkJo88PqoG9q7TU1YoXS5KCBN9Eos/7XC
 cCoOZbjhUWacokMPeskst/r1DJdT91386epja9x28zKXa7MWIjdib/t7NVYY5pTQfn+J
 uw2F50hkWFWE15ZTOz9vmuOTZ/k/T6G5hKmjZRVT691b5D6l1WnuwuuGdNex9g171Bef
 9ZcD17+2T8kE09+gR8oiQywLLXoIcOsxpcG6wrYJhTHFYFHJnZMsrNqeG1HOP9txlpO+
 EXiBrxiZGBUURzV4oI2BY267ayDLjZRtEeXBBWU8vPKQvcH6zc6M/GaXgcGdKSArR7qr
 pLOg==
X-Gm-Message-State: AOJu0Yx1b7/r3QYSBsheDa7UCNVexf8BqyqgSVxZDJwUc1SQL7rSq505
 /a5ht5sGobD0wbQ5e5L0vYQ37/qRZ0U/+AJUh9shHocbBLx0LM6fB1RLkK/lp5Y=
X-Google-Smtp-Source: AGHT+IFRZGLPjJ81cd/p1GFNyF9eqQx1uWhTxC28fuhtrPwE3+n+pbBPSR3wbx8WqI5FXa2v2SA+VQ==
X-Received: by 2002:a05:600c:4ec6:b0:42c:bd5a:9471 with SMTP id
 5b1f17b1804b1-42f71385ac0mr374335e9.16.1727711548211; 
 Mon, 30 Sep 2024 08:52:28 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e13944sm107441005e9.30.2024.09.30.08.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 08:52:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 sjg@chromium.org, semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com, avromanov@salutedevices.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20240911214945.15873-5-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-5-ddrokosov@salutedevices.com>
Date: Mon, 30 Sep 2024 17:52:27 +0200
Message-ID: <878qv9m950.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitry,

Thank you for the patch.

On jeu., sept. 12, 2024 at 00:49, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
>> board# bcb ab_dump ubi 0#misc
>> Read 512 bytes from volume misc to 000000000bf07580
>> Read 512 bytes from volume misc to 000000000bf42f40
>> Bootloader Control:       [misc]
>> Active Slot:              _a
>> Magic Number:             0x42414342
>> Version:                  1
>> Number of Slots:          2
>> Recovery Tries Remaining: 0
>> CRC:                      0x2c8b50bc (Valid)
>>
>> Slot[0] Metadata:
>> 	- Priority:         15
>> 	- Tries Remaining:  0
>> 	- Successful Boot:  1
>> 	- Verity Corrupted: 0
>>
>> Slot[1] Metadata:
>> 	- Priority:         14
>> 	- Tries Remaining:  7
>> 	- Successful Boot:  0
>> 	- Verity Corrupted: 0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++
>  include/android_ab.h | 10 +++++++
>  3 files changed, 113 insertions(+)
>
