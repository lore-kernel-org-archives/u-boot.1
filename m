Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6C60A2616
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cfwkk0kK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f7bF+rS9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 812A36077F;
	Tue, 27 Oct 2026 12:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJ4S2H_-RpI0; Tue, 27 Oct 2026 12:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D7CE60789
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104769;
	b=CbwK3Mgqb+Wa8VSQ1C/IIsbJkqZU6aJ9vxJe5vPocQCYCCSa9b+cl6tmisqdLunV2EEe
	 +K8U4+P4q/bFqEjnXHvv21obQ8EBlGOxYAup39SYLyZZaSfCr7St6lhTWJrAvkvoAZMy/
	 uvisM0Bkb01+H7XxhTJMK7zz7NzGZGCz7Tjw99K6T/VQdW6bBfcSayRQ1/6Y3Dau6NcCc
	 7DeUnZSKcBFdW+wOxaXGZ4VbVEVBvmkIf5JGkCzhjQchYZCS326fDEoAOGb6ct80HzHzB
	 A/E0o1p1EoYdAtFHai2wKWO1qMGuPkAdg32yCtL42CtnS+Y3r9D+FunXvcf2fl1U48w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104769;
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
	b=e32eA+cICjBeNuey2kpdnOl9ibj7ydUkkMlQ/L83gCfxqMKEYoSjQ+xKtB47hiag/HT3
	 ba70jJpCQr62+oA1ReBwg0zZAFT60lQvNY+aGzeXz3KE0SsWx8yPxyeD+INjftfng7+oY
	 QZTPV/F9CEZGjV1ev49cXPfCsagslUEV2EuFYVvi5I8SWXGn29nH+Yp1et7brvzZV2eIJ
	 BpqUXJTlg6Xq2xRd3OrL1Dxv6kiArsiPGvE2PWOFJfUTLplmoI9CFQFH5i2qLJNCPSulc
	 8zLH1ZHv4RFDZRuN1xj+2Jn6CX11+c9l90JOzBNdW2CJVrwjv6qcCFE1UqDuxCxCOew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104769;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cfwkk0kK8jj4/lA13gz9Q05XQ4IQ+r6NGgHQ09dZmZpLjc2az2e3ctiPNo2QDUqkm
	 uWD0b9GgVUVdQ1yIepdRSY4L+i5Qq/yFXxhfInUwW4SMeIW9+wJdS2kVMZaug1v98f
	 aWfWGoR2B1LNNDSBw5M5uHlIwPh4TDR4wCc6Be7wQy9E/kFi8ITBLnMQ53Eedjm2Px
	 oIBQjxVvnVDNyPvDnZA6gYrdIeGk21mkXeosOxX5o6D/dYtOBV67vuIyjc9de2tmcN
	 iyaXO+ODJkLuHLnFWFtqno61yZ7ZMORC+okfT157W+WdxD0Z5qq1aTa6R8SUHgj+9t
	 Y+vg4gPPgMEKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D7CE60789;
	Tue, 27 Oct 2026 12:39:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE0923D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 920594059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-GB0ahr0w0E for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98ED94060C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104763;
 b=elCooDOYTfzgAq3XNGNCPrrJhch417v1ifvYXM6NWOCBYTRKmqWI5qxpHa1hN5u0Ds0k
 xxaogEfAGErhk04JiRS9eaG69P/cnxkkf4o28t3EwKG7xh6P9+QLHCGJYrkczIAp1n//F
 pe9eLYllC/D1HaetO4dJ2xdzQOTLfiL1UK/z0tfsiOfRzsZ6KxkgfiQVuKukaulSORHfd
 jp3GIN3l7HMfVoe88REWZmMHQ2Mmjmus+tFZMaIMQrhx4YDEb78ioRVsGatKC7GpqdNTD
 lD/gisT3fXeP67P+joarCph+8ba76yHUhzddxugsKRYEmqC5OMJST64wN4BWhlmRNxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104763;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=mfZbdYj8aq6MgSuXWHLCJZUBMSxm7dESbUv5u5cDXWDCwIXwls/4Uqzrsmi41HNxZPOR
 1KqHOmCMDvKlSWopedKEe0Y0P1y9r5IMdkQP64raRl0Mm/UXyzXc+xxvsUMR2ct034ohP
 kpTpE+eKccJ5B6wMQm8l3gT6SHlYKF2j3QhgnBPzZz4Ez1eXxxvhrqnY1go12J3DYCVVi
 aGOR4YZ0AzC5ulYKwfaAbSSARQ5wUsANo2GeuKhZQ1xDhc5GI8+VeexnSPOWS9sR+D0Oi
 HGTCbEeZ/WIhaRgEOREn6r+8gTzWAkT5W8jftzDIm8/XSDErHBx96QD/jlvqA+KAgfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=f7bF+rS9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f7bF+rS9
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98ED94060C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:22 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso2634494f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104760; x=1793709560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=f7bF+rS9zqhvj23BsuzIedmWg7JYQZXk1FzmMqTmb0oidVPKXFDbmIYGSN0N0iEDHi
 TmXbaN8Bc8ioqNZEf6BC74GtvCOz6cMn1TK/cVvmXw4ZiD0rGq7UI1dAgX7X7YqzEHN7
 kPGr8skIvmBGF8qVngo/FPdtVa5jivfaVaVo3CYezu0l899WxfUgWZT7NhZOkjRupELK
 6ZUGg3wu1FDoq7KC1cdW1Ek1DfjAZ3OsXZmHOKy5mSMJ70hJ1LmzkbYBUDZMdrg1Miv0
 XC2Jh6c2vhXCn8kEPafuGYQDD5eAqYuw065Q0yvNVvFjKCApCJxiAEDpXVGRgC2hCuBs
 Dm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104760; x=1793709560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=aX80F25dcNCR/PJ6zV3XOEX1blXNcqmyz5XPLnIeDRWDndcXoLsxe8wPgPr9fRsHA9
 9hmixwa9k/GeZeaep92etfY+aZzcOXPVz89/RqcdBPCtj6JG4ZlB5Y9ynXqev1fh9+C/
 CsezJCL6KDQKkutV2cvD0bvoGweUBx03PpKaiQSZiERhvahwe1G+AwkneJGfZ92WJrTP
 LFq7Zvsld8h26ApOAreBd6pAatvQ2ft5jV8f7E6eYl7EoAWYYkUIaBOLU779qChxUXQg
 1EVvTqnzBcU2paAf+BtIjiIF+mrPR3lhLhXkudpbKi/rPvLJa6qB0G+3zhKBtPn89k6l
 c9Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy48w8WZzTYZJL8PZhvwhMGmVlRdUQJaZU5JV5A0Nzo0smjSdl83wPUMjKf/nXS6BQwonlqRLU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOe7e22O0KKupP4khvamaYYT72Ne0VvDCQOpvatJn3tDfPdtxB
 jq+A8998E4MyssWAXnk8i3H9bAm04MLK9PrdGvKEgCif5RdKcHbkUuAJ
