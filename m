Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ED2CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FD2849B7;
	Thu,  4 Jun 2026 22:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="mKKMO0RW";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="lIWO8HCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA10384975; Thu,  4 Jun 2026 22:41:57 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2760849AF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605714; 
 b=a4vC51RK87vEulSqKH3ctp1+Ehh0saOZhyQCGi64Y5POf1ggIGQhn0w1qtAly4P6SgF6z5LXqG
 G6ZQgU9OpkhlMT+2/2pv9vmCUHV4OV9dZ3xk1LgRncSVEUBFP29FpBuusl6qq6BuE6nAqDj33y
 /YEcjyIQF1TrN98t4qHCQlR+d3JDmRpLnRQAEwr8X0qkt/s0TXOab/BvKKMosiMcDIgCkCkCr0
 E2QL7e9MNEg9yeiVvf3+LTxtBggIQEgFuWH5R23Jj53fXy5FI0TcZqCOxtSocB3//IDj0VjiVk
 QQcD48SGjL4q6cGHnzEqkVVgPaH08mr0UPINQ5o34ZVCvA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605714; 
 bh=apbPx9EF4H49Tkj1QVR4Tie7RUfN8IbVoT9bdsLTvvw=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=gtie2EBqspc47+ibswVJeZGjqQHtNBJ+XxHYXzUsBFG9UBEpmxhguajp+gvDTL7jOgpJO90GbT
 qD45lsEPzgV2iYaLkCQBpHcDNGD+Cy6U7ZhW271b+Nwmjz8vjbQji5j3x2zF7FIFh4ZOqnC7PR
 COszMng1gAe7btWcPxs9JaVOB6KZu/yiRUhMxlw3sqN9qzD0LgGjV2dCU4BjRQUNGk+Pnj56W0
 tCOvZOcAFwBR8OahADM2u8RTbhJq6l3JD11eXc6Rze1oGzD5BSgWAwb7f4a7VTyLjL6ARi9u3o
 2Sk358AYvxb7FYvVfP1VKjzU27FthmQyexoixF45+3wgZQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=o3cEDaUP14IHHCYtT9H6q6/ohoMnhZ8FE+KTM42q3Jw=; b=mKKMO0RW/lRmtVPRJYleJnq1Fp
 RvvtHpTNMk4rm+RGSE3+yxgT1gvvIjgYrMbEJmu6YOCMmoKlMFa/rc1wfZUCZUhBGVdPlUDg8scGa
 Z/NLCT26sN4Gfq56qCO+SF2UU0emLARzXHYxxbG/pxJv84euZPq6VaHs2V0/U9RKVQM8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEsy-00000007It5-3B2W
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=o3cEDaUP14IHHCYtT9H6q6/ohoMnhZ8FE+KTM42q3Jw=; b=lIWO8HCgsU5F2T0rMCP2WgxGau
 lp32NNwW21UeeDo7XtxleCGbFT8HKWfFQVVes8PnQNRyA+Oh2+UVg14vzmoeTTU19WUYXolvRKldg
 +svX7WLZzIrFM+JYtYFp3GV6ZFB32auK4L+6ihvEzsScdQ9WsrdSLjazvPN8UqdJUYLA=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsl-00000000GnV-09xG; Thu, 04 Jun 2026 20:41:39 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:37 +0200
Subject: [PATCH 3/6] spl: fit: rework the FDT load hack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-3-ec036b5872e2@valla.it>
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=francesco@valla.it;
 h=from:subject:message-id; bh=apbPx9EF4H49Tkj1QVR4Tie7RUfN8IbVoT9bdsLTvvw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxmSVq372ZRkcbS74i/vhKhF/Yve2fv2Zb3dbnjSU
 45/tczyjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAi5ryMDDNbAxgbFrw57v7s
 lYs2n/g1pwOCK6rn8Te3m/4N7lLZ8JThv0P6i5jZ/aFZO3a37FnWeMq7jX+xcPizJ3FeGntesb3
 gYwIA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: da331d4b5daaa9f959e8aff259a5abdb
X-AntiAbuse: ID - da331d4b5daaa9f959e8aff259a5abdb
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEsy-00000007It5-3B2W-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

U-Boot proper expects its FDT to be right after its binary image; the
"full" FIT image loader thus adopts an hack to relocate it, ignoring
the specified load address.

Rework the current form of the hack to:

- support the 'sandbox' environment with a sysmem-aware memcpy;
- use the ALIGN() macro instead of raw alignment logic;
- align the FDT to 8-byte boundary as per FDT specifications;
- fix the debug print (which was reporting the source address for the
  relocation instead of the destination one).

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl_fit.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 229eda0582f1..1f3f7e549502 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -1000,14 +1000,15 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 			     &fit_uname_config, IH_ARCH_DEFAULT, IH_TYPE_FLATDT,
 			     -1, FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
 	if (ret >= 0) {
-		spl_image->fdt_addr = (void *)dt_data;
-
 		if (spl_image->os == IH_OS_U_BOOT) {
 			/* HACK: U-Boot expects FDT at a specific address */
-			fdt_hack = spl_image->load_addr + spl_image->size;
-			fdt_hack = (fdt_hack + 3) & ~3;
-			debug("Relocating FDT to %p\n", spl_image->fdt_addr);
-			memcpy((void *)fdt_hack, spl_image->fdt_addr, dt_len);
+			fdt_hack = ALIGN(spl_image->load_addr + spl_image->size, 8);
+			debug("Relocating FDT to %p\n", (void *)fdt_hack);
+			memcpy(map_sysmem(fdt_hack, dt_len),
+			       map_sysmem(dt_data, 0), dt_len);
+			spl_image->fdt_addr = (void *)fdt_hack;
+		} else {
+			spl_image->fdt_addr = (void *)dt_data;
 		}
 	}
 

-- 
2.54.0

