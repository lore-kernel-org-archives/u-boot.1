Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8C606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sqLjOvAs;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heweAsfK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D827B60687;
	Fri, 20 Nov 2026 07:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STkHI4CufrAM; Fri, 20 Nov 2026 07:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CC6F60750
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795161485;
	b=FfXjAiNDxnxS+PXkNQdnvS0I2nbL8p2cVunH/+Q1iL7twIwCoTu1NJ0jw8AAGWRK2odW
	 l1JN2mP3yvwme7swHD0+PEfqkZja+Udo14cQkrtQdOenFUBP5rN1RkfTEBl7pNfMGQCjP
	 pkSbMt0Zww8xPIaxhOZ6l7pUVIDjbt/qA72HohRtXbV5aEEMeQp8mYPMBMQC+AauwAB15
	 vAvIULKG79vU2QKTvoi5TYtLXb6PDe969rgCB/XXO9LEwRuhelR7gRd4jx4V7UsStGxaO
	 XusE7/7OWhP0rx6H+psW/aahf2i2l/SmzOaL2NuJiVx7McPGB7XacQMfYgnmK7tvfsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iHPnnHmVn1aoVbEThWIz95vQIqLanxo7XFS8EeI75yQ=;
	b=LIvSPalptrnOv2B8y4PfuLX49DW8vMYV8/eTEYJ3zr44tegFy0FaLSWAc9V3IP+72jId
	 1fEq12Osh5TGld4lNIweyaG+AEEqcXVaEf0y2KSn021vAlFPGcp6xfBObeT9p17z/tUqu
	 T8A1hvQrn322ZBDsBRRWpNWrIsSafrmHAnsbD7fDd+2/sk7wwx8y9VUOXntax8wVunTxU
	 12iz4ojP5m0LO+htnmyX2ty4pYLVfEg8j1WJ4QajOhgCTB5j4l/NDKARHGFdGbB2atj0u
	 1C97+JSEXZcCnQUReF+Hl5aOMNd1iN2lcaoLqMMxU/EaNbTpB9UE421+BJCDRiyHFZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heweAsfK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795161485;
	bh=iHPnnHmVn1aoVbEThWIz95vQIqLanxo7XFS8EeI75yQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sqLjOvAsql1w+BtT03a8jHFKeHKFcTrH7ziqSBjPdDCVr00+Nr2fQ3rJzS9fwY6/g
	 PJPubiPLEcKLRY7e1/v1LOS5LIFc/L62J7El2U3qQxp0KHdtTV4rZbRil8xw9eLbou
	 rl/R6bB11g/wkJ7GAUgRrtRY2/Q/um+hzj9s7SOoh6NfkI8R++5aDXLF+gMdkYwDT1
	 UteZFIQ/ckkrIgoQn1e9GXRPRsmv6h51GDVByb0TlsambdER1rKxMuiS5SjxUupJqj
	 COFCKZWiEk8FM7HvlElN3hLilBRin35dYUIL0xJOqoHoWBBE4+7kaO0D6kkkXwvoCM
	 wK2IvV30ubMbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CC6F60750;
	Fri, 20 Nov 2026 07:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B422922B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5CF260750
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSBXkjXf2TYW for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 07:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B811460687
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=heweAsfK
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B811460687
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:58:01 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so2743985e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795161479; x=1795766279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iHPnnHmVn1aoVbEThWIz95vQIqLanxo7XFS8EeI75yQ=;
 b=heweAsfKPrbWQ4nxl6tV4SVgHTL2W6pXWGitbR/XrKQ6vMymudNMyKzWVBIW5+XvCD
 kESFUxQiMPtEyd/jTFYCbkRQOZi8cFY7uBPdk1ZCpk8wvyUVXWGkaFIz2phvVuQuHCKn
 PptVSwJ2WtLIDKEGAjPyT8gCYp+12KpTGaga/KrnSr/zfU3RxIucDK/TZdqVl6ZpeEb0
 /ZPtLwMiBAWL56w1do8QrzyarmgPbSlruZ68MlnQpPSm4xPaqmJs+70/wruzQDh/mkQE
 b4qnc6WyyfwNF9YCwjx/D1g9idjQobk5fZyZ7py6qHhQK1Pmt8rwo3VQipebuLZN9UGL
 kApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795161479; x=1795766279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iHPnnHmVn1aoVbEThWIz95vQIqLanxo7XFS8EeI75yQ=;
 b=wQndrYiJH1SBLicswtsYaAyTr6tWjDOY8NnIygZ/qSoavd0NTHQ99RwO6jiMHLda5y
 pKNjgSTf61jRCexuBUNqV6+S4kq3X+r+2Wak4BDLVtyZqKgKQNegSmwSpF4fdT/0qTTP
 HWJQwMU91vLboFfgghE2hgoyJw8E86hvN8J9IQ5UJ7Frf8IRvtSHZC5mhVFFtXm3CKkw
 rhyxoAlMXE7rH9ApxvGA6/tUHwH/9+UUmx/tSIFdMuNRWuJXUW2HrTQ4yCgQc5H2eiLY
 0pFQyLFsamlU7flZjwQ6t3BmJ+jU84lU6f9eD/G+ks12sr1X0VjQ7rjjaj9zpeH11rhm
 CUzA==
