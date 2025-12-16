Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE815D637AE
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FDF83A24;
	Tue, 16 Dec 2025 22:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YPgLorhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8D383979; Tue, 16 Dec 2025 20:45:18 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E38D8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 20:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4129725E97;
 Tue, 16 Dec 2025 20:45:16 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arPCTvPE6YQZ; Tue, 16 Dec 2025 20:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1765914315; bh=0O+omfXG76/djbHWFJv5rmsMs1tEEgdpsW+3lMriFeo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YPgLorhZSadYY5Iyw1qhgfNkE8gKXnyQ4ff4HhFs2ethAzU90TjW/SI1jMI1Nt45o
 GWCOugbhwdf329Scmlv4x0teteq3hiA//apSozfaKYVij4BZ3HS3pq8lqjWbwL2pmw
 G/Jm10mSS+DRSS/StJ0zLeCcCvwlVrparUaRuF0CY7WyKCYNuJ9QrY4htzukKpI9zV
 yLZJNDimpS2X+4Tx/pzsIqIZvf3LYXAsBbW/eM62d5zyfdZW0+GPjsHjHQCnDqs0dZ
 seO+D+L0HW6M64IyN0p/1HNJxSNCDe9FasVXViGZRUjz3iNzehscChe6ezOjbAe13M
 Yj2YMzJoD62Ew==
MIME-Version: 1.0
Date: Tue, 16 Dec 2025 19:45:14 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Minkyu
 Kang <mk7.kang@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc3-generic: allow fallback of dr_mode property
 to "otg"
In-Reply-To: <a9c78f0b-ec57-4af6-b577-3c6570d31b7a@mailbox.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
 <a9c78f0b-ec57-4af6-b577-3c6570d31b7a@mailbox.org>
Message-ID: <ee7311712c5f02582a5f126a299f4a8d@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 22:20:31 +0100
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

On 2025-12-16 11:13, Marek Vasut wrote:
> On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
>> Documentation [1] states that the default value of the dr_mode property
>> is "otg". In this driver however, this case is not handled. Add simple
>> logic to fall back to USB_DR_MODE_OTG if its reported to be
>> USB_DR_MODE_UNKNOWN.
>> 
>> Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> How does the driver end up with "unknown" state in the first place ? What is triggering this problem ? (this should be in the commit message)

When dr_mode is not defined in the device tree node.
It isn't marked as a mandatory node, and defaults to OTG. That's the
reason in the commit.

I will add this info in the commit message then.
