Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60BBD61015
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506AB83FB2;
	Thu, 29 Jan 2026 14:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z7SrY7oZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5029483FB6; Thu, 29 Jan 2026 14:07:31 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E40983FAF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 14:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1zvL4jkGz9tlT;
 Thu, 29 Jan 2026 14:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769692046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8j894SoWMPmv37YdQ7yKiVBh+PIK0ZhdhBZvrXXY6JA=;
 b=Z7SrY7oZgzppmbNVUNnVIr8wMwYwOBvV1QZtc3vdyqoYL+nAxq0djLKA5olCpxXyCjvyhd
 tJiytFOiluUrOtvSuFM9mjFEMjSOKY8ScP+aUHNYVTtON8yeLcCPyEcUyAUSW7Qtu4/tIR
 XBxCYl2P3hd8Nc0tbJhh/EOB+ofwl+7nIVPvLwx9sB+y5/B7a+5pK1GeqXyIlX3PdipbSs
 fziKNC+MuDI4QWjm+QnrejJqGcjYogUPylO56Pz1+To3C1iLBf+PP3GOEEvVIpTKKgk7Kd
 6PILCbypaNWvPOISAXIk/QFu462Yx09joZcQRDLVAID+IhTEu04VGqzHaGQUzw==
Message-ID: <10e255f0-e817-45c4-b3ad-f3998c994ec9@mailbox.org>
Date: Thu, 29 Jan 2026 14:06:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Add support for Dosilicon DS25Q4CB/DS25Q4DN
To: Ssunk <ssunkkan@gmail.com>, u-boot@lists.denx.de, trini@konsulko.com,
 tudor.ambarus@linaro.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com,
 Takahiro.Kuwano@infineon.com, pratyush@kernel.org
References: <20250827122403.20159-1-ssunkkan@gmail.com>
 <20260129123340.4372-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260129123340.4372-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7e9n3odn6nbksbduokoa5ztzx7cofqru
X-MBO-RS-ID: fc4a97c22a414dfdb12
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

On 1/29/26 1:33 PM, Ssunk wrote:
> Hi all,
> 
> Gentle ping on this patch.
> Please let me know if there are any comments or changes needed.
Adjusting the CC list slightly, this is really up to the SPI NOR 
maintainers.
