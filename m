Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD221C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2589287D91;
	Thu, 21 Mar 2024 20:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R0Ezp00s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SrzMK6VG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA93880F8; Thu, 21 Mar 2024 20:38:14 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE4087CB7
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 20:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V0wjc0LV7z9sTK;
 Thu, 21 Mar 2024 20:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711049892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zbzk8BsF7lITshqZCvRI9CvJGXEKy15KEp8VtG1TeFo=;
 b=R0Ezp00slUEXuIgrf0kABxW+r50Roan8B6SdefIf45ek7FP//lwcSs8dZy1zXuy7xVPaYP
 flWGgx6dQ/C8OlGnYUiIGLHIh4PvTJOyOaKvE+1mHjkJhcMkZZFraoK8ZjtX40g4cpfBC7
 Q0NL05g7MV4eq1E10DjgrE/SusLWtpZj527yZ4yVhXianOZVhBkRB0e3hYpc+mp4EVDcgO
 l/bPMs4miW51aCvWt7pPj/BtcWrU0Rl/6vB5cVXf1t3PyOciZ1qwnNm2ot/dbJlmNPEHLp
 YLvnlwcqNsRkY3f0/6/YIZG+9NjUCpFp5p3xKmQajvCrjto1sgsRllBKzz6UoA==
Message-ID: <ca4dfdf7-810e-4569-a594-095da8820d5b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711049890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zbzk8BsF7lITshqZCvRI9CvJGXEKy15KEp8VtG1TeFo=;
 b=SrzMK6VGo2Oz/OasHv9qFpTFp/C1wDz04Vg425IjC7EaHN9mAIOhAIESqgioUs1Fnc32TK
 yvCeFuovRa52j0Quz2ZTjEu9qOCMg8MaIRnJAHziS20ROoMwX22eAmPZ8hdu6UZYBz0Qhr
 Ys4REkF3IiWxI5Bfy+4vIRZjuF+5ZSmG5sibe1vvQDPlHtcpFLAN8b7a5wSeUdQs3EySld
 NrlrI7AdfUBMOGvXgi9+5+zelWuEeXz+GLBiSGrkKN4rCjuUWA8abiuFK3qeEttsHVwGr8
 1QSS6CBdNeeq/X4ZQr/SKdktxMQDA+8BYiMawsgRgDKK614k8BQLIus6WKlsHg==
Date: Thu, 21 Mar 2024 20:38:07 +0100
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
 <3fd317b9-6bbb-4ef2-b806-9e364b4e06de@mailbox.org>
 <9bb30db8-08d1-49bc-b89a-6c3bd4d898db@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9bb30db8-08d1-49bc-b89a-6c3bd4d898db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a98d2c1a59a8708b171
X-MBO-RS-META: 1dfcunsbwd47wtyx6xz8e6xcmpyfz3jn
X-Rspamd-Queue-Id: 4V0wjc0LV7z9sTK
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

On 3/21/24 6:05 PM, Caleb Connolly wrote:
> 
> 
> On 20/03/2024 20:18, Marek Vasut wrote:
>> On 3/18/24 1:47 PM, Caleb Connolly wrote:
>>>
>>>
>>> On 17/03/2024 04:42, Marek Vasut wrote:
>>>> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
>>>> this into DWC3 driver. The OMAP implementation is special, add new weak
>>>> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
>>>> handling should be called, and override it in OMAP DWC3 code, to repair
>>>> the special OMAP interrupt handling code until OMAP gets switched over
>>>> to DM UDC proper.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> Thank you. If you have a hardware with DWC3 , can you please also test
>> this series ? I am afraid this may break things, although it is likely
>> to break mostly select MX8M boards.
> 
> heh yeah it looked like it would be fine for qcom, but better safe than
> sorry :P
> 
> Thanks for the ping.
> 
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # qcom sdm845

Thank you!
