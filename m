Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33717C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DC7882D9;
	Thu, 16 May 2024 13:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bqLxZRbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC8B8832B; Thu, 16 May 2024 13:27:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12B188297
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4200ee78e56so37852945e9.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715858860; x=1716463660;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Xa8skHvPIb90c+e/IL7fkA2nOcy0cwUBrddiiyMGbQ=;
 b=bqLxZRbwuMwUcnLFZfPJRiacCFW1q0sa3dCWMK/Y0vIrn6AxADig20xTAirrEJL8rE
 x0q+ppOXlha0PwXZa0itPJNQ1NTwdXRGTStP/Lk/x3YqvqL11+Enjd24kQQYqWanygZ8
 wqmQ1C0J3SIt+40IgiHoXfF8Ti34VeSmAKkFefcacpRiPGShzCTZZ/MbpSZKZRu5f97B
 JoTClIZPTL1Ux+ImU92VBo6AlwTW7FCOpNzhQS7bx9KdQVHKZXg004uCS4WxjW/wWl6E
 +h5MvfKM9sa5IFaLUFWmhTDTcfKS205qO+aaub4uGMke1RISbN/6+IWmBKrrp263l6bN
 6XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715858860; x=1716463660;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Xa8skHvPIb90c+e/IL7fkA2nOcy0cwUBrddiiyMGbQ=;
 b=wBNpc7XxkgcuuMWuYBNJbDaJk2wIdxyCIwwapl7MwoJxhhj4luIl/qcE4viC6xdI+K
 cuzS/c1QqaD8IjWUThBQHKnkie8WQZ0lNIJyFfJK35/+6/vplZa2eRL5XGM7zzp4Wv9e
 uLBNbeY9+aVdt9A/aEjqD3eaMAjsT8S+KZj1dGK6F2e9SG9GASevO7GY19lXJqWcaI19
 xwBe6CG2OXRT98g7NSk02kLFINSe5qzY1X2p2zs7QIgH3npnMpQJjVkM3PEHulN8g1cU
 GRqC5y+W+bhbT9z3gT4YLpCbKRhbzwXRurqOso4svYAecPucHeTUKvBYQmL9ShPo7ucj
 51qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZYhJHSP0gX0SgIEKHg4hSsmXkaFh1+Fd3DGrwKUE/4KFQO6CHQtrWMkWmGt5ejf/ELG5z2wnlGlIue5pyDdVDM5cROQ==
X-Gm-Message-State: AOJu0Yx8Hx8ABxgYyIElTzJWbtRwDfv+u1j6TerEvad3MZGOt4C9+OKP
 pOE7oR6Sjq5aAxypTDto6U97RGS2aP9PudxjGH0x/HOJKp6jyh4AKi9Xi0Ycqt4=
X-Google-Smtp-Source: AGHT+IGuktmTXamnze5hfmmUhjUhO0lMXzPutyhQc3CqyocW4ERb0ip3BfcqJEsUfcGwXipauuaQkQ==
X-Received: by 2002:a05:600c:4ed0:b0:41c:14a4:7b05 with SMTP id
 5b1f17b1804b1-41fea93af8cmr125853715e9.8.1715858860321; 
 Thu, 16 May 2024 04:27:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f881110f9sm302466225e9.37.2024.05.16.04.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 04:27:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [v2][PATCH 2/2] MAINTAINERS: add USB gadget regex to u-boot-dfu
 tree
In-Reply-To: <87af8311-cd97-4029-a654-266bde702d86@denx.de>
References: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
 <20240516-gadget-maintainer-v2-2-23cc916df434@baylibre.com>
 <87af8311-cd97-4029-a654-266bde702d86@denx.de>
Date: Thu, 16 May 2024 13:27:35 +0200
Message-ID: <87jzjuyp20.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the review.

On jeu., mai 16, 2024 at 12:23, Marek Vasut <marex@denx.de> wrote:

> On 5/16/24 11:15 AM, Mattijs Korpershoek wrote:
>> We try to split work with Marek on USB as following:
>> - Mattijs handles USB gadget
>> - Marek handles the rest of USB
>> 
>> Add additional gadget patterns to the maintainers file so that I
>> get cc'ed more often on USB gadget patches.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Acked-by: Marek Vasut <marex@denx.de>
>
> You can try and look at the N: instead of F: (see top of MAINTAINERS for 
> meaning), but that should be separate clean up patch.

Noted, will review the differences and consider a later clean up patch!
