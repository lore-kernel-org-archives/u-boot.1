Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE5ACA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED0584056E;
	Tue, 29 Sep 2026 00:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cn2jlkt8uzes; Tue, 29 Sep 2026 00:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CF0840568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640321;
	b=QMt8Wo0G3msWjhMdtgcHzoz8Q3amz3wIu7U1435+2mAKw8Gz2idkJrNpQzTYOIStxzaY
	 cmj6EUyQ6qFp7QAeNPZ413xGDV2TiZy03xYqqiZS8VSvWB9P02LBBrG926gtBGktpTDn5
	 /f8FWQi8yuPF+oUTgDxCLQOD5HTClNGwJTyofeQiQnsw9JiD9GHxFFxMZlGZo8Mus81rA
	 0b5bIju8u2FsqzVvwHJp+QrrkwJMndH71Jq5qazF+OUBOiBJtXxa4g+3tMoU/x+EowSLH
	 VtrpikF2GJKVoaW7oBTWKJBlkQXIXeg3sAgLpVSnyJbIEnR625Jo7Imk++FJ+7i64mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=41wTWhn3Ukedb6sz5Ya7PwiM2g5yYp0vmyAy4GOIkpc=;
	b=stlUaFplkXoilatrRFb0BJWnrwbz2k85eE7FBoFP6QzrQT04ytYYfP34aW6Ar+c8yd6x
	 jTKhN0Mv4PHkEWdYBtqEy6oFZKHxYDumTsLPRlPfCskss0F4dhoxG9/1zvVIuNHODR4Jm
	 MUbyAjDyciMyCSS1THMHIZoTj0Z0ptxzc9hU+zKSW1WoNOZa88Cdy7sbzNKL+ghjp8VZJ
	 Tq6iA/9YhiPtrV9HIZJnFEvQ/jIxnWwnQ+s9w0Rff2htadI9ttDN9fzkBAHz9fRmKsdgY
	 iPzuiI/yjGPkGhRqbYsNNIDpIaD2rKTvvfz8O8i4Iam6smhU0q+lPQ41JwEce5RN38Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640321;
	bh=41wTWhn3Ukedb6sz5Ya7PwiM2g5yYp0vmyAy4GOIkpc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJpnDj3CRrA+ifjBiD0OKIbdeze/4E+On/wXX8u6XtJ08Yq+tQl4c+4s0UuvT9Ut9
	 2yLedOyQqLG6Jmp8ajHAnrje07KvD9OlU/9o3zwdrp+O/cMNE0jGVX+xsYtXC7yf+Z
	 psXMSBqhYNh8oil9Cfxynjtf338WwDK9Yq7+e9EmH+Uvycb2X9fgY7+0waLzj/4Sf9
	 +e3hAVW+JB18cIfzTpVTXSV21QjEPsH9GGfsuh+DT7qp7D3zd9doUAvRaezCdvsWF7
	 m4PxhFzvglXOp0zwRrJZ9NVswOl6rQWDKdHgLoc2wQhRwPFzghKQvHE7igBTLO726i
	 aTt4TMM6JqPxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF0840568;
	Tue, 29 Sep 2026 00:05:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4180C417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23376403B5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hc7j3ZDJueAj for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AEAC40568
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640319;
 b=TJBfUJJkB3rLKT/OSJM9l7ZHceAqwCk8loCkWN0qCBjQ67lozOFnQkcn39+jbVhALC8H
 rg3dVDoL0Cyycs3gMBTlOCGrQigaCR7SstC07pmEv8Lx2p0s2dAdkh8kvv/ikw7Fn5tUK
 botS6D5ABLK13eDjUOvAsg96oYqyQm2+g6F8dqxd2WZA0+VO7dirlEltwt0/ei0y9VWTZ
 lvV71T440MtzkuWIisdZJgRpQwWA2fRXKbNlyCmWk3HBqGp4/rYNTCM/5jFFMfy5IMtMb
 jrT0v834PiS3k3saPzlWtxcpK66ZvvEarEZzjfLWYHxNVtd/zlv+VZJqLv+7sMuCuNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640319;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=41wTWhn3Ukedb6sz5Ya7PwiM2g5yYp0vmyAy4GOIkpc=;
 b=hvcyA2txjOcDgJx0fpxkO1LpEig4lqyYmzd8FNV+LDn9O/I0gZqR+1rLOhinIVvKFn9l
 XG3VefqXgram3lrQIsdWG/OP7aLuXkAaaCqnmt1ENZcJhT+TcRupcZbNqvnbzKau/PswQ
 xOGLj87Jca+g0H8AL1J2cl7VDhvFh6bdfsPHcKObBnOjbohnbJY6imUb0Gyoiumc74Fjh
 ZPKuA6DkvTlNKB+du6bxZTMBsIf2svBYmTWzUzA8IYLwfhJCt7XjCLYtvULMoMSPoinim
 ajtVpQkwAGyH4DA+g1Ao+jvED2SsznJL1InqhWpLtaM//Z5IuS3Y9p78UdfraIZnFsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AEAC40568
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:18 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLP-000000001MN-19bK;
 Tue, 29 Sep 2026 00:05:15 +0000
Date: Tue, 29 Sep 2026 01:05:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 04/11] boot: imagemap: free the reservation a replaced record
 owned
Message-ID: <d37b9238c4e19f4b96f44c7d9a0f3beeddfdb9fc.1790626459.git.daniel@makrotopia.org>
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

imagemap_record() overwrites an entry that already covers the same image
offset, including its lmb_reserved flag. When imagemap_map_to() replaces
a region that imagemap_map() had allocated from LMB, the reservation is
forgotten with the address that owned it, so imagemap_cleanup() walks a
table that no longer mentions it and the memory stays reserved for the
rest of the boot.

Release the reservation before the entry is pointed at different memory.

Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 9e77ed25d00..89396a03730 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -114,12 +114,22 @@ imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
 
 	/* Check for an existing entry at the same base that we can extend */
 	alist_for_each(r, &priv->regions) {
-		if (r->img_offset == img_offset) {
-			r->size = size;
-			r->ram = ram;
-			r->lmb_reserved = lmb_reserved;
-			return r;
-		}
+		if (r->img_offset != img_offset)
+			continue;
+
+		/*
+		 * The entry is about to describe different memory, so give up
+		 * the reservation it owns while its address is still known.
+		 */
+		if (r->lmb_reserved && r->ram != ram)
+			lmb_free(map_to_sysmem(r->ram),
+				 ALIGN(r->size, ARCH_DMA_MINALIGN), LMB_NONE);
+
+		r->size = size;
+		r->ram = ram;
+		r->lmb_reserved = lmb_reserved;
+
+		return r;
 	}
 
 	/* Append new region */
-- 
2.55.0
