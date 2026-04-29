Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3808FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 18:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB0D848BB;
	Wed, 29 Apr 2026 20:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QxYrP3V4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8E4848BD; Wed, 29 Apr 2026 20:02:19 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96831848B7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 20:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd89701acso76131a34.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777485735; x=1778090535;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9L5PKnF8A6WpJrZmtMbg1QxIVqDtIGUsYnJ+GYfqmKk=;
 b=QxYrP3V4Lb8J9dp1fO2TG/FnMsGFJlNdfcSJDDdWkN6b6laN4BJ8h1Idlupk6zo6s1
 2Y/EsrAjtwJCEblRmO0qkmxMx5k/ht+WFw4xSJh5lT1VHcM6kRZUxI3u/6QNB9frUoL6
 JO7YYxBd8vqiMeuaFBuvPlZm6rOQyPS1IHNkr8z0FU2jEdP0EIiW6zcsi/tDkWbBLyrv
 +pMoFkq5bdrpp+qwXA3MfRXIs8RmEAzcHQDF6QhxADExfwYoszpj9RtvL5zmfsNcJpsX
 vy/e0Lr8KhTjXEven30qx/EWQ6J0yLqhv1wLqWRW06qdtOx06VihkoMQS6GYfSKWhcbJ
 03jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485735; x=1778090535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9L5PKnF8A6WpJrZmtMbg1QxIVqDtIGUsYnJ+GYfqmKk=;
 b=IxUdJlfIJfkQJnKJPdEF2jCNXAz7ceMpxEAEa7EPqjzPjtPcx5xP6bAcnHyX8Oane+
 OpUaVVSASjTyEjVCmOLiVhNIO/GBdDFRhmnHVGEnLwM4t0B1i80mGf3F2IwEQf9VxrPj
 OX2/ijvVUBNMy0DQywcTf7CeomWbpR2nrAwNWEPQ3HottRybr+LrRCVCssan5fAhHmM4
 exHrCpJemouMAhu1JgoAQtD/W585FDF6Mrxk53pXmQjml2spy+7bOKZh/6dYqFJRE7jj
 NCstqPS7UOcaMErUi/q/pgmWMm6TbPGWdbx85Je31sVj/axV00L8jWzVnDWRBt5B4Gq1
 +dSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rRYZmi49l/82ms8cdoCIzdVSyRbGKFMFDJt/dSaolQZ6jQ7ci+Ve5hgWIbISo0vgF/jiYzpg=@lists.denx.de
X-Gm-Message-State: AOJu0YypBf3SITqQquGCImLyptBhAE2Rl8vVv7NPLj+YoQAotR+GMbIU
 AMa00YkaPea1XcGTs6se/1HAR+6ZPPzy0QH+vjj1de9G2/eXSc4CCsx3BJxzc9ucYAM=
X-Gm-Gg: AeBDieu+TgjzD9Zp8gFbH6rWJ21QQt1lqTz0Hoh0RmrLB76MAHVXmH6l1XHSvhhjQFw
 rU4KVcalEex+fvLm91rZC1ioHYmanfJ3TraU7DfMqTeRWNo2/PDbye6l7fdt2MF990trK+IdNJ/
 EzxekGN8UCUZGwLfexNHzzrkOgeKYp2boX5Awny4AW+0eOq8JMKCEwLiN836N3e3Brc7Cl9zMJp
 Z8NS+K09MAUx6+UuRKO0sMjvg4z5J6b3zz158K6vqoGV0aJkfUe+C/+JsMfEThnDk3gCrTkJiuA
 cKQ9Ja1nnGF+psTZbt2uRQRKfyrQUFfOHMUuJt8jFZcxAO5mX97+0FLdD0wbdnAHgFtOFAMnhxi
 eyqyIjPbcpDi6WwL064rul5y5z81RkjN5RByNfxa2uk6Y7tt2UTJPYFfGGwUEjPejkv+ek2pqmT
 zUgfnOv9N0hYDKW7P7YlzAH4uBU7iA+ulNvMltCVdM+3WWbN/oNJOW6b0A2Rsh7Ia/ICtlnxy+s
 O5OaKa/F+dH
X-Received: by 2002:a05:6830:6a97:b0:7de:649d:f2ab with SMTP id
 46e09a7af769-7dea67106b8mr2958562a34.13.1777485735089; 
 Wed, 29 Apr 2026 11:02:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab8062b6sm1736792a34.8.2026.04.29.11.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:02:14 -0700 (PDT)
