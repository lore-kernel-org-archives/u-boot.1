Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF616C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 09:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13107887D4;
	Tue, 30 Jul 2024 11:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T3+L5X+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C89887B9; Tue, 30 Jul 2024 11:48:11 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C851887E4
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 11:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so56971231fa.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332889; x=1722937689; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SciELskzrXEIAx2jrLHwqMx6iKbzpnD+LUGoNMhs7k8=;
 b=T3+L5X+V11stA7ptuQibH59aThu69r5wMHzgeGHzL2ZPb8gEwe30V+ZpS1Vxuv320o
 KAnQNIxMzpJqlzwyDnGlcPbaL30g6csk7bVS5aV4jychWJdKNAB+GssMfjJFn66rXo1I
 VFiD1zkFuYJg2C1qm6hu0EZ3oqQ475JeeqvLq+JpvULSAU0JOdoEqioQoXs60sOVIrWd
 dRZ0pCS3t9Cr2el3dVv35ZSi0ibLANRNmSQJAPYQTkVj/fYij3DAs1FzWQG4EX7mQE8+
 /Ae5ksQKHkIhcRrHMILD4YBMhQ+XGkW7ftT4xM5JBqTdZBmN+udJReg6qeh4XBLTP0l+
 lwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332889; x=1722937689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SciELskzrXEIAx2jrLHwqMx6iKbzpnD+LUGoNMhs7k8=;
 b=Vb1W/tCK/IHu9wp6jhOjoXrH+jENedusAu+pfW1tgpe45aVNeJ0K6UpKY5p6tXFfQO
 uN5Am9FmCgoZwcUKVS8Qlu4wzJE4JzYqtanjr8yAbUZVN1Pr1m+fgacReNSRBnC56vL3
 SPGdMdnDwdsIueH1/K+NX3Q6/cQreQwgXbM9GjBA7xHth2As7My4KlcRJEXzHDET4HYo
 VTo5HtUpD+UmInOZBq+TPKCVeAqI4flJlfMyPifWeF2z+ger1PXEzJSWAmCErJLu3010
 CqAv2PD4VoNwOsRrsAig0TnDtDjrIqhDyWqDQK6Mtz1VjoTIQygfNsfy0zAzxEgi8zhu
 rqxQ==
X-Gm-Message-State: AOJu0YxIRmPvhXPrV6zd5dOTjm615kf/kaz5P/u0p4SkX6YDogEnQrIs
 ll5+2u8fViKygX4pl8A/+knPrBJ1TMsIOYP5vul7LQ91X6j9fGed4QFGtY1j1gc=
X-Google-Smtp-Source: AGHT+IG4/NZNRSZ4A/zn2x9CBRSG7i1X9QxnECtw7mOb9xp0DGXN/yfT9bZ0LxCNswglR9hcYDYLjQ==
X-Received: by 2002:a2e:a787:0:b0:2ec:63f:fe91 with SMTP id
 38308e7fff4ca-2f12ee2419dmr92074271fa.38.1722332888543; 
 Tue, 30 Jul 2024 02:48:08 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.157])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36416e2esm14273357f8f.0.2024.07.30.02.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 02:48:08 -0700 (PDT)
Message-ID: <db1d3c5c-918b-4aa5-b68a-020c168cf05c@linaro.org>
Date: Tue, 30 Jul 2024 11:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725172220.GA989285@bill-the-cat>
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



On 7/25/24 19:22, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> Prior to applying this series, the lwIP stack needs to be added as a
>> Git subtree with the following command:
>>
>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> 
> This is better than v4, and on the hardware platforms I could build and
> boot on (which was most of mine except the am62x_beagleplay), the tests
> ran and completed, including the tftp+boot a Linux kernel.
> 
> The bad news is CI blows up, a lot:
> https://source.denx.de/u-boot/u-boot/-/pipelines/21764

They're all failing with: undefined reference to `tftp_start'
The reason is I inadvertently removed the 'default y' on CMD_TFTPBOOT :/
Fixed in v6.

> And:
> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/build/builds/9014/logs/106
> which is another Kconfig dependency problem. I don't _think_ I
> introduced that, but since this wasn't against top of tree, I had to
> apply the cmd/Kconfig patch manually.

What's the build command? I can see:

/bin/bash --noprofile --norc /Users/runner/work/_temp/9710a6d2-6670-4f76-81bc-990cc45b1898.sh

...but that's not super helpful ;)

> 
> I have my world build running still and may have more comments based on
> that.


Thanks,
-- 
Jerome
