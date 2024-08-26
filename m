Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D177C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 13:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA66288A08;
	Mon, 26 Aug 2024 15:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lUZ6O9Vc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380DD889FC; Mon, 26 Aug 2024 15:26:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A332884C3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 15:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso37244415e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724678772; x=1725283572; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GS1scRvCyBwbrpcaZx0ehCH8T2CZfpMiKUJSYdRCYzM=;
 b=lUZ6O9VcQfyQ1dhg41p1M0ib2f1RQXT5MwNh07hFcDrU2Vvge4c1HnqQjtbr52w+MN
 Wx/mBQcFVR6uJYkC/eC8NE88zqBX4EY/d1M19PgRNCY/i7w9jcSMEP36axB1okHzcx5f
 Wo8WXyWc/b2F0ar+uYwKIENytzXAVYVmQ7rqUcOZogZi9m1ulARYw926nH8JYnpGI37j
 c/eGYi8J3h6TwVAr6+T/gJKbF4UtoQT4NUereS3EOLSsJkZo8tj9yvDIhgHB65dpIhpi
 a/y15TRZv9LCYrkZH2ND5+LcZ8NVek08OP1icfvwBAKDQjy1KsJKUE06kG3h8xb6Zwz1
 FuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724678772; x=1725283572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GS1scRvCyBwbrpcaZx0ehCH8T2CZfpMiKUJSYdRCYzM=;
 b=lE09mla8Zl6nZEDa0POuuGrBZ7FYVpdTkBdCFWFs9ii2bYLJa9CulZBmllcKzKgIjw
 7qjA5fo4maraj2hxo/aYJQPny0YsspUarEC3elUKb1ZXe7yzoLIw46tNyWYRRXVYrOFl
 2IAOeku0rVrb7g8qK3zSwbyjoec1qhVPy3CvHv8sLGbYaihwSiUi3sUFAdiFZmnpvgRf
 Fw8l5G9fxWS+aBDsqST8iebEcCKaIsMqJIbQ24IzgjZjGtAVkh5VClpLCIFyVTJxL/0B
 rFLX6QW8YOaGCYtegjMDR3/IuBKCoI2Vsw4bo35M/IciQzVSJK0f9EwZIdfX0y97/G1/
 W0mQ==
X-Gm-Message-State: AOJu0YyY5r9rvdJRdEpgi6Y5JPaf58KlTohrSG8OwSC2+EoDnkIV0Vms
 HO9A3aZ7jSGtYvD/HNPJ1dZyQpXA1Axd0ykwTpo75mudYTodnjekem9vJ/Go/ds=
X-Google-Smtp-Source: AGHT+IFgz2zPNG9L1ZbW7exQxYEvY5O647V/gLlmYq/g7IPXeZmynrQep/DkuaE0eKoumOW2JQOuqg==
X-Received: by 2002:a05:600c:1f1b:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-42acd5e357cmr58278345e9.35.1724678772335; 
 Mon, 26 Aug 2024 06:26:12 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac51579casm155940075e9.11.2024.08.26.06.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 06:26:12 -0700 (PDT)
Message-ID: <7a25850c-6082-4490-867b-126b480ba757@linaro.org>
Date: Mon, 26 Aug 2024 14:26:10 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] bootm: adjust the print format
To: E Shattow <lucent@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
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



On 25/08/2024 19:36, E Shattow wrote:
> On Sun, Aug 25, 2024 at 5:26 AM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>>
>> All three addresses printed are in hexadecimal format, but only the
>> first two have the "0x" prefix. The patch aligns the format of the
>> "end" address with the other two by adding the "0x" prefix.
>>
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>>   boot/bootm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/bootm.c b/boot/bootm.c
>> index 480f8e6a0e6e..951e549f19ff 100644
>> --- a/boot/bootm.c
>> +++ b/boot/bootm.c
>> @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>>
>>                  /* Handle BOOTM_STATE_LOADOS */
>>                  if (relocated_addr != load) {
>> -                       printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n",
>> +                       printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n",
>>                                 load, relocated_addr,
>>                                 relocated_addr + image_size);
>>                          memmove((void *)relocated_addr, load_buf, image_size);
>> --
>> 2.43.0
>>
> 
>  From U-Boot documentation, alpha-numeric input is assumed to be
> hexadecimal except when it is not, and generally does not accept "0x"
> prefix on input. So the correct action would be to make this
> consistent over the whole U-Boot code base, or remove the "0x"
> prefixes (not add more of them) ?

Most(?) U-Boot commands accept the 0x prefix. I don't think stripping it 
is sensible, I myself have gotten confused many times over hex values 
that lack the leading 0x in U-Boot output.

Maybe unavailable in SPL (not sure) but I prefer the "%#lx" format which 
prepends the 0x automatically.
> 
> -E

-- 
// Caleb (they/them)
