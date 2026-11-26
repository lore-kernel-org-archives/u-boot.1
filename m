Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87354606A335
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hr1PTkqc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdMYFkSj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6414B811D7;
	Thu, 26 Nov 2026 13:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2d49DYoGJdq; Thu, 26 Nov 2026 13:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 827F0811C0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700032;
	b=gYK2meLpGbzpKtNULkbi97cmSmf7FoS3h3R1CDBBx0ToGOtFIyZXlIL4xGOhIYi1gUwd
	 Al1PbOBbrxgDp3PJhdVDnZ5/qcvUva9qPuWxk2YSgez5aexex4SqZOCZFK0Izbs7FZVVd
	 O+CrC14kKD7vCafxOkYez+21IWOX0tFJYoBsIbM8tH4nCvRlkjZKlF/ZASAeyGTCLp8F4
	 PmfcMhoZb5WTZpVNHaNZrXo98Loy5wdIwg13xUfy65+a+/HlafGsm5tnlWbmnJFr6yc9L
	 dlQanvfnlcKFa1cwCjyHHuxBcyjA5DKeYd5mfRLxKszfqUR3cm27dUo2h3dQ+pVbdow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W2N9ByAvgO45672TzpMKPdHEUTvgFTXCNpoZy1hrqog=;
	b=H9yfcytPC07TEij1qaCFrc7xjI46m4VDmhmH7B2Celo+EULtJfiTRyXB2ux9yZsiBK3j
	 Kxpg9H4aWoIhk9B3P7w7RRr7DFF9c6ER8AzvUKY/WANzmWjiuzu12qNBR6NcrawWL9zup
	 FBJdVVVONEE26EAnW6N8N7dfvUPwptWJMPocCp31OlLoSLTHE0RPPVy/RPXhd2Wyap2Sc
	 eeUp23yQ6eFxMlWl1Va8A8xikrNVaE5DUHq54byE9Tr9dgccgKKPrEf27w96F3crv4sHq
	 kme93MZn4iBrOHFnWEkcqmzKMHQCISxYV9cFCITdU1G5gXOF93nEonQx9gMc06FGElA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700032;
	bh=W2N9ByAvgO45672TzpMKPdHEUTvgFTXCNpoZy1hrqog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hr1PTkqcO/v9gFjeQlV20HcD8d/2IPxtfQKoW/ArBQSNDPUcx0YsiO/pOtwjbP0xE
	 RKTIt6bm+v2ZT7EvGmA90LwJn1jrB00bVDVCwMPsxoeGSn/kjBaH/P26bRq0j0l8Iv
	 wLusl1dRlFYtM5CIN57B+f4hq33XsyP9yZ+PAqlEBYZ2rU8dmfp9LNGNh7DKXyBfPh
	 +EEuxgGv9C2vsn0lZE1vplXHqxUpLqwCVeQFW8UPKfHxTA3eP28jyygLiK+J1LHcZK
	 dA/Y4zb1JJyzU21xFlhsz90zkNZ/cyBtbU+FastXWc0A8UmGOGYC9wns4GpcKVo0Ws
	 raY8HrNvBxffQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 827F0811C0;
	Thu, 26 Nov 2026 13:33:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A11681C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9389E40492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utaA2QiZQT8c for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3B5BC40490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=AdMYFkSj
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B5BC40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:46 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-843cf077f10so8992437a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676025; x=1796280825;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W2N9ByAvgO45672TzpMKPdHEUTvgFTXCNpoZy1hrqog=;
 b=AdMYFkSjnb19i/+hcFlVelvJQKJlDOxFS8HNQLqX3WuAYtGqeafG7VX8aR7pez2g1S
 TtU30cTeLsbEOYBoqAveUiz/CqMpYjTkksnNZ1l+JNJzRUmdmchslVdAml5m02Gz0N/M
 nEzGuGfMTjGWBqhYHq6F1MWBI0Xkn56UljUUDKfsqnwOWvtFaRwpz9/+1KKVUFJ2jjnG
 8RDWQR0g9k8cmdLFUkrspnB2Bqt/GWORXgpqO0c6ylBeqzB5iUcKHRu5YjgXg8YA82gE
 zoT/cKJdshmts6tVRM2IY/VEV6ZNZwOuu19/v6UTvzqb82V+2D8q6LGCCwkhEmZh82dC
 qPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676025; x=1796280825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W2N9ByAvgO45672TzpMKPdHEUTvgFTXCNpoZy1hrqog=;
 b=hhUVogXgbiT0s8R3+BLq+AWdzVC/DIsplNUowBR516C6ePLx6TB1aQRF0+FbAFnbA1
 RiCsyDaOcZRbLTd9cV0Vd09PmL/I6ek82YN2JzyR0xFxtnmnzuYm8ezyUi3G12sdehrT
 F0ft9IOCU3CqL/zLpLKHUHRjw5SosZ9bSiCbnA8xOFEh2MWSuhmzdWjJxUB0VqorRBoh
 IOkUWijJGksfq3jw5oRSllRj5BVmPQZdA+92RkgLRNy3UeMuNy2jykHRwToP4BB0QPEZ
 x5bf5W4SNNjGXFYkWd5EhDy6XvC1WfnsnMiDanR84pCDkscN9SQkJVf4PvqVYB5mhE2L
 JwxA==
