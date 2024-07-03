Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4846C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 07:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13FD887C1;
	Wed,  3 Jul 2024 09:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WTHc0JoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D6A887D7; Wed,  3 Jul 2024 09:16:08 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B8388464
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 09:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e9a920e73so122114e87.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719990965; x=1720595765; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbAju8xQ188c/NoXc4pb828+dbfTEDzcOxYiLJPhvMg=;
 b=WTHc0JoSa1OLf8j12BO3YkFEbwaeIKfM/N5+TT7NU38rJKtK5tkb8GukRF/9BOBHjQ
 rI0DetcGOnEST+dNlIguR7U0rSrTQmsrdxdsnjITO2sUe3AidRxDbakdDD72K46QWgyu
 Qw/zlWlIeBydcjmAXqoSLicBslyrVFLcZCFfHMFV5XzBF2HWzVNWYPJwWz/ZofRR4Fgq
 ut4s95wxivHsS7w9TOTbhbLbYPIFucScovTDWN9pHyWRB59rIxoDIr8xQdMUJ7b/u9S5
 nvR7DzxTaEislUUpKhc13FQTzxcXwNW1AWYy5hdzAejs+o8N+kDwQwAf9uMNEPAXp79i
 fs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719990965; x=1720595765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbAju8xQ188c/NoXc4pb828+dbfTEDzcOxYiLJPhvMg=;
 b=aoifxekjcp1ZUf9l4mZpyy/rasjj6u7gV53176DeNnfZruHnH6c2PHt5VH5ind1zPC
 2JBW5PKHw3tD9K5uTV7OlPPf19luVAbF9aYZqJeIVyhB8SBUyVd8otFWLyUUApL2032W
 eFBnfS14SF5uB+8Eo684kf8jOD/2AWwXzSMUxgxfj/EV4fA9HN+zWpLvj+u6mm+Sh94J
 GJF2ohSXd1Gu03AdVWm2joeNtunhbNnyVkJ6xYJtNrSvPBufkvL58Tdn8kG7NMPNaNfw
 bRMhcE7fRlWWa1NeW9QZ3+WoBy7DWR2Flya/xWPt8+U3PNi2PbMq9PsoINEDS0Bu3qKS
 UV6Q==
X-Gm-Message-State: AOJu0YyOd6cMzDhjDca/1RZel5wHKVRfhs3hIbgwpdRTxuRbd9QAtuxM
 l1wAXgAUz9OdSOLmku3RIgz9JG76Mc/vZJFPhIQhAVq1Z2uBbrO7nv6Z8WPdXag=
X-Google-Smtp-Source: AGHT+IENL0kqPtZd1mNKA55vi2hYtpOJl5ZdcsJCgT0Uq8sPWnW0CEzP45RBxCgWBI3rwR1DPE+ZAw==
X-Received: by 2002:a05:6512:3a83:b0:52c:dcea:86e2 with SMTP id
 2adb3069b0e04-52e82646dd4mr8444090e87.1.1719990964946; 
 Wed, 03 Jul 2024 00:16:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f4e2:f258:6545:9264?
 ([2a01:e0a:3cb:7bb0:f4e2:f258:6545:9264])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389efsm228215105e9.7.2024.07.03.00.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 00:16:04 -0700 (PDT)
Message-ID: <3d513ee0-fa95-44de-81eb-5f281b1899ad@linaro.org>
Date: Wed, 3 Jul 2024 09:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/29] mbedtls: Add script to update MbedTLS subtree
To: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-3-raymond.mao@linaro.org>
 <20240702205658.GS38804@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240702205658.GS38804@bill-the-cat>
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



On 7/2/24 22:56, Tom Rini wrote:
> On Tue, Jul 02, 2024 at 11:22:38AM -0700, Raymond Mao wrote:
> 
>> lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
>> commands.
>> Usage from U-Boot top directory, run:
>>
>> $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
>> $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
>>
>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> ---
>> Changes in v2
>> - Initial patch.
>> Changes in v3
>> - None.
>> Changes in v4
>> - Minor fix and move the script into tools dir.
>>
>>  tools/update-mbedtls-subtree.sh | 47 +++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100755 tools/update-mbedtls-subtree.sh
> 
> Given how amazingly close this is to dts/update-dts-subtree.sh and also
> the lwIP version, can you and Jerome please co-ordinate on a short
> series that you can then both depend on a pre-req that makes, I don't
> know, tools/update-git-subtree.sh and that script takes upstream URI and
> whatever else would be needed so that all 3 of our "update or
> cherry-pick from a git subtree" scripts call that and are more or less
> one line scripts themselves? Thanks.

Sounds like a good idea :)

Raymond, FYI the lwIP series is at [1]. I will make sure I CC you on the
next iteration BTW ;-). All the information about the subtree is in the
cover letter and that's basically:

  $ git subtree add --squash --prefix lib/lwip/lwip \
        https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

[1] https://lore.kernel.org/u-boot/3c2b8a90-1d4d-41ac-a15a-0d3b2a7d2a57@linaro.org/T/

Thanks,
-- 
Jerome

