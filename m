Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D39C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 03:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161B1805C8;
	Fri, 21 Mar 2025 04:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742529511;
	bh=WctdROsQbKj/RzM/fwJ5LBLNoKnI539MeDT1tEZn4oU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k1zJyptZTbEMr/uza+TIRr3MNCD9cufuzhb71qOqFzeIVtGC4lBQZHgDpgjO7zPE2
	 RL2hYELSK6CHOHzF4TcqfKfHYs301jPqOWkOnAI4/528T7EyYzfqKA3mFUIv3HaFVk
	 w/MsZvvjmj77wuQoJGv7Gke+/UIasP/HgA2eNEHdmj0oJ78QtymjvSQTyJsH2G+ZN2
	 jHrNPBk4FZQz4jj72l/Bqho0NQ+FSCola6ohsBFOHQzI1FgSbuYp1VAWJPPBblC8/Z
	 2YxWUKANy/03qUjzePVygtvZWnmaLukGlOUW2JdWu2K7ZQnNck8e5dBassllbv2/dQ
	 uPRxQ6NGWj3IQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CCD805C8; Fri, 21 Mar 2025 04:58:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754D9803CC
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 04:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Mqfvn/hT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 724B1101E9152; Fri, 21 Mar 2025 04:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742529507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WctdROsQbKj/RzM/fwJ5LBLNoKnI539MeDT1tEZn4oU=;
 b=Mqfvn/hTzLTulcSvvgsFSpN2C76wLCtL9vBwtff/U0xyD94D+KRvgGbZAteiOQL4vSm3tO
 Oc0BSA4hG1jKyhwbwiRcYA/a5WKHIgivPYKH2akqHQDSoAgt4FSVUd9o3Y62wyHxJlUa1S
 lW+Iamsz3ginV7G0+u3XYTA1QUtD9Jy09HLnslrEZhIKn0cAfQ3CZYKRQCBmOAoInWEUry
 SlOqac2u+aRuhsiA0CED94yFaK9m8oe1ydMDkgZxahdnwuyLHIwgF1yvyF/zmiPaLhYEI6
 Kp8fMezwxXfivyFNnx6BP1c0JU45Ljgre2Xduv5oELULOHG72YINZfmhkWDnkg==
Message-ID: <1fb4a575-b9c5-4c20-9479-d0bffc6e6945@denx.de>
Date: Fri, 21 Mar 2025 04:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20250317113627.84885-1-minda.chen@starfivetech.com>
 <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
 <SHXPR01MB086382C94AD9C7988302D1B0E6DE2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SHXPR01MB086382C94AD9C7988302D1B0E6DE2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/18/25 2:02 AM, Minda Chen wrote:
> 
> 
>>
>> On 3/17/25 12:36 PM, Minda Chen wrote:
>>> Add USB related file to Starfive visionfive2 MAINTAINERS.
>>> The N: pattern can override this.
>>>
>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>> ---
>>>    board/starfive/visionfive2/MAINTAINERS | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/board/starfive/visionfive2/MAINTAINERS
>>> b/board/starfive/visionfive2/MAINTAINERS
>>> index 898e284ce2c..f1d2deb9f5c 100644
>>> --- a/board/starfive/visionfive2/MAINTAINERS
>>> +++ b/board/starfive/visionfive2/MAINTAINERS
>>> @@ -3,5 +3,6 @@ M:	Minda Chen <minda.chen@starfivetech.com>
>>>    M:	Hal Feng <hal.feng@starfivetech.com>
>>>    S:	Maintained
>>>    F:	drivers/ram/starfive/
>>> +F:	drivers/usb/cdns3/cdns3-starfive.c
>>
>> What about using 'N: starfive' instead to match on all files which include the
>> string 'starfive' ?
>>
> Maybe other IC code will be upstreamed. It is not me to maintain
OK, in that case please put this USB controller maintainer line into the 
top level MAINTAINERS file, since this is a generic driver, not a 
board-specific one.
