Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777660A262B
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NlnGhv+J;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=ElZwR/xz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M7Y8X2XU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 516FC40E95;
	Fri, 20 Nov 2026 19:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7z1GHYcyBra; Fri, 20 Nov 2026 19:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65DD140E8B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795201282;
	b=NZDQrAVTLf+ZMYgNrq24S3udtkOj1WEWL7e84GfKpi4FFcsJD4yarKG25w/KClPCSpYV
	 GhDTa4M5MqPL7od3LqDeM5G2haMceB8kZ6uGPPyn01sCQIenHvf0F1jPz1FDm76LDyyRS
	 LPPBiH1CKoPt4sxQKRElDgppQSTCnEJCqT2/vj016L+E/iEhDTqGOWaSUY9xIZiUyU0Gi
	 Zi6E2TEWLKozzJ+owBotekJpfpGpxqEWeXhXXfrH0V5JeJ8Vbpk7IqQAaz1JEBp1ZOTOm
	 QUY9dBoCk5dEtA8EdzJYW7vQeJ8HUzLetLXnrchp3mFcwjTggwAcqRM7tqlonZQNJsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795201282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:
	 X-DKIM2-Info:Message-Instance:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oVoP83ggWFPXDYTcoAal9k2BMDxpCltyOYSeJ8tbDX8=;
	b=AcjeKvMu4K5U68fLjV7/uGq07p/TuvCbmENSxljFMIlENHGHh4ibAonxVONdVAMsN5t/
	 qnEr2y1QXvnIFb06LiHZ/EewVhb1XTfh86sJo8asH4v3CHM1Mf7ROvOUz8j4qZslqZRkW
	 KzolTSjwJLDGWP0CNQcnvgUcqDqq9XwTa9I3EjSwnJ2t9MGgNbuA5pTvgoF6FddubSUGV
	 kBlxJqisHkDSTvOrCtN4ZJ0TMQ2OJzn/ETLD4XW0fCODm/GxxmZKBUMIki/1EK/WuSBnc
	 27aOcpYebllAVQeFCzCYRy8WvOeoS0g/hpZFFRjz9YGd6mUJ05X5DNgSpZj0sVBX3oQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795201282;
	bh=oVoP83ggWFPXDYTcoAal9k2BMDxpCltyOYSeJ8tbDX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NlnGhv+JynXPC2dbbGkkBE+d1XT8njM37D5lry6xPNSSRyhD89z2L/zCOhPWdRS0M
	 qZvMapA30P09oNDlHwc4GYrNdvg4v6DlH8G0G1xd6ICrqKoXjDNk9yaH+Uw7MxkjrP
	 fCbweRGgU81K9QtaqQ/cu91nz0ksFXMOOBsV/yW2s/gliHP45zKOWRvaX0O366qjbx
	 1q7DZg6HKtUa2ftygwnRXTpAuoL3qNA7jv2+YBYDE7VodP9pg8QdtU5FTjY+N0Y+Bg
	 PyV66yp80HrlubU7e1UIH+wwdcdZ3DJdqFuNO0UlUNK1JUagoY8Jn3+NUu1uKaAN2u
	 yuzQlfUfAfTpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65DD140E8B;
	Fri, 20 Nov 2026 19:01:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 743EE465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6633D8109A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hi0sVRhfRInJ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A712805B2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.151;
 helo=fout-b8-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=ElZwR/xz; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=M7Y8X2XU
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A712805B2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:19 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 75ED71D00477
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:53:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 13:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795200805;
 x=1795287205; bh=oVoP83ggWFPXDYTcoAal9k2BMDxpCltyOYSeJ8tbDX8=; b=
 ElZwR/xz+d0wey5XwQIaYjBwZfjxl7xeMyGEKZLYLU9t7B0vzTL8+F+dlECHPujz
 fwxWR3bnNEVs1MttI3zp2PN9yoVXpgLgs87Ny0DoOxypMu4wwQ2Fpav3lEBzbLRC
 BygmD2H7THruvlXIwgxkC6DKHpeEGUx1w5ztsljdeX2zLzmpd1p9C6Jjo0bLKd9H
 Sq6HpzWJ4Rkavm6D8e992fXT2+7wM3p8OAx5hx6cRItDJBCFgdPDoaKv1iyWJQ7J
 4RRC2hDdz3U6en0rftmxHT8mnS35CUN/B4qqGv0P9Yu2fI4wpzwz7hZqn8KcsSzj
 8t9aZTHmQ6z6iG2HVOAO5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795200805; x=
 1795287205; bh=oVoP83ggWFPXDYTcoAal9k2BMDxpCltyOYSeJ8tbDX8=; b=M
 7Y8X2XUvLOmidUjllIGnU3Inx4PwwNTi7KHsvnO+vDbzizGH0xduHoDdjieciCpn
 9uYdSctzNQ+iJQrXTbHHdbOpqp776F38hHKL2QlbKW5HtTFOH+GXoUaAc8OAwIWy
 QeY2jxen/viCv6q9dQfyXGLVzW++O04j89k+A5DMLNx3xlxvjwo/yAQ8I9fslZMc
 cNskgtlYSOFduq08He9Q+gss7ItWNvGpMSXyuo2DI3DTWnpTZmwdJmSLnojO+ydr
 U6pBmCQTiATCoBY39RszSqZWzfV7jOY4v6JESf91LvDBnDk6+hxzlgnS+nE0jjCE
 MhAYEysn5EFxuOdMEaHyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795200805; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm2:rsa-sha256:JzqVJWZZockzDas00yHbyHQ6fDveewF6WZ6ol1hwqb0hOpe
 ywin38W9mYtuscQhnsmYSgzTf2hNsQUdrIH8VLGWe7LJFFYC2bChCh7XO8r5h9Sd
 8nfY1479/dFCmHLQuGxNZaNYw3YxxFKjrj80JAthdhEKWnKH4a7pO23oUm8KJIwe
 K+5Wnd64r+VaNV1aCalB7+yKW7W5gENZCcAw9mFatPcfDxMlmMI2qtHb41wrSneO
 bmr4cAa6P9uMY4NHdGIu+7j7RM1IZUGjiCkRmf6RIHltZbizYsSs9nPjwMCgooka
 rRAWgyt4dsaGg4RN8Syi5YDVsP3GrDFgro3Pc9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:f+bc0NGs+mnRC2JHoYQ+07syHXm6BezjGZDe+D2lcek=:tIvWFHenM7LuUPbl/Xzfep5JQL7SOnhq+P5uL8nGdxg=;
