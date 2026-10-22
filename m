Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF89606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RSBN+pQF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MbSLURyx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E35A812BB;
	Thu, 22 Oct 2026 19:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qX8WbW214X_F; Thu, 22 Oct 2026 19:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A601812AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698085;
	b=RpcAYZpH+VF3cXKPY/TuhuvMeesprot1aXgvVsI75EE5lMOtD4DcQk07a6v3Ullswndb
	 KXVFpTRmxkJ1K08DlBtrc2kpqdueNYnY05A8csKPjzf5Za8hhlTKDDME3usBhlFKqd11x
	 SwVpBv82CkHo4Dr3BLK/YTISbknerCJ7+OQN3pjxUaAVY2xVTcFPmKboDuMfmfkJTPCsk
	 mpYAiOmk1ClcJynVc5HcL3mTqhrBBvFD0CWMyQBRv2LiZy4UkUM9ymHmHV8qTlIn5aFj6
	 pqLeCnPb3uacvEPcVsvu0ZGhOt2YsS0tkin4AyjAP5kbfSz+8fUANAq8gWe1zqu+w2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vR0ULZEuVsT6THagxO2xoYSjbZXYrBGWU42JKXxh5/k=;
	b=ZXepJlLfxHRpaptcZQ+rRmxO1owA8Z5LrF/QrsR+YMvMePtlvznoAISAf2k2P7/k4DgC
	 VnRtlwlsOgI4dexpryMSm12L1sjSahci8C3UQVip6g4/H+wEnNxihyALD9PYjQoBL66Fy
	 6LGPXywMtFDNNiQEICl8JM3a6NhuyIxiKXNtRj4dJUJghl8bXiLoRYaE+PcaTUK7XLzlf
	 UboKoLH5uerZn9X21Oqe5BAqFf6gandYKQg0Bu6HU2zRTeGpYX2X2+dATMkeKzHglnpNu
	 f8Ec1N4Xy18gQmB4s2EZACMphemH1hpDLdStJnIvVvO+5AptvT+8P9IUowPvhiVbXWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698085;
	bh=vR0ULZEuVsT6THagxO2xoYSjbZXYrBGWU42JKXxh5/k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RSBN+pQFWqV1SSMNmFHldPGQBykmF21aOdpZVolXurffwOtDADSP6gvswK2IPYM63
	 X16vaAqis5rp6vlFp0npbMkKaStwluQqc2sHnxaFgyXjTRSYRgYH6KV7pYR3fOfYgy
	 5g2QdQpuTlgjb4727m08Eni6lDoptakFHq9GHtvAT/Nbp2aHidECCX6yoQn2rWuDhQ
	 grBQ1aRZguHuYtbwvk1SeupN0cbgv+DVAiAnLgnUtRbTHkHwhU3K8+aAdWXNMNXhlz
	 syT/tjyk66PJTxp/sCUKLMCaS7w4dSwfG0XThXxZdJV1apD9YERr4iUmgfY/rRwOQ/
	 KfvyjU/BxqViw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A601812AC;
	Thu, 22 Oct 2026 19:41:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AF543A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 770296080C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUUovVxqTcie for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9A9A60816
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698078;
 b=Q0B89ZKYib28cPHg7dqRZIJ9PZj9qcAYzztsEi3zgn2mHPkwI3ZJ7vEM+4v+3NNjar57
 GcbobL8WTGDCDzoZzENj6ad2mirKHTCLYyJ+Uu4cIXuPdwf9N5msGd/ZZPDOePwAi6AFf
 Tuv47owceThlYnKPkpzmrIa8LA12Vhp8l0xmfCebBdAbe9Co8qg1+4bZJ5z3bQVzEWJp+
 jn88wpl1B6J4sW8UJz4vig0/mSMwdNJ+DWYYg4oIwdYM6N1QIIrKFYGrlRTxA1JSvyoy9
 Va3HbiDhOULiaNankfRulIabzjADuugY5iIbYpMzso3/d3n/4sRdkpIV5L9sflU5OwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698078;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vR0ULZEuVsT6THagxO2xoYSjbZXYrBGWU42JKXxh5/k=;
 b=qd87ixGdzWYs0FUm5WlDGWiYylcrvaK01ePIQsOfgNunFtZvNQ8S/pU205EnqtHAHIdo
 fIXNOS0lHJlYkRlar8EutCWvf1VmvkCZt2AufBzMj7TfgtH23s6Fg3C7Irlb5KN1FtjoM
 b5ugxfwDNXHsMTiwvfz7lf34UDBkITJtc+w8yKw3uZ6Ex76UH75lcprQ55LGnkQxQbhFX
 Oyy1kFJXn8zqE2XZZNGczp4CdHR1lb9ON2PX/UBAEzwdnK/yOkcXsdav++qoHgvwhXyJs
 TVMwkw/2Wry8wQl5zRoLLdytuPpKwx/d+4smC+3fLK3pmKokKnzI54I8qvJCCDqJPsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MbSLURyx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MbSLURyx
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9A9A60816
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:17 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so1461235e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698075; x=1793302875;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vR0ULZEuVsT6THagxO2xoYSjbZXYrBGWU42JKXxh5/k=;
 b=MbSLURyxXBn/dr3bNkxqmjxBuAF4QML1OTe2Vn3nVc0jx5AM40lEoUqIjuYoKnXj/K
 MhrTsKd2Tx1nT+nv6gcKMHVtS/2uc+cjNltFcdMDxB/pLqRBZekxXVf6UaNu2WH90+JV
 /rvetdRd+1K5rPC6+g0NHqiEkJ6VuZ6hmJyF4OPDk/HurbJTrAtuQqKkEukyigx+9UPW
 g4bzkTOKT9a4zVQk9cEnM+3yn0HYWOmFlcpn/N3hG+G/eRUKU6HCNSg97IbvYY09cSFw
 YTlNK+kvnrwuuPWTWWxR6vxDKhJVH//KphJ9NPQvgFfq5PG4mu9r6WJl43l/c3LT0/14
 D1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698075; x=1793302875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vR0ULZEuVsT6THagxO2xoYSjbZXYrBGWU42JKXxh5/k=;
 b=IRaXmaHRfI+PCDPlION/lnLR7ODKeZpRBLpxy88G4bT4F4y4e+2lYh2vfJhCFSY8Pk
 bw+WkgGsKgXeQb2TxK0OV6zUcuhOC+m6WO22Kv3lKT760/HlwAEtY0QbDg7HqvRZxaO+
 2EH356Y5C50Ej82QPnicO+64E2S7WDcFL2IsLpceFZYcM6QtHYCy4xo+eBfvFVnxhYXt
 ppRcQPnYlU34Rv8+bWZbfp5GLDcaVflNfm5cA+RWzo6o8CPNSZ7pNt5VvWux91F+gx6h
 KzDkYRLfrEFhS6eAOPZZB6OVmWc+1EACrl2mQ3G53obXNveJniYuFIteKqbh6IePdgh+
 OjbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRsyib5TtmiHcyZRjKAI8CvsiOJnlH+czTRw4jidrWJAf5ki4GbKQ3zmt1WgPnQDQzYPb3t3Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLnamOwkp2UD94oUQNeRzwXUZADSe3au6sP/U0tv0tVFHn+AauF
 pEmDCrBuVHqK6iXKwt+9OFr6FAmtnw7iKC7aBt5LmcZqeRjBtgifRAMu
