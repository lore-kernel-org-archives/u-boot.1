Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712D0CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C559060735;
	Tue, 29 Sep 2026 00:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0wna_rEVvLAk; Tue, 29 Sep 2026 00:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DBA5860725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641321;
	b=p5PNhWN7aXVOk0C2OXKjVUtAms8JvFOFKF6zYu8z8jYtuihqgGuduEWTVbKW4w8Uckdn
	 sZKZFl6GSzZ9D8mHCYzX6coiDshYA40f3e4BQVMYVJxYfu4yUgqmed87JJr5aIZ2mQSpS
	 CMsX78nXZFn4D9jDakJPYzvUvk08R9oGp3XUpD3QHdQdhZ/VjdIBUNHRJkIe8ZOtjQT1I
	 ZpxyyupNnRScr+3kKhHV2v9mkL63aEJacYvvYFh2pNGKPzTrH+Wb27RsX+U2JKvoUGpsD
	 UxDa/XTCeXM06/qTE1pxdkrmR8wfzREnhHivD+hVyo26VDhi2/i5wumS21uUgzQtXiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t5DrIqnJX+CiwuR19bc4kTK+A0WTsAz+y8rrGv3VNmA=;
	b=bUY6Lu9MT1bXePQZ3PF/FYa+2+jhS0k+ifh7CPxuwAJcDUD7AueiKNdzUI3zdOlp2tnk
	 0wcGCxzLKnxuQx6iz4JncYqiaxCQzh+EjU/v/ofYu4uuKgepjX1/l+O7m8Pqx0sP7tm4Q
	 q+atBgjBrf03MigY6W4gyRWiohM8F+yI+cLz1tC3JhOGKXh/rQIqvnbnA/by9L8xLCK0V
	 0FijKqJH0yPrbzxxIi8EEp4t86BCjtiTEl5c5VCX0nR4b8p/kJqYp5U8W0ZCW0mm1Jxse
	 tkp42yRr13Z1aGIDoZ4I8h3tufHqoPl6eEI7E1xbRzRCYD1RpOiZi/ZQo9P12zkBr2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641321;
	bh=t5DrIqnJX+CiwuR19bc4kTK+A0WTsAz+y8rrGv3VNmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQ+0VydVunlJbdL3d6tMGaVs2cuzicZs89J6q1r30VI4Nve+7wU7L7VHi51mHIuSK
	 8FkF3rXM0Hom56eb5tp2jjqhy4/CSQeLlEbvqrKhZqb9fJNeeT60iUqBxOUeC1cV24
	 LZuTJ+cHl9SqhTRuU+L6HV6KAYnY8j1WX7MsiG/E70mpS5PpySTvAV5BW6JXjp//uS
	 RTjda8zBvOD4PlHnVx8xtxTy92m7joYwv2JQ9GIuuXcDZ3ZEfwsJKjzsVcGqDUn5kb
	 iUnmtOie4HJi0B9TWEU7s0RVPWz4S0VbxirCUxYBFoYAMmRiqeMOdvXBzB4IDukeQ1
	 Lx+L13JO5ytqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBA5860725;
	Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BB5D4CD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86B3A80C16
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwQndFNMAUKB for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C0F580AF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641316;
 b=SRgGxy5Q0nx+5oz0ExRnuqwwXBlMcOo6OVRCQtIvTq4DiA+9KQXC3MPp835Hd57OK/b/
 06UtD5CA/d0AqWXh0WYsMIx/5IeD3IHa+9BhEdgUbBjeoFxrTMV3PSYFVOzkDXftP3eGw
 FvFefDawq1hOfWAo0nSFBiRyMyfwkjqkkEzJ3aQGqybemcBVLi3LIQYEsJCHrcY04LIYJ
 Y3WbVITrviMzN59nT3CjuPMFckpxmi3xD24+FRigpJT5Naez/EnH/rKZ9Qwi9oZa4WF+B
 5HlwtmO8/r2+7eE2d+keYa6qaNg3MuZvfMWM0of9kSVOjVW6cf5zJ1kEFDXj6gNsu1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641316;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=t5DrIqnJX+CiwuR19bc4kTK+A0WTsAz+y8rrGv3VNmA=;
 b=PuTRoSYoExJNqmz8TtbGBfbAqTr1vd/1+KdIZOk5tdB/m0PCHHXYOAaJPe2PNblcFc/D
 oXquAdvVywvJNY5OlzLOn+cyYd8n+jqjY05snW+S00NkVNme+tF+CyYpz5DwtzglmrkMi
 nzEEiF+6yXyjrZNg9EXcsdn1pJ1ojfMEHE1ZqeMEbq5VSApmlpXBtj9cHacYwLYXn0LPV
 b01ME9e1O6AtrxWWCpPNVXGGcP2C5Fs/P3bZ3+Bq4DxMND38knVYeoatjSBU5RRH/hx7G
 A1xRyHpqkmaPkOGQlZsly0fWXSJsZzAsplyO14LXfxkY9ykjbHUBGlXyYYt56ETUTJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ksm46ZzK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ksm46ZzK
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C0F580AF9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:55 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b15bca7e0so1703873a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641314; x=1791246114;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5DrIqnJX+CiwuR19bc4kTK+A0WTsAz+y8rrGv3VNmA=;
 b=ksm46ZzKsNg/jQqFzJhL2BqZnm693+2/iSaCgcTHWEc/HW2Tjz7QBgbjbTWZ7Sf5L0
 rOS/FZrOMcAEZwwTJl8UGYftBm45NHkwMZv1qaE0dg+BhLEXJDu67o5eQN1MfciwYUqK
 4uxyTBHL+KiXzbcjE1HycAFcWcB2oVZ+5WHpHfglK8NplOFoZdguQm3XKC/ePUv6vlEx
 eDCrz7k99RIoaKjKtAa6Mex3jS8EsTa1IghdsZ5qEHMZwQnQ0TWGujBtjFkh3syfnEdJ
 Wi7tPbUlA9lVp29IfVu19ZJIgn2lEa9xrKAfq3dlvsmDWxg/sbPwS+GH4FQzrMHIyWG1
 tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641314; x=1791246114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t5DrIqnJX+CiwuR19bc4kTK+A0WTsAz+y8rrGv3VNmA=;
 b=HXmlmYt3sP2i2JW0QnK1YVBkXeZQv2vBP3vrniRgRfYNwe/Kl8v1HogtpVog37Y0BE
 B1ovVLP8pC3l7UFzcTh4awCuK4KZgOdZy0h60U+qBnS0pcw2lnf6RqdUqx+/muI7LMGm
 xeyKJXfiK9KOQX6rZ12GreKC3IRPMx91G03yY6SsMK4B6dRaHm/wiQ8Rv7oO3kiAAwge
 osJvsjoNPH7xI6ejKvvcA3zm0M/kxcZXeHhuDITlU+v/tCYs5xSxaulDvjG8N84dpScs
 hz6XPcYTEXakRCz/rTVYdsoZWGKI6mwcUqT+tL3vsNdOxle5tjDr4t/ClkfvVy0cnO77
 qIDQ==
