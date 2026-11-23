Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBA606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SLGdwlgn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwxcIfLz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0952C40654;
	Mon, 23 Nov 2026 23:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQQOfBtxELtx; Mon, 23 Nov 2026 23:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A8A84065C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795474988;
	b=KnwBsYDagduQQTMsC5AzxWE0YDetywbW/uzxusx8boDLomfkN3yE0yidtrvX3PIdhIWt
	 K713XulwaDTb4EQHNZiU9VHBFSNI5y8kXZ2Gcn16u+V9TnY2137H8m9OTUW2j40mJvpfw
	 orEMHQm922wOpPPlIS2Qc/GBoxapOLC3BU+qQw1oIdz517o3+lcD5tSBR4xBcXuDik7p2
	 2x0gcRQ+KsYvxDrJ5P0Ol0WOLYx3dyFNrrFQ9prRRFwkOTCZ5KgdpdSCjBWe85SMMlKXL
	 zdUvjN5Jlbvwpg4Zf1T3YdqbMIM3klC66dl1fQQ8j9xx8ANYWipMwZPqmTQdOgxu2/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8N64qtQ/Hhoj+ajlLXjrC/uuVoDF45VYInDjUkveMVw=;
	b=LBnUyu6WCdYiDsJtxJTjzXjvawj470gHII1cDkiG4/nOGEjsZGuNb0jbK9bI+JHBpK3n
	 cZ14fGtxKx4QSuB0P3PQ67p2B4xbMsJ7IQd84hp4ZO9vIqJdtk/cLbiYep80FZZBDjAsa
	 q+5DjWCe9yQwfwMdCUJOMZnAdDNv6JPH3AOUHoCDB9OMLYEXb7yPw1MoGIqXiENrJAvjP
	 SLPijTjNjGzmp6Hcq1xH6QjaukaRU0WtbcJFTX5dlyV/aBbzhkUi4g1ftD8qisrV6mcWo
	 /UPJmmeLs+qAVGVblU6PP0Tiqi5BUf/Mj5j21BojoMD3pTyyR67AQlti7gAo4g/9SvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795474988;
	bh=8N64qtQ/Hhoj+ajlLXjrC/uuVoDF45VYInDjUkveMVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLGdwlgn9LFmLihZK3VbUnmkLeWQRS5LGRGw6xtvX13Nr/OzzTy5QO7Q8RLUZJdT8
	 mI0ANdqlCkBI7bkRxu15LMh3aGt/xHhR2tApBy6nDCxDvWqrR0QWaOp2z2KYB4+M3C
	 Sr5U84dbFFlwxAmJqYpzTXGYMcx2YexyiFzlt/7gngq1f2uAxCiyZqzJ2cJIzvmheX
	 NEKhEQ20HgI8jkrTxPBe87tnbjXeU9su/D57FjR5oYW2gOLur0CRLdKg4PuTDQuXnj
	 UO/qx8KliHBLCWTFrQQu0mljWUDJ6ah0dl+vcoPtTB8UA8pNOaBp9KIPm80RSOST+0
	 3jKPvOn441wXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A8A84065C;
	Mon, 23 Nov 2026 23:03:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B7483A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7221680D47
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNak_fMm63Bs for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C6C280D1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=FwxcIfLz
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C6C280D1C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:03 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6df5e315bd1so3335646eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795474983; x=1796079783;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8N64qtQ/Hhoj+ajlLXjrC/uuVoDF45VYInDjUkveMVw=;
 b=FwxcIfLzTdoxIseCaGP8e5yJMnpoZMUp1H1Y4L4IG01unbdegxmKYAVTao7MtYX98E
 e5/OX8pGV5wCzWpY2ycqa1OIomwfQYNGXZlOKYPbdJPY0x7qjMve/2XJcZ+IHHUIekKz
 gks2CKEPq7yDqb5RpSLcQBt4hs/babcKuTszIa3vD7uvn0KSFha5QpGhxzydHA+B7VzU
 jZ1hmNyTV1up46r6afttV/x9H0oQJWW7tOc5rKUa/GG3A6Y7sqNlTwgwaxr57c1ZwEW9
 Z6pI04hEBbk6eQeH5z3fN4mXmzLWSPFGeRvVwGIMljtVThHlHpGV4ztyfS5useWkSc7G
 KZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474983; x=1796079783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8N64qtQ/Hhoj+ajlLXjrC/uuVoDF45VYInDjUkveMVw=;
 b=BWfVaCv6xMzybZcaw/XZSw0t2jCrpePJmnyd4mzEywOsmGKXKpJyrHkj6HIWd2z2xt
 5U2CNtFeWzstqo+7UMQ8v2Q8WKvfAFC6FVVPSXGslWc9hUnEOyrBtF2CTsQ0A4t93pGZ
 eg38oLkB4yh1CAQPX9Ch54lP7gBOw2lc/jSTmUYQv3DKif5Of1VsWgAKf4mN6G0BB9jw
 TooLdoX4RfKRJyMdlr5vPNkA6+it1B5s7PdHivzyrbyycNg8/C8nnUzs80UqU5xKqFsa
 0sciE/XTe+YFZoXeihAT21bG7aka8DKkoOJnpirk0QlSixM+YmLCSxnDfHaIPMcZVLuv
 aLtg==
