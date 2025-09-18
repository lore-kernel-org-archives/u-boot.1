Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F9CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 12:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDB881E13;
	Thu, 18 Sep 2025 14:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nu74eYT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246F880B9B; Thu, 18 Sep 2025 14:21:24 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE5480B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 14:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSF9X1xGFz9tY3;
 Thu, 18 Sep 2025 14:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758198080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNNIPDqUOUNYMIDh2/8/I2Qsasxr0eu8N0XfczIR/YE=;
 b=nu74eYT/QsCTs/+Bu/GjY0WaM9CGKHINl6yBEFJnaRTfNzInV1CAhFN/O/DGtl/ykoW92r
 JRyJ17h9J5HBL6OmliYRbTVI87qNCmHQMK4q+SCAiIYpl5DEPxTTHHNIRA5gg6MDqyrJqY
 7tQ16Vt8zDWlYkDH8SQ42ideX4jAUKyPZWbA2KjbLmf4M+zUPZTYT8M18rLNogSkdj0Icb
 eohU5UEW+OgmDAOJVIQTCWxn17YMwTIPDOxXsSiqyPoQyjOhvlP57lVy+wKSv/M3kS7fVz
 T4dv6HlNuaPzGzfUQngpTWb4LOBm4PRdpiQk8VX2LPD4Bw/jOS+SKNC7CDfgBQ==
Message-ID: <c7645818-d51a-4fbe-8f4f-185429416e61@mailbox.org>
Date: Thu, 18 Sep 2025 14:21:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, trini@konsulko.com,
 festevam@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com
References: <20250908194649.3645232-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250908194649.3645232-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5a4z7aqmkdufr3tee6zxmxb6hksk8enq
X-MBO-RS-ID: 53d593b56a19b253545
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

On 9/8/25 9:46 PM, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
> i.MX95, the condition check is updated to use IMX9.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Also ... at what date did you send this email ? I received it today 
2025-09-18 .

