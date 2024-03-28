Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CDACD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35816881B8;
	Thu, 28 Mar 2024 18:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UBZDeIpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1A4881BB; Thu, 28 Mar 2024 18:59:45 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9368B881B9
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33fd8a2a407so823868f8f.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648781; x=1712253581; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=UBZDeIpiEpJv5eBwrUyFcPh5y83Sscjbi6SqSGhrWV7E4Q7T6ng5F6P85SkLJ7shYQ
 2WRnp6uCy2lZkPixV+3yLplqWzXujQTZG3aZsJHA3HbDmI55PSUJ6KrDqsjguuSdKBMF
 qIEaOtRG2uFtGKOC0fXJ2M3PkusXELFZxoa2pMUYvgmw2rJcJpSmay6mfufTUlIos3E2
 39EgxwYrPswtEJsMF4MGDzbAoXEyEsLK8azbN8Mw4FOHwsghgxZh4JDBa36vWOXvvhr8
 R4MIJ0467Qox++Ov0pPJjzMOvv38nwWANo/kJuuEoWlXc8uTtY/jN1jjd2lDjputuIXD
 RnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648781; x=1712253581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=wkNVufGnhedCk/yLZq11yHqNtYUhLF6YicZwwP/naSAeqBRU4dY8Gg85/I+3wagH3I
 Wz+X3QTc2HAsp9WpZqHWVDU5838VyQN3Wdd+QAcu6CsmOhi9NNDnA5/ymgO4iUBm+Toz
 1N8UPSluPHGXhYldNyGJUMxrHqGKNupjUQsUqSHqk+/VvlovmD1BcwlOFlxLv5pfpI/k
 FqfBYm1k5iWDIHgQOaFQGeUCPdfSngxnAkXyPC22BPvrqoHq7Ap6IRG3mY/A1FVxnZ79
 axg9g/HZ3PjVzOpgmJNLIVNdkTdkyDLD3/3sR+d+/NTVyFQK+JME6xONsKgqQ7kzBeR9
 h5og==
X-Gm-Message-State: AOJu0YxAVW5LSFLHtIrvzsuGISGEcYG0l12j3hyD8Wye1nX4xRo5iJy8
 OMtnjS/qaco7bTFWHmfNzIuu0pC++VI3w/X8oSxqC5l05Nyhi/zME3ar3JBS8jg=
X-Google-Smtp-Source: AGHT+IEHI3WYDH0+XU+9LJwcKtUJeM8t0vNuMoIpyXHcywJDms7ZAwBGbt+oDa5dl29h8hb1Kj2L1w==
X-Received: by 2002:a05:6000:e49:b0:343:349f:99c4 with SMTP id
 dy9-20020a0560000e4900b00343349f99c4mr839976wrb.5.1711648781030; 
 Thu, 28 Mar 2024 10:59:41 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:07 +0000
Subject: [PATCH v5 01/16] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-1-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XSvtB4NoCXg6pY1Nq/qGGGjasqOo57hNo8/eyKot594=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZwVuV3iRkfyjmqdt4lZb3mw5PdFmQB+N+59v63Zd
 kXXLzrVUcLCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZyWZbhe5RP8ew1yWLz1CS/
 3Ej7cKPu5aKDoUXLk136LVg0dibNZ/jDefM8/9/19x+xzrf8Ifm76tQb26O3Q2wUeG5dmPTv3n8
 eBgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Update Bhupesh's email to his new one.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>

-- 
2.44.0