X-Gm-Message-State: APuU4Z/0Jj+MV5+oBSYREWwjgTb7c1qVX/E6ox0JGedMi2uk+/dpAzVc
 UEzPUrouC8N+0B1QTdZgIArQSUiHo1ViE/sO9IPGldyuwK77e4YBHtyT
X-Gm-Gg: AZFdTZf5nZQ/Zk0H5Tv/Noz13fdk/QzAJ1ZKdH6lmfbHl2bI984DfTPyCVQosB/gm7N
 pONHerya5v7o21SIa5DSBZNabFPMHusDt1SD7T2VFsgUWC8TkXXizYNdPaZ/fJQ8et+eTxp6qHI
 hzRNU0+qd9dTefrajkcRn0wMiC7raabYLUraC+N5ZDzmFj9Aky5waLtfHOJAX6PD1cc3QvvMElv
 c9QJowp3B4JC6aihjOoNo0moNIDp0zZOzuVZ++T3NafVzUSeGhykNiBvKbc0Nu3awAxtJk1CsFA
 iqSJERXlCkZp6P79WpDdIon4OtygL3wCZ86MF1FsTQl77jD31AZ8f646wwZJBppvla9zqrvR6BD
 AIW7vNkY43wm8A3sIfCjAc8TTdM4qLgF5Po7RUxhOOZ0NezbIP2P+3IXuvlh0v2yBktVuzMbQnJ
 FRDdD++0EN7APVAjwtK2lz3WZcHeunG6HucNUnXl4hxFnKFTg6SzPvRIu5BhNuheVAIQ6P1zOjP
 w7AXnWt9aJGr2nWhjsMIsUdIEZAfif/pIzekEfmGPMQ3kkhm3fUuC1PNXyR8ZaElZH3kLSZTCly
 A9bfXG1y9kqQwn2REL/Rvb5INPiUzeERzCTjonXT0JXNCLydVnBxxlB//5TtazORuo3YhkJUMza
 Bpmg4Vs/rh84E7ImN02c0SMC8swqFrO4rrRBUI3dVUc6Mcf7zJEze+SS12quP0gjGeDMFz6G/wV
 SNmmbRAM+DN7n5+HoyHqd64RMnN8f4ozeICoNPszWP//7pPXuPC0c=
X-Received: by 2002:a05:6830:4487:b0:861:5cbb:8603 with SMTP id
 46e09a7af769-863158d55b4mr22313614a34.20.1795676025073; 
 Wed, 25 Nov 2026 22:53:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:08 -0700
Subject: [PATCH 19/19] net: lwip: configure NC-SI before starting network
 clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-19-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

On an NC-SI port, the management controller must enable a channel
before IP traffic can reach the network. Use the shared NC-SI state
machine to configure the channel before bringing up the lwIP interface.
Dispatch management frames separately from IP and track their timeouts
independently. The ncsi command can also bring up the channel without
an IP transfer.

