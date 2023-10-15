Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06386CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 19:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D2C86BA4;
	Sun, 15 Oct 2023 21:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mprS0Gl/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s+7WS9bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5555B8657B; Sun, 15 Oct 2023 21:05:52 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284278652F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7qSS5zyKz9sn1;
 Sun, 15 Oct 2023 21:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697396712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAfw2eklyF1T5ovlRjyHV2K5A6HfEgwHRXdaX4fRKiw=;
 b=mprS0Gl/vd/cBSyqAFNj5oePGwsgwXB3EzzPvBWzKEL3JfGURPuEOLhDrb5SBT+LtzDz9N
 v+LUwFLed+hFnhx6CSvK6F1QZbatZetFBWSMq24vUqGl7K0/gg9sTggkuIlYgQEKw4ltnr
 BtnOps3dQJCoVfo8zq9jd7/J8+ljbj0ZblXr68cktBaLIAjk0f6cocQ/CG7qM0SQG2FxHb
 CTqWoEtxs3fPUMpqlcpDB0NLwvWinLiD58v/oreGaZIDdk+UwUwV7DglWWpLwIAFgkk1hL
 y07Dy5Cjuxv5GNr1XIXI7J/uWarl2TqF9Np2g8rRUkkrQDvFelBA6MEfh/AIHA==
Message-ID: <5fb89b3c-322d-49e2-b71f-a4289d925bd6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697396711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAfw2eklyF1T5ovlRjyHV2K5A6HfEgwHRXdaX4fRKiw=;
 b=s+7WS9bk8Se7bzSaOsPRYI67OJAxc5y2IH16a/0A8u1vOGEj89p79I9LT5pY52dIyNMr/f
 PQPlQIiulA5MZcePT/37PT0ZXUB5J9RwL4a6PyvNkWe+Y7ELndiTzN5zA5+xzlZdepaTVh
 0ePmVKF4wJizEYO3eDLVJ15tsExURcWbs5byExROZlNauaMbrht4wg2MmS72kffLCXGw4N
 FrKiHis2Hx+lXTml3N8ohd5D9AUp2sjAUJAsNttvzYHEu1ScupktgQJw9l38cQSn/nJDHB
 kE0mRID6Eo19PQIuRCq+Eqw4zhVXpKInpoflQYaukQ+/f67pYlW6tGl9za2Xew==
Date: Sun, 15 Oct 2023 21:05:09 +0200
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
X-MBO-RS-META: sjq5cjsusjmu5gy1qg4dr9p54two3ij6
X-MBO-RS-ID: 1789eb8fa0c9b3183d0
X-Rspamd-Queue-Id: 4S7qSS5zyKz9sn1
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

Much appreciated, thanks !
