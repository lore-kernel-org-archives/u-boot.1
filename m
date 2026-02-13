Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA18EF48CA
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DC783CEE;
	Fri, 13 Feb 2026 06:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="FBDrIx+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF60583015; Fri, 13 Feb 2026 06:15:19 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE04683B9D
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4CA5110825; Fri, 13 Feb 2026 06:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770959717; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ws29+wpNjJ5tO019O/zmKLWIAmUN1PDiHlbCDr7wUW0=;
 b=FBDrIx+4BPUbNKSybItLGuHo2dZZ/FL14grr8YIPjAmziWt5Gh1jZah0Wh4Z4RqeyPTQiR
 BrU133Lo/d8b5Vw93XmRPUXwKlArh6E4NWk6qrosIJnw8SGzDJe2g8EenxJ5vWZ8pAdyqN
 b9PbcZmEJbrsqAQpcy0oKnNO4WNwFqGVTgCYjy1vUGDqi6TDR3RPhmCkyrcDMV1uA/Hhvy
 jWNHxr+4VZAE768EwYEEybt8+Fli98fwz00qirwvymMtChg0VltPlghvC4o6NhmXnOdJ5b
 nKP7WaMM2/U1WABFuV+16r9qV4oEE+QdfeR17QM8vbWRcRWRhQ1J2FpK2jsEXQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 John Ripple <john.ripple@keysight.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] imx: scu_api: implement sc_misc_get_boot_type
Date: Fri, 13 Feb 2026 06:15:06 +0100
Message-Id: <20260213051507.23466-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260213051507.23466-1-hs@nabladev.com>
References: <20260213051507.23466-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

add function sc_misc_get_boot_type() which returns the
boot type.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v2:
- rebase to mainline
  b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
- add Reviewed-by from Peng

 drivers/misc/imx8/scu_api.c    | 25 +++++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index d9cc7acb970..c15a4a629ad 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -374,6 +374,31 @@ void sc_misc_boot_status(sc_ipc_t ipc, sc_misc_boot_status_t status)
 		       __func__, status, RPC_R8(&msg));
 }
 
+int sc_misc_get_boot_type(sc_ipc_t ipc, sc_misc_bt_t *type)
+{
+	struct udevice *dev = gd->arch.scu_dev;
+	int size = sizeof(struct sc_rpc_msg_s);
+	struct sc_rpc_msg_s msg;
+	int ret;
+
+	if (!dev)
+		hang();
+
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SIZE(&msg) = 1U;
+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_MISC;
+	RPC_FUNC(&msg) = (u8)MISC_FUNC_GET_BOOT_TYPE;
+
+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
+	if (ret < 0)
+		return ret;
+
+	if (type)
+		*type = (u8)RPC_U8(&msg, 0U);
+
+	return 0;
+}
+
 int sc_misc_get_boot_container(sc_ipc_t ipc, u8 *idx)
 {
 	struct udevice *dev = gd->arch.scu_dev;
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
index 876d52cac35..7f4ca735663 100644
--- a/include/firmware/imx/sci/sci.h
+++ b/include/firmware/imx/sci/sci.h
@@ -86,6 +86,7 @@ int sc_misc_get_control(sc_ipc_t ipc, sc_rsrc_t resource, sc_ctrl_t ctrl,
 			u32 *val);
 void sc_misc_get_boot_dev(sc_ipc_t ipc, sc_rsrc_t *boot_dev);
 void sc_misc_boot_status(sc_ipc_t ipc, sc_misc_boot_status_t status);
+int sc_misc_get_boot_type(sc_ipc_t ipc, sc_misc_bt_t *type);
 int sc_misc_get_boot_container(sc_ipc_t ipc, u8 *idx);
 void sc_misc_build_info(sc_ipc_t ipc, u32 *build, u32 *commit);
 int sc_misc_otp_fuse_read(sc_ipc_t ipc, u32 word, u32 *val);
-- 
2.20.1

