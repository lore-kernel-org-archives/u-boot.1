Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF1C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65D7160674;
	Wed, 29 Jul 2026 15:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XGX2i1SrbxPn; Wed, 29 Jul 2026 15:57:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C2736063A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785340625;
	bh=JF2eah2s+pn+S8k4W9Pr/I2ZEP4wDWyR6N23FSFKOYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ppSqbQWtc3MbuLm9hy9b95n7jyFuTtbXFKGb3hOpxNQ1V4EY2bkPoQKk1fOQCw80s
	 ysIjy5FKcRFJYwE0PfQk4e6XlmWm6uOkQeMsdxmByW8WkLy/srCZT9UeD5M19pZMb/
	 mjxB0Ao7huZAnO2mQvZS2qK/ZXDeorygbeqKfj+xICep7Cd58MU44V34j/q8VXU8eJ
	 a89fjmZcygVkXhPwDBw3Ni9ymHVRRqRFlVKPV6R1j0TcEEbaYaQLDfQNV6+FzZxLl/
	 e+psXj07WspvBzwhX8PLfhM6SaWQvMvOmmsSAo7s+jbdWnaHgLfBFdENJ1AEwMxYI4
	 coOa2oOtpamMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C2736063A;
	Wed, 29 Jul 2026 15:57:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 814EE788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F2F76063A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQNLOmWeoNr5 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:57:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A7B460612
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A7B460612
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A7B460612
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:57:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2EA8494B; Wed, 29 Jul 2026 17:56:58 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DA782991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 17:56:56 +0200 (CEST)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-45691990234so690180fac.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340615; x=1785945415;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JF2eah2s+pn+S8k4W9Pr/I2ZEP4wDWyR6N23FSFKOYs=;
 b=QXUavDIYjBWAlWeQH44HUNSZ/wLV2BBqvqBVPQ9fhEFCPTTc37EMvsO/4AR8lIxS9Z
 JpUTFHcMzhX0IrgyFOYqjGf73g3FJ+5IK6I0Xa+rKd2RuVbfiGTFf/D4kCN5O6tBz+f/
 ImASKAe6Hw9cEb5ZZzCxm/tSZqaJ4/JgszE30JC3NgWlnUOnm+R/MOMPi5ril/cDoNqV
 vUX8KtD0ycI7Xo3mLUMr743eQ+nBSV+WK/oGzNyDCo4CHuU1DKSwDmtxkk9E9UYQNOqz
 xDF7Fiwitmm5I5o4fqZSD7BqTyyulbFpkiC0xqgY+FnjEbKFPYSSdU/+D5gE4IzYeJoM
 bukA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5ke/3GXJssQ4kQBGc5T+K0IFPLayojBcwYufLYj9+EqXi9ZqdxWKvW0kQp6JbKHw5DQolQ9M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6KREaei3AYNubDTbEA4pCYdEKrwRt8HwL41PFwEQToOt++/Nf
 IMJRku6HbdembEvOhft9vg5pieJFhwDlo9XSLcTCgrSyjZV52ZISNZbc07ONtBXk05yfv55EdDO
 xB0uA
X-Gm-Gg: AR+sD10lW482bBbPEp9ZXoOAKqeGtfyypfj/tCUR+OzUNzxcj1gVJGH6OWPYPKhY5JQ
 Bx0rxFnXZe3YJL8s7EhOy2v26Hk6wCYImuEmNQzMFinwlWpL42hdhAr3XBKCPLvEeuTDYnfi6RO
 5GrkHbXQgCqSFQ7TGoVyaEdhFHNwfvNs8bZqYYI2ZvdCp8bHs4ecBoMH7+pgGsfm4iSsOUeR4JB
 A5Jub7ktg2M593Dn4hQTfoa/ELkLu2E4r5TBavm2naxYvClq9KW5+9W1kCBYxIwgqYUyDztDciX
 JJdqVa4rcOXZKtSqlz5ug5Catfu6+7ZXVNLNRyV//rlUFc9Icxw3vQi1Fcie3v8M0dC1muj5G6e
 VNIsr/oKT8tBFWyprjQ4LrYCzSCnM7VmjrorBgdyZLQHU8tq3LQQD+A2Cx5LfWewjMfZp2cTYyp
 mYGaq9bM3HsAXNdS1GfTQkc2TCJoIoTKreZ83w+QH8fWl2dMICOiZuuKuD0PUtkMt+g77oVSI7D
 XRctKz4ugzY/thcULOUqusO/HR2fTOqeyNJnsg=
X-Received: by 2002:a05:6808:1588:b0:490:af61:8830 with SMTP id
 5614622812f47-4ad5b942d04mr3945315b6e.3.1785340615097; 
 Wed, 29 Jul 2026 08:56:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6ef5d650sm2008285b6e.9.2026.07.29.08.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:56:54 -0700 (PDT)
Message-ID: <f1290282-98f5-4392-bf04-810943f77d7f@baylibre.com>
Date: Wed, 29 Jul 2026 10:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
 <7d48671d-1100-4c20-a1ef-76fbab25e1d6@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7d48671d-1100-4c20-a1ef-76fbab25e1d6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785340615; x=1785945415; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JF2eah2s+pn+S8k4W9Pr/I2ZEP4wDWyR6N23FSFKOYs=;
 b=kKqN9L+FLkf/HXwKbeGUh3YYQBQFaxKRHnHsiMmHl8NTy4xwcX3vM7FkAyYFwo4g1X
 O9lYs7ESQCD0tWQCkj8J/dGAuj/dLZ8Rb8uKVoWPI0ibGAGK3gOEwCJarN6LhtGUAPAk
 LPgleMbCISciWWLQNfoGflci0Ug1D9Tdx7pFEnicwMGa//GB9OvG8V9m2yWVbdODo9do
 5RelUYBS/Q11ufZk9YsjFmMnAE/IJkmhqKkzHcQ95g/frWbxC/GtGUmFj+1+WP/VMi/t
 myUufCGOJlS51EJli2axOHzgAH5PW+fptytwzYILyY+fZwda1UTZ7mMPvcVFV3wtiGCG
 4A9Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kKqN9L+F
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="kKqN9L+F"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 6/12/26 6:35 AM, Casey Connolly wrote:
> Hi David,
> 
> On 11/06/2026 23:59, David Lechner wrote:
>> Add some preprocessor guards to avoid a compile error when
>> CONFIG_SYS_CONFIG_NAME is not defined.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Thanks for the patch!
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> 

Hi, it looks like this patch still hasn't been picked up.
It is blocking us from moving some boards to lwip network
stack.

I can take it through the MediaTek tree if no one else want
to claim responsibility.


