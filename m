Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95787C88E50
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9DC56066B;
	Sat, 12 Sep 2026 01:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFjRJKIdwXPG; Sat, 12 Sep 2026 01:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 990DE60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175245;
	b=j2G7PCPmulD7D6xJGkMsMQLj3jjt2TXsWi8b8iWoIA0Gmjb0hxDdYrBKoUpSVfrNW7vq
	 NxU7XzEy7ugEf4GPHCyQOtdsYq5F8RYiDzIROXkW61NvnylHcf2q9tMJkoyjZu+JqSEKU
	 ApQ0CGdkGYli1xMxfmWBH1oXdnneoyPv/2W5T8AIpY1oJYi5+IpVo3mv4ENy2J6J90RTX
	 fif9xBjjoJ9iDccYPAZdhokQRPwgro+esvyvSakYJcgAa2lhWQ22QZO8FAFAQeHsjUVIi
	 4RMSNZDvWCC7Ic0Tly9TxbCpND4oyQtNa4nSa+qRQcJbcoLbTTh6ylSJT2SWCubweQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=++Dq/WqdLTuNhaigSsgZrzgOFj/eTJAPRtQPg0xkZkU=;
	b=izVXjgpcjlQCmurfnHTZKps9PQ7aZ7YZ8fIRA46xKiqP5bnhzr78r1l5tX+3uRhmml8l
	 wyNmkXbVuC42/8C23mkdhrb+MF+YzF4k23dYNt0T5zX/8LLwicEYhRFyTcvKWG3wqhsj7
	 SfWDuWhBnr0/oFeAZW0KmwYfKJIo7Ao0JlMgI5ZCo/1yN+r6u0McB0OqsIwKOUqgzt3ZP
	 soS1VSzeARGqmdgouAxMdtjf/mwuYDE7p5ImddUsCdONdvgsxX07gL1VhWv4a0VOPOkhI
	 g+kfx47kPgrf4OkTqPAIg/kgYQzM3coQdS787nG0basXPj6RHxqnMNPrA6rc904Z7jA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175245;
	bh=++Dq/WqdLTuNhaigSsgZrzgOFj/eTJAPRtQPg0xkZkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=f8I/dpHMaONu+OuwYNQHg7ZwGP3jiobyy0qT9JQvWwNDwR6pdFHrfSGsVeZq3Lwac
	 UqoJYfOS86gYnaXBHpvMqSSjf15ndaqRcclfka/nsCNGkq91hOd2YOos9DT59/sYBm
	 O77SO4XnV94M/e/TyedCH8XuLX32gSRiw+8ItJurxDxCZnWWb/sRdGq3sZmNiQ0FnN
	 2eYrVvWkxSfyzJkByA3EnGIKzJ3kPAlX4rmYBxjCdfvKUDyZn8l+d+FcIueTwhu+Q4
	 xfAKXlLOYLHwXOEDrXli0WfWhbv3Ze3ZFyPg+GZseeOy63TYx9sEG4ugjKlqaDTkwr
	 ZnFphBzD/MqrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 990DE60621;
	Sat, 12 Sep 2026 01:07:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 117DD3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 036A4400F9
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbHo22lhWqu9 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0725E4000B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789150743;
 b=WR174M10emaKEgAYKSuwFPv7BnmuHUACkZ8kTkqf5kFm/2YF+kBVstGZBHlHHqsP1XZv
 9xO8xo2Qagb+GXm7X0SSxAjNyl7XcRgN/7fCxFZ4mIKdw0M9RAc1Y6l66QbX8QNsF7ao5
 uRvJL6f4N1LUbwqLB3jDgW2DALNeZqowo07S37U5OmLikKw9aNbjzJiGX4knM+PeFsSzs
 1QOTPL5glglA+szOyVg1m04y/Ij/V70q/6qggdsRaq9f2dUaFSx6XQh0ziOdlpS9jFcwV
 46K1x9zjbyf9UoqnWgld6Nj5c4iXdztW6TG95tjh9OxJqDISythmRgzpuEeZJCHzNuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789150743;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=++Dq/WqdLTuNhaigSsgZrzgOFj/eTJAPRtQPg0xkZkU=;
 b=aAPq4UQEyWtmFZS/OWeQ/GYUlO/9QEo8X8AptdoVpNv1DnyZpn5YIZGiJgdsJbvq+FeJ
 VjQ4ds6SsrdbbLHR5uoufYZG8OElZlWERMiSr+ASTA2hxGSihnWlNLagrxhLujH4XmUfZ
 8J62lTTxT2NKQXeIWzIvj/OnjsrNOtOwN20AYhNDAbWrZdkOeFCUj8ViXUnULmxvt4qbO
 hRbpKAUg7t4hHEuQp6XCZkzQYPW60bEBncclwPBJGX9wUV+DpM72sacdBtWqiSkXmq3xT
 +MklPDjC/YkfEriGzuDHkIOXwHvuDUIiOxKHlZBerGvg5QhByCq0sBYaUziyUi4xqgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VRYl8ucc; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VRYl8ucc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0725E4000B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8DE24012D;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98641C2BCFA;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789150741;
 bh=Jqe+c2W04KkKNAI0Vni2RfZ4ZjyQ6ChVgV+u2J1yXtE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VRYl8ucc6vsiHWYkTn+F8TZiu+5B19IWTH4k4/OLYhDgrkRyFLbtbZ3ENx9rqpeDR
 Y61DZcBIsw7w4bzJYdseHpTOVA3hbYWOu4cI3Ei8dal3MbuLQkcVuJrzOSh9T+ZVcj
 euUTKxKwf6Y5M4yVNp+mKJmHgjLbf0+FmZ9/CvH8Y1FuZ+4Plgnyjbt8grJWQoQtB5
 bMvfWkYEn7rgnVjJujiWGd/foq9JVNeBED/2intvMPFrFPiIR4eemjJfvaALSID+od
 xcCJCOa0MnLz3qwJbflPKfuKu6dUDSIHX2nW7b0BcIoxjBQPYYgSCMkFcpbDDkEtFf
 80sdYjp3mRBJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 728BAC88E53;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:18:47 +0200
