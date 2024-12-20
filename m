Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80138E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E703B80087;
	Fri, 20 Dec 2024 11:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mhxd4tM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3324C80362; Fri, 20 Dec 2024 11:38:08 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210ED80087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A882AA418A7;
 Fri, 20 Dec 2024 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB98C4CED6;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734691084;
 bh=S3ZtjA26xYBC0lTUNchBOZUB0v+N6NLJ0CDbIgoU3LI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Mhxd4tM0WtPF/BMIVZNbJz14pkFOXWWlfRVPbCP/2Ls6PDxfx8z8QwA/RSb0W73ng
 634aQ0jZtBiR0gGEhaEWc80d5hbwEJFWPXR0BQiLOF3GZ/xknr7gIjpab05kbturuf
 vM4ddIVwHG9WCJINmJSP2BHXPdy0Xh9KGvxgXmBDhXJ4n6yTnf3YGVcRFRH1+dfjCC
 NK4Ly712nUo+U9TyLB0YRV6JNntOLI5Mh02KrykoOAgjfbW61q2l/K4TRX9E40Yzy3
 3MzHT3xk9GWHcbAY1lhLbhJ1Pny23K0ky/Z5+MxCapYoWQ30G/Fp6pUEryQeYosIK5
 743/GFMOt3t8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B8172E7718A;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 20 Dec 2024 11:37:51 +0100
Subject: [PATCH v2 1/4] powerpc: mpc83xx: Fix timer value calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-mpc83xx-misc-v2-1-ff4c17ee5fa4@posteo.net>
References: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
In-Reply-To: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734691081; l=883;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=x0ia0jL8u1gi+3N5LzNhvLJqux0qTzIoCLuH/bt/yqY=;
 b=q794xZoD49eF4H212C7CsF5qWCT5HJgB61Pg6akeixhDfVTAYnNCNuRezKyD+KX3fONYuxCc3
 uzbvYRA+4I1Bsz0GdfSLliV7IcLcBr0LnAA82zG+zzwmG+FdY/yMeGi
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

TBU and TBL are specified as two 32-bit registers that form a 64-bit
value, but the calculation only shifted TBU by 16 bits.

Fix this by actually shifting 32 bits.

Reviewed-by: Sinan Akman <sinan@writeme.com>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/timer/mpc83xx_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
index 9da74479aaa678bfab861950a770b216b604c433..f92009e4ccc8256d4c5f4d11e414dfc141f5a043 100644
--- a/drivers/timer/mpc83xx_timer.c
+++ b/drivers/timer/mpc83xx_timer.c
@@ -206,7 +206,7 @@ static u64 mpc83xx_timer_get_count(struct udevice *dev)
 		tbl = mftb();
 	} while (tbu != mftbu());
 
-	return (tbu * 0x10000ULL) + tbl;
+	return (uint64_t)tbu << 32 | tbl;
 }
 
 static int mpc83xx_timer_probe(struct udevice *dev)

-- 
2.45.2