A Configuration Required event can start discovery again while a client
still holds the interface. Check the channel before attaching another
client or changing its addressing. Reject reentrant attachment during
discovery and leave existing clients and their addresses alone if
discovery fails.

Do not let a retry stop or rotate an interface another client is using.
If Ctrl-C interrupts initial discovery, return from ping without trying
the next interface.

Exercise capability-query timeouts, request-ID rollover, failed channel
enable, shared-client recovery, callback reentry and cancellation with
interface rotation enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/Makefile       |   1 +
 cmd/lwip/ncsi.c         |  23 +++++
 cmd/lwip/ping.c         |   2 +-
 drivers/net/phy/Kconfig |   2 +-
 drivers/net/phy/ncsi.c  |  55 ++++++++++++
 include/net/ncsi.h      |   2 +
 net/lwip/net-lwip.c     |  70 ++++++++++++---
 test/dm/Makefile        |   2 +-
 test/dm/ncsi.c          | 230 +++++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 372 insertions(+), 15 deletions(-)

diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 90ad4d21e6f..43a6b29e687 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += linklocal.o
+obj-$(CONFIG_CMD_NCSI) += ncsi.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 ifneq ($(filter y,$(CONFIG_CMD_PING) $(CONFIG_CMD_PING6)),)
 obj-y += ping.o
diff --git a/cmd/lwip/ncsi.c b/cmd/lwip/ncsi.c
new file mode 100644
index 00000000000..3b6b257977d
--- /dev/null
+++ b/cmd/lwip/ncsi.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+#include <net/ncsi.h>
+
+static int do_ncsi(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	struct net_lwip_ctx ctx = {};
+	int ret;
+
+	ret = net_lwip_start(&ctx, NET_LWIP_ADDR_ENV_FLEXIBLE);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	ret = !phy_interface_is_ncsi() || !ncsi_active();
+	net_lwip_stop(&ctx);
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(ncsi, 1, 1, do_ncsi, "configure the NC-SI interface", "");
diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 31c9e0ad4d6..f50765cbf0f 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -183,7 +183,7 @@ static int ping_execute(const char *name, u8 type)
 				    NET_LWIP_ADDR_ENV_STRICT);
 		if (!ret)
 			break;
-	} while (!net_start_again());
+	} while (ret != -EINTR && !net_start_again());
 	if (ret)
 		return CMD_RET_FAILURE;
 
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 02aeb1db977..ed5c52039a6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -389,7 +389,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
-	depends on NET_LEGACY
+	depends on NET
 
 endif #PHYLIB
 
diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index 5cc183b88f8..5ae65bebf46 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019, IBM Corporation.
  */
 
+#include <console.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
@@ -81,6 +82,7 @@ struct ncsi {
 	u8		expected_type;
 	u8		expected_channel;
 	int		result;
+	ulong		request_start;
 
 	unsigned int	current_package;
 	unsigned int	current_channel;
@@ -112,8 +114,10 @@ static void ncsi_complete(int result)
 {
 	ncsi_priv->result = result;
 	ncsi_priv->pending_requests = 0;
+#if CONFIG_IS_ENABLED(NET_LEGACY)
 	net_set_timeout_handler(0, NULL);
 	net_set_state(result ? NETLOOP_FAIL : NETLOOP_SUCCESS);
+#endif
 }
 
 static void ncsi_reset_probe(void)
@@ -536,9 +540,45 @@ static void ncsi_timeout_handler(void)
 	ncsi_update_state(NULL);
 }
 
