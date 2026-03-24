Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65467FEC0E6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEF3807C0;
	Tue, 24 Mar 2026 18:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="jUFlW2Y6";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="TAjXY483";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E245A838BB; Tue, 24 Mar 2026 18:02:29 +0100 (CET)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00FA80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=hCh4BjxCaHJSjrb0314AwLSZwsHFgPH5LEc7JuM7tjE=;
 b=jUFlW2Y6p+2hZjCIBhtbDzRm0Lmyjzxliimp7YCWNXqqQGAsOaeGa3fZVDsgbWnYlNh4TyXOz2eKb
 ajvhiBpRqP1/YAJu00ftpjCtcvlEsgeuW4vHIl2xczr7zT74e8atZTtiVIK6Nf2G2dG6SpMxkclJvb
 53mdLP5RyvSU9X+I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=hCh4BjxCaHJSjrb0314AwLSZwsHFgPH5LEc7JuM7tjE=;
 b=TAjXY4835HNeG+BAwbpTVYRyqHp1ffZbpKpXYmKKWrRBxvMOJOQAI0dny2BYNYo8BCDWMDKPKIFqg
 tAf8j15XgOWM7T8jpK+RMvw9BQVsS0iSb34osnKRKukryVGQPFXpRU8KA8JBzug/smcUunc+7YWDTr
 oalAM00hO75LelLTPNmKffU8jGecBTbrFoit6CaqsU69I9qeOnYtS5hrOMu9CBoDdVLAkjO1Zg2Jer
 jah/NrNYYvLcjpjnfLNW2rsYulb2JIjNV9H17fGT2cGDapIgPryUv3TthkU4uVRHgL7YvP+c2TdhCV
 OtjqPR60XoFelT/E7erXFrvJCOVwCxQ==
X-Originating-IP: 20.71.22.178
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 3ab56a5a-27a3-11f1-be08-754228886235
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 3ab56a5a-27a3-11f1-be08-754228886235:5
CFBL-Address: prvs=0543124a45=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000331.corp.hitachi-powergrids.com (unknown
 [20.71.22.178]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 3ab56a5a-27a3-11f1-be08-754228886235;
 Tue, 24 Mar 2026 17:02:24 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000331.corp.hitachi-powergrids.com (Postfix) with ESMTP id 440794043;
 Tue, 24 Mar 2026 17:02:24 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 1C0C460B7D47;
 Tue, 24 Mar 2026 18:02:24 +0100 (CET)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, chuanhua.han@nxp.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH 0/1] spi: fsl_espi: fix din offset
Date: Tue, 24 Mar 2026 18:02:11 +0100
Message-ID: <20260324170212.481394-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Mar 2026 18:56:27 +0100
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

While working on an old T1040-based board, I ran into issues when reading data
with spi_xfer. It seems to me that the driver is copying the data back to the
caller at the wrong addresses. I am not entirely sure what was the intention
with the original code as far as I can tell.

With my suggested change, at least a small tx of 3 bytes works correctly and I
can see the expected data in the buffer.

I've really only tested this with a 2016 version of u-boot but the code has not
changed regarding this since then, and I suspect that there's not a lot of
boards left using this driver to read spi data in u-boot :)

Best regards,
Tomas

Tomas Alvarez Vanoli (1):
  spi: fsl_espi: fix din offset

 drivers/spi/fsl_espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.3

