Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24550CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E99E340817;
	Wed, 14 Oct 2026 20:00:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhJnn2Hvhbsw; Wed, 14 Oct 2026 20:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 346A640806
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008044;
	b=qdf//rGJMSgeHPIV3lHAvWvIUhWOF2sVrbs2C9ilhXCieEL/AVj6VIqtKucvSKCrkNlb
	 NiX5VzxK95JB9gp+HpvLoY4DXZNjhPRGN6291zg3XvajACEom54qkki3vdQSCl7KqJXhe
	 QxM723aDWMCAdO/BrVXxPyD5hm0ec1m26Y6oJV69bDSap0TTGEadYLwEvnlVDEuWBpqzb
	 PEVg0kAq2CC/31wmOVxCP2JcO3I9fP0OkQSEOGe/GTtGz/ZkGZmJ/HIUIHzx8wbB0/oRu
	 OAquFKrkA9tO4Cxgfk2CwwAOklKY3ouKfD8MfOOAh1G3zcGBdJ06ohzHGKCWJ8UVeJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ROyJbGUfuFmIDqQjK5qqgQS4pQbqnoJXXjKH1h7PPNE=;
	b=UMkMxJ+9QQCTgACJ5YasRdtqC3Suz8fCoPKZjkDV8dRrpK4RZ/OUmB7Yb9gRkGhK+kuM
	 +/1y2puDhXWk9g62kzTgZeFJzNFJ+IMMM3ikjjMeG22ANVAWbDpKm6LLBOJhtWAJ3BHKK
	 BbqFET+h3Q0eLozQGQwM83ZzUJ4g6U2OyAa8BwN9jRyCnAIlXtJNF8X+KcVEeaIIfOq47
	 Ts1e2NXxUd+lJKtJHw7UBFFRWf/HK7hJZTRkcV9AkAJ7A6WdfVYAiVKLanXFs233HFGTJ
	 8hp3FOj1jF7LXTljl8JerDzRFVQGPzCMfpG5PddtmEMU3/LqiU224d2HxSxmnkg9k8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008044;
	bh=ROyJbGUfuFmIDqQjK5qqgQS4pQbqnoJXXjKH1h7PPNE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsEWgA9jd2CONcv3bcPA2GZMTR1ttn8wfULbLdrUs+EoBRy0VKOEKe+a00/4xSbwF
	 wwCxPrJz2Tc9omxztMLV+WH7vhnLyuqDKog3ZfeVbAXxJ3L0J5TLIObOEsFj9s7p4J
	 /Fzbqy/pCKgJxFt1w9XNwb9yTfwnFfY646edG1Ytno7kyUquty7X1AbsTLjjSg61F1
	 rmePDfY0wgHBkZL6mItQhAC/sQMrgf9y/rR1M/2wVHAeh3QbJNp7dTBaF9EcIHpJrH
	 R/qVRV8/CQyXgy/1+fcINodDQxlHLLAf/Hp3Fi3h6NMqbo1bMN5SxqTGT/GLTFHDuq
	 x7xCBfvTAXJUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 346A640806;
	Wed, 14 Oct 2026 20:00:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 916112E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8372360840
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVQdyV9QYPuy for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E2F6606F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792008041;
 b=Jzl8RM19ItnKvLodSfWOdIL0fprWIW1c7vIYa1PmTkuYk/RwSmjp1iCrQpnrf6/e0Pnl
 7Pnc2yN43wWnGwRWrKlFDiaIOsEBMLVuuAqjqY/eDR2tc64/DJNKwx9iTgwHeqaxBI8VY
 KxERRk+l0QVWdkzAOf0WgrKk1ayS5AzyKndvItk5VX1BwDwlz/icmon4wzqYIxNwTbdJU
 Dqjh0MVDiMR3DC2I87gO67wGoYO4/kzckCbATQ1rqbruHv5ZwqEA+rsMMw/mHefazknYD
 TbgdC9uwM909BInH4BxqcTw6kMTd0L6im8WfenNmc8KvP7XofXl411AsMCLzo2OCMvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792008041;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ROyJbGUfuFmIDqQjK5qqgQS4pQbqnoJXXjKH1h7PPNE=;
 b=L4Xz7maSrPDnHLL9Xc56/gTjYRMQ7jd89mh+UnoDtTt+ke5j0jccvPIMGLqZguyPOD5H
 Q/AWIAQkywMxCplnM/iTA0Ba0mO2ltSxOa6qGU0ZwaCfPXWfrqt+vKiYH6oxjZIx8bXZ+
 rm+EmMyBAwil6LjfeScYnFEus9c942WyZDj1lEZ5VlRUCdSxDMD3me/OykCLGryTNDh3H
 roED4Zi1rS7MyVDzyM21jU/4tibvHvlVbrzd4nSolXqtRv0t4tMjFDAZQGRUdyOB5BzjF
 XDQB5Z5f8qRVCM4eaUHq26BMOX+kI/qle3YwiKDoMhBqaVGnfxJm4f8eLana53Nn+mQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=anm0s+FX; 
 arc=none smtp.remote-ip=185.70.43.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.103;
 helo=mail-43103.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=anm0s+FX
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E2F6606F3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792008039; x=1792267239;
 bh=ROyJbGUfuFmIDqQjK5qqgQS4pQbqnoJXXjKH1h7PPNE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=anm0s+FXfvQAOwa/OLxeLpff1G7ZRcTuF50WhqHzo+pONRXvOqvy9WetNoxsJW0Ya
 f2FUbxt2eJWbsH2w7LcOjLhGw9qhD+YnfA6BiM8bjWs23Wyni64BWhUjFsiledZ2ug
 aDzMTYr7IUehOljCf96ODoli2LAfX72YAuesX4fFosBkgJbj/Gxg0++X7RgZKyb6TH
 FsEeWe5Ge4mYKZb+c8sAu+8mZpY5Nie2ZhQL1qGe43LZBQj2TjUmp6rQwVB1ZQ4EKY
 8vVCd2dYs7NDNn4NbSNQn8Iq3a6K98atOHU36HoytcMuwdRnjaBjwINpEnkzRf+EAv
 obV4IaxwiuqNQ==