X-ME-Sender: <xms:JZcAa5Fn4ztFGZ1JsHJ0pMdQ_Q1MmF5WYotehjxG2pMTShENANGPpQ>
 <xme:JZcAa4V8dHuRi1EgNE_VphCYdxS7yPwHrCc1QMd9XdZBNIY2djVaka9TqYyOWmfue
 Mu7ijmFebihe0TjD-tvkXeKH-PY_NZe3c__a32cLg6bfXvyc1DlJ5A>
X-ME-Received: <xmr:JZcAaxwRU4EYMzIXSadek-T7eE9eDZwmvfNzLGu794PfT2Uvb5PGQDDMxRZ5yVOW8bkIE22vchjBoTqmWENCabjBott89hhS1qVXHQ>
X-ME-Proxy-Cause: dmFkZTF40NY3j+ynN54GON3MNlAVzxJLtPAx2Hedsg+UjTHj4zhL7JTRhAJpFoXsLtvn+d
 lqP28eeB/BzEKpHqS1aE0+eMkKY3CaL4Kd1ab7pTKj71pDm6Q2932xedD8+/6RWYLt1Czy
 se4sW5hWg3zR4ZwAPtaB4BBpz3CUPGBBKncmjcZVDZeuALhJjD010wD8WQDSVMVovLzHpd
 eX6y5K5z3VcfqK/1d8wCfoxHFm7g39w/fJGF/1QrK6LIeZvtqkFpz4Xv5ssVbGumUJwN71
 AOtPCYYcwZGGBR8w+SJVJHQmuAE4PQ82dv2/TzBiysxC0z9kpgUlKX564Oj2+rPjlig4Qf
 20znYb1+KMGS/+p1o4Bt5b9w5V6/DoD8q3ZTFxF1tOMFr9A2VkweOHal2tSkqDzl8PRKVB
 4+diq1nJu/7X/8ZNPaYGz1XWjwlzMUCe9ZbkCagghCjEMjsIxHyEEi/L/ZOpavzqeOPPXc
 x1lcA+pLxdWsyQ88+h9wH8TLbR0ZVL2S+uMJZGoZVX9464jgzN1q6eW0M4E6wNELkTFLQZ
 Okdak8bxPo3ZNfhuirQFmR+omE6jbxLEMUn5mEWTEFShYe9BI+MuAaWJqeMW+wFxfED+So
 JcfftV/q7+1yAOX87/HYbHw0AOn/bfQ2Pdr8QebijbFxr0HQ+df/opEsXxAg