+#if CONFIG_IS_ENABLED(NET_LWIP)
+void ncsi_poll_timeout(void)
+{
+	if (ncsi_priv && ncsi_priv->pending_requests &&
+	    get_timer(ncsi_priv->request_start) >= 1000)
+		ncsi_timeout_handler();
+}
+
+int ncsi_lwip_configure(void)
+{
+	int ret;
+
+	if (!ncsi_priv)
+		return -ENODEV;
+
+	if (ncsi_active())
+		return 0;
+	if (ncsi_priv->result != -EINPROGRESS)
+		ncsi_reset_probe();
+	if (!ncsi_priv->pending_requests)
+		ncsi_probe_packages();
+	while (ncsi_priv->result == -EINPROGRESS) {
+		ret = net_lwip_poll();
+		if (ret < 0 || ctrlc()) {
+			ncsi_complete(ret < 0 ? ret : -EINTR);
+			break;
+		}
+	}
+
+	return ncsi_priv->result;
+}
+#endif
+
 static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 			     uchar *payload, int len, bool wait)
 {
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	struct ethernet_hdr *eth;
+#endif
 	struct ncsi_pkt_hdr *hdr;
 	__be32 *pchecksum;
 	int eth_hdr_size;
@@ -555,7 +595,16 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	memset(pkt, 0, PKTSIZE_ALIGN);
 	start = pkt;
 
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	/* NC-SI management frames travel directly to the controller. */
+	eth = (void *)pkt;
+	memcpy(eth->et_dest, net_bcast_ethaddr, ARP_HLEN);
+	memcpy(eth->et_src, eth_get_ethaddr(), ARP_HLEN);
+	eth->et_protlen = htons(PROT_NCSI);
+	eth_hdr_size = sizeof(*eth);
+#else
 	eth_hdr_size = net_set_ether(pkt, net_bcast_ethaddr, PROT_NCSI);
+#endif
 	pkt += eth_hdr_size;
 
 	/* Set NCSI command header fields */
@@ -582,7 +631,11 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	if (wait) {
 		ncsi_priv->expected_type = cmd + 0x80;
 		ncsi_priv->expected_channel = hdr->channel;
+#if CONFIG_IS_ENABLED(NET_LWIP)
+		ncsi_priv->request_start = get_timer(0);
+#else
 		net_set_timeout_handler(1000UL, ncsi_timeout_handler);
+#endif
 		ncsi_priv->pending_requests++;
 	}
 
@@ -817,7 +870,9 @@ void ncsi_probe_packages(void)
 {
 	if (!ncsi_priv) {
 		printf("NCSI: no active interface\n");
+#if CONFIG_IS_ENABLED(NET_LEGACY)
 		net_set_state(NETLOOP_FAIL);
+#endif
 		return;
 	}
 
diff --git a/include/net/ncsi.h b/include/net/ncsi.h
index 42405992da3..619c08a4e18 100644
--- a/include/net/ncsi.h
+++ b/include/net/ncsi.h
@@ -10,3 +10,5 @@
 bool ncsi_active(void);
 void ncsi_receive(void *data, unsigned int len);
 void ncsi_probe_packages(void);
+void ncsi_poll_timeout(void);
+int ncsi_lwip_configure(void);
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 075d5b1716f..8efafe6550b 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -27,6 +27,7 @@
 #include <lwip/timeouts.h>
 #include <lwip-hooks.h>
 #include <net.h>
+#include <net/ncsi.h>
 #include <net/pcap.h>
 #include <net/wol.h>
 #include <timer.h>
@@ -37,6 +38,9 @@
 /* xx:xx:xx:xx:xx:xx\0 */
 #define MAC_ADDR_STRLEN 18
 
+/* The PHY driver uses a global option but is linked with this phase's MACs. */
+#define LWIP_HAS_NCSI (CONFIG_IS_ENABLED(ETH) && IS_ENABLED(CONFIG_PHY_NCSI))
+
 static void net_lwip_keep_serveraddr(const u8 *frame, unsigned int len)
 {
 	static u8 saved[ETH_ALEN];
@@ -90,6 +94,7 @@ static struct {
 	unsigned int no_addr_users;
 	bool accept_untagged;
 	bool polling;
+	bool ncsi_configuring;
 #if CONFIG_IS_ENABLED(IPV6)
 	bool ip6_configured;
 	u64 ip6_lifetime_time;
@@ -434,8 +439,6 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 		return NULL;
 	}
 
-	netif_set_up(netif);
-	netif_set_link_up(netif);
 	/* Routing: use this interface to reach the default gateway */
 	netif_set_default(netif);
 
@@ -830,6 +833,28 @@ static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
 	return 0;
 }
 
+static int net_lwip_ensure_ncsi(void)
+{
+	int ret;
+
+	if (!LWIP_HAS_NCSI || !phy_interface_is_ncsi())
+		return 0;
+	/* Do not re-enter synchronous NC-SI configuration from a callback. */
+	if (net_lwip_runtime.ncsi_configuring)
+		return -EBUSY;
+	if (ncsi_active())
+		return 0;
+	/* Discovery needs to poll for replies; defer it while polling. */
+	if (net_lwip_runtime.polling)
+		return -EBUSY;
+
+	net_lwip_runtime.ncsi_configuring = true;
+	ret = ncsi_lwip_configure();
+	net_lwip_runtime.ncsi_configuring = false;
+
+	return ret;
+}
+
 static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 			      enum net_lwip_addr_mode addr_mode,
 			      bool eth_started)
@@ -841,6 +866,8 @@ static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 		return -EINVAL;
 	if (ctx->netif || ctx->dev)
 		return -EBUSY;
+	if (net_lwip_runtime.users && !netif_is_up(net_lwip_runtime.netif))
+		return -EBUSY;
 	if (addr_mode != NET_LWIP_ADDR_ENV_STRICT &&
 	    addr_mode != NET_LWIP_ADDR_ENV_FLEXIBLE &&
 	    addr_mode != NET_LWIP_ADDR_NONE)
@@ -876,16 +903,16 @@ static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 #if CONFIG_IS_ENABLED(IPV6)
 		net_lwip_runtime.ip6_lifetime_time = get_timer_us(0);
 #endif
-	} else if (addr_mode == NET_LWIP_ADDR_NONE &&
-		   !net_lwip_runtime.no_addr_users) {
-		ret = net_lwip_configure(NET_LWIP_ADDR_NONE);
-		if (ret)
-			return ret;
-	} else if (addr_mode != NET_LWIP_ADDR_NONE &&
-		   !net_lwip_runtime.no_addr_users) {
-		ret = net_lwip_configure(addr_mode);
+	} else {
+		/* The controller can request reconfiguration while clients are attached. */
+		ret = net_lwip_ensure_ncsi();
 		if (ret)
 			return ret;
+		if (!net_lwip_runtime.no_addr_users) {
+			ret = net_lwip_configure(addr_mode);
+			if (ret)
+				return ret;
+		}
 	}
 
 	net_lwip_runtime.users++;
