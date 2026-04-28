Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD569FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFA1846B2;
	Tue, 28 Apr 2026 22:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="sYuM6PZC";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="h0AEL8bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D9D8467A; Tue, 28 Apr 2026 22:25:28 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B7A84699
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-czb4.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407925; 
 b=NMuRmD/wpPCgnsxyHk2Rku19OEJJ6bmqVsFBGnzHMVn8g+j1omhMLXRWyF4GUn8F8UQSe4NEKK
 BtlEpkrv4XCadc96FAHNL1dAohPJc5J18HnjoCmKYFA6nLfuf8fvVqcjL0xMuKaKMmlWPMX2Fg
 3wpq5HaZUfFMxG/hCg195eYUY3wD/hQwa0dDxZkNpDYz88munqQQCqLG2Z5ZkI70yUV96H8Eqn
 fwc7XroIvxWSVhELTnFvM3IVIzP4ftVt3BrMUCugwrtOT6DlU08Wpwg47KoFDZZY2Tx+SkYVjv
 7pCCJKRGILf8+dmMUzS04gl1xDahLK4BkUieKtUvLwUc2w==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-czb4.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-czb4.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407925; 
 bh=Vtkw1d13pgCGzFx5/iuZVSpPpLbmnOa0KmKp9dj2oUA=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=tHizEMN1lhQdhNpZ9w+WAl1nugBGDTb07rQo+WFdSLc6g5eG85UGhWWFfRacb8RIdhhrVO/EHh
 QGWIIurFMF87znruAq9sLi/hS9TSd8d1WYwje3qOSYryfRcUW64DlpFkWN2NnsYaOHU/Au9Sxs
 jiGYPtkH26yfMFdu0pg6gv+PhM9HK7H36dJu+N4383LujgvwBLYI2nWb0niJErfFV6iZyhVOdy
 CsKLLKraXlJ1dDT21n8dA+rMQcXNYnHHHvcBIt+PezmykGfyy/G1xkyAqogdo+1fbK7EDLZ/gJ
 zpUVUihhvd5ofOlTWYOXAxof8GZQrpF50YGRDv5X1j6tZA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=ON75lvKOMG0aSPat7B2byBU8/0wkSVDxhSjtQfTDfdU=; b=sYuM6PZCPCq5Xm6XlIARambQJ3
 Foqkp111o1VU4tYJHRPxutr7CczedaPoyIG8VTBGuWivu6elWQLu/WiD74FUpWT4zgBnbUH/Q+rqN
 FjkRP61l13gpO9/1qiRD4/ez8KX8s2/lre2qlaBhu17cN/kASi9aVUMHJRRIIVhT/p8U=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-czb4.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozj-00000004yDJ-0DgP
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=ON75lvKOMG0aSPat7B2byBU8/0wkSVDxhSjtQfTDfdU=; b=h0AEL8bmlYwvYj4mCjpsCcjMT4
 3bFsaRFePG596XboNfCRbUnt9mk21Md5NXveoMEjFOzMsME6jCLRh0D3nuEKHBWNZRM0kFI9GC0G/
 a86XP88YA14C0zFGiUvbyEk3vd+xLaCNGylCWwHWp+ONRBJq9RbE3QIxA/Qz5u7ERbj0=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozN-000000002Bh-1ttc; Tue, 28 Apr 2026 20:25:01 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Apr 2026 22:24:45 +0200
Subject: [PATCH 4/5] spl: call ft_board_setup() and ft_system_setup() if
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-spl_fit_full-v1-4-dde63beeaab1@valla.it>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>, 
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Michael Walle <mwalle@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 David Lechner <dlechner@baylibre.com>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=francesco@valla.it;
 h=from:subject:message-id; bh=Vtkw1d13pgCGzFx5/iuZVSpPpLbmnOa0KmKp9dj2oUA=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxad3P7p5S07FT0KVY/n52n2zhJ7NiPc7uf2P7PRyn
 w6dk09tO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJHD3M8E9XW1Ejcdf/B2Gn
 WtclH9n2+rOrh14Yk2/GVNM8X2n9iQqMDA8/ab7Y653YX+e0I/dXhuSBj4nZSdPOFuvcuaN1vYN
 Rlg0A
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
X-SGantispam-id: 6315f20a0d3262df70362e1ed68a01d3
X-AntiAbuse: ID - 6315f20a0d3262df70362e1ed68a01d3
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozj-00000004yDJ-0DgP-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-czb4.prod.antispam.mailspamprotection.com; 
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

If board and system FDT setups are enabled by the corresponding
configuration options, perform them also in SPL. This aligns the
behavior of FIT loading from SPL and U-Boot proper in this aspect,
reducing the need for custom code in falcon boot setups.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 722b18c98edc..a09ebac62c2a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -156,6 +156,22 @@ void spl_fixup_fdt(void *fdt_blob)
 		printf(PHASE_PROMPT "arch_fixup_fdt err - %d\n", err);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
+		err = ft_board_setup(fdt_blob, gd->bd);
+		if (err) {
+			printf(PHASE_PROMPT "ft_board_setup err - %d\n", err);
+			return;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
+		err = ft_system_setup(fdt_blob, gd->bd);
+		if (err) {
+			printf(PHASE_PROMPT "ft_system_setup err - %d\n", err);
+			return;
+		}
+	}
 #endif
 }
 

-- 
2.54.0

