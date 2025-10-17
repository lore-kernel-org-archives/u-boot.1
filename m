Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D77CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 16:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92B68384E;
	Fri, 17 Oct 2025 18:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P1lPrA4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D3883849; Fri, 17 Oct 2025 18:09:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E1383869
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 18:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso15839515e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760717365; x=1761322165; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uw9zW1+qFQXzyEkOX7AiDBF7y42v8g7mOEOhPjlBAnA=;
 b=P1lPrA4VNwfIUj02MOCBAQokZ5Ey7hQiRxL7rT0lRJrUIHjT4jd2GjR4AA3QxWWt53
 lBDHfCUJTLcPh+J9G7FeVEXFFFxb9G2nKkFcUNLVhYXlHw4JhaWHNrLa69hgww+mi3sW
 2IOqece6Ka1/EBcHBnHzDN5BFVGlmrOKxmjnjJPF6hvYqvWZFxXzeSIDiCJF+kkVqlyQ
 0EMmsAl0EbC7islXC0iJx56Eofm6avMjHGdmzici556H/L167Rx3Uc7pXVhqYTLaBh82
 DSuIYPUnoQNj/5kCs1MSwA0wua3TiHDsuiqxJBgSPAmA8/P+MmiDGGH4qStvmuuykKLs
 LA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760717365; x=1761322165;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uw9zW1+qFQXzyEkOX7AiDBF7y42v8g7mOEOhPjlBAnA=;
 b=PaKae3o5stRLwuZ2ZVu/f/WhlhllRh2vyE9+KpcwuyCnLi+/yT7/YHxW86peAjh1LI
 TsXr3TXF/6ikoSUF7z2Snbt9KjRylKKLuaAtY7bWug4R96M6ChEcHM5DxGNXunQ0/l9L
 C0jclspCaqp8jcG9GtDPx9MoJkF8zZHBNLAXSreh0hjlGoH09xg2RsCXBZoiTph1gr6+
 C4Qmo9cuI2TjwUoqZPW3yTCek3o62uYJgWimTuc+Pej8BOzYu0A/dw8PqI8GTAEFCLXW
 3ugcoSBxwuaw5+GocrTRSe3M7mK3OmZ0sb63GOkHPqGgEwq27Nea+zWQ5fSlcVHMEnHZ
 dyRg==
X-Gm-Message-State: AOJu0YxCmPYO09bTrQ4VT3V+kCv6RrGaLtes1AGmX6wh0c+iAbqOQf/N
 F5u42b2j6wnRQuw3AavESMyxB0XoGdDL24XuGAWDgAXTgtUj2yRku1T9kNtKp/1uLkPGdj2Yo1n
 KEfyn
X-Gm-Gg: ASbGncvrCuWFz0mC21Xu6Rv5sJbzCad4EmUGFv8H6JCrxdNBrXvIlvrElY1aJ+FlHpP
 jOVmFHkODSSRVcOn0RYSqgMjGe/0cvCx/On+hCW5A44xMkasVVDhD5UUzBhzSkCC2RmNV4KTwFi
 nk2gkTWj0FX9I6vJDLyA0Ah311I9degsQKR0flt64KqVcg1KbzrzMzDu3Hb78qXGg7QYP8bfH3o
 KNUfaMheu4jPHm7YsZrST4UDfweOLALoooCthppIRTi4Bsj4usEApXK+Z/VpjqtToQIyvqymzbR
 gcdaZfKKvyR7h+DmcEmV0g56+yo6C4fTGh62q3/0KWbK/tVO33TRdSvQH6jpLb6wE5Y/kNysNd6
 4TlADzTy6DvRBWW1YMdnD26FXebf9LKcWPasTUcpPJLV8sg459YewTWRWw9ssgCPqFoiHZx1xBP
 f+rLEh3aq4prkq+z2bMAg/HAD3e3ZZBQAdskH0vK059wC00W0eNAShg5c=
X-Google-Smtp-Source: AGHT+IFJ2aAGXT0uqHJDIk06VjO5DQxmuK6sdRsJ7pQuimOyVod1e6ZNDuw2YMDGSJTVxPitmcQ5fQ==
X-Received: by 2002:a05:600c:310e:b0:471:14f5:1268 with SMTP id
 5b1f17b1804b1-47117907a77mr33398255e9.25.1760717365299; 
 Fri, 17 Oct 2025 09:09:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:8b74:b42f:5bd3:638a?
 ([2a0a:ef40:fed:4601:8b74:b42f:5bd3:638a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82b8sm88222415e9.15.2025.10.17.09.09.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 09:09:24 -0700 (PDT)
Message-ID: <d3f247e8-099e-42ca-bc7d-d66ef30d2f3c@linaro.org>
Date: Fri, 17 Oct 2025 17:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Github testing stalled?
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

I created a PR on github in order to run the CI on Azure. It seems to 
have stalled?

https://github.com/u-boot/u-boot/pull/820

Can anyone see what the problem is please?

Thanks,
Andrew
