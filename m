Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D2606A329
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FI9zkYPa;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKZ7qxhe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E74560A4E;
	Fri, 27 Nov 2026 06:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7Lzyi9KtdwO; Fri, 27 Nov 2026 06:37:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5401160B6E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761422;
	b=O8YflrTw5KIFdAjSVAAcsyA3OoWNNe93kkqHE+oTXRxJe05f1rYF544eobIqFh3nU+qv
	 StGoZ+vR4MfjtTfMQc4uGxLdCD3qwrajoIWSkWXJak3tw25xnqBw8b1zg7+EZfHLuC5sf
	 MgzwVB9zsQO4io3c/n1LtLX4JlWodw8mTcJYT4Z1V/02yoozn8gsmeCL6MpG3gW/SD4IR
	 aOZ1uJC/oRv/br/RJKKrYVyXyIG8g7RcmoDiQUPFCpfNE4xhChS/rh0MSh1jnruYJiz7v
	 YE3BPa/wJZRg8IYSU451um8GGEtpNU4JUDo4yUrFQGeieiYIpKiDqhF3lVTPmBlGaaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+rPwE6w/m0Vao8xcZDU7OfO/XhUL1NrmvDvDFycmAH0=;
	b=goCwj9ABi06AV3+sg9C+j09kF6qDk2jjlWI7/hZCjPLDFmrgiZB5BQm7rqzP08LfOrzG
	 HpEgRRg2Ason2EGGNQwXL1Lt5tUWhX807HvEXgubftuYUsGRFV0TFVmgaOyegsJ8haNGX
	 9IxjMQn+NUVg9joV00jTT+0BGPv6SoOjpOlnMGybCYE94lAoSfVFG/PFLwgE12E8hHjkw
	 yMbYqktIBTIpGlqNre4TYk4v4ud8kKyhym/9Bd3UCltYJWtqA3ENAf6KPG5GhQcjkfW3u
	 agjvZzQFc6oTvkrE7JpNspGQ9uTVqeikWbgElmi6fADycNyE058Ay3OiMB3pzKyi4GA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKZ7qxhe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761422;
	bh=+rPwE6w/m0Vao8xcZDU7OfO/XhUL1NrmvDvDFycmAH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FI9zkYPaWMIdAjFzYAQ5yQlfDxL18u791KpobndmRgbbCXVZjhSJqNKkB7EDIMY5d
	 0+yYwt5e57gkNnK+kYJcnrcF2wCTnVsyOi7FsVRIU3aIGBXNFUdLDKvQ8F8ChsPbh2
	 hfyprWgmouzw7l0RYXZC5LK13AHRvkT980Dj2ILWXe9xyEzM8HDxN4E3jzv/xpyqmd
	 T6iUqQYWUQDgVlTD8lR0TvH7Tbe4V4yw3UCUXvy+iVpsDa2Ap2YCN+vy1vDnl2kItI
	 f/uiM1n7QHNxJp7WWqhpFao8WBpx00LrMdzrc0zrkulTYyiW+PVDsd+6fEiIs5PnXb
	 PpeWVgIIKNeow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5401160B6E;
	Fri, 27 Nov 2026 06:37:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4273E2BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2781460D68
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PhIWU3yRFver for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 200DA60B8C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OKZ7qxhe
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 200DA60B8C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:52 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-33fb4680717so4132858eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761412; x=1796366212;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+rPwE6w/m0Vao8xcZDU7OfO/XhUL1NrmvDvDFycmAH0=;
 b=OKZ7qxheCqPeJz1rjx4aoNHxIbH8Rl2zMj4RtBooohjlz6yh60L+OTIM0bZS1zxygU
 /fXEnFXsnN/dhYVNmsEl9q9p6PKnRkRIz2/5HNhivdE15mTrav/L3ldkuuevdXjKliBa
 89tyD33rytJZHR87rZuxG8PA66t7tUynUGgPcBHM4yZg22+d08TaIcNjW0v8W+IeM6IX
 o94eU4yDf/W9psY2Brcqc4QSBcX8thCLfHG8tGMIb1+KJ0Lrn4Qt0yurXer1qs6QyOc6
 4q6PoRyioUoYW/c1ShPcvINubxiuY+dvTUURF8bBHux7NmRHnHIn7GwLG5tU/k309V7m
 glnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761412; x=1796366212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+rPwE6w/m0Vao8xcZDU7OfO/XhUL1NrmvDvDFycmAH0=;
 b=FS6/aSViR2qsG9Sp09juOAWimKq0LaoluUOJ+HlQyUuHOlnJr4TNGeRXg0hjAZzPCJ
 UbXNVYuAQUZzrcbDteZW6C4YKpekU3y/DluGIMvvzqhngUpE/r19q+CNEf32FsPAC62U
 qMzn3z6JuppCB/JLGRcbkci6V7lq5DrCarhRn8slw4wYvDqSEalNlLk/K+aqUzlXLNMl
 2TgjfepgcCCCYOztxhEdmZgJ3c3wT88ABfP9DuP3kA4hlLkpiX5KdMFr62WdBMI6/tY7
 ffMcDFRl7tGtLDfaVpQJRqMXtda9D6n6VI4oLrCD8cgK1vXuD7knakzGypziePvLQHle
 d2qg==
