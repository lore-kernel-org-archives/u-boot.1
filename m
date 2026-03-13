Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7818105F797
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F91842F4;
	Fri, 13 Mar 2026 11:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jisYMFsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C758D842EB; Fri, 13 Mar 2026 11:42:52 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012088427F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D557DC42701;
 Fri, 13 Mar 2026 10:43:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B7BC160027;
 Fri, 13 Mar 2026 10:42:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A857210369E77; Fri, 13 Mar 2026 11:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lkGWj1zUsEirDw3doZaE1OJhLh+V4dNVrMdW72dm5Gw=;
 b=jisYMFsECZcwZd82fg0fEwCkPw+kKejmSfsuiJ3QLvtPt8XAwG4E77mk3E3vWW6hdebmhg
 K7h6gUJHA5GiORyssypEnD8y86LPANUbWFe+FwEsa2njy/rMDOjnWysVio/KCvtqhoHjwt
 rYrNJ1j6skgiSupOmuL0f4jFtDqwg0ZMtjIutvQ14gsnMraOm0ac4oX29lagWl/2/rUF3J
 3PmYnI3/KvOMagy9oO1s6B0GvJHJltqM8MY0iuRdridCgQpVACN2DgQaC0ABkQ472bUVs9
 1GviBlaxhf8K+s3NrJ8t/Lq1iE3QaUPOFV8ikay1uReu9+UnZqn4+Xy1XYN41Q==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 7/7] MAINTAINERS: SQUASHFS: Add myself as co-maintainer
Date: Fri, 13 Mar 2026 11:42:29 +0100
Message-ID: <20260313104229.1555236-8-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

I propose myself to maintain the squashfs files with João.

Also, reorder patterns in alphabetical order.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73be3d545fb0..e9b04bbfea59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1769,12 +1769,14 @@ F:	include/spmi/
 
 SQUASHFS
 M:	Joao Marcos Costa <joaomarcos.costa@bootlin.com>
+M:	Richard Genoud <richard.genoud@bootlin.com>
 R:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 R:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
+F:	cmd/sqfs.c
+F:	common/spl/spl_squashfs.c
 F:	fs/squashfs/
 F:	include/sqfs.h
-F:	cmd/sqfs.c
 F:	test/py/tests/test_fs/test_squashfs/
 
 STACKPROTECTOR
