Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7F4C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31CB082893;
	Mon,  5 May 2025 14:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hFVsKMBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0290082102; Mon,  5 May 2025 11:17:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFE981FAB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6B9655C5717;
 Mon,  5 May 2025 09:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE9FC4CEF1;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746436632;
 bh=733TZKD1rUkMmEpMYi+ejDfy1uinBRKJ8pY4VvIFN3A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=hFVsKMBf6Kc9m5NZNc9T3UJtVyNRKlldnjxJ13fJ7zMgYXt+0n2yQdlM46Ea0KVeb
 YVOFpE5WgU1uuTHImrBLHeuKnsd3Q/EFy58LWd9bJpWRmfqR0LofX7FJNVHsdVcJ+k
 M5INl3dbgXO8tbybo8DuUs+OMD4A07xXj3St6Z3Affc/XulTcO5VkrM5ItwBdboL33
 g/lRdvEC61h3KuIO58Tdsw1718QQ82WrPKFwm2DtgbNGgJHuQfm6fvZGYHuCPRkZwO
 Qyao7w0oGuNjo1MnkVZ4B+BZs908+E835xclxEo0VrwT0znAWPtb485Nq43IojwGGn
 lQPRMPupPP8iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 32904C3ABBC;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 05 May 2025 17:17:12 +0800
Subject: [PATCH v2 4/5] qcom-phone.env: Example of new env var
 legacy_os_boot_param
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-android-boot-v2-4-92dcb5bf59c8@gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
In-Reply-To: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436629; l=839;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=HgRzW0yhUc8yhUeP4sq42vjx20KOLqwxVwT8pR9drO4=;
 b=qjYIz76A+Y9bedhQNSPUtQKJkaK9mTv/t3Im1mf0QwgcskFVkTqyrKIXGYuGYASmLrPUY1aVT
 SiBYNbR28OMADjBIEKhI/NuhHR4iMtIc44X4il29B/irQbtAKBWqaBV
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:34 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

This is an example for newly introduced env_var legacy_os_boot_param
that will append 'console=ramoops' to fdt bootargs.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 board/qualcomm/qcom-phone.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
index e91ae3ecdfb..536467921d8 100644
--- a/board/qualcomm/qcom-phone.env
+++ b/board/qualcomm/qcom-phone.env
@@ -4,6 +4,10 @@ stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
 
+# Introduce var to hold legacy boot param, it will be append 
+# to bootargs automatically
+legacy_os_boot_param=console=ramoops
+
 # Fastboot is keen to use the address from kconfig, but we
 # allocate its buffer at runtime.
 fastboot=fastboot -l $fastboot_addr_r usb 0

-- 
2.43.0


