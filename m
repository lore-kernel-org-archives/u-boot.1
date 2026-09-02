Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A5C624DC
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 21:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05E0660897;
	Wed,  2 Sep 2026 21:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVc3XsfgrMVn; Wed,  2 Sep 2026 21:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C0A060861
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788386341;
	b=oGMVYJ0FO1ISakG3n2HeXipwxT4owFcAEPh3wafUKESauw84eJfzRpM4Fj7aBo2HaL1R
	 5EPFtQQWh3P++gYenXxeg7a4et3fvHPG6VzI+3L6Nbcf3WF36oaw+C85NI5keRvYnpdei
	 9139QBwtnt3iPlXLsQEO0GQ0+Ww6JXKJwtlNp9uY6VZlzlV0q/xPkIRwBeRKzXxk+wbpo
	 AuKF+tfODc6pH76ObDc2RH67hdPqmJ+yF3nLyg0haoPgR1AeZAV3gatkw75G1fHS7uJqt
	 QKefXja/QVg0N8MO/gN+vyFbpHOmNUrKzc1XwQV39osq+BQyTjL/An5R5BJd5UjWYrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788386341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lmrGrjxEKEARoJhEdMsrV1MoIb/ZK8G24FsMMzGSWsQ=;
	b=BO3E3Djz8KRK/2TfEOZvqiRL83JTtQOUCQGW8XWfRYpFI5X92bN4QBlAuv4r7fdWcKjj
	 URLjNC8C6TQYvl3axZoOWvyaefeNEsxbBj1fsoG/1uUD2pPbRqgoZvuKUOdMYjltUhA9e
	 vWQItb2vcsO0JHvnnqVWuRYT2ONl9/PDRHUSYWP54JtQspAz+i0o7p2coOmLLM7f436V4
	 249ySuKowzuH9+wjluoys9CF3n597whr4yLAwdE1YUWmch1CIqiyTeGeHyq04Ufxcg5Yd
	 lcleNyxbAiNk+aMPfRovc+9r2/ocow7S0Lww3mRsOWFHixrf43K0J8klMbqn8MhPv+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=binarly.io;
	dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256 header.s=google header.b=eyGl5RnD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788386341;
	bh=lmrGrjxEKEARoJhEdMsrV1MoIb/ZK8G24FsMMzGSWsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1JPj0MkOGE5Tf7h5BNVNLeGF6+Vsrbu1xGXMNnp9JQnvNzbu1E5Fxxcs7vW1lbpnG
	 U8ZPD3PCyUpBHvg8b/PlWGTMSL7z1FW0DnLAm6Yn+ALiFpinVlAW26IywMvKZxpNBi
	 p1Kcle1aybdXg7eLBhAG3JZsZEdLszKktwfq1auXhsFR7Ww3ueIZUkECBFZa4KUM51
	 RM7BhD/g7mnCGb7eY4ZB3G7nZUg1+rfYwSvl18lQ6gpc9TCvZLekabXa550PPVHgY+
	 nof2U0SOLZUHCtrxz2dn06XHQPNLBpLlQ7LquQ5jbeS1vKLxR8bTl63yr3d3Hihrh0
	 4bV0GU4RNSYIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C0A060861;
	Wed,  2 Sep 2026 21:59:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F08F42FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D702060679
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1shOtgnM2A2 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 21:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB8146069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::733"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788384235;
 b=bY+Ilc4pfP0UQxehwpklMG4gQjzmj0eyEjRULCix0XKiZTCZpqGewWAI067BvIJ7z4k9
 k+wNdM8M8kz7j9Uq5VgBBSSvy/l72YVNbZbeFjmQ6iH2uf84m8Tq+0eiHrejBZIOk8KNF
 lU/R+frkhLnTrQ35KewoaPqMXDR/RNHtjZX/NAUID6ld7FPXlPny0F7l5NMwNATS35ecs
 SnlOZ8EoNkVqXfz4+vzW0MG6kYBGhyafc09uI+vPZ9Kr/lr+zeWt8RGZ0e6JmZ2P6H1Tq
 5f9iOIbXQx7EF3u3LLtRGhEDbeUw3mGt1lBbJGmjR5gcs3yR2xH11WgxoCwSBU2L2yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788384235;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lmrGrjxEKEARoJhEdMsrV1MoIb/ZK8G24FsMMzGSWsQ=;
 b=XojVxLphqTSvgX1RjdmN5BfpsZVV5O55kwuupOL73RJZyqzR9e6rKnzc8ZDrWsJlepoM
 A6C0RqA1qW8sCKIKK9vUWiKv7+leoPeQ5uIE3CnPLzh8o4GzXlPcK8tawBCLoA5BWNGTv
 7Df/4m3dMet21+ga9DbmE31TC9dma5jOpv8iPJ46LYfVwRaNx+fsE8M+QPaKDQbgXbj46
 DmQo7RmZ34583QrkTKJu9sfRfK2kU87Xoc/dxGwZGspqa0m/su9uSsKl8A6gaZU2bKWv4
 LkRlWA/QaZuvVOa2TDFosLgajs+i6tWLUvL5uNg9QmbetiUn0VYw9LFIoqHrTvP+0VA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=binarly.io; 
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=eyGl5RnD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::733"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=binarly.io header.i=@binarly.io
 header.a=rsa-sha256 header.s=google header.b=eyGl5RnD
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB8146069C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:54 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-934956bee57so239345885a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1788384233; x=1788989033;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmrGrjxEKEARoJhEdMsrV1MoIb/ZK8G24FsMMzGSWsQ=;
 b=eyGl5RnD48FZ2yqosQhOm28jDVNeti64bY8sjwuLK4YGRFLgTUSt2VkLq7ytdmlWDj
 iycrf5dpZ9D3tQen/myS6ZEuilVFfo0Q8q1kmIqQf8QmWee5RjDpDx2eh7h5UZNT33QZ
 +mvCBuoXM7Meh0PUvLr+DAUGcd457BeH6fnPndM6E0tBPHHmmCFdgIzYjhAImMV3yMAt
 uKzAogZcQHzTNamj5a/JP7HrPxTg5FtzBL34TM7Ca0I50xULw3b12jOas1or8kJnlXn2
 Hcgl7kSR6oHfNAztB9LpRCkIJRIVnEKBK3SmNyoEiuKCeRhmKjEnKF7q0AEMNADUd3Rx
 gzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384233; x=1788989033;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lmrGrjxEKEARoJhEdMsrV1MoIb/ZK8G24FsMMzGSWsQ=;
 b=na4z5fWXOrhPcColMNuzXeLKhcIfD6Sb1mk0GMYG/5Qw9hp2ypeCdTUIE8qzeUQyW1
 qC0hfSX51PUJzx9Qo/yrD9aB7KBPGVpBzKgDUTB09RFzVp6Oy4G7SVG28RKqSr5GNGqa
 d6SA9pbLZGS/wqevJ6WzOqAjDkF75wRh/ZDCyIfC5LMZE2WL2BoLa89DKo1bAbDf7MV7
 axS2h28Wcy7VJs9h2wK4Uiv1nG1Xo8cpoLN5l04y+AScwzaEYQmY3Jmrx33/HrEBtB6k
 h8wVx8J4fWMjwdC4ZXbFp0EsuOSYFVc6R1d1TJbjtapMa/Vqs6e88kHah/lydOFF+6oi
 3PyA==