X-Gm-Message-State: APuU4Z9flPbOEWZcJIlzwPqWrbODgqe8OlBqR0yGy4GMYpAzmDjg5nZY
 fnlyMlC6dOqwLeXOE2ips66FOXIhRpiFyk8b1FaV6FVZs9heR1y4e1JG
X-Gm-Gg: AZFdTZeG/6tISADir35CdX/ciZ7iidSgJLGFdFbgQvr1HBRrXEUSrRuVBQrbMU3p03s
 o1V6eJZrg4vT5tXc7A4heYxW+p7iv5poNn0JWw+IVxZS/TNBa1Pg//JfazDLR+oyti+W09breML
 a6Nju/D3O8JelDA2E2bB8xVD21nfmbKijtaUuAszR0/Qjiw52dXXguF18cGmF5ns+7ameCSt056
 9vvJMjVy5bmhwS1n0B4W2ENw0Dub4DPc6dneKam6yzdtOM/MSFpBMeFfPbyu+YBtT86YEbMfJGZ
 FlbsIvQaU007DjTNtf8h5Hz2juOyT8we2OhkY4nfKwXmSa8dRrfkBw+X1No/Q1J8P75C5a4ZyW3
 s8G2r8ccjzKGecM9aRhWbjaCBf0ZaKuRXr0cljmhpzbZMa0/RnKOj3CNHJ/LFtZZLEaD2X9Fxkz
 ErmGtCvnUARH4Q9qqf0PluTco0mEzMeSi9qSRdURH/N93Wbv8ZKIsUG0HHFMIJBD8csSWcAuiGL
 PNLXl1nnPeK9JUvicDabZMsuaCjz30fQzXvLov7UUscaBJ1lrG1OOCwufBRHeEPY5k4Qxbsd4TF
 VZR6r3sVoA/BowbzWrj/IszCZ4UzDg6KSP0EN2YMCbSs4ZkYVy9YQnXgr++jrjGd/4yMg/bc4pY
 vM9Q1PZwRwhoK0/1e/EiCKAkTrp6NFxLuP06y99LcOK8AcCk2OqF6dJH4oWV3As9e5/nXbd60v/
 kbrsU848i3YpUq/jeVz+apiuAplF+yHiYpxWtks/keV7SobqgOxdo=
X-Received: by 2002:a05:6820:83da:10b0:71a:f082:3c88 with SMTP id
 006d021491bc7-71b394d600amr7667834eaf.15.1795474982609; 
 Mon, 23 Nov 2026 15:03:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b6b680b66sm701616eaf.9.2026.11.23.15.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 15:03:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 16:02:57 -0700
Subject: [PATCH 2/2] net: lwip: serve Fastboot over TCP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-fastboot-v1-v1-2-34c1eff8b1f0@gmail.com>
References: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
In-Reply-To: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sam Day <me@samcday.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
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