X-ME-Proxy: <xmx:JZcAa9RuRaAdRuRtXDkcpS8ZC07cHZMKULQ-3qnJqFUxaKsfMb946A>
 <xmx:JZcAa9j4VSWYlS7ii17eV5OOwm2CaZmXO-A2CQz_T2Ff_RK6F0BKaA>
 <xmx:JZcAa0nkAA3SAjSVMEMLs3lOF3qSXBDzAIizLFVYoYtZJt0bSwL6UQ>
 <xmx:JZcAawue5J65O8mTZ_FQm0fr2U1M3wyGqIo7snqKwz8zdUyoixmX0w>
 <xmx:JZcAa60l8uDCOxQO4aHlLwfXu3hwbGa2-DwhfFsfwD3KVcdFUGOoET6l>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:53:24 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Nov 2026 19:53:09 +0100
Subject: [PATCH v2 3/4] arm: apple: Add Apple M3 Pro and Max (t603[014])
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-apple-t603x-support-v2-3-606b4f5fadc5@jannau.net>
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5159; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=tIvWFHenM7LuUPbl/Xzfep5JQL7SOnhq+P5uL8nGdxg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmyG6eJbZb7yfI9sCsw8nJZ2P6dBN4PreFrp3I5j7Pqtk
 zWM563vKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJGAVIZ/ytZlW66dWu+vtOSX
 fP7B8Imrd2pf7rQ+6Xv15sLsV1aPyxn+V79cvfqKwObS3VzMh1bIaP7RPJqdmjr9ld029yMzmmu
 fcwIA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple's M3 Pro (t6030) and Max (t6031 and t6034) SoCs are similar to
their M1 and M2 predecessors. The MMIO blocks have been extended but
M3 Pro and M3 Max still share the same overall layout although they
aren't as similar as M1/M2 Pro and Max.
Most of u-boot's existing drivers are compatible with the hardware and
M3 Pro and Max device trees will carry "apple,t8103-*" as fallback
compatible strings. Only apple-atcphy-reset will use a new compatible
due to USB4 and DisplayPort changes relevant to the Linux driver.

Acked-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c        |   5 ++
 arch/arm/mach-apple/memmap/t6030.h | 104 +++++++++++++++++++++++++++++++++++++
 doc/board/apple/m1.rst             |   6 +++
 3 files changed, 115 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 6b3a0225f9ad..c93c3bd56aa9 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -20,6 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include "memmap/t6002.h"
 #include "memmap/t6020.h"
 #include "memmap/t6022.h"
+#include "memmap/t6030.h"
 #include "memmap/t8103.h"
 #include "memmap/t8122.h"
 
@@ -72,6 +73,10 @@ void build_mem_map(void)
 		mem_map = t6022_mem_map;
 	else if (of_machine_is_compatible("apple,t8122"))
 		mem_map = t8122_mem_map;
+	else if (of_machine_is_compatible("apple,t6030") ||
+		 of_machine_is_compatible("apple,t6031") ||
+		 of_machine_is_compatible("apple,t6034"))
+		mem_map = t6030_mem_map;
 	else
 		panic("Unsupported SoC\n");
 
diff --git a/arch/arm/mach-apple/memmap/t6030.h b/arch/arm/mach-apple/memmap/t6030.h
new file mode 100644
index 000000000000..5d2061a446c4
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6030.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Janne Grunau <j@jannau.net>
+ */
+
+#ifndef APPLE_MEM_MAP_T6030_H
+#define APPLE_MEM_MAP_T6030_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M3 Pro and Max */
+static struct mm_region t6030_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC2 */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC3 */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6030_H */
diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 66ed247eca26..3b4fb2913981 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -16,6 +16,8 @@ the following SoCs work:
  - Apple M2 Pro SoC (t6020)
  - Apple M2 Max SoC (t6021)
  - Apple M2 Ultra SoC (t6022)
+ - Apple M3 Pro SoC (t6030)
+ - Apple M3 Max SoC (t6031 and t6034)
 
 On these SoCs the following hardware is supported:
 
@@ -87,3 +89,7 @@ supported SoCs.
      - 0x2a1200000
    * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
      - 0x39b200000
+   * - M3 Pro (t6030)
+     - 0x289200000
+   * - M3 Max/Ultra (t6031/t6034/t6032)
+     - 0x391200000

-- 
2.56.1

