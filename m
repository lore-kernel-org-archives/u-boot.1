Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C33C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC16A83404;
	Thu, 17 Jul 2025 16:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wmCTNf/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097FD8340A; Thu, 17 Jul 2025 16:56:41 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F38E833F8
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so823979f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752764198; x=1753368998; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4YSnUBiMBgHhiiNrZwUVeM4DZTY4t0tAyFfdugOXFPc=;
 b=wmCTNf/B8NOeoZr8vd6kUtedmnAqbeCi1Pz23nhlQw6N9T2RxQLayFGA3k/fOGxkHX
 ggSZPWcP1a+f5hsEqgCMB7IydS36fXGKEcVRsMTKbXYMmBYlDvDCkQDvsvqJLOk0bl/q
 cLid/7H74vbGF0CL7FcYTggFuIjNKBs2tpmMXuI7ZVOh+PsYXXN6O7KCsM0euXI8bqhi
 Tj9DuFqQ0hjncb8v6mUW9JQcKrtTcK6ub8RrEPtx0qPCELIcBpLBS9GcSYEijLB7PjXj
 DyuHFJqN6WRVCshjnuxTnTRN2OfUp1SHOjy/iYGBQ6Dp6q8GzjzkpOtnVFbOhGTFYB0C
 YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752764198; x=1753368998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4YSnUBiMBgHhiiNrZwUVeM4DZTY4t0tAyFfdugOXFPc=;
 b=uCAG+WNflS+d8iQc5J4e0+oX6LedD8QZjmr9NPlXRXEPrdqUsxv5By5sobu9T0dMLU
 ttO5ya8ODuC7bn/Kawe0zTnflsHtR3XtRX0mu7mOfRJajeURlohURT3m4cwcJg2iymWk
 9PfAWCuxeF3wjbTn/ZK1BcGIYlgCk/HmFtPCVjJLJ1F6WBSiTSS35s1idkZ21vcX4D1y
 IsDYeswnFAPcaIa4K9JKFXoPhURmcN934mIv8haxxcMAhCrcUwmMhTIHUBtKfwNNdlSb
 jsdbqjLmTYufYUjxnKQSNkWADYZhuHQts0lV1pV7/9ZqzCWIqPCOlD4f6/QxX9kCj/80
 idoQ==
X-Gm-Message-State: AOJu0YzAqH/ZSJgv48wTqKpPlhRbqtaz5dWxl65ESMtclbtKlJ8rbSEK
 97R4Dzi0QDuA+Rw7dEoFtcl9SWmlgIjsRutY+I3B3YbJV72XlOPlJKmDmIfXNxPs0h1BF+JQx49
 chXKT
X-Gm-Gg: ASbGncvryYCYH6wms5Cucq9Gd34S8KwGUJWVDD/0zq9zeFqaTpbj/+zHjzwdt6F1qLS
 /gxsffwDP04QLzjP0o9PIlHtcPUeLcuKRsCEzdKdv1m4KPg3NKj6vOS378XJg2wLn5AeaH9FcI1
 zxtb/mmaalOONHZZ0q+MVqm8+Dt+NJjzjCSrruFahOjYal+zXsYAcHXgahEM0+/ildXpGTb4/rK
 OE3xxsZQYSgkUwCDMKRJGgZlJVDD8xrNxh3zbEMfynkzX0EDHyNNF9dL3dLuW7gEGHo0e8CWavx
 VojY68m9PkeUe6PujuWxHEKut5tfe88PtezG23Mzyy4cLuz8HIxK0PxIV13YRBXXSxS/pIdrFW1
 4Fe9GIjRmrfd3I+Lr8qhgnKOiz9/uL0FOkRKrV0yVYttTTF3vLkZmo8mHxdU+ppoBQLrjXsCHgB
 boLQ==
X-Google-Smtp-Source: AGHT+IE3QKNAIgwuZNrxQdYFBHbN8yHC6qYtOay+J5lOT9ulq1u/HML0h7yVUg+7ISbidDni2t/4QA==
X-Received: by 2002:a05:6000:4b1e:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b60e50fe9cmr5496720f8f.27.1752764198327; 
 Thu, 17 Jul 2025 07:56:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb9:1701:f497:a590:bf80:45c8?
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e819e04sm53913045e9.18.2025.07.17.07.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 07:56:37 -0700 (PDT)
Message-ID: <e39f6445-c9a6-496c-8c37-cbfa5b86f0c8@linaro.org>
Date: Thu, 17 Jul 2025 15:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: exfat: Remove unused label code
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250717-exfat_label-v1-1-e15f28fd6c6b@linaro.org>
 <20250717144602.GM193579@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250717144602.GM193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/07/2025 15:46, Tom Rini wrote:
> On Thu, Jul 17, 2025 at 01:04:58PM +0100, Andrew Goodbody wrote:
> 
>> Smatch reported a possible buffer overflow in exfat_set_label but it
>> turns out that this code is unused so just remove the function as well
>> as exfat_get_label that is also unused and the helper static find_label.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   fs/exfat/exfat.h |  2 --
>>   fs/exfat/node.c  | 54 ------------------------------------------------------
>>   2 files changed, 56 deletions(-)
> 
> Since I think this is just pure upstream, we should guard it with
> #ifndef __UBOOT__/#endif like other parts to make future resyncs easier.

OK, I will update the patch.

Andrew
