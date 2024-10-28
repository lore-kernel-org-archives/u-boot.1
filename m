Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA9CD5B154
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 22:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CD9890A9;
	Mon, 28 Oct 2024 23:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PQ1MLE9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6E5890E7; Mon, 28 Oct 2024 23:01:15 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37EFF89043
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 23:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A80CE3F2B3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730152870;
 bh=NB8DtMk9ZsvjT/4TRndeB8yimM7Rjg+RDzd9NP/YVHo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PQ1MLE9GTSFLUSEFSpEbdtvAL6jRTG95D6j3x25KPbLLFrN5ZEawqvkHfFciOiaNb
 VZnqGHMFuKH2YfBiDOr+tn2PqmyDxb5OCelFDyUmvVTlgHnMS32J0V6THQ8loYhsua
 d3z03vPSX3Yl6qyPeaNYhOJifat5MaW202/Gd5UjsLkKFUwQBkQWAuXLlSKAQnk0rS
 LmB3BNXmOaLLfIkXhji2LPn3d1qJeUKfghG7rUVP7YeLRRbGPVg5ku4YvUQfsIwPlQ
 hxsANLc3Zs7GVG0wMwbuZUmgbYztnnW0jCtfZ9wDoGZkJZqd2KDskLxC/3tfs36z9s
 9VC1pig5t0SCA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d504759d0so3166665f8f.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730152870; x=1730757670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NB8DtMk9ZsvjT/4TRndeB8yimM7Rjg+RDzd9NP/YVHo=;
 b=SYI3u3XN8RRTtEKqv0kk9lwxy6AFK9gm5pzGbRyhY/JJ4kSL6EuH7hOVAHvFQpEzBs
 8o0hdJ3od5AAljsQAxhh2hHW3gpVKQ2LoDZx98CD0GB3zJTl5Ba5eoG3PT6aL3tke4wN
 zPHxzKLLOjJMH/uHleFUWCkHgMbA+okv4u3CrbMQS5GzX9PaCk5t1qfM5p01zYPjCnBv
 VCVBQCpmkWYrUyEwEC1UgPK4iqn5FpXdcCMeirUJzznVbP5cQ3aWZg+r+hpnCAIjhhME
 RUe/IpFqeqKtDQHf1ewX9QQ18qxvfGkJpZAZc/WObS+DNd/z1LXg5S6QYNMnbqPN2dAO
 t1eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRpGIhPWx9K+VkCJWIkO0n2G7IjonTAhuw9ypDVweKwmjOAInve4jcB4vUJ/KemYEQPeqRZ4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwcWghmxcf4jkTgM0ZuoO1nYS2dSMwtJczPDmf9V0jUs4mDfr8l
 qTL4j3iQIp9eERzaLnU8bo3T+DVGTr6PecXPabDOr7UFjB4LvkK/XZF7VpejE9HJUkyHHlrOKha
 3uZRagV4R7TSY4PolZGLugbJKciccw2HNa10EmY/uehLTDwfacRo/W56K/UNnchJIJXNrn80GYx
 NpcN1x
X-Received: by 2002:a05:6000:48:b0:37d:4eeb:7370 with SMTP id
 ffacd0b85a97d-38061247a93mr9342136f8f.56.1730152870161; 
 Mon, 28 Oct 2024 15:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInY2kvmLO1Mo+U+FVMZ+fOlyrnHxQHYUpPmM2nC2Yrb+mvdMd+YLVJj7K6Y3tr94KKstwDw==
X-Received: by 2002:a05:6000:48:b0:37d:4eeb:7370 with SMTP id
 ffacd0b85a97d-38061247a93mr9342109f8f.56.1730152869774; 
 Mon, 28 Oct 2024 15:01:09 -0700 (PDT)
Received: from [10.43.6.224] ([87.215.50.114])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f2994e9sm409372666b.115.2024.10.28.15.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 15:01:07 -0700 (PDT)
Message-ID: <e229e1d4-c2c9-4697-aa39-925a9ae5c75a@canonical.com>
Date: Mon, 28 Oct 2024 23:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] test/lib/uuid: Make lib_test_dynamic_uuid depend on
 SANDBOX
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241028164844.2308549-1-trini@konsulko.com>
 <20241028164844.2308549-3-trini@konsulko.com>
 <7eb00a6a-bba3-4aa5-ba63-1da2c63b3e5f@canonical.com>
 <20241028213441.GU4959@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241028213441.GU4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/28/24 22:34, Tom Rini wrote:
> On Mon, Oct 28, 2024 at 10:24:58PM +0100, Heinrich Schuchardt wrote:
>> On 10/28/24 17:48, Tom Rini wrote:
>>> The dynamic UUID test checks for the sandbox specific capsule UUID to be
>>> used, so we can only perform this test on sandbox currently.
>>
>> The tested function is gen_v5_guid(). This function is used to generated
>> capsule UUIDs. It receives the test data provided in dynamic_uuid_test_data
>> test_data[]:
>>
>> * compatible string
>> * image name
>>
>> The generated UUID is compared to a UUID provided in the test data.
>>
>> By chance the chosen test data contains the string 'sandbox'.
>>
>> It is not obvious why this test should depend on running on the sandbox.
>>
>> Where did it fail for you?
> 
> On Pi 3, I forget if it was rpi_3 or rpi_arm64_defconfig (with tweaks
> like enabling CONFIG_UNIT_TEST).
> 

On qemu_arm64_defconfig the tests runs fine:

=> ut lib lib_test_dynamic_uuid
Test: lib_test_dynamic_uuid: uuid.c
Failures: 0

Missing CONFIG_SANDBOX cannot be the cause of the issue that you observed.

Best regards

Heinrich
