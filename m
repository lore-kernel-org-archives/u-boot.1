Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27237CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 01:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ECF83AA0;
	Tue, 11 Nov 2025 02:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JlozxkDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8221483AAC; Tue, 11 Nov 2025 02:03:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8249483A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 02:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d57Zv3bBlz9t4w;
 Tue, 11 Nov 2025 02:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762823031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2GN72HlDCTbg6lywE0HNt8KloDFWnsCMunsNT3wCGQ=;
 b=JlozxkDHXCzgpbEJjTjhWiZB7l9TWckj3WHTsgRLk21creTl9RDdC8fP9lFNT/6aEjISFq
 5txbeP4cSwNjBtnuxIUm5Jm5TtgxSkHeALzR9q3xsHGCPqRkXN1zWe1SYDAZ/7IxARm0m3
 KIuMQBepv2DdTn9D1QAHxReKF6JhaN0MVTDxE8I/oBjWSTu9PIiacbps67qmiFJsikgwpf
 sIOj1Q+/f7VPijA7L5G2geMnlP7R0BUz75WS7Gxj2BIKyNHaadGP9cun784CCdVXqO5RI+
 QM8MuSBartEAGkRrknh+bnA/Z2v7t02E6knFLGe/mgNVyp/e4cPH6a7vmAjM1Q==
Message-ID: <d4dd9ecc-1ade-4a2d-85ee-979dbb31f57f@mailbox.org>
Date: Tue, 11 Nov 2025 02:03:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [U-Boot, v6, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 ansuelsmth@gmail.com, weijie.gao@mediatek.com, SkyLake.Huang@mediatek.com,
 romain.gantois@bootlin.com, s-vadapalli@ti.com, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 ericwouds@gmail.com
References: <20251111000506.18366-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251111000506.18366-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t5b9ok31ooqjf3jtkzttyejup8j4xjym
X-MBO-RS-ID: 9af17409a5c7c25385c
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

On 11/11/25 1:05 AM, Lucien.Jheng wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via MDIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture level.
> 
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
