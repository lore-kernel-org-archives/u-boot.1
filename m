Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D993C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9CB831D3;
	Wed, 13 Aug 2025 10:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nCDt+Bux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421FB83285; Wed, 13 Aug 2025 10:07:05 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8496831C6
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so3912485e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755072422; x=1755677222; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zERW7KmyZFnGo/2r3bsYIhCaiRaOB7HTg+ka6SOlqYY=;
 b=nCDt+BuxMZEsEH0kRbyyIplIcFHA5pvCK5vYFwCrVCiQyhItBNx7Qac4P85owhnfMx
 olj0XXCS0k6pHdPo2Q6RZgRuo5JoChLoEoAlSTX8qcdUZ9sh5uhXFCiNCArQ1bdhopoq
 xXfypLQ2PTjeNsoUe6VSTZeUrhiLrJgLiek/T/6pQ96oVanr+1Jgozi4zfDWfIekBvcj
 efWdwcxdszFkMDtNt5KdNqah+d5GhpvDIPujIixrzkDo5XII9WcdJNw1wVS0C3ayvgXF
 nBu2OCzdNR0GR6dryOVtPXzBq/lsrY54yBnWgOQuH9Qh8+dU+BnxsF/AsgZ0/hfw9VzS
 2a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755072422; x=1755677222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zERW7KmyZFnGo/2r3bsYIhCaiRaOB7HTg+ka6SOlqYY=;
 b=YnXYnGaPACPv/YJzv12O3eDy5MuEW2oB6xpxofvV4h0+yx2VbSsuRCP074qeUcyToK
 R13xlV50pdwNjYmbQNFJP5rZ92qHzCuQ/0z3CKY91KgAsdFRx9FcV8Hh0I0YbHj401H/
 Jsw+CyzH6NZxxwyB1iZmvXZGJwxcz7/AXeCfBzhaYzc+pQJ434Q47o63Ng1L/iQvk+A+
 klebNTzmmIL8zYPgHjoJj1+GZoxKxeUOx3fwd68ibko8dCqQaqQEDzw/8KyAbrfP1Y3/
 +Y+Y8XBZKIvLszw5kf66WK+H7R9Tt34ow6XLy2yXuF9P/Q2QLM09wVBffhYsy3grOtxo
 533g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkpHqVYQ6VgxDBJZE8/P/JpvRZ620o1n5OybbAU9bpCZ70/fMrz8IDutwPInIdsDE3DLgvmqg=@lists.denx.de
X-Gm-Message-State: AOJu0YxnVk1ED3yKHUxFtLznU3izaFdw6fmK74k7yvnVlDeSz/WvLYYm
 silJ+GFN4yZ1cxQ9vAzTozJfI2Bek2krGIV9Cg5MGcDHe3m8WRQpvHEpKkIfEarINq0=
X-Gm-Gg: ASbGncvgmOaZoBUK0N7mysLxD4wU3YFBQc9HRfjw8tCyGtUlTKicSZDv52B0wfctbjc
 WJ1cJ0rU7hrAPJOVBK+7mmLYRFrI9s3fP5Ar2A7RzXmJGjeBIV5icPHcU96C+Ayr5uh9rRWBdpQ
 No8os/gb87EDJCFAD1wq/gw90cOcB4QKCM1Lto68o0FwdlTnzlRREZB9F2ODWeRtMJB1qQh0jMf
 rnbunOcDlsV9d1ifTAbXQnYqd3BcLcGgQttiwuQmnmzC6AyVwrKY57BXmYTZ2oxYLo+LGY/r49q
 d5a/zEfSkRlxaqCMlCwb9AG+jKQfAmte+CumZF6VIETmr+1ZAxaQwSY0C5x3hg/9yBmsEc9GWpt
 JbBmVyoEu8SD5LX5scsA1oZY9xZTyIyE8Gj78q3zk
X-Google-Smtp-Source: AGHT+IFZC0gqGX5cBgsvp3mGnQfiwVjp/q/vb6Irq0MVFlJNp4FGc0wTP4qRZ56bu7/j2PjfpflsAA==
X-Received: by 2002:a05:600d:17:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-45a1700b88emr13061985e9.1.1755072422235; 
 Wed, 13 Aug 2025 01:07:02 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm37039886f8f.31.2025.08.13.01.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 01:07:01 -0700 (PDT)
Message-ID: <c3543a4b-0fce-4ba0-adaa-5dc64a8706a9@linaro.org>
Date: Wed, 13 Aug 2025 11:07:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: gen_atmel_mci: Fix some Smatch issues
To: Peng Fan <peng.fan@oss.nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
 <20250805034659.GB29103@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250805034659.GB29103@nxa18884-linux.ap.freescale.net>
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



On 8/5/25 06:46, Peng Fan wrote:
> On Tue, Jul 29, 2025 at 05:16:15PM +0100, Andrew Goodbody wrote:
>> Smatch reported issues with duplicated checks that could be removed.
>> Smatch also reported an issue where a variable was dereferenced without
>> a NULL check despite being an optional parameter.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
> 
> LGTM:
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-at91/master, thanks !
