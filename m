Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862C7CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D94383710;
	Thu, 30 Oct 2025 14:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kCbbt2su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A56838CC; Thu, 30 Oct 2025 07:49:55 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77178835FE
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47114a40161so7291055e9.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761806993; x=1762411793; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrlvILngcCqRzl87RwiXot2TlVaf2q00sAjuZb/A9o0=;
 b=kCbbt2suHUjNgVjlC2tLiH7g+2iZXEALcPWY3SO6Ftyl36vUgfOIaMrtWKPsysEjo8
 1inM63vbHEFZK00awJGg87jzaYESchCKxkHXpqinyZzwkk9gm4mPrQUQCj4rVGZQlCr7
 HEwuloa+B8lqRi95rd9grWaxevymsJ9LiisY3hMLzQQ3muV6L9daxVXLBGUfw/KbJ0Kf
 qexi6xCCPdqHRwJfczVnRkgzWXlAV8Ec2Oink+gbxISbsj48OxZoV+56NqjcPl/rq8l3
 wQQkjOA8E+Dl7TooB5VUzSZpuIB9C+IYMN6n2HcTeoF3KI3loKtOhWHc7R4AUCcpv0FL
 B9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761806993; x=1762411793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrlvILngcCqRzl87RwiXot2TlVaf2q00sAjuZb/A9o0=;
 b=C/LXYkGQt7V1cpPIMmzoE/SA9np1gIGXZZ6g2+i0brvc80CRZq269VkYZvrbKBD14x
 EWrILhlq8Chwen9b851IfeW6WH0fCeAq+6IKtpw3Tg6uu73fJtPdOr4CgrhoBz+d8ShE
 co4cR2+XDRuEgI9sbJ0cFCPkGLVUfpVJXjKo+Ri7AKr8jZg+UJphjcEhebPlF1yA2mw/
 f8Uzw8iK0fCbFlXXL7WsxhHAko8icmvHmO5yaZ3ndTz9Tqai3dcJ7Ici8xnfv/LA/nUw
 g3uXMhnWFJL3v+Nq4YGNl/Q6YQ8UQTlFPAcvijtfVHbd0YPLwOOXKimkIGrhRkU8x3Y/
 1VDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0D6Qwgmvj5Z41oB89taf5eGZlnq+Mds4t+YkyAfb58rlOBqswEkQXtnnwr5jC5oYRzSQP+K4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/u9Fza8Augo7I8GDSQT85/4J/bXEK6oJeedxGnvVXQSdiKpBe
 HiAFYC7TS/hUBwksPYwgoB51glnyqMyKWv2MgymdaNQKDUm9bhfnmI4gJik8OO5ZHbs=
X-Gm-Gg: ASbGnctJFdceHzs6SYK2liIlP40fQMNs4RfYjyVtBpnLUT98sUmO1vYKa7E4W7nxNj2
 hQSxaBOFYB3JJYfoE7RJ8MBdLQN0ZE4QvxH4ZTAyfZfAPqmpoT113V/hGtn5UQu0o7Cq3mUm0UM
 I+f22V3dw9gr6U7+Nc5wdcwu8kaNNO1dijhzm+MMJqTS7K9nyUkToB7PmxeWEZtmcCMhsZwh9NQ
 ir/4/nanRGzhK2K9pC2tKb6Xi7RcqwBX/mOJoUYedfRRjMwJ8Jbl1luf7wKRvHheCQ3CXJ72ibf
 yY/UiDIzPmf+xRbKtZ86/hI9cduokk4u5ODgtMhUS0uLaQQCB1o16xnF5+J08QDgYffhx0Jt2XO
 8rtA2BINvUpeBrtd1LUqkyIqmdAgfL5HBbthL75eAkNNJ2smcj+4pOohiOLG6SDjS7UXZMdhqt8
 Qk/itcJkRDxA==
X-Google-Smtp-Source: AGHT+IEDsNNVckQ55yFskT9Jr9B+opgiIKKNMT2qYXUIlLJxME8UIIxdIe26bTGDlLPlvuMDHRL7kw==
X-Received: by 2002:a05:600c:4689:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-4771e3aaf0bmr54052765e9.25.1761806992917; 
 Wed, 29 Oct 2025 23:49:52 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d4494sm30762350f8f.21.2025.10.29.23.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 23:49:52 -0700 (PDT)
Message-ID: <12aa89f5-c130-44c5-ba22-6abd6c1dc45d@linaro.org>
Date: Thu, 30 Oct 2025 08:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: vlim@gigadevice.com, Jagan Teki <jagan@amarulasolutions.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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



On 10/28/25 2:46 AM, Marek Vasut wrote:
> The SPI NOR ID table indent is inconsistent. Reformat the table such
> that the first line is always IDs, optional second line flags if they
> do not fit on one line. Make the table consistent, no functional change.
> 
If you spent time in updating all the IDs, then the current state
definitely annoyed you. I'm okay with the change. I think we shall focus
more in reaching the format linux has, and to split the IDs per vendors
files. I wouldn't touch the format too often because we'll have an extra
level of history with each touch and we'll be buried when using git blame
to find who introduced what.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
