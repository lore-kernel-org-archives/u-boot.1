Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E040AD58D41
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A0789A42;
	Mon, 25 Nov 2024 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ADRl+QjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F95A89642; Mon, 25 Nov 2024 08:50:25 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E2888E77
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38248b810ffso3113038f8f.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 23:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732521022; x=1733125822; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/xcFvqAqh4DauH9ahYD6W+2UiQwO7gKvcpyemPWcyM=;
 b=ADRl+QjKE+lF0skas6tKNnpSbOu7gMs+lbUy7+bB71DIXHbNMyjZjZbxeKnAMsmolZ
 TJiKM0ekb/epuakyYDHGYrZeDYVCRKcERFpMtk2Uyq6WFpY1aKVxubhdbyNgRwMOfAE3
 jTNz15mp9GyaWWNHDo0FZDRCL/sSNN9lLhCwshisB9hn4BYMG33QSZxl1eZtK7u7RJJ/
 9re2trM7Vfun959AZQV2rWG6ZS7s78sL5h39kO2854ARPuISuTz6Rzft3SEurjR9jGNh
 dOc5PNU0WTZy8SP248Uc6IFQ/OgC2opmTuFMNkBbr/9OHC9oNzZ2zxOMZCTPBF32C6lh
 BGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521022; x=1733125822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/xcFvqAqh4DauH9ahYD6W+2UiQwO7gKvcpyemPWcyM=;
 b=r0O8kdMRUUBu/ye0bOWnIKtyG5V3YTcX0GfYdq2PHVJK9H4Jn8hGKVEMTxVhb5cG1e
 IAus3A/5t8fEX0lsEeud7BH9ElKbern/e9BwdyJrDZ7WgwDk/vAA88JYvUlihhVnEsiN
 PoMO6lzc69ORPzvQAucU4gYXHB2aifR0Urkn7vIrlf9qnhgaQnrqzyYeiVj8ByDGQc4f
 334i4G6YX5trkPiNYy9PBfcBB/KCZ8o/zK0GbFiXiSIzxq7h7nsa7VEyBJ7ffdFtw8yc
 EVJaSHCbfUEWNuJlIRWfduPzNxJgcoryvAdWQ664xMGTckOeGju+O3tGhiu4JQZyWeXT
 FzCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHjSHTUhn4RZUePfQGzWNbSQd5bm/nLT35mS2sEfBGh6ohXfH93uqZKzel7y8eJphGxsrCdkM=@lists.denx.de
X-Gm-Message-State: AOJu0YwEZvn9yP9Yu9ZpxM4xVXvq/+AB2tA7/YEyCxaYQUqHuZXYm17d
 ukhUD0elq+AVlH3gaxHA4MjyiGF7ruPyuP8lCx2CMVqSGm3PN5vsek5C+I49e9I=
X-Gm-Gg: ASbGncuJoHoOWg/Aq9LbSWj84Tujym06IZUUAphXwgyt+C/FhYOn0h4LkSLH8OAKx/8
 Nle1uFrtzubdgw7eSVJ8fGTYuGU0qF/4AecqqPxVOqaN+exFOPZ+AsP4MINcOfwOwCAtUddMO8+
 iqxaeN5GsxZJtQZGMFDjYDObYhYp9Y+kPIA2s1yOoWYMZg68QgmEr0gufQQndFIJUMdQNnHjG2h
 YgqFxezILQ6PpP5V+9v+2bbHoaEo0D1ObIBPZCfqeNd1I1pgdQFoCUksw==
X-Google-Smtp-Source: AGHT+IFT1E4/RhfnHwT2utQR91SAzQlhyK670YFbX2LQT7yv46NBV3MMgjA44x9P4KU/DuyAQbIiHQ==
X-Received: by 2002:a05:6000:178b:b0:382:4b2f:f755 with SMTP id
 ffacd0b85a97d-38260be3c7dmr9853135f8f.54.1732521022499; 
 Sun, 24 Nov 2024 23:50:22 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9f59sm9575599f8f.34.2024.11.24.23.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 23:50:22 -0800 (PST)
Message-ID: <76a95870-e767-4145-b03c-fb8a1ca5ac6f@linaro.org>
Date: Mon, 25 Nov 2024 07:50:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix flash part
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com, marek.vasut@mailbox.org
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Dragan Simic <dsimic@manjaro.org>
References: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Nov 2024 14:06:45 +0100
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

+ Marek

Hi, Marek!

On 11/22/24 9:47 AM, Venkatesh Yadav Abbarapu wrote:
> with initial testing conducted on the
> Tenzing-se1 board using STR mode for basic erase, write,
> and readback operations.

Would you please advise us what are the minimum testing requirements for
a flash addition/update to be accepted upstream?

In linux we added a guide on how to propose new flash additions and what
tests one shall do: https://docs.kernel.org/driver-api/mtd/spi-nor.html

The idea was to be sure that the flash works since day one and to have
enough data in case flash collisions appear so that we decide how to
handle the conflicts. u-boot can benefit of this too.

Thanks!
ta
