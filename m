Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A51606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EhGz+Nbp;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=OWpyJ9b7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D71124098A;
	Thu, 22 Oct 2026 01:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIk7pT2KbzMf; Thu, 22 Oct 2026 01:38:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FC8640987
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792633100;
	b=XBqPtO3WKIA0AaGjt0QXSAxJSoWxT3TBkvQjOfw8YrgKMFOC0M4/va/sVy3EasWxTALQ
	 /Pu3YWVmd1mMIndnFciAOv6/5k2d/1K/7SNXjcmPnwpiiHYNiQyn8k42Tch/MFQNY67jr
	 9Ct30cqGhlq9dKwR+xm6DGVwPyAW4GxAcM7sGtf6qf+ukPP9GVSPa/AupS62JCoyfXAOL
	 Xx2p7maPSPlZoOy1ACijmpK0cmL4lPorI+QTlMSCCNzrctbP8gscfvGjicUJcoZeHqqaZ
	 5BLhnk8LHEg80Mxqn4hxvWdmSXg5Q4s2LBTzH64aP/sicsALkl3NgRDlWUheEc4UlKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792633100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=43ojPt9FKUrCkI0p0cEJuNaY1spbRQk2R1//SHfEz8M=;
	b=HY7ZcSWggO2iKZcyGFrx/sYJA3dHoJLvFwqql02U05lVm+oLhl9mE6vd+lnYlet2LVxX
	 XKRxV8mGxB+BC3cvp4s/Gppm1LscyZ5s8jy4G0rDeeyhmvJAfMfN62x02KkL9y5NOkONJ
	 TcEa6qNitx/b8LWan9CLIQ0tWKUM5WCYtNwTWEZVtGitQ4UJd0NEgrmQvxicdfwlyZyoh
	 v2qViI/2f09ZRLFVvPJMgMs+FTWxJr7THV8dPGeTYg55t1JXn71/hQ6Hqd0cl8ALdvT6s
	 mk0JfhNkDrXcHPTMi2C5ZzjONPlUttH11q8yM6zT5PCocUR9QnAuZIWB1DtdUUHUkzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=OWpyJ9b7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792633100;
	bh=43ojPt9FKUrCkI0p0cEJuNaY1spbRQk2R1//SHfEz8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EhGz+NbpR6MUdiNHUTEjCodwqdlwtJQqHe/niRTs4SMoXZufVJZr+xLJXs4agO0dz
	 4OYdFBPtQ6j+T6Hp4UhuoNPPny2vYL8bTsH8zvZh1L+As6poQ6qSUAjtt4XjnAFK9C
	 oSsYPAI/Ka+HuGeMSnVJfG2347QVfvvLHZvQXVIyLCMnAWG+oZePqDo3ho0s2e2Pvd
	 fMXK7zbg/MMZ2bP6ZQNLWhDbEp2jXgB5K7wlM7AkoIJqbYhrQWfx2jgCBQoc3C/JbX
	 OWIQ52tjLNLAQc4zWIY7M3sfry8ZUCXwdLJlUMpsflxYlY1LMEdQshSGIyVzASIh2b
	 04zjceqX14DkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FC8640987;
	Thu, 22 Oct 2026 01:38:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C38B51AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A96954097F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZuKiVs6mqhg for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B15C940979
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b135"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792633094;
 b=EbgINRTRRoR4it5TiOK0h3Gr8gSup4AeH0x12pDo1cVSJ6587KkH1dU4yns67uVv2I1G
 I6NaAj3r61eGO5xftNNVG0P+I8c/JRqCJO6OhLEIl+s8+DMajyj3MnSQE6BBzyI2xxd2j
 xkKPyxsQVs4pLB+IDUnjlISaqhDdHOwpFVULrDn6yrpSo4QXm+T/yUwPk3nijydRvctrJ
 n+N5UpuxTA7b/9bOE/k6CBEvaqJpDvd2/pGfQrx0e2mqBIu+QjSIZgYMb42nLCEX8qNtR
 J74dsl3r6/Uah5J/Q/QJNAaKD6FifDunG8AWnAF9hbROWkIEIbSEcY2RF8KsXa5spDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792633094;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=43ojPt9FKUrCkI0p0cEJuNaY1spbRQk2R1//SHfEz8M=;
 b=au8N1qy4oZ1JdD6s9aGswhwKCcUS3KBrrOO5ireu5jfyICoBPnH/ZOZryrcS3I6i+lOL
 50slAOEKtsFl8vrprR9WceW/pGwX4Q0cUlK3Ld/+6zae/CTgeDzHaVnUfouVj4czywQcj
 y0o9Cq4eyDwmx7WtQAIGzBtYhVj0iXg4We9cQdpj1vwDNBTzkhiEQskgKKyVk59kK/8l2
 Scqysl+NCS0uHguoFI1MKjKInaEZNjhpvDgrPZLxs8h0SdFWn5TCLX3PbPVkLPbMxxIKp
 aHFg/IAWIXT0X1xIP0sDB66lXirGZ3DufDFetNtYhcGIp6vafq5vSan/Wmtt8owen1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=OWpyJ9b7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=OWpyJ9b7
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B15C940979
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:37:53 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67999045530so1185569d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792633072; x=1793237872;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=43ojPt9FKUrCkI0p0cEJuNaY1spbRQk2R1//SHfEz8M=;
 b=OWpyJ9b7jR0OHxqjrmmhRau1IVvzw++2SwrJYNV6jUHf/PbmbAc/DuQxNAjXXa1TDU
 TIgSLv1ghWfux8611Zu8ZyhUttFyrxLR1lLQWoawoxTs7Ld1MZi2BI0suomiThY8FACR
 4Tl9EMpIKhgJVGtNjr51NLy7hwEF5D2koigWTg4A5ai2EqNPWi4HrGBxK5U8qspr+UDL
 zmu84wiw/YjEAfUWX0DMrKoRiStv9MPwZsOEqsgpKXKrtlTtu0qPWI/dhLm3saZgQlxx
 ydzNILsQLhv/48T8ufXsQMo0nnd2kUfv9bkWxOrhpRJTFPD53l+lWL1AhFXPLWBpEl4S
 AhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792633072; x=1793237872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=43ojPt9FKUrCkI0p0cEJuNaY1spbRQk2R1//SHfEz8M=;
 b=Ar3CaIftPfY51jA8wAgy9nxcuLv7nGB1AwWX5eWPmAmwHybMDftgQLXjw4sDAUP9ti
 /MOU89TXiu4un6HdRx3LuqfvyhRA6ThNxfLXPyH71u2QWnRIGXf3i7iUPDhl5Aam+Ni/
 ivJiOBVKPlscQvkz8kOy8EkLTZk/iPbyIyqMgjCfXXt1Ia5j82k5BvOyeCGSmpilOh6h
 pbd2Y6N+SZyZsyukq/LDF+FJQ5Gu0EiMertvc9zLgL3LExomq5shw81+nUrYeij7jLB4
 zbeIAECC8oacAL2q5ceGcybcMEqkBjFFax6ewXORLHR9OpjomBJ1Dhppn4bymcsvLKql
 NC7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxSV4uSEinNo1hqTQtHA0Pq+FmCwC2VMg/HQGKz/n7AGjAt4/6OXol7JKvAnd44sXcEC/C6YU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL4UKywn9WVmEd0xyerkdUT3ccHPgT4xTlJodWt02ONSC9gxJ6t
 nBny7HICvLaemYIz5YXR1t6p51OUX0dneAIZnfn3m13Yk6ymc/AqeB5TUYb0/fZ3Bkc=
