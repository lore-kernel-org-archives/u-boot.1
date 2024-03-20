Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163E0C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DAD88010;
	Wed, 20 Mar 2024 21:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="durQZY01";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gKD/SBil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3928A880EA; Wed, 20 Mar 2024 21:55:47 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6BB8723E
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V0LTX6YMyz9snx;
 Wed, 20 Mar 2024 21:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lC9tE/VJcDeSYdJYjGLUhqO5+1efOcbTaWJeG9Ubwg=;
 b=durQZY01RdWMPS49qBj5tQpH5EdwKrFgGMUTm0aQrC0STsyvabi7tTtDKKKFIF5Lo8brNo
 LQoiEipJHx4wEiWq0EAUlHhxfU1sbla3CaEg5zD3mi6I/kuZ8dWwj68igb7Jm+Q/15l5Ze
 Tey9x4uQ1JARoivHQ3Pg8HR2Ge+vbTN/rIvDtCV0FEf5BsaPWV9r1Amuw/w/wMmVVMu5RQ
 z8OMp7nC6o7OtdZqn6VzlCriMzJk7OAZgY6YT/dYpZ6CHWi01sh6bXu5M2oP+3uCM8toUN
 ZUjsXQ6nfprJm+0046ffXfwV1MzTTOVHwHl1QdK+c4//SPQWxCi8SK26jWDKxg==
Message-ID: <3fd317b9-6bbb-4ef2-b806-9e364b4e06de@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lC9tE/VJcDeSYdJYjGLUhqO5+1efOcbTaWJeG9Ubwg=;
 b=gKD/SBil7pdKNMvpGtTpjUj8RP1L5E8q1MFX+4ZRJHETrce06TkUc1ahBAUQqrWNWJTyvq
 ADUlMiXriJB78Zdaw9olp+DWPTWJYl8tEqj7DUDUcsFd8wYhJ8r3Z52IWzwzpr40WfxhMc
 6vDnunRM2CatEmnZ46Q78Pkl5wZ2/kiKa13XitG6KZhaP33FrbE73Rc5ndTBr+nD8n3QB0
 6+6w7lgfrNmk9NrXr2sWxWVTuCC5lKoq+1Putuy4EGwQKwYLE1Msp+8zgCZm6Vm5MZCepP
 VKC8/ey615vA4DJa9uZwSFvPbGCm/gqjznY4FjVGFJKBC1tRe5tdG6BpGVklYw==
Date: Wed, 20 Mar 2024 21:18:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
 <b20f5e01-d45c-402c-90e2-9593558bbeaa@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b20f5e01-d45c-402c-90e2-9593558bbeaa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 20c02a0d29cccf4afa7
X-MBO-RS-META: wjh6tzjnnt8qn3oygedpxn1c99d9bhng
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

On 3/18/24 1:47 PM, Caleb Connolly wrote:
> 
> 
> On 17/03/2024 04:42, Marek Vasut wrote:
>> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
>> this into DWC3 driver. The OMAP implementation is special, add new weak
>> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
>> handling should be called, and override it in OMAP DWC3 code, to repair
>> the special OMAP interrupt handling code until OMAP gets switched over
>> to DM UDC proper.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thank you. If you have a hardware with DWC3 , can you please also test 
this series ? I am afraid this may break things, although it is likely 
to break mostly select MX8M boards.