Implement the Fastboot version handshake and length-prefixed command
and data stream using the existing Fastboot handlers. Parse the stream
incrementally: a segment may contain part of a header or data frame,
or more than one frame. Copy download data to the Fastboot buffer as
it arrives rather than allocating the advertised frame size.

Bind the listener to the selected interface. Wait for acknowledgment
of the final response and release the listener before continuing boot
or resetting the board. Document how to select TCP on the host and
target, and select the TCP implementation required by each stack.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS                |   1 +
 cmd/fastboot.c             |  31 ++---
 doc/android/fastboot.rst   |   4 +
 drivers/fastboot/Kconfig   |   4 +-
 include/net/fastboot_tcp.h |   1 +
 net/lwip/Makefile          |   1 +
 net/lwip/fastboot_tcp.c    | 302 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 322 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2400daab7bc..d878749efd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1051,6 +1051,7 @@ F:	drivers/usb/gadget/f_fastboot.c
 F:	net/fastboot-udp-common.c
 F:	net/fastboot_tcp.c
 F:	net/fastboot_udp.c
+F:	net/lwip/fastboot_tcp.c
 F:	net/lwip/fastboot_udp.c
 F:	test/dm/fastboot.c
 
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f8ec1374dcc..e6e05111ddf 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -8,15 +8,14 @@
  */
 #include <command.h>
 #include <fastboot.h>
-#include <net/fastboot_udp.h>
 #include <net.h>
+#include <net/fastboot_tcp.h>
+#include <net/fastboot_udp.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
-#if CONFIG_IS_ENABLED(NET_LEGACY)
-static int do_fastboot_udp(int argc, char *const argv[],
-			   uintptr_t buf_addr, size_t buf_size)
+static int do_fastboot_udp(uintptr_t buf_addr, size_t buf_size)
 {
 	int err;
 
@@ -26,7 +25,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
 	}
 
 	fastboot_init((void *)buf_addr, buf_size);
-	err = net_loop(FASTBOOT_UDP);
+	err = CONFIG_IS_ENABLED(NET_LEGACY, (net_loop(FASTBOOT_UDP)), (fastboot_udp_run()));
 
 	if (err < 0) {
 		printf("fastboot udp error: %d\n", err);
@@ -36,8 +35,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
 	return CMD_RET_SUCCESS;
 }
 
-static int do_fastboot_tcp(int argc, char *const argv[],
-			   uintptr_t buf_addr, size_t buf_size)
+static int do_fastboot_tcp(uintptr_t buf_addr, size_t buf_size)
 {
 	int err;
 
@@ -47,7 +45,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 	}
 
 	fastboot_init((void *)buf_addr, buf_size);
-	err = net_loop(FASTBOOT_TCP);
+	err = CONFIG_IS_ENABLED(NET_LEGACY, (net_loop(FASTBOOT_TCP)), (fastboot_tcp_run()));
 
 	if (err < 0) {
 		printf("fastboot tcp error: %d\n", err);
@@ -56,7 +54,6 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 
 	return CMD_RET_SUCCESS;
 }
-#endif
 
 static int do_fastboot_usb(int argc, char *const argv[],
 			   uintptr_t buf_addr, size_t buf_size)
@@ -127,18 +124,10 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_UDP_FUNCTION_FASTBOOT) &&
-	    !strcmp(argv[1], "udp")) {
-		fastboot_init((void *)buf_addr, buf_size);
-		return fastboot_udp_run() ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
-	}
-
-#if CONFIG_IS_ENABLED(NET_LEGACY)
 	if (!strcmp(argv[1], "udp"))
-		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
+		return do_fastboot_udp(buf_addr, buf_size);
 	if (!strcmp(argv[1], "tcp"))
