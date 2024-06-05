Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310FCC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 18:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395C488096;
	Wed,  5 Jun 2024 20:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fjO/qnis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB9B088356; Wed,  5 Jun 2024 19:48:29 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FF3879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 19:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dceef429bso16978f8f.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717609707; x=1718214507; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zF5Hm/7tVmTlU8SNyItXB5afRXMnwupk8D61gNGjYoE=;
 b=fjO/qnisPUvo3jGaarkkT9yWQfglVRqYTXsn0Wgqv5ebE5VmTFqsHZxvE+13qdqVKj
 0hDf4nO3jnHzw+aMUPPSBB42i0wunVuMzLIAPpDpWBPN6k9IHPpiYBsq5QcCp1+Vo2de
 ii+aBQY7fmGFlhrZsF6QaYosByEd2mT62cPOWas6p8jPtCdKIJshnSzlkZje/CVm/FQo
 hLbvgC7bOQNh/Fi96x30ZUiw7RDtQV3rMU6g7mZiJ0RKPnp0XrMwD7IptPIrVRuIR7fO
 Sq0lt2mHnIxV/3Xwhd3SxaldTBlcT3kGdSkpGdUMQWjxBbakogjNIglBh9Z1V///RiPR
 +e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717609707; x=1718214507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zF5Hm/7tVmTlU8SNyItXB5afRXMnwupk8D61gNGjYoE=;
 b=G1dfZ/wck8DH3E6u8gebPBqhBdSA3NOLsfkNLN/H7khAQunf+JUhQIgGarULKV8XWo
 OQS0qN3CcMwKfAuHUaM3jVnIYI/CsQJXdPfhDrxqqMH3J3tM/mjbnk/h/YpilxOW/m0Q
 g10dmsLcSqaNrF8sHVtZmrWoQtjelMTr3K5Ms+5VGE7hP1X+XDtHDAeEWeLiegthlBvr
 JFxH9ITp/VnLhmVRFzF5XE1uoMjJl5AvzCLWAPlrQiYjmPjmt2Q5occL/azNTSZ10u9q
 sepC7ExQKHSeAAGW1G8yKmKQHNVPYwTPf0ii0QEE4rs2UZIFOo/U0gw+ZMdibtlJz2ha
 T4Qg==
X-Gm-Message-State: AOJu0YwMJbOiQz+xowYDwHYGZyopJgGtziq144t6HLETSypC0+urSrFx
 NyafpT8TDY2pqGS7LkGahmvcQrBMarZzXBkiEcBNkJPiyYDnfrhXRpc72CP7cKI=
X-Google-Smtp-Source: AGHT+IH3BhJw+Y7YuCKDjeEBSargXRf6giETCVVFhtCxhJCVQoYrRFaVHI3SEN4G7ZUtrhEgDWgB2w==
X-Received: by 2002:a5d:68c9:0:b0:354:c330:5d2a with SMTP id
 ffacd0b85a97d-35ef0dbd277mr257344f8f.35.1717609707052; 
 Wed, 05 Jun 2024 10:48:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07?
 ([2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da182sm15233268f8f.54.2024.06.05.10.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 10:48:26 -0700 (PDT)
Message-ID: <aefef4e4-5541-48b9-bad9-543409029a35@linaro.org>
Date: Wed, 5 Jun 2024 19:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] net: introduce alternative implementation as
 net-lwip/
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ion Agorria <ion@agorria.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <923f66b4a74d9c91c6d661e96dced8e1cbcdc7e0.1716566960.git.jerome.forissier@linaro.org>
 <20240527153434.GH2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527153434.GH2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 20:01:50 +0200
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

On 5/27/24 17:34, Tom Rini wrote:
> On Fri, May 24, 2024 at 06:19:55PM +0200, Jerome Forissier wrote:
> 
>> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
>> adding a new net-lwip/ directory and the NET_LWIP symbol. At this
>> point, enabling NET_LWIP simply disables NET. Subsequent commits will
>> introduce the lwIP code, re-work the NETDEVICE integration and port
>> some of the NET commands and features to lwIP.
>>
>> SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
>> that are part of NET (such as arp_init(), arp_timeout_check(),
>> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
>> added later.
>>
>> Similarly, DFU_TFTP is not compatible with NET_LWIP because it depends
>> on net_loop(), tftp_timeout_ms, tftp_timeout_count_max. Let's add a
>> dependency on !NET_LWIP for now.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> [snip]
>> diff --git a/Kconfig b/Kconfig
>> index 82df59f176e..758256ab121 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -747,6 +747,8 @@ source "env/Kconfig"
>>  
>>  source "net/Kconfig"
>>  
>> +source "net-lwip/Kconfig"
>> +
>>  source "drivers/Kconfig"
>>  
>>  source "fs/Kconfig"
> 
> I think we need to instead rework this to a choice statement instead so
> that in the end we have something like:
> choice "Networking stack"
> config NO_NET
>   bool "No networking support"
> config NET
>   bool "Legacy U-Boot networking stack"
> config NET_LWIP
>   bool "Use lwIP for networking stack"
> 
> if NET_LEGACY
> source "net/Kconfig"
> endif
> 
> if NET_LWIP
> source "net-lwip/Kconfig"
> endif
> 
> And then SPL_NET still depends on !NET_LWIP for now and we sort out the
> problems with different networking stacks in SPL vs full U-Boot later
> on.

Done in v3. Thanks.

-- 
Jerome