Date: Wed, 14 Oct 2026 20:00:34 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v3 3/3] configs: spacemit_k1: enable USB host
Message-ID: <ac057da137ba730f46251c57098da9308fb00928.1792007916.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <cover.1792007916.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: b9f499c2161670845151722b9acf3cb5dd760f18
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Enable the K1 USB 2.0 PHY, the DWC3 generic glue with xHCI, USB
storage and the usb command, so the K1 boards can boot from or read
USB devices with the default configuration.

Enable DM_REGULATOR_FIXED as well: on the OrangePi R2S, VBUS for the
USB 3 port is a GPIO-switched fixed regulator, which dwc3-generic
enables through vbus-supply before registering the xHCI controller.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---

Notes:
    Changes in v3:
    - New patch.

 configs/spacemit_k1_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 39c490438d..8ee9baa13b 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -61,6 +61,7 @@ CONFIG_CMD_GPIO=3Dy
 CONFIG_CMD_MMC=3Dy
 CONFIG_CMD_PCI=3Dy
 CONFIG_CMD_SPI=3Dy
+CONFIG_CMD_USB=3Dy
 CONFIG_CMD_EXT4=3Dy
 CONFIG_CMD_FAT=3Dy
 CONFIG_EFI_PARTITION=3Dy
@@ -92,6 +93,7 @@ CONFIG_NVME_PCI=3Dy
 CONFIG_PCIE_DW_SPACEMIT=3Dy
 CONFIG_PHY=3Dy
 CONFIG_PHY_SPACEMIT_K1_PCIE=3Dy
+CONFIG_PHY_SPACEMIT_K1_USB2=3Dy
 CONFIG_PINCTRL=3Dy
 CONFIG_PINCONF=3Dy
 CONFIG_PINCTRL_SPACEMIT_K1=3Dy
@@ -99,6 +101,7 @@ CONFIG_DM_PMIC=3Dy
 CONFIG_PMIC_SPACEMIT_P1=3Dy
 CONFIG_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_DM_REGULATOR_SPACEMIT_P1=3Dy
 CONFIG_DEBUG_UART_NS16550=3Dy
 CONFIG_DEBUG_UART_SHIFT=3D2
@@ -108,4 +111,9 @@ CONFIG_SYS_NS16550_MEM32=3Dy
 CONFIG_SPI=3Dy
 CONFIG_FSL_QSPI=3Dy
 CONFIG_TIMER_EARLY=3Dy
+CONFIG_USB=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_DWC3=3Dy
+CONFIG_USB_DWC3_GENERIC=3Dy
+CONFIG_USB_STORAGE=3Dy
 CONFIG_SPL_LIB_RATIONAL=3Dy

