Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94E4C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 12:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CFA81A0C;
	Fri, 14 Mar 2025 13:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gZmbjGZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD03C8186D; Fri, 14 Mar 2025 08:40:23 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714248007D
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso11672915e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741938021; x=1742542821; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ZOLox7jduaOPy21WQMQztTJ+RxCY0l6lSDUBUxE5do=;
 b=gZmbjGZFFnMVc0wgxTZGlItMA8S9rAOZEwuXhup90KUdmy0P2QsQts1Of+3VTMEY/u
 OS4B7BEavRDM+8MGiLreLA7iWYlEj+142stZwrGLLut3wLmOg6NrbD1aXTpvpFzJRVvi
 gQy1U7S7jfPmItkmkkBxM0sm3Y42ncpMPm3Mm0qB87Ip9162gIIbmKSGDjUVsq5sMz7c
 XW8oLam9y7D3IWftXVAMNBXTyFh/o8E9e1i62b2+Y+KonNpDUG0i6iOj1xFzZa/LL8C1
 TQWfNFswwlmUn19vX9e9Q40hco1fIz6uX7CYaxRebXzLsAgy0oIIVE227MV521lK5Gwq
 Y61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741938021; x=1742542821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZOLox7jduaOPy21WQMQztTJ+RxCY0l6lSDUBUxE5do=;
 b=sZBWcYKFWjiWDBn44EZYVyeRSeuebhq1dBEnNcgipM+x95hXF4N+7UmdgR7FEh3Gb0
 L435FarMEQMYrJWbub09NPvFe3anlbL6ZcupRpsUJBVpMwRBA9yiJQJidQlLg4aGPL/W
 nbQxXqNs8fT1zz8ysMegQUmQcmvMqngzVaD6jVW+I8Cja7Se1MAkQNEMnJjPqZTPwZDB
 6hX2+gMBG2GDJ8bO3EBYrRPq2PWJ5GHhZQZ5GWJ0D2BYMwu+nwSM6ZHUu8fjG3HPF1Xb
 OzSO1Rf2wXcaUo4E5xx0D/QbjpFb+qgvINhzHV5uOsOrGHRRtQyxdk690X0KfZKr5Gjs
 WxTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbCOEOKEupeqxoBVygftod8Jiq0EMbcDDaoMJdADiX+YmHO90Y2SvNl9GnNTJNcfcRQi+ET3E=@lists.denx.de
X-Gm-Message-State: AOJu0YyhEgcqAUkrH0+lMaMojI88cGyi8LMKRt9TaEcaEjk1TPLfYqZ4
 cOIuOIxnLAXf5h8t7xQ6EweMgTL/L/w0IJYQv4mP76wunTSOkmXSBFLvjkmIIy4=
X-Gm-Gg: ASbGnct0njef43rsNWy4KgCDjYnuQ3lWYfpoJo3cytjl96lw8QZo9bUp7Sjf0wrnATr
 g2ZOeLy8bQ1BVKzN7pzWLaGhcxbgovxCHZX3dhMdI83+xCgdduO4HzRuMOZLqZEZupODm44FGQQ
 Na36vmpElXAJnY10jiNRzTB/qbLDjiVzcYkRCXdM4bt4w0pEslWapA6QpemH8wlK4JcDwizvyyS
 kfbUJTyXNZ48Hfm9az90KdOBXKqT93qSYXHFvr6DLn/+p3NfGcepVEPZR2q3EYenhw4eshENFDE
 T83czHC+mjGWG1gxwVoB4HcH+XZpU98Fy68WZrPeaZzz8IT8iputJw==
X-Google-Smtp-Source: AGHT+IG3fhtQHcqaaBm1gYvjtDpykFBrWy/nif6FgvN1I1Xjrftoius0kTYw8K3vn1FDyuW1fV01MA==
X-Received: by 2002:a05:600c:1d1d:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43d1ecd2beamr18124935e9.29.1741938020776; 
 Fri, 14 Mar 2025 00:40:20 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df35ecsm4746324f8f.16.2025.03.14.00.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 00:40:19 -0700 (PDT)
Message-ID: <b4fa6dc3-d9c5-4543-8410-5125a6fc9b7f@linaro.org>
Date: Fri, 14 Mar 2025 07:40:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: spi-nor-core: Rework spansion_sr_ready() for
 parallel memories support
To: tkuw584924@gmail.com, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 pratyush@kernel.org, ashok.reddy.soma@amd.com, venkatesh.abbarapu@amd.com,
 Hiroyuki.Saito2@infineon.com, Shinsuke.Okada@infineon.com,
 Daisuke.Nakata@infineon.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
 <39ff6a5876f739f27aae4121f0669545def4aafe.1741930961.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <39ff6a5876f739f27aae4121f0669545def4aafe.1741930961.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 14 Mar 2025 13:58:22 +0100
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

+ Marek,

Hi,

On 3/14/25 5:53 AM, tkuw584924@gmail.com wrote:
> spansion_sr_ready() needs to support parallel memories configuration,
> that reads status register value from each devices and combines the
> status bits, likewise read_sr() and read_fsr().

SNOR_F_HAS_PARALLEL describes 2 flashes that work in parallel mode. And
we hacked SPI NOR and used a single spi_nor object to handle both
flashes which is obviously wrong.

My 2c is that we shouldn't build on top of a crumbling foundation. Until
everything's moved on top of SPI NOR, I'd accept just fixes on this
subject, so no new support. Tom and Jagan to decide.

Cheers,
ta
