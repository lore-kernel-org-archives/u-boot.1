Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13AAFD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810AD84101;
	Tue, 10 Mar 2026 17:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSm8ZZFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01398410C; Tue, 10 Mar 2026 17:21:53 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7482C840EE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ae50a33ff8so68926455ad.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773159710; x=1773764510; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4X4p6WvpzkGUnNff3s6wSC+4isNHUkw8RVcMw186h4w=;
 b=mSm8ZZFtYDchqhva06BRDE3FkbeJ9v6EtkqMz0ENSQVx2JlbsmdF0lYbqzCKlJrY7H
 voO3zFHc/Dyois5Dq1sr2dUk9Ld+21XIKZbfmU6aQEt89gKvMQOUQd0fj80ndwbFeM0S
 V0koIe+tlojqVLzD6sDSElNkq0OH8cJbYMyBZg9YqrF/tq8+EYDxZC6JjO+I6CF0PDoU
 NCNFjnVDuOSu2hx8yngOTK0LyIMC3Xe7kWsTapzl/d1G2LwrVwWe9iGi3UULiF4a+OiT
 JQAsfPQ+eP74x1HozGSur8wofs8w2hFoUAicPEVHW2dafrE7j/SW4k73eFUZHTTKXxxn
 ppKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159710; x=1773764510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4X4p6WvpzkGUnNff3s6wSC+4isNHUkw8RVcMw186h4w=;
 b=wTgeVb4166xE3RL0/Qfdi9Uy078vZyJ4pxpQXvpG4HOgQIfl3D5Sd3D+GAWE5g/eA/
 XJpZspYiQK9cnjivlX4f+l+BxyPV1io0YY2ghL0lrNVpxl2JIqDCRWGhxjDw1CKOD8Um
 Ib4nK+JR1LUm0GEBGvi+/IpXqRABaU8HutzoHOSs25i2kR/j6peJjR0rDC6RScHF8SZP
 5gWKS41w9uQZ+HERT3iP3FMnsRYHyx/xitA/sLyQPlEsJMu+npVXyf0c40iQMKewM6/f
 XxLDiC0oi0nQlLI5v6d41ugEPWGxi3flnqNFfaz0ah549nebhxf2XTYVAwdRuGLkbw/Q
 qhcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkx1sGxjbMPJs/z5lqBRzy4cxx0cXmpf3cyvYlGzPagsgYJI5aQ3by1l5psusNo64cEBG5hfo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz69KxF3rIEg1ibyv00nwPmWKGwNbtTTS2dF08hUC+GN7oKwVUe
 qwKMAxZHXBWMsHkI6sQhvBJ1h7fN+ai3sm4BG3qGLxgB5RG1Svtfge4n
X-Gm-Gg: ATEYQzzx9mYw4cH+NXFb4I7z5xZJXfFbTwp765RVeDEHFOVcuCgT5s5IxXKS0cunkiz
 qGwvkxWui8MGfuXMRlPlmA5VvwPnlHU9pbOZlBPiAH2AwZsuDv3Tj1oALt78eO6OCcJHXjUBtjk
 fvWjMDFc9UwpHUnDnjVrBRqOmsivNEXpzWWFbZ2GzOrKelQopt2Dyy8DcZgRlPgC9dkb/JRSQ/K
 M549EJaCRvAadJNh8uYCrueCqnnjHf/ukKY8Zoi6UIpbEVE8OlAZ+9u/baya2YFgpnnuCZEPLPh
 igJDWN3FPoPquSCTKRfVc7X5isSD1S1sbXuoI//b2DHxJHkSt0PxsenDz3hmticegRJ7EiADVLh
 Uy2ARbMxnQWtQyJ6vbPxNoh42AjYLalFMEfv7W3bC/tNgdS7A9Ka4G764gu+tX7taZs6H4B4ueR
 Cfjir+G1BxSAiSa+Dc1WXbsVYJC4+4b3k8qHe+JOma3zw76YsWLjxjG0+Xoj+/gwgAYGdYfeZN5
 XQcPeFuQlQ=
X-Received: by 2002:a17:902:cec6:b0:2ae:5345:89ef with SMTP id
 d9443c01a7336-2ae82432e95mr167826295ad.26.1773159709805; 
 Tue, 10 Mar 2026 09:21:49 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e57cb1sm151259085ad.9.2026.03.10.09.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 09:21:49 -0700 (PDT)
Message-ID: <06373536-c45c-439e-9876-69276055e565@gmail.com>
Date: Wed, 11 Mar 2026 00:21:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: add common PHY properties support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com, kabel@kernel.org,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-2-lucienzx159@gmail.com>
 <20260310083200.cbcedg4gj5jlgqso@skbuf>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260310083200.cbcedg4gj5jlgqso@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Mar 2026 17:28:08 +0100
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


Vladimir Oltean 於 2026/3/10 下午 04:32 寫道:
> On Sun, Mar 08, 2026 at 10:06:13PM +0800, Lucien.Jheng wrote:
>> Add a new PHY_COMMON_PROPS library that provides helper functions for
>> PHY drivers to read standardized polarity properties from the device
>> tree node:
>>
>>    - phy_get_rx_polarity() / phy_get_tx_polarity()
>>    - phy_get_manual_rx_polarity() / phy_get_manual_tx_polarity()
>>
>> The dt-bindings/phy/phy.h header with PHY_POL_NORMAL, PHY_POL_INVERT,
>> and PHY_POL_AUTO constants is provided via dts/upstream/include, which
>> is already in the build include path.
>>
>> Ported from Merge tag 'phy-for-7.0':
>>    git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
>>
>> Link: https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>> ---
>>   drivers/phy/Kconfig                  |   8 +
>>   drivers/phy/Makefile                 |   1 +
>>   drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++
>>   include/linux/phy/phy-common-props.h |  70 +++++++
>>   4 files changed, 365 insertions(+)
>>   create mode 100644 drivers/phy/phy-common-props.c
>>   create mode 100644 include/linux/phy/phy-common-props.h
> Thanks for doing this. Do you think you can also port the KUnit tests to
> U-Boot's own "ut" test framework? Should be testable with the sandbox.
>
> export KBUILD_OUTPUT=output-sandbox
> make sandbox_defconfig NO_SDL=1
> make -j 8 NO_SDL=1
> $KBUILD_OUTPUT/u-boot -d $KBUILD_OUTPUT/arch/sandbox/dts/test.dtb
> ut phy # or phy_common_props for the new code

I haven't used KUnit before, but I'll try to port it to U-Boot.

Let me look into the commands you provided and figure out how to port it.

Thanks

