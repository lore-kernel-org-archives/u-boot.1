Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3E606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qItWU4W2;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NbUn2qw8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 191D740850;
	Mon, 16 Nov 2026 17:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eF93Vdu_FhuL; Mon, 16 Nov 2026 17:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C9C240829
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851009;
	b=XMN4AZbHxQQ4oYy4/OLtmkAMHdHo3cbd2MRhthoWUazc9snmdpDRkrMK/p5lyKrfNpJJ
	 6yl2pXqaKs37LF3YNWq/mvvR2Be5SSM1qUOim+9rP9k/wmXSx2yfWkz8K2dTh1LEcxB9n
	 h2tEqdoIVJJFrd205t76DbZjzSUaPhSeoByO+3JH/ug5RKMiCkE5YFdf0AXzLNHlqJtgk
	 NNn6Gd7M7s5KSXQeMbUUsZoccjviu3waYABex88Ru9tcI5R7f04HuI5uZwoWSMQW6WE2l
	 ujh3+IT60Yk6dGPQRLoFK5eCm4J96oi9zJYh9Lln+EEwBXD2zUZwgA4OfjS3a6qaMwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aCzqIjhKD+dT3dQsJYRZxurGorgcfk82Jp6ZaUUrD7I=;
	b=pLobTIghEdGHPGfznBdPpoT2yglv/Yt2KZlEQRWRjQrsYK9BzozUE1IOmBN3UPFkMMvK
	 Cu/Bj5OBF6xbVCPXkzXWeNuJlnkH/5RzyzQrHYIFtue770gZotOCPWa3qMG0a6O+mzazz
	 m7HcrjmPCY74u+e9lzaHonLgM7btUMLWEZm8SqOil7Jo3XrzGktA5xbM96gZUn9edbA3L
	 R66hW+IKJPxz78qA4w7GTGCymU+HY4PAriCNGdfi7Yh2G60CCc2YYhHnmb7VBtK7xgE+C
	 65utZnRGcs/TBYk8wfWxQ30jgQpx+3+zSJY+Rnmh/pissyPAvnYVLxxQ/7eleQ0/OPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851009;
	bh=aCzqIjhKD+dT3dQsJYRZxurGorgcfk82Jp6ZaUUrD7I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qItWU4W22EqnmMN/Ptm4NZAELoIjPGv8SZ88/r+Fyg7gD010nI55cqWhoSFhb8c6C
	 6jGhHz5Vijfrj5AZ/4sfw4EdZe4b/GcQ2ezdassMwZKXxdNpj+gpGPNh7Xm92Obrfs
	 tqkurbVusyTbUyLJx4LQakddKmCLf56b4Ccpbqqysjs3ivRtCbsKrgwrYoljn5DqGL
	 EPN6MkXSzOQVWXegw/3S/ui3KcJLlzrbVuqNclADLgtwMNCumzySLXu5k+wuB5smJp
	 TkihKcAir3CwR0FBB674m1RTiDZvAtdNfHgRI8fVUGqYxWKjZdCbjvPlvsJYNGq2Q1
	 h2eTABZDbRFEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C9C240829;
	Mon, 16 Nov 2026 17:43:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDE0F169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3F6D810A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ULIwOIgwxSki for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1173A81063
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NbUn2qw8
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1173A81063
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:26 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSwFR5z4TzKr6F;
 Mon, 16 Nov 2026 18:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794851003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aCzqIjhKD+dT3dQsJYRZxurGorgcfk82Jp6ZaUUrD7I=;
 b=NbUn2qw8Bbv7JGEKNLnj9wHQcdVJEinVUey6h3hZfF3bJeRbm66JXHzpGaPgpo40nNhojX
 QktT+afPM6sBfszmz/0ehOCqZIG5CNkDjP0qdNc7htA6UTpSR+EUTPhyDDncsy61Fzg6zm
 M/oou7mts5NfOttdQnLGFyQSeHaIwqdxwWhU7zHOuPfaOv+2WWlOsHbwH2LbmfzvDvvWHj
 Z5STKEOMYMFmYIsbH287/KUk1lBXApZdWHTxEUz3qvCt+302C/32+6Wq4WHKgaBQz/ZSNH
 A/S9BwPplH+MWqrk+Y/A5q5YO7ml+IuLcZcWAmyq0/fRVrVrbjijm0TVVZjHqA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH] spmi: Constify driver ops
Date: Mon, 16 Nov 2026 18:43:17 +0100
Message-ID: <20261116174321.3488304-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e32def9052b91dc5d2d
X-MBO-RS-META: p5eizfffojk9yfbpkinpcqqty7kkfhft
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spmi/spmi-msm.c     | 2 +-
 drivers/spmi/spmi-sandbox.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index a665850cd65..9ff5c151691 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -246,7 +246,7 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 				SPMI_REG_RDATA) & 0xFF;
 }
 
-static struct dm_spmi_ops msm_spmi_ops = {
+static const struct dm_spmi_ops msm_spmi_ops = {
 	.read = msm_spmi_read,
 	.write = msm_spmi_write,
 };
diff --git a/drivers/spmi/spmi-sandbox.c b/drivers/spmi/spmi-sandbox.c
index 1a8561b3aea..0fe4e6ce2b9 100644
--- a/drivers/spmi/spmi-sandbox.c
+++ b/drivers/spmi/spmi-sandbox.c
@@ -104,7 +104,7 @@ static int sandbox_spmi_read(struct udevice *dev, int usid, int pid, int off)
 	}
 }
 
-static struct dm_spmi_ops sandbox_spmi_ops = {
+static const struct dm_spmi_ops sandbox_spmi_ops = {
 	.read = sandbox_spmi_read,
 	.write = sandbox_spmi_write,
 };
-- 
2.53.0

