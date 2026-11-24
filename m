Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19E606A32E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pqFM6UPW;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aDiXrelL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E0D440654;
	Tue, 24 Nov 2026 14:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yswx5nTc--KH; Tue, 24 Nov 2026 14:26:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 855E540675
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795530414;
	b=hZZXKgJISaUcTlooq9NbpVP63mS8Jv8ndWvd9fi8dAG69kzIXLA2YK8FU0RtODfsRAhu
	 eXo/NY6gOmjBblaed/aHvEoVx3JnJcqJupt0a8h4mV9+bdO8xsrRFDbI998V+PlGjqGuN
	 +vhVSp5Ffou4m+l5g9zeYxomHucIuK3AAFOy/ALBp0noo4la8QVukE3xFpwCCSHnQ0uIE
	 VL2bKf/3SXBsG+781YTvfjeZtRvrsJRRUUm9vOEZSpJQDkN8kCay0lLETYM9KyBELtNM7
	 M0AMt0OgDLHcXyTTGQCvSXGqp/wrzvBHRLsLHJWWZFW1Nk0MsMTbnbvYXF6QjpVRLBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795530414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BdatPWE7SstVnLlf7QAMLi1OOHMM0QIzsNYCiz26d6I=;
	b=GUXKyzLfwdpaF9TqrXy6kF6JbWxDr/sP/S57bPOBH1MMzSVXgGw3EEjzxZEtvZ09Lf3C
	 KwuDqaDIfTEO7ixiWn/J+R09eOLCkVqdBopnc1KoazA4rUyZhV9krEJOtgXWhAe5pyqaW
	 bf87suSupySrcvQ6tCsiy/cK2VnEOgY6WyoYcBrt42BXbx343DwXOZOshVXL+qL0GeAN5
	 bCoZMFeO9MCV79GzJdTkpk8qoXD/KVSZG9v8T/3YKZWzrmDFrLwWTlw2/VXu2n27c7unp
	 VaNH5T7MCjcOPS0mPUmLTsb4EB7DjQUku8e6X25zmnYYyS6G16Qlw8hpfsLDdRRf3Fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aDiXrelL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795530414;
	bh=BdatPWE7SstVnLlf7QAMLi1OOHMM0QIzsNYCiz26d6I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pqFM6UPWmZOQFuZFzjXcsPef8lQpw+yk587dIHTHtkW/XnajMoxxKmItlxtKLKMtF
	 zPClHemLYI3Brg2IR3UDPz4r577CjZ0D23Z0lLz2k5MwoqCjoRIvNSxhfXcekoVoSK
	 Vvx+f4HS9J9VFIPW4FvJHW3E0QnOpX0CKzAj3sqTrRA/FFLWmTjlYoPoteze3lVmqj
	 mgNG+7qvG1uDyNTDu6u2B+UR2US7lDAvZlBoPpjnPlien9Tu38cDmODjWZ475S9aOZ
	 EiR1ll0S0K/W3RMN+fwIEy4jKgUD3E3Q+arFPObWcluGr0iY4qjhbfDgusiNMofkZf
	 6lo8mTLm5BBKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 855E540675;
	Tue, 24 Nov 2026 14:26:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 307D81AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21E6440675
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztBCgI9xDXbZ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 14:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEB6840654
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aDiXrelL
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DEB6840654
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:26:51 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-862b98b2e47so1796517a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795530410; x=1796135210;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BdatPWE7SstVnLlf7QAMLi1OOHMM0QIzsNYCiz26d6I=;
 b=aDiXrelLxHsCTd61m8TTF8wCoWxkadrJa9p5Wln0duzFcK6xzaabgD9keFeUfwPOMj
 9JTC4CQQwQ54b9dShkiP7MKutehJms2JAAVNS0C0fIXQXU1zuPR9Q/zliDSMsh5doaGY
 fkETwyMgxbgc91z8QSjU8qcWPpqO+5g1kuaxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530410; x=1796135210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdatPWE7SstVnLlf7QAMLi1OOHMM0QIzsNYCiz26d6I=;
 b=fSi6r8ORw2iwRuQ48Zt92wfXdKFCEibuUbllTbJg5rh7pEsYWqZtr/3UWXe1SUkCfT
 lVZHkX28UBEK8vYjfnkW0/uDExHPaCFIQTURIlt6UJ7msG0lvzwaSpOchPn5mEdQpGk/
 Fw/EYYrs4f5GtuAThaSZDWrcO75FfgQZud/wMvZDRMCJl6ljscfYbVRxJUmiatyScwO/
 ctxsNyPWygAQxYYHZ6yvDAfS6I1NK5m0Z2jNRe6vIFgl3mF2pylxILOpgNRKdUBHDS4L
 VPRFdFtQZFLEMTBIe8GPLwKZ4E4+G3eLkI8C0MF92tb0wag7vNj0AliJWldunxRoDxKl
 gPHg==
