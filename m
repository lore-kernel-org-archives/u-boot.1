Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39412CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 20:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F0E848DC;
	Sat,  9 May 2026 22:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="lOLYyLOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D29848FD; Sat,  9 May 2026 22:31:51 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF61846C0
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 22:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 1ae31c9e-4be6-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1ae31c9e-4be6-11f1-bea8-005056992ed3;
 Sat, 09 May 2026 22:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=5vc+KDgk/FFRdEgtdAecf/7iOhq5EaBCw/QK4WfYtyg=;
 b=lOLYyLOUaCBcIuqlAxrxTD3wdDjF+4z/K03rG7XgX+Qm3oFCfEjuPV9fOsVNAZoEll+BOMGfmAeH5
 CNXjPHk/ak39pyTkEUdEUmGwUHnhRB+7PvwRe9dlptDHY7PCgPz+TI+loLZC6jhxGofp36ADm36pNV
 45n1ucqX2S105jcc=
X-KPN-MID: 33|+fnVDqvbTwzKCOhJ5g8d52rZ+yzOjCxZms0y5OIAMzlc7Barhxw7FsshhoaODiu
 cONNadVtw5XgdjfFaw96wxqiT4+EKPzs0mdQWD1mEyiY=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|YU5F0Z/Vyyat4i2yUTE9WR5xvFWGZaxIF6FGP3NPfsQcwffCDh5PEf9tJHgaivj
 l1Nf/ZEdkrFnfaF2J+QphlQ==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1aa69706-4be6-11f1-bffb-00505699772e;
 Sat, 09 May 2026 22:31:49 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] smbios: Do not fall back on devicetree without valid mapping
Date: Sat,  9 May 2026 22:31:36 +0200
Message-ID: <20260509203136.46745-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.53.0
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

The smbios_get_val_si() function may get called for a sysinfo
property for which there is no mapping to a devicetree property.
Avoid a NULL pointer dereference in this case by skipping the
read of the mapped property from the device tree.

Fixes: 83b28b55d74f ("smbios: add support for dynamic generation of Type 9 system slot tables")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 lib/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index d5f18c8bd69..906d2753517 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -292,7 +292,7 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
 
 	/* If the node is still missing, try with the mapping values */
 	nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
-	if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
+	if (nprop && !ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
 		return val;
 #endif
 	return val_def;
-- 
2.53.0

