Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A1EFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FEF8444B;
	Sat, 25 Apr 2026 20:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hsnCgKea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC2D84399; Sat, 25 Apr 2026 19:58:08 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4475584099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8ac9ef74131so135809966d6.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777139885; x=1777744685; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ph+f5ABkVpMeWqfR1FGh2+ygMigLETbQXYWSM37BU9I=;
 b=hsnCgKea2QFObLP7dH5fwaZZrqpwuHx3en8w+RgEi/Xng7XnrORItZAxmu8KO8LKLV
 08MKA/s8/JOMsqgMrxe+B7IrPHd1eL4mTMPsMXICjhJSbI4X2uY2VImu3ziSRMBILnYI
 yQdx6irff3Kff2suzwCoYPNs0jGsFZalTYhDOJydWHLXRd4sJ4SFHZ+/v5AU9dI9d79W
 yH/qIPpYzvMIpc7T2k5iALSzu9EoNBTHbfbySlvI6PL+My6+j8o6jnDJ12/gTGS9CkCa
 +oCFz6XJ45Fj501VVb9PEHGR28kfGA5iJrm/LHoHIlDRq5p11sm019y1QNTR9a3vy2bX
 8OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139885; x=1777744685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ph+f5ABkVpMeWqfR1FGh2+ygMigLETbQXYWSM37BU9I=;
 b=F5fxo/90++EjbXVpUm3OBvIIzr4T8M+gThGByeZReJGfhm2D0Ho0NwAdAEaBydnS5P
 7NccP7QBCpkGt+fjyuJXEYFbSpLC8hdAYyRecFQ3HHp7JOsOO5WUDtQxtmYfEvoN43DT
 gUJi5o+x4PinZ7IFMgq0CIQr/4PQgbBqz2hXDrkdEWL2aPS6ZjukBrDsfN3JL2x0f8Er
 AMXuF7i5PZ42ngdP9aqRGmtyTWne0fkcCElW9vwNH3khBkHfQ/hTE0PQ5KyVJdWOsVku
 VVYTFBnC0/JZ9cxLZl5lAEyBorwn2x2NM3e0oc9P0DwkkN5/WOjOpclJPeoIjtJ6qQxB
 Wbog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+//lOZcuFlFbCZSvJ4M+1hKKX6lbg/V1Z9/qC57BxRsVbAJMOknShDd420FkLskHrlellCwGY=@lists.denx.de
X-Gm-Message-State: AOJu0YxHLwbwJ+BAZIOIDQlB3aXmIYJ0F/gZzYxHc8quP0TKebTbXyiZ
 NIs7ZVkLfgeYphxIUzu6pUwCUAyTL+50Z1m/NdPXRFMFTHeCqe0X+VHlM5suTQ==
X-Gm-Gg: AeBDiete/1i+/BSIEZqLmqf0/fkYYm+QMufmWHc5qRJ1gc0mbFRm7yIEsA8GDjHSI6M
 vi/jPsCUaLVStDinoBm7+tQal9Ik4EFZww4xlDsTadVD7H3CjnRTlLT5TEYCbpDc7ipxSqDi97I
 hfvCxIcVKkot7jWXB4apDSlByvEQLZNVtqkCAfd6xKdZzqJZ3SEu2mh+99LDMXqtDaUvB+LqV/c
 iyAWOiIzox2nLH8HkGxr6Gqk7cUsGN1tO7p3lxTAuVSc/C6bWPUupAIX6QS7eVzl4d+6K4n4hdL
 Vmc2BxgPhD5sP0z6o224oIg4r62Cr9U39xcsCD9TLSpiC5YUL4fnRaaPRiCKKmh3lnU4+6WFS1Y
 o1kCdnJYWNoak7Hd23WwdXhGsk05DMLOfrsIEhCynRbpHVFpAkSGrr0CW0uYkkPARb914KElglP
 d5BvghoBIiEMAPMzaoCFdLPnakvnSDDzQLNiTZJpUWYxVzJ/yHZu6n0246QX/WoR4aypZcYNimv
 BZ5NEHgV4u5SjqdtLcB9+ujYR1e6X6T
X-Received: by 2002:a17:902:fc90:b0:2b4:678c:5f1f with SMTP id
 d9443c01a7336-2b5f9d65af2mr215238975ad.0.1777050088206; 
 Fri, 24 Apr 2026 10:01:28 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab4049bsm211595275ad.77.2026.04.24.10.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 10:01:27 -0700 (PDT)
Message-ID: <6e64fc81-e0ea-4161-935a-16ba3aa8ba0a@gmail.com>
Date: Sat, 25 Apr 2026 01:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] sandbox: dts: add PHY common props test nodes
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com,
 ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-5-lucienzx159@gmail.com>
 <CAFLszTifgNBs+jxh1f+XxropHkKmtp27Bv7k1o3t8vDFpwehfA@mail.gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <CAFLszTifgNBs+jxh1f+XxropHkKmtp27Bv7k1o3t8vDFpwehfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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


Simon Glass 於 2026/4/11 下午 10:38 寫道:
> Hi Lucien,
>
> On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:
>> sandbox: dts: add PHY common props test nodes
>>
>> Add device tree test nodes to arch/sandbox/dts/test.dts for the PHY
>> common properties unit tests.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>>
>> arch/sandbox/dts/test.dts | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> @@ -16,6 +16,7 @@
>> +#include <dt-bindings/phy/phy.h>
> Are PHY_POL_NORMAL, PHY_POL_INVERT, and PHY_POL_AUTO in an upcoming
> subtree merge?

Correct. I used tools/update-subtree.sh to merge the latest DTS tag into 
U-Boot.

Thanks

> Regards,
> Simon