@@ -901,6 +928,15 @@ static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 	ctx->netif = net_lwip_runtime.netif;
 	ctx->addr_mode = addr_mode;
 
+	if (net_lwip_runtime.users == 1) {
+		ret = net_lwip_ensure_ncsi();
+		if (ret) {
+			net_lwip_stop(ctx);
+			return ret;
+		}
+		netif_set_up(ctx->netif);
+	}
+
 	return 0;
 }
 
@@ -1123,7 +1159,14 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 					       packet, len, true);
 			}
 
-			if (!net_lwip_accept_vlan(packet, len))
+			if (LWIP_HAS_NCSI && len >= ETHER_HDR_SIZE &&
+			    get_unaligned_be16(packet + 2 * ETH_ALEN) == PROT_NCSI &&
+			    phy_interface_is_ncsi()) {
+				ncsi_receive(packet + ETHER_HDR_SIZE, len - ETHER_HDR_SIZE);
+				goto release;
+			}
+
+			if (!netif_is_up(netif) || !net_lwip_accept_vlan(packet, len))
 				goto release;
 
 			if (CONFIG_IS_ENABLED(CMD_WOL))
@@ -1172,6 +1215,8 @@ int net_lwip_poll(void)
 	net_lwip_dhcp6_poll();
 #endif
 	ret = net_lwip_rx(net_lwip_runtime.dev, net_lwip_runtime.netif);
+	if (LWIP_HAS_NCSI && phy_interface_is_ncsi())
+		ncsi_poll_timeout();
 	net_lwip_runtime.polling = false;
 
 	return ret;