X-Gm-Gg: AYBFou2ri7/k5hW3eSeIsMv7drmkPHH1ylNthG7iZR22KDCsu7lfH3VszDviDeJQ9YW
 bylJZmKHXBLOyk1oJZQjq2ttfP0c+FhNkR90tgomnOIF38uKrQKuztuhNuYZzDo2wravX6olZEi
 agcn8WhWsQfSWzu8bEaT1Chd5zVMkYRS3kK+qNTB+m+3QWEDw5J1+DBZStm+S151IpLDXy8N4WN
 kopx99O/sMCvSmxEhnc2TfJXLS/6KuYuOy1D6rd0TLx46MWceq5GJxKLuY6uQky1JZ5w1jg2umQ
 Xgv2OhAex8FgNLnEnfnB3u9Ik42WKfKijtnlZ8JpjVmvNyfw+zZiZN1atGwWw0eC6fPyB0Yrmfp
 fBUSK623Ck47Jn+GIO91t2lRSZj8sAWygD8zTXF1RUFy68X1/0Lzcr7yzA1NvstxCUuBxSCtmPM
 pA9yZOqx1gtDrP8borzQE3RKP4uIU8fagRYqbbrvbWg/fCOPCNLSds9xGChA4/aUZ7+Z9Ukuv27
 UW/1GQC8+MW6I4GZC9dCEy9xc0mSjSfIBpOc2bcBvsnSvxy3ACd0MAZ07pjBT4Jt2Z27e6DtoCF
 ocXtkTFxvS9wf0+wd80rbAWCaMxXvrEgoUEiwbqOco8B339DGIRm3btjpnaz
