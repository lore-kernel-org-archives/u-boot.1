Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E03FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3203D846B2;
	Tue, 28 Apr 2026 20:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S8UsWcjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4B5846AD; Tue, 28 Apr 2026 20:14:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55551846A2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A12D3F4EE
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777400089;
 bh=H/xnREH8FcpaqDwPuCwrOi8W7vVa4yd8MiApK6jvQXI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S8UsWcjzQBrWXNJEX2cNOijTv2Sdxv+w8usdFnKHvrMzAp0iQVJjyUV0VyWGJpVT+
 mEFRjMkLfJT4/0kTVlwORfuPNCMxP1ZmYXwm3MUihpbhZ84wEW8gPbl+Ovi575Vw75
 FBEPlIgnrIfB8D/dLYGnD1h5L7l+lWqE1fyd7JwFayWBK5pUXTEuGaM2PEGzxmRRbD
 R56jhS26/XckhrmikBTrbLkgj9nYCMRU6/b2V9QuIP97UsRhJ5Y+b41WkvUhQylcBl
 r6sXgOTMgIzB3UxC0LBIC0o4HN9ctMkVAYAx5DL0SU/jMABSRyfkFdIALxKdheo78w
 XECOTU41qzZpPrFSY7Bo5cAwfPHh2MW8OjLTzzWrljv8oaLyk3lViu1sZn01P8WaPC
 02CCwyb7BJBLAyHaT1iFUfqc2BUYluUlUGZBgyDSjN5q1V2bam8Aj9A0iyWU3acFUR
 hZey6j2/Sp4eE8G9AE5rjg/FCqB7e5ER+hQMLmCtV3sqXPCGzGWip8f2QYOBg+TzMT
 1vQgkCvoAFfxzhhdItSwe9nzCf5lLjjqYDtadhKtgcEjPI7zLwI/eklakVcDIC4XSJ
 U+e7FSjkTJY4moDdcHP01+auf6WAn3C+M7vLZx4zq9z7oBFUFvzwcIL2n5nf/ucGwm
 Qtq8XNDqDNXeOpilcrVOFZ/0=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso9017036f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400088; x=1778004888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H/xnREH8FcpaqDwPuCwrOi8W7vVa4yd8MiApK6jvQXI=;
 b=azrDTofOYx99YGVSbqcWPEnbDCMlm+Z8u+uaWWNb6bAoSBABmXUHxS7HSWxlXiGhzE
 U23VZk/dx2H0aghasKVCJW/02vvvrWhRRNdpToj517SwwOlimH1iyleVxpBzWs/Baj7M
 VYAmeIniP0Tm+id2RXv4kQ3t2vSnQbuilNCcASErmZVvZpUP9gcg96w6e796/11Yqc7+
 AfjXGwuD9SD3dHSfdaZ8/+zhxayeBa80RwU05vczo+hZnqSS9dxl6FYW2VKXeP7O+YU+
 HJ1o9URvoDfVL6dS1LN3ao4H6f8YQYgp9MwEJvTntpxuHbuR54yYdlh049fPIK4pJMI5
 QZtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ChCrzOynZvVyjGaYzb3A7RnH3eiPcq2vBZDR+FR9eXyv9iNUzAVfbcHybpWEG9QWy3CWyLZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5j/sAFHQJarPwmivAIS+v0vgYPRaHaqjV+MpaOStmzDLfNfhK
 5bpowgGZDMYTyO2Ld/KqKUq7r8SL8fzyEBVaSCic0epyu5Z2RDIhF3SBHpXPOfAjA/kBmCkijd7
 IIVdUjqVGjy3WshWC2dMyxWiDXp3XRsbgX9SY/dW/cqK/IEnv5xZjawMXM8yeEyPTvhW/qTM=
X-Gm-Gg: AeBDievEqcwdrg6gv4c29fyUobTc00pV5TGH3P2e9/lMa7UkimD/WG2xToGo1FRaGsF
 7uKiqYwGJRtgwfZDhmt70Dl2OT16e7q8+I1vYkdJPXMcS7oaZB9nUCytRcQdeScCCiiYRhy36oj
 PSUJKpNO2REefyLT02jYX0e9N6qVsypG5uzhZC68inXJ4I6GRKV10+AXTXSv8ryz4XdzwS7g+CO
 +9VqephMQd3qS+OSbktnxhDo7FNDLJT+gUTVdQti6JiR/aB0qhIDIw34GPPoGuFaY8KPImY6ht+
 ndwcPMdndP4fa9GEAXBf5hZdEt8yuoc/qyhMG7X8igpVSnGac2MJS055xPs1WfwDHoTAHiUYa5g
 vg2GHGNbG3SOuHMdPfSzBKcwnetz6IiqDppnH45dXMfThGtROhcwAUxZzjydZG1I9cuQ21NnWXT
 /v6QlxZ12L2FbMVbkzXi9iHNQC5tyhABozs4qutjyWIsyaAlL61s4bxpUiUHFf
X-Received: by 2002:a05:6000:2907:b0:446:189c:ac4e with SMTP id
 ffacd0b85a97d-44649ba1992mr8093136f8f.34.1777400088555; 
 Tue, 28 Apr 2026 11:14:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2907:b0:446:189c:ac4e with SMTP id
 ffacd0b85a97d-44649ba1992mr8093087f8f.34.1777400088117; 
 Tue, 28 Apr 2026 11:14:48 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f35csm9551802f8f.11.2026.04.28.11.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:14:47 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] net: lwip/wget: missing linefeed in diagnostic output
Date: Tue, 28 Apr 2026 20:14:32 +0200
Message-ID: <20260428181434.179888-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
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

With NET_LWIP wget produces this output with an overlong line
and missing white space:

    => wget $kernel_addr_r http://example.com/
    #################################################  4 GiB540 bytes transferred in 2 ms (263.7 KiB/s)
    Bytes transferred = 540 (21c hex)

Removing the condition on inserting a line feed yields:

    => wget $kernel_addr_r http://example.com/
    #################################################  4 GiB
    540 bytes transferred in 2 ms (263.7 KiB/s)
    Bytes transferred = 540 (21c hex)

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/wget.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 008f3b395e7..b6c25be6115 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -20,7 +20,6 @@
 #define SERVER_NAME_SIZE 254
 #define HTTP_PORT_DEFAULT 80
 #define HTTPS_PORT_DEFAULT 443
-#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
 
 enum done_state {
 	NOT_DONE = 0,
@@ -251,9 +250,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	if (!elapsed)
 		elapsed = 1;
 	if (!wget_info->silent) {
-		if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
-			printf("\n");
-		printf("%u bytes transferred in %lu ms (", rx_content_len,
+		printf("\n%u bytes transferred in %lu ms (", rx_content_len,
 		       elapsed);
 		print_size(rx_content_len / elapsed * 1000, "/s)\n");
 		printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,
-- 
2.53.0

