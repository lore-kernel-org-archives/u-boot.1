Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCCDE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E98804B6;
	Tue, 31 Dec 2024 19:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668812;
	bh=VW2bLYvOgerFD4Ub4BH3o8ldf9bIMwghA2vMRoWOSHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdtjTUnsdGhJdWssmTgR62d2obUy2ENk5hfhi7tlV9e7m8EliCBHtwZEWrfzqly2X
	 MdWDg7BWlBiXL44e7RKUSrf95mfEh0YGqbpevUd3YvhsrWjeoOIF6uBgvLWZaIQ+XG
	 eq6LJlBbWDn5TmTZ1/Pr2Bhs7LGDtqBsa/VGqLgOPIXfJChqRMMSjJzLBnPtM5y7O8
	 TyyYk5iVQjjkA8c8LYxSIKUbvgFWRv5oLm+D2wXxXet793kN8KklmGm56AvUIKbX02
	 TYevB3RWwxx1ywE410Fh9qGmbUZ1u5h2GMiuiWariy8LoC890qltvSi58U5PvTyayS
	 3oICVzX2oo5eQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE9FE8058A; Tue, 31 Dec 2024 19:13:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4337801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Jz7T9jJw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0729710486D91; Tue, 31 Dec 2024 19:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VW2bLYvOgerFD4Ub4BH3o8ldf9bIMwghA2vMRoWOSHQ=;
 b=Jz7T9jJw2yzH+LhHtekV5u3lP+jQmYAlXUEC2H3YFCCojBK6uOUrNgPpk+3vvf1AXTa+e9
 +ouuHZTRW10JSc+lbj35Dz6ir/FKwPUa3rqPZ9LhF2RJ2dWDGkCfmk+f8gC4ym3x4QkJZn
 0/wbRxuMgg7uS5mVGWxa9uIIVZaoYLlGNgHAEsFcXKtXZewPuD1tDHvl2uV0TuXgkj2b4W
 QoKvWykBNxnJW57Em+esqXcfd+PpLasKoQkx5tfmfqmIAO1gueXad3QjLV7hh9fjlM53j8
 vNeDKWR/38lriknuo5nZF4ctHEZZdEjysrXYR1jaR/xbuX3gxDUf9uwkf/GkMA==
Message-ID: <5f6d5906-607e-47e9-ac0a-3d2f9bbd38dc@denx.de>
Date: Tue, 31 Dec 2024 19:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] usb: dwc2: Extract macro definitions to common
 header
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-6-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-6-12cd9b8a2358@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Some macros are shared between host and gadget code, causing duplicated
> definitions. Move DWC2 macro definitions from host and gadget code into a
> common header to reduce duplication.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