Message-ID: <c1926ac9-e810-4909-945b-a2cf2a824685@baylibre.com>
Date: Wed, 29 Apr 2026 13:02:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
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
 <20260428153448.980150-3-mikhail.kshevetskiy@iopsys.eu>
 <5f524c23-d21f-49f6-8b26-778654c41a42@baylibre.com>
 <bb3d92fd-0ef4-468f-a3d7-f663f59b5251@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bb3d92fd-0ef4-468f-a3d7-f663f59b5251@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 4/29/26 12:09 PM, Mikhail Kshevetskiy wrote:
> 
> On 4/28/26 23:42, David Lechner wrote:
>> On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
>>> The driver based on official linux airoha pinctrl and gpio driver with
>>> Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
>>> The changes:
>>>  * Separate code for each SoC and keep some of the functions in
>>>    common between them,
>>>  * Add pinctrl driver for EN7523 SoC.
>> These comments above seem more approiate for the cover letter.
>> I can keep the cover letter in the git history when I pick this up if
>> we think that is important.
> ok
>>> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>>>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
>>>
>>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> ---
>>>  drivers/pinctrl/Kconfig                 |    1 +
>>>  drivers/pinctrl/Makefile                |    1 +
>>>  drivers/pinctrl/airoha/Kconfig          |   16 +
>>>  drivers/pinctrl/airoha/Makefile         |    5 +
>>>  drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
>>>  drivers/pinctrl/airoha/pinctrl-airoha.c |  691 +++++++++++++++
>>>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1060 +++++++++++++++++++++++
>> Let's split out an7581 support into a separate patch too and have
>> this patch just be the core/shared code.
> ok
>>
>>>  7 files changed, 2287 insertions(+)
>>>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>>>  create mode 100644 drivers/pinctrl/airoha/Makefile
>>>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
>>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>>
>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>>> index 578edbf8168..46a95a1ab6b 100644
>>> --- a/drivers/pinctrl/Kconfig
>>> +++ b/drivers/pinctrl/Kconfig
>>> @@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
>>>  
>>>  endif
>>>  
>>> +source "drivers/pinctrl/airoha/Kconfig"
>>>  source "drivers/pinctrl/broadcom/Kconfig"
>>>  source "drivers/pinctrl/exynos/Kconfig"
>>>  source "drivers/pinctrl/intel/Kconfig"
>>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>>> index 29fb9b484d0..b03e838ab39 100644
>>> --- a/drivers/pinctrl/Makefile
>>> +++ b/drivers/pinctrl/Makefile
>>> @@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
>>>  obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
>>>  obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
>>>  obj-$(CONFIG_PINCTRL_MESON)	+= meson/
>>> +obj-$(CONFIG_PINCTRL_AIROHA)	+= airoha/
>> Alphabetical order?
> Could you provide your vision or more details?
> What is the best sorting strategy?
> 
> Should it be sorted by CONFIG_* usage or by corresponding filename?
> Should be files and directories sorted repeatedly?

I was just expecting it to be added before broadcom like in the Kconfig.
I didn't look at this file beyond this context shown here though, so
maybe it is just a mess already and not sorted well.

In general though, sorting by CONFIG_* probably makes the most sense
since it is easy to mechanically sort it then.


>>> +//#define PINCTRL_GET_STATE
>>> +
>> Drop commented/dead code. If there is a good reason to keep
>> airoha_pinctrl_get_conf(), the make a comment there, otherwise
>> drop it.
>>
> This code allows reading current pinmux/pinconf settings out of hardware.
> It might be very useful for debugging reasons, so I prefer keep it.  

OK. FYI, I did something similar with mtk_pinconf_get() recently
so that it prints the current config in the `pinmux` command. Then
debugging can be done without modifying the source code.

>>> +int airoha_pinctrl_probe(struct udevice *dev)
>>> +{
>>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>>> +
>>> +	pinctrl->dev = dev;
>>> +	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);
>> nit: casting isn't needed here (leaving it out makes it more readable)
> 
> Yes, it will be a bit better readable. Unfortunately dev_get_driver_data() returns ulong,
> but pinctrl->data is a pointer. The compiler might print warning.

Ah right, I forgot that. I usually do (void *) in that case since it
is shorter, but leaving it the way it is is fine too.

