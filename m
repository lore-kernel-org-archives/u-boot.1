Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8888C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4DC82C2B;
	Tue, 15 Apr 2025 23:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wmk1ht+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5528782BC8; Tue, 15 Apr 2025 23:18:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECA0808AF
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso69789405e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751914; x=1745356714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPapFxm3yxjBtHQRWGN3QR2UhbaPTtk+IO2db1XR8X0=;
 b=Wmk1ht+NtAhSaa/uZWwgBfSphaaWFNTyBGseebIy8Q5u09IUd0GaTU4CVswMrrOZbO
 kcFeoF3JiNi5ywhAPuBCeybcNlwNflu3fCAiSa7eaWoFeKzQdmbq/xk1fgYBjurtQ+SF
 8ysIa5bmeKJ5t5+xBbZNBzYMkybpQeOETx5hO5Pk3Ed4B2/3OqqdqwkQv7THmj411dYY
 gnae70L/dA8peiTM1aJbJSNpi6A6qJDnY0TkbgWprh5qzRCUisFg4y0n3tZzys4IrbgZ
 xAkUeC3+oc0RBDeYtEQ/aNRnBJsK9BvacsL9Rpgk2S4DK+DdEUGINe0h7I5scLu7j66L
 tthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751914; x=1745356714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPapFxm3yxjBtHQRWGN3QR2UhbaPTtk+IO2db1XR8X0=;
 b=Dwz/id1dZ6R41UAk1Yg4SQSDIIWAkav5NXfvPEha/w/mdM6g5VzRLZPUVw5g5wwjbe
 SDIE7R4NWDa0gkic58uws/UH2RB8+aSG7uyYei+ttq05Ne4tToy1tPySpkqk0ZRyBDhl
 fuN5zTBoiICQDxqDDWKyH4WUB0P+mVhkUDmTsarDLDpGvUHyaPHQAnMZL98b7lymTlTa
 dzvAtV2ulMz1VFWD1AkV2XgTM0gsC1MRtLaXZaAz/UrsryTX5x1CSFkGnNyTb8htbcBh
 LjcvdvR2JOq4wgOS/pSnundT+aGk9sfepcolsbkdAf/46Q4OItIvSpqoMHpqPoG6SHSS
 sKIg==
X-Gm-Message-State: AOJu0Yzrv2iUZFHjSekr5HuPcHxkqZ+KRh56XLhf4W0r7aBEHgaejTY0
 /0D75Zm3bXdP39b5H/Nut2xisN1ebOS1zy3tTaFd9ntYaJXYM2fZCiHxAjj5dI8dmSVZrq+jCI0
 oQNw=
X-Gm-Gg: ASbGncupDFD+UyHgunB+g08SOuaqidUGwE7Y5Kv8JbQr2vWOvXUyPn4wTw1ylNHHAax
 qDWl1IdPFUPp+0vyFDJ1r5g4fW6XBXCfg3AR4+OTUXvy4ARILVllxPVSa87vOrYWRCqNlpUIpPI
 2oIyQeq/eJiIJNbRljUd6Rm/qyoInRyCkyS6ExWDMYqj9Bm4Zu2CzIVbgkUzjTOjlNO/IavBDLF
 r28HCIjMV2H1APyrEMJtLZyLBqlxkjbvm21NxIyPKrjCes3LRtSQLF3ECZZOwSdBJOFrdVul7on
 eTnQUsu44plBAPTBVwSOcdtLriv3hhk7fiYhDLKU2NkdXqkz
X-Google-Smtp-Source: AGHT+IFAJbmh5Q7UmIXvOV5s0EhWJ/9Lz7yGVgAWDZJousRd7NpyS6G8lcCxv5qmB6bf6KwWYh1YzQ==
X-Received: by 2002:a05:600c:4e47:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-4405a0313cfmr5825295e9.17.1744751914622; 
 Tue, 15 Apr 2025 14:18:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] net: ping: make do_ping() available via <net.h>
Date: Tue, 15 Apr 2025 23:17:42 +0200
Message-ID: <20250415211819.1254435-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

Make the do_ping() function in cmd/net.c a global one by getting rid of
the static qualifier, and move the prototype declaration from net-lwip.h
to net-common.h. This makes the function available to other parts of
U-Boot when CONFIG_NET=y, as was already the case when
CONFIG_NET_LWIP=y.

This is a peparation step to make the sandbox tests use a common API
between NET and NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c            |  3 +--
 include/net-common.h | 12 ++++++++++++
 include/net-lwip.h   |  1 -
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..eaa1de5295f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -456,8 +456,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 }
 
 #if defined(CONFIG_CMD_PING)
-static int do_ping(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	if (argc < 2)
 		return CMD_RET_USAGE;
diff --git a/include/net-common.h b/include/net-common.h
index 0b7edd7d76b..e536968a92b 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -493,6 +493,18 @@ int net_loop(enum proto_t protocol);
  */
 int dhcp_run(ulong addr, const char *fname, bool autoload);
 
+
+/**
+ * do_ping - Run the ping command
+ *
+ * @cmdtp: Unused
+ * @flag: Command flags (CMD_FLAG_...)
+ * @argc: Number of arguments
+ * @argv: List of arguments
+ * Return: result (see enum command_ret_t)
+ */
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 /**
  * do_tftpb - Run the tftpboot command
  *
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 0d3bb8a8bd8..b762956e8fd 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -34,7 +34,6 @@ bool wget_validate_uri(char *uri);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
-- 
2.43.0