X-Gm-Gg: AYBFou0Uu50b39PndfCUsgaZXfIzncaMWzPh4GBTWR2uwQ/+Sas7KNVSavdEXTP1+UJ
 9EdZiPkrAbzoe14A+cCUdxVx3lUaIGslP3Xwe8LmFD93cc4s7VbSLdTsE9OPG6PiUyboLIGrlln
 HnFkpigJHhyffhVXlDJBhwTYZhGBwJ07BfCN3g0vjy0A1Xe38IpkzUSYzeDY/5UZqtPtNcXArDj
 dZ5BYDdUyudz/ADg5W7z0RZtuCmVPtXxjgLqVzhiFsVDy2R5YyQjOfeQrEwmUe1whTLbrFPA0Qk
 H0KLJH6D6oyxL1tftMIhYP8kAj/NLZoWtX95ZXqZNN5Oc83yqSEd9EtfiLV1F0nmqfuDM5IJuO0
 cVf9l4xh7SCiBEFvwDfYPHGGjmkCXMcqpYzFQazTOkdHGOwQi2DkxBu+SK55upkfKex/W8B0Jji
 YnYEhwDov9LPFC0t7CNxv4GfPsEjqTzLvkBq5kQ1s/D/kne/FmNqZOqLX0QMt4VU7K+mayWV9ji
 ay0nEUaeZS30vzuz1bBUlvLb7Z9pN61GpAQS5C4gfghRGebc05R3/ZbhlgHVrwhWQ5EqbWW6UQP
 IA9TmAueouW8DpgsPnqya+k+v5dTTsrivo1w5QnRHYMr2Axz+pFlYzkf34EA
X-Received: by 2002:a05:6000:2c0f:b0:48d:b940:af7a with SMTP id
 ffacd0b85a97d-48e3eba36d3mr19330124f8f.55.1793104760101; 
 Tue, 27 Oct 2026 05:39:20 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 3/8] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue, 27 Oct 2026 13:38:58 +0100
Message-ID: <20261027123905.839-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
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