X-Gm-Message-State: AFuF++mTM7ePZVxOJO6S1MRx++0Qtz8rHoaUQCiinXs8DLmggk4tvldQ
 hmUErDP/k5i2BB4rdJRvhoArfiSyIfJWYu+g83kyya/63zSw/vLjrk6D
X-Gm-Gg: AYBFou2U8IC0jzeYVVrsvQgJhr+hyG1zUAmqFWP2p2FMk8glQaWh4vvHGE56rPfhocr
 mwwojnomKa4yUaL9EeapXNaflVwQ7XbyeEqW3n7QJxVVbLDHFhVBfPuOKDybk2k2iMQaiR1HrLq
 Zsj0d3vAferUpq7kDDE5zcdKRXceBi4Yp+v20g8agKXLvN0kaIW2VknXLlVwf9q8UItv++IXF9J
 FZFSPb4Q+4Zy+kCWqAHB3EzFGEdnisGgMwSiPN2HkpHK6CF+7HIX7vcj/FEDBGYTtzEbB5k+CjV
 YlOFGDf8EHORGG/p/fO8i3SeQKjG+HRrwB4Vvf1FNUHReF17EaRQtz6RGAA9zh8uddQFOL0Sd3d
 /eFH7q0aRs4ZCng3Yuyw7j7x4dMIO16A8Vw2VVQ6bKyLkEh76LNKQh+9PlbIFxmWwaGAAnHnQcm
 pnh7X6EfCATkZqneY9G6j3MiKJQde0wSvRTkCHcMrhYlCmDkudRN6SpcT1f2ZXjLEHWlU1DcqsM
 4Uza4v+0Atr5YRNZSN9p8va4feREj2Xjh/yl+FUVl7gWQSWjAdmX2TaDX+i1GHusYKKJlY1xD7J
 QaK9PSuFyIkJdjTLaFFEQ/pPCVatbjjGbe+BiQDEPpa0agFfNObPGIXEAhy7iYR/aJP8d4V3bK9
 IH77P/xAdG6l8Wvy45WAN