@@ -1241,6 +1286,9 @@ int net_start_again(void)
 	int retry_forever = 0;
 	unsigned long retrycnt = 0;
 
+	if (net_lwip_runtime.users)
+		return -EBUSY;
+
 	nretry = env_get("netretry");
 	if (nretry) {
 		if (!strcmp(nretry, "yes"))
diff --git a/test/dm/Makefile b/test/dm/Makefile
index c926ec3958f..a869371f305 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -73,7 +73,7 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_RARP),yy)
 obj-y += lwip_rarp.o
 endif
-ifeq ($(CONFIG_CMD_PING),y)
+ifneq ($(filter y,$(CONFIG_NET_LWIP) $(CONFIG_CMD_PING)),)
 obj-$(CONFIG_PHY_NCSI) += ncsi.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_TFTPBOOT),yy)
diff --git a/test/dm/ncsi.c b/test/dm/ncsi.c
index 58776851857..5d7c68334d6 100644
--- a/test/dm/ncsi.c
+++ b/test/dm/ncsi.c
@@ -3,6 +3,10 @@
 #include <dm.h>
 #include <net.h>
 #include <time.h>
+#if CONFIG_IS_ENABLED(NET_LWIP)
+#include <console.h>
+#include <lwip/timeouts.h>
+#endif
 #include <asm/eth.h>
 #include <asm/unaligned.h>
 #include <dm/test.h>
@@ -12,12 +16,28 @@
 #include "lwip_test.h"
 
 struct ncsi_peer {
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	struct net_lwip_ctx nested;
+	int nested_ret;
+	bool try_nested;
+	bool try_active_nested;
+#else
 	bool ping;
+#endif
+	bool drop_enable;
 	bool enabled;
 	bool early_tx;
+	bool cancel_probe;
+	bool wrapped;
 	u8 last_id;
+	u8 drop_ch0_cmd;
+	u8 enabled_channel;
 };
 
+#if CONFIG_IS_ENABLED(NET_LWIP)
+static void ncsi_test_cancel_tick(void *arg);
+#endif
+
 static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
@@ -30,10 +50,12 @@ static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
 	if (get_unaligned_be16(packet + 2 * ETH_ALEN) != PROT_NCSI) {
 		if (!peer->enabled)
 			peer->early_tx = true;
+#if CONFIG_IS_ENABLED(NET_LEGACY)
 		if (!sandbox_eth_ping_req_to_reply(dev, packet, len))
 			peer->ping = true;
 		else
 			sandbox_eth_arp_req_to_reply(dev, packet, len);
+#endif
 		return 0;
 	}
 	if (!IS_ALIGNED((uintptr_t)packet, PKTALIGN))
@@ -41,9 +63,22 @@ static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
 	memcpy(&hdr, packet + ETHER_HDR_SIZE, sizeof(hdr));
 	if (hdr.id != (peer->last_id == U8_MAX ? 1 : peer->last_id + 1))
 		return -EINVAL;
+	if (peer->last_id == U8_MAX)
+		peer->wrapped = true;
 	peer->last_id = hdr.id;
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	if (peer->cancel_probe) {
+		peer->cancel_probe = false;
+		console_in_puts("\x03");
+		sys_timeout(1, ncsi_test_cancel_tick, peer);
+		return 0;
+	}
+#endif
 	/* Only package 0 exists. */
-	if (hdr.channel >> 5) {
+	if (hdr.channel >> 5 ||
+	    (!hdr.channel && peer->drop_ch0_cmd &&
+	     hdr.type == peer->drop_ch0_cmd) ||
+	    (hdr.type == NCSI_PKT_CMD_EC && peer->drop_enable)) {
 		timer_test_add_offset(1001);
 		return 0;
 	}
@@ -58,9 +93,17 @@ static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
 		break;
 	case NCSI_PKT_CMD_GC:
 		payload = 32;
+#if CONFIG_IS_ENABLED(NET_LWIP)
+		if (peer->try_nested) {
+			peer->try_nested = false;
+			peer->nested_ret = net_lwip_start(&peer->nested,
+							  NET_LWIP_ADDR_NONE);
+		}
+#endif
 		break;
 	case NCSI_PKT_CMD_EC:
 		peer->enabled = true;
+		peer->enabled_channel = hdr.channel;
 		break;
 	}
 	out = priv->recv_packet_buffer[n];
