Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA0FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 19:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67EBA84682;
	Tue, 28 Apr 2026 21:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Uyis97+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA7F84687; Tue, 28 Apr 2026 21:53:02 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935BC8466B
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 21:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-415e568a7ecso4549337fac.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777405979; x=1778010779;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AN5+Nc4ZOUaBcZA6boVYUMV4wmUM6XPWFOwD6rZ2y0M=;
 b=Uyis97+xV5zoJI6PzMeaHanq/6zQgJEdxdvWUf3gGQZHW2dRbpK051zZpEORNyxNBM
 ShNqUI4MNy4Q/bco2eAzquTcji7Qt8ZrIHepKqitlm0L2+phg+SAAYkKw7U1/92xv/EI
 Q4pj6lHSnd2JIniKCQTMabr2StLpAV14hmLSD5YUy+kNOFkXuBWmylEdqLSZQxQ0UTHd
 IDgwpvIMGU4ReaIW9ZnllMa/4EL4V87wojvoa05EtVN5Ry//1amWAYm5TqXMZKyeTFuD
 VtQevWdl8yPIUCnR9Jr1J6moorptJiyRcjTs837jDRTqo2Gpv7PjO4wtyskDaF4POaG5
 nQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777405979; x=1778010779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AN5+Nc4ZOUaBcZA6boVYUMV4wmUM6XPWFOwD6rZ2y0M=;
 b=fufyodHn17f7qlCS8MVor94uuTE519MX48O4EJZscztgeKz5wHAfLZCVzQYx+i+nP0
 i/Q3sOsFreCvxRhwkgoUT+Oabq6NtcId9mnjRvjBHttoMii0hKbfRpa1GqqSIi2OidPk
 4qa0EIkVAUexf0Ps3oiZhjFnMZUTgLnmmM9lZ4C8uDMtAVps6fdjphbYr88GrwTzb6sK
 nZZ4LqeelPfQKs25MqrslumXbt99b2pFu3hemvwztXOSKKRk2VfnNtxFotyfXQoax/G5
 BC7pL5EUvculw+5OkSqyrF95CGf4i5tmuo7GebiTGa8cvScIo9xCSjugva8MSmzLm/v+
 zvJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JJ/nWFGq8007nqOgLeJmjWCune013QRv4QpYB0r8IHFQGGBAMhI00SbWlO8CJwPljGZ21a/4=@lists.denx.de
X-Gm-Message-State: AOJu0YxB/6nqF0g297UxNuUqAROE1YLtkGUf6SOJ+fSk/w4oBniQaqfu
 0Cd6Jaz2UKLBL5xCQTG5N53FQ1s0yeKe9AKvQtG/3Ukq+wHOnxEkvypn28tM2mUimFU=
X-Gm-Gg: AeBDiety/NLpGCwed/VE2yeHkiSJJUcKobG+nmmOt4D3EzfXLvKlCBQkkqwCjpu6JUj
 RFe2cbGzfCTlid5R7hQDz30s2eF+1R7Fc8NBDCfBHlzqySTOoSNk7tiereTqxaHrroYQhD0pE/u
 v/mjQezg0ZrFQZaqnzgLDZbI52s0pDLaBDBEVdhLxoLPD4Nu/M+qqPVkuTcNjfrFQBDsAm0jstx
 uGeqMpY8DSqIDI2O6vag7/ktYjDIgpp03OhqrsBwjgv0VeQH7sVvdV0900LNF2x8uMBtcEuqvpt
 tZXkiOJsu9xZtC5ii/Q1pb60OE8/4CarmbwUPxWp1OmDAwA7zhKtHLAIf/HBYBXHpoIkjXpqHGr
 MWGYM01CQXO3ujrjqE3z7XHbpWfUpOBqkiOIGtynfAif2VhVMVH23ArYWDc/0Kgs7v7iq0SCAZA
 gthkFOK6Dh/WcQ3Vvj36OyJ3AQoAtE3sQkVoU2OL7mtUFIrXsxm8/M/4lnFXfHztfL7jQZCM4yN
 eWEzgip48g1
X-Received: by 2002:a05:6870:a101:b0:434:98c:d935 with SMTP id
 586e51a60fabf-434098d5682mr806739fac.2.1777405979289; 
 Tue, 28 Apr 2026 12:52:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e98d29asm84611fac.15.2026.04.28.12.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 12:52:58 -0700 (PDT)
Message-ID: <8c84d587-beaf-42c5-b08f-fcc6ad9dd09c@baylibre.com>
Date: Tue, 28 Apr 2026 14:52:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] pinctrl: add missed pinconf/pinctrl definitions
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-2-mikhail.kshevetskiy@iopsys.eu>
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

In the subject, I would say "more" instead of "missed".


On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> The code was taken from linux-7.0

The commit message should also explain why we need these changes
in U-Boot.

And in this case an explanation of why you chose the locations
for the code would be helpful.

Since the code is taken from Linux, it is odd that some goes in
a U-Boot dm/ header while the other goes in a linux/ header.

The patch itself seems OK to me, but I wouldn't mind hearing from
someone who has been working on U-Boot more than me to say what best
practices are on copying code from Linux.
