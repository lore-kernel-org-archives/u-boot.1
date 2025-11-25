Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EE0D0EE0C
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 16:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F556840ED;
	Tue, 25 Nov 2025 17:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pOw03MSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C29A840ED; Tue, 25 Nov 2025 17:15:21 +0100 (CET)
Received: from mx-relay163-hz1.antispameurope.com
 (mx-relay163-hz1.antispameurope.com [94.100.133.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8092840E0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 17:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0417def1e3=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate163-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=k/7DIufJiJVQlQtfzNnEFpo4gRBZIumW/M5bXxAhrQs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764087317;
 b=hfFfNM6eglxfFI9CzYgRfABl4L18IdGZvrqiQ0QWxrP7EPzf0esTRRStESi5cTbPe9EOLSa0
 ZpXjYXy4DhXrQj0qFrL724U+XSLqO3oERKAbWnWlAo5xC6ss3SoUG84YRCBhlioWixXWtjhi8b6
 Tzj6ey6Nlcx4yIo5ZNQS+ULhIheqLho0wtfy4JyI1ugAO+P1foNMp4zKDYxMySo0VWuvSlMAM8N
 QHI7eZA5x1MGo18fvha/Ri35m0dpPbuiug5DqTNp3+Tqrf7BDi9oPU0y5QtaQWfw1/cPoQq8wes
 cE8WVwjGRPrtRUAmo7yCp+nIJKOi+aYL88uNN1v65ImzQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764087317;
 b=WF02V8Zw+fF+Qu/pjwqTYLOXjkFjSuOKAbYSfoKqluCauV4q2x2SbL3EnHyaoAj27HlR/K67
 GayAUkOxwAZRvQYWZMTQtWTK1YADq0A+4iECpMEsjsERxRsabQ7WKN3AuIwluqJMXhaE2W0dryA
 hjMlFZyOYEw5RyQIGO8Wau5iFQ/ap9uOo0IwNM4VKfMa4NrI32i3ajKXqpsIQhkGIKem0xUDpd4
 vkUMe4HUBODKMJKYMrYGbpi4yNW9CyOEBfSrWpycipTg4++9pusxTkb6LC1Yrrg8B3JyqwTuPZ8
 wiss7xDwW4Pku6KCZEqX8XfTxrOFxQfTGQLFW9lZ5760g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay163-hz1.antispameurope.com; Tue, 25 Nov 2025 17:15:16 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 57D19CC0A1D; Tue, 25 Nov 2025 17:15:05 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [BUG] silent hangup when debugging lib/fdtdec.c
Date: Tue, 25 Nov 2025 17:14:12 +0100
Message-Id: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay163-hz1.antispameurope.com with 4dG77t036Rz1Z1m4
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 4ede2fffc9ab647837e22f61aed7829f
X-cloud-security: scantime:1.968
DKIM-Signature: a=rsa-sha256;
 bh=k/7DIufJiJVQlQtfzNnEFpo4gRBZIumW/M5bXxAhrQs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764087316; v=1;
 b=pOw03MSLAMIF82SCLQPMimAYh9PIpiu+wEWENT2OE2FPWUsmAxVXFX041o/sJloBu/XB0/l7
 +ieKwMtzloorLt4UAt7gGcWojTQaqNBPtc2Jhst39RZYMs5KMYWHHn3VtX15Pd+a9QxoanOOCmA
 ze7/3Trbfb+o5rCuOf9K6tRaLVXFWk9K5LatKc+zGe4d9t8nTzWyey0GFgwmde6IjJzpaBhJEhx
 S2p1kf5/1lW2cN2oGtB7OzSRxzQHz7Nqd8t6HDCae90osiRwpf9wQxFmRfpMYVEpviXSkuua2jm
 XCpUjO8PEjhO8Ftgl7UYdj30iOTlt6mb/Ga0kT2geIb2A==
X-Mailman-Approved-At: Tue, 25 Nov 2025 17:48:34 +0100
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Description: U-Boot hangs silently during boot when enabling DEBUG in
lib/fdtdec.c

Not sure if its really a bug or rather a configuration issue on my side.

Minimal steps to reproduce: <see patch>

The hang is caused by `panic("FDT overlap");` later inside the if block.
(see `lib/fdtdec.c:1279` in `fdt_find_separate(void)`)

Additionally, no boot log can be seen because serial is initialized after
loading the devicetree in this boot stage (see `common/board_r.c:665` in
`initcall_run_r(void)`)

Tested on i.MX6 with configs for tqma6d_mba6 and other tq boards that aren't,
mainlined yet (tqma6ulx_mba6ul and tqma7d_mba7).

Any idea what to look for to fix this on our side?

Thanks in advance,
Alexander
---
 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..0f2f7c948cd 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1257,7 +1257,7 @@ static void *fdt_find_separate(void)
 	/* FDT is at end of image */
 	fdt_blob = (ulong *)_end;
 
-	if (_DEBUG && !fdtdec_prepare_fdt(fdt_blob)) {
+	if (1 && !fdtdec_prepare_fdt(fdt_blob)) {
 		int stack_ptr;
 		const void *top = fdt_blob + fdt_totalsize(fdt_blob);
 
-- 
2.34.1

