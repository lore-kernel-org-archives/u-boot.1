Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4698606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KMI92RsS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/VlF7o3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B465B81365;
	Tue, 10 Nov 2026 13:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id deXZnt5GJAJL; Tue, 10 Nov 2026 13:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4936812E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315957;
	b=XqQGxx211ikaeFNcy9Yq7xc15xWFYa5jlhjPxAX/LJrDkPZXYSy5RtceENkHHitt0ez6
	 qBMPNghtSgsxnhOAKOVi8lKcpQQZvwFjdWBDlyM7Jss3eNXK85i1Kpt2NA1xbQenofXuL
	 yTfWUvYggS0IngcjsWGBgHK58WeVequjWPfAgy6F2MeyXAklfab9jGpJwesrFvZ8y1AfU
	 rjaHaYbDEsttYdYX4cZI+NVciVcQzRg7OYfzVha1qUJ5NnhLv8+A4X4m1XgCFNI4LpHjz
	 5PE0YIxjxOvZ/OA7RZLimxa7OFTQLLiA9UDMm1tOzIwhx6+GoLue3ObgXeN35P7iQaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=RzmextgAilkMrlUdSJnF5z9JVRwAxsk8TAyLMixOc34=;
	b=fKtV8crrOjFM906gfoSlezGSv1XVYLnEC+g/2YIMB3cyrGTbq1KTMN1kYchxYG50Z1Xo
	 mtt+S/bpUwnFYdvBfEmfa77c1sLWg34TU0WSpCCUB0J0vMSManQKAkBRyTGBRVKXRRhDd
	 TN8U2+Vmk/SRPmh6Uw6/SGVWvVpaBaWhiZioddZzPHtMuCfKDkuC20VvbnNQutad9ewS5
	 mqTolbcMDVh4V4F9c0XOnVd0cG2jcEt0wrpHumcDfN79hKmjcaJL4roaT2FIVxCcE1KBo
	 uzQL6xkp34eYCjBnQv8mw01xSIFoa4Qus97X6QojMJo6+xXWve1HGEhbSDuZjWID2Sg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315956;
	bh=RzmextgAilkMrlUdSJnF5z9JVRwAxsk8TAyLMixOc34=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=KMI92RsSX1RAwKPHe/Hpif9dMVeQHT2RQEkied18rycMIxPTcf9EA46GL5RZl6zWy
	 UeLFE2YIEo5Bpthu6VGuS9kXRlsuZmhXLjpTl71UyAazt4/Gf5N976Kp/tFDkJoXWk
	 r7JYz1oaskCvq5bkQKfORQxKbo1RDXU75hmhbrSnJgHQrH0YZ+yRuCrAxkyjAgfRKS
	 5trqUuqPJI1MPOttpsppXCmMxO9FL1mrOknWL4Yle9KWX/GTiZPTfVSRe8eMsnP/Nv
	 3Js9k8EhNytxW24VkWyiTzdzMiz0vl14HxdDz44M755Xs9mxkiDNTXFoRX0AWcJI/R
	 CN45EHkdmMQMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4936812E8;
	Tue, 10 Nov 2026 13:05:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69B1F335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F74640585
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EY4ySEDcQI-d for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:20:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7341240575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S/VlF7o3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7341240575
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 140B76375C;
 Tue, 10 Nov 2026 06:20:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 49F291F008A1;
 Tue, 10 Nov 2026 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291628;
 bh=RzmextgAilkMrlUdSJnF5z9JVRwAxsk8TAyLMixOc34=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=S/VlF7o3AyvP9v/EamTeAzCsyFFxbUa8is5lqJII+cq34FMWTH8UQc27iwUnZnJqt
 vUf0MP7KKdiJuV9c3rEqSvhUZXWP2b4O9HrUehdJBCpOPZqvSsKtN4ZOiqf3fyh9LD
 lY3pRphUnUgUBiA77nQtOFiMrskenykHt8vZYsJqHbvaFDMZhG6XCUXyDmqx5AfhEp
 N8VCzFH6RJadKECb5Qgc6lyF+eD64+r5T+xkvTf5d9qWP+0H1El3VH5cTRoMKTa8vn
 eCTZC8OoQur01bO82sBPncU42GEE0e1LYTzScSJ6RezC/HsIKB5AY6hmC/ku6LFW/o
 OL41yosqoXZcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D03A7488EB;
 Tue, 10 Nov 2026 06:20:27 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:20:27 +0000
