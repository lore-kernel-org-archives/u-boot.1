Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8416CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D5A83FB0;
	Thu, 14 May 2026 15:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WkworYrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D54984676; Thu, 14 May 2026 15:17:33 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1022783AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 15:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso6267056fac.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778764650; x=1779369450;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9yA9DmsorYNMNj9qJAXn2JIUGyHYr6xb3gpA/1nqRI=;
 b=WkworYrk8K9JkBYXp1BHtIHMfYhBk07ZvoGWsoKeCI+dPgOYCNjqjIUqaMMD3EW6x8
 yBYnk3HQKaY30hwXHcTtEMlsLorihrAvOm7EZwd88qfB0yuY/OfaWjzNiWwN2BKLYZZu
 17ydXErG5ldhwFcCj6Ktqo0Op3wqs9WqtSL+BI6j8di7oM4mpmEfOisMkomO9GdXNXAP
 hvk/0ZVaq1ju5ItndtQc/+0Pz2TCxE4MJ+OPlmsJg5aMEm0klpG2Z84lmWtapps6E9W5
 5xwTeUvuN3C5oF+ypkMU7ZyhZ9feJj7tG/z+R4UJ+tEfpeTd69llYqyaSgEd6rg7LKm9
 SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778764650; x=1779369450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9yA9DmsorYNMNj9qJAXn2JIUGyHYr6xb3gpA/1nqRI=;
 b=AjLLfpr+BQrM8Q85lzVyqPFFJ25FiP+Mtm7Tk47PJa4UEZHOShoko8t3n1SDjZG1Si
 pOOTyUbd7ilqaTYUbntp9sE4qtSyDlxKlAthPrf1YL9l9c3/wN2dZKEImpYDE+Oz3H3U
 /tSCn+0kg/vScOdHIayqU6gkAh6LFG41Z9MgRBFhVdSllYM2TUP5d2t/RjOdl21YBMrC
 fzGN5iQSKtk0UX059IB7wknO9Ua8IPHmcUlJnX6ewzCQQf/bZ41K/Q5jc84FGAeIFm2C
 rw1fgdlkacQ53bTTW5Hq8YlcAPPjsORJWhUy0iiesPwE96fw04MpWJnnUoVpBicVLUM2
 8Zrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ca9TCbaB5PG3ggUwMeDdnnFcgxSAPhQOMpthe0uHBIt8B8XMxd9gv39JzwCVINN+LvKOFIB0=@lists.denx.de
X-Gm-Message-State: AOJu0YyBfAiVpIG4QePkKgDU7YHcQk0PVZwXzi/k77FbsNK/emuhFEYM
 zb52gUMUFgy6bfZFsxVmrphTzul1elIifUYX4xh6EVq1pPcU9K47JC+bF5Ipav9jAog=
X-Gm-Gg: Acq92OFU6buIhKNwtoDzeb1iIOjqYTslFt6QbmXb8rufr+jiuzMhkqLO0VnYbXCvU9i
 0i+Xaq0caQ17dkGA2lCxzb34JayoTq0h9s8qhq7ofZWMlmJo6k0r/E+Kq7rfISM+re+7jI2MBPf
 TVP/ky3DrumIOsK2S2b4+UpogIUEMCWQYayidV26Ykk2ze4/NNLXujMlBttEAZi/byjNW1p4PIs
 nLToM/ky8p00d7/GeCyH7rwWPgO0EYgmc6hoBXM1QiePt5+rDgD1lb4YboAX3E/rtB5jmtPuiKe
 FYZ6doNARbeXj7fHMeP6n4xg1bdpoLe0F+kBaMJsVQcOs7MSvKMKXYODFrHnCPsrfJAEk9TIscf
 pBYuHq8StHAkvJC4J3RJrWG8poXGMzO2r+Zu0OfNihVNiINiDdw1/7V8oWuWzfSi4snGQWx/OkK
 YKXovXMWlYQr6lzF3FWs4SwIad887+6KeXS+BaWxiT8OF3sqW3fXBP1WZi8edL5KIIvi738kdgS
 w==
X-Received: by 2002:a05:6871:7516:b0:42d:c200:420c with SMTP id
 586e51a60fabf-439d2f5c7e4mr3898503fac.23.1778764649560; 
 Thu, 14 May 2026 06:17:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:649d:d320:df1b:143d?
 ([2600:8803:e7e4:500:649d:d320:df1b:143d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc4dcb89sm1909924fac.12.2026.05.14.06.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 06:17:29 -0700 (PDT)
Message-ID: <6b8790b4-6180-4f10-8857-c2714cd2fdd4@baylibre.com>
Date: Thu, 14 May 2026 08:17:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
To: Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
 <DII5FZA8ENCM.3KT0XC9C90X2D@ti.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DII5FZA8ENCM.3KT0XC9C90X2D@ti.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/14/26 12:27 AM, Anshul Dalal wrote:
> On Wed May 13, 2026 at 7:41 PM IST, David Lechner wrote:
>> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
>> not support modules, so tristate does not make sense here.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Thanks for the fix David, I see the same issue is repeated at other
> places outside of PHY:
> 
> 	% find . -name Kconfig | xargs -I {} grep -HPn '^\ttristate' {} | wc -l
> 	47
> 
> Let me know if you would be interested in doing a treewide cleanup
> otherwise I can take this up.
> 
I just did a few subsystems to start with to see what kind
of reaction it got. Feel free to pick this up. And I will
consider doing the rest later.
