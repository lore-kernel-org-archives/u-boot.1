Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D3EC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E2340D2E;
	Thu, 24 Sep 2026 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-IuVIgf4Ss3; Thu, 24 Sep 2026 12:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A581540C9E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253434;
	b=juCC31hLWB3Aa/iEtwShXAYNo2ryb3BxHW9fP2CUui1kLCfdXOjle+/F1oKK4nhnTL3r
	 f6f4yKL0Ks5lzrc8VDWETNspr/EqtRIf1LTOwxKT4YyPvaBbVyQow0K/P36NvDjOrn0vN
	 6jsngRgU6PH4wv+NzMDs9E+qGnxxzdpoDQnRebXJ904fbv8kzY+B3QKp3MMYbsPoqpV9g
	 /X/YQR8Wd3VU0VEbceDGMIl5k06y4pJIrlMGugvOiK+hH52DPhtj4dciSs6vLHSfqiT7F
	 /31wVjyFvsTY8o/wHuxAuCWpxVCz/6YPDh4rV5TGeLX6t6HlACezNyhX185skg7XTrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nH5rQlfzrshvn7V8NbItF7so8756MmJzn+mQUzLDYhs=;
	b=kJtKkNTPl6VbplWczi+0qI8kdV2Qm4V9LtEK8rkkWnydo+qmk38bfHZwTk1UVnIisDcu
	 cYxZc1x0sMZDAPsSJ0RfMiMi15h7qZd3uYVzdUJkCO4CLqsHtBrmnJDGJxTmfsitLFXGI
	 qGasNp/0QIOjxPUqH0VAHlTvwXd2mRYcd1crWyKeXLeD2r61FzytTo0Nam0V3MlbqPdlB
	 fWpI8hFKymnyK+dacJoLm3mfFQiwbxtCvH/l7xw7ySbQl2i1z2hYCizS6bMNaPui1fdpE
	 ZiJh4j9DmbYHgDpr5zloA5BdL0bZRWAw9snLM+BnxGx/AOlUuZ3zJvW7yWIH0D5wZeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253434;
	bh=nH5rQlfzrshvn7V8NbItF7so8756MmJzn+mQUzLDYhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nBCzuMvRVF3EfhW/CLa4TTe9X9tsU6hLVCcvoQhbfAMYyvORmh5GtWXfVcokL5CMv
	 zDqnq2UwOunbzZ7y6caDC0yogwIpqsgn+X2Jl7hx7aQFo34/zWjNGzLZuEeAvpfpbk
	 UJ7ia2NkAhDmcxnSnC8cA3/PNSsJbH/OxES/FJ/KPicbx7uwhJBFjxn1NTIw8v2TRk
	 GUWIQWelJMEErpc1elv4AuK6QGXsrA3D+WrYTBgBwBcjYbSfC7iVMIOQwWeVBHqeJQ
	 GgTR+tOy72L0eDwb2NuF7XdU+pXiTYyV5JR/kHmENn6mU7fXpSFzlHadsvribiZbiW
	 K7kCNHRIrrM9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A581540C9E;
	Thu, 24 Sep 2026 12:37:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C0F35A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0988E60830
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KKUkBNALNsn for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CEBA607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253431;
 b=kKh/p4Y1Og3E0LuZ+/K7otB6qrgqe1MdbYn1tVkqkHs+tA0to+hZIrg7SQLKLZAu6AnD
 PJtrFdEtZl+kAcfUXjNGkpQYvse1/zDzjb5ZPaz9DLGm32te+Hq8kppQKpTkTSux7uqB0
 wU3xEOEt4ci131JLDhbf0AyfJl4xPrv3a1rvtmnzqN++ALEtwJzO2/+OrE5vgOXrMSWW8
 2nQUEODlFH4ttmBpuN/fuRyHKvmdLx3rMfMPZF4rFEuDJw1oTyFv+BqBnrlDXEbSMXwB5
 nJuWyBMDekoYVMMV/ViotOhHHmtsl1hEO9FUmi5G0Q4vNuNFjDNdXKmXYjNqvorSDQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253431;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=nH5rQlfzrshvn7V8NbItF7so8756MmJzn+mQUzLDYhs=;
 b=EYNNBmp0kO4w/Vx9e1CfLYUSUvuIm4lOKM7ajDwmqoazyr1UIER68xmtdZG1tzJmKnaF
 MW7EFWmielNEYoxjYGigkDVMu/zxqDTCXpQKAjHN8DTltyYgIKKbGPJeSryVSTE2uec1p
 yzSOD26le3BB3ia49PFngHTQryYvLAnUwQQLy9ndm1SuxAY3v6ufvlIvmRpis2wKzXrOS
 GRtuvKXeBQwBPQGAPBP/Ni+DaGoPgt2Gb9y7+/j+ct5v73E3gQCqN4rWX0Wrun9PE1Fp0
 N9YxfV02HVS5cHgXrYZ9j+VMr5dwlnMllIP5++huhBUa7FzziTn3Zmfbitw2QKkNX9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="Gio/djgd"; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Gio/djgd
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CEBA607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EA930C211C1;
 Thu, 24 Sep 2026 12:37:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A6F360341;
 Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1320C103284AD; 
 Thu, 24 Sep 2026 14:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253427; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=nH5rQlfzrshvn7V8NbItF7so8756MmJzn+mQUzLDYhs=;
 b=Gio/djgdvgQRADs5qS5NQamY3//FICZAaOWoWQZLvYGzdPQrndZLZ/4vRcx8avoc6FZ+nK
 CSCZa6JF9cdIqOUcrSVWLn+S1LoPstETnAp1AlIj/nzwI3UkOnx4xTK6O/5xh80S/CUL2B
 p5L8wuj43eP++G0RNFHtalGuijXXTyHTSVg5JJo/MYWKfhQXtyUgc5KZhOWMBZZ3zAC81o
 X52shg5dmON5psS2p++AszamhFKx9mLfm6oDeQWpW6gg/hyoIwPgsxPqiLZxwIU1tz249m
 wUFh5BgWC40MUM9iaHhcnMvIHSmZsTSO9LNXtkGwRYf/j80U4h5f1LLSXZadTw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 17/22] arm: mach-k3: j722s: Enable LPM resume flow
