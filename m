Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB835D12698
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 12:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4DF88F68;
	Tue,  5 Nov 2024 13:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CwGUH5Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028C388EDE; Tue,  5 Nov 2024 13:12:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531FE89156
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 13:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so42462145e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 04:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730808743; x=1731413543; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QgoxnoK9ZzEb/bnOLf9yjr/3OqeETXfirp+tHaJXfy8=;
 b=CwGUH5LbuUEbM/yqvRPtT7W1UsD8iZLTqtk3Ad32sdo1XvrnoOLBprtUETYZKcz7yN
 74nnMif2GqTutbPMLzwsbXWKcFzf9wHofjRgmzBxKkuAl7MDWqHDtGYlosMxnnnkdzz+
 s0td/jvurHhyeE2998PghS3RVe61h7YJvK56SnK6HQqRVPDrTQT7fn2t94B5QWgEZm8g
 9C8uYOOIewYlWpLsspv35i/9wVVDZzwqwTx8v6WO+8/D220M264cLsf3+XE0dCpTmNyd
 t/Bd3ycYdpTFoHIqHA9+H4qpa+qzRCV5ChdbBQ90rvBPfV9QcuJkwgNA7fTXUNwE1IKJ
 obvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730808743; x=1731413543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QgoxnoK9ZzEb/bnOLf9yjr/3OqeETXfirp+tHaJXfy8=;
 b=hplDtZAevgpRriqXTU3FOdoVvwhBlrnlCR7P2DUPB+kPSecW6YaLcHskxXZlZq+jt2
 qjIVwmmeLLCbEywxAoGpILy7IYi7/2trxP1jL4thc6yjtS3tcRRXFnH/cf08bGaPVptb
 4keAqwbJ08iJKhP4DSDZv2/Ue25uTVh0d8KgAI3ZEUuYcX73GQ8dWvxs82R4JnB86b0N
 mZgGczgctZLX24YiqI8CVFKwbMxkyzAmwKxMajVBVJNhJktOqwq2Cvyk53qXDDnJKQg4
 polAOEHQ13ogBc6h2Vt4IiBXTdp2t1AtgD6hMD3AOY3YSuA8zcQ0OfqYSkFJnHsycv74
 seEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHHpWEyWK/NQ+tG4zLFKLRD9onMtJyVI9f1Is1mc7kbZVUELCDYbdWS7Wp3yrBtWYCB2NO8A=@lists.denx.de
X-Gm-Message-State: AOJu0YwByEf/gPkmvOgyPSIJFiv8Kl7g25VLU24pSe0xgYxMYm8ZSXm9
 iFML3B1aoorUcrri5N0649MqwsWdjRP1YWTig+YoZbiDI8WAwib7oU/hL9rNcHtOGlplCYC9rIo
 W0A9ZgQWF
X-Google-Smtp-Source: AGHT+IEWmGeN8oUr2xcaMfJOw/Ythq4dfn8zrWiTl+0taFRhDoA1O+Q8gMQiu2rsvkvBBRENBpHzEw==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr323185785e9.5.1730808742563; 
 Tue, 05 Nov 2024 04:12:22 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf4e7sm185400015e9.15.2024.11.05.04.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 04:12:22 -0800 (PST)
Message-ID: <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
Date: Tue, 5 Nov 2024 12:12:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wget bug report
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
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

Hello Simon,

On 10/27/24 17:16, Simon Glass wrote:
> Hi Jerome,
> 
> Just something I noticed earlier...when running 'ut lib' I see this
> failure on sandbox:
> 
> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
> ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)

The reason is:

$ make sandbox_defconfig
$ make -j$(nproc)
$ ./u-boot -c "ut lib"
[...]
Net:         eth_initialize() No ethernet found.

I don't know how sandbox is supposed to instantiate ethernet devices?


> Also, since it is testing a command and is in test/cmd it really
> should be in the 'cmd' test suite, not 'lib'.

Agreed. I've posted a patch for that:
https://lore.kernel.org/u-boot/20241105120653.99438-1-jerome.forissier@linaro.org/T/#u

> 
> Regards,
> Simon

Thanks,
-- 
Jerome
