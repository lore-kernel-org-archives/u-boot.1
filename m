Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B19C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3205F8391B;
	Wed, 28 May 2025 14:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDC2oupz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2729C83A79; Wed, 28 May 2025 13:03:16 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2162F839A7
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so5169185e9.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748430193; x=1749034993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8r6CfjzcabpIZcqI6CZYMs0uQHY1t2gSpknHUyKa0Q=;
 b=MDC2oupz0JfSRSsVeJOnUwy8lvmb1213pCQYjo6+hPYoHjvXRe9Tvc7Bn6JIgJKYnt
 EreJObo6c8kdp8hKAGSDQYYppliCIpe7EajNZxJcwb5hwGLqL1fPzjpYAHYgbPAZK1h4
 nOePVC0TEY8FcoUgdlqaINtOEDsakQLvVl7SSJk2YVB5mP5Ns6huN+/lQgNjFIbqmMUp
 TH9S4YVopuGqMaISyZYGR9viPHJEWPoHAg/cWoLmdlsfotiZCVz5Rg81yXYI2M7HspiD
 zseU0k2+CDalvEEdzBIOepWVQCqLvq2ytI1tO+tinFxOiQ8wk7/noQP/FlsLH9y4/tBI
 vb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748430193; x=1749034993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8r6CfjzcabpIZcqI6CZYMs0uQHY1t2gSpknHUyKa0Q=;
 b=JpqdjSDtT1nq517qcQdjof6HRlAILEvoH0vmBAjB/HotkYWmodYnNOqFpL5BA0kjwJ
 WNSYrrEYYUVtMFECTrcYMu2x9ptsjSv7QgUxiRabQiPOUk3+99B0KA7T2GPZl9/67LE3
 Vqy6e/8mHM+5OMMzJZNRA/QhbiCc5Uuf4w7VhvlX2OXo9LDHQn8lwpO2FfurUuuSK8iD
 8q1bVrYNOBBxwvahoEPYMblAE7Q+b2BSLcCBzu9XyqTjoYfrRQd2MN5IMb2cKNAPP24H
 3SGVwEKAJAvlApaIuh1COiBiPmixikGRqD2v1VkDpYXFQIv9JRsM3+92nvMUAdAre39M
 ZPKA==
X-Gm-Message-State: AOJu0YwtUsIukXwAsiaPD4GJMqAiTrUswBadmhfpOEO93yoDFk0tg3Lg
 LJrUvsxXZN2A0m4cwrzcwsp0USPmWeEZVDBW1uBQoEt2+UqPVUN15tZBoMK56xS8vK8=
X-Gm-Gg: ASbGncvUbSXpOXBCasn1SwT/obqaMtIcHohqR+PzzAhjEVzlEPoI/soSTQg5SfMlpAs
 kf1m4wXw6lrPguVZuLUqhRjZfs29ZWdRCjrEBT+R/Esh7vMFqWF1SOX/t7v79PqTuEvsNDlgw8/
 eYQ9inyr1l2haUJZ7dm8b7xPjqfo5pev+iavaqJ2264BmUNEQWusoBKfPlJZgY0oplS8Zvw1h2r
 4wXFMyRY9CW3dYMEzrtYMa6hpTuO00+2rC025ZmemVBdhkwl4ZPwljPQkA39riMV9XNBRms4MPe
 WsVoivm56p4FPmVYYqG9VJUxts4XBJlBYMuZXQ1X4DFk2wmOOlLVzEl8WS7Pb2WgzzpW7aGOooT
 DUbGLFtGbYinYdNDSn/qlk3urWw==
X-Google-Smtp-Source: AGHT+IHnD9q6A1IBPdeb4smGyUidYdVXeCL4KZjqXSUxqWrai/xFaq9ScGwpbPp5Cddpr1EAdDsT0Q==
X-Received: by 2002:a05:600c:8712:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-44fd1a5bd27mr39209765e9.10.1748430193295; 
 Wed, 28 May 2025 04:03:13 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:7b9d:1015:16d5:5c7e?
 ([2a01:170:117e:fc:7b9d:1015:16d5:5c7e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450787d416bsm14022095e9.39.2025.05.28.04.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:03:11 -0700 (PDT)
Message-ID: <b8c81f80-a32b-4935-b2f6-edb361822b6f@linaro.org>
Date: Wed, 28 May 2025 13:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523140613.GQ100073@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523140613.GQ100073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 28 May 2025 14:46:33 +0200
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



On 5/23/25 16:06, Tom Rini wrote:
> On Fri, May 23, 2025 at 02:06:35PM +0100, Simon Glass wrote:
> 
>> Some functions provided in lib/efi_loader are actually useful for the
>> app as well. This series refactors the Kconfig and directories a little
>> so that code is easier to share.
>>
>> As a starting point, it moves some filename and device-path functions to
>> the new directory.
>>
>> The next step would be to move device-path code over, but this will need
>> some discussion.
> [snip]
>> base-commit: 3599a58a5114224a01557d18371036a5823233cc
>> branch: app
> 
> Please base this on mainline, next branch before asking for review.

Seconding this, for the second (third?) time: please don't send me 
patches that don't apply to mainline U-Boot. This especially sucks since 
I want to see EFISTUB upstream>
-- 
Casey (she/they)

