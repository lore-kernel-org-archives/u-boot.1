Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D1606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0dzXNnRq;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnXfyugo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E5D760865;
	Tue, 17 Nov 2026 12:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBERIxgC-CnX; Tue, 17 Nov 2026 12:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A50360887
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918454;
	b=Vwc3AqGfB6dEjMzbBzOrBqiMUYsGqypVzKUCVhQYF+gT8Px48dxTbhTHkI8pFP+64VlT
	 e1zwcQQ9F7dlbK0y6D+laDjF0SPaQRt+Xy7LIRK/IVQ2F5s4ofoEjTe8/F5Pw70cISEQ9
	 bkOggEl6fgYB4pOT03mJvpmECAlBNZkCMxP0vlIEw/WE/aGiNK1O0MfvkzT8EKXCS/5vs
	 BIxROzztSFpsruiM2H3Rtoxkbs18ypefWVCWvGRJ8SaZu8Ug7x/6C0iWWLyGk+IWuPG2M
	 b9cAkz6sfTJyfmXo0cz7cZX5IpQiCILeLdsEivlyxwekkJul0ALbW9Dev7dLjcZh41g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	b=iMhTyqGFMjlDPTVEdxOJCVtwTJ7Hi0ZuQRBenHRGxj9/ohvgx/HzC7vRlh+JcbIxSp93
	 G0VJpfvhIeDuWv86/ObggldAnT65NbLu07kga6wYno3P9GsRv6Kgwo9figNT8UgfTr57d
	 B/PLQyMAiKq8v/0N0p09KBOoyyV8X7vx/xBkc7LDhgqVqNcrF99RMYh1lu9MrgIRNgGNX
	 Y/0vumwdcB/O7MP19XhDOTiKZpMwTLm+YeT2t+jyQl603ayMWHiZYsEN5QUACIkm40zU9
	 urK5O+CFgCkVVnVYa24YK4+NfE4icbo0hLdDvtrWlz0WTV/gF5UlXAisoSjWbyd+sYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnXfyugo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918454;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0dzXNnRqVnk0YrW6upW8LAt0nCuSE3MNoIsM7VbTKRNKEp16NHB4yu/fpzOj/aFW7
	 abpbp6z9zPRM42ZZCIpxzxM1arQUJwJxY5MmJIle/r4TzVmYpLRUPY+72WGAZVT40O
	 Ze4QWLmTXTtVdukiMz2Iefb4kXHKihXO3zCoK0iZK8Sv5C7YqD1U1bmNx1YbI32l/7
	 +ihAUwTHArs0ZU3Y2xXTp9yEj9hJJMOglQeP9LOlJzS8QVQUnL/sZ68B+piQU+zEKz
	 NMcBkHKx54r+FCrajCVkEmuPAZD5aKoOdjOyabMLhN4FOXETb/G54+NibVoXdVufIC
	 K/rVOkqilgnNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A50360887;
	Tue, 17 Nov 2026 12:27:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD1BF1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD9DC60899
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gtyclwn8NVmV for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 143276085D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=qnXfyugo
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 143276085D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:29 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so472087f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918448; x=1795523248;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=qnXfyugo7wi6SFF+8gRhdnHcNVlJjDHB920cxU8XKKlZKaWe1rScvhblIpMZ1+0qTv
 yFKof2lW2bqJgX5//zBtS6bcf5LUhAl47XeIea40cxt6IJTeRKuJQylzTBlGgdyCAWg0
 E8rVP4UsSZ9n3AwHdMo+mkQq0MnkTOEd8anGePxanHOgjsAfJ8wIGrFL9O/MiVOU1kdq
 6sax5AoleaNllvcFKNHdnK+jzqLN3y6DF1yVeCm7r3/0DE0o3iNJVTSR6WflohGb00DU
 lfhM6cSlcsqkmNRZOWC/rm4hKQxeDZxEYyMPDfaHg+rhO3oTFtX4E17B9Lx6Eejs5hZs
 5sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918448; x=1795523248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=1V0gVg5tmcQQliqTPLkb1GelXCsbczr8x4vV6kUG6/Vc8nI0I9ZpNoAZoylQSCd2QE
 1PRecO/En5B2Pcr4VhKI3shFY5y7mVX0SpCxvFbHouK88AgCbkwDSqZSgF8ZjBA5wWDX
 YF/rnwGfYCdpyJBWwKcW4yss7SuJtMdXxKDew0lTWKnnvnzXwsztvQ+uPZSLzzCbhQ3U
 s6BEkBw5W1Jr7po0ylKSFh7Vz7R/boSyUi92pf87Ckux5fzJmeDbuiGdYS+U6m6NPvxM
 Vu1VpsQKEHdMLvWRkuX7pUuASGSx+Twec/wXN6twavC6P7abdmKg2DSL2Q9MybMHowE1
 vxpA==
