Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2803DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 11:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBE9886E1;
	Thu, 30 May 2024 13:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="upElKJWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFAB886E3; Thu, 30 May 2024 13:42:57 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C92D88499
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 13:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UBgoe2086414;
 Thu, 30 May 2024 06:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717069370;
 bh=AUxF3sTIoRrFurxebgYpUsW6TmPj/G3OUj09o62iFw4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=upElKJWrGRpcosOaDPBqAlC90SL9R+jz39hnx2lQgrzKZr61Kj7Xqk4E2uqbg/rll
 XW/1sGPxJy2NGwMyF3nNzGi8pdA1b76Sg6F8N/0iqGaqb2ZHPB4d4AAqhp8DzKjgwK
 ea/cxVwfyC0IXIvjfC1PhvMuBGQFkha4S0M3hZWo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UBgoSK127917
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 May 2024 06:42:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 06:42:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 06:42:49 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UBgheL009971;
 Thu, 30 May 2024 06:42:44 -0500
Message-ID: <d684873b-e9c8-4fae-9b5e-2b91e953f806@ti.com>
Date: Thu, 30 May 2024 17:12:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm: mach-k3: am62a_qos: Move common bit MACROS to
 k3_qos header file
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-bhatia1@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, <joao.goncalves@toradex.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>,
 <sebin.francis@ti.com>
References: <20240522113726.302908-1-j-choudhary@ti.com>
 <20240522113726.302908-2-j-choudhary@ti.com>
 <d444e122-59d2-44eb-9dde-fb8ec373920e@ti.com>
 <20240522230659.GK2568172@bill-the-cat>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240522230659.GK2568172@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Tom, Andrew,

On 23/05/24 04:36, Tom Rini wrote:
> On Wed, May 22, 2024 at 10:21:28AM -0500, Andrew Davis wrote:
>> On 5/22/24 6:37 AM, Jayesh Choudhary wrote:
>>> QoS bit mapping are common across all K3 SoCs so move those defines
>>> to common header file (k3_qos.h).
>>> This ensures that we do not define these for each SoC.
>>>
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> ---
>>>    arch/arm/mach-k3/include/mach/k3-qos.h | 74 ++++++++++++++++++++++++++
>>>    arch/arm/mach-k3/r5/am62ax/am62a_qos.h | 74 --------------------------
>>>    2 files changed, 74 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-k3/include/mach/k3-qos.h b/arch/arm/mach-k3/include/mach/k3-qos.h
>>> index e00e1de5b9..6ed5704803 100644
>>> --- a/arch/arm/mach-k3/include/mach/k3-qos.h
>>> +++ b/arch/arm/mach-k3/include/mach/k3-qos.h
>>> @@ -9,6 +9,80 @@
>>>    #include <linux/kernel.h>
>>> +#define QOS_0	(0 << 0)
>>> +#define QOS_1	(1 << 0)
>>> +#define QOS_2	(2 << 0)
>>> +#define QOS_3	(3 << 0)
>>> +#define QOS_4	(4 << 0)
>>> +#define QOS_5	(5 << 0)
>>> +#define QOS_6	(6 << 0)
>>> +#define QOS_7	(7 << 0)
>>> +
>>> +#define ORDERID_0	(0 << 4)
>>> +#define ORDERID_1	(1 << 4)
>>> +#define ORDERID_2	(2 << 4)
>>> +#define ORDERID_3	(3 << 4)
>>> +#define ORDERID_4	(4 << 4)
>>> +#define ORDERID_5	(5 << 4)
>>> +#define ORDERID_6	(6 << 4)
>>> +#define ORDERID_7	(7 << 4)
>>> +#define ORDERID_8	(8 << 4)
>>> +#define ORDERID_9	(9 << 4)
>>> +#define ORDERID_10	(10 << 4)
>>> +#define ORDERID_11	(11 << 4)
>>> +#define ORDERID_12	(12 << 4)
>>> +#define ORDERID_13	(13 << 4)
>>> +#define ORDERID_14	(14 << 4)
>>> +#define ORDERID_15	(15 << 4)
>>> +
>>> +#define ASEL_0	(0 << 8)
>>> +#define ASEL_1	(1 << 8)
>>> +#define ASEL_2	(2 << 8)
>>> +#define ASEL_3	(3 << 8)
>>> +#define ASEL_4	(4 << 8)
>>> +#define ASEL_5	(5 << 8)
>>> +#define ASEL_6	(6 << 8)
>>> +#define ASEL_7	(7 << 8)
>>> +#define ASEL_8	(8 << 8)
>>> +#define ASEL_9	(9 << 8)
>>> +#define ASEL_10	(10 << 8)
>>> +#define ASEL_11	(11 << 8)
>>> +#define ASEL_12	(12 << 8)
>>> +#define ASEL_13	(13 << 8)
>>> +#define ASEL_14	(14 << 8)
>>> +#define ASEL_15	(15 << 8)
>>> +
>>> +#define EPRIORITY_0	(0 << 12)
>>> +#define EPRIORITY_1	(1 << 12)
>>> +#define EPRIORITY_2	(2 << 12)
>>> +#define EPRIORITY_3	(3 << 12)
>>> +#define EPRIORITY_4	(4 << 12)
>>> +#define EPRIORITY_5	(5 << 12)
>>> +#define EPRIORITY_6	(6 << 12)
>>> +#define EPRIORITY_7	(7 << 12)
>>> +
>>> +#define VIRTID_0	(0 << 16)
>>> +#define VIRTID_1	(1 << 16)
>>> +#define VIRTID_2	(2 << 16)
>>> +#define VIRTID_3	(3 << 16)
>>> +#define VIRTID_4	(4 << 16)
>>> +#define VIRTID_5	(5 << 16)
>>> +#define VIRTID_6	(6 << 16)
>>> +#define VIRTID_7	(7 << 16)
>>> +#define VIRTID_8	(8 << 16)
>>> +#define VIRTID_9	(9 << 16)
>>> +#define VIRTID_10	(10 << 16)
>>> +#define VIRTID_11	(11 << 16)
>>> +#define VIRTID_12	(12 << 16)
>>> +#define VIRTID_13	(13 << 16)
>>> +#define VIRTID_14	(14 << 16)
>>> +#define VIRTID_15	(15 << 16)
>>
>>
>> This all seem like it could be made into some macro, something like
>>
>> #define K3_QOS(qos, orderid, asel, epriority, virtid, atype) \
>> 	(qos     << 0 | \
>> 	 orderid << 4 | \
>> 	 asel    << 8 | \
>> etc..
>>
>> Then use that instead of raw values. That might also make it more clear
>> we are setting the other values to 0 when we are setting these registers:
>>
>> .val = K3_QOS(0, 15, 0, 0, 0, 3),
> 
> This sounds good to me too and to be clear, move in one patch, clean up
> macro follow-up patch in this series.
> 

Okay so 1st patch will be similar to this.
And in the next patch, macros will be defined and cleanup for
arch/arm/mach-k3/r5/am62a/am62ax_qos_uboot.c will be done in an atomic
step.
Rest of the platforms will be added after that.

Also, just for clarity, this implies changes in k3-resource-partitioning
tool which would be generating these files.
So is it okay to post v2 with manual changes here and then picking up
the changes in the tool later according to the final file template that
we settle on?

Warm Regards,
Jayesh


