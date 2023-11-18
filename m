Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF6C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 11:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8537D86CBD;
	Sat, 18 Nov 2023 12:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qB+85cCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DB586E88; Sat, 18 Nov 2023 12:40:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA3A86BDB
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 12:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AC70D413CE; 
 Sat, 18 Nov 2023 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700307640;
 bh=XCfHbyaO0frNlshKEc19+FLP7HUmUshFmnFziLFaC+Y=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=qB+85cCYlDabAj+I8VmoKlM3JiaSRp6/ILny5MPOxMJofzT/1BpDsurRgzdUXAie/
 W3eTvgCuGsXyN5OmTAf79N9TrJ+dOOyKzhFSr/3ZPgnJp2qQfmDo4OqZArosGKu1hV
 LNqOvneQCuKE2sGPkccZ8gMZZTKe6euBsQ6++G4fdbwkSAp15/tEtQqFD6uJ/oJUmn
 slYbqBq/xSXdxC9d4ExJqCR4fweCjWurLXyOugYnqp7llJ6vLZUP+hum0cquSaeCoR
 7F++6+JVB648Q0Eopw5IYtTCGtlx1zUPIcFpllpIPnP1E0YhAfegkNBIs4QODZkxfj
 Z389aWjkVGfGA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] cmd: eficonfig: create shortened boot options
Date: Sat, 18 Nov 2023 12:40:32 +0100
Message-Id: <20231118114032.19098-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

The boot options created by eficonfig should use shortened device-paths to
avoid problems if drives are enumerated in a different sequence.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Correctly handle the case that dp_volume does not refer to a block
	device.
---
 cmd/eficonfig.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e6e8a0a488..34a59cb15d 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -528,7 +528,10 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	p += fp_size;
 	*((struct efi_device_path *)p) = END;
 
-	dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
+	dp = efi_dp_shorten(dp_volume);
+	if (!dp)
+		dp = dp_volume;
+	dp = efi_dp_append(dp, &fp->dp);
 	free(buf);
 
 	return dp;
-- 
2.40.1

