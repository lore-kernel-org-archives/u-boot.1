Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E45C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 054F380DF4;
	Mon, 28 Sep 2026 10:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ML8c467PFcQ7; Mon, 28 Sep 2026 10:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5EDEC80D97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590543;
	b=jn+031oHK7gRQUg4lsSSUa8a8KKdi0gn6NuNHOMOH8+THe/msRCOrDOVv+YBZYRU1hRQ
	 mookDdfmwfAoYPUud6eA0HeMZ/avwjDrgp2zBb3gl23zwQkVWCD4IWA7vI4YJecAJ5aQD
	 0vnfDX1coPHanG7xTnCaP9ZcWIJGgQj9t5AaaDL0XS+LybTZeP/BSBqHcwel3iSSxvmGh
	 PaD3YS9XoNGuYuEG2vf3/7cPd/Ga5lHnKmOjxWsJ/k1aZdBAMh0VJHPNPsmGykrf5Z37O
	 NJYTyAzhBXaAZAo1WRqGZskKw0b1QCo1sfZVtnp/MZyn8Az0ihubUy8t1RJD1Vb/xfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YvMCDC3vmJgDGEx76IiJOyYxq189//TR7EWjJsCdMkc=;
	b=AmKrFlVqNCGrA1hqAGuTkQ8h3jM25YyL2t0DuqCWcuTPIwqc2ARo20hPlcwQqNaiMaxO
	 Rinbg0LEmgRoxDONvqzh6vTQK4PqIoqI3VNfGgaifq4iguoSR1wtIgLTry+cv2ZNBOmcq
	 uPQOvq9XCzKFGCMAeWoKK5w/jIbmrV3MfscpfPkYM+OWeyOphtFV012pnrQi7uHdMbUOU
	 osfmXGcxPwQqbWcSbaxKX+258lgGvTjL4lG+qs0JkFOBVrnT0ATx65aOCI2AjWyRaOeKF
	 wyy4VqYBKwpmSseqWoPOMkVx43zeOoVwR6n2F6mdNPFa9A9CpjYjNKnyID4Yc0kl8Iw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590543;
	bh=YvMCDC3vmJgDGEx76IiJOyYxq189//TR7EWjJsCdMkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EW8kbw7IhJy7r3ScdBt6YGxfpus3AjhU4sXmLGb+g424OeATRLcAvh5smQ8JtG4QG
	 0sULv4ZHSKylmMOGrFR54vRgwj2Ty8qOdFeDv7Rv960096UMMQ+efPI7e8S1821jT6
	 1oTvawvuYzVtnE+ROKqQBJ2+pvJ3Ek/uFHz9hj+XeFlBB6Y2V1S3TS2+Zu4UgJHWBK
	 XTj/hbexeWhZ2JE4Ar37rFJg6yQ/qfKfRvsW8NLfJas/bG4Y0xH/07OvJIEgyyttZa
	 1j04rM5FaZJV588WQBztjrnTGm71Z8SGgebf04XbvHODtl9xmev1ReF7BqJxr2iynB
	 dZIouvNA+lRSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EDEC80D97;
	Mon, 28 Sep 2026 10:15:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5FFF361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C556401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWauZR7y9LBB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:15:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EB9AF4019A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590542;
 b=ONNOfT0aX35IZDGI/wyV9Avx0mDJVTaTBMoAUQCEs7braRChWR1WKDsr72cYZchptXr/
 pOgctm2KJYPwvhQh9Ml2t79tVV8EnroOirMSDZeJ6gczpSuVeJ/LyonfGLGrqlwxMdMwh
 QeF9SGDTxUj2uNQELcJETkF8pdGijEAQ6Nkzc2zcH0WYdZqvENI8rhB2rcJvbFZXnCpzy
 E0Seylq06ZmnoRxUpDaEsmu9AHgc66oW516u1Y5k2JFh5Vff1FA5AG1REtaHgn4BSE/Rc
 ZJPPodTSj7vmD8u3jkqI2N/J31qF14yL9RRZCoJwMv2quiLUtQESwZXS9ASeKUibLag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590542;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YvMCDC3vmJgDGEx76IiJOyYxq189//TR7EWjJsCdMkc=;
 b=XyCHcSxJ4LpuVxVOyJoQWjnHadGg0hfYiV7Xq6UV+X+hcWwTA8T4bRwKj8avJ4k4Ubqc
 BVqSTydfLSsRWAsUKQG2jNSZWcWy1cUEBspUzBeWkcAxJeiOo6Lwjo0tVsbVNPg65JkdJ
 oNguR3TEpcOgunG0l/ee/Fv1UviP/M56TbLZmOHyUhb1UblFFykNWcQcgnikDQ3OmBqU7
 V1Pf3LgAcHsW472Mj+BTzBP40UoH+ykAd1uWiU2OgCz5QIZoEOF2+GmLatd8pztED0Sc9
 ZheAjFRsdeysly7KDZxCApaMDyWcpXkqVsh0aKx4z4UPRu2C9j09pMMD9qqXXUy9QZw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=htg10aDu; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=htg10aDu
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB9AF4019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4AFB3B00548;
 Mon, 28 Sep 2026 12:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590540;
 bh=CBtIWxNUDCOUiYZLo5GuRLQTfq0BPz/o9tGcs5+lwBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=htg10aDu69qgE5tI/ZBL13fBkPx/xXZGMNi6bOy1Uv9GR/4MIfSkuK/x9Z9SSPYV1
 Ibegek0DqpunEcppYSNyOuc1WN3BGaoF+cuFetIv+Bbnq3PqOZY+AcxgkNVgnUP5Hm
 ymCAY1ncKidISCE0F7JZ9hqyK1OZKLry875ze+o983vjBiOSr0WrCaFImYtJ/n/vb/
 KPABe//012q3rjGKweL+Wn3EeQ9kdSs9NUtXZbOw8owiNlqRonbrXQk8AHnjcxlmB7
 JFvdosj2dkS5dSvCkppP4EMATh57jjYPAzzpeciXaX4LW5Y0zWEjNinZuqXfxIGeAa
 +I0TsRJ983+Zw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 05/10] board: lx2160a: serdes: no SD1 config once MC runs
Date: Mon, 28 Sep 2026 12:13:24 +0200
Message-ID: <20260928101330.881662-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The MC reads the SD1 lane grouping once, when it boots.
lx2160a_serdes_apply_hwconfig() has to run before.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index a8fbb278b3a..057d3c97739 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -12,6 +12,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
+#include <fsl-mc/fsl_mc.h>
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -556,8 +557,16 @@ void lx2160a_serdes_apply_hwconfig(void)
 		mode = &sd1_modes[i];
 	}
 
-	if (mode)
-		sd1_enter(mode, mode, 0);
+	if (!mode || mode->is_active(srds_base(FSL_SRDS_1)))
+		return;
+
+	if (IS_ENABLED(CONFIG_FSL_MC_ENET) && get_mc_boot_status() != -1) {
+		printf("lx2160a serdes: the MC is already running, serdes1:%s not applied\n",
+		       mode->name);
+		return;
+	}
+
+	sd1_enter(mode, mode, 0);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
-- 
2.43.0

