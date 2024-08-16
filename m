Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCA6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 16:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D24C88618;
	Fri, 16 Aug 2024 18:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2soAGoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C959E88B6D; Fri, 16 Aug 2024 18:21:39 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4638852A
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3719398eafcso667847f8f.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723825286; x=1724430086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IIu91GM1o9Tjpoe+vCe614wbBbUiIJB+JAXjwlYnSl8=;
 b=Z2soAGoX6edK2kq3mXL1gVrVy/70mCJ/8Pd9Ftt16NXbvZuuR+NsTMkSzbY0UKIcZc
 a8FHEXxJ/wzB32lY8TRcUklFigvatGkkJKWBDuz0ElaLbYfn6PfmnbVTXHtW/xWB0f+c
 6G1a/Y0835qq4qPz4RuctzPARqFTDGlklsLB+fJlqY3hNXdWGRp/ITRHV40nXI8OWFSW
 3mjjHxh7j/ciB+y+bvA/f7HhWeVIlT30oeqbC6JuaMQBM2AhdlfdykOM2hnUfcOzP8hd
 TnyXE18xYuGixQSBaA9XI4SoVd/VE5YRh2z/jnVOuolNf33b6MWaVv1zHil1yR6vWNUc
 O2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723825286; x=1724430086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IIu91GM1o9Tjpoe+vCe614wbBbUiIJB+JAXjwlYnSl8=;
 b=NKnKLcdEoxYHUKGaOXES+Ifl/95Jkk2/rFKftnzJRVPBMRzDGs9PfuWzT+laPj5txv
 o9Dy3bTj3tRm6umQdigcD97JdDeH9hZGTmnI7Se3ibnpL6j1+eRfFJ65wGfIrGOZXfzo
 wlko6LZtCRBPhLN5kyk0ajH/kJAY5dBd7wVVZo6xdiD1f7oksr51m+R76j/gj1zlJ1kZ
 akeUmcNL5NAlDlVA1OG/7QhPmkJfZg7jnuz1AekRyYBejO+/cS8kHJfAQ3rzp2ydi22m
 DaDMRI/qUasQLJgNswaj+zgkGvJl62Ot1pkxAnJ/wGJbX4KI/9JOogzRXQPzsSJobyIr
 +Iiw==
X-Gm-Message-State: AOJu0YylxER4h+bkEKBNR9KB11I6yuhNBre9ox0Ekxq3pk3cUyKvI/o4
 4zBx3d34wAMl5AkhHQTtQRDGs0HzSVfKhqP1vdroY4+/aQznLU7XZ27hk+giF0w=
X-Google-Smtp-Source: AGHT+IEXTQHo0W1mf28+HYWnJdnh3VaQERMkdfR/00ybJ6LEFULzc3gD8QHGZZ2qjck7cFpvTtLAYA==
X-Received: by 2002:adf:f8c9:0:b0:36b:bb84:33e2 with SMTP id
 ffacd0b85a97d-3719465f62bmr2616721f8f.37.1723825285712; 
 Fri, 16 Aug 2024 09:21:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1dfa:e7ae:e33:dd21?
 ([2a01:e0a:3cb:7bb0:1dfa:e7ae:e33:dd21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aadc4sm3945895f8f.96.2024.08.16.09.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:21:25 -0700 (PDT)
Message-ID: <d9fe273b-ab60-44eb-bef8-cbde3af8ab1b@linaro.org>
Date: Fri, 16 Aug 2024 18:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240807204400.GJ1626301@bill-the-cat>
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



On 8/7/24 22:44, Tom Rini wrote:
> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
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
> For v9, I think it would be good to do a CI run with NET_LWIP default
> and seeing what fails from that too. There's a few problems still
> leading to a lot of failures, in that case. Thanks.
>

See here: https://github.com/u-boot/u-boot/pull/635

I fixed a number of issues, see the commit descriptions. As for the
remaining ones:
- There is no http server in the CI so the wget test I added fails
- tftp is super slow in QEMU (~145 KiB/s) which causes timeouts. This is
for two reasons: (1) the tftp windowsize option is not supported in lwIP
(while the legacy NET does support it) so the sender waits for an ACK
before sending a new packet; and (2) the latency is very high due to
memcpy() being incredibly slow in QEMU (I am mainly referring to the
memcpy() call in tftp_write() in net/lwip/tftp.c). I measured ~20-60 ms
to copy a few hundred bytes (!) and if CONFIG_USE_ARCH_MEMCPY is enabled
it is slightly better but not much (~15 ms). Also it seems the QEMU
networking emulation is fragmenting the UDP packets because with
CONFIG_TFTP_BLOCKSIZE=1468 the tftp_write() function never receives
1468 bytes but only a few hundreds at a time (max 544 bytes).
- The r2dplus_* tests fail for reasons I don't understand.

Thanks,
-- 
Jerome
