Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0939C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E9B87FDD;
	Tue, 27 Feb 2024 16:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NZsy3T1C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p1XLkaoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A987E8800C; Tue, 27 Feb 2024 16:59:12 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869C687D87
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TkhxV0Zbtz9sWB;
 Tue, 27 Feb 2024 16:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysdHx98mYLRhPOIglJcuM+MIeKmHJ+BwczPMehxu+Do=;
 b=NZsy3T1Cxl4HIXjSjK7imzCWh8Cgf3AaZpxFJiRalU6mpaWuSITdU7A5SLtcSqCoyFdjR3
 u+Hkk1ve121BddVxKXBTn2RlxtwS26lBOKFbpIniIMKC/u6iIMhSp8zJCbKBQOR7i191EW
 C4o9QBDMPkfxprJME9JigcQYxfH84m6Y7NC0c4nV1mj6LKjf7PqOdaAZz/aHYjPg+nz0rg
 JSSgKyZUR/K2zpdQGVD/YgzkVYCprE7aUmNFiGOpFEKr25eLKQjn1Ej8LYlsAFF3lutpMP
 R6vpec6YfU3na+oWIGrPRZE5/aStIzyBv3A0a/epTsNEr3jGSG0KZmZNiYP8Rw==
Message-ID: <76775acb-c6cf-4099-adf3-aeaef3e8743f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysdHx98mYLRhPOIglJcuM+MIeKmHJ+BwczPMehxu+Do=;
 b=p1XLkaoDadwqQ/V2ufmKjkTvpSZEX7A7i6r7PCZlENYreVJADIoi3XSx/4LUNmJHJatLnO
 2RKMkZyVJF7EuJoXhyx55Ke9nABGPr0elIvXsy4YRbfXWibnrb3Z0qwsbAG7TqNUqGBzWj
 yUP6FURomi+LesSDoyeJnB72cB85f4FrkQx8SsFSa/vzIQ9u7LihjfnE39S1ugvTofu7vn
 9aVNqV1qbmxpGZt7tQXmjzhAiKbBO0AUrz2iJKONibFZSI/zHmhBSYeMeRYCR4DGrlUbWX
 zLMhV91TerENpwt9P2i8zTn+TnH+pgGS8W5tOctR34dwo/snxKbMoCRbNun2DA==
Date: Tue, 27 Feb 2024 16:59:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] i2c: rzg2l: Add I2C driver for RZ/G2L family
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-4-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: thpy1im16hxrb73wdzmdzdwh5o5or4ap
X-MBO-RS-ID: 8c9dbf0ab567f19faa9
X-Rspamd-Queue-Id: 4TkhxV0Zbtz9sWB
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044)
> SoC, also known as the RIIC module.
> 
> This patch is based on both the u-boot driver in the Renesas RZ BSP
> 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.7 driver
> (commit 0dd3ee311255).
> 
> Support for deblocking the I2C bus is included as this may be needed
> after triggering a reset via the Power Management IC (PMIC) over I2C
> (the PMIC asserts the reset line before the SoC completes the I2C write
> transaction with obvious bus locking effects). If the SDA line is
> observed to be low during initialisation, we automatically attempt to
> deblock.
> 
> [1]: https://github.com/renesas-rz/renesas-u-boot-cip
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
