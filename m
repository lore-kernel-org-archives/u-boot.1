Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E5ECA9EBD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 191BC80C55;
	Mon, 12 Oct 2026 02:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PppmUvEEGvlT; Mon, 12 Oct 2026 02:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68D0C80C11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791772367;
	b=eG2tP6+1b8NS36gk5+um+VyteWCxxW5FSninvkRqE+P7QPqNXAehm+rpIXP6PPWfsMAT
	 76g8rt30RPfdBYm4RyZl8/Kte67FYjZQ2/3xUsjhvU4pHkWv+NiTtestUH/hk7jpdtLdS
	 YJ03w73YthStvwTzTjQfQ/ENC7nONa5zV631PEv2S+gJ7uwJVXrBFxVWJote2wvxQ1k5G
	 1jHWlcDHqKZ5ZA4WTon0JAtIKPQ4568WGXE8AMATyJgCEBubtbFMW5L5blvXpcJvdmnnB
	 pA1dIslBQNFiv7S8UNv8abS+HKqt3LqwU+krOkoSRqSRBkTXl35TgkRT0m/1weopTyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791772367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q8ksCVxphhvE5hbFaOGqPBJc+Hhg5V6NF6vPuqJB9bI=;
	b=TzVQoQfZOHIw2xoHVM1gbke/zaIcA9VIAuxfWvmw8NXXtgZdAYX87vyeJxHYpvPEWuXp
	 dhfmwFHE+PPGUueINA3F/GHveNdUuSsYlC0Eq7aCcRgb1XKIvIb+LrP22XiXiUGMioXPS
	 56bvr73tfXxslGtf93X8BrRQGRwMTW1YZqeYUoM6N1upjWHKAx8reaO8BfVmlUl2bI8Ju
	 6HAQX5cnqLFGMvZhFmQw1wyiDb3V4czN0Ho45I60+W/RnbQiiwD2rAKM/Z1Fy9akIKIHu
	 ZX2IGAMv3JKXTa8Ew9fZa+61ovZtmopRwZw71fyCCITvMjOUXCpN5F4/wtkxRqjpNGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791772367;
	bh=Q8ksCVxphhvE5hbFaOGqPBJc+Hhg5V6NF6vPuqJB9bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7WLiBm3ZZ22aTkO339OttMn/qbQZG9xDuhdtRsW0HbVS4WGgyp87uX0qYTAOnsvU
	 eAw0m70VCJteQDsusnScSZqXeX0Kzdi8u6QbL48OlTQtuadbnQqFo2H2wT7j8dlLyJ
	 XOv+f6uRsh9AT5dKhkMBpcWfTUfXZCzoRFH0fficezMW7JzBIN542b8e0SmqfMDjoG
	 N6N5MOihi/Cr0FdaXdjASUNVGhRqNK4j3De3ecvz4GlEsSygHkBQo58BT0Pvn7bBMx
	 q2zhxvkdQgiSbItje00mQdCH8lDfQ8e/qKfeL7hs1YX4J6h2IzaB12sOHm3RWbFFTe
	 VZ7bhbhHULXFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68D0C80C11;
	Mon, 12 Oct 2026 02:32:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25E799DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 234BC40544
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUhlUNz96sgR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83E4A4051D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791772365;
 b=b6/0ysOyoTMd/c/362t9UjWYbtZgp5HDRBJCbs3AytyjhrfFfNYsdlbQ1lZ/cFLvxtHA
 fvmJ5U7klCsVVFpjAsTBPP+4MB7TKIdsXYpzzaAOFZ3XaM7AD2ZfmAIO9YH5rSUq/WQT2
 DZ7XEE2OzNsPtW3cr6XDzwJrd6hI6BCuLlt3gGMqbYIvi9CuwWag7UJ6XUs4FNZLVtIlJ
 6Vh5U3oh54kOfFzt3e+2nimXFr+z6BhvQodcm4WQeyIjHq+3qoud5i1y6oXZDImA3kl2/
 njmyr7t8ZiJv23bckBDNcAt3sIQqXYvIHzgQj28FhRPSfIgxJj4XD7jX87VgTbmNFbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791772365;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=Q8ksCVxphhvE5hbFaOGqPBJc+Hhg5V6NF6vPuqJB9bI=;
 b=IcEJEvzxkiU1Ssg3zymG4gfNBin6bFhbYN0W/NURGCFzEzaLJDArdZqWMAGMZ1gZiiIB
 Ldxmc5srVicdoBtKY60bZEHNNNNIWQhZnIhBrvLnWCKZcZ7txthsZ4DaPMUpAvNQx+i0X
 wAfUxEdtc7FiRlEsLefp0eU+AfWMQa4wfLh0jldc3giY2lUYYNaR0ZhSjWgSdhKwJ/BYA
 zTiW80nO7OOw8W7pgMzH1u5gx12EmLxAIDPpUEaL9opwU0XHviFbSSGB0yIW7acz2JfcK
 llmskWfZpRuskAUHdVrYoHyGO8wjIRy4raHDLIANI62k4ot1NTIXi/tzk5TgCPn6aSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ffiok+CJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ffiok+CJ
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83E4A4051D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:32:45 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-88bda150550so491579b3a.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791772364; x=1792377164;
 darn=lists.u-boot-project.org; 
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q8ksCVxphhvE5hbFaOGqPBJc+Hhg5V6NF6vPuqJB9bI=;
 b=ffiok+CJaJNbfhtesx3C9zwogWt4fjENBDG+GVQtU+K423u9JYo5BTMGVl1+1REoWv
 9noQEh9w6b7JnmNbB4vlxQc0d2px+Q2yedkbALYF46/DIzIyDTY+IvfONuwpFH21NKXD
 kAdEHDPEeh2qvW2cPZKKiMSBs/okBBe/GSHiTCRVxVI/zZ0d1HuMwgfL8E5E3owCaY6x
 SprE0Pu4OduOo1dds14jM2CNjcqMbXDDyzNmHkjHBntmRrzLe6h0/Nabrb17bQ6U53DJ
 +yaGaHlnSytfgsVLgQDXM317c287nr5Z2puix539J2GJkkfOSYDzTxDqkWa1t+E2/RYh
 oCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791772364; x=1792377164;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q8ksCVxphhvE5hbFaOGqPBJc+Hhg5V6NF6vPuqJB9bI=;
 b=vaR2TeJ07DiOfYep2WjXjDrw4kXZLLD1aZWNey3jylNlmdAIv0ifEcm99tMzcWbvt7
 gjwnyudI1imPoIrCuc6FzlfzdportkXxuBTbEQLJaaOrWJRQHl/sjKS1GqlDX2Fgtwi3
 MTqXx7z3chjB05nVnjkqeYsGxbfzNq8rYefWyo5dc6mmViCWpbW7gLrOWqM6i52AWjhG
 qy0er+9inzA2+jkEkFIPCEWNb5eXaMRWmTcw7TXtKOCLA/0NvxXlNVhixdoX0RirB0fQ
 hKD+er/3HUQ0S7IVIDKxOitQXHEDG//j0OLEytthNbe37x5J/l56OLo6eeS2QuO76MhA
 58OA==