X-Gm-Message-State: AFuF++m0hGxhQ/q+np+bDmceN1pjiufufaBgv/hQhmqqwkXNNHtPbnqV
 /42W42z9r6yQG+ftB60E0enyR4ZAnKGnoMuKJSCZ2dibbqKhYw+EHzpOnDA0xyZ04OA=
X-Gm-Gg: AYBFou2RLdDSmDpwq8anRiSnPfN7tvisAPXjYKpnFpj2d44pryjzHL7gtQSqcIqxfhf
 OI5pZjVm6+NLRemjoDnU6paEuCGO9DBEhTobWvgxRJZL7B9f7nMriQke1kXHlrzgtSNbjVWFdS7
 Up5gYSWViGlVG6CmHba7rFrrRCuB5Ydexyp5yYRDTVLWJvFxKp+d7MOT1QKEg3NKFItDld+wOAS
 jaz4K9y6fThbEnbhVanCTfMHsWYGJJbAdKRcc1lgPWI4ToVp2/X1Vk5WlVQdVrJKcJGFezR9iQJ
 p0veDDM1DK1QltP7Zr9aKxY2ssUr0CRmq2agMZWpfrCNG7Oh35TuDD45s8+giu1T6O0lWdNV/aE
 zPShlZAygnA7arBSIGXpdipbHBkavW6ugsStD/QPvngCKBj4P2y0QFMU/XWrGXgfe/AL5Vwzq6G
 DNd+9fVgzfb54kbiFTC3xsbKTLAbaUkgeuPFuDSQbMTim8Gm0MJWSnw+10kAD134o8yI1yf+NOy
 Ts6jtsz3Hro3lWS
