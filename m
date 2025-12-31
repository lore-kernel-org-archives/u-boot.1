Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52D1EE644A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 21:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0943D84183;
	Wed, 31 Dec 2025 22:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jNIcAzpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C6584164; Wed, 31 Dec 2025 22:29:03 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA5284097
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 22:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dhNPQ4WKvz9sl4;
 Wed, 31 Dec 2025 22:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767216538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=777IYtrq55pG/qCpJL4DJtU7XzV1Q1C5jKWpI0E2rkw=;
 b=jNIcAzpgwi6b4YS+u57zXD1p1uBuCraZs/997ZnQgjv8Yx8r6elkcLKysc67lKC6nkogoY
 dxbf4hmoyNwCina/3vTwFdpQc2cimFd49qb2/J5NYVA/kd8GzjMwVKvW2oqYLwOhd8IwU4
 IIdcoIHGjuYE1T0bHO1L3OrzK1QBmH25PVErnE2MjPvP6XovbktLpqdoS2PiHa/7sTKObX
 krUghVi3LcLNisD4xlR/BS9JPLtOpEqlcc6smAnpKyNwdTxayxeSg3pQ4SWlK+9OcWhZLK
 gxXKwOwPqDiNgKQ09AEYsi0H2aT0Q1kTNYO3KusrOUABS4yB0kh8Q4o+r6YhWQ==
Message-ID: <da02bdbb-11e8-4375-95f9-fc142a3b838b@mailbox.org>
Date: Wed, 31 Dec 2025 22:04:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: dwc3-generic: allow fallback of dr_mode property
 to "otg"
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
 <a9c78f0b-ec57-4af6-b577-3c6570d31b7a@mailbox.org>
 <ee7311712c5f02582a5f126a299f4a8d@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ee7311712c5f02582a5f126a299f4a8d@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c8ba4df54b3a8a49453
X-MBO-RS-META: cw7hk8t1c74qbp7gcuhixcmeaoat83cm
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

On 12/16/25 8:45 PM, Kaustabh Chakraborty wrote:
> On 2025-12-16 11:13, Marek Vasut wrote:
>> On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
>>> Documentation [1] states that the default value of the dr_mode property
>>> is "otg". In this driver however, this case is not handled. Add simple
>>> logic to fall back to USB_DR_MODE_OTG if its reported to be
>>> USB_DR_MODE_UNKNOWN.
>>>
>>> Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> How does the driver end up with "unknown" state in the first place ? What is triggering this problem ? (this should be in the commit message)
> 
> When dr_mode is not defined in the device tree node.
> It isn't marked as a mandatory node, and defaults to OTG. That's the
> reason in the commit.
> 
> I will add this info in the commit message then.

Understood, thank you for the clarification.

+CC Ilias, I think Jerome was also syncing DWC3 recently ?
