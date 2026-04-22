Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE02FA1FC7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4381843EA;
	Wed, 22 Apr 2026 17:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ah/LkfvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DEC843D0; Wed, 22 Apr 2026 17:43:43 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E14F843B8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfcF8go68PRtOC+4ci5teOFRZ8Bsm/SltKbjrKX6o8g=;
 b=ah/LkfvW2CAG1xtKvGikwLv+noI3rUM7ZiVr1RbvLBiIqwb5ERxTgUAyVOAJwISau+eGV8
 TH/I8mUgLYhz/igCRw03A4HVPLGDYM+eujPvG2mca9pTVE5wqEOE+jGKFY491dUYTbRxiC
 +8oB30ZTKdc5LA/0GWbiSdtsp7wmU1vGfe94BMKNFDM3JPHURlvr6/hLdNa9fe0PeHLm33
 2Eviu3dJrH4YmRGFLstJY20K7lAr/IysOrKnw8MtuM6AndKUgnZeYMM2j4OdEm5MJAXRM6
 8p1llG8xGENzWgi2yKdam+Fd7zI297KUyRbvFtPeBQF+NFHDU8NkpQbuPLUqGw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:25 +0000
Subject: [PATCH v3 3/4] configs: libretech-ac_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-3-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=828;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=bBnzaFTiKpP3JoUbits1MCXh6AWRwr3MZCW9LgEPemY=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OyjmvAnzJMplJXt0JgK4yMSw1jg9xLcy6DK4
 NaHhhEVS+mJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsowAKCRCEr8vQ14ma
 A9x+EACV8pTGJcbt1mSEeTbhosuqUzEw/gjouvBztol/bEaXcyiIZ/idtEpQChqMqInOCUY1rwU
 rSZplSYcMiPNCWdYIUGxd/M3pcDymKv17AZyz98RQ8UC6dtYaLdO4DZYFzhduOcZiIYywA0kZLG
 vlO5MKBeXHGZHfTreF+zBkgcC6KS8xVFd1pdw8a+5ozaJVAQ3SpRTDopdyA1hvZVZ+w/citi487
 Ul7ACBZHd84nPlVsnQvos9kXi8FaThYG7eD012Vxnu1W4fJd4XNwzpZPVXb82RV4VZ0aqGw+uHR
 rcM6AUx96+0o5uOOz/oJPdCN46c4yJfFOALU9IPAgStruHfSgxas6GXnZvIpaW29+La35MHOoB9
 YvT52jE8ujd0gCUSErCBFn8h+EA74faNAXULpaX5lxOHRKN025fzWSs+4SpQfI57/M+L4w0XB5U
 0DuVFV5zyLTlCdtIxzYIrP3dv9YGXCVTA2FW5EonDhiwtrRplyxkux1d9eTz0rYspOV/c151r5k
 yYeawn5iYL81yiRnIl4Bk0HxxpE81Qt4TIgCN8mLCtgEQaupQ2hobXwhXq4cgRwVAfkjFfb0gfx
 6ceEzHzo1K3L4Ah0Dc6fQtd0/MMplb9AOO6bXDUs5F6Di2n1mY0qb2d0raWIonSZuBRgfVfLKAi
 pxR30nCTL96NXig==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Everything is already in place for EFI capsule updates, so enabling
Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
flash from Linux using fwupd's Capsule support.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-ac_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 1a67ca734b8..17d54655017 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y

-- 
2.53.0

