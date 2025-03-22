Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26044C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 23:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B50881A0C;
	Sun, 23 Mar 2025 00:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HPJIe78w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF728197D; Sun, 23 Mar 2025 00:31:14 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D3880C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 00:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZKwYV0sYQz9scX;
 Sun, 23 Mar 2025 00:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742686270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TDdX+Ps695FCI6W9KP+ayHGfW0DF/Y6aLV4WBt9J8Y=;
 b=HPJIe78wLdpibeaMkX3a0HRvnyfPhCN0ZKiq0rnoU0HgYmnFEIEfksikH4RndxbfL+mI+I
 r1k86sf/UKn5+JbC36we5r3jTZN53T8LHXDQRBr+onUqGgq5SqxZDlsG6lCtFWNUIfdxBL
 /57KFPAGPmMaQZPM1xaoUtUu/n94Izt7J/lMoPIcEe6m/4as9JcqQyp+SyFL5hyFHvlicF
 LIuM3fBPUEa9MGiFVhOHC9aBCyQIhDdMI8QczdueV8gLuA+XgmwRKpf7xorSX6EFMHE6/x
 10k8EWpeHLGFVRyWruR8HnqLXE63lDcPmMJeJHBHfWOGqneYS9g18G7fDmib7g==
Message-ID: <94f1042d-df9e-4864-bae2-e69a257df88d@mailbox.org>
Date: Sun, 23 Mar 2025 00:29:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V3 1/6] imx: imx9: Imply IMX_TMU
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-2-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250322183812.784676-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oy9rroueprpnsi9q9xumc3w78obh64pr
X-MBO-RS-ID: 6ecd832d9f860095620
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

On 3/22/25 7:38 PM, Adam Ford wrote:
> If the CPU Information is displayed from imx8_cpu, it displays
> the cpu temperature grade and operating temperature if
> CONFIG_IMX9 is defined. This behavior is similar to what
> happens arch/arm/mach-imx/cpu.c except that the latter
> checks for CONFIG_IMX_THERMAL or CONFIG_IMX_TMU.
> In preparation to make imx8_cpu act like the previous
> implementation for any CPU, make IMX9 imply IMX_TMU, so
> it will be always displayed unless a user decides to
> disable it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