X-Gm-Message-State: AFq9FYKytrKWsjAsghhhWlpu1vhcO6PZ2yK36zoezTDmXcPv+YjuAoGl
 DaPs1FNe1m17VwiaPNdSRQ+/LgicdTDMavE7wdVXVKeIrsw2uMj6uvIusbRBHne9+Uw=
X-Gm-Gg: AYBFou1fxVkutcB3sw3BAV5h2GfqTNCuyLUOQ2JPqJJqDdpBCEP+jHSEGpjNEzFNBJI
 4XmA3/mn/bKlVd3njTXePCAnwqC3qtE7/cz5a+pNQfGzXtYv58RNaHZ8T0sFYtPqGmpcUAPsQc8
 mU0ePgcpf8XIEihADG6bztGqCZiN0A/UEV/w27MZFDFbA9epZj6HgxTVmDvPonOS4sEnxkjn1LA
 A1fUOviUMHNYmI1IwXei2CaBtwlU2ZQ0PTiYjgQRYdR4PkAM+l1pW6BEaawnxdRJsH1mHOZPfqY
 2wqsnhYNoRAWVCkhTSBjoFyfWv42a+SRZnLIqB1+WJ0Rc/vkr3g4yNwNasueYityx+rTklhwOBh
 eEOyQ7nMyO28+4ABX6v9iNTz6ImMxopvVFwUmpJeVQKFMNwqMiUyIwngYvFsELA8bu2RfbW8I5R
 lWU8og0Ud3c3MjtozICjKA+pCJ585kt3NGrQTC2f3c5uTA2Q9ap5lFQZllaVg8y6LseWpaZFSA2
 5gwpjympJwj5/aP24KYlCBbIALCi0o63+Z99LMI/mIiNyoQUomul4VU6Zvg+RIiLrfPeEfdgg==
X-Received: by 2002:a05:6a00:1954:b0:882:6836:25f0 with SMTP id
 d2e1a72fcca58-897c7cd4bbbmr7226008b3a.52.1791772364365; 
 Sun, 11 Oct 2026 19:32:44 -0700 (PDT)
Received: from [127.0.1.1] ([121.165.170.166])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3cca5a6sm3393163b3a.31.2026.10.11.19.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:32:42 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Romain Beauxis <romain.beauxis@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Date: Mon, 12 Oct 2026 11:32:39 +0900
Message-ID: <179177235981.160645.5738595815037361598.hcca-reply@gmail.com>
In-Reply-To: <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hi Marek,

> HCCA is communication area ?

Yes, HCCA stands for Host Controller Communications Area.
The comment refers to stopping OHCI DMA accesses to that memory
before OS handoff.

Thanks,
khaliforce
