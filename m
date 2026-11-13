Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18059606A336
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UjjX/fQV;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=YWto5wnY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5B75605F4;
	Fri, 13 Nov 2026 15:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-u6LBgp1LTD; Fri, 13 Nov 2026 15:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C4FB60678
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794584827;
	b=HpZUOALMeCK8LpI0cm8dtx9w0T+xW0uYaFlpIsAbc/j78zNbWw1KFPSVIsadXv3woZ77
	 quSLgcgN0BIPUpsyJEmnXAGeL0qnizjZdn66TSsAJB5wRb3vTgKBL8tJl4CQoGmp3C/px
	 j4zUPT7/z6zjn+wKK9+FN/H/joDpQsrDrHaKNVYpwKTGw3Le77VdCHzSxZSzIbcdRzTJS
	 EJKn0ZQvBU8sM7uXniZU3LtcODsDk2PzrsbOX+/wl1+pGKYEolXV9LlglZAve5u9RMfWD
	 Bxpo06rN+WSlbLSYGGy1fbMwjGhPMd5DO4m0nhQLoxlWeDWCIm4/3Q+h+zt1UNv/q/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A4PK6snnmMh5fd9HAygG1gqY9FZieF6etxOPyOIaudA=;
	b=VyHHitNYoielDyxtqQBYiCxzVZ+4aCevI5ItFtZrHJuEZByPOm3WWCLcS0yOFWDuwj3E
	 kL0ShZGsqSYLS6O8Gqjrzofoh47JI2Ecfy2AXYf9ZWWju6hLG5xJnAWNW3Yllxpd7/bMX
	 UkIwDs5bSNMjL2UwMafoPjlMGwFM+VlE2x2WNzPxFQXcvm8IQwxJLvozN5Jk4BJpW54BI
	 cRi6zfzX9qfGvEKbgaorgVLZ+4ysC5QfIY7sU3kGyMbCOda6SJ+Gv3qgxnW4GNMEIX/a/
	 vzrNX9GPQCOWcRkPS2M155+4O29vgVU2N0mV0wsXYDL4jHmikox+ARrAWz3tpvLF5uw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794584827;
	bh=A4PK6snnmMh5fd9HAygG1gqY9FZieF6etxOPyOIaudA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjjX/fQVGxoFyoZ6X6jT/LgDBzfyIeb5YqrUx3t5Wq59NVGij0VZHjH+jicNxYoyo
	 sbAgxiP9qKK5SDBsbiDP/F6FIkJiYU7AD4IYL848zswzUj8xCssjKmqZrg1cZiR7sH
	 aXEAerxqSbNWL6ZWbknCN9wPq/4jB8M/gl9K9jdqd15xfVCPz+ueH5GfG40OOWlQGw
	 ZcefqaDzOGD6ujqYFHmNbOvmVTtGxvmrCmrSw//Sum1fpeb6qIEn38+6Z+VJPItIwA
	 CiKtw+zszeEOp2lTbxLHkqIuLsqfILgR+BkFUhXhUGEyvv4bEbx6MV6NQUPSbpUbgy
	 R0MnhnMvKoV9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C4FB60678;
	Fri, 13 Nov 2026 15:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D3AEAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3902E811F5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDiyKmFXOgpc for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:47:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BD5E811BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
X-Greylist: delayed 88902 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 15:47:04 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=YWto5wnY
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BD5E811BE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:47:04 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR1pV2w4sz41V;
 Fri, 13 Nov 2026 16:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794584818;
 bh=A4PK6snnmMh5fd9HAygG1gqY9FZieF6etxOPyOIaudA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YWto5wnYXXDJFQmQA5IXNxPZyflHHI9zvTqU5YpnZhDq0ckbZ3Rk0OAl2qgXbc7PG
 jnY3kyZ9czi96NtNSW6nEbhnq5K2+Qi9a816gN07E7lMu32ic8KPiEodSfiLcOHppx
 RtKvkMLhPrJj7LasrKP5Ka6rEjGl3IMTxQpMaqdKePOJhlr1TCP9/XRrFhrqEDMhBl
 jDn+LLzZVF83VjM1z+UJVxQ4T2Z6SfhZmad6UP133/n5+8I9AvRkUvxrktWhRnPCb7
 p56A96QIQK5mvWAaHQrfFPsf7XjAD9c5n3edRNUxu5/s9XhXRztXsqLI8uAYJvuSXa
 h/27KEQoXBx8w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR1pT3tXCzJLj; Fri, 13 Nov 2026 16:46:57 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 13 Nov 2026 16:46:43 +0100
Subject: [PATCH 1/2] rockchip: fix MAINTAINERS entry name for Rock2 Square
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-take-over-rk-boards-sjg-v1-1-4278c885ecdf@cherry.de>
References: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
In-Reply-To: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This MAINTAINERS file is for the Radxa Rock2 Square, not Firefly.

Fixes: 7c1058fadc8d ("rockchip: Add support for Raxda Rock 2")
Signed-off-by: Quentin Schulz <foss+uboot@0leil.net>
---
 board/radxa/rock2/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
index af974c983047..b789557a062f 100644
--- a/board/radxa/rock2/MAINTAINERS
+++ b/board/radxa/rock2/MAINTAINERS
@@ -1,4 +1,4 @@
-FIREFLY
+ROCK2-SQUARE
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/arm/dts/rk3288-rock2*

-- 
2.56.1

