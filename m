Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76627C982D9
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25A9E40B75;
	Fri, 18 Sep 2026 10:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_lur-xumH0e; Fri, 18 Sep 2026 10:53:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3835C40B58
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728786;
	b=cY8dI5/YoKHRidzVTh2wZTbYGIebqkSj3idaAfXxWK3Ek3CJ2WPXGyjzoUye5uA37aRv
	 NzGNllYVFcbQt1pA1J+baK0QYcrMe5Agl1m0+oFGwwv1olD9JnXF+GAlBb2BO/PUNLc+0
	 b0bgkonf+kQDVtB5xPNgysMsWjdyIi3Ro7X/ZsFJo+cqQkTpDilYppB96ylm1JAdh2U24
	 531dz9GmDBwxILO4E13pm9ex0mZPvFJi4ROd5AbK7aQWZjpOqU7zv4IS6iLhsYwRjeC7m
	 3/Zsicg3UTxn9BcrKkKEFN3gwMRjErPpBaxWpEhjOucZYSHJf+4XNdiAdGqnrdXU0cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E7qfsNVpV9GNQzocoOV+sfYUxRfwsxUI7xQzq2/8QTM=;
	b=lKVGzeUn2FS+9ZN7DFka2bJIW2FyD1AL6JVEeSWLP3Wmami1VM09tfqNDpS3zKYM1al6
	 YW7t5wMmll6tsFM4Ui+5GFM4wGzx5DtNlZm0KWjFBppavMpthxqaXVrwfyUT6HR057WvF
	 zOQYMhPNmJY6UrYIFNbnFoSjJKDj/t989/eDawwruXRWbpv119PvVXopfPRQDo3jZlyeD
	 yn3IJFIUBf68uYMO9ZQ4701pG2/MTzJvbl4TXTOdabYvrtdf+k/aTuyA9ckOPL+RxuGzo
	 7ZgLQ/kfULhWIJuXR5z6H11F9nEQVfG6J1HxI9I8dfh/UQdxS+F4Ii/huoM0qec7G6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728786;
	bh=E7qfsNVpV9GNQzocoOV+sfYUxRfwsxUI7xQzq2/8QTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNCpixqeAO6cq6NKMwOCA84nyjtogCp+WYmtSMqInG8iys01h5UP0j+pp2CaLxKja
	 Vkx11p0zwJgs1McqVc8lXN5s7E/nZbWYSxsimaArA4ZSwiQqzGUtnxpLt6sQpJ1BLU
	 1MNexfi1jfwrXU9YwvFh2uqc3SXxhj4qw4hUnAPfk8iPaRk2iODbRT4bHvSLGNRLec
	 b40Lifhuo7tXvDeYlR3oamItOBKzQv6NaS8qHdr6DXqjP6ZiwBUA1lw8STVg9LEB/j
	 WkptOPM2/tRpVp42ka+w9sXqtGVfhTJez+AxGh45shFrFOupQPW+7/fJ2gU3+Hoqo1
	 sO0K2ml+UGPpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3835C40B58;
	Fri, 18 Sep 2026 10:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1748742D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF73B8125F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqCyIK8wnrTQ for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 63FC281270
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728782;
 b=btbJ+Qc1fZsSwR2prHbz80j8M/bM9JgEe/sJBX5u1bE9AwHgIiUmvPHKUrksYjOl62Gt
 Wmg2FmUUUPP60NxVz5znD1vsLb7sHCkvJpU/tQ910hFzxMDZRdL/LI0JVy86ZgkqspKCr
 UWgDR6nGIaU3u5mvkAEtody5lswcQnhDMEBgPc77oSy0y5hgk9X5GTnn5gKR04x+BOYsZ
 2S9QJ06+wZgQ4DfDyWzd68aGwr3FCgXbzQwJZItRXXwsjcvWZfz2evGn9AqEJYQeKKtN0
 gNnpNW8GCz7PkC7ZMqdoakjz1df1UbmXRMoHqFKwnsYoy2EFEjnsYczzJU/WJPravlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728782;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=E7qfsNVpV9GNQzocoOV+sfYUxRfwsxUI7xQzq2/8QTM=;
 b=hqastd5QlyMV7i9e0+kjqW3UABvw1y5QCYt3CnDx5vVe9tx486geQVzrod96DVuADyzy
 bT6aQmcih/2ZspozKdQ7EpDDTerJfb090tR5LbIADnfJ+RXx4OJFci+ZwF2oESs0CVZ92
 k/ZD0XOGurEjIG/+3bvl2oLp8wK4+fl9pBd7hajIVaeqWY5dlWpRTBaMXbfF8MbRg3SUf
 WC8fSPYTOHoIl9ErO3/XhFm0MoSZakbVe7JhuicgWFERNgjY0RvW7l7wKsicPIwIhPixt
 dtBnZouq0EmuWEMJnR7JKsm6ME8HOzujODwsGGD5aJ1df9VzqHYyq0ECBNjYFEf8hEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=HKZ0njIq; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=HKZ0njIq
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63FC281270
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:02 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso4745285e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728780; x=1790333580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E7qfsNVpV9GNQzocoOV+sfYUxRfwsxUI7xQzq2/8QTM=;
 b=HKZ0njIq9l0rxyqcXKu/zt7ZpjvF30MFcKroypWNL5uMSUkFI7qUwJxaIwwGNFrSEF
 lkZTlw7BgN1RKiS1mb4XlAXhuJEdIPX2gjovdRxzrpzyIunLMqjXp9UlS+M3tlbea2UU
 j8mcMV7ioE3cf98JAb0Fyat17BhCP17UJr1V7VaEuH7+qeCtqKWnl9mX6csMCqjRMfT5
 tWOWSql9ibBd22MdMb/Z/m9Vqsh4YFenxlHzgEHJMy9JVXv/UNCC29O/r3QFMr1Ae4af
 iBrEZtocFSlQBAGWM0kiuw8VUA03HYiOpvNLu935ZrnapclOuqdIGPoP/Uie0GYiJkko
 QUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728780; x=1790333580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E7qfsNVpV9GNQzocoOV+sfYUxRfwsxUI7xQzq2/8QTM=;
 b=Sv1IPSChBM5SeMQNrOsaZGsREjEIBhXdbPhkyd7X1dJvf2jCXoSt2D//4eQmOyiGt/
 sra2AXyHfc7Gn/ZHOEnYkUOMbMFwZYFHwHIL9783RXAm0CEINhYsRJK0L2epneDeX6X9
 2d6RBes5yFKORwVohHInYBVWfITtsk3BzcXI7V6d7GvUjR5VJhom82eBdKeMyixvtIYs
 smpzRkL6zaQJYSsWuNV8rm+QAgl0IhjJ9Ldc6pJcdmk3JpYQ62+ys430vSShDXC0jrGb
 MmWEKA5hgrhuTVRkbNm3gpvZF3bwBhd4WFULrevjr0WqAiKdQ+WIRtXMJvM5Kil9MXn1
 KK3A==