X-Received: by 2002:a05:6808:508f:b0:4d6:9252:4643 with SMTP id
 5614622812f47-4d72ea5fe60mr15314769b6e.55.1790641313110; 
 Mon, 28 Sep 2026 17:21:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:39 -0600
Subject: [PATCH 02/20] net: preserve the autoload value across dhcp_run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-2-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The autoload variable also selects NFS and can contain other string
values. Saving only env_get_yesno() silently changes these values to y
or n after an internal DHCP request. Duplicate the original string
before changing the environment and restore it on completion, including
a previously unset variable.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/net-common.h |  8 ++++----
 net/net-common.c     | 22 +++++++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 3084a2b2a57..f1f670dbd8b 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -503,15 +503,15 @@ int net_loop(enum proto_t protocol);
 /**
  * dhcp_run() - Run DHCP on the current ethernet device
  *
- * This sets the autoload variable, then puts it back to similar to its original
- * state (y, n or unset).
+ * This temporarily sets autoload and restores its exact original value,
+ * including NFS and an unset variable.
  *
  * @addr: Address to load the file into (0 if @autoload is false)
  * @fname: Filename of file to load (NULL if @autoload is false or to use the
  * default filename)
  * @autoload: true to load the file, false to just get the network IP
- * @return 0 if OK, -EINVAL if the environment failed, -ENOENT if ant file was
- * not found
+ * Return: 0 if OK, -ENOMEM on allocation failure, -EINVAL if updating the
+ * environment failed, -ENOENT if DHCP or the download failed
  */
 int dhcp_run(ulong addr, const char *fname, bool autoload);
 
diff --git a/net/net-common.c b/net/net-common.c
index f21a80357f6..3a9a0635ad8 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <dm/uclass.h>
 #include <env.h>
+#include <malloc.h>
 #include <net-common.h>
-#include <linux/time.h>
 #include <rtc.h>
+#include <dm/uclass.h>
+#include <linux/time.h>
 
 /* Network loop state */
 enum net_loop_state net_state;
@@ -68,14 +69,21 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 	char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
 	struct cmd_tbl cmdtp = {};	/* dummy */
 	char file_addr[17];
-	int old_autoload;
+	const char *autoload_env = env_get("autoload");
+	char *saved_autoload = NULL;
 	int ret, result;
 
 	log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
-	old_autoload = env_get_yesno("autoload");
+	if (autoload_env) {
+		saved_autoload = strdup(autoload_env);
+		if (!saved_autoload)
+			return -ENOMEM;
+	}
 	ret = env_set("autoload", autoload ? "y" : "n");
-	if (ret)
+	if (ret) {
+		free(saved_autoload);
 		return log_msg_ret("en1", -EINVAL);
+	}
 
 	if (autoload) {
 		sprintf(file_addr, "%lx", addr);
@@ -84,8 +92,8 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 
 	result = do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
 
-	ret = env_set("autoload", old_autoload == -1 ? NULL :
-		      old_autoload ? "y" : "n");
+	ret = env_set("autoload", saved_autoload);
+	free(saved_autoload);
 	if (ret)
 		return log_msg_ret("en2", -EINVAL);
 

-- 
2.53.0