X-Gm-Message-State: APuU4Z8dPwptk6mPJwbLw96g02HcSHhCuJMWVoVGCcQe2wtyRrwfi00o
 I0UEDdNWg0j+TasjHiG6nCTQfgpqKXt9sm4sgcXYD1UCI/jdadlSZznIvRUzL8CDlambRU35cPe
 KFjPFH0HR67oK
X-Gm-Gg: AZFdTZdglnoK653KPyO+iQivwTEPkpVcR5Lb1TtYKUe3AafLsYQPGzg3REW0NP/T05I
 M2Xc0Wjyqg9B0wQ6Ngo2fTB5SACW29v2F09kZRf5KXAGgLynFbdkL29GTj2j5gLNE5YK5cNQEcm
 dmSe54YJGhbfj5HRO/ZQzulSFDJccoJMYa//1t/X29mUtLz1x5ZuCtDfTfC2DUGo2z2ld6QqH8r
 OsCf6TN+vfEi1oSx3D0y1qTIQq3Z5hAnMQzbCKkvxVlmwp7CSo/+nhABFEbwD32izVSBhBWGz57
 AFr/toNJx6pMhR8mgNUPcT0kgEu+quJiZ9By2L2Dco948uoLnYkgFgzahyTOoCvJj45ML2ezcph
 zWqEVS9MtLdeqJ0tpinlHcfrXnwR27d3G2ifWVCxzhQtCgKq/+18Qc3mBGyF9ONIJWs6IbmXCyP
 76R25Ax2UGi4jKxqpvehNcq1pcn5hISgMWtZPhYU4errhEzka5dcfVdptaiwfz/R/VA9uvaXN6w
 eLazLoko4Dcehxg7qGsZCkOU92m8csUuHozY7855k1ePS8X/RHgeuKpnrHwM4MQ2OhDEbS2co7T
 lz4GYgLymbKR9EfcZJ/dOGGaKkn6glIy1c1ow3x8eBYL+yXugntkHe88/lkBOTur/oZepdHrIQq
 de9dpqZHYlP0uo+TSSEqDvs9tfwNB/Levpc0GKxELnKbNJrY+zke2ymtM9+mlrCK2ECW1fe3GxU
 9fRjw0IfJNefXcL8cPdzvh5cGMYQIfFJSZ4yvJtnRQm3uu0UdVrM5Rieg=
X-Received: by 2002:a05:6830:82f6:b0:862:a2ec:dda8 with SMTP id
 46e09a7af769-8631590938dmr17383587a34.26.1795530410652; 
 Tue, 24 Nov 2026 06:26:50 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631682200esm10622299a34.2.2026.11.24.06.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:26:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] arm64: renesas: Reduce size on Renesas R-Car Gen3
 Salvator-X(S) again
Date: Tue, 24 Nov 2026 08:26:48 -0600
Message-ID: <20261124142648.947401-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To save even more space, as it is an issue again, disable the expanded
help text for commands.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/rcar3_salvator-x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 50bfa1853241..3a51886fcf2b 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -31,6 +31,7 @@ CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadadd
 CONFIG_DEFAULT_FDT_FILE="r8a77951-salvator-x.dtb"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
+# CONFIG_SYS_LONGHELP is not set
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-- 
2.43.0

