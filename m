Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85368C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 09:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F568800D;
	Fri,  7 Jun 2024 11:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YLwbZcJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD08788020; Fri,  7 Jun 2024 11:11:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC37488009
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 11:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4215afa33b7so17775685e9.2
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717751510; x=1718356310; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0XxHBnGMqxopLxFNT3WOWA1+5xv+MIqgQOKzmgIytk=;
 b=YLwbZcJcT2nRpKPaNECKwiEVaPMgrxrS+lagJHzgGu4IaiEkddSz33qwH7FpUViv4n
 Hqi1bX/bTgwW4amGZ9yfc6QUXbcMLscw+sx9wMlu2pcpQj6BkTgdRUiKGXThqFZPrgaA
 gd+zgCOas/4WxLRTxN492HtlhL66I3fUEtjLv7JKomxNMhjowD1SOdVIzSs4ifR7Q2AM
 lQYm8UpkQXCz6eTyADYKFzz4NEiGQvO1WUYqld67bNAXpLhHXowM5+Ep7HfAeZroGwC7
 l248hyKT8C3SguVvBubTyVahxzh4b2Bm9d8+Y3U6OZP2BD0rxzruLKt4DUkIj7Jo1PSk
 cW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717751510; x=1718356310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0XxHBnGMqxopLxFNT3WOWA1+5xv+MIqgQOKzmgIytk=;
 b=K1R1YIJbhvNPnu4vavB6fhKzZ3W3umOxi3m2q08auMijHUImL+MswAsyxw1p5r4cIx
 nKd9dg4xoe4LsI/nm6kEKQ/DYiAcIjaLwin3SfpH4qbi3CXk+O6h5uR0tCzX9GqZQvNy
 YxNE/Q+gWmIoCCRNJ2Y6VxxLw9ciiRb3/Exo+zOw2ptZ8+IBxntAPTSE2P/Nhe763j9J
 HGrI+U6uA2fk0+jB00b9v867/Te6eaj98z7k4fBZ5q/IBwD/96hgWpLZWtrllV8ot7bn
 ovNsTFsTEAsGZ1mP+n6+VP9sNq0cFbT2eYvYnyQC2668pQGQKXLbJURNMTqt77HESSJl
 lLlQ==
X-Gm-Message-State: AOJu0Ywd7BXPWfKKDiZ38ZT2AfIkR+YGucUSW9KpOZjNjDUXFPT/jFm/
 HrSt7mkPzFxuqv82xFaWMOGEqbDJnzXb5F5VDkXZt+qdSF/hH+LBCvTsgYnzOc8=
X-Google-Smtp-Source: AGHT+IGMz0aOe9xplGjA2mpgO/LERVQ3CEZQDo5UopbaUHvDK0cLN+iXGabonSR24cMJKTpsFXdDgw==
X-Received: by 2002:a05:600c:444b:b0:420:29a8:ff5e with SMTP id
 5b1f17b1804b1-42164a0c1c9mr17842085e9.19.1717751510199; 
 Fri, 07 Jun 2024 02:11:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d685c9sm3575996f8f.53.2024.06.07.02.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 02:11:49 -0700 (PDT)
Message-ID: <97621d9f-584b-41f9-98e9-c6e4346661a5@linaro.org>
Date: Fri, 7 Jun 2024 11:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <20240606165634.GB68077@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240606165634.GB68077@bill-the-cat>
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



On 6/6/24 18:56, Tom Rini wrote:
> On Thu, Jun 06, 2024 at 03:35:55PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>> has some additional lwIP and Mbed TLS patches to do so. With that it
>> becomes possible to fetch and launch a distro installer such as Debian
>> etc. using a secure, authenticated connection directly from the U-Boot
>> shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
> 
> Alright, on Pi 3, I think we have more "output changed, test fails"
> problems:
> ========================================== FAILURES ===========================================
> _____________________________________ test_efi_fit_launch _____________________________________
> test/py/tests/test_efi_fit.py:452: in test_efi_fit_launch
>     launch_efi(False, False)
> test/py/tests/test_efi_fit.py:394: in launch_efi
>     net_set_up = net_dhcp()
> test/py/tests/test_efi_fit.py:178: in net_dhcp
>     assert 'DHCP client bound to address ' in output
> E   AssertionError: assert 'DHCP client bound to address ' in 'Waiting for Ethernet connection... done.\r\neth0: smsc95xx_eth b8:27:eb:fc:64:a6 active'
> ------------------------------------ Captured stdout call -------------------------------------
> U-Boot> usb start
> U-Boot> U-Boot> setenv autoload no
> U-Boot> U-Boot> dhcp
> Waiting for Ethernet connection... done.
> eth0: smsc95xx_eth b8:27:eb:fc:64:a6 active
> U-Boot>
> =================================== short test summary info ===================================
> 
> I'm going to skip that set of tests and see how far we get but I suspect
> it'll keep failing on DHCP output being different.

As discussed offline with Ilias it might be a timeout issue, although 2000 ms
for DHCP_TIMEOUT_MS seems a large value to me, it might not be enough in your
environment. Can you please try to increase it? NET effectively has a timeout
of 28 seconds if we take the retries into account.

Thanks,
-- 
Jerome
