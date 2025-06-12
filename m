Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADCC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA16800C1;
	Thu, 12 Jun 2025 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="BYrYCWkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C755782B70; Thu, 12 Jun 2025 12:10:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C1880050
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1749722988; x=1750327788; i=frank-w@public-files.de;
 bh=T7Yu8CZMsmKKwGKVqXG1i/lPlpxnBlhqpqRFKHCL4so=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BYrYCWkAhiPxzN35KXvU+g+cKC6REDU6FG/EHinozCeUHv9ZcPDlushdWDGvXrzG
 Pnw2cwEw6wPYjx+Woday1AydJiL/9v+GZCNtuIZ9+0ppObBFSrlypSKyNRQeBrlYH
 47U7Q0/A6hQ352hCBDHmv0xTI+3aMYQ9iLjLI8e+R7Gu7NHQlh4IW53ABGUUc/1HW
 zza4eUBacDX7ZENbm+6W5G+A7E2VHdpeofjjbSX+ajn8oAqDsizNO+QapEJ+LAeMd
 irr8JQdF3iRXVXaZ5/jZufsD7ezwrmNch1SCxGdZgcd0SFEgXujFXO8cjmOxU4Eme
 2qEHQbn5fevEb9CCuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.68.32.175] ([100.68.32.175]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx (via HTTP); Thu, 12 Jun 2025
 10:09:48 +0000
MIME-Version: 1.0
Message-ID: <trinity-e740c5ff-b6cd-404c-82c4-eaf0642a13a6-1749722988086@trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx>
From: frank-w@public-files.de
To: lucienzx159@gmail.com, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, lucienzx159@gmail.com,
 u-boot@lists.denx.de, trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com,
 lucien.jheng@airoha.com, daniel@makrotopia.org, ericwouds@gmail.com
Subject: Aw: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 10:09:48 +0000
In-Reply-To: <20250511051400.29853-1-lucienzx159@gmail.com>
References: <20250511051400.29853-1-lucienzx159@gmail.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:J8RgPR8JpTm4UxHguT1DLOZlwAphstqpJmj/sRBtOIFWw3OWaSVmWl4lOcn1eBYNIhWnW
 ycUsdhu/gZr3zJ2x38z8UwIBAmQhvJR6AXC06hAuQJGr3hP5x3DbNiAEcKXHx3q9G24OUZtqpssF
 h0NQIL8Fpm5oB2PG7ZM9fF2pR4woPi6N7uGrjv7XNuJ9YWNQqlaOrsJ0ttX+OpQKB4uAPIhPrzU7
 1dmJrtMMzd3FDTSafZqfRzFb8pWOaAyGs2vNFfLODNfV0E5hozejims9uAV9ym3pgPyt/F1YYeUu
 VJU5eCU2Q7E5YKfKddXimjDzSZX9Tcebd1JlufFDMJOLHg5tGWAqcA/ds8UvLFhoRk=
UI-OutboundReport: notjunk:1;M01:P0:bGMb9RQdbbQ=;DP5zsGA+HbYuTYJ3se5+/gB9ttK
 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
Content-Transfer-Encoding: quoted-printable
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

> Gesendet: Sonntag, 11. Mai 2025 um 07:14
> Von: "Lucien.Jheng" <lucienzx159@gmail.com>
> Betreff: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
>
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
>=20
> The driver uses two firmware files, for which updated versions are added=
 to
> linux-firmware already.
>=20
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via M=
DIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture le=
vel.
>=20
> Linux upstream AIROHA EN8811H driver commit:
> 71e79430117d56c409c5ea485a263bc0d8083390
>=20
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot seque=
nce.
> and have validated this on Banana Pi BPI-R3 Mini.
>=20
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
>  drivers/net/phy/Kconfig       |  43 ++
>  drivers/net/phy/air_en8811h.c | 852 ++++++++++++++++++++++++++++++++++
>  2 files changed, 895 insertions(+)
>  create mode 100644 drivers/net/phy/air_en8811h.c

Hi,

is there any progress? i see no review or apply (+tom in To-header).

regards Frank
