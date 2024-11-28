Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CE5D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01038962C;
	Thu, 28 Nov 2024 16:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QXm0qps9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D098A895C6; Thu, 28 Nov 2024 16:20:38 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D21089384
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53de579f775so1312362e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732807236; x=1733412036; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PvpSqSxLk/Yd6gOijAiRUXYYlobadBMazDIb56aX83Y=;
 b=QXm0qps9Z2yt2pruSkvYEjZ7ccAF4oKbag32n65X7o0PtgIQcq3xuFSIc2lAQFBGdl
 QIdbt0sqwCFCrkJmHZt32nF9BPdHfid1Lxem2D9TF+HYQ54jSe7SxF5tY8Epv1323y8K
 O+cnVe2Y2X2Vs4x8nipvRmFhZ62pVr7ZOGpQLmladEH/DSbz0IqPYKcJ08x98hj6v0Mt
 25atRiTxnrl1OOdxjeP06Sc9UUoIT2944OiuDS6daYKtuFsz2I4i28LXMUtcJtphIrZU
 cGO+A5K1ktCnL2+kL/NzIJJ3qm4KXHpw9hXeLyippKZd4BQQXsMXOzYfpCd1i7DqNU0t
 EamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732807236; x=1733412036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PvpSqSxLk/Yd6gOijAiRUXYYlobadBMazDIb56aX83Y=;
 b=Mhtfr31QJYH/yxyCbKLyQcjJelE56V2yILKgA3zvDB2I6qlHM9XvCoVGcBAvH5j44q
 ml7JzzFlmv/or1DpkOGbNzESvEEnI9X8z9AChiaNDiNY0cQJKsX52B/8n53Qh9vqSXlb
 /3v3n1sy3QLNy30OFvGDCtraa2sUReGNd7gPjANVVb3HafpFQ6UvjnmgmqP+xqBdZR0o
 A94fEDuROSE7qkBB0JyDRBHiyaMb/2QJLXer02dOai1cRUbtmKOH66XVv9PT6Qurl68F
 Kg5lf298VwI3oQhxzFjfjgUG+f94XDanOmjtFjt3gZ+NhY0MD3jlEtd5CtzyVbHUmbdn
 cAAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8I5JKOAbbmv9nuxrYe735BMXbRZtISrkJettUj+Dip/8itZ6DI4jOT2MCEKCwqi6+YwUNpyc=@lists.denx.de
X-Gm-Message-State: AOJu0YyddXN8F1hHZEyFMabjDURs4Yjk1VFbAwUBGvHwdce8sVn0FAdO
 2Z0TmmYEm0cf0+i6lMGhTCFtkrmA93qcQj+qXeghzXZ4ztzB9Y2qf6e/Fg0nAuE=
X-Gm-Gg: ASbGnctabUjj95OZeC6oxacFZKPGwagzt3cau2dFySLdFyyWxCv3LVwtOpBIq1xkbyR
 4XTwRJ7GIJOxvNu1n+F/Y20n39OSVX0dFYlTfH68l11QkRQEzrL1xjXOOsEoeVtsG7iosrJrzrx
 sEXO3mxW7I1Yr0nrhJrrGCe/IqxW2Nama25yKW7hfSbBOr4ejhaRJ2yacYxNE+ujYkZ22h3GXlA
 B7sWsM0Iv+f3J5G1fiPdJn5FKT85t5nLLCU9UykB5t6nSuInA8btHZ3Uvb+rZzBXWDbcdQar3ls
 9UL8sVZZWU99L0id8QX4oZUx1f4S2Q==
X-Google-Smtp-Source: AGHT+IE5dgLf0XebBIjGHmC7/pJpA9SLe977ogHiSUZc9No11R7WpXbTV/H2UoFs+/Ieun0fUQRMYQ==
X-Received: by 2002:a05:6512:1286:b0:53d:eecf:e25d with SMTP id
 2adb3069b0e04-53df010b161mr6804050e87.37.1732807235788; 
 Thu, 28 Nov 2024 07:20:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a?
 ([2a01:e0a:3cb:7bb0:869b:f8c3:dc94:123a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a777sm76736966b.154.2024.11.28.07.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 07:20:35 -0800 (PST)
Message-ID: <da818188-cfec-43d7-9d7d-21fbb5530f9c@linaro.org>
Date: Thu, 28 Nov 2024 16:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of
 5907c81
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20241128143704.590211-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241128143704.590211-1-adrianox@gmail.com>
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



On 11/28/24 15:37, Adriano Cordova wrote:
>   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
>   correctly rebased on top of the changes introduced by Commit 6cc4d04
>   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
>   This commit re-applies a  couple of lines from 6cc4d04.
> 
>   Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/lwip/wget.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

With Quentin's comment on the commit subject addressed:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
