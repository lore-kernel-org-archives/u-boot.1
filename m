Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C02C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6161484166;
	Tue,  5 Aug 2025 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RtgbUkOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C668684171; Tue,  5 Aug 2025 18:30:54 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E578402E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so3971703f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754411452; x=1755016252; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xgwm8hHP3IBQddi354q6p/qv2b6r6lrzMMjgDgkAHOU=;
 b=RtgbUkOw2EZVY2Hpauv4oohCv5vxHCmpp0KL7fB3CTXhO9Tnx7RFXt8hmH2wvLr++5
 I9yK8+UPJD5+o1qZWh9VsDn78BDSlprZpYDk4jOW/4i6qmwViNoYAkSH+l1ETL+/1gww
 y+8kWH71tBHIDmHNIaW4bDRW/9dX2JQJKasHA96sWuPpqB+r6SJIjg99Zaeq12Ou3LIA
 WT+sE/PMqEPPzZfxcebBjhT0p7OeNVRKw8NB4Drk5jN6bz0iukd35saNiE90NHhNIQao
 bMJjyg8egm0vBgxNXIp2+h1qoVvAoH2eBhTGMDKSFgvCRZG8QuEu1bkmpd9ZcopJMhyB
 CyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754411452; x=1755016252;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xgwm8hHP3IBQddi354q6p/qv2b6r6lrzMMjgDgkAHOU=;
 b=D1fssLlF9btVSO3PC/Lwr4rHt4KK+6cMd6TY3SHXcDi2SDNxERNzKRbXXVSHOj1nNI
 ORknJUemh/2rBOwaWyuhXCt2t+fBK57Ac4qd95Ol1RFTeDVaz8WUSo3veA5Aw/npGeqF
 cT6cgyzhafbbFgC7FPtpwqtCN+KK+9cUEGNMJAtONLGn2n3sXIZDhP5w/m0JM7BSD6QC
 /VlhnHjaFNNtqbzFLMmVxCaUHAEYdsBjRB+oWkn9NAsjN0mbc4xJpfHAp9njKn7FRy+i
 GQuwMAAJHWlzSovH18HclVdeX3AZDWsx06OJqNguNGztkkqvGjtn/UINEPjqVlqWVuJn
 BBAw==
X-Gm-Message-State: AOJu0Yye3yVeC9Hues2X2dKqODrpH4E6ge0/GRTkfOQah//jxO+6Dbt8
 ZxBo1Z+EHQOYZBpUVmaxv8NHuZ+jVygy+jxcTVzdghafrKi8O5yPniSWxr2OeBUXUFI=
X-Gm-Gg: ASbGnctTcvmJYhIKb0z2wG7luWCNJhTIWlbnHb5+5ygy3KXu8nOQ/pdKo4k1GDozXyb
 XI5XINvp7txibxFBMlL4ub4/vXqqO+fRlpUTGfrHdL/0L7Yk+VwbamdYkQwI/0cj1BfMKVpvdDr
 WQ4ohC7V9j5FdLJhsam3IAkuiF8WUPCmTiIjyDfC2Pq9BW3+Tq5zXAOCbRzgnuxP7nN8CpTZW+L
 rk5B1ZeCr6AJldtcveESTUq50Om6fkjXUPXCXHNUTEUdI8bGCgMaqtx8GzRCinBbQmWGkf33lyv
 1iq5Dcw+7BmXBHcLKB6eBSSrTUnsATpqW6LyIML9PtjbIxy8Jz/bysQcSW4aiFiCWHIs2WO9laW
 tF/Zxyo5mfXigNEm+RWS22jrxjez5ujz1CKOFtJamLLoD1rWO4+NvlyaCvKdJEC7oDeWwBqjl9Q
 B12P3ej29uWsqw
X-Google-Smtp-Source: AGHT+IEa3bikngimFG8ZgzDSs7YPfFH2eahBlIT8+y93qPLkYZUROJtdyKe5LVaHuTW+MONCQdF/0A==
X-Received: by 2002:a05:6000:26cf:b0:3b4:9721:2b19 with SMTP id
 ffacd0b85a97d-3b8d94644admr10603203f8f.11.1754411451947; 
 Tue, 05 Aug 2025 09:30:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35?
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5862be7sm11421415e9.15.2025.08.05.09.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 09:30:51 -0700 (PDT)
Message-ID: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
Date: Tue, 5 Aug 2025 17:30:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch report for drivers/net/phy/marvell10g.c
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

I have these Smatch reports.

drivers/net/phy/marvell10g.c:384 mv3310_select_mactype() warn: was || 
intended here instead of &&?
drivers/net/phy/marvell10g.c:387 mv3310_select_mactype() warn: was || 
intended here instead of &&?
drivers/net/phy/marvell10g.c:390 mv3310_select_mactype() warn: was || 
intended here instead of &&?

Now there is obviously incorrect code there as it cannot work correctly 
as is, phydev->interface cannot equal two different enums at the same 
time, but simply swapping the && for || is not going to work either. 
Could anyone please point me in the direction of a fix?

Thanks,
Andrew