X-Forwarded-Encrypted: i=1;
 AL+hErGczsA644N5z5ImdI/IV43qCkCXGwnftzDGErU8HMUWw68HH8L7Cjn/S2yhDSU62L9aMXU/jq8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/H4cgWCIEj52lIRArBu3yx7p8c576Duq0yLZsH5MR+lrNwDqsq
 oUV1Dw8NTKIwatlaQlowYWnHcUF0UA+OxGUpCZkAK2W139itNjTwBFVX
X-Gm-Gg: AYBFou27h/RL5uTryNxzcohD4t4bPGmK3d6grZwujZNSFkXHcGL99q4J0DNavSNpM0A
 19B9Y9EFbShM3ZDTWrYb0avzte0nSg2L4Qf2prbzKczzqCt0G7wfVJidOkgjIIseOR4GRHHzmzq
 cpkacTXwVU76/CvclB4nSE9QAWWvCPpAL0AynNgPB4R0B1VZtRdB0nlNPC+E9ngqtsVF53Jd0/B
 Z1M5PVXxCFbu6lh9eSGLAFrLXBDWwHlWSdGdolU+ftQh+32cdsePTx520TWUmBL3lQxuaVRTyBl
 POq79Tj84ewSqHXNZcH0OITQCncrUSR4hqZCFzEBY6bkyb60Jqu9TviqD+iL4FCZxDtWN+D3/4X
 V/hb97nAIou0k6RVMs4pbwQL/kIsELlGSoMsQvFb/Bw+r9CvNtixDcKZgiTrndbQETk1NdPzzo/
 qC99yEk48s8oRpEBIYAtT/iGnQ4j8hdbg2Ctu6pcaJRU8Yd3VsTgbUB96n1m2/W2LLKPVPBD4ci
 jBiNZHXmo2p/DxVeci7RypfUspNqEPZgzSr0p5h95Kpc3V3SmE9qPHF3qR6oncTCrxgdvMYI36R
 mMU3Jo8o+gzim0W11/00q7RU8naPztj2O31ATNqS31tNqo00tsxfdnBLQCpqFhQByWj69m5QIhx
 4FOsA7GLCJq7998zTDINf5sEZtzR998nSMXXQOF/RpJ3+pYotcaaYH9x58fO97ATIF4JP2miGYB
 5/W8FPmBWp4xXh
X-Received: by 2002:a05:600c:674b:b0:4bb:6947:3e1d with SMTP id
 5b1f17b1804b1-4bb8892c0fcmr42186125e9.20.1795161479250; 
 Thu, 19 Nov 2026 23:57:59 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm55771795e9.10.2026.11.19.23.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:57:58 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] efi_loader: efi_fdt: fix use-after-free in
 efi_load_distro_fdt()
Date: Fri, 20 Nov 2026 07:57:50 +0000
Message-ID: <20261120075756.2548804-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The device path of the loaded device-tree is printed after it has been
freed with efi_free_pool(). Print it before freeing it.

Fixes: 5c1b5e6bc59a ("efi_loader: find distro device-path for media devices")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 lib/efi_loader/efi_fdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index bfaa9cfc207..5aeff62e76a 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -119,10 +119,10 @@ void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size)
 		if (!file)
 			break;
 		ret = efi_load_image_from_path(true, file, fdt, fdt_size);
-		efi_free_pool(file);
-		if (ret == EFI_SUCCESS) {
+		if (ret == EFI_SUCCESS)
 			log_debug("Fdt %pD loaded\n", file);
+		efi_free_pool(file);
+		if (ret == EFI_SUCCESS)
 			break;
-		}
 	}
 }
-- 
2.56.1

