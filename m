Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69591CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABA783FB2;
	Tue, 25 Nov 2025 09:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z/RwXe95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A2E83F30; Tue, 25 Nov 2025 01:04:53 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D86A83EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45085a4ab72so2267204b6e.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764029090; x=1764633890;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHXzxzxmLPRQiA5OvDfc6kqZ9H3vxYj1Tki/jMFhqxM=;
 b=Z/RwXe95gfi2zM3BHpv2NKx/vu3WrbDKaRi56zfJdTwFr9GWcE+W8Z3GpofAUs/Il0
 yLZz8D3cggIxbUpl3dbiGURo5Vt7Dw72xTnMCoLZwftQittaeVi62WO0Unm0vZzkKt2z
 6RQQyDrujkQBCQRP5d6Mzi6nZnU7NSL1gchv7gEfiVUP8orBWL5+zPKMavoLdNlAx6sS
 Sb7flrIAD60gj10AGM2uyuCUw3sMhYsFxkduvwm78GyzGXjVXHDC+eEq5MamUyOVpsQp
 apYAp6vs81BJ0bh+y/PBsIk+mD7gkJ2ZAipjF8ljM68/WOEp2js1Caa4UMy1s1CgiSLp
 BX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764029090; x=1764633890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHXzxzxmLPRQiA5OvDfc6kqZ9H3vxYj1Tki/jMFhqxM=;
 b=b1Rd4jUFVQixtrj1vCfEQKJ5WeXOgwcUAkbbI5zx7QivY8rNifM0X4UJayDTOkilia
 CQmVpm+8LDtjTWLAzPomko7aivL2ALUVsqeZDEKUF8AuKtKk42rF7z2x0bRMYdQ6rjgB
 PZ3Qo3u78vtpXJqq7WqeBIzJLaWm8V9etDPu1+3PGw6mQXFq0/7/iAptCVIrbQP8zIfW
 zdlC7xyNSf1N9dgvBGGcn6bFfBQrSymM1wDkPSzV0AfnZ7gVIZ/icsdj2cSijVuzCjsH
 RNtbQh8bolvVS+UIxUrfWKIgU2Yyyvjb9qe2pSMmMgmxQGEP6YCzAkpIMCO4uJRBZtvi
 2PQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NVLguRU85e2IuGqPYR6ijMpvR9CEj7/9yfYj9N5oLqakusWn546vh0D6B4WjRXLG4vXS0Ag=@lists.denx.de
X-Gm-Message-State: AOJu0YxZTxnzLhLb6cMpfDwVRdgfoUKAgSKJynof1DXzbCA/g/2PGFaq
 eu+tJHIg+h+2hrzmcGlSaXe8bIHTs4A6dQ2saSSa6kDh8+3N0m3j/aW6QxJPx/mIL7o=
X-Gm-Gg: ASbGncsP+fXakIBcnMvkYOYu/C3Ixtez7mgRtbhu8fBwlQkZJVbgAYCZyxl5KUoIu1i
 v446BUpjyW0issr1rSZRp8mc9oiKwtoPdz190QEPqmcFZE51QO64jakZOAIkNlU9KP2hE7zXeqa
 RDkq6ilK2hlOrw+hqgwHsJ5s10Rim8mBV6ODJQu8srkX7ZlP3swttfosPouvLwGa/E1nnghuNFW
 +o99tX/L8P/yFcRITfY1DHCaRFM7OYnR6lb9vsbgVGie0ZoWRpCN/mVy6rN9I+AwRloYNkW6N2F
 v7EppJXJiUNpgseynyqbaFFQprHvEKDLA6rZSZqXJtnJqWMeMOTWVM+MbLl9laHlZD+bz/zsFWr
 CHw9Uu2OqHSF1Nb1e2xhNW2xinYFPpPAaCnMY54um0rZA2ZcGPmnxSl6oQQRV3O65JUw0c0zBMe
 pkX7yOjTfC/gLfQ70JwMRVjLa1Ve6Ky0qu+UsQXpR06rC/Wi2Up57TUVmJ3A==
X-Google-Smtp-Source: AGHT+IEEd3+LSq5A2jDX9eeOg2S/dFY9w753+kGbAX1wj1zdQbKRuhxZzd6pfowgrP3wFDpqaQVdsA==
X-Received: by 2002:a05:6808:2f14:b0:44d:aa8b:58f2 with SMTP id
 5614622812f47-4514e5f9dd3mr468080b6e.9.1764029090288; 
 Mon, 24 Nov 2025 16:04:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8a36:4d72:5018:118?
 ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782b4cc3esm3867083eaf.10.2025.11.24.16.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 16:04:48 -0800 (PST)
Message-ID: <e874e246-16a8-4459-92ad-31979349fd94@baylibre.com>
Date: Mon, 24 Nov 2025 18:04:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: pytest: add missing hook script env vars
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
 <20251124-doc-pytest-fix-script-env-vars-v1-2-fec5b54007f1@baylibre.com>
 <5b53a23e-1679-46e0-92c3-7574a35ae8f3@gmx.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b53a23e-1679-46e0-92c3-7574a35ae8f3@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

On 11/24/25 5:53 PM, Heinrich Schuchardt wrote:
> On 11/24/25 23:44, David Lechner wrote:
>> Add the _EXTRA variants of U_BOOT_BUILD_DIR and U_BOOT_RESULT_DIR to the
>> list of environment variables set for hook scripts.
>>
>> These were added in commit 8f2a9fa7d6e7 ("test: Support testing with two
>> board-builds") but were not documented.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>   doc/develop/pytest/usage.rst | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
>> index 7c42a31528fd0ef78d3e24f65ee86ce2d61d6e87..df3821da20dd6e4199947a594e5e2eb2198e6e6d 100644
>> --- a/doc/develop/pytest/usage.rst
>> +++ b/doc/develop/pytest/usage.rst
>> @@ -316,11 +316,13 @@ Environment variables
>>   The following environment variables are set when running hook scripts:
>>     - ``U_BOOT_BOARD_TYPE`` the board type being tested.
>> +- ``U_BOOT_BOARD_TYPE_EXTRA`` the 2nd board type being tested, if applicable.
> 
> I cannot find the two strings above in U-Boot. The mentioned patch adds 'board_type_extra'. Where is U_BOOT_ prepended to the capitalized string?
> 
Same answer as the other patch, it comes from:

    env_vars = (
        'board_type',
        'board_type_extra',
        'board_identity',
        'source_dir',
        'test_py_dir',
        'build_dir',
        'build_dir_extra',
        'result_dir',
        'persistent_data_dir',
    )
    for v in env_vars:
        os.environ['U_BOOT_' + v.upper()] = getattr(ubconfig, v)

in test/py/conftest.py (around line 340).

