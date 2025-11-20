Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19156CFA454
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8318405F;
	Fri, 21 Nov 2025 00:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eFOpF5Zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D987E840AE; Fri, 21 Nov 2025 00:24:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D25C83F80
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dCDv42BSVz9tNJ;
 Fri, 21 Nov 2025 00:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763681040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDgQmczYvXFbnF/nqM2wYoKT4Jm4AWrT0a0LPhgLJGc=;
 b=eFOpF5ZoRGYQmt+XtKyroz8+QQ3a6mU+ModY5Srfz5UNaZhbvrwZtQ6Px5pyosTCcMn1sW
 gZbWg+gxs4r4fO0EGA9MdwbyF5xhXESov5nvnbYsLD7XQ0zvXyzCIUfLyv3lB6wgCbQ2pG
 XT4MAxkLB63CWL7pZha/eRH4iIV6iX3TG0sqltfJfQvqt4OHQUigFKXvh0+uwVZe1UbRKR
 mI/6i1bA8aSkHOv2U1dd0qakhKZ0AS56myaeNORU2g2rinZzDt3pmzjxOpkEsoJKOLK+zm
 MFd/G/b6cpaVFeKEm6rtrEPBrcKXWaQ4gHxDQ+CwBpxWdhENgQa+F117kXLv5A==
Message-ID: <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
Date: Fri, 21 Nov 2025 00:23:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
To: Tom Rini <trini@konsulko.com>, Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251120212909.GQ2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7f6e9e1d8e9ee750d37
X-MBO-RS-META: ros3y1i375f7jxjkizmcsqo3dtrb61yz
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

On 11/20/25 10:29 PM, Tom Rini wrote:
> On Thu, Nov 20, 2025 at 11:42:53AM +0100, Markus Schneider-Pargmann wrote:
>> Hi Tom,
>>
>> On Tue Nov 18, 2025 at 3:08 PM CET, Tom Rini wrote:
>>> On Tue, Nov 18, 2025 at 11:40:28AM +0100, Markus Schneider-Pargmann (TI.com) wrote:
>>>
>>>> Currently once a driver matched the compatible string of a device, other
>>>> drivers are ignored. If the first matching driver returns -ENODEV, no
>>>> other possibly matching drivers are iterated with that compatible of the
>>>> device. Instead the next compatible in the list of compatibles is
>>>> selected, assuming only one driver matches one compatible at a time.
>>>>
>>>> To be able to use the bind function to return -ENODEV and continue
>>>> matching other drivers with the same compatible, move the for loop a bit
>>>> to continue the for loop after -ENODEV was returned.
>>>>
>>>> This is required for ti-musb-host and ti-musb-peripheral which both
>>>> match on the same device but differ based on the dr_mode DT property.
>>>> Depending on this property, the driver is either UCLASS_USB or
>>>> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
>>>> function and returning -ENODEV the other driver can probe instead.
>>>>
>>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>>> ---
>>>>   drivers/core/lists.c | 62 +++++++++++++++++++++++++++-------------------------
>>>>   1 file changed, 32 insertions(+), 30 deletions(-)
>>>
>>> This seems like a big generic change (with potential performance
>>> impact?) for a rather specific case. I assume the linux kernel simply
>>> doesn't have this issue by handling OTG differently. So is there some
>>> other way we can handle this here?
>>
>> I didn't find a nice way to do this differently. I did have a different
>> idea to do this by overriding the compatible of the parent node of the
>> usb devices. But I didn't like that idea so I proposed this solution.
>> But I would be happy to hear about other ideas.
>>
>> For the performance part: I don't think this reduces performance in most
>> cases. This will only add overhead through additional iterations if a
>> driver with a matching compatible has a bind function that returns
>> -ENODEV. In all other cases this should not add any iterations to the
>> loops. Grepping through the code a bit, I don't think returning -ENODEV
>> in bind() is widely used at the moment.
> 
> OK, thanks. I guess barring someone else having a better idea, we can
> try this direction.

I didn't fully grok the discussion, so please pardon my ignorance. But 
isn't this matching exactly the same problem that is already solved by 
Renesas RPC drivers ?

drivers/mtd/renesas_rpc_hf.c
drivers/spi/renesas_rpc_spi.c

Look at rpc_hf_bind() and rpc_spi_bind() implementation there, which 
selects which of the two drivers binds to the controller and which does not.
