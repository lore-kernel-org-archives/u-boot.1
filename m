Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB6CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E6BB811B8;
	Thu,  1 Oct 2026 21:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Wl3WgGuENhy; Thu,  1 Oct 2026 21:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 497E881196
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889890;
	b=lXy62gVRoyYS1UdCFkvrOXfYb0ho3wcboFBDM21v+CZPLa18pBL6JUdPqwZBMKx9/ij7
	 h4HkJcJDHvb6S3PfoZZIIBJr31SpIHltgiE94szQMaeLZxKzpCZqDmtjdxPuMTNWdLKbP
	 Dh4uhdEUPF7NCtiTS7QO0zh+mNUtSAIJ4PNIYnmKH0HdmdSO9I1Zi0tbQE4kI5iV26OAI
	 kaxUJFTWVVmyW8lyTlKQhohStxrO4E5Re2oO+n+VEznC93I1goPPQI9sQR4Eq6C/JDte4
	 2eFxDY+xGBUkcVrHiuKIHSObm+8g3DGa5Y3jaz8rFGIBQxEgmQhR0jo3825/SqGE5YQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JKZionR+GOkxSbaSI1pET3odi2R99mR28LI6wcclo1E=;
	b=UTRvfvvujM9CawzrwC7IRe7pO9tPZNl8RzpbhB7BzSMRmeM5Yad8pWkF5cdqD0H2E6Ks
	 BEfRPL+DxYfHAFXZcdFqJlQl8yMc4zTvoWDaWNrPo1eGNt25+ylVkevc7uJVzuesofb34
	 U6np9QXGvbz4ZBl/3C2WDbIjLsMU065oNS8fDVe4Dx/2AAoMxW6HEOTGumUag30doBcHq
	 onTJgyuDOQ2+TVcEau08zS2WqQje0uYiKrjPHv3At1TFyS1F44/mS7y2uL4zXKvLAR+yb
	 VxJlEKmxCDzldhUaQNyYoFo/EIPgfaBCPViRH36lsnfR3xNgZMoCkqnsYCXDJNQr2rQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889890;
	bh=JKZionR+GOkxSbaSI1pET3odi2R99mR28LI6wcclo1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LVTrMEfzrEH2hWw269sQ0i5G1YqMWl1Eu4XlLDTVsqvFWAn7JrYk0RnGgjef76gnt
	 v4vuhBpiQIyEXtNBKCZ/TLaqrCFrIghMIFgiVJilu692De3s919cKlbENgjeBd0pYi
	 zg8VmXWL8aQeKskEq0m53V741e7kWB0jGcPO3dSAk2p7H98UkTTqK4mMKg9ADGiR8b
	 tpu8MHkGoKyRIiJT8Ps0uRAMPE4rboMeABgSq6a7Yn1NjHXNfZMHS8HCwk5YJHhegt
	 10B91o/10fqNR6wOptDsNCOunGdnpGXN3Vsz3VJffYNPV+wd603waQdWqaH11cGo2V
	 cGvVpGxQQ1I2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 497E881196;
	Thu,  1 Oct 2026 21:24:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCC0D32F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B346840062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtXECdcvJWnP for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E810F40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887517;
 b=SYDvHjENGdqlrIwx1sPTV90jNfEgaSBCcA6BNfC5MpnjSDy+qstn94nyS3PsdRngldHS
 WpFXutAL60/V9dqDfmHyfJGy8ipGtmM7nlelUcC8nAeCY/VbOJ+OyNXMs8X1gL06s4NJH
 HSfQnmQ/WqsoeEbJMtEP6mKjfz4WzwkaGezyelySsI716uYVGKjqaKKAfpy8WShCcArZx
 yKPw1oupjtxtyFMCYb2DxKUFxX4CbgNEWHNnFeYMTg27j8xki+qPY57yeArZukc6tFmYo
 h4or0ps7QdhrojSqU9AFpIdfs/6troaxfoMQ5qHL2Aw/ZHDtOivrPZa3PU2CujLqnxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887517;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JKZionR+GOkxSbaSI1pET3odi2R99mR28LI6wcclo1E=;
 b=SNpOcJObLDZygc7l5G5gJGWJbTD8TFk2btHSdFqwUMycuMv06mBeGF0w7s2Ws0Vn4am1
 achswZ6zE1fVNVQangLCxzpFq/OYsUk9bOTiRuEz5AywpMA6vWtfV+jYtVu4Q53NFoZ4L
 7Ce49Uem7rVF0RInE8/yz144oQ5uSfzWTtnwyj3qhWBiEEGQCS0RIDeB4fUzlLV7nWSys
 G90tCaottuyr27HY3PnYi293qfr6nhmdSDZlrWzZa7xsY5Jw1IRb4Rzf44zJYnME8Y9sx
 iw8b8LKJt5TC5xA51ypTUqCITMeWXV8x1IOGA9qiOcT19wfKF8fdvvrDV5Jmd5TXfAA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="dzNT/+wJ"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::d;
 helo=mail-pj2-x0d.google.com; envelope-from=lqing2013@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dzNT/+wJ
