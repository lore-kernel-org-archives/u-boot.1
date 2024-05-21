Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF2C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6742988728;
	Tue, 21 May 2024 09:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="udY3NG3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438D78871A; Tue, 21 May 2024 09:13:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C5C8870B
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 131666201E;
 Tue, 21 May 2024 07:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB0BC2BD11;
 Tue, 21 May 2024 07:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275625;
 bh=7RVidHPJdNkmb71oOh0BZ7YaTO9xABgdKKrVNZfvSi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=udY3NG3LE+6U4+i/kBd74VU9S/ScCWcrF582L+2EVMfk9FWLRvwJB8ja/vjT9asC0
 aRSKRia4q52FrIYEjmTLtyOfxe/oTj0jTiZmUWp/CR0uXkue5Yqwyca1C5nZFekV2E
 T5Bd4c4DmX6IoNMyf8NY5taRyhXAFQFPyfc9jDbIVcRQNswCMlJj57vyJg21HceCV0
 trwMDuADt3wH6h+suMu3K184ofTHGWDDdQx1l+gx2bWdUzq/eQPT4MNy82QgsoFfuz
 h+3HczCLu464rtbpeNUfzdvtqVMiSGWVPxtG1KkI7pNawX5jEVEuHtOyGrRDyTIYpv
 nuwaOsC3cvDYQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/11] common: eeprom_field: Fix updating binary field
Date: Tue, 21 May 2024 09:13:27 +0200
Message-ID: <20240521071335.4193-4-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The __eeprom_field_update_bin() function is expected to parse a hex
string into bytes (potentially in reverse order), but the
simple_strtoul() function is given 0 as base. This does not work since
the string does not contain '0x' prefix. Add explicit base 16.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 common/eeprom/eeprom_field.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/eeprom/eeprom_field.c b/common/eeprom/eeprom_field.c
index f56eebe679..9b831414a4 100644
--- a/common/eeprom/eeprom_field.c
+++ b/common/eeprom/eeprom_field.c
@@ -55,7 +55,7 @@ static int __eeprom_field_update_bin(struct eeprom_field *field,
 			tmp[k] = value[reverse ? i - 1 + k : i + k];
 		}
 
-		byte = simple_strtoul(tmp, &endptr, 0);
+		byte = simple_strtoul(tmp, &endptr, 16);
 		if (*endptr != '\0' || byte < 0)
 			return -1;
 
-- 
2.44.1