-		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
-#endif
+		return do_fastboot_tcp(buf_addr, buf_size);
 	if (!strcmp(argv[1], "usb")) {
 		argv++;
 		argc--;
@@ -149,8 +138,8 @@ NXTARG:
 
 U_BOOT_CMD(
 	fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
-	"run as a fastboot usb or udp device",
-	"[-l addr] [-s size] usb <controller> | udp\n"
+	"run as a fastboot USB, UDP or TCP device",
+	"[-l addr] [-s size] usb <controller> | udp | tcp\n"
 	"\taddr - address of buffer used during data transfers ("
 	__stringify(CONFIG_FASTBOOT_BUF_ADDR) ")\n"
 	"\tsize - size of buffer used during data transfers ("
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..5c8d5e3f473 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -248,6 +248,10 @@ or UDP::
    Using ethernet@4a100000 device
    Listening for fastboot command on 192.168.0.102
 
+For TCP, use ``fastboot tcp``. On the host, select the device with
+``fastboot -s udp:192.168.0.102`` or ``fastboot -s tcp:192.168.0.102``
+before the desired command.
+
 On the client side you can fetch the bootloader version for instance::
 
    $ fastboot getvar version-bootloader
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 07973ba0e53..ecb2774f628 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -43,7 +43,9 @@ config UDP_FUNCTION_FASTBOOT_PORT
 	  The fastboot protocol requires a UDP port number.
 
 config TCP_FUNCTION_FASTBOOT
-	depends on NET_LEGACY
+	depends on NET
+	select PROT_TCP if NET_LEGACY
+	select PROT_TCP_LWIP if NET_LWIP
 	select FASTBOOT
 	bool "Enable fastboot protocol over TCP"
 	help
diff --git a/include/net/fastboot_tcp.h b/include/net/fastboot_tcp.h
index 6cf29d52e93..b070f2f8dc7 100644
--- a/include/net/fastboot_tcp.h
+++ b/include/net/fastboot_tcp.h
@@ -10,5 +10,6 @@
  * Wait for incoming tcp fastboot comands.
  */
 void fastboot_tcp_start_server(void);
+int fastboot_tcp_run(void);
 
 #endif /* __NET_FASTBOOT_TCP_H__ */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 8d4074b8b23..bfafcc7cc04 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 obj-$(CONFIG_CMD_WOL) += wol.o
 obj-$(CONFIG_UDP_FUNCTION_FASTBOOT) += fastboot_udp.o
+obj-$(CONFIG_TCP_FUNCTION_FASTBOOT) += fastboot_tcp.o
 
 ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
 $(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
diff --git a/net/lwip/fastboot_tcp.c b/net/lwip/fastboot_tcp.c
new file mode 100644
index 00000000000..fff996eb0bc
--- /dev/null
+++ b/net/lwip/fastboot_tcp.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+#include <console.h>
+#include <fastboot.h>
+#include <net.h>
+#include <asm/unaligned.h>
+#include <net/fastboot_tcp.h>
+#include <linux/ctype.h>
+#include <lwip/tcp.h>
+
+#define FASTBOOT_TCP_PORT	5554
+
+enum input_phase {
+	HANDSHAKE,
+	LENGTH,
+	COMMAND,
+	DOWNLOAD,
+};
+
+struct fastboot_conn {
+	struct tcp_pcb *pcb;
+	struct pbuf *rx;
+	enum input_phase phase;
+	u64 remaining;
+	unsigned int used;
+	u8 header[sizeof(u64)];
+	char command[FASTBOOT_COMMAND_LEN];
+	char response[FASTBOOT_RESPONSE_LEN];
+	unsigned int outstanding;
+	int action;
+	int multi;
+	bool downloading;
+	bool handshake_reply;
+	bool peer_closed;
+};
+
+static void reset_connection(struct fastboot_conn *conn)
+{
+	if (conn->rx)
+		pbuf_free(conn->rx);
+	memset(conn, 0, sizeof(*conn));
+}
+
+static void connection_lost(void *arg, err_t err)
+{
+	struct fastboot_conn *conn = arg;
+
+	/* A command may poll the network while consuming the current pbuf. */
+	conn->pcb = NULL;
+	conn->peer_closed = true;
+}
+
+static void disconnect(struct fastboot_conn *conn, bool graceful)
+{
+	struct tcp_pcb *pcb = conn->pcb;
+
+	tcp_arg(pcb, NULL);
+	tcp_sent(pcb, NULL);
+	tcp_err(pcb, NULL);
+	tcp_recv(pcb, NULL);
+	if (!graceful || tcp_close(pcb) != ERR_OK)
+		tcp_abort(pcb);
+	reset_connection(conn);
+}
+
+static err_t received(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t err)
+{
+	struct fastboot_conn *conn = arg;
+
+	if (!p) {
+		conn->peer_closed = true;
+	} else if (conn->rx) {
+		/* pbuf chains have a 16-bit total length. */
+		if (p->tot_len > 0xffff - conn->rx->tot_len)
+			return ERR_MEM;
+		pbuf_cat(conn->rx, p);
+	} else {
+		conn->rx = p;
+	}
+
+	return ERR_OK;
+}
+
+static err_t sent(void *arg, struct tcp_pcb *pcb, u16_t len)
+{
+	struct fastboot_conn *conn = arg;
+
+	conn->outstanding -= len;
+	return ERR_OK;
+}
+
+static err_t accept_client(void *arg, struct tcp_pcb *pcb, err_t err)
+{
+	struct fastboot_conn *conn = arg;
+
+	if (!pcb)
+		return ERR_VAL;
+	if (conn->pcb || conn->peer_closed) {
+		tcp_abort(pcb);
+		return ERR_ABRT;
+	}
+	conn->pcb = pcb;
+	conn->action = -1;
+	conn->multi = -1;
+	conn->handshake_reply = true;
+	tcp_arg(pcb, conn);
+	tcp_recv(pcb, received);
+	tcp_sent(pcb, sent);
+	tcp_err(pcb, connection_lost);
+	return ERR_OK;
+}
+
+static int send_reply(struct fastboot_conn *conn)
+{
+	u8 packet[sizeof(u64) + FASTBOOT_RESPONSE_LEN];
+	unsigned int len;
+	err_t err;
+
+	if (conn->handshake_reply) {
+		memcpy(packet, "FB01", 4);
+		len = 4;
+	} else {
+		len = strlen(conn->response);
+		put_unaligned_be64(len, packet);
+		memcpy(packet + sizeof(u64), conn->response, len);
+		len += sizeof(u64);
+	}
+	err = tcp_write(conn->pcb, packet, len, TCP_WRITE_FLAG_COPY);
+	if (err == ERR_MEM)
+		return 0;	/* Retry after polling for acknowledgements. */
+	if (err != ERR_OK)
+		return -EIO;
+	conn->outstanding += len;
+	conn->handshake_reply = false;
+	conn->response[0] = '\0';
+	tcp_output(conn->pcb);
+	return 0;
+}
+
+static void run_command_frame(struct fastboot_conn *conn)
+{
+	int cmd;
+
+	conn->command[conn->used] = '\0';
+	cmd = fastboot_handle_command(conn->command, conn->response);
+	if (!strncmp(conn->response, FASTBOOT_MULTIRESPONSE_START, 4)) {
+		conn->multi = cmd;
+		conn->response[0] = '\0';
+	} else if (cmd == FASTBOOT_COMMAND_DOWNLOAD && !strncmp(conn->response, "DATA", 4)) {
+		conn->downloading = true;
+	} else if (fastboot_is_boot_command(cmd) && !strncmp(conn->response, "OKAY", 4)) {
+		conn->action = cmd;
+	}
+}
+
+static int process_input(struct fastboot_conn *conn)
+{
+	struct pbuf *p = conn->rx;
+	unsigned int len = p->len;
+	unsigned int need;
+
+	if (!len) {
+		conn->rx = p->next;
+		p->next = NULL;
+		pbuf_free(p);
+		return 0;
+	}
+
+	switch (conn->phase) {
+	case HANDSHAKE:
+	case LENGTH:
+		need = conn->phase == HANDSHAKE ? 4 : sizeof(u64);
+		len = min(len, need - conn->used);
+		memcpy(conn->header + conn->used, p->payload, len);
+		conn->used += len;
+		if (conn->used != need)
+			break;
+		if (conn->phase == HANDSHAKE) {
+			if (memcmp(conn->header, "FB", 2) || !isdigit(conn->header[2]) ||
+			    !isdigit(conn->header[3]) || !memcmp(conn->header + 2, "00", 2))
+				return -EPROTO;
+			conn->phase = LENGTH;
+		} else {
+			conn->remaining = get_unaligned_be64(conn->header);
+			if (!conn->remaining)
+				return -EPROTO;
+			if (conn->downloading) {
+				if (conn->remaining > fastboot_data_remaining())
+					return -EMSGSIZE;
+				conn->phase = DOWNLOAD;
+			} else {
+				if (conn->remaining >= sizeof(conn->command))
+					return -EMSGSIZE;
+				conn->phase = COMMAND;
+			}
+		}
+		conn->used = 0;
+		break;
+	case COMMAND:
+	case DOWNLOAD:
+		len = min_t(u64, len, conn->remaining);
+		conn->remaining -= len;
+		if (conn->phase == COMMAND) {
+			memcpy(conn->command + conn->used, p->payload, len);
+			conn->used += len;
+			if (!conn->remaining)
+				run_command_frame(conn);
+		} else {
+			fastboot_data_download(p->payload, len, conn->response);
+			if (!fastboot_data_remaining()) {
+				fastboot_data_complete(conn->response);
+				conn->downloading = false;
+			}
+		}
+		if (!conn->remaining) {
+			conn->phase = LENGTH;
+			conn->used = 0;
+		}
+		break;
+	}
+	conn->rx = pbuf_free_header(p, len);
+	if (conn->pcb)
+		tcp_recved(conn->pcb, len);
+	return 0;
+}
+
+int fastboot_tcp_run(void)
+{
+	struct fastboot_conn conn = {};
+	struct net_lwip_ctx net = {};
+	struct tcp_pcb *pcb, *listener;
+	int action = -1;
+	int ret;
+
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+	if (ret)
+		return ret;
+	pcb = tcp_new_ip_type(IPADDR_TYPE_ANY);
+	if (!pcb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	tcp_bind_netif(pcb, net.netif);
+	if (tcp_bind(pcb, IP_ANY_TYPE, FASTBOOT_TCP_PORT) != ERR_OK) {
+		ret = -EADDRINUSE;
+		goto close;
+	}
+	listener = tcp_listen(pcb);
+	if (!listener) {
+		ret = -ENOMEM;
+		goto close;
+	}
+	pcb = listener;
+	tcp_arg(listener, &conn);
+	tcp_accept(listener, accept_client);
+	printf("Listening for fastboot on TCP port %u\n", FASTBOOT_TCP_PORT);
+	for (;;) {
+		if (ctrlc()) {
+			ret = -EINTR;
+			break;
+		}
+		ret = net_lwip_poll();
+		if (ret < 0)
+			break;
+		if (!conn.pcb) {
+			if (conn.peer_closed)
+				reset_connection(&conn);
+			continue;
+		}
+		if (conn.handshake_reply || conn.response[0]) {
+			if (send_reply(&conn))
+				disconnect(&conn, false);
+		} else if (conn.multi >= 0) {
+			fastboot_multiresponse(conn.multi, conn.response);
+			if (strncmp(conn.response, "INFO", 4))
+				conn.multi = -1;
+		} else if (conn.action >= 0) {
+			if (!conn.outstanding) {
+				action = conn.action;
+				disconnect(&conn, true);
+				ret = 0;
+				break;
+			}
+		} else if (conn.rx) {
+			if (process_input(&conn) && conn.pcb)
+				disconnect(&conn, false);
+		} else if (conn.peer_closed) {
+			disconnect(&conn, true);
+		}
+	}
+	if (conn.pcb)
+		disconnect(&conn, false);
+	else
+		reset_connection(&conn);
+close:
+	tcp_close(pcb);
+out:
+	net_lwip_stop(&net);
+	if (action >= 0)
+		fastboot_handle_boot(action, true);
+	return ret;
+}

-- 
2.53.0