X-Forwarded-Encrypted: i=1;
 AL+hErH7HCCWVPLsnk/0HOijhzrlIaKHEuy2GnW701ko8rZ5OwW7n9GMkmTdcJkZb9lvHC48WZXF6vY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Rx+kBH8If+8z6Hcy1T2alM2GUgEA2bSaz8oxswCzXXqHbHPyv
 y1ElVbQPf9lT7KFfsjcR0sxX5zwkmEe52XOPtGukGpv3YFW2AVvXWqtU
X-Gm-Gg: AZFdTZdn7AoxMxBqp/j6cQcwvOw1iWqCEh/P52m9Dn0JnM5BN1ADa5zYNVCIKXlCVyv
 P5aoGMdgViJ/lKUcQ2QJqmwT+/BdlO9+BO2F4C8ZUcB0WesL4xuviyRlUw/rxn9mhdiUCyMx4G2
 8h1dMwFBhPXBtvEjgYPSrK6V+Qf0zI/WGw4o+reTU2f7QQoNOwfyWHJk4cxAFQ8S+OOFu5U/yvF
 rT8iJK1BZcZEecdV9rgPwyE4pTVQ5hr58RZ9cIOF9C5g335xA9CW/cwjt3fnfAhbosholzwk8ke
 /wGgmPEfK//FO2tduTIPIvCMuBmnHZBtEzoLSGECgIaO3+KtayRfFs/4tO1IJMsg/Upk5zZF/x0
 bObSvenZoBdw1PkxhEoXzy/qNMz4KGaYa8t6+QTnbDgg3BT+ESiMKTEa2GMRlG17APqir49fV9N
 G4To+z2v40Fsee7gnfeYBYbU3pkqW7sZBq4Fd7MB+qC2bAIqYS3uI/tcLgdcPlW0BsHjCTlVJvb
 aJMOhdJeFrHTotilGt2wGlQPNi624r0tFvBqpDp+wlwsMEKoD6xOrjiRUj9ceQ5WsSwT0ffLZus
 JMvs+cq3zAr/RR45xqFnGLeCrbSQUh0dI4vEazwJFNNaCLZHgmc8REFY3Q5fPsd8DA+BFpQPY1l
 jfir6zMSS7J8+yw1q57o6AXRrq8iqryLtLg==
X-Received: by 2002:a5d:5e88:0:b0:48e:679a:4aeb with SMTP id
 ffacd0b85a97d-49c6d63fbe1mr28091777f8f.3.1794918447473; 
 Tue, 17 Nov 2026 04:27:27 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:26 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 3/9] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue, 17 Nov 2026 13:27:08 +0100
Message-ID: <20261117122715.7983-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader-uclass.c | 24 +++++++++++++++++++++++
 include/fw_loader.h                       | 14 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 0d95fac8f42b..7f19d6c4af4c 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -7,6 +7,8 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <env.h>
 #include <errno.h>
 #include <fw_loader.h>
@@ -137,6 +139,28 @@ UCLASS_DRIVER(fw_loader) = {
 	.per_device_auto = sizeof(struct firmware),
 };
 
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+					  node, &fw_dev);
+	if (ret)
+		return ret;
+
+	ret = device_probe(fw_dev);
+	if (ret)
+		return ret;
+
+	*dev = fw_dev;
+	return 0;
+}
+
 /**
  * _request_firmware_prepare - Prepare firmware struct.
  *
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 56f5e3be6195..99c47380a172 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,22 @@
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+#include <dm/ofnode_decl.h>
+
 struct udevice;
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Search and probe a matching FW loader device, if found.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
 /**
  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
  * @dev: An instance of a driver.
-- 
2.55.0

