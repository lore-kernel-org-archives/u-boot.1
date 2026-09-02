Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92799C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 649974077C;
	Wed,  2 Sep 2026 06:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BnlZE6HLt5SA; Wed,  2 Sep 2026 06:38:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788331082;
	bh=w9R2ZSBCd4efDGmuQO1+IsPGFK1NY3CB+rJffYGnsGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HK/Jms04sCart5UhI78hZI8zebNFKmHV32bnjfSkn8qHKJ+lKna663fzgLPC+BwWj
	 yWZodC4QuzfdiWQjCKHMJWpQxwznEPqts8fk9srqEVe7ZSOdaeLmvmgpdVnJEjhfcV
	 JBumFn1BIU0K0Iw/KM015bbGtYRZUX8DVRVLjBZsN3o0qlImqoWuC6kAc2m3OkvO4A
	 5LFjql4bxE1liDByAW/BKJN+3npvAeZapuVoL9MyL1T/cJXf/eoppy0oHSTC9tceDR
	 dkvouxApJYllN2f+QkbRqY0zfklzNBWNASS9kLKDCfY1YBxhko3uvvzJcldmWTQBZq
	 muAG4wpQVwCmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2CFC403F0;
	Wed,  2 Sep 2026 06:38:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04FE4127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB0FC400D5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcR9FMzoKuZH for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:38:01 +0000 (UTC)
X-Greylist: delayed 402 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 02 Sep 2026 06:38:00 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=JkQ7mOAk
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d201; helo=forward201a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DC254005C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:37:59 +0000 (UTC)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
 by forward201a.mail.yandex.net (postfix) with ESMTPS id E0C03870AE
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:31:22 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward103a.mail.yandex.net (postfix) with ESMTPS id D5F298071E;
 Wed, 02 Sep 2026 09:31:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-nmt9BGFD; 
 Wed, 02 Sep 2026 09:31:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330674; bh=w9R2ZSBCd4efDGmuQO1+IsPGFK1NY3CB+rJffYGnsGA=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=JkQ7mOAk4oXU14+ctuOssasuySIlVw1stCHv/XrsKh5TAD0vPRLMnjXJ9smy2kzJq
 DWTSErL4BPc7txxQudV2I45E3plDLoj0qVN/vGm5WXlmpJ0JNII0UZGkCk2nLDXHk6
 0tCA0NQ2nkE/VXZnRr6b9BrLMng02e9LrWU1SQ9I=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:13 +0300
Subject: [PATCH v2 3/6] spl: fit: Use map_sysmem() with buffers for fdt address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-3-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=917;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=5Egx6xL6Ha+XUP3Vj4zkHU9dH+dEAgaiWwW9ZvvbsK4=;
 b=xgsPpdbkHlMNDu3jESPVGbBZSt+KNqgkt9hYjjOGZXVl+/iMLu8NkGO2lwAMD5z4UK0eBNC0O
 mGvU9mMECBQAFag3q54QBYoXzODHl6WJKd7I9xuZImoTT3BHwwsMiNa
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.54.0

