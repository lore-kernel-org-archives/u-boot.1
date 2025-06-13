Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1230C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 09:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAA5807B1;
	Fri, 13 Jun 2025 11:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L8NaixVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EE0808AF; Fri, 13 Jun 2025 11:22:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC6B800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 819225C4117;
 Fri, 13 Jun 2025 09:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A4C4CEEB;
 Fri, 13 Jun 2025 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749806556;
 bh=rBP8VTrcjfrE8OZk7TVH4KJYXP0WmnKufCaNj/W0QWM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L8NaixVoVw2J5jwImPL3v3g8yC2m677mHjwVkqUBxFCvWeyjeL0YeFyL8UGgtxEtB
 Yk/9sAaYWDcdstEjj//QgGnSn+2dcnp2bUF9WtOszK7B1r5ggruZ8R8BVM15fJGF0+
 rken7TgQjSsRrL9TtPivvjsd4p5Q/SyZdirnKIFFRuS4nCOaZEw/Uy0K1wB5dpQmEm
 9d3Zpgja15jxZ6/g1CXigEPBID4aPKkpL+7F5AhMdiTQlhmxRTPmSINu5aMP0yfXCN
 LoW09NSxl+IUf158T/mlQx2DzEuuex+aEx26PcRn3Jy/TIGAE0g3Vy+IfCSi4IV8k9
 QjIiVDcNY49pg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
In-Reply-To: <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org>
 <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
 <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
Date: Fri, 13 Jun 2025 11:22:34 +0200
Message-ID: <87tt4k3sit.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jun 04, 2025 at 16:10, Zixun LI <admin@hifiphile.com> wrote:

> Hi all,
>
> The case has been reported with No.01589331.
>
> In brief line high-impedance is not observed when both PULLD_DIS &
> DETACH bits are 1:
> - In unenumerated state (no cable attached) DP is still pulled up
> - In enumerated state, disconnection is not detected by host [1] [2]
> only by [3].
>
> The test has been done in 3 ways on SAM9X60-Curiosity and AT91SAM9G25-EK boards:
> - Modify UDPHS_CTRL on u-boot-at91 with mw command
> - Modify UDPHS_CTRL on
> linux4sam-poky-sam9x60_curiosity-headless-2024.10 with devmem2 utils
> - On linux-mchp 6.6, comment out gadget_udc_start/stop in
> soft_connect_store() of drivers/usb/gadget/udc/core.c,
> leaving only gadget_connect/disconnect. Then run echo disconnect >
> /sys/class/udc/500000.gadget/soft_connect
>
> Host used:
> 1. AMD Ryzen 5800H native port, Linux 6.14
> 2. Intel i7-8750H native port, Windows 10
> 3. Genesys GL3523 hub attached to [1]
>
> Zixun LI
>
> On Jun 4, 2025, at 11:51, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>>
>>
>> On 6/4/25 11:20, Mattijs Korpershoek wrote:
>>>
>>>  Hi Zixun,
>>>
>>>  Thank you for the patch.
>>>
>>>  On Mon, Jun 02, 2025 at 17:45, Zixun LI <admin@hifiphile.com> wrote:
>>>
>>>  I'm surprised that checkpatch.pl does not catch this, but the subject
>>>  (title) is too long (it should be less than 70 chars):
>>>  https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-message-conventions
>>>
>>>>
>>>>  Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
>>>>  does not always drive the DP and DM lines to high-impedance. This
>>>>  prevents the host from reliably detecting a USB disconnect and subsequent
>>>>  reconnect.
>>>>
>>>>  The symptom is that the first gadget command (e.g., dhcp) succeeds, while
>>>>  subsequent commands (e.g., nfs) fail.
>>>>
>>>>  Disabling and re-enabling the controller entirely, instead of toggling the
>>>>  PULLD_DIS bit, reliably generates a disconnect event.
>>>>
>>>>  The Linux driver works correctly because gadget_disconnect/gadget_connect
>>>>  are always followed by gadget_udc_start/gadget_udc_stop. In U-Boot
>>>>  pullup() is used solely.
>>>>
>>>>  This behavior has been observed on the SAM9X60-Curiosity and
>>>>  AT91SAM9G25-EK boards and has been reported to Microchip.
>>>
>>>
>>>  I'm not against this, but the driver supports multiple gadget
>>>  families according to the compatible.
>>>
>>>  I'm wondering if this issue is reproduced on other atmel
>>>  boards that are supported in U-Boot.
>>>
>>>  Eugen, have you noticed the above limitation on a different
>>>  board family that you maintain?
>>
>>
>> I have not seen this before, or don't remember about it.
>>
>> Adding Mihai from Microchip team to see if we can get more info, whether
>> this is a general gadget thing or it's specific to these chipsets. If it
>> was reported to Microchip it would be interesting to see the response.

Mihai, Zixun, do you have any update on case No.01589331 ?

I'd like to pick this up and some point so please keep me informed.

Thank you
Mattijs

>>
>> Eugen
>>
>>>
>>>  If this issue is chip specific, I think we should test for compatible in
>>>  usba_udc_pullup() to only use USBA_ENABLE/USBA_DISABLE for this
>>>  particular compatible (microchip,sam9x60-udc).
>>>
>>>>
>>>>
>>>>  Signed-off-by: Zixun LI <admin@hifiphile.com>
>>>>  ---
>>>>   drivers/usb/gadget/atmel_usba_udc.c | 9 ++-------
>>>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>>>
>>>>  diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
>>>>  index f9326f0a7e7d913bcf201ba3e4aeca9a099e7be7..a38e70957402fb3ade3de611d73e29b990d00703 100644
>>>>  --- a/drivers/usb/gadget/atmel_usba_udc.c
>>>>  +++ b/drivers/usb/gadget/atmel_usba_udc.c
>>>>  @@ -521,16 +521,11 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>>>>   static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
>>>>   {
>>>>    struct usba_udc *udc = to_usba_udc(gadget);
>>>>  - u32 ctrl;
>>>>  -
>>>>  - ctrl = usba_readl(udc, CTRL);
>>>>
>>>>    if (is_on)
>>>>  -  ctrl &= ~USBA_DETACH;
>>>>  +  usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>>>
>>>
>>>  Could we add a comment in the function as well? Something similar to
>>>  what's in the commit message:
>>>
>>>  /* Some chips don't reliably drive DP/DM lines to high impedance when
>>>   * using the DETACH/PULLD_DIS bits.
>>>   * To ensure a reliable disconnect, power cycle the controller instead
>>>   */
>>>
>>>  Feel free to rephrase your preference.
>>>
>>>>
>>>>    else
>>>>  -  ctrl |= USBA_DETACH;
>>>>  -
>>>>  - usba_writel(udc, CTRL, ctrl);
>>>>  +  usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>>>>
>>>>    return 0;
>>>>   }
>>>>
>>>>  ---
>>>>  base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
>>>>  change-id: 20250602-pullup-83c5540db5cd
>>>>
>>>>  Best regards,
>>>>  --
>>>>  Zixun LI <admin@hifiphile.com>
>>
>>