X-Received: by 2002:a05:620a:2556:b0:938:fc91:91ce with SMTP id
 af79cd13be357-93960efd273mr933426685a.20.1788384232752; 
 Wed, 02 Sep 2026 14:23:52 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm19948755e9.13.2026.09.02.14.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 14:23:52 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
Date: Wed, 02 Sep 2026 22:23:26 +0100
Subject: [PATCH v4 4/4] spl: fit: Bound external data like U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-b4-fit-ext-data-hardening-v4-4-a884a5de96ea@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788384226; l=4212;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=kqwUVO8UfPzi40YGw14aHe/7yjXJsB21NWAMaN4LP4U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNcOOG4Ne3S+Oud8YO8qTLT83dSuAwnOn9EVl55EJt/8LnHu9fz7vUEGG8u05MMXSOp+l1eBPa8
 kQKGuDpZX9gE=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Wed, 02 Sep 2026 21:58:52 +0000
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

fit_image_get_data() checks that the external-data region fits in the
addressable range and, for signed FITs, stays below
FIT_SIGNATURE_MAX_SIZE. The SPL loader had no equivalent check, so a
hostile data-offset or data-size could make the read offset wrap past
ULONG_MAX, or the destination range wrap around the end of the address
space.

Add the same check to load_simple_fit(), using the block-aligned read
size and the source pointer the read actually uses.

Signed-off-by: Anton Ivanov <anton@binarly.io>
Reviewed-by: Simon Glass <sjg@chromium.org>

---
Changed since v3: the out-of-bounds message uses log_debug() instead
of printf().

Code size, from buildman -S in the u-boot-gitlab-ci-runner container
(gcc 14.2.0), one board per combination of CONFIG_SPL_LOAD_BLOCK
(BLK), CONFIG_SPL_FIT_SIGNATURE (SIG) and bitness. No rodata or data
change, so this is the cost of the checks themselves. SPL only; U-Boot
proper is unchanged:

  BLK SIG bit  board                      text     all
   y   n   32  am335x_evm                  +16     +16
   y   y   32  firefly-rk3288              +32     +32
   n   n   32  am335x_evm_spiboot           +8      +8
   n   y   32  evb-ast2600                 +40     +40
   y   n   64  imx8mm_evk                  +16     +16
   y   y   64  orangepi-5-ultra-rk3588     +40     +40
   n   n   64  r8a779g0_whitehawk            0       0
---
 common/spl/spl_fit.c  | 26 ++++++++++++++++++++++++++
 test/image/spl_load.c | 23 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 65934674b6c..9da709fd79a 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -343,6 +343,32 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
 		length = len;
 
+		/*
+		 * For non-signed FIT images, we can check that
+		 * (read_offset + size) does not wrap and that
+		 * (src_ptr + size) does not exceed the addressable range.
+		 * For signed FITs, we can additionally check that
+		 * (offset + len) doesn't exceed the allowed FIT image
+		 * maximum size.
+		 */
+		if (size > ULONG_MAX - read_offset ||
+		    size > UINTPTR_MAX - (uintptr_t)src_ptr
+		/*
+		 * #if (not a runtime if) is required: FIT_SIGNATURE_MAX_SIZE
+		 * depends on FIT_SIGNATURE, so CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
+		 * is undefined when signing is disabled and referencing it
+		 * here would fail to compile.
+		 */
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+		    || offset > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) ||
+		    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
+#endif
+		) {
+			log_debug("FIT external data is out of bounds (offset=%u, size=%u)\n",
+				  offset, len);
+			return -EINVAL;
+		}
+
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 557362ba113..334ec77b18e 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -483,6 +483,29 @@ static int spl_test_fit_read_offset_overflow(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fit_read_offset_overflow, 0);
 
+/*
+ * A read whose end position (read_offset + size) wraps past the addressable
+ * range must be rejected.
+ */
+static int spl_test_fit_read_end_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	/*
+	 * The aligned external-data offset (0x2000 plus the size of the FIT
+	 * itself) stays below the 0x2fff bytes remaining before ULONG_MAX, so
+	 * read_offset passes the offset-wrap check above, but reading the
+	 * SPL_TEST_DATA_SIZE bytes of data crosses past UINTPTR_MAX.
+	 */
+	spl_test_fit_offset = ULONG_MAX - 0x2fff;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x2000, 1,
+				  spl_test_read_fit_offset, spl_test_fit_offset,
+				  -EINVAL);
+}
+SPL_TEST(spl_test_fit_read_end_overflow, 0);
+
 /*
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier

-- 
2.55.0