Date: Thu, 24 Sep 2026 14:35:28 +0200
Message-ID: <20260924123533.2599438-18-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add support for resuming from suspend in board_init_f for J722S.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly:

First, set LPM core bus path and compatible needed by extract_lpm_region
to find lpm-metadata memory region (at boot and at resume time)

Then:
   - Extract context address from devicetree
   - Power on the rproc cluster power domain.
   - Ask TIFS to authenticate the certificates attached to saved images
     of ATF, OPTEE and DM and apply the firewalls in it.
   - Send the context address to TIFS.
   - Ask TIFS to firewall the context address area.
   - Ask TIFS to decrypt and restore TFA.
   - Ask TIFS to resume TFA.
   - Power on the rproc power domain.
   - Jump to DM firmware.
(All those steps are done in do_resume())

Moreover, ctrl_mmr_unlock() needs to be called again after the TIFS
version message, otherwise the pmic calls in j7xx_board_is_resuming()
are failling.
Just moving ctrl_mmr_unlock() is not enough, since in this case, TFA
fails to start on J722S HS-FS device.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..99517fe0a29c 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
@@ -151,6 +152,8 @@ static void k3_spl_init(void)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	ctrl_mmr_unlock();
+
 	/* Output DM Firmware version info */
 	if (IS_ENABLED(CONFIG_ARM64))
 		k3_dm_print_ver();
@@ -165,6 +168,8 @@ static void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM init failed: %d\n", ret);
+		k3_set_lpm_core_bus_node_path("/bus@f0000/bus@b00000");
+		k3_set_lpm_core_compatible("ti,am62-r5f");
 	}
 
 	spl_enable_cache();
@@ -186,6 +191,9 @@ void board_init_f(ulong dummy)
 
 	k3_spl_init();
 	k3_mem_init();
+	if (j7xx_board_is_resuming())
+		do_resume(); /* no return */
+
 	setup_qos();
 
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
-- 
2.55.0

