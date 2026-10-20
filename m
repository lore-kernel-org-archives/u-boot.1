Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B8606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uHRXsgEF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33D206081D;
	Tue, 20 Oct 2026 05:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqJvWFdacEOU; Tue, 20 Oct 2026 05:49:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A3426081A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475346;
	b=dY0PPbj2chc8gGk7XL2LWBSAERbdXvrz8IrriX3ASwwj5z3ofj85A3/mf6J1yb1bawyG
	 cDPa/6wCj4agvalLwjLgaD79mTLZxy/+8zSY6lb7w/FWjHWvPz9sqFvZ7sqHQ61stkDl4
	 hMUEBKVZ5XF3K/VLB+sdgbpUiEgP/fEk+N0TtnqnSxLeVJvYrvqCASG14sHOpKb3K5gSm
	 tbW1sXqVGz66WwLxPXGMAXF27/Esm+g9g9+yS1y8s9r3FePDNTvFhY7pDzLpDIpOecjVq
	 pHsmOhmcHT9RltnTUEQYSu9iqhCzmXghMQ2rWF0erOfoMIJWn3x8ZNbT+cOsFp9o8KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Virus-Scanned:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y/xyNxSWPsm/1gKKnBCMtr55Dqk2cxeYIWCUE9D+PZ4=;
	b=U6blGAakolGMfOfT22/PogZBzGXVc7Atnf/ZexGmkZlceBqKHnkPvASlJ9W3EwAtvwQv
	 7kOdQHuSL/kxVUzocezINDSsN0rgWabmlgI5+fKiqOdHRoT4c1D40OeWAjOEbA23Rbm7W
	 3QBzT973Uo8ZHcI5MrK/+VytFrHNTcCztJIkj0HONT4x4HJEwHMYAixrzjrad6ceFz+Eb
	 q18BynDMTgKMxrLC86egOfRJElbWGSA1du/v9YGiyx/r+qveFJtBGIdTKFn0o4A0dawY1
	 oTSC1bJNcrGyZZPjJ5fNciHXLd2OW4j8femELoe9oDCWMnUdeLNxLBN3M5eZmJ8MjjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475346;
	bh=y/xyNxSWPsm/1gKKnBCMtr55Dqk2cxeYIWCUE9D+PZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uHRXsgEFnY99IcjojIB0W+wCDr30luSNt4+Ot9nsOT74+KUfGAhjQtegUFER0pz47
	 d0keRjgRHRfbm6gQhWgdjdUjEuEZZM2/NdehjprDy/v5VqzBBjg0l1fI89g28Yd8f0
	 BK3LIRatdDBBVxxG0yW0fE36Gl7Vq7KVZf2Z3nbe5y7yxE5R+EtJc04YKqFsoDFuu2
	 MkPGvO6DUPzFkQo6eda8ugCOfBRsLHl85dB+iyoaulKcV/h/Jvz7+HLBKxq8eU5Wbm
	 /4KjbsrvpV0qkaO79ytVyKOKImnlns/4YhWXe3XUAXx/YhkruQD3QstodssfBD3xFb
	 Ude6ATGEIBZqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A3426081A;
	Tue, 20 Oct 2026 05:49:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63F4B1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55998400D2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I7pubvzhJ8JG for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:44:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DFB054008B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792475052;
 b=YCvlD35+NTxYaq8sYjNB0jbc/JPpNZnL2il7RRxLFn3LBsxV8oPhGqZtA2lqo9wrFm2q
 7JCZiViB94FEmvM6A2Jetex1MG57L25OuwYW7y4nLXj5geUF7AQBdw1ayA75MkFwW6Vt7
 RjMBAzvbcEY5tGyy5AYBiyIxbw4joqikk9uc5oRQ0uvI/J+NlFR+5fLW048uYAfbz0BwI
 mB8kuOuK4XKLIpCV4vvZdOca/MQB5DRjy18h5j0xp3IyQvN7nELpBcJ6owPs/jaRtWNpe
 DL8KZ6MM1x4k8TYt71C4nC6BLJJNsBLvxSaTm06iGn+vANWczw2G6tbZtIfmlHxj2EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475052;
 h=X-Greylist:Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=y/xyNxSWPsm/1gKKnBCMtr55Dqk2cxeYIWCUE9D+PZ4=;
 b=kw3RxOXC4650THTdV+x5C+/thnQYTuu4XAIJCrtzUG7bIV44zLA/eSpwsNYGpSRyED0V
 Tem75eticoJ2Jnd8pkR7f86NUJkS7s0GNNwIZgBOjgMhIzco3OfZ1wMKz7OKOLAz8Ie/2
 1pgunQTiIVAeVA2UalI+cigrea1fHF6eM3Eo2XJu+tXvEij+/DrTmUmq5S6jf9jLV1aJ3
 NjlXBGeuBbJJ8covq9GSrYtpchMR4SyUNoy5ok6gX81/nU68CcZyBOfUaH1t4dxlXzgxP
 oLK++IY3XqYnqlwWPZupPkQKRN4DoGkGTZHgyzXVNOcWfPEZdJ7+dHBg9Ej31f9FtyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 arc=none smtp.remote-ip=92.121.34.21
X-Greylist: delayed 573 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 20 Oct 2026 05:44:11 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFB054008B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:11 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FA4E20007A;
 Tue, 20 Oct 2026 07:34:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CD6F9200071;
 Tue, 20 Oct 2026 07:34:36 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D9D1218000B1;
 Tue, 20 Oct 2026 13:34:34 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Tue, 20 Oct 2026 12:25:08 +0900
Subject: [PATCH v2 1/4] imx95_frdm: Enable remoteproc for i.MX95 FRDM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-frdm-imx95-pro-v2-1-09b188f16738@nxp.com>
References: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
In-Reply-To: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792474473; l=1181;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=0Tac/P5Dspoz0TbJBErkq/+pUqJKRTfhPmOqWIOkWnE=;
 b=+cy/AZKOp/BI4dfELOMJko3BkJ9zIZUfqCj2MaqjzCDFd5uf3iXfmb+Fw0AAY9xnPakrKYIMa
 repxzhXT0krBuirNMhwe0rm2vNF9Fg+yZ3IDQ91EC0d1E1odpTsM2b8
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 20 Oct 2026 05:49:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select remoteproc related configs for i.MX95 15x15 FRDM
to support manage CM7 using 'rproc' cmd.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 configs/imx95_15x15_frdm_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/imx95_15x15_frdm_defconfig b/configs/imx95_15x15_frdm_defconfig
index ddf25da551c625196005c3f4ddb09bb5d0fff289..3b631b8ba22f76ec71cb49ba0fdae6631b39fd02 100644
--- a/configs/imx95_15x15_frdm_defconfig
+++ b/configs/imx95_15x15_frdm_defconfig
@@ -69,6 +69,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -101,6 +102,8 @@ CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_ADP5585_GPIO=y
@@ -128,6 +131,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC_IMX=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y

-- 
2.34.1