X-Gm-Gg: AYBFou24+vokfcgOu7knQ52xKBo7cpJyGx7RvEUgge+x61iUVa51WpfKFRTQQ2xwcYk
 efA4+mdFN2MGm9Jf7kjoOKqmk/vx4MLSseqKYEkQTe1SFeKsvK8OOf1CGt3WgY03d9UKYVFcN2d
 thqpXcd1HkjS/90UH/FXKlYcF8hp6duRfyL5R+vccrXXALxBtTtE1dN6nTcRY5Tr7sT7nq4z31g
 Fp5J8l245LExJQ2BRUDeXOfTKqH88QakyRGx3RNHhbN6N/FKYjYkiANGA2l6nl71i/O/a3ezxjS
 ySwadfIv7y5ZEvBDy2ly7COOvIjWOh6mtP50T0/I9cwVXoo/F8J/HDQPLReIpbJ1+8r6ccUYCL1
 2+gp20cC6xcB+uA+2PHgsYAbPpF4cV7esUflzHK1n4vy3dJ7BwUg4xqmRNlwQMEYST/b5G+/umb
 PyHTipAGejAsoM7FSojnvLMurxq/PtY9nRwfDP5XRrTJMw5RkVKxzDDRj9Muc8tYuO7PMPv2nLf
 LBM5CzIjI1eNYwiBRegkZnjDaF22VT2Jirjx3XlAVqa2jFSNKNdMk3S9gMFa4aaiY5uC2HmDEo3
 vEwCZOd8DEEm7ffAXSJgPkTcr7ZG/Dtm0kAvJ2yfbjhWnKAxwR5hXvxD
X-Received: by 2002:a05:690e:4882:10b0:679:bf13:c01b with SMTP id
 956f58d0204a3-67a0e4b3b26mr1280292d50.17.1792633072275; 
 Wed, 21 Oct 2026 18:37:52 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:81a7:5305:ca4c:d0be])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a0e53a353sm1933502d50.18.2026.10.21.18.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:37:51 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 21 Oct 2026 20:37:15 -0500
Subject: [PATCH v2 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-spi_fixes-v2-2-78af1e8c8c3e@oss.tenstorrent.com>
References: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
In-Reply-To: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	T_SPF_TEMPERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The designware spi driver doesn't support dual/quad/octal modes, but
the driver still tries using these modes when it sees a capable flash
chip in the devicetree. Add a supports_op function to this driver
(along with the needed SPI_MEM as a Kconfig dependency for
DESIGNWARE_SPI) to prevent this from happening and force single lane
operation.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/spi/Kconfig          |  1 +
 drivers/spi/designware_spi.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..8d87167199a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -222,6 +222,7 @@ config DAVINCI_SPI
 
 config DESIGNWARE_SPI
 	bool "Designware SPI driver"
+	select SPI_MEM
 	help
 	  Enable the Designware SPI driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this Designware
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 0df9a4f5abd..2f6dbeb1d94 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -694,8 +694,22 @@ static int dw_spi_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 	return 0;
 }
 
+/*
+ * This driver only supports 1-1-1 transfers. Reject all other modes.
+ */
+static bool dw_spi_supports_op(struct spi_slave *slave,
+			       const struct spi_mem_op *op)
+{
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->dummy.buswidth > 1 || op->data.buswidth > 1)
+		return false;
+
+	return spi_mem_default_supports_op(slave, op);
+}
+
 static const struct spi_controller_mem_ops dw_spi_mem_ops = {
 	.exec_op = dw_spi_exec_op,
+	.supports_op = dw_spi_supports_op,
 	.adjust_op_size = dw_spi_adjust_op_size,
 };
 

-- 
2.43.0

