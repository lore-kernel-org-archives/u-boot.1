Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA75606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kYvp9BtP;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=s6HOriWE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 499AF40810;
	Mon, 16 Nov 2026 17:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IiPWAqDCczw; Mon, 16 Nov 2026 17:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C65140804
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850810;
	b=IiKocurqKDZuy18aWCnTI1QGxJqg4Nf5vqPQaizlV4KvFoywZrGzSxhqanLjdkSHstU3
	 8h+hGTp4t2q7BGr3Fqy2pY3liwz8HoBdvglZOqxCDeinKhlrWK6uQ/ndpMf5p6WrW7yQs
	 871rWMp+fWp18B8BEPmVX1O4Xo0Ek+pSGdqXuTU0Q+/1OyV8/+i/kjsf3cSH0gcR1UKWT
	 /t+3mwSCex2ZYKrLHkgIteSmxIpRD0Y7ph4gflePL/h2jvAsO+WvtunrhwPoy47Fy4zVZ
	 LTUHA3xeO/0r9xVRgsJI5pKWmyoaxUKW5M3CH2FSmQjVn3emNIcAzM7E1TzCjZ8m9EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tKCuP7vFCsJOLrB8wyXd2f5bJOb+rii1Cn8v2Do8n8E=;
	b=fVaQZh/RY1jPcxef4yoZ6+Rmkkq8hjYN8p3QCEyIgKHZaVwz7OFB9M+syRGZm9cPFQoQ
	 Hz7siwaaBWfXxWl/YzHkOKPQQPjOiXeseTgaMj5FT7Eg6RDqP+OVuLw5XtjL8HnXu9EeI
	 F1pAjrT3A9gO84bADWUFINUhqsk1FnLYb5mMwt9Y31eQk4dgfxaem/5yt2UlFH2Y8KKeO
	 +yY4bqEn9LSG0aZXphGMF34xlfKYX9JOOahn5V/6tdXAkFd8Xc95RmmVKp2dwnPXJTex+
	 cyTG+6DLvTgiABdj3en43G1TGTwo+ieG8d6hCI56TbWu5iRtNOuxAuk/dheKEkoo2mQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=s6HOriWE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850810;
	bh=tKCuP7vFCsJOLrB8wyXd2f5bJOb+rii1Cn8v2Do8n8E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kYvp9BtPqm/vZ4W4ggiySk5gTy2jVrWjMiAkYLQu2eVyzXPxcdSBSHSz+0sxTFr5Z
	 yaLxPBr/E5AuTbrcP0QUjHR8iUpgoIgDOJF5PwVkXPkf1ol/uMnGtA2Aan6Ucqz7iG
	 Qc9qaTLo1B0KaeIkzHv2D8NBP6/p2yT+ACw/u3TJz8ZSIoOKCfv58oILveLphgD1qP
	 /6e8dOp8ywsPWPYrmP6So8ixal2bNeQEOrFxl+ovZYz/KoQmMujrG/0bMnUy1fay+U
	 1hej5ro5ywyCAt8VpXSOjb/MAZeg9NLou+YZjuRl1ZAbN11BFhFDkFTHNnRgxfQjEh
	 FLjUkXxX0Js6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C65140804;
	Mon, 16 Nov 2026 17:40:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 848624DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A8DD40804
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CszcL-gHMg_c for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC0214056F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=s6HOriWE
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC0214056F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw9c1fx9zMlj2;
 Mon, 16 Nov 2026 18:40:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tKCuP7vFCsJOLrB8wyXd2f5bJOb+rii1Cn8v2Do8n8E=;
 b=s6HOriWEw5WrX0OXEThAyer4vvWYXXes5yEb0hy1xMGXsqqsaQBozwP8o4eQpJP3zeABom
 VwZhYcKArpq/1hHZrYKa3wBOYNE7Ybv3KwgodOEOx272/OD56otuHxcvADLDwwqodspMY7
 TBQ4ca35rWYt6WenWzJtOdkaQTT45QRKumRRN9HghMNpFW7dUUUT8I0TvLVb7RlApyIHZE
 +VAun/QRodXIBRA196l+rzj1WvmENYWstkpsrchZiWTvWWqe7FCuT2RV+RMkEjCWJroO+g
 8q3r0wJEtPW/+lMdU4jWNb9pbm5wcZcRe+cvu4S3Nv/pK0nHEVf3IiRugmPuqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: ep: Constify driver ops
Date: Mon, 16 Nov 2026 18:39:56 +0100
Message-ID: <20261116174000.3488119-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 913a98c6e1723869ba4
X-MBO-RS-META: prcz1hqcnkn8bz35tr4tt6nicgkco8yn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/pci/pcie_layerscape_ep.c       | 2 +-
 drivers/pci_endpoint/pcie-cadence-ep.c | 2 +-
 drivers/pci_endpoint/sandbox-pci_ep.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie_layerscape_ep.c b/drivers/pci/pcie_layerscape_ep.c
index b7809857565..f8898b6fcb6 100644
--- a/drivers/pci/pcie_layerscape_ep.c
+++ b/drivers/pci/pcie_layerscape_ep.c
@@ -59,7 +59,7 @@ static int ls_ep_set_bar(struct udevice *dev, uint fn, struct pci_bar *ep_bar)
 	return 0;
 }
 
-static struct pci_ep_ops ls_pcie_ep_ops = {
+static const struct pci_ep_ops ls_pcie_ep_ops = {
 	.set_bar = ls_ep_set_bar,
 };
 
diff --git a/drivers/pci_endpoint/pcie-cadence-ep.c b/drivers/pci_endpoint/pcie-cadence-ep.c
index e02ea14e4e4..a57849eb4eb 100644
--- a/drivers/pci_endpoint/pcie-cadence-ep.c
+++ b/drivers/pci_endpoint/pcie-cadence-ep.c
@@ -134,7 +134,7 @@ static int cdns_set_msi(struct udevice *dev, uint fn, uint mmc)
 	return 0;
 }
 
-static struct pci_ep_ops cdns_pci_ep_ops = {
+static const struct pci_ep_ops cdns_pci_ep_ops = {
 	.write_header = cdns_write_header,
 	.set_bar = cdns_set_bar,
 	.set_msi = cdns_set_msi,
diff --git a/drivers/pci_endpoint/sandbox-pci_ep.c b/drivers/pci_endpoint/sandbox-pci_ep.c
index aa623fa357d..fb6dbea6140 100644
--- a/drivers/pci_endpoint/sandbox-pci_ep.c
+++ b/drivers/pci_endpoint/sandbox-pci_ep.c
@@ -156,7 +156,7 @@ static int sandbox_pci_ep_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct pci_ep_ops sandbox_pci_ep_ops = {
+static const struct pci_ep_ops sandbox_pci_ep_ops = {
 	.write_header = sandbox_write_header,
 	.read_header = sandbox_read_header,
 	.set_bar = sandbox_set_bar,
-- 
2.53.0

