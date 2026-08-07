Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B3CC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8CAC409CF;
	Fri,  7 Aug 2026 08:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkUydgCicavx; Fri,  7 Aug 2026 08:14:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 225F1409A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090444;
	bh=aVvBIa7cUJBsgwWCUs4484Utu9zONm9ZQrQbY0vJ1wA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EMBl8GlvGlAizOoH360pSdpVXEM5/anILu40kBLyw/YyiNabC7ErVOR18wKaIlXCs
	 jE9+s/HQ9LZpH5Zkh0Yltx+bWBuIcI1QPTq9R92QnZar2u1e58+bt17xMN7QB1VK5A
	 H+QBTZ1qzDr+RY4IpSWZ7UqozlxATHv5Zbd6IzpSNRyRQnejhgZmP3AlmeEi8whT4Z
	 b6zKWrvM/PVo2PJtN0AZPzsmRaxV3wW20Q1zrYKkkKfcK4Ie2BbsmFsoX1RjYSv9ga
	 +37IiD9NARcS4Cj4DlXiCmWjNCkU7OO9TWrafNx4DN8fuDugGdklrGsJr/2/e0n4k9
	 KIZTzzL2RNkLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 225F1409A6;
	Fri,  7 Aug 2026 08:14:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 339E8397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2598D409A6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7-D05VMkZ0S for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:14:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d202; helo=forward202b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4B3D84028C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B3D84028C
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B3D84028C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:00 +0000 (UTC)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 by forward202b.mail.yandex.net (postfix) with ESMTPS id C5072C408E
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward102b.mail.yandex.net (postfix) with ESMTPS id 56F32C03CB;
 Fri, 07 Aug 2026 11:06:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-VAtV5PDW; 
 Fri, 07 Aug 2026 11:06:28 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 07 Aug 2026 11:06:40 +0300
Subject: [PATCH 3/5] spl: fit: Use map_sysmem() with buffers for fdt
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-riscv-full-fit-support-v1-3-21a34f79c350@maquefel.me>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=872;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=UDkxOetHzS/UeKF+OiAD5ecFMmO64kj14w5F0i9Wwoo=;
 b=HcJhu5NFQ8BSjRYLh7a0iIIJbvfZ8v+ulNOMoKvOjoGCjtc1yCxaZZqSwY4o4c7R/Kq1zCDvx
 +kHHiST67fdDakLJkGpPA7TjzfK68671a8bVgjbe3uiJsquL2223Z6x
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089988; bh=aVvBIa7cUJBsgwWCUs4484Utu9zONm9ZQrQbY0vJ1wA=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=CjDIIwXpFkwt72e0naQPQcQqpYtn1LEvJOBk6Pb7MnhnqU0fFrruPAw8yPRKzN0mk
 WdFZgbU9kc2ftPlKlumcSEoNrf9/+jxgp7EFUOFteUjKpEL7Nn3NO78xBL5fbOnd/8
 A40k6N10MaMa1KWYEEzLhKkO+LKhJwfBV1dJqsQc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=CjDIIwXp
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 18bff7b8d4a..4d4a96d1c4c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -1034,9 +1034,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 			debug("Relocating FDT to %p\n", (void *)fdt_hack);
 			memcpy(map_sysmem(fdt_hack, dt_len),
 			       map_sysmem(dt_data, 0), dt_len);
-			spl_image->fdt_addr = (void *)fdt_hack;
+			spl_image->fdt_addr = map_sysmem(fdt_hack, 0);
 		} else {
-			spl_image->fdt_addr = (void *)dt_data;
+			spl_image->fdt_addr = map_sysmem(dt_data, 0);
 		}
 	}
 

-- 
2.52.0

