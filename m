Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97640C28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C0180756;
	Fri, 21 Mar 2025 02:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z5sNdROB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ch7RrN70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326E0807D7; Fri, 21 Mar 2025 02:55:23 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCCD8003E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZJlrj4sSjz9sQm;
 Fri, 21 Mar 2025 02:55:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742522117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue/tG1FX+Gv/YbiGDgI5pXPeJAraoTsZKeQEYBYw/GM=;
 b=Z5sNdROBn5Nk5RLtJVfJNqy640UUfCfBbQurrV6ovkEldzRLXFT+dQzSc49DJPDc4dliz2
 vBalMpFHqNgEi6SVSOjbKf+KC8AEPpoImq4ddbb3O5iPVM6TCDLe0/0R3MOTLQsAdBwvDT
 dK1Q8XbzBWCwS/DMMhvak42+pn18qcRgWMv+//2ZkujiyIQToYYxAIffWXR5+BSnkYACQq
 JN0VUJ6UMCyk27jpNoFdZRCjFf/kZgbJMgTe1t7ed3WslwCSUT3ZGVVs0Wk7vZXGVI+SSG
 550PCuVHKLBrr2Nbjp27SzFWHyfnxliInM8rocJDT9mDZzZ+yBrJseF506DyoQ==
Message-ID: <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742522115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue/tG1FX+Gv/YbiGDgI5pXPeJAraoTsZKeQEYBYw/GM=;
 b=Ch7RrN70P62L9F8KjDK/Sr2PJ6bbab8sO/0wOrRo7YEOpeMfMmeoxEJvgL3i2plRTOX5SZ
 GAiu+JS4RkpqjGs9YFStVUdYhFUNDIVIssAKPEwLe/wy6db7PB2G2YQCJb1EKDvrp6WNM4
 UyejyO4psoEZjVpLJESf8NaxhYaetx4Hlrusn9h/IyoTycJJS0l1M01SDKK0DF7e9884Kt
 vICSRdCIwDoZ/QgfiEZwI0Ixx+UIaGSmZpPIOUOyXrYXT5lHQ1wZeTVttssd9JvADLdGe1
 OF1Bg0tNCnhKUEBg1pkIJ2qCN9K4lVDmEkT1TvEoY/nf93XeJkTZ9FGCUyieJQ==
Date: Fri, 21 Mar 2025 02:55:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg
 <sumit.garg@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250321013109.709431-1-aford173@gmail.com>
 <20250321013109.709431-3-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250321013109.709431-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qt8bnemsc6j383htxs9bj8yp4r48yjb7
X-MBO-RS-ID: 762c6a42bcb7b2f875a
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

On 3/21/25 2:31 AM, Adam Ford wrote:
> Enable CPU_IMX to register the ARM core and identify the
> speed and temperature information using the driver model.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
I am tempted to say, imply this for all iMX8M and iMX9 in arch/... 
Kconfig , so it gets consistently enabled for everyone .