X-Received: by 2002:a05:600c:4f90:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4a211bb82ecmr2514895e9.0.1792698075487; 
 Thu, 22 Oct 2026 12:41:15 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 6/7] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Thu, 22 Oct 2026 21:40:41 +0200
Message-ID: <20261022194049.670889-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
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

Update documentation for Generic Firmware loader to YAML schema,
generalize it from FS specific and add new property and example
for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/device-tree-bindings/misc/fs_loader.txt  |  48 -------
 doc/device-tree-bindings/misc/fw_loader.yaml | 126 +++++++++++++++++++
 2 files changed, 126 insertions(+), 48 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
deleted file mode 100644
index 542be4b25a0a..000000000000
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* File system firmware loader
-
-Required properties:
---------------------
-
-- compatible: should contain "u-boot,fs-loader"
-- phandlepart: which block storage device and partition the image loading from,
-	       this property is required for mmc, usb and sata. This is unsigned
-	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
-	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
-	   required for ubi and mounting.
-- ubivol: which volume of ubi the image loading from, this property is required
-	  for ubi and mounting.
-
-Example of storage device and partition search set for mmc, usb, sata and
-ubi in device tree source as shown in below:
-
-	Example of storage type and device partition search set for mmc, usb,
-	sata and ubi as shown in below:
-	Example for mmc:
-	fs_loader0: fs-loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&mmc_0 1>;
-	};
-
-	Example for usb:
-	fs_loader1: fs-loader@1 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&usb0 1>;
-	};
-
-	Example for sata:
-	fs_loader2: fs-loader@2 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&sata0 1>;
-	};
-
-	Example for ubi:
-	fs_loader3: fs-loader@3 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		mtdpart = "UBI",
-		ubivol = "ubi0";
-	};
diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
new file mode 100644
index 000000000000..0a99509e0881
--- /dev/null
+++ b/doc/device-tree-bindings/misc/fw_loader.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fw_loader.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot Generic Firmware Loader
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Generic firmware loader for loading images from block storage devices
+  (MMC, USB, SATA) and MTD/UBI storage.
+
+  The fs-loader loads firmware images, while the fip-loader locates a
+  Firmware Image Package (FIP), optionally at a specified byte offset
+  within the selected partition.
+
+properties:
+  compatible:
+    enum:
+      - u-boot,fs-loader
+      - u-boot,fip-loader
+
+  phandlepart:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the block storage device and partition from which the
+      image is loaded. Required for MMC, USB, and SATA devices.
+
+      The first cell is a phandle to the storage device, and the second
+      cell is the partition number.
+
+  mtdpart:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the MTD partition from which the image is loaded.
+      Required for MTD and UBI devices.
+
+  ubivol:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the UBI volume from which the image is loaded.
+      Required when loading from a UBI device.
+
+  partoffset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Byte offset within the selected partition where the FIP header
+      is located.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - phandlepart
+
+    properties:
+      mtdpart: false
+
+  - required:
+      - mtdpart
+
+    properties:
+      phandlepart: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: u-boot,fs-loader
+    then:
+      properties:
+        partoffset: false
+
+  - if:
+      required:
+        - phandlepart
+    then:
+      properties:
+        mtdpart: false
+
+        ubivol: false
+
+  - if:
+      required:
+        - mtdpart
+    then:
+      properties:
+        phandlepart: false
+
+additionalProperties: false
+
+examples:
+  - |
+    fs_loader0: fs-loader@0 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        phandlepart = <&mmc_0 1>;
+    };
+
+  - |
+    fs_loader3: fs-loader@3 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        mtdpart = "UBI";
+        ubivol = "ubi0";
+    };
+
+  - |
+    fs_loader4: fip-loader@4 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        phandlepart = <&mmc0 0>;
+        partoffset = <0x100>;
+    };
+
+  - |
+    fs_loader5: fip-loader@5 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        mtdpart = "ubi";
+        ubivol = "bl31";
+    };
-- 
2.55.0

