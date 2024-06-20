Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5058AC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEEDF8813A;
	Thu, 20 Jun 2024 19:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c0Q3ROaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F948834D; Thu, 20 Jun 2024 19:03:31 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C0C87C7E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d07673185so1049519a12.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718903009; x=1719507809; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8JGxkr/six9t3qc7f2ESqOisF9oE4Cst3xwl8CVGmGc=;
 b=c0Q3ROaOaCwyPVDjabMwO4XQRBtJQwDiSe2m30cLc7aBpqBovc6mmZxCguOF8I1Z7r
 0lBT8aHSELfVviBOJjKk/8oFAceTlogy7L547TTByv7lglCz0/qX4WPf6NVHNwfQ+hKq
 uTpyJMVdlEaF3lfsxJIjth81h7ndbhXLkbTMNmaTaboez5PH4azpopU7Be5JmWZ3mh3g
 k2BDXKPyy/eNNY6WnZIzsQ4IFZQJKogfDG0kdhbyc8eagbI8Q3KEVscS9TFUWhaFOHL7
 IcUB+ykfsENZNjQgNlLAVW8/zcAF3BIkx1u2DuC3A19GKn1BkuiHwt5DT9F74sDmzKMc
 Rkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903009; x=1719507809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JGxkr/six9t3qc7f2ESqOisF9oE4Cst3xwl8CVGmGc=;
 b=ptG0MohCE2jN2mD+mhZCwm+Nzlh74zf2f+J+oyfBRoPWrTjWovc3qkH9g961zJQ1vp
 /59rfEVAVKxsU4TCmHWrq93E2pI9Fy4J7khHIECd1qQ4oBUblqY88I2B6dIzjGmEGtfa
 VxyQxOgI/9gcwE8xX8cl73A0DCQ0Bnoq3y2hgvwCk98HM1iPGhhx8m6x++Mg8nErL4zQ
 TXxCZGQpPO5u0V54ipH7PV5boO6BF5UA1prMDrFVC6CU/A8HAeaxqMWbw+akjYy2tr26
 yrYAAKC+IUl5d2uJIO3vpf/g+yU1auc7o+5vKX4XbOnANSBuKae45xkt71+W6fJKzQf0
 relA==
X-Gm-Message-State: AOJu0YzoM+dAzaCtkqxxXWci/hHbjIr/i+Z8E6Y+yPVb5Jcz1bGZfMKg
 wKlcMdF0+un+6x5w8R+Ug7zJm6SjU9IxcZNEiD4pnrR3zEoFAjI=
X-Google-Smtp-Source: AGHT+IHE6ozhhgaDBXMvOK1d19EP+xQbujHBOOqMrsAtqKpclnjlyKRXp/NXBZzgoTj4aO08Reoeqg==
X-Received: by 2002:a50:d494:0:b0:57d:788:aaa3 with SMTP id
 4fb4d7f45d1cf-57d272db7c8mr807161a12.8.1718903008319; 
 Thu, 20 Jun 2024 10:03:28 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:67df:1240:90e2:3b31?
 ([2a02:810b:f40:4600:67df:1240:90e2:3b31])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743907bsm9922568a12.87.2024.06.20.10.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:03:28 -0700 (PDT)
Message-ID: <09a91cfd-080a-4c39-8887-c36b42fc8ba2@gmail.com>
Date: Thu, 20 Jun 2024 19:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
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

Am 20.06.24 um 12:24 schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> No meaningful changes were made to this SoM since February 2021. Nobody
> from Theobroma has booted anything recent on that product since July
> 2021 at the latest. The product isn't available to buy anymore and
> disappeared from our website.
> 
> This product is therefore unmaintained and it would be disingenuous to
> say the opposite, so drop support for RK3368 Lion.
> 
> If you're a user of Lion, feel free to revert this patch or contact our
> sales/support department.
That's a pretty interesting support-strategy. While I really don't care for
this board, please don't go ahead and remove the whole TPL-/SPL-part for
RK3368 in yet another pointless "cleanup"  only because lion was one the of
last/only user. Even if EOL RK3368 is getting finally interesting in
regards of display pipeline as we are finally getting a OSS gpu driver [0].
I'm planning to add a board which uses TPL/SPL soonish (when my rare spare
time allows).

Alex

[0] https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/issues/1

