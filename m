Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396A606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mBvPWXtr;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=fM/fgnFJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2BD1812AF;
	Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gz9dcVlMu1CN; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B05281288
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406880;
	b=PZKrZuSuUq8ByhiX5yCKRVbamJs6gAeZx6YlbTgausCUjIRhOMO2SqmDnIkGSYusJMwR
	 PuRrtcpEAhyCcmuhrtaMiA7S+FWrdTctnDJn7MyfjUCN04nau8YLe5vM/R92UsVeuCA81
	 zEyPFzT/JcM2inpHAS2B3MGhzPazBO6ETgFyyfKjz3K58aK3S4z/7VOVpqM6SJptG9/ef
	 /SdnBJI292KxzYxBX/t1F709FcZCBE8r07EmowABpD1+PDgfr1Sl3JEzfWJWBgQk1cjfs
	 44W7Uqj8ok0uIQOA8Vfn3GlFSZiuMmHy4tW4MVWlMApUmzrL+6EzzpP1GanIj6VMuiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WQV/lLfMN8U1I0Bcutj6auwbjD7fyJZj4JsT6f+Uj14=;
	b=gpuHiH2Mc7NrodDzxns4sTar69slrWgSBlv4Jk2hRh082e/lmvO1tRrH8QIKFHgThDI6
	 F0gDym4CARe0ibSIB+XGq21Eam4VjeFdsAAU2hG54YbLM/twQYyrlbUtjoxPZ/VlKCtEx
	 HUd0EC98TrQY1JBz+1qAyW8nBM9GrUf7JLNs6KT7tGSXRHD+gRw+psj33JU0E2+ySn9T7
	 GhHyqtB/UjpDjUpBDl24ZvH8VxziAfCBHDK3fOyT0+hJEc03MMSKzHSJM4yN8+YkpwOL+
	 ELotKeKreoIo0u8EzDTupCM9SWJZc9q5YM4dzo6AuQPLinmSCatQaQx7vWmxCyCABjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406880;
	bh=WQV/lLfMN8U1I0Bcutj6auwbjD7fyJZj4JsT6f+Uj14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mBvPWXtrzIM6RyGrWSKK/nqAbPdUsKbh5Va8Cb98thpOi3FxyM4IzavMOGRQdh/wm
	 /nqoKuie429mAxDckcYu1l1UKxUpuo2w80ur7+nANDLCRoHDcOVfSuL+Nlhu6zevJI
	 sdLZqTW5m5T7GPR4hYKG2GV7YMFWnE1nhzZXVRJ9DBFpzdZeLtMD97gGpawUhWl9aY
	 tW8MHqrqVVqXbJPh8LixYnWb0JmwkRLzW2ByWQWW1GpzcRf9HK3Pg2WQXbuyxf3jLc
	 mfl13Eu/tWiiA01YDQOhadEa7/XJTnc4WQ4hhob5M86roHTHRH/Tpv9VIS8uzfwooM
	 bXw8RRXYLWI0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B05281288;
	Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 988142FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89EDA60683
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UD69_DT0izZG for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 137346069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=fM/fgnFJ
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 137346069A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:15 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 76538214D7;
 Wed, 11 Nov 2026 15:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406872;
 bh=WQV/lLfMN8U1I0Bcutj6auwbjD7fyJZj4JsT6f+Uj14=; h=From:To:Subject;
 b=fM/fgnFJ/OYgnl8z6ojraZA6UTCkLs8M6Qj+9GwHC0SKz69K/mqDsnFj9qoyM9+IW
 6isrfmUUVQFxpWt6bZ0DgQWplwWACQN2BQLz+nAfS/HvhWx/RWRq9ESUnmVr/9+zcW
 pCC1rrVy7+b1zBsGOp/hbIlcOLmQ1OPu2m+4sP9VpkELiKcfO/DWMdNR0+Na2uEtIt
 9KzeIMwiX0UGCXEcHevrAW5bItwHsM0ES85hBbNaw6+Qr1aK2UASf7PLej8LF68+Uv
 ipWHKmpsAom1CmlmnXjNy91GlEGIZwZtD3AN/4PlNzKGlK7UOArgM9dQnDyc7cdg31
 YAG9OidyvXNGA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 03/15] board: toradex: aquila-am69: initialize ret in
 spl_board_init()
Date: Wed, 11 Nov 2026 15:20:51 +0100
Message-ID: <20261111142104.109139-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

If CONFIG_ESM_K3 is disabled, ret is read uninitialized by the
subsequent "IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0" check, making
whether ESM PMIC init runs depend on stack garbage.

Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/aquila-am69/aquila-am69.c b/board/toradex/aquila-am69/aquila-am69.c
index 45fba1bbfe80..9c9962d3d7db 100644
--- a/board/toradex/aquila-am69/aquila-am69.c
+++ b/board/toradex/aquila-am69/aquila-am69.c
@@ -204,7 +204,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 void spl_board_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
 		const char * const esms[] = {"esm@700000", "esm@40800000", "esm@42080000"};
-- 
2.47.3

