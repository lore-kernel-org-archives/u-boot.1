Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F04F8A157
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 11:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F426840AB;
	Thu, 16 Apr 2026 13:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RkwnzroA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0D2841C2; Thu, 16 Apr 2026 13:09:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C888407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776337753; x=1776942553; i=xypron.glpk@gmx.de;
 bh=Sg4+1Lg/q7SUphUeVUQEntNMrKbVOZKNplk0dRLfyxQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RkwnzroAmt5MvyB5U1lbjU+s0QlVvXgI2HCmsuiJNaeN325JM+RvEnj6S6oWns/W
 GR4b7jDC9Fx7kgZ5C3ZRdAg4AEniJ+JzX5s6p6lGq/63EBXLRmvyRn2EcZL9e8Hu9
 KGSWqbCWaOWOqcm1Ga1ELl0CnPqKjRuHgMHfWlsEI52wobUyS+QI4qCuDledzeTed
 zcmx6Wg4yJY2SMDCf3V4qceX8tqIpYVKlHolVTjow3gQisoL8Marv41V5oDhYPQNy
 QcqUEA2Ceyx4ixhy0raFhqFhlYPbEm08nvvZRAMuGxydLZ7s5u16s/1V6a1YjlTy3
 UsRcpX0yRCMj3Qqkzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1vJdHT1HJW-00vNUI; Thu, 16
 Apr 2026 13:09:13 +0200
Date: Thu, 16 Apr 2026 13:09:10 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, rs@ti.com
CC: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, 
 anshuld@ti.com, bb@ti.com, trini@konsulko.com, afd@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCHv3 1/6] lmb: allocation flags macro documentation
User-Agent: Thunderbird for Android
In-Reply-To: <CAC_iWjLR+wZB6G5p7uMDcv516YkNMhvUaFNdyd68Kc44Nai7uA@mail.gmail.com>
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-2-rs@ti.com>
 <CAC_iWjLR+wZB6G5p7uMDcv516YkNMhvUaFNdyd68Kc44Nai7uA@mail.gmail.com>
Message-ID: <3E092F53-F932-47FC-AE5A-1EB992D54F61@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S9iqC2IkV1/+rRfSLucDXdeL8cgjME+Y3voEu510ILf7DLNHD2Z
 DRnnbtiup9Gifl5LGAsw5Z3s50lImPz/WPBTF4wMUfQb8JkiERhAqVciQSV4VxFkRRBQMwV
 T1oyyw7sTE7HBQrtvEv15AHTr8vdOvjD6dpspfAw9scvZTpp0cDNE6hR/QNgpDdrV4vnsix
 b9vOtje06swFLhiZweqEA==
UI-OutboundReport: notjunk:1;M01:P0:8f57S0LXLFM=;l5AF/aPikIykgLa8YowFrKku2IE
 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
 qulzsJ9T1qd9hHg==
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

Am 16=2E April 2026 10:30:32 MESZ schrieb Ilias Apalodimas <ilias=2Eapalodi=
mas@linaro=2Eorg>:
>On Mon, 13 Apr 2026 at 23:36, <rs@ti=2Ecom> wrote:
>>
>> From: Randolph Sapp <rs@ti=2Ecom>
>>
>> Update the allocation flags inline documentation to follow the kernel
>> object like macro documentation=2E
>>
>> Signed-off-by: Randolph Sapp <rs@ti=2Ecom>
>
>Reviewed-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>
>> ---
>>  include/lmb=2Eh | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/lmb=2Eh b/include/lmb=2Eh
>> index 5d5f037ccb9=2E=2E427d701bc30 100644
>> --- a/include/lmb=2Eh
>> +++ b/include/lmb=2Eh
>> @@ -19,16 +19,36 @@
>>  #define LMB_ALIST_INITIAL_SIZE 4
>>
>>  /**
>> - * DOC: Memory region attribute flags=2E
>> + * define LMB_NONE - no special request
>>   *
>> - * %LMB_NONE: No special request
>> - * %LMB_NOMAP: Don't add to MMU configuration
>> - * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserv=
ed
>> - * %LMB_NONOTIFY: Do not notify other modules of changes to this memor=
y region
>> + * LMB Memory region attribute flag to indicate that there is no speci=
al
>> + * requests for this region=2E Normally used as a placeholder value=2E
>>   */
>>  #define LMB_NONE 0
>> +
>> +/**
>> + * define LMB_NOMAP - do not add to MMU configuration
>> + *
>> + * LMB Memory region attribute flag to indicate that the region will n=
ot be
>> + * mapped by LMB=2E Normally used for reserved regions=2E
>> + */
>>  #define LMB_NOMAP BIT(1)
>> +
>> +/**
>> + * define LMB_NOOVERWRITE - do not overwrite/re-reserved

%s/reserved/reserve/

Best regards

Heinrich

>> + *
>> + * LMB Memory region attribute flag to indicate that the region will n=
ot be
>> + * overwritten or re-reserved=2E Normally used for reserved regions=2E
>> + */
>>  #define LMB_NOOVERWRITE BIT(2)
>> +
>> +/**
>> + * define LMB_NONOTIFY - do not notify other modules of changes
>> + *
>> + * LMB Memory region attribute flag to indicate that the region will n=
ot notify
>> + * downstream allocators (currently just the EFI allocator) of changes=
 to this
>> + * region through lmb_map_update_notify()=2E
>> + */
>>  #define LMB_NONOTIFY BIT(3)
>>
>>  /**
>> --
>> 2=2E53=2E0
>>