Subject: [PATCH] usb: hub: yield while waiting for the port connect
 debounce
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-usb-hub-yield-v1-1-b9a88ff102d1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IQpHSqxQXJjPWKUUlY8Qiu
 btRl2/x/w7KUVjhVe0QeRWVaSywdQVh6MYPo1AxOOMaa63BpB6H5PEv/CPsn8ExETUmPKA0c+R
 etuv3bm9r8l8OyzmBnA8+FI6VcQAAAA==
X-Change-ID: 20261110-usb-hub-yield-f8c2eddd60c4
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Arun Iyengar <aiyengar1990@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291627; l=3148;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=e+5J4O++x9STxA0gBZBWtuFvWcs5h8+LDLg5VyNifoM=;
 b=b1D3+Yk5EgZwCTvT6CDdP8jq4CndNcqhsBQZDoTup18EUZGFGWVDMGGUiDNsdveY6LH6YPgAm
 HXvE67venmzDEpKyhODvZoFfjG5DJLVlbTrNVQW45bUT93N91aK434p
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

With CONFIG_UTHREAD, usb_init() creates one uthread per USB controller
for the bus scan, but the scans never actually overlap: the port scan
loop in usb_device_list_scan() only waits for time to pass (query_delay,
then CONFIG_USB_HUB_DEBOUNCE_TIMEOUT = 1 s for a port with nothing
connected), and for a root hub every port status request is answered
synchronously by the host controller driver, so the loop spins without
ever reaching udelay() or schedule(). The first controller's thread
therefore holds the CPU for the whole debounce, then the next one does
the same, and "usb start" costs about 1.1 s per controller.

Yield once per pass over usb_scan_list. The other controllers' threads
then configure their root hubs and add their ports to the shared list
while the first one is debouncing, and the running loop scans all of
them, so the debounce periods overlap. Without CONFIG_UTHREAD,
schedule() only runs the cyclic functions, as it already does in the
EHCI transfer wait loop.

Tested on an OrangePi Zero2 (H616) with all three EHCI and three OHCI
controllers enabled (the two extra ones go to the expansion header) and
CONFIG_UTHREAD=y, nothing plugged in: "usb start" took 7.0 s before and
1.5 s with this patch (serial console timestamps), and all six root
hubs are still found. On sandbox64 (CONFIG_UTHREAD=y), the test/py
USB tests give the same result with and without the patch (the
dm_test_usb_* tests pass, except usb_flash and usb_keyb, which fail on
main as well).

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
This came up while trying to scan the six USB controllers of an OrangePi
Zero2 in parallel with CONFIG_UTHREAD: the per-controller threads were
there, but "usb start" took as long as a serial scan.

This patch was developed with Claude (Anthropic) as a coding assistant:
it investigated the problem, wrote the code and the commit message. I
reviewed it, and it was tested on an OrangePi Zero2 (H616) and on
sandbox64 as described in the commit message.
---
 common/usb_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 6a4bcec00bc..31b5aa7ae04 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -41,6 +41,7 @@
 #include <asm/unaligned.h>
 
 #include <usb.h>
+#include <u-boot/schedule.h>
 
 #define USB_BUFSIZ	512
 
@@ -592,6 +593,17 @@ static int usb_device_list_scan(void)
 			if (ret)
 				goto out;
 		}
+
+		/*
+		 * Root hub port status requests complete synchronously, so this
+		 * loop never sleeps while it waits for the connect debounce
+		 * (query_delay + CONFIG_USB_HUB_DEBOUNCE_TIMEOUT) to expire.
+		 * Yield so that the uthreads usb_init() created for the other
+		 * controllers can configure their root hubs and add their ports
+		 * to usb_scan_list meanwhile; the debounce periods then overlap
+		 * instead of adding up per controller.
+		 */
+		schedule();
 	}
 
 out:

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261110-usb-hub-yield-f8c2eddd60c4

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


