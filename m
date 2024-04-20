Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C68C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215958873D;
	Sat, 20 Apr 2024 02:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="wAlOFM3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC998873B; Sat, 20 Apr 2024 02:04:45 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CCB886D5
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xjVKrPeMbquo1dgnRKeSpKmm2iBIjuNaHQyIGeK3fs=;
 b=wAlOFM3MlJpeUdzr+uq7ylcnVLJnXq5Qx/qYEFhWsa2V+q9+WGzf0eIjz6M74WD8EhoPFs
 02S1kIGScE3MzuGavk6un4lujguiKXdNmO8g+fOky8hyXUaRPA5U1rzoRBGIIKfzMu0mx1
 vfzL78RxTTlSlDkEytZLFp9cOAuCGmbuf+lS6hnOc2CnNya+4ed+t41HGjJmhRvmVXkB3h
 1+scbmwowShVxoRTBRVj34YZOhdaTe0yBNGjEWhBK/5/5w+vHdSbXpBONdrV0ajvXbTNCJ
 HI6xtL86HZAAXddXSE/75fD8khv5aCoKn/Z3dA/Po4FPL+u2q1ffgtrlgn3a7g==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:41 +1000
Subject: [PATCH RFC 8/9] sunxi: Enable display engine on H6/D1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-8-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571397; l=889;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=UgGLkRZ2qHEDDsr0f43iyWQk9eOPj/f6+OFtx8zlemU=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAVOS/d7VxEz8MqYn2iWuPVPm
 ob25oGP2LhsQ2erFykg+HaoecXPbUlC1fZPS4qDojDTiduOa8n/NS2awek8JeAwUAAOpg
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
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

Now that all the code is present and can compile, enable the DE2 so
people can use it.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/mach-sunxi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ddf9414b08..9d76e429ef 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -202,6 +202,7 @@ config SUN50I_GEN_H6
 	select SPL_LOAD_FIT if SPL
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
+	select SUNXI_DE2
 	---help---
 	Select this for sunxi SoCs which have H6 like peripherals, clocks
 	and memory map.
@@ -210,6 +211,7 @@ config SUNXI_GEN_NCAT2
 	bool
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
+	select SUNXI_DE2
 	---help---
 	Select this for sunxi SoCs which have D1 like peripherals, clocks
 	and memory map.

-- 
2.44.0

