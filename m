Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA7CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADB3E403B5;
	Tue, 29 Sep 2026 00:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4z8xNMyYO8Sb; Tue, 29 Sep 2026 00:05:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19DD140568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640347;
	b=MOpWHiOUG1kG3XDl8zhyxAMdMOZzTFiHaMFg/phWePAVKq5UFCMcm8ZYVS3BWZLvqmEv
	 Rxw7yIrhK8s64bnFfequklUbzZkfpM47eM9A68Py00NaDwqU2aw1Fv0E4FnjXLJXp5EsR
	 DoK/HEW7tac6ky5GalHc8vS0k3MceMRTJWw841woLzVHPX6YvOAL2deoyVjGsNv0n6yGM
	 tnFQ3VZpNsj6Dl6PkH5p4XNP7Ohhkz164R9dWuX2Kwg7mCjIAz2KxG5t2fuoBD2oVZa5H
	 VK2QRls0i19cgqxJR5776d38ldz5o1lmxYv0qPugVP1tC91WbeAhHuloXMPWNps5UPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DBHDOoDWNfx9rdmZLRh61KGkJEKXuDixhdVNwcxpbH0=;
	b=GNyKPpF4QhOLiuY9C1pxdsoGNAX1AnszLXREIaEZr5LGRG3Be0MDiiTqy7Tskp9TEjvC
	 iYdDX0gFVauu+HlmDG8MvEy5w7q+e6I5hP4cLY2Wy+7vJSZEMnG6YtUWMY3SvrjnnRkP+
	 xnuTE96smU0I6L1K+2qF0NBPumftLpZI7FlrO5Qb8i7XYlNHkFSCkTAtF2N4+7CCqxWho
	 YPn/ERh2tqcdMT0IV4c7z8dAz/JmNKm1/17eeoTDiztaR5T1Qba+uEESwLsHml8M+XFrG
	 S9Ij0LjeAm/TWu+rmmgPUJwXxUaIvcaLjeFgmu363QrEIcp0j7FUMqRecSkKP0RCzsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640347;
	bh=DBHDOoDWNfx9rdmZLRh61KGkJEKXuDixhdVNwcxpbH0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qd0cxDaTaVXOQNjtiy3O4ChK+XuwL52G5MYgVYMfJhWjTfPTJALaJ5MvQk2WAMrH1
	 J+ngEPZPTlkzwyH3HtiUnj2/r7lE7sFcfboypEcPCArKF2W3LKQl6KLlhGH9SFLLFI
	 yBNQG2NDFCiaVL3OgBhixiuAD9M5FOkqfQZQxaFkb+bC3Y6fAaAXcIiOoDk/LrDT2P
	 kl6MvDDXWHQmfgG2ZrxFfUtv6/ALfW82Lzgl8qQbh1npeb76/yli1XyxMBGmtBHWlI
	 euNQY4/WVsrUzYiqLH7VzZQrhqY4gfBWiQ6YioURMHJXnFXDXSdylMeSEe6DQGJpd1
	 gOYWnBhNq3MWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19DD140568;
	Tue, 29 Sep 2026 00:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A8D4CD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2C704024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tN7YhcwkOVgh for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1DCBC40253
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640345;
 b=e9ca3ZxKfd6LSjRFMZddnJEB4WI17NKQ6gXTzXOTsrFuadmN0RppvOX47xMmu7A70VA9
 IfGlNdG711g/g9tchcTiCH3KgYXK6X87sMSSAcZLCrdpCFu1ZtfFC6m1SfCQFp18TqxFm
 zvwQ1psaLePaeLXoM9kdnqEQJZCQQSC+PyPNigHWVMEBrfkzSyK1FxwO1BaT3tNWY01WN
 UAqEOLRnAsN/QCrVxjUXkyZRUosuXpNYQIGr6jPmVUChiG5qHLPGeiY/aEBv+ijN+Q9/V
 ufnkjta5qXmFWOL2b5oDPpCuzpoeGzLyMwOh9NDq9/KSvpQy4K0TyUVMAuIk5BpEe/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640345;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=DBHDOoDWNfx9rdmZLRh61KGkJEKXuDixhdVNwcxpbH0=;
 b=bTHca+fh4x88UMAw2Bz2kJI3jKNSY8DKF2f9GNvPM6cNF+o33Nnu5m9BDhrYweTovwXW
 F+2FNYaOmFhd3NWRDANj0rebMiD+U65aJbb4f9ZgW2cpQjTxwtd7uyVLeT4oz7T/0owwQ
 X1VDJQ3t9GTlpHUDoHFQqMMVSx8+vcOqvwAmNfmGufv5u0yW000ekhsc6bFNpgD1cML0k
 6fMPTguTMkiK6TUO8ycd4nQlBu8e7ThzCtZ62y1M9JgWf3Rpd2K6b7NCm0jDQyBQ2nwmN
 WbC9mFbyjfMV+Lvox1g0P1MAP2R1Dg+XEVfx/2Ix0noIMHpY+0ipGj0cehq4tfGzuww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DCBC40253
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:44 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLp-000000001OS-1uia;
 Tue, 29 Sep 2026 00:05:41 +0000
Date: Tue, 29 Sep 2026 01:05:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 07/11] boot: fit: unmap the load address after a storage read
Message-ID: <9ecd2cb0a242f1dd110422e8554df8bcd091b655.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

fit_image_load_storage() maps the load address to get a destination for
imagemap_map_to() and never unmaps it. The mapping is a no-op on most
architectures but not on sandbox, which is where the unit tests run.

Pair the map_sysmem() with an unmap_sysmem() once the read is done.

Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/image-fit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 60e47db5fb0..5d86342852c 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2190,6 +2190,7 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 	ulong img_load;
 	u8 img_comp = IH_COMP_NONE;
 	void *mapped;
+	void *dst;
 
 	if (CONFIG_IS_ENABLED(FIT_VERITY)) {
 		u8 img_type;
@@ -2222,10 +2223,11 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
 	    !fit_image_get_load(fit, noffset, &img_load)) {
-		void *dst = map_sysmem(img_load, data_sz);
+		dst = map_sysmem(img_load, data_sz);
 
 		mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
 					 dst);
+		unmap_sysmem(dst);
 	} else {
 		mapped = imagemap_map(images->imagemap, data_off, data_sz);
 	}
-- 
2.55.0
