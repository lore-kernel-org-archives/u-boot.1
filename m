Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B84EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 16:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E6F885A4;
	Fri, 26 Apr 2024 18:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147255;
	bh=2z1VTJJp5Naq/Adarg4mVSih2+BcH11vpMu0ESQH7E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+pFyW3sSzSHot1nKRQzgvoaQcg1guWzI5Tx3SKRE3p5GtRM1/UKDqra5mZWeWB2+
	 5SRYuYuIhHAennxv3mBv0Kciokct6bp8J3Ds3F00dp7BiaMmII7CMlCx+nQGHZNYz+
	 tCp2bx6afWxYy3hofaRBu4eIVl38GV0aCbpDU/hcExiZ6mwFXNpDR7xB7Eg2vA/uU4
	 3FUK3qHoEE/jhMBBbM5db4WEtGZ0NddPIhpb5Sxz/MEo9iWeg99Z9s07tMsS0qFiQu
	 y4q5uCHue5RU4AAk4V7aaA2JyTPi4zZRBkVzu8MKt44KLnoZMRtkwrQG4MICwoTs5p
	 VasCk/VH9bSUQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 34AA788505;
 Fri, 26 Apr 2024 18:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714147255;
 bh=2z1VTJJp5Naq/Adarg4mVSih2+BcH11vpMu0ESQH7E0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O+2zQfaTzYkdarMbSuI3Faev/0aUbyEmctDUqfo0FDqGZlJ2zZuOP6ZPMAujjfn5z
 fqDCkPfHh0/xhfo2SzHQKPUh2/zlJSv3ZnCEORQeVqC4ynOqobv0iEyxclJOlsFffS
 9/3e4D71GbIUMfcrSmgoAq27jU/T4Yo5rrcFTchgfcuMtG/iOCvi9Y8oUJbVKBo6xG
 GsQzza+ipgLA9m/AmNrBqfwtrxT2Jc6PMYQAzobrERhURgSePLnJEn4yL4CmekjPP3
 IrWWkj2G9VHbbdXBtXfwlca8h1wkUDG4XBRuKkC6+zHNMfoFUJBzcbOc4AnbUBZ+5B
 vrtaWqXlxseAg==
Message-ID: <e5745575-9ee4-4e35-a81a-634d5b399d02@denx.de>
Date: Fri, 26 Apr 2024 17:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
References: <20240426001419.1210364-1-tharvey@gateworks.com>
 <254b0fd2-0085-4894-bcfa-686c456e4e2a@denx.de>
 <CAJ+vNU0fRLnZ-DvA8-ksKZAXWsgtFt_qa7Bcifb=3xLzZDu8WQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU0fRLnZ-DvA8-ksKZAXWsgtFt_qa7Bcifb=3xLzZDu8WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/26/24 5:14 PM, Tim Harvey wrote:
> On Thu, Apr 25, 2024 at 9:07 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/26/24 2:14 AM, Tim Harvey wrote:
>>> eMMC devices have hardware partitions such as user, boot0, and boot1.
>>> Allow these names to be displayed when reading the mmc PARTITION_CONFIG
>>> field via 'mmc partconf'. Additionally allow a name to be specified when
>>> setting the PARTITION_CONFIG.
>>>
>>> Before:
>>> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x2
>>> PARTITION_ACCESS: 0x0
>>>
>>> After:
>>> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x1 (boot0)
>>> PARTITION_ACCESS: 0x0
>>> u-boot=> mmc partconf 2 1 boot1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x2 (boot1)
>>> PARTITION_ACCESS: 0x0
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>> ---
>>>    cmd/mmc.c | 25 ++++++++++++++++++++++---
>>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/cmd/mmc.c b/cmd/mmc.c
>>> index 2d5430a53079..26692a8e349b 100644
>>> --- a/cmd/mmc.c
>>> +++ b/cmd/mmc.c
>>> @@ -14,6 +14,18 @@
>>>    #include <part.h>
>>>    #include <sparse_format.h>
>>>    #include <image-sparse.h>
>>> +#include <linux/ctype.h>
>>> +
>>> +static const char *mmc_partnames[] = {
>>> +     "user",
>>> +     "boot0",
>>> +     "boot1",
>>> +     "",
>>
>> Shouldn't these be 'gp' partitions here ?
>>
> 
> He Marek,
> 
> Do you mean that 3-6 should be named 'gp1', 'gp2' etc? I couldn't find
> if those values were possible or have meaning.

Yes, General Purpose eMMC hardware partitions.