X-Gm-Message-State: AFuF++kLXNYcJMs1ywiVXJeMsQoPOr8LU8vyn7FlnxWkqhKER+9pKcrA
 TKYdmEhD1okrE6aYFw2snuua+bSpB9JUdHY+Mq7G4U8MIQbJqxEH5QMNGXGEh7q4PWc=
X-Gm-Gg: AYBFou0j1I7/2COjeIhPhJrxhyw5qfoxIqF1rkhka7Km/zJp4xdPN5A2/z67VoAZ1SX
 grNYgKFxGBdB6zyPouJZeKPD4owQtUn9UNU2w9q/oTbmO11O6WgFzOp1EXTKUHDoeT6UbDZR+Xi
 Kmx4ynjjU4bYGZF2AihdC6d4Rdg3JYF/6YhW/KqCy1Ok5SfcvbBd5ZR1RTxdCKCvIKwGzhoTqTn
 8SwQoL29XLIy32cdB3UtlRYf1teWzfakqScMrFCmkIkgPUM1+EfwpbbLrkqobHs526QJWGrXOXx
 A1ydMsSzA0XwBXW60hnmb8kKgn1CYLGBYUYt/o8WITGChXQHRr20K72GGeKT52C26i2gjyJdfFt
 0RQ9zZWFkpui8SgfIrJ3RTtjduwqukULp3908bQKVjQ2jAFT6AqxNiSjfx/lq0rSeNp4Jje/Nye
 Jdlia8Sz53aQM+XWpb2xlurdam5rWcH915x/0G4Srb6WnAJpGzBfdLLrDGH7/AK4KD87d2wxwiL
 at5pqYNdEXng1TUOBs7lDqfhEQTmrjn0uUcags5HSSa8pGhOWXE5A==
X-Received: by 2002:a05:600c:8b16:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49fc5736db4mr21961515e9.26.1789728780230; 
 Fri, 18 Sep 2026 03:53:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:52:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:30 +0400
Subject: [PATCH v2 03/11] lib: Let SPL minify zstd on its own
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=alchark@flipper.net;
 h=from:subject:message-id; bh=pDy95RHXLH2Lwdc4eMGBPrs452WrJalndPcioKKpCac=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf/7u2z9lyXnDSrj/25akCR/d2ZzuN3ub55nkqI9L
 sz9K/xVqWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp1nVnZHj1b+Jhice8grs8N31LtjR655b19vLOiYsdvIRF7pzqnfidkeHWDIb
 JK76K2154ucEqKnCqgmfXjUvNTNabdtnnNArsEeIAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
enables zstd for SPL alone gets the full-size library in the phase which
can least afford it.

Add an SPL-scoped variant of this option and key the build flags off that.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/Kconfig       | 12 ++++++++++++
 lib/zstd/Makefile |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index ec6f162dfb57..1292185e03f8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1023,6 +1023,18 @@ config SPL_ZSTD
 	  buffer and takes its window from there, so the compression level
 	  does not change what the SPL heap has to hold.
 
+config SPL_ZSTD_LIB_MINIFY
+	bool "Minify Zstandard code in SPL"
+	depends on SPL_ZSTD
+	default y
+	help
+	  This disables various optional components and changes the
+	  compilation flags to prioritize space-saving.
+
+	  For detailed info, see zstd's lib/README.md
+
+	  https://github.com/facebook/zstd/blob/dev/lib/README.md
+
 endmenu
 
 config ERRNO_STR
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index c9a7dfe405b4..9d1b4d4a4f72 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -11,7 +11,7 @@
 obj-y += zstd_decompress.o
 obj-y += zstd_common.o
 
-ifeq ($(CONFIG_ZSTD_LIB_MINIFY),y)
+ifeq ($(CONFIG_$(PHASE_)ZSTD_LIB_MINIFY),y)
 ccflags-y += -DHUF_FORCE_DECOMPRESS_X1
 ccflags-y += -DZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
 ccflags-y += -DZSTD_NO_INLINE

-- 
2.55.0

