Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBC2C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E43D81197;
	Wed, 29 Jul 2026 12:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wemRMh09rhp9; Wed, 29 Jul 2026 12:27:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 758A281187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328070;
	bh=FpzJcYXvZ1LKBNDHISQ3E1ulw8CNo1+sNLgpnVVnAwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKZId0tw4amOvuit5R6gQJsRmwssmMn49z+p7xrY+Ys1YDZedMqdZV73f+udrEeoO
	 mdk7EfIpl/VtrRIv5g7IQQPS2LyIec4igjl+z2YVKIQYbbL4uIucuLtlwVyToC3UkR
	 C5g1rWD2/ETKNG8vhogllpuAcHCL/yXlmiXJIHRx71/c2wgO08Cj4sqzyMiSFbKp7G
	 PnKRY3y8ExrFidurcyFVWJdpWxvFvvg0di3QET+BEyNJ/xED3D0uPZamF1lr2YnMFH
	 V1LsNp3NGaQ/RtrnVt9lgjvFXYsow3p0mXVoGkVixzH9e8b1scfKBWqaNxYSsyV7Zx
	 RHuE7ibbg+JJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 758A281187;
	Wed, 29 Jul 2026 12:27:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AA42194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 459C14025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgPoP0tI0Kgq for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:27:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 238F840074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 238F840074
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 238F840074
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:27:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D363A8493F; Wed, 29 Jul 2026 14:27:44 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBA482991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:27:42 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 030D3600B1;
 Wed, 29 Jul 2026 12:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F2A1F000E9;
 Wed, 29 Jul 2026 12:27:39 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Anders Roxell <anders.roxell@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 68/75] usb: dwc3: make gadget and ep0 build in u-boot
In-Reply-To: <20260716134305.614278-69-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-69-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 14:27:37 +0200
Message-ID: <87ecgmx9om.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785328060;
 bh=FpzJcYXvZ1LKBNDHISQ3E1ulw8CNo1+sNLgpnVVnAwk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=WILSQZN+8Jmmpb9GXQk+oZ/sv5sIbNEKWcodI2AluGDotwktr/JkZYVPfJPNMLz3H
 SmvV8+/dQerYRQIrTpD+BKiVsj8sE5iIHtrkBZ/RF2rEnWqiEkkkhB44NmVKN1xGbG
 /Y/mcfzmJwMxx8L2Gb1rpAd3mwbtqjL2FfQ/N2RN1axPkYX8QeV1ToZLA2xP7Xb24l
 0aRr05LvzVoUr1UTSViAVGNXVCVobjGukyuwhvRsCp5D5NhwTrbSbbDySWHZQaEzWv
 NdSBqCFfBqcdCgpgSja7tkKqAP69aYeNVEBpXbrrlj4vMna5xz2EwmwDf3We9Qnd5A
 +BDo2LLxQmlxQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WILSQZN+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WILSQZN+"; 
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

> Adapt the DWC3 gadget and ep0 code to u-boot after the resync.

Similarly to the previous patch, I see some functions that are moved
around in the gadget.c file, making the diff bigger than it should be.

Please re-arrange things to keep the diff at a minimum so that review is
a bit easier.

I've not done a thorough pass on this one because of the above.

Thanks
Mattijs

>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/dwc3/ep0.c    | 110 +++---
>  drivers/usb/dwc3/gadget.c | 786 ++++++++------------------------------
>  drivers/usb/dwc3/gadget.h |   4 +-
>  3 files changed, 207 insertions(+), 693 deletions(-)
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 666ac432f52d..0a4f69cbc28a 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -1,4 +1,3 @@
> -// SPDX-License-Identifier: GPL-2.0

Why the licence drop?

>  /*

[...]
