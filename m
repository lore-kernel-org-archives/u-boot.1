Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18500D36129
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 02:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DC488A1C;
	Wed,  6 Nov 2024 03:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GhZW3FfR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XIx4srmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D554B88D54; Wed,  6 Nov 2024 03:12:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C614A8852D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 03:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Xjpcx4LW0z9srB;
 Wed,  6 Nov 2024 03:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730859153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgRREMVu2z1WQu/izn1V8LHto/O2ukvepWQLOglhaAk=;
 b=GhZW3FfRzhefByxmrPEOXj/ZUTapPPvpWCoj1+4WI+IyUgEgF+LbQKcp119feIwKie+QCi
 b36ZhycFys9QxeuhGpLk7jWMBRaKq9WO+Ag1JatSRuunGddg9etmeiYSALV0Xg6E101GCW
 nh5Eg8ftjJyBFX4PjXGh6HZIZopIQbDGwa0Sk6zneNovI02j0kq0YHBGYucJW4tTqcnbMC
 30d9IcPkcyCD9CUxhUuU92ZkyPT4UcLHMtOpbnjLGcBY2LMcOkvcZiDiOFs5Hk6Jvk5EgT
 hGl3bjzIYWUDAfHyDHxQdlfEsaik3GZ+hUjmzT0IuOPSVGxFo7RI0Y/qV2M3Tg==
Message-ID: <09770590-c262-443b-955c-2b6dce7a75f0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730859151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgRREMVu2z1WQu/izn1V8LHto/O2ukvepWQLOglhaAk=;
 b=XIx4srmu9dFpe9RvKCh6ohhEyMjzto4f94d4wt0u5w0LQLw4fnb+kKpXcYc1ObV1ynDuX4
 dV/rmSrAyYCAjSHU1c+aLcye6fqvmw3owGzHzgRnF+3/UrGfH0La2d76HAor4S7qTUeIMR
 dXDN1dq90yMEOgxRVGZH60uLc8/bzyY2TaHYq6jVzD53wgNUwqKkNRaFWi4zvGQgEEx/i4
 nNDRmDe9E2IVD+qwoRtPKuVID6mX+T5GEUWHN55NqefAkY8svXsn6QBh0YI1tTvXLe7pNj
 ZvPWHLj3OZaXdhYsWCk1JxBGNWoAUF8DN5C71dXK/TTQwbDR0eDxgqqfIfozBQ==
Date: Wed, 6 Nov 2024 03:12:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: image-board: Mismatch a type between variable and
 return value
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com
References: <CGME20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849@epcas1p2.samsung.com>
 <20241105221149.507119-1-jh80.chung@samsung.com>
 <a3ad60cd-c8f4-4377-a30f-80f1530313eb@mailbox.org>
 <02ea01db2fdd$0799f610$16cde230$@samsung.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <02ea01db2fdd$0799f610$16cde230$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 600e1d35b830691ae89
X-MBO-RS-META: ispwpd89swgsjfy834wo7dwotkx1wrec
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

On 11/6/24 12:47 AM, Jaehoon Chung wrote:
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Wednesday, November 6, 2024 7:57 AM
>> To: Jaehoon Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
>> Cc: trini@konsulko.com; sjg@chromium.org; marek.vasut+renesas@mailbox.org;
>> laurent.pinchart@ideasonboard.com; m.szyprowski@samsung.com
>> Subject: Re: [PATCH] boot: image-board: Mismatch a type between variable and return value
>>
>> On 11/5/24 11:11 PM, Jaehoon Chung wrote:
>>> phys_addr_t can be used unsigned long long type with CONFIG_PHYS_64BIT.
>>> But hextoul() is always returning to unsigned long. It can be assigned
>>> to unexpected value. To avoid wrong behavior, change from hextoul() to
>>> simple_strtoull().
>>>
>>> Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")
>>
>> Looking at:
>>
>> 7e5f460ec457 ("global: Convert simple_strtoul() with hex to hextoul()")
> 
> Thanks for informing it.
> 
>>
>> do you have to update any of the other hextoul() calls too ?
> 
> I didn't check other hextoul().
> During booting with initramfs on RPi (32bit), I found the problem that is not working fine because of this.

Please check the other sites too, maybe there are more of these issues 
lurking around.

>> Maybe we need hextoull() ?
> 
> IMO, We need hextoull() for some cases.
> If there is no objection, I will send the patch for adding hextoull().
> And I will check entire cases.
No objection from me. Thank you.