@@ -81,6 +124,190 @@ static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(NET_LWIP)
+static void ncsi_test_cancel_tick(void *arg)
+{
+	(void)arg;
+	console_in_puts("\x03");
+	timer_test_add_offset(1000);
+}
+
+static void ncsi_test_free_pkt(struct udevice *dev, int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ncsi_peer *peer = priv->priv;
+
+	if (len <= 0 || !peer->try_active_nested || !ncsi_active())
+		return;
+
+	peer->try_active_nested = false;
+	peer->nested_ret = net_lwip_start(&peer->nested, NET_LWIP_ADDR_NONE);
+}
+
+#if CONFIG_IS_ENABLED(CMD_PING)
+static int ncsi_test_ping_cancel(struct unit_test_state *uts,
+				 struct phy_device *phy, struct ncsi_peer *peer)
+{
+	struct udevice *dev;
+	struct eth_sandbox_priv *priv;
+	unsigned int starts;
+	int ctrlc_state, ret;
+	bool interrupted, rotated;
+	unsigned int tries;
+
+	ut_assertok(phy_startup(phy));
+	eth_set_current();
+	dev = eth_get_dev();
+	priv = dev_get_priv(dev);
+	starts = priv->start_count;
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(env_set("ethrotate", "yes"));
+	peer->cancel_probe = true;
+	ctrlc_state = disable_ctrlc(0);
+	ret = run_command("ping 192.0.2.2", 0);
+	sys_untimeout(ncsi_test_cancel_tick, peer);
+	interrupted = had_ctrlc();
+	tries = net_try_count;
+	rotated = eth_get_dev() != dev;
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	peer->cancel_probe = false;
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	eth_set_dev(dev);
+
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(interrupted);
+	ut_asserteq(1, tries);
+	ut_assert(!rotated);
+	ut_asserteq(starts + 1, priv->start_count);
+
+	return 0;
+}
+#endif
+
+static int ncsi_test_start(struct unit_test_state *uts, struct phy_device *phy,
+			   struct ncsi_peer *peer)
+{
+	struct net_lwip_ctx net = {};
+	int ret;
+
+	ut_assertok(phy_startup(phy));
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+	if (net.netif)
+		net_lwip_stop(&net);
+	ut_asserteq(peer->drop_enable ? -ETIMEDOUT : 0, ret);
+	ut_asserteq(!peer->drop_enable, ncsi_active());
+	if (!peer->drop_enable) {
+		ut_assert(peer->enabled);
+		ut_asserteq(peer->drop_ch0_cmd ? 1 : 0, peer->enabled_channel);
+	}
+	ut_assert(!peer->early_tx);
+	ut_assertnull(netif_default);
+	return 0;
+}
+
+static int ncsi_test_shared(struct unit_test_state *uts, struct phy_device *phy,
+			    struct ncsi_peer *peer, struct net_lwip_ctx *held,
+			    struct net_lwip_ctx *other)
+{
+	struct ncsi_aen_cr_pkt event = {
+		.aen.common.revision = NCSI_PKT_REVISION,
+		.aen.common.type = NCSI_PKT_AEN,
+		.aen.common.length = htons(4),
+		.aen.type = NCSI_PKT_AEN_CR,
+	};
+	ip4_addr_t address;
+	u8 id;
+
+	peer->drop_enable = false;
+	ut_assertok(phy_startup(phy));
+	ut_assertok(net_lwip_start(held, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	address = *netif_ip4_addr(held->netif);
+	ut_assert(!ip4_addr_isany_val(address));
+
+	/* Lose the enable reply while the original client stays attached. */
+	peer->enabled = false;
+	peer->drop_enable = true;
+	peer->try_nested = true;
+	ncsi_receive(&event, sizeof(event));
+	ut_assert(!ncsi_active());
+	ut_asserteq(-ETIMEDOUT, net_lwip_start(other, NET_LWIP_ADDR_NONE));
+	ut_assertnull(other->netif);
+	ut_asserteq(-EBUSY, peer->nested_ret);
+	ut_assertnull(peer->nested.netif);
+	ut_asserteq_ptr(netif_default, held->netif);
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(held->netif), &address));
+
+	if (CONFIG_IS_ENABLED(CMD_PING)) {
+		/* A failed ping attachment must neither stop nor rotate the held MAC. */
+		ut_asserteq(CMD_RET_FAILURE, run_command("ping 192.0.2.2", 0));
+		ut_assert(eth_is_active(held->dev));
+		ut_assertok(env_set("netretry", "once"));
+		ut_assertok(env_set("ethrotate", "yes"));
+		ut_asserteq(CMD_RET_FAILURE, run_command("ping 192.0.2.2", 0));
+		ut_asserteq_ptr(held->dev, eth_get_dev());
+		ut_assert(eth_is_active(held->dev));
+	}
+
+	peer->drop_enable = false;
+	peer->try_active_nested = true;
+	ut_assertok(net_lwip_start(other, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assert(!peer->try_active_nested);
+	ut_asserteq(-EBUSY, peer->nested_ret);
+	ut_assertnull(peer->nested.netif);
+	ut_assert(ncsi_active());
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(held->netif), &address));
+	id = peer->last_id;
+	ut_assertok(net_lwip_start(&peer->nested, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	ut_assert(ncsi_active());
+	ut_asserteq_ptr(held->netif, other->netif);
+	ut_asserteq_ptr(held->netif, peer->nested.netif);
+	ut_asserteq(id, peer->last_id);
+	return 0;
+}
+
+static int ncsi_run(struct unit_test_state *uts, struct phy_device *phy,
+		    struct ncsi_peer *peer)
+{
+	static const u8 probe_cmds[] = { NCSI_PKT_CMD_GVI, NCSI_PKT_CMD_GC };
+	struct net_lwip_ctx held = {}, other = {};
+	int i, ret = 0;
+
+	sandbox_eth_set_free_pkt_handler(0, ncsi_test_free_pkt);
+#if CONFIG_IS_ENABLED(CMD_PING)
+	ret = ncsi_test_ping_cancel(uts, phy, peer);
+#endif
+	/* Channel 0 reports link up but never completes discovery. */
+	for (i = 0; i < ARRAY_SIZE(probe_cmds) && !ret; i++) {
+		peer->drop_ch0_cmd = probe_cmds[i];
+		peer->enabled = false;
+		ret = ncsi_test_start(uts, phy, peer);
+	}
+	peer->drop_ch0_cmd = 0;
+	/* Even one command per setup must wrap by the 256th attempt. */
+	for (i = 0; i <= U8_MAX && !peer->wrapped && !ret; i++) {
+		peer->enabled = false;
+		ret = ncsi_test_start(uts, phy, peer);
+	}
+	if (!ret && peer->wrapped) {
+		peer->enabled = false;
+		peer->drop_enable = true;
+		ret = ncsi_test_start(uts, phy, peer);
+	}
+	if (!ret)
+		ret = ncsi_test_shared(uts, phy, peer, &held, &other);
+	net_lwip_stop(&peer->nested);
+	net_lwip_stop(&other);
+	net_lwip_stop(&held);
+	sandbox_eth_set_free_pkt_handler(0, NULL);
+	if (ret)
+		return ret;
+	ut_assert(peer->wrapped);
+
+	return 0;
+}
+#else
 static int ncsi_run(struct unit_test_state *uts, struct phy_device *phy,
 		    struct ncsi_peer *peer)
 {
@@ -97,6 +324,7 @@ static int ncsi_run(struct unit_test_state *uts, struct phy_device *phy,
 
 	return 0;
 }
+#endif
 
 static int ncsi_check(struct unit_test_state *uts)
 {

-- 
2.53.0

