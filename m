Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC873C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 06:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0358C60B83;
	Sat, 25 Jul 2026 06:22:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2HNVlHZ6idt; Sat, 25 Jul 2026 06:22:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3213660AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784960535;
	bh=qzUvKzjQMOG2yisAksvbHmK3mHtaYa//0SUt3FxI8dk=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nhtUZsJr5t9eYL4W9tUXQDbGNxj36ODLM2wjCj/FJZNdXHRCx3DakHm/yJ3mCXJvi
	 OLXZERaZwK5I7olMDtJE+V0dbhgn5OTSu+pFIVhXd9MaQQklfoa/O8KYAKDXa2ThNJ
	 HVe6sy375eU6zNiWIZHm6n+DB8Wc25hr1j3FaHYJ+NDlbeN2SSw4h3dVXBt4vH+EDk
	 aE+86f9VFQhNfJQC4DnwqZNsN0wA5lRH+xUCy7fxELZJOYNe5/qHDGWEMnD3a3RPNz
	 nO10BdwbqRuUlnpn3TmJdSKhQOWijQTkVGQxfooNfurh50/1rOC89QxfBrScablNbl
	 H6IpO0n6HLwWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3213660AF4;
	Sat, 25 Jul 2026 06:22:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92010490
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77E0D60AF4
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cio-_ozXGlRk for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 06:22:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 65214608A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65214608A5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65214608A5
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D90800AE; Sat, 25 Jul 2026 08:22:11 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906DF8005D
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 08:22:09 +0200 (CEST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h6ZX05z0lzKmsG;
 Sat, 25 Jul 2026 08:22:08 +0200 (CEST)
Message-ID: <8ac0dcf1-fb31-496a-b141-35d77983c3f8@mailbox.org>
Date: Fri, 24 Jul 2026 17:19:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
 <20260723-rzn1-usbf-v3-2-34dd7c4ddd99@bootlin.com>
 <32d38204-8f6e-4a56-923e-b73b08eec87b@mailbox.org>
 <31ghNLzIQOah4QfwbFFCUw@bootlin.com>
Content-Language: en-US
In-Reply-To: <31ghNLzIQOah4QfwbFFCUw@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hzwkbgknoudnoyck6nerjqi7eh3a8o9e
X-MBO-RS-ID: 6446cf6e8f9b56f9ef4
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784960529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzUvKzjQMOG2yisAksvbHmK3mHtaYa//0SUt3FxI8dk=;
 b=BR/6AjI8/RlD/nIxKQ/1j4NeCNEKRU12Chvztir9ULKfzT/vP2toSMZ7S2L8e3Hze1WmfQ
 DleSbZKc+LdfgfSgcpKZwF1zQs4jjpH6EHYlOxOCRXCwxWU62TwEw7GYCYv+O7X5suSHpR
 q/++y2ErFr38j48fI9/lWcZnznAEIwFlQlmrztacWh/bJYCi/b0SEiPRtJPt36SKYe2WHE
 w3yOVJYVGgg2zuA2B1UQo7IamiEOhvPqVx0KAF+IsysVU5TIn4FqWbuCSJJMF/qx753OFL
 TZJa6HkT4HfUJ2eTkRCB1tEpc2LGtkI2qmQLCfGS+08S4P8wdDs7Nteu5IRj1Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784960527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzUvKzjQMOG2yisAksvbHmK3mHtaYa//0SUt3FxI8dk=;
 b=G4a+6Zie4Dsj1PEGAbQHFd84+3XqbpYZIpuruWL72LfxfWJDOZDT94vXPssvrnMnIz3mq5
 CTpwyVJnmklAS9P2kxfBGuvPB5ikihIoIc1ORCF44wXp9r6uK3aDYD71RHqbAwWEbXcw14
 +yPX/Un4E3BCMvXfJ4E9e3u8siUWIyCVQblzM8ohxxgYiCrNrLCsgw+ARqNOPvTc8nwM/P
 FPG5etwE5YCyXj+vfwQuB2ZGF0JNWDKrjuJ/JM1l0srE1j9lCAxS48uoluUeQdLW+vPAwI
 ndVwDR3H9qK241JQnYFiwh0bgsUjDO248BpeRIJpW3i6YECXnKWCRjSz+YnYgQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=BR/6AjI8; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=G4a+6Zie
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="BR/6AjI8"; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="G4a+6Zie"; 
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/24/26 7:15 AM, Romain Gantois wrote:

Hello Romain,

>>> The following features were removed to reduce the memory footprint of the
>>>
>>> driver, and to avoid including features not relevant to U-Boot:
>>>    - Suspend/resume
>>>    - Handling of endpoints > 2
>>
>> The code seems to handle 3 endpoints ?
>>
> 
> Yes, I'm talking in terms of USB endpoint numbers here, so endpoints 0-2 are
> handled.
> 
>>> +/* Only handle the first three endpoints for now. This is sufficient to
>>> + * expose classic bootloader gadgets such as Fastboot or DFU.
>>> + */
>>> +#define USBF_NUM_ENDPOINTS	3
>>
>> But why not handle the additional endpoints ?
>>
> 
> Because I didn't see a major use case for them in U-Boot, and removing their
> handling allowed a reduction in code and program volume which seems relevant
> for U-Boot.
> 
>> Also, can you test whether 'ums 0 mmc 0.1,0.2,0' works to expose eMMC HW
>> BOOT partitions and HW USER partition as three separate UMS devices over
>> the same USB connection ?
> 
> Sure, I'll give it a try.
Thank you !
