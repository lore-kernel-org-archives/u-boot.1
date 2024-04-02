Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA791CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400F988390;
	Tue,  2 Apr 2024 16:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hFqPCA8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B00D8838F; Tue,  2 Apr 2024 16:47:21 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D798646E
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B69C93FB77
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712069238;
 bh=bUYUi/7t+03fR1s1JDCd+czbeCNTFmxpiNnimeyhic8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hFqPCA8l0DEE3JsMe4ZUd3pOElF5GUryEjblSt6TFj9fLQy5qQaGcrc6HxRNndPVa
 6oqqEQwcqXQu4WYmxVdwaHqetNL/sEvzMGKlACV+yLIhoplT6KscxaXHzaSHTrfIRT
 70PHkadZX32xlNRX80nLCwXvwEC1svyLNKHzBH3ZUZpmjTTupUujA8VjnhrDx73dZn
 kmJVBNKD1PFF+6grlSIwogyKQ+0rU7OCTb43+mXLZlCjL5yV79SPlwv5uG1Fv7hD9L
 7XJIBSEB4CkqxBs4a8gnuLtl7x82fZlhrM5N3rvBT08saMMu6K8B9flqi3KKHyBKyn
 3vaCHBHcSpqJg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ec308655eso1475794f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712069238; x=1712674038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUYUi/7t+03fR1s1JDCd+czbeCNTFmxpiNnimeyhic8=;
 b=l9gZw5tsORMlW0mbTSxf/1XnBnVXnr+5+LpE/nhZcKxmrppj1EQz9OSCzRFd6dhq3z
 0v+UzgJR2/cn07qv8Un0Uo6ubzCgAJfSQ2z/DO040IyECiV7QPIzMZzIB/FJPlqd/56t
 IECF/zKX2tyS2eeyQeY659uaPDd9NgIfw2Swyym9EIatwT5ofvQ68NfNJlq+DuZUe/PR
 7LV2EsMZ7vxvjhoaNbKBvyX3s45GH02Kqdn/1/uvDksfCf8yiRHx5OObOEZI+hvsZhvC
 fn2fJUUWceGQ+6+JoiBxz1Ed9jvUfOVU0REgd1p96/0631g6+6eQFp6tDF3v3F7RukPR
 /98w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkMFQlV3RiNDkfaVqKkl8on7sJFG24TyejO5CaU5ilpHcRNDdiakuXt8yct2uOjNXH9UI8so/IrPFjGi1Obeje3o3jtg==
X-Gm-Message-State: AOJu0YwtvYJWIhGgDrBw6KESyKxijcbqiNhcTPdurlE2xV0fttYnq/1P
 7ouNCUHSmtsv5EaapAGgKGKf93/e6/ehZT17l1XDBkUqwaIGErdLneYdIypDnxO7Bby0m35kwst
 /dJnW1O8r5pkQNedu9xwVtaVIlLNy3XVy1bXowwDhwlI/3mUgk2Ns3r20OmQU8+O6V2c=
X-Received: by 2002:a05:6000:12c4:b0:343:7654:3e98 with SMTP id
 l4-20020a05600012c400b0034376543e98mr916303wrx.43.1712069238205; 
 Tue, 02 Apr 2024 07:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtY7o0oZcAJl5hF7l9MYROieI0uid3x/GuEiQI5mSPWJo0Qfuy4pDzkCwwiEHorc3AH+HUcw==
X-Received: by 2002:a05:6000:12c4:b0:343:7654:3e98 with SMTP id
 l4-20020a05600012c400b0034376543e98mr916289wrx.43.1712069237859; 
 Tue, 02 Apr 2024 07:47:17 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 w8-20020adfee48000000b0033e95bf4796sm14296654wro.27.2024.04.02.07.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 07:47:17 -0700 (PDT)
Message-ID: <4c80330c-e12a-4652-89c2-857d572d6a7b@canonical.com>
Date: Tue, 2 Apr 2024 16:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Stefan Roese
 <sr@denx.de>, u-boot@lists.denx.de
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240330175948.80931-2-bigunclemax@gmail.com>
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

On 30.03.24 18:59, Maksim Kiselev wrote:
> Add support for DesignWare SDHCI host controller on Alibaba TH1520 SoC
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Thank you for driving the TH1520 support forward.

Locally I updated the Lichee Pi4A device-tree based on the Linux 
device-tree and built th1520_lpi4a_defconfig with

CONFIG_CMD_MMC=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_SNPS=y

I tested reading from eMMC and SD-card as well as writing to SD-card and 
found no problems.

Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
