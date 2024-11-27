Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444FFD6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE93B89800;
	Wed, 27 Nov 2024 18:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IRfClq+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AA289810; Wed, 27 Nov 2024 18:23:04 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F8B897E2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d43e034ef9so117766d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728180; x=1733332980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMaAl3CdMfgJdK0h8B9zGC81ISiUWsTf6wS9gQrbeLo=;
 b=IRfClq+SOHVEeMte56HEcJsuMKBdKBb7kum/olnZLMtb6Mi/LrdtkX+w1bCepGo3fG
 q8wZQb3KjIMyTTA+oP3OCQY3rpB2DcbKz3zdUiufg8jAX4EE7d0p13CHH9Z+Elw9dYJz
 zcDxA/pmZYDh604p7ITqBq8m7LHYmu+BdD8xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728180; x=1733332980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMaAl3CdMfgJdK0h8B9zGC81ISiUWsTf6wS9gQrbeLo=;
 b=l6tW4ybRcjqQOX1+SN8LBSssVdfzVv+lNxB3FLodzpA3tnY8vC8q1+/WcNOIcrj12o
 0eLnZR/GHjMI+Dv/9DrlMUdPmcCmhRL6x9OlhN7qzz82xrzsLDplJ6saujk+UYfHbMv6
 qA/pZ1L6ndQrQCC+4Tf8cFOhYzOp96+1D8XaKOj3n+lFOYlnIxdDli6jh5Y9VK7+2EgV
 XY/ezYUtg2oEuayqpbN0mZU/7S5KA8hA/Rbs8NRs3BbD6xlKj2BX8LULnoIcPYnBQ57x
 jUd+bV7l0Y3BuKT265wdjmiYI3xjLmMjAQ8ZCliqoBmljRnZPJEmRWhW0DOLItAxUryK
 W8YQ==
X-Gm-Message-State: AOJu0YzT3cIQ5M4ZY9eV7JXPwi9mZlrkPV9+bqK4MppxY7/Lc9xu8HxO
 H1ojAgj4LLsY5AnYty7N8DB+QjTlKE0xg7eKEuSBjb1CLE/YmJ1ckMmGXbP7Qp2UUBWztF3Xpg+
 C+mY=
X-Gm-Gg: ASbGncvJS6UaQEvI1UX1mFwhXW7MR8ljSZJlSZ2AZlQy4S0dwwRtGuzD9zKgQOGdfOL
 EI1hLWvsxngt6VPHCcyMtvDJJDC5kPqRqEk9P0ufdHj1doIJse42rE8XOE8gcwhSKoJjB401h9e
 MN6iiudX0vhFsv9yz7TGYhmIWuy/eabsqQELi/+bNIMHyJOn3ojMtm5KEJ/1DNUIBKIJIe3IOmB
 qxTvKLS8KUM/+ENu6OmcKRc/3BH8UHij/zBxbfGVU3HXnLvPelRBZvLSwrkvwDBBhwDXX/7
X-Google-Smtp-Source: AGHT+IG1b9K+Chpd6hwP9QN7/heGTh+Wl9/RvErJVNIw/+cOojvB7aGzZw+g7lcNXVgG9iLR4lMPyA==
X-Received: by 2002:a05:6214:27e5:b0:6d4:257a:8e with SMTP id
 6a1803df08f44-6d864d06cd0mr41224376d6.4.1732728180165; 
 Wed, 27 Nov 2024 09:23:00 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 05/12] docker: Update to grub-2.12
Date: Wed, 27 Nov 2024 11:17:23 -0600
Message-ID: <20241127172247.1488685-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The current release of grub is 2.12 and it will be good to pick this up
now so that we can update other parts of our stack.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- New patch
---
 tools/docker/Dockerfile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 449745712de3..11beaedf9b30 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -55,6 +55,7 @@ RUN apt-get update && apt-get install -y \
 	flex \
 	gawk \
 	gdisk \
+	gettext \
 	git \
 	gnu-efi \
 	gnutls-dev \
@@ -128,11 +129,9 @@ RUN chmod +r /boot/vmlinu*
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.06 && \
+	git checkout grub-2.12 && \
 	git config --global user.name "GitLab CI Runner" && \
 	git config --global user.email trini@konsulko.com && \
-	git cherry-pick 049efdd72eb7baa7b2bf8884391ee7fe650da5a0 && \
-	git cherry-pick 403d6540cd608b2706cfa0cb4713f7e4b490ff45 && \
 	./bootstrap && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \
-- 
2.43.0

