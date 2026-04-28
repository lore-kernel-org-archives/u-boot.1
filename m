Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F59BFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA9E8466D;
	Tue, 28 Apr 2026 22:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="JjhIHunA";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="K6q/rEdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FB984612; Tue, 28 Apr 2026 22:25:25 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD8884612
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-njwc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407923; 
 b=JS/8qQrM8x1qiOlvBxyfohl7zHhlfqqspfnqHxnzGsDWcwnBBviqr4TeJsWzEPUpek2Ua01RUw
 eBPkLMkWcjCuujjEo4upHrfqkqU9In/WaUBtyWRSPeQp7hf5i3rkDx5maxfCkd+ubJG7oXXlkA
 S9KGf7igEFTR6KFpdwta4eTPzfHiyEtMEBl6giU2/yZDRgVWqnBuODfK/svjWVg7dTs2dqtWvq
 +D0aYfGVT7maeEMIGdMHoJLcVUpDFFOmD5YJZuzshGRSyHwqaZHZNUISsUs7JJvQKFLdsEefyy
 YSycM6UGzLA/XRoeEfcVT++9fAaKCs5f5iyD5Dmk4NkCRg==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-njwc.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-njwc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407923; 
 bh=8vH8SWkdbTG8u/LCMWGsHAkK7qDXgtEngFgujD/hnqo=;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:From:DKIM-Signature:DKIM-Signature;
 b=Dt13T005JTzwyheRs+iQbWv6L/blOIo9B6BVfLg6vrmYx1HcqcTlcWtXZk8moM7MRd2EZnPORA
 WzHQYlHluj0aqtwh9TIcaYoHLXT3v2iGs46YjdSeqC3Nl84IPqaBvzQXJ16zSK5xpa3NiqSZDI
 JM1dTpHwkv/itzv8KgqVaZJOQVlEv+UdtHoVmnnKqRFy0pWwdm9o0yCA5J5W4VWOoGzOiVAU4a
 Nhg8IlofPrFOvZWnAIMiNax14n9TX4FQA3BhpoBR9oidHZAL0SmekR/MZHAfULDVu4aoBqqSPD
 pvq4qebmN6OJmPARh/d2HAkXQ/i6QRm+wbPb8fHgWtoNNA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=raTl81k32OIaUC/KnXQogBxk44/WEMonDmz9KDOWU9s=; b=JjhIHunAw5J9o9V+ftkCFyqrZs
 shEEw0H2COsmdvla5YVMEb36Dg1Cv9g+aYW2RgyXpzaZMf90UQ3EazMEycmm0iM8yfNKLUPORy3FC
 UpLd6jzMzvSpH7BNZXDsyh4bMP74CDWe2bPezAh9NitNOLUFu2L38+7wQeyDawXLk0Ko=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-njwc.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozg-00000005ARU-1Vu1
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=raTl81k32OIaUC/KnXQogBxk44/WEMonDmz9KDOWU9s=; b=K6q/rEdH8/JnPpLP5u3GTgkFtG
 S58PDpNr9LeZoERu8MXTRN+TGygdGpeYo92GrVKIjZm++gRDPDznm31giJD6vDLXRpkHcpx87toLA
 qFWRd1s1MqvFoyKd0oQ7ySvW3Lza0oVdSVCai4id4+7BcvW3ANyMWVEfDoaBEZo/fxDI=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozI-000000002Bh-2zll; Tue, 28 Apr 2026 20:24:56 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/5] Enhance the SPL FIT "full" loading logic
Date: Tue, 28 Apr 2026 22:24:41 +0200
Message-Id: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1hbaIoPjVUQk1VQzFJVGRRDvP
 lWXb/H/CUKRSaDKToi0s/A8JZg8g27EaSDFfTJYbT+6sKWSJbSe19ZvISjzRe1KZxB7hJQskTw
 fz65uXsvmftSt9wOu6w/dKp7YcAAAAA==
X-Change-ID: 20260428-spl_fit_full-19a0b8b1aada
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=francesco@valla.it;
 h=from:subject:message-id; bh=8vH8SWkdbTG8u/LCMWGsHAkK7qDXgtEngFgujD/hnqo=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxSdk13bzG33Z1qJZEZCYM7ctQTm8P3LNEsMlmSE7W
 j0PvP/cUcrCIMbFICumyBKy7sa9PXPNv6VtYHwEM4eVCWQIAxenAEzkpDgjw30GHtOUMxdrDU1c
 asO0MrkSOOQcHp/+oOLS1aC7IrHAgZFhWpPeufULl79lLrhY6Vj//X6VwzfOsPSf2X1e/iH9yk3
 cAA==
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
X-SGantispam-id: d6e014f3e875d7e9097b5fba58951000
X-AntiAbuse: ID - d6e014f3e875d7e9097b5fba58951000
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozg-00000005ARU-1Vu1-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-njwc.prod.antispam.mailspamprotection.com; 
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

Hello,

this patch set tries to align the behavior of the SPL FIT "full" boot
flow (i.e., the one obtained enabling SPL_LOAD_FIT_FULL) to the one
happening in U-Boot proper through the bootm command.

The final goal is to simplify the implementation of FIT-based Falcon
boot on new platforms, reducing the need of custom per-arch or (even 
worse) per-board logic. The reduced FIT loading logic is in fact not
enough in some of the modern platforms, where additional firmware
components (e.g.: TF-A, OP-TEE, auxilliary processors) need to be
loaded alongside the Linux kernel and its devicetree.
 
Note: patch 1 fixes a bug in the signature checking logic when called
from the SPL and should probably be applied even in case the other
patches are not deemed suitable for inclusion.

Thank you!

Regards,
Francesco Valla

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (5):
      boot: fit: fix FIT verification in SPL
      boot: fit: decompress kernel when in SPL
      boot: fit: enable FIT image post-processing in SPL
      spl: call ft_board_setup() and ft_system_setup() if enabled
      spl: fit: add ramdisk load

 boot/image-fit.c     | 11 ++++++-----
 common/spl/spl.c     | 33 ++++++++++++++++++++++++++++++---
 common/spl/spl_fit.c | 18 ++++++++++++++++--
 include/spl.h        | 20 ++++++++++++++++++++
 4 files changed, 72 insertions(+), 10 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-spl_fit_full-19a0b8b1aada

Best regards,
--  
Francesco Valla <francesco@valla.it>

