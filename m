Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74FEC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 15:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03872886B5;
	Thu,  1 Aug 2024 17:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YV4xRBv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DC988A48; Thu,  1 Aug 2024 17:15:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1797988669
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 17:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428119da952so45371045e9.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722525335; x=1723130135; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=38jYVDf42CBuPQRvS7A9OybQDqGe5PGo/emTDgnR9Dg=;
 b=YV4xRBv4vQEwZ3Ws4sNn7sQf0v6gxGMjky10D1JwtRtFTRqcoQ7DGBAt+Pdcvi2CLE
 h3m49fjjv9b6cSbNrea51VCcArSsXfG+Z1umfuNvRhjJCg/0I1GGt8gejbQ4s1kNrgEP
 bhQZkMqO9Xxc7J9zAwt5CMqjMO+J9scbjW5+CZ0LuuaTlDd6Q63tmc8URg5I+vCbjhnO
 mu7xD76dXpotzIrE5KJhZKi7pTjGTOAW0BCnkwszpqhnaC2gwmeqnALDJD0VBg/yFk5U
 aREBPgJJ9RuxO2GpgMApAanPjgJ470dAVHw2GkD6hIYfzSZcwVS1WsTHfBujSetVSFU/
 QCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525335; x=1723130135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38jYVDf42CBuPQRvS7A9OybQDqGe5PGo/emTDgnR9Dg=;
 b=jLXd4Mew4XWwxyVQfNsstw+z8jHKUDnKegFFtB6WAsk/tak8feSNlLdQufXscSNIYQ
 1lL0GcohcYZHqhHDlev4vKuLjg5I5/53hsiKkooi8NKlt9SrGT0Z8rUz0RvnwPs4zQqj
 TbDl8TLZgjib5kMbN7/2Yb6njHI7Ob6VXB+bZ481dYsoweChHU/hK2trLkloUIvokDvp
 hjI6AUZngq0dILLix+oSyRAFLdAIWRMPpMgo5TyfwvNHAFYFrWsSo0ALJCdQrkii5EZp
 2TAsh0Za0G3eeyyWH83swJLybsta+X9FyKoQiIrtlTks1ut5NqW01koXrrHjjxXzf0rQ
 V2yQ==
X-Gm-Message-State: AOJu0YzX6+SgyFfKUxR7I6D7wvPWK1CQf+eqgZ14Lvl9lcRTEG7bH8Ra
 FCr20NRA11a85oBPl7NCRFm433JCitc+3IMkwyosgbodNBxsN18FKJgUh9LSU2I=
X-Google-Smtp-Source: AGHT+IErM1KTKi8GbeheX8dZgDItmvRUIuo1fEcUzCR+Z1UH1Ji2M+cqZfUvYqAX+UXvTayx+j9teg==
X-Received: by 2002:a05:600c:154c:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-428e6b956edmr1147505e9.37.1722525335357; 
 Thu, 01 Aug 2024 08:15:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:10f0:14b5:e4e1:d5ec?
 ([2a01:e0a:3cb:7bb0:10f0:14b5:e4e1:d5ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d966csm19706106f8f.38.2024.08.01.08.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 08:15:35 -0700 (PDT)
Message-ID: <36497602-1fc9-4044-800f-cb1d5fd789f9@linaro.org>
Date: Thu, 1 Aug 2024 17:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat> <20240725223401.GD989285@bill-the-cat>
 <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
 <20240801144344.GH3794063@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240801144344.GH3794063@bill-the-cat>
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



On 8/1/24 16:43, Tom Rini wrote:
> On Thu, Aug 01, 2024 at 04:40:03PM +0200, Jerome Forissier wrote:
>>
>>
>> On 7/26/24 00:34, Tom Rini wrote:
>>> On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
>>>> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
>>>>
>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>> reasons for doing so are:
>>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>>> such as Debian etc. using a secure, authenticated connection directly
>>>>> from the U-Boot shell. Several use cases:
>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>> binary with a different one)
>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>> image as it is being downloaded
>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>> (this is becoming more and more common on the Internet these days)
>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>> - Less code to maintain in U-Boot
>>>>>
>>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>>> Git subtree with the following command:
>>>>>
>>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>>
>>>> This is better than v4, and on the hardware platforms I could build and
>>>> boot on (which was most of mine except the am62x_beagleplay), the tests
>>>> ran and completed, including the tftp+boot a Linux kernel.
>>>>
>>>> The bad news is CI blows up, a lot:
>>>> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
>>>> And:
>>>> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/build/builds/9014/logs/106
>>>> which is another Kconfig dependency problem. I don't _think_ I
>>>> introduced that, but since this wasn't against top of tree, I had to
>>>> apply the cmd/Kconfig patch manually.
>>>>
>>>> I have my world build running still and may have more comments based on
>>>> that.
>>>
>>> First, with NET_LWIP being default rather than NET, there's a lot of
>>> other Kconfig dependency issues. Unfortunately I don't see an easy tool
>>> for making sure this is all clean aside from a shell loop like:
>>> for C in `(cd configs;ls)`;do make -s $C;done
>>
>> I have run this loop successfully with the upcoming v6 version. Some
>> configs do print some warnings but there is no error.
> 
> Those warnings are the problem, I wasn't clear, sorry. If I could make
> it error, I would since then CI would catch it.

v6 won't add any warning besides the ones in the new
qemu_arm64_lwip_defconfig file that you said were OK:

$ git co origin/next
$ for C in `(cd configs;ls)`;do echo $C...; make -s $C || break;done 2>&1 | tee configs_next.log
$ git checkout to-upstream/v6-wip
$ for C in `(cd configs;ls)`;do echo $C...; make -s $C || break;done 2>&1 | tee configs.log
$ diff -u configs_next.log configs.log
--- configs_next.log    2024-08-01 17:10:50.903533652 +0200
+++ configs.log 2024-08-01 17:03:55.497799493 +0200
@@ -2016,6 +2016,11 @@
 q8_a33_tablet_800x480_defconfig...
 qcom_defconfig...
 qemu_arm64_defconfig...
+qemu_arm64_lwip_defconfig...
+generated_defconfig:71:warning: override: reassigning to symbol ARM
+generated_defconfig:71:warning: override: ARM changes choice state
+generated_defconfig:72:warning: override: reassigning to symbol ARCH_QEMU
+generated_defconfig:72:warning: override: ARCH_QEMU changes choice state
 qemu_arm_defconfig...
 qemu-ppce500_defconfig...
 qemu-riscv32_defconfig...

Thanks,
-- 
Jerome