Subject: [PATCH 1/4] common: Add command line parsing utilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
In-Reply-To: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789150739; l=4144;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ZdXxyiEAeOugrDHWmQZ2fyrZPJ4bt6tClmkXHuoPbrU=;
 b=5r3/mMK8Zq6Bz7V7Dht68o6Nr/XgdUt4GrWSOJTi7yeElJ2xldLc6MVnGW83qlYmG5vFDVK01
 LPGl/cY3lNPB3btwQIGnEZpEiTWI7oczcCCWLjc7Bci7m2LTH2UyLZm
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add a new utility library for parsing command line parameters in
key=value format. This provides a reusable interface for extracting
multiple parameters from command line strings.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS             |  6 ++++
 include/cmdline_utils.h | 21 +++++++++++
 lib/Makefile            |  1 +
 lib/cmdline_utils.c     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..ed697d11349 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,6 +1065,12 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
 F:	drivers/clk/imx/
 
+CMDLINE_UTILS
+M:	Petr Hodina <petr.hodina@protonmail.com>
+S:	Maintained
+F:	include/cmdline_utils.h
+F:	lib/cmdline_utils.c
+
 CPU
 M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
diff --git a/include/cmdline_utils.h b/include/cmdline_utils.h
new file mode 100644
index 00000000000..cf127b64e55
--- /dev/null
+++ b/include/cmdline_utils.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Command line parsing utilities
+ *
+ * Copyright (c) 2026 Petr Hodina
+ */
+
+#ifndef _CMDLINE_UTILS_H_
+#define _CMDLINE_UTILS_H_
+
+#include <linux/types.h>
+
+struct cmdline_param {
+	const char *key;
+	char *value;
+	bool found;
+};
+
+int parse_cmdline_params(const char *cmdline, struct cmdline_param *params, int count);
+
+#endif /* _CMDLINE_UTILS_H_ */
diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..67ac974487b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
 obj-y += hang.o
 obj-y += linux_compat.o
 obj-y += linux_string.o
+obj-y += cmdline_utils.o
 obj-$(CONFIG_$(PHASE_)LMB) += lmb.o
 obj-y += membuf.o
 obj-$(CONFIG_REGEX) += slre.o
diff --git a/lib/cmdline_utils.c b/lib/cmdline_utils.c
new file mode 100644
index 00000000000..b4798c439b8
--- /dev/null
+++ b/lib/cmdline_utils.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Command line parsing utilities
+ *
+ * Copyright (C) 2026 Petr Hodina
+ */
+
+#include <cmdline_utils.h>
+#include <malloc.h>
+#include <string.h>
+#include <errno.h>
+#include <linux/kernel.h>
+
+static const char *find_cmdline_key(const char *cmdline, const char *key_with_equals)
+{
+	const char *p = cmdline;
+
+	while ((p = strstr(p, key_with_equals)) != NULL) {
+		if (p == cmdline || *(p - 1) == ' ')
+			return p;
+		p++;
+	}
+
+	return NULL;
+}
+
+int parse_cmdline_params(const char *cmdline, struct cmdline_param *params, int count)
+{
+	int i;
+	const char *p, *p_end;
+	int key_len, val_len;
+	char *key_with_equals;
+
+	if (!cmdline || !params || count <= 0)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		params[i].found = false;
+		params[i].value = NULL;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (!params[i].key)
+			continue;
+
+		key_len = strlen(params[i].key);
+		if (key_len == 0)
+			continue;
+
+		if (params[i].key[key_len - 1] == '=') {
+			p = find_cmdline_key(cmdline, params[i].key);
+			if (!p)
+				continue;
+			p += key_len;
+		} else {
+			key_with_equals = malloc(key_len + 2);
+			if (!key_with_equals)
+				goto cleanup_error;
+
+			strcpy(key_with_equals, params[i].key);
+			strcat(key_with_equals, "=");
+
+			p = find_cmdline_key(cmdline, key_with_equals);
+			free(key_with_equals);
+
+			if (!p)
+				continue;
+			p += key_len + 1;
+		}
+
+		p_end = strstr(p, " ");
+		if (!p_end)
+			val_len = strlen(p);
+		else
+			val_len = p_end - p;
+
+		params[i].value = malloc(val_len + 1);
+		if (!params[i].value)
+			goto cleanup_error;
+
+		strlcpy(params[i].value, p, val_len + 1);
+		params[i].found = true;
+	}
+
+	return 0;
+
+cleanup_error:
+	for (i = 0; i < count; i++) {
+		if (params[i].value) {
+			free(params[i].value);
+			params[i].value = NULL;
+		}
+		params[i].found = false;
+	}
+	return -ENOMEM;
+}

-- 
2.55.0