Received: from mail-pj2-x0d.google.com (mail-pj2-x0d.google.com
 [IPv6:2607:f8b0:4864:39::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E810F40022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:16 +0000 (UTC)
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0aa9d356eso5293191a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887516; x=1791492316;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JKZionR+GOkxSbaSI1pET3odi2R99mR28LI6wcclo1E=;
 b=dzNT/+wJlENWWZAy6xJCsz+6cAI2fP2evCUg6qSFusLIpmbItqAr33oFl5nyrPexnw
 HAs5v2tPoidLtnd/AsY7nYcRjzH8O/AQpm5Rdh4RGDhL7A58WNNM62UNOSB89cSmzRaZ
 CpiVOQnsxFKUnecywLi2XM/vxA+/yjsLbitm+ok380f7YMhNA5ZmB5hFSQZjNmiqZwvM
 Yjj9ylZ0M4J/OHBZRANCKc6zShP4OLa7mmytajZQuRdyAHCAz91txH0XC0VUugpkF8XI
 6uAxLcdj5hZkKAcMKl4h+qRJoPw3MxBiSoL3U1cwzPsyOSkhlPjlax+rOp1wVY2rsLj6
 9jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887516; x=1791492316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JKZionR+GOkxSbaSI1pET3odi2R99mR28LI6wcclo1E=;
 b=vZb1LsV/436K4btNG8C//BqJDGXWL94Fy1bdVQ9ZOye5+cjetdG6MZNwP0zkrV4WtU
 48aGcz7wl0KWfPxvDfBro8wsOstLrxYqVnHT/AC4ezTXzNCCEaN7Zstz1EH+Q3itA1wk
 FIG9q1GuhnulTn4EysMrN+YnW0bgY1On8PEEluZcBOvjufAF8ReVMcY8i9BLyD8jC7ZU
 Xbo0Rwr5bpb7lPF5KahV0AjCa3YZ9l0Z4vjtYy46Pc3zMXG1epCK5W53FhE5TdXNFFHC
 1Piu3bRbEpqWSWbJTKuOpP7zAE+gFOYu8k5kwVOT8HJGSp+dJEdUyqK8mgbqu/oOY6Bp
 2APA==
X-Gm-Message-State: AFq9FYJe8cGvEh2YiAd6YuCL5s/ZC6avZQoaYPL4XBHQWooQNNxYe0Ku
 lc2HX3sgNhPuNq88dqelGHnU6jmX+IsOmK1iULHo58HTxttHYy+ePlh0DuDVmMrGi0hHQw==
X-Gm-Gg: AYBFou1GjeKyE/WikJJ1RXSe6Qs2sgpABhG1M9U+2TrP6saeuxwtTPW9IWQW9q3SUv3
 43tJWv39a+kdilauPpQBfgD9y2/lpEMvBQeZW0ScjPQ4pkpM1lFlnQqX/bZg6Z/NdAGuwVk91yE
 SpzjnXRM23iGZSYz/Op5TtpCfOtb+Hr8Hz0jHQ4YTvYU+U5zPgjDExkyPyOPV2KpqHZPZG8yw2U
 hAss/aKgskuRryvx6eivjUn1SvpADv5LodeGVv4y7BivUDd+UGHY0UNw/KHzB33tiQ036Yt5XAa
 QEmRLoUuLfKPZNdyw6kQVCI8JrNER/Vzl4XkzdWXC5hXxa6xFtkzQJpayxNS+Or1f5KEsX1Zs2m
 6H9fprdwvUrOzmqvpsbfp0kYfiLgIYH3rJqf4jTbAn0uNsJfGSOREhbqi03xYjbLPBvz5FyyxcI
 BhAAEe07m12QnGJFEIp7MIHKgCK3FKhx8VEFZu4X+n8j11RkX/3nOSryVlUxo7AsqXIt0BMVpln
 0IV/2YwwHMW082lmd4YVMv/HCnRh6W/t4V1ug==
X-Received: by 2002:a17:90b:564e:b0:3a4:e9e4:37f9 with SMTP id
 98e67ed59e1d1-3a6ceaeebe3mr667323a91.31.1790887515427; 
 Thu, 01 Oct 2026 13:45:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:14 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/9] pstore: make the ramoops device tree node optional
Date: Fri,  2 Oct 2026 04:44:48 +0800
Message-ID: <3b407c008dafc5ebed1830c1e1e1b62d89d1aa2a.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

U-Boot adds a ramoops reserved-memory node to the OS device tree when
CONFIG_CMD_PSTORE is enabled. Some kernels register the same region
themselves, for example Qualcomm downstream kernels through the
ramoops_memreserve=4M command line parameter; a second ramoops device
in the device tree then makes the kernel hang while populating
platform devices.

Add CONFIG_CMD_PSTORE_FDT, defaulting to y to keep the existing
behaviour, and return early from fdt_fixup_pstore() when it is
disabled. The pstore command remains available to display or save
records.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 cmd/Kconfig              |  8 ++++++++
 cmd/pstore.c             |  3 +++
 doc/usage/cmd/pstore.rst | 10 +++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 049f6397a70..37b72e10491 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2604,6 +2604,14 @@ config CMD_PSTORE
 
 if CMD_PSTORE
 
+config CMD_PSTORE_FDT
+	bool "Add ramoops node to the OS device tree"
+	default y
+	help
+	  Add a ramoops reserved-memory node to the OS device tree using the
+	  PStore parameters. Disable this if the kernel registers its own
+	  ramoops device. The pstore command remains available to read records.
+
 config CMD_PSTORE_MEM_ADDR
 	hex "Memory Address"
 	depends on CMD_PSTORE
diff --git a/cmd/pstore.c b/cmd/pstore.c
index f2c0034abbe..5d1890fa5e7 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -491,6 +491,9 @@ void fdt_fixup_pstore(void *blob)
 	u32 addr_cells;
 	u32 size_cells;
 
+	if (!IS_ENABLED(CONFIG_CMD_PSTORE_FDT))
+		return;
+
 	nodeoffset = fdt_path_offset(blob, "/");
 	if (nodeoffset < 0) {
 		/* Not found or something else bad happened. */
diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index b8e2a478421..bcf912aa89c 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -36,9 +36,13 @@ i.e.::
     ramoops.mem_address=0x30000000 ramoops.mem_size=0x100000 ramoops.record_size=0x2000 ramoops.console_size=0x2000 memmap=0x100000$0x30000000
 
 The same values should be set in U-Boot to be able to retrieve the records.
-This values can be set at build time in U-Boot configuration file, or at runtime.
-U-Boot automatically patches the Device Tree to pass the Ramoops parameters to
-the kernel.
+These values can be set at build time in the U-Boot configuration file, or at
+runtime. With ``CONFIG_CMD_PSTORE_FDT`` enabled, U-Boot automatically adds a
+ramoops reserved-memory node to the OS Device Tree using these parameters.
+This option defaults to enabled when ``CONFIG_CMD_PSTORE`` is enabled. Disable
+it when the kernel registers its own ramoops device, for example through
+board-specific kernel parameters. The ``pstore`` command remains available to
+read or save records when this option is disabled.
 
 The PStore configuration parameters are:
 
-- 
2.50.1 (Apple Git-155)

