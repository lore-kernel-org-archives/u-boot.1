Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7277FD6CFA3
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA5483AC5;
	Thu, 22 Jan 2026 20:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rdNkMNOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E52283A6A; Thu, 22 Jan 2026 19:16:49 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A8480077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 19:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-459fa8b6044so774676b6e.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769105803; x=1769710603;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ti8XnMX3yLkamzvycVYVUBgqbZuODOaUHLJvU6L9UTM=;
 b=rdNkMNOYLazQqQtoSrEANzadi3TbJHT5h9Z25ZHTTjjy9C0jA8/OmPG6dAjXMCqFN1
 zVBjkYkZjxrjbdUWU1Z+trqIFikbR21L1U4oSxgOAiE27ypAMQorVQiJ1D4PZk8qM9OP
 3P2oaHp/yj2S29OSBa9FRbUSpcyOizU593Br6WWH1x0Z45vyXl/oocVtqnOUYKVrMxV4
 rzV5+W8MofPQsp5WZd8NqDdjCDW9Gr8xRuMuni6eezKwFtkB7jvrCmjxl2Deue1YOk9z
 HmZtOIPyjuHTueV1XdlswccUEf53UYsHESc4qHdlyRHHiuM0GhriJSLhxj5dY4QKIw5X
 EuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769105803; x=1769710603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ti8XnMX3yLkamzvycVYVUBgqbZuODOaUHLJvU6L9UTM=;
 b=QtJLKDHjSB79rQLCXn2ynhE/N4SdslPJnMZTzrK1HBapKIW2odbPM5V34uXcKpUO1M
 b02z4pfJd27xz4hZDeM/ZnQ90U6CPXstXWXwCM5CW0skD7V9QKBmzYh/g6q7XowNp8gJ
 TGZX9HGNazbtSHX3hDCQT8DkuUaG6hN0B7ZOsdEC3TV7xRPCCiaty9Br9q7NyyUvnAJc
 +9FD0ZP+13V/09S0CZFwpcukp6Ko3eDBlQJ+WX4+/cZMUk+FzwxR1HAc00KYc2msGSZb
 qmYcNWQhJHmsVZ5MzH8fNdMkZO7fgorouF70EJln5e0iZDtdcQrCsA/6YZ1u4O5b5r8/
 SNkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwytTveTBd7x/3F4osothWSJoOqMYWmZYEFxx6vNwJs6yk5OcqBDhdZM31lxzQrrb6EEUnRV8=@lists.denx.de
X-Gm-Message-State: AOJu0YzTywUTofral/pezEhlPrO+pIfTIkRfE5TVFklpwkToPl/QkZsm
 2zQDnF0qqnyGFeG5YDEna+HboB3zahrl50/LEg6eoC5LW60z5qV+6jAM56tZjCeIiJ8=
X-Gm-Gg: AZuq6aJaX20FiH7FEwqmYrj7AGhtLgVxVw73sAZ3047EmfiwKp5gc0u8nrWWY60iLc9
 V5THz+oEDXtgTOMBjXoulzBA9ce+v8106YvpCl9CHV03VRH2TCDyKJahDgHks+qmbA6raoqSuqM
 sm6zN+9S6isthShNE3bmRxEZU2Db0Aye/CURlKJwrtB2YvvM+7lfoA5CcCxuNIQgmtCogvXiDJ3
 t6tuVeio4XJolsFurB6neiJO/BrCsCDVzJH0U1soda2bLyHx9uzAROmB/R3PjwNsnyBN/g7bW0g
 WXxO5JsJ7tk78T6d14XCCi/YtYHeCn2NQzvfzVxI1QzExUGCL/pI9qTY1+rxQ1rZlkNBAotmY2P
 /JlwnueJmhcv50+G+QZ9wP9iGB5HF16ojcPlfZuo36/KCOTl4w7Pe0oQj1iMviBIaSeXXGdpgg6
 jC98ovogDrygnnhed6UYNYPTsQBep7t55FEKgdWV6LtSIxTVwA6UNMz58jew==
X-Received: by 2002:a05:6808:2384:b0:45e:af00:2de7 with SMTP id
 5614622812f47-45eb1b486f3mr293078b6e.28.1769105802936; 
 Thu, 22 Jan 2026 10:16:42 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:a885:b1e2:e67:4098?
 ([2600:8803:e7e4:500:a885:b1e2:e67:4098])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dffa9f4sm10870866b6e.10.2026.01.22.10.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 10:16:42 -0800 (PST)
Message-ID: <4497c9ea-9915-48ff-a907-be6800579437@baylibre.com>
Date: Thu, 22 Jan 2026 12:16:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: mediatek: add pinmux_property_set ops
 support
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, "Jill.Wu"
 <shu-yun.wu@mediatek.com>
References: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
 <20260122-add-mt8188-pinctrl-support-v2-2-324b4c8f2b64@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260122-add-mt8188-pinctrl-support-v2-2-324b4c8f2b64@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Jan 2026 20:34:05 +0100
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

On 1/22/26 10:38 AM, Julien Stephan wrote:
> From: Vitor Sato Eschholz <vsatoes@baylibre.com>
> 
> Add pinmux_property_set ops for mediatek pinctrl framework
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
Tested-by: David Lechner <dlechner@baylibre.com>

Tested on mt8365_evk. 
