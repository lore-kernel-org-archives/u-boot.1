Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DD2F3D60A
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 15:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4460D83E7A;
	Sun, 29 Mar 2026 17:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k/3xjTiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FAF84011; Sun, 29 Mar 2026 17:17:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C651083C14
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 17:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36DAA60054;
 Sun, 29 Mar 2026 15:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC485C116C6;
 Sun, 29 Mar 2026 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774797456;
 bh=+LvUE+V9kJ7Mm/fKNIbQo1Wlqu0hT7ZsN4yAvKXi1wQ=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=k/3xjTiw8cPwAMzq1JLAXjgGjsKgOPB48A5BniMMlK9OriMuFFzj5Jii+lEOstHWb
 ReOTxZZe3Z2llKy2+yqU/HHV2OB/YJXiaopD8I9GHUPij0IwTgrMpEa5EBjDiwNV7Q
 dhoW2JPo2ZplysJIugIEesIU3RmtuQztZzSftWaDnUBvsirNddwbAuM1x+wvODAIHX
 I1KNk9peWexW8zdhMYY/oIRV3lnK+RJccVQEXYk0bLZUh1+pa8u2s4RP1hxhCucKje
 Qu2qPFKP53N2s0HNo078AYSQvW1uX52AqL11gjoFRggQicw8RMvHH+/PewuKhwjagc
 W+X5MFELotXmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A945AF3D60A;
 Sun, 29 Mar 2026 15:17:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 29 Mar 2026 17:17:33 +0200
Subject: [PATCH] boot/bootm: Disable interrupts after loading the image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260329-bootm-wdt-v1-1-f46b3bc6d50e@posteo.net>
X-B4-Tracking: v=1; b=H4sIAIxCyWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNL3aT8/JJc3fKUEt1kU0NDC3MzQ4tUMyMloPqCotS0zAqwWdGxtbU
 AwHozGFsAAAA=
X-Change-ID: 20260329-bootm-wdt-c51187618e62
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?=E7=89=9B_=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774797455; l=1473;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=zPsGfFMuExAJidkBX5RFyv2C7XhSoz2IUlILWWWBH5I=;
 b=hO2Zorae2qOXNp3SbKtYEfFtCH2IWBWMFI86shCJ6CW/qDgH3lHIJ6ZBH51mMLY5/IvlAfFXL
 BLpKWgwlzkCA5P5K9t6ReTTduMMwvJpkFlDs9zZeLYEcOYzXZ/Z42If
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

Interrupts need to be disabled before we jump into the OS, but currently
they're already disabled before we load/uncompress the image. This has
the inconvenient side effect of taking up a part of the watchdog time
budget, which can be rather large when the image is big. Ideally, we
want to leave a full watchdog time slice for the OS, so that it has
enough time to initialize its own watchdog driver. To ease the pressure,
disable interrupts (and with it, a timer interrupt that could service
the watchdog) after loading/uncompressing the OS image.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 boot/bootm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..fa4b53050b7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1015,7 +1015,6 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 
 	/* Load the OS */
 	if (!ret && (states & BOOTM_STATE_LOADOS)) {
-		iflag = bootm_disable_interrupts();
 		ret = bootm_load_os(images, 0);
 		if (ret && ret != BOOTM_ERR_OVERLAP)
 			goto err;
@@ -1044,6 +1043,8 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	}
 #endif
 
+	iflag = bootm_disable_interrupts();
+
 	/* From now on, we need the OS boot function */
 	if (ret)
 		return ret;

---
base-commit: eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a
change-id: 20260329-bootm-wdt-c51187618e62

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


