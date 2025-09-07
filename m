Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406B1CA0FED
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 01:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FBDE83966;
	Sun,  7 Sep 2025 03:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z54OdaU1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tfqoGnGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A3A837B9; Sun,  7 Sep 2025 03:01:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C00E83906
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 03:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cKBcC2rppz9tbS;
 Sun,  7 Sep 2025 03:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757206891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwHE0fLKvqD2v/+mXIUukEEjl+ryspcp3WrMlVK/EDc=;
 b=Z54OdaU1OVVIjwVFBh8uNVBcTM0nrh6wy+B4Yo7b5eI07IOPyW7f4J1fi/PSd16ph9Ta6+
 lGTAs3Dfy31R/Qbq07SdCWipHRtUXleBUNXIzn2fjc7N/6CcbhjnfDj+MKWLzNZ9/fyjE1
 jtVm0urm/Ds+xTJ9wWo84eX699CHErfclM/xQxmEOI58ij5l/cRosAgvQ19bUySrQGlD6y
 YxDF/MTxA4hawYjH3PjnXZfcaeqT2Kc0Aes9JtOLwbzMSiE4Gqv3n1FMSEeyLFGyEwhilH
 OI3D48SQHcZxK6sJFJUFfllwRiT46CrYCvubsEsqTN3MGxBftU+6sVNDKvHzPw==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757206889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwHE0fLKvqD2v/+mXIUukEEjl+ryspcp3WrMlVK/EDc=;
 b=tfqoGnGsHGi3/ep2QkoqLwmwnFIg8PRfHlYfTWkBEF2+zpdKCv8OPRWvEhyfvKDDwAzece
 Jue7daoXu7G7BSquN8Yo00kbSOQq3tbGnM9HhwMnPos7C1vIRJ5DvxW6jxb0LvqTdU0qmx
 6T2FN4P5wgBh88bwohqYQ5JEmZUXUHPKmB6Q7aM2uTNj+NybKuoVUPBeGQkJCxv6/mnOt8
 /TyFtsTn2kl+4EYniVy5f3u68MuN7MnNxTAtfl6jQkr5vkvba91GsTxPrL/5huzBN6efvm
 MO3otpEvn3Xi1rrgXKoTUKCX7NiGPF6I1YuaH8qhRrtBmDkF6Y/TFE702cLxkA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] board: dhelectronics: Use isascii() before isprint() in
 dh_read_eeprom_id_page()
Date: Sun,  7 Sep 2025 03:00:47 +0200
Message-ID: <20250907010103.667681-2-marek.vasut@mailbox.org>
In-Reply-To: <20250907010103.667681-1-marek.vasut@mailbox.org>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6fee88464b01017a7c1
X-MBO-RS-META: otwgwecpq9cuugq1cqkewxa58mp1p7dt
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

The isprint() checks printability across all 256 characters, some of the
upper 128 characters are printable and produce artifacts on UART. Call
isascii() first to only consider the bottom 7bit ASCII characters as
printable, and then check their printability using isprint(). This fixes
a rare misprint in case the ID page content is uninitialized or corrupted.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 board/dhelectronics/common/dh_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index aeabd617374..e7ee23aa8ce 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -88,9 +88,9 @@ int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
 	/* Validate header ID */
 	if (eip->hdr.id[0] != 'D' || eip->hdr.id[1] != 'H' || eip->hdr.id[2] != 'E') {
 		printf("%s: Error validating header ID! (got %c%c%c (0x%02x 0x%02x 0x%02x) != expected DHE)\n",
-		       __func__, isprint(eip->hdr.id[0]) ? eip->hdr.id[0] : '.',
-		       isprint(eip->hdr.id[1]) ? eip->hdr.id[1] : '.',
-		       isprint(eip->hdr.id[2]) ? eip->hdr.id[2] : '.',
+		       __func__, (isascii(eip->hdr.id[0]) && isprint(eip->hdr.id[0])) ? eip->hdr.id[0] : '.',
+		       (isascii(eip->hdr.id[1]) && isprint(eip->hdr.id[1])) ? eip->hdr.id[1] : '.',
+		       (isascii(eip->hdr.id[2]) && isprint(eip->hdr.id[2])) ? eip->hdr.id[2] : '.',
 		       eip->hdr.id[0], eip->hdr.id[1], eip->hdr.id[2]);
 		return -EINVAL;
 	}
-- 
2.50.1