X-Gm-Message-State: APuU4Z/055WvZBqBR3yl8h5ycmh1tJkvEevwrvIL+vsEwsyV1U1bFK4S
 VCNLyB1EJrcD50IXQWBc76mPC2IjhQu7N7jEzRIuA0XGD43N707yloPB
X-Gm-Gg: AZFdTZfMkv5sMe8gs8VE5ybKqzVkGRJJcVAzWa3nm9HJumvAvKqMHsEnCuXw9inR6yh
 eSW1KfYuv6K3II3kT1Ka96LYt5wNFmo8hu4kPgDyePpPU8Nbg0FJiYna0QanWFpHEj0SxJRf5fa
 vkjFuJpQSk5iE+3pD/ZDIqMMqqhROC7LseJdg1uOmy7oDGZaZD6CevyD1FHmehAmEQQuF3WCDYZ
 e3qQwAuM2b5273xmNiwOhrvD37rpPaTXcb+ZJM290TofWWGNuM1u38LTCIwdfvOOnBLpfXprleE
 o9uVo8DbioViiAgyb2+y4hmtTJzuwwx0EkdP0aZ0SCVQEkzleyPhaOlHgBarGSuvd9G3sRubBJA
 TjmFQSiic0ol1cvNpAGDZhOx7nxUHfA0s/liirp1ivpwV4lGuQV84Q4+SySer0mBL9twuN8uOOr
 iHHNe+BOfPeQz/8w7ONDOXXEhpd3W+wrDzB7rMCAVjsr4cFLDOzuTC0zYIKf+1k/vcFRgur8lJ5
 MNYKdeXfmKIhm5epXZ0eH6Cxn6U/Sx/xN/Jk6hWDbO38nQed0xffDZ78J88ZuzL+3JfgafjENHP
 WopeQvvVLpbT+Z183yLInZBusQkvSKJr+2KWGCVmPWjrtVKPxAZocDEyvrHlP51AcX8t1Zmbc3D
 dCydFrzf/PzKihw1LrjTNGow=
X-Received: by 2002:a05:7300:d10e:b0:36f:a72d:29f with SMTP id
 5a478bee46e88-38570152da4mr25095299eec.34.1795761411657; 
 Thu, 26 Nov 2026 22:36:51 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:51 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 8/8] doc: board: google: Add Google Tensor G5 documentation
Date: Fri, 27 Nov 2026 06:36:20 +0000
Message-ID: <20261127063620.399391-9-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add board documentation for Google Tensor G5 describing the supported
features, BL33 load address, and build instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  1 +
 board/google/lga/MAINTAINERS |  1 +
 doc/board/google/index.rst   |  1 +
 doc/board/google/lga.rst     | 37 ++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 doc/board/google/lga.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 09efaef4066..2f7f3b53640 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -363,6 +363,7 @@ F:	arch/arm/dts/lga-u-boot.dtsi
 F:	arch/arm/mach-google/
 F:	board/google/lga/
 F:	configs/google_lga_defconfig
+F:	doc/board/google/lga.rst
 K:	[gG]oogle.?[tT]ensor
 
 ARM HISILICON
diff --git a/board/google/lga/MAINTAINERS b/board/google/lga/MAINTAINERS
index c5e7a2364d4..0e56f1d4e73 100644
--- a/board/google/lga/MAINTAINERS
+++ b/board/google/lga/MAINTAINERS
@@ -3,3 +3,4 @@ M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 F:	board/google/lga/
 F:	configs/google_lga_defconfig
+F:	doc/board/google/lga.rst
diff --git a/doc/board/google/index.rst b/doc/board/google/index.rst
index 061c7977187..bfc60cbf031 100644
--- a/doc/board/google/index.rst
+++ b/doc/board/google/index.rst
@@ -9,3 +9,4 @@ Google
    chromebook_coral
    chromebook_link
    chromebook_samus
+   lga
diff --git a/doc/board/google/lga.rst b/doc/board/google/lga.rst
new file mode 100644
index 00000000000..3372359130e
--- /dev/null
+++ b/doc/board/google/lga.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Google Tensor G5
+================
+
+Overview
+--------
+
+This document describes how to build and run U-Boot on boards based on the
+Google Tensor G5 SoC, referred to in code as LGA, including Pixel 10
+(Frankel), Pixel 10 Pro (Blazer), and Pixel 10 Pro XL (Mustang).
+
+U-Boot runs as the BL33 payload loaded at ``0xbe000000``. The initial port
+configures the MMU mapping and DRAM bounds, disables the APC watchdog left
+running by earlier boot stages, and enables the serial console.
+
+Supported Features
+------------------
+
+- Serial console via NS16550 UART
+- PSCI system reset
+
+Building
+--------
+
+Set up an AArch64 cross-compiler and build ``google_lga_defconfig``:
+
+.. code-block:: bash
+
+   export CROSS_COMPILE=aarch64-linux-gnu-
+   make google_lga_defconfig
+   make
+
+The resulting ``u-boot.bin`` uses ``google/lga-frankel`` from
+``dts/upstream/src/arm64/google/`` as the default device tree. To build for
+another board, set ``CONFIG_DEFAULT_DEVICE_TREE`` to ``google/lga-blazer`` or
+``google/lga-mustang``.
-- 
2.56.1.839.g22a8290db9-goog

