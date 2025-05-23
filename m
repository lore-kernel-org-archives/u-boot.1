Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99FCC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 22:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325AC83340;
	Sat, 24 May 2025 00:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ETgvgNOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F23833D3; Sat, 24 May 2025 00:26:17 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D076B83264
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f9832f798aso263705b6e.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748039173; x=1748643973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BY/yqNREpLvY264+S7M2w+9Rmu46mn6cq1ynaos1Gs=;
 b=ETgvgNOJHMkFWc0UAhaEBTBZOPoopt0sYJ4ij8kyBa0yxM/4McoWxMkphbQf83wYFP
 LX4JKRZWlgaUH5Xxcsc77FzG1Xuyvekl2ZN/J4Mi095bmlQt1KcRB9YhFj55J/RZmlnl
 fzR6alcYlBfQsZKiJ+WxlPK7NUV2ubTM0Zns4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748039173; x=1748643973;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BY/yqNREpLvY264+S7M2w+9Rmu46mn6cq1ynaos1Gs=;
 b=EzI+j4eZJNwXMyfyfbG/qJ8w8Q9suVjH7YLUbLFxXbsJ6CnzJvXU4eRnf6hYJxFAWl
 Kzhvv32HX/q4yis4INhtoQVKbtsj3GEJjqsbmzVbKWUoGDV0YWuC+8NbSELw3x/PY57y
 kXShmbFYWssXRCe4TGWwRL48zhiiLzZ03wdEWo4t2ozsriPBUy4TZeg1WyGyDL3ZtsU+
 GR99HUZKwBK0yrEmmt1CjjogMXmUk07uOQi7hu6ayj9OQSUE172DdBvusFpD/pWaZZpV
 AoxkD2juqYviUbNYqo4VtXLqK5VP+XAzcclQuCRxOiYuApnJDxv3R4Toq16gj7WrAYoj
 bzyQ==
X-Gm-Message-State: AOJu0Yz48TkeoTJ2kp4wGkUDPmqoaw8dgNXnNwsTTBNxiktZpDo30IES
 2kDDMKH33ZnqVEFpBwwDBQHIzINuK0hQdBMiFu7iDnNQinBrwTMbxxQDyoyTlEEKpy0=
X-Gm-Gg: ASbGncs/Yq1zHx54N8AASRX9xBJyZECYOhBjx2QeJs+/Y9Jmeu3H8evdeM2gQhgxsfZ
 DKnGHtZLUxtkFv1GTx8hD2GAaYVt0GybbC/kmhyNYgQPk94U4CSR54FryH7MRO4+WCqE4F6AuJ6
 uP7vKMs5QzqtqkZQjoj1TAy4l/3vxEQcffaTx4CW01VjhROIZYjb/TXwzArquXti20VNuYyxkGh
 5c3N4/QN/ksvEqwtwAXSXJHfLb9gKLrg2luRSTgvFXuzBInqN6OSSGaoVRvoMFdldMiJI+po8qc
 6ZO57s9QB9f/4QqrBbKn7f5rTXYFDku546yTSL74vwpR3IoQcNavk850JiHrOjAZKF9ZGzSRnMO
 ktfR52DQDE8s=
X-Google-Smtp-Source: AGHT+IE+ghMXeGZv9mK3NKUl4uOsOhHt+GINsoOfDxk+t8gIcakB6F6rvBYET5hiFEdLcqMr1zpqcw==
X-Received: by 2002:a05:6808:229e:b0:404:764:fa10 with SMTP id
 5614622812f47-406467e3a21mr489417b6e.10.1748039173567; 
 Fri, 23 May 2025 15:26:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4064522312bsm194029b6e.34.2025.05.23.15.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:26:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Edmond <seanedmond@microsoft.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Charles Hardin <ckhardin@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20240509023918.2504185-1-seanedmond@microsoft.com>
References: <20240509023918.2504185-1-seanedmond@microsoft.com>
Subject: Re: [PATCH v8 0/3] BOOTP/DHCPv4 enhancements
Message-Id: <174803917198.2369538.18387605008838632819.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 16:26:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 08 May 2024 19:39:00 -0700, Sean Edmond wrote:

> In our datacenter application, a single DHCP server is servicing 36000+ clients.
> Improvements are required to the DHCPv4 retransmission behavior to align with
> RFC and ensure less pressure is exerted on the server:
> - retransmission backoff interval maximum is configurable
>   (environment variable bootpretransmitperiodmax)
> - initial retransmission backoff interval is configurable
>   (environment variable bootpretransmitperiodinit)
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>   (not recreated on each retry)
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] net: Enhancements for dhcp option 209
      commit: c867045eef153b0beab69fbc74059fcfc4ad9472
[2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
      commit: e6bca3305bbc333cc71e5bf1ee483bbacfa84736
[3/3] net: bootp: add config option BOOTP_RANDOM_XID
      commit: 2111bd7e93a3044f0590c942a41f2667d15d923d
-- 
Tom


