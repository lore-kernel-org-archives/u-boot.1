Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E440C43458
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 04:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FB084D7A;
	Thu, 16 Jul 2026 06:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="QWYHfTOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E851384D77; Thu, 16 Jul 2026 05:54:41 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615F884D73
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 05:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leo.liang@sifive.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2caed617615so69852925ad.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784174077; x=1784778877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nb2LFYa5ihOfDT2PT4tyOSt6u3QbCpC/u7xasEw0OmA=;
 b=QWYHfTOG5ad5KgVheKK6HOzds4+BG01PghES8+0Y1A7hlEdMLNwu/fy7ADZB1JmQM+
 7buAmRghDYtjwYuI2eYlrEXYQaVjlnm2iZRoqzXSkKeuA2hPA11E1IagIEsbhAsXMP8/
 2pr56246HZyqP37UxMLx+ecfOJrLctK4PkKMEphTvf4waxQvTgF39SvNdoqLOUBm7r6A
 VRPevWkLrm5v6fs8WAGm5/GglQpv1psGZ/f6JK0GOJeHBv1AQmPW7+qAbvP4ZPRBW3Es
 Cq6KIszs4y8ryvgGTXYeAxXoFS/1Hoe4ZaAmPtBRL7/l02WXLf4kOAGLxIIvnqhGvg3P
 e2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784174077; x=1784778877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nb2LFYa5ihOfDT2PT4tyOSt6u3QbCpC/u7xasEw0OmA=;
 b=GAP0SmbfA/x4Cl0AluB6mbgMYswwXXvzMisitsnwxbyko8OAKs4FY7nNZVHU8aCKrD
 ZrCLZB2laiZcLkIGpK7XmEnJQ1QQx0ABhSBNcVr7NIn+Xdvdosyl795K7fjF2m6XlH2Q
 oSf3enTb6eeCDtbpxol2DnKCnHpDziWGSRrSoe/ZeOy/pbr8oU1x6vkwh8a2BaYh+5w6
 sbnJWtJJIdXdm0AXkuLcoqaYqn/U9ZEAeTM4bDh99s32yHfdH5VMEP+N2ZmolNJJXYib
 L/cvWpGOOqVCA+c0htgjDbpcKr6yhnqgihmjdlrfBd6HmMsEZHRvPj3Jk7vg9KjvX3/t
 /O0Q==
X-Gm-Message-State: AOJu0YzjXdN0uXp7NZb/5hMIsQzMoXNnEyi9V53xJVX8x4rvcpWaHkgQ
 fHR8RERL9kfJdNuOWSo677OwIaEklITxIqMVfjbF16xBjTyMlDiZNouR0Sd1nvoI3rvRqWL7ZR5
 yss19WpnbsvZcYz0L0NTFLXW4WiPo6VZseog1/mloPlBsOOaicLjZvZlAZdYKfl9RKbizh1xjNt
 BDfgSmdyIfIZachlfaCEHT9oWmLlaSQpWkcNsoDzQ=
X-Gm-Gg: AfdE7cmQPl7GrpD0BJ+98YZA37VwKynauiw7IELaHq1m3FGu/O2H9kUwmxE1zdozjdL
 amybsC+zYIjuwDfiwGI+KnbAj6UE3iMcqQk0YIJNyFDHA7NH+Qo/f/1N8x+bx6bt4CjUZ5Ljn2H
 TTWIFqrnQvu+/EcQn78po24Iu7FWjzcATIltqFUXC2t2G8gduWxhn+COE7tbtpqduBgCbcOvp9y
 S+Bg9PiCX6ypD0yBO8EbkYOp8FjkBSTgQc/GzltNSHnlauGPOXZb2BseFHp9LQAZ9I8k+xaeAZq
 HOKKOascFr+aX/BpaM0Dbn8nYEagG7D5uygGrn9jWaWI2HpDf7QXdihe64sBbZQqcjYnWW54+ys
 1YdU57ZD0q3IbxRcAh8AEhePYnCM0eCtyT8bhLkEasolt+cPmqyLqGO7DQP8nKjamwfhv3n0AXA
 Tu96lLw7EvFmAmTu4Z
X-Received: by 2002:a05:6a20:a10b:b0:3bf:6c04:a812 with SMTP id
 adf61e73a8af0-3c36c35cb1amr5626061637.51.1784174077274; 
 Wed, 15 Jul 2026 20:54:37 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5306afsm6498069eec.9.2026.07.15.20.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 20:54:36 -0700 (PDT)
From: Leo Yu-Chi Liang <leo.liang@sifive.com>
To: u-boot@lists.denx.de
Cc: tim609@andestech.com,
	Leo Yu-Chi Liang <leo.liang@sifive.com>
Subject: [PATCH v2 1/1] MAINTAINERS: update RISC-V maintainers
Date: Wed, 15 Jul 2026 20:54:28 -0700
Message-ID: <20260716035428.789022-1-leo.liang@sifive.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 06:05:43 +0200
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

From: Tim Ouyang <tim609@andestech.com>

Rick and Leo are no longer with Andes. Remove Rick from the RISC-V
maintainer list. Leo will continue maintaining RISC-V, but update his
email address. Add myself to the maintainer list as Rick's replacement.

Signed-off-by: Tim Ouyang <tim609@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373c..7544518b7c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,8 +1608,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/raw/
 
 RISC-V
-M:	Rick Chen <rick@andestech.com>
-M:	Leo <ycliang@andestech.com>
+M:	Tim Ouyang <tim609@andestech.com>
+M:	Leo Liang <leo.liang@sifive.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-riscv.git
 F:	arch/riscv/
-- 
2.51.0

