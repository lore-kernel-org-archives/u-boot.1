Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE8ACA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 139FF6071C;
	Tue, 29 Sep 2026 00:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eb3zq6jyBCFg; Tue, 29 Sep 2026 00:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A1D46070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640340;
	b=NJA/zP/2lBmfALIQU/B6yhsvu9b8pL/3hy6l/tTjtImAzPWbEvb0Bg2h3EvZRDY3Nbv+
	 khZoX3Zoh/lBxr8+1WfK97t/70QU1sg+HecAqE7bttL6UezLaNzPexin6gO9duqLyGXZ4
	 hjk58fxAfyHc9FQVfJXzWWRHhg+yQPapwO8B4wowdPEnDvYmB3VNFt9SAPJ7+YSGip1fc
	 6YoAtvCMiiH5tDaVMlXnXfk7U/0WkwYVLWogxTfEasGGR8BFGAX3dEeIbnLfEWn/WItc3
	 Ibtzut49hS/jz4fZS6qVVXxXUynSbE1xa/DvGksA1iYqfz6Gn8qtTzLuErP7fj0fW6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9C3VCbRhL76NbM8mcqz6TUUJR+9s3S5eDuEsGonUn4w=;
	b=nnVZe8Br7nYy2R8xdXSs4OXaljzrwsv7S9V9KYXxM6kcE5OkXmtgLdRL7qRZEiHmwiy6
	 nbRQ9RMeTuoi125J7+6jioVr4Ts/oGe7WirFoEmjTjvigr0eFXIJJrbqX3cuEVxgeK4NV
	 lhpVTF36JqmUiqjjYYKm+G0DqOT+Xwtb894mDCbynAoh/W9RFWgF5AJPF/Y8mVKC2Kjx7
	 RHGuH54QaWF/2v8sgPqBF5RmCm+8n3t6ahVX01EhvArJNxHu7Pa9+3hf5a9J3XB7hdsSM
	 54p4+L1Lb3ZTkNTEddg6JInXF4MCmYE3usWk3MFvXEK3Xmf890uLjqd2mN4a+cgP7AA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640340;
	bh=9C3VCbRhL76NbM8mcqz6TUUJR+9s3S5eDuEsGonUn4w=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E76Nkw0e+9A6QyVIMIFbQAZd31tEuvrAHO2Pssf2EoErkwZYQS4mlwbIlweh4oQHv
	 mJSij/8ZYwIa/ZjvYmg4l3SPIsv9L5kVTDdUgA+emjD1Y86RdFO1iczK5JcrJKFini
	 uXzDc4NOHjpRdILmQ1HiPC4rW8F8E+JFML3zimldsOdJq1fjk68hTgzYYpDpQbHoqW
	 Hs7hxV61K2xf60Ma+MA2zOl0pt/a7KKjd3UG7b0LipCk3Osql5J8TrXw34gvNOi2EJ
	 pDHhmCgu2hRg0oIHKp6JZH+rNLH6BOdDNhdvsoSPvmITm39fE6LfSogmtU00gEfFZa
	 NQAY/X8g1jkIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A1D46070E;
	Tue, 29 Sep 2026 00:05:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DD693D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D56A40568
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7pxDQwsrr7d for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5E98F403B5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640338;
 b=Au4lDfVvOLxtFTehOwZFxgKjfALyvJBI8VUg0+SsdzxeGb9F0weJMQgoTHif5OzRFAwi
 wtdcRiTXdqV/5zL0LdEBxn3uQVaUbUZXZ1Mf8RERz+uojE4OxncGQPqtEpWGAgHOhOYH+
 RhA4TQu7yY0k7BkVCyIEZLeeVAZdkNBbErkmQGru5W9d2vNutsFGLibmDjRVUolTYP2xx
 gPeHORvm1Uczd1WRfK1EotrRv2HEhbBPK1rCOpYfmUJ0A4ZwPBakJUS1spEDqlus7RnXN
 Eu9lyNa9xb5BC114XXe1oVYg0gJYLnzm+HIRBoyZg2RrX7Kysy41ZBxpBCSSBIPh0Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640338;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=9C3VCbRhL76NbM8mcqz6TUUJR+9s3S5eDuEsGonUn4w=;
 b=aSQ1/6/tXEDEz1ghN4ouv04qi1VruIS0dMVrxj52SDt0LQn7pNoFefeTFiZXrhzDFeIz
 4BOqy73gAsO2NOMZNQKu6UG92XDVfUbAyk/3EC7IamP97KIy1CfjeHhOVmF9EJZaabY7M
 xeoZXkzYgeeP76GGpeSNFzQHMXmnjQos06eALqnd3xm4KuWu0gFh8puKlw2hEx2NpoRdy
 718svywIu06H19oDzC+tjlsGRcf/TUPhfNybWakh3e545GJ8oi0r42xgZTSV8Ei8ig+0m
 1Mdgc/TmCk7NXoU9yitgZjhI1yP36wJvuxjbX1Pr3uC87Xkh+YCrV1iq5dwGhJPltgg==
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
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E98F403B5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:37 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLLi-000000001Nz-3Flz;
 Tue, 29 Sep 2026 00:05:34 +0000
Date: Tue, 29 Sep 2026 01:05:32 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 06/11] boot: imagemap: read only the bytes an extend adds
Message-ID: <9a960bc5139c79b9f60f37f8ea6255e6e8a76c2a.1790626459.git.daniel@makrotopia.org>
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

Growing a region re-reads it from the start even when the reservation
was renewed at the same address and the leading bytes are still valid.
The translation table exists to avoid re-reading data that is already in
RAM, so the common case of probing a FIT header and then mapping the
whole structure pays for the header twice.

Read only the range the larger request adds when the region has not
moved. A reservation that had to be placed elsewhere still needs the
whole range.

Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index a28c7928e46..b004aa1644b 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -213,8 +213,10 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 	ulong overhead = img_offset & (bl_len - 1);
 	loff_t base_off = img_offset - overhead;
 	ulong read_size = ALIGN(size + overhead, bl_len);
+	phys_addr_t old_addr;
 	phys_addr_t addr;
 	phys_size_t alloc_size;
+	ulong old_size;
 	void *base;
 	int ret;
 	struct imagemap_region *r;
@@ -241,9 +243,11 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 			if (!r->lmb_reserved)
 				break;
 
-			addr = map_to_sysmem(r->ram);
+			old_size = r->size;
+			old_addr = map_to_sysmem(r->ram);
+			addr = old_addr;
 
-			lmb_free(addr, ALIGN(r->size, ARCH_DMA_MINALIGN),
+			lmb_free(addr, ALIGN(old_size, ARCH_DMA_MINALIGN),
 				 LMB_NONE);
 
 			/* Try to re-reserve at the same address with new size */
@@ -261,8 +265,14 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 			}
 			base = map_sysmem(addr, alloc_size);
 
-			ret = spl_load_region(&priv->info, img_offset, size,
-					      base);
+			if (addr == old_addr)
+				ret = spl_load_region(&priv->info,
+						      base_off + old_size,
+						      read_size - old_size,
+						      (char *)base + old_size);
+			else
+				ret = spl_load_region(&priv->info, img_offset,
+						      size, base);
 			if (ret < 0) {
 				log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
 					(unsigned long long)img_offset, size, ret);
-- 
2.55.0
