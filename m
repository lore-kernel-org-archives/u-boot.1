Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C6C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D3D87974;
	Thu,  4 Jan 2024 17:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PlHx3utL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FE8879D3; Thu,  4 Jan 2024 17:12:24 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA209877CD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so3761125e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384742; x=1704989542; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEAZ1+3PDgrBvMaavHxTgu9FfEvBZn8PsL5jxNXS7OA=;
 b=PlHx3utLzc+5Gvp4+Hlc8w7pEp3m5lx4QwWtOBtjNJe24PYO2ZnQcI7idXeFMzKHGa
 AYIHPc+amkg+OMED4okroR9E6pid6HjEXnsXD3iilzGqcSuw8uRuWInS1mMW/kDacb2Q
 kqZmVyu7jcUHrFXA48O9D6ed06ijTWTj/rV8jJVu7DcrE1wb055RImwbpZkU1qJTIh70
 lOuMpg4ztBvfOwRwBG3ee6UgxQoOpCoCL3gb+G1p2Sa1GHiKXfZ+FXnm92wPefmqcWup
 hFh8wRrad+cHXVP10Crg6wEYKRdKCNi1HzieqArnOIaPxCPIOCZfGNFk8ipsqJNfq95A
 Hm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384742; x=1704989542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEAZ1+3PDgrBvMaavHxTgu9FfEvBZn8PsL5jxNXS7OA=;
 b=FKjIgR05ZvLUitqaxqoTbwhOZHUiZtlQwRJG1gJ+wBqUqMgCB3qYgC1yX+oVuUZaCW
 iu6co8P4IjGDDdFaLYl7axAy6Qw0Xq8smt+0GjRf9aMq4Yaz7PSsACzsyrSeBkp9ON+Y
 l01igGJ7PHwl3HoQw+6ZYEiDM8DzheeuvjOS6z5kd5MeJFEiEibzAwWPq1iTx1pWJLPE
 iQQEP3qMHtJC2NW+Er5KOrP69TMM2kA7eZ/gUPRo4X/EZWNizRCV5I2aKDARD7+yBmS8
 q2aT9Pn62xC/d/RZPs7ozgd5tROUop7AZ+fvVT6su2g7s57dHTianYajSnp7qIHZvZsM
 CF5A==
X-Gm-Message-State: AOJu0YxtqEU23IsqFJ35uX5+YVqVaQ+qywaH4WXIpW5utrEOioxzrp07
 jVn6zezOjvFnfsnEfBmkNLX5fzlq9XThuA==
X-Google-Smtp-Source: AGHT+IHi5de2uF14zKDX+pp8lOYhROTORjc/vqhpn2I0UXmboPP94+Dc75wcZRNo8lghBSn18GeyYQ==
X-Received: by 2002:a05:600c:1c10:b0:40d:81d3:8d21 with SMTP id
 j16-20020a05600c1c1000b0040d81d38d21mr542093wms.124.1704384742114; 
 Thu, 04 Jan 2024 08:12:22 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b0040d579817b0sm6170300wmo.15.2024.01.04.08.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 08:12:21 -0800 (PST)
Message-ID: <64b2c04a-be50-49fd-8ad8-421357d0ee91@linaro.org>
Date: Thu, 4 Jan 2024 16:12:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH] bootdev: avoid infinite probe loop
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240104160346.285881-1-caleb.connolly@linaro.org>
 <CAFLszTiU-A2bGbJG4k-sVB9W5gMF34fi4eq6Xjhab8s_ez3rEw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTiU-A2bGbJG4k-sVB9W5gMF34fi4eq6Xjhab8s_ez3rEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 04/01/2024 16:06, Simon Glass wrote:
> Hi Caleb,
> 
> On Thu, Jan 4, 2024 at 9:03 AM Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Sometimes, when only one bootdev is available, and it fails to probe, we
>> end up in an infinite loop calling probe() on the same device over and
>> over. With only debug level log output.
>>
>> Break the loop if we fail to probe the same device twice in a row, and
>> promote the probe failure message to log_warning().
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Resend, actually change log message to WARN loglevel.
>> ---
>>  boot/bootdev-uclass.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Thanks for the fix. Is this something for which a test could be added?
> One that fails (hangs) now but works with your patch?

I'm not sure, I'm not very familiar with the U-Boot testing
infrastructure yet. I guess this should be testable without having to
solve the halting problem :P but I don't know how best to go about
writing one.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
