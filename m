Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E785C5AD48
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 22:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFAE380BB8;
	Sat,  8 Aug 2026 22:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80jdfSIn32ul; Sat,  8 Aug 2026 22:08:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 219F880BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786226895;
	bh=SWKByJOd+J1rc2A7EiKvV46XzgR2F+ONrlR1XCLEE6U=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=groF06/95f1v85N5gGXH0COSKV8gbi+TZZ+a3+uJHsnkBfWhm+hOWhNgpiomhPtXK
	 JRAkJTunbRwzrTIVc6L7IFw0aSCRPojGFNf866Ht88NbdloQChzxV2LuBQSPTZISm3
	 fjW0C4CmaZ5bSqnfWAZdi2UKCQdFrFc8JoJlclNH0c9S0DLO5cT1ufPPuQs+StwuFu
	 TOvZruRwwQLq25qQpPHzOwxXeWEg6Mqi8MP3mXxJ7QEZ57Yt+JR8TAPYQY0VknNuLa
	 R0o9SxEt4sbeeI42fOt0+2tAgif+cAh24blFJezaHm3dduI9wJ6/nu93Ns152LGk4S
	 PoCThGfgf7QMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 219F880BAA;
	Sat,  8 Aug 2026 22:08:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D1FF2282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 22:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B831460621
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 22:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7NM0284hCR_V for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 22:08:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=sputnik@on-the-web.ch;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 05F0760617
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05F0760617
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05F0760617
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 22:08:08 +0000 (UTC)
Date: Sat, 08 Aug 2026 22:07:13 +0000
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@flipper.net>, Martin Herren <sputnik@on-the-web.ch>
Subject: [PATCH] rockchip: rk3576-rock-4d: Enable XMC SPI chip
Message-ID: <20260809-rk3576_radxa-rock-4_spi-v1-1-e3f2933f411d@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 37bd24212b416acb1cb87765e283eb3e52eb98ba
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------88ed950f993948744f2799da0916bd9b9d8ceb641a11db2eef3b50d409c07df5";
 charset=utf-8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=on-the-web.ch; 
 s=protonmail2; t=1786226839; x=1786486039;
 bh=SWKByJOd+J1rc2A7EiKvV46XzgR2F+ONrlR1XCLEE6U=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qVc6N0PEQjj7noZWz6hgi7tpSKG3w62w8LyUWTuSmRroggdAH7pxwr/ZnTEyLvvoY
 41SN4i64EULFSpSV9O8qczC32yhsFHe/EpjzFPleNm7+bJ0/bMpQg841KPS73rrerg
 hxuTRzXirVH1O7ZodLIUeAyBgq0c8ies4/VVf2YZduUZ9HHhevsl5TKyu3k2i+EdW1
 dg489shWfsKgfoTu/HWtDOSfHqi0blutZEVqlP0Bq6NbpuWRltoewoiT4sKKs6XuB1
 kp3uR0IyLLOq6feM397Y4tsOYUd41QhGGMFKk5yycp/4IrHofo7DCWa4PvJ7qOlXfS
 pGQjzYXKyHSfQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch
 header.a=rsa-sha256 header.s=protonmail2 header.b=qVc6N0PE
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------88ed950f993948744f2799da0916bd9b9d8ceb641a11db2eef3b50d409c07df5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: Martin Herren <sputnik@on-the-web.ch>
Date: Sun, 09 Aug 2026 00:06:33 +0200
Subject: [PATCH] rockchip: rk3576-rock-4d: Enable XMC SPI chip
MIME-Version: 1.0
Message-Id: <20260809-rk3576_radxa-rock-4_spi-v1-1-e3f2933f411d@on-the-web.ch>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDQAxA4atI1g2M4/jXq0iR6RhtKqgktQji3
 TvV5bd4bwclYVK4JzsIfVl5niLSWwLh5aeBkLtosMYWpjIVypjlZdGK7zaPMocRXasLYx2sS3t
 HtqYcYr0I9byd5+ZxWdfnm8Lnv4Pj+AGdF3ujewAAAA==
X-Change-ID: 20260808-rk3576_radxa-rock-4_spi-9c241f4e29e5
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Martin Herren <sputnik@on-the-web.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786226830; l=1303;
 i=sputnik@on-the-web.ch; s=20260807; h=from:subject:message-id;
 bh=hV9JMZUEQpBgA+C+YX4zJYR/ZVW6TNBDkUCs6gEmzyo=;
 b=3ro/17LU+2I5iBSYADFrMKeP1wpo9dpJiCxxLrsXHdCQF5iW4yybeHh3znYKjQK0QiAZaF+jd
 XJJWaLwx9gFAoqHzXNWye03CkOoqr3rn308DIMUKha3Qzo587YR+1Q0
X-Developer-Key: i=sputnik@on-the-web.ch; a=ed25519;
 pk=BR38NGVUwMvK69LvaMsmvH+Fv6i7mZjbbFA1/X+SwsQ=

The Radxa Rock 4D exists also with a different SPI flash chip than the
one specified in the schematic[1]: XMC XM25QU128C.
At least board revision V1.12 can be impacted.

Enable CONFIG_SPI_FLASH_XMC Kconfig options.

Without this SPL fails to probe the SPI and thus fails to load u-boot
proper from SPI.

Vendor u-boot also enables CONFIG_SPI_FLASH_GIGADEVICE and
CONFIG_SPI_FLASH_WINBOND so other hardware configuration might exist.
They are not enabled by this patch.

[1] https://dl.radxa.com/rock4/4d/docs/hw/Radxa_ROCK_4D_SCH_V1.12.pdf

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 configs/rock-4d-rk3576_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 7228a9d879a..93faf09962c 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -49,6 +49,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_
FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y

---
base-commit: d0615e4a67c8958fad4a8c39262074958f04c179
change-id: 20260808-rk3576_radxa-rock-4_spi-9c241f4e29e5

Best regards,
--  
Martin Herren <sputnik@on-the-web.ch>


--------88ed950f993948744f2799da0916bd9b9d8ceb641a11db2eef3b50d409c07df5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmp3qJEJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmftTm2z9j0mihKNp/WsLvsbFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAJZFAP9t7H3V8F9fD1yj5j1vepgsWLFgTEf1DvmfxAiK
LlUIEwEAlYirct89vULTu9OQoIWl94pKOZclbZMyuN+f1Pw31QY=
=cPye
-----END PGP SIGNATURE-----


--------88ed950f993948744f2799da0916bd9b9d8ceb641a11db2eef3b50d409c07df5--

