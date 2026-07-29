Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D99C54F52
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 065DC40888;
	Wed, 29 Jul 2026 09:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kg7CnpPz7BaK; Wed, 29 Jul 2026 09:41:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0806A40854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785318075;
	bh=LkkQWnGECtwlzUadKA4DPKlsv8KFLblu+8Xe32f+o20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wVMBOYekM//IdL4BU7KxNlsMYorA/iFhvNmQAAOZKhW3xI8FDn3MSPmxx7rblsFLh
	 ceC1675Ur9brB9S4McPSTPPEa/ECJOXJcDCnCSNRp/pMYc33CVzchrgj/XhID8CLkt
	 W/DGorNUYnj8HG6lKWTN6tPdEJ6PvrA8cRYwropnM+KVoKbZFbqop+/CITPW++tUjG
	 2zB+uzkIrtMa0w9T0wj5w+CC+qiFMyC5MPS7qncVxXRQUtjcf9ZV+QXiCqZPuzSfwY
	 Wyo1WTjEG9/+xwKXcqkp1CWH0QBbtKcBlcCh6OeScQCaVQA8orPaMEFX0ht+TVCA8z
	 1BaCo+Im5O1bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0806A40854;
	Wed, 29 Jul 2026 09:41:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B9A669
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F216F40854
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYy-d-TEie-0 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:41:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9770E40851
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9770E40851
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9770E40851
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:41:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153C98494B; Wed, 29 Jul 2026 11:41:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB828404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:41:08 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2875A417BF;
 Wed, 29 Jul 2026 09:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0281F000E9;
 Wed, 29 Jul 2026 09:41:06 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 63/75] usb: udc: re-import udc-core.c from kernel v6.16
In-Reply-To: <20260716134305.614278-64-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-64-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:41:04 +0200
Message-ID: <87se52xhe7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785318067;
 bh=LkkQWnGECtwlzUadKA4DPKlsv8KFLblu+8Xe32f+o20=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=fEgGn6q1u2p8EuDGZgiVhukpnvJ+0f8so7aKhO74yxVl8NagDXi9C0BkODktAfc1G
 bb9WIcrnDKKvo0rm7UPF4gETyTHAt+1qj8XfcS50F51BJCygeTUq9feqy+K2q/E1Nj
 NxUqQNUm9RyzmJdzk4dw3Kx9ugzO+rUOlfLQ9n2GkD54DQICBGVgszxbRaf0K48Btz
 uDG9PMA169jCG1MoHuY+N1POBmZDtqmRDiV1U1wCCFUWgCP5YahBZCN0Et3fI9h+CM
 2iTk5NQQej5YZd15wuj+F21MozJPAiULMQn1oIS8bWw6QfpMTZSlCXiXWt1rV8RJY2
 swLSdGYy4c2Mg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fEgGn6q1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fEgGn6q1"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jerome Forissier <jerome.forissier@linaro.org>
>
> Delete drivers/usb/gadget/udc/udc-core.c which was imported from kernel
> v3.19-rc1 and replace it with drivers/usb/gadget/udc/core.c from kernel
> v6.16. Keep the name udc-core.c for now.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c | 1889 ++++++++++++++++++++++++++---
>  1 file changed, 1715 insertions(+), 174 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index 6bb419ae2abc..d709e24c1fd4 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -1,35 +1,51 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> - * udc-core.c - Core UDC Framework
> - *
> - * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
> +/*
> + * udc.c - Core UDC Framework
>   *
> + * Copyright (C) 2010 Texas Instruments
>   * Author: Felipe Balbi <balbi@ti.com>
> - *
> - * Taken from Linux Kernel v3.19-rc1 (drivers/usb/gadget/udc-core.c) and ported
> - * to uboot.
> - *
> - * commit 02e8c96627 : usb: gadget: udc: core: prepend udc_attach_driver with
> - *		       usb_


I've file-compared with the mentioned Linux kernel release, and this
looks good to me.

However, in the previous patch (usb: host: re-import xhci-ext-caps.h
from kernel v6.16) you added a small comment to the file stating:

/* Imported from Linux v6.16 */

Can we please be consistent and do that here as well?

With that done:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


