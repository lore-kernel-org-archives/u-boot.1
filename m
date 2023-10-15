Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F93CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 19:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA10865A8;
	Sun, 15 Oct 2023 21:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hkbyVNve";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oARSzMQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3737C8657B; Sun, 15 Oct 2023 21:05:11 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCFF8652F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7qS815pTz9smn;
 Sun, 15 Oct 2023 21:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697396696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iq8Rd8dVbOX4rq8WQhyEHQWCZxEsxzGQA5WqwWc/ipQ=;
 b=hkbyVNve461arhVutSsl1HVqqkUfSQNVhfgoLHDIo0/rRTP3rDvj3GxSKg36OazgSVp/u0
 SzrdP3SNbxkvkvH1qIUrcvBqIZhhNJOl5mIzEpfB3Bfmi0/WzoGg/IvxRErc7bZ790EcZF
 OBHmfrxV1+heGNYU1kZMxOFXs8pWnrmV+84ctAG4XguSf/cthMV3CjU9ay6Baz1Xoe37k/
 u7u8BiKL9sTrpoQZipz+fPnkfXciDrbjX9ysoakGLAYYmRB4l1QR8EbjCmHPnvfIayF5iG
 jOa/DJu7q3qxNYPLfjvsh47k5cGu+q8SqJ/fIjVamNrxh3J6I+cB568X9s8b1Q==
Message-ID: <6925efc1-0ffb-4ce3-b284-f670158a4f43@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697396694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iq8Rd8dVbOX4rq8WQhyEHQWCZxEsxzGQA5WqwWc/ipQ=;
 b=oARSzMQLp9i682ZH2O/oO4HSegJ9PhDx2cTrnqL5QmPhNft8lGWhdZ7uewdDbJ888VDQq/
 ZstrvjC1ylBcs3BX12MTyYpWABXEnQXivPbQGsqifzmXSsEbKZ1OF0lDBXwR3lLLrTWNjh
 UF0uXhQLgradtlXM0dwbA9OHlTQ8YttDHLLbEAyv008FslR4jj8t2Hethm3gM8p0s9nYxW
 KvgI1d7WQR98nNEcIrxRMFffF+zF/GvTsmDIXaDbL2RFg/I19yL/lQxBvoSoy64e/zw/my
 GWu8mz6BtZKkMoNHctF0PiM8lvmu8qlGzAB9lKPg92AOrWs8lGWXKeVznl7KfQ==
Date: Sun, 15 Oct 2023 21:04:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 12/19] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham
 <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
 <4beeef07-6cdc-4f34-8ed1-5ba31c36f04c@mailbox.org>
 <20231015175938.rf2wnvpgpyrn56cz@GBR-5CG2373LKG.adwin.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231015175938.rf2wnvpgpyrn56cz@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1jp99a5s47wxzxkwhf4oj3oj7s5hpthy
X-MBO-RS-ID: 451f30d44dfb92d14ac
X-Rspamd-Queue-Id: 4S7qS815pTz9smn
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

On 10/15/23 19:59, Paul Barker wrote:
> On Sat, Oct 14, 2023 at 09:53:53PM +0200, Marek Vasut wrote:
>> On 10/9/23 18:46, Paul Barker wrote:
>>> Extend the existing driver to support the SCIF serial ports on the
>>> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
>>> relevant reset signal is de-asserted before we try to talk to the SCIF
>>> module.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v1->v2:
>>>     * Moved handle_error() changes out to a separate patch earlier in the
>>>       series.
>>>     * Unconditionally de-assert the module reset during probe.
>>>
>>>    arch/arm/mach-rmobile/Kconfig |  1 +
>>>    drivers/serial/serial_sh.c    | 17 +++++++++++++++++
>>>    drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>>>    3 files changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
>>> index c30ff2caad17..c421181c89cf 100644
>>> --- a/arch/arm/mach-rmobile/Kconfig
>>> +++ b/arch/arm/mach-rmobile/Kconfig
>>> @@ -77,6 +77,7 @@ config RZG2L
>>>    	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>>>    	imply PINCTRL_RZG2L
>>>    	imply RENESAS_SDHI
>>> +	imply SCIF_CONSOLE
>>>    	imply SYS_MALLOC_F
>>>    	help
>>>    	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>> index 2b650d458e71..6ea8da34d434 100644
>>> --- a/drivers/serial/serial_sh.c
>>> +++ b/drivers/serial/serial_sh.c
>>> @@ -17,6 +17,8 @@
>>>    #include <linux/compiler.h>
>>>    #include <dm/platform_data/serial_sh.h>
>>>    #include <linux/delay.h>
>>> +#include <dm/device_compat.h>
>>> +#include <reset.h>
>>
>> Please keep the list sorted.
> 
> The existing include list isn't sorted, so in v3 I'll add a patch to
> sort the list first. Then these two can be added in the right places.

Thanks !
