Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4435ACCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C04383A32;
	Wed,  5 Nov 2025 13:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SeMS+wg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B348B83A48; Wed,  5 Nov 2025 08:05:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A554E83A3D
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 08:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b72134a5125so298782066b.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762326350; x=1762931150;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0F7ea5mHo+cAM5BROiPim2S299jxi1HHVUtpoa3rS+g=;
 b=SeMS+wg0nWc/F3BPZD8tWDBTkuB1ceHQ7Hk8f3uCtnHi4kjY8itm1JMzKyPnoeMoV3
 ynIynWCwwb1vFPwkvZEba6zVCQIS+9iJWHwMkP6CTEIg6UGvHSg8xBcYeiXemAmDuM+s
 78FFJfxRFz4NOuaoRc3wsgbXkSgTXHMSWbf84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762326350; x=1762931150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0F7ea5mHo+cAM5BROiPim2S299jxi1HHVUtpoa3rS+g=;
 b=rubMPwgqKLc1DKcjYc+c/uAXFFoCtqLfd3PIbnrOzNy1Gtbgrcs8ecFuq5OEb/rEDl
 eKs8AsKF8IDtvcBY4wKdFKBOvX/OG3oxd1aSY8e/tHS3QKpCIFdrQKiVUIKPFgzd/cjt
 2P8zbKnh9k3sWoyT8uEDeAngGqReS6x+arQuGfuoIXEOEGmsQVl358uXmRaeXsziXZNX
 NnYGowmf5sqyGEFEPtxEMeNcBf60A2WkcB8zYAbegbfVYp0nhPnmuJpRMMGawQIBjc+a
 91ldssycV1SpQyHnUTei93cKOO3Z2x31lNbAwv1lYm/qxLYLHHBFazqbebrL7XJAG4GM
 TSRg==
X-Gm-Message-State: AOJu0YzlRm2POG+NCijnjUrndTDqCkPPgJUvu/lDZV5T4Ps9kKvKqx+l
 Oo+N+F5vYySTM7D1CREaQTswiaBiXUSK7xjET3ernyNdj2OkNxfPQ7H9HNi0UyI10VA=
X-Gm-Gg: ASbGncub1orcDji4T1eZ5q2p1ipyb/8QJVjRJcekAy0RrV6NO5oEiFjvf1Q8YXE09my
 AzyYMr3eH4mCIZ8UegNlNesKxRwqNpw1bGNiQ4VUiT/wPWMUTgQvXQIvKQAuRIVEOZtZHzgFO4e
 VvlKBC6o+olVWlY+yJigLfLJdH0zHm52e24oygT0KW6X8SM6j1ZAkNwhPkSTVp4Tc/yWCZimUl8
 wxYpXN1tlcsSWi0+cSAeV4h3xhxEaydSoScG4wc3GjleJwvo4o67Y8r62fInbNif3Gx4E0/eXG4
 jrYoXYg9yKz9t66hIhdXdfRj5c8ODM6sYX3lmljRCJdnWxDNlmckJMZbz30wlCjxV+hS9de1kdC
 aR5sUQa1Ifqca9UaxJvXOfLVALxO3IftYxFPbgIy6eWpbYr0IFDuDFcotbAJC/SYWE7iLSpA7yD
 vcaSG7tgpYDhHPrllQIS23XqF+pjRY27zkvfRAVO9vBAibjx9o2YSI3FixsiFzHg==
X-Google-Smtp-Source: AGHT+IGgUF1vo3sZjFSgnjiesd5rJIxSQdkMma3w5orWFKidUW9O19Fe67bps8RsLXVfH4nDQlgVxQ==
X-Received: by 2002:a17:906:6a14:b0:b5b:3ab0:a5b7 with SMTP id
 a640c23a62f3a-b726552ff4cmr173891166b.42.1762326349906; 
 Tue, 04 Nov 2025 23:05:49 -0800 (PST)
Received: from [192.168.1.54] (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7240540d7csm402927666b.71.2025.11.04.23.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 23:05:49 -0800 (PST)
Message-ID: <ef13fbda-8526-4d42-8d96-1db0ce4a46fe@amarulasolutions.com>
Date: Wed, 5 Nov 2025 08:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] bsh: update readme with instructions to build M2B
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
References: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
 <CAOMZO5AJoHXOD11hoVgKV9QjNvxwk_Ox+XN1-UPRYnCPzAA-=w@mail.gmail.com>
Content-Language: en-US, it-IT
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
In-Reply-To: <CAOMZO5AJoHXOD11hoVgKV9QjNvxwk_Ox+XN1-UPRYnCPzAA-=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Nov 2025 13:57:55 +0100
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

Hi,

thank you! Sure!

Il 04/11/25 19:03, Fabio Estevam ha scritto:
> On Fri, Oct 31, 2025 at 4:46 AM Andrea Calabrese
> <andrea.calabrese@amarulasolutions.com> wrote:
>> readme was missing instructions to build M2B. Now added.
>>
>> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
> I have applied patches 1 and 2.
>
> About patch 3: please rework as per the suggestion I sent earlier.
>
> Thanks

-- 
Andrea Calabrese
Embedded Software Developer
M. +39 339 394 4747
andrea.calabrese@amarulasolutions.com

__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9170
info@amarulasolutions.com
www.amarulasolutions.com

__________________________________
This message and any file transmitted with it may contain privileged or confidential information. In case you were not listed in the addressed recipient, please notify the sender immediately and delete the message.
Any other use of this email, including copying it and the disclosure of its content, is prohibited.

