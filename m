Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B26C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 01:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5586406E0;
	Mon, 27 Jul 2026 01:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8r4gHRyGutM2; Mon, 27 Jul 2026 01:14:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 701B840687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785114864;
	bh=VUJnBfbxhy6ylJspsNVBctS4D2oLP1UhD8lA/w2MATk=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ae/m+jSYoFMV6vjxip5LGW94twgfwvbOZW2B4TlNSJZb9+asSB8fyabwC0JmHxaaz
	 gcK5OzZ6Xci3K7VuQ3iflvbieRe0BgtW6srsWWvMFWYEC231KWXngyemKu403OrwrB
	 7V46cKWWtoDZApDNY6vxq6r8S8RIBRNQe1Mxxf7dzypQpXZH95GZNtp3XX/TkYJKFb
	 fwtkpFvwn5HgZT/n4WBYioyltHs9UpeZtUCkDdG7cbO2SJn0LkNCCxU/DbyhTd8Tif
	 BlDR8lAYjoA1HZp8IYFpR/PA4LVCRszud5xSltC/woP9mSP/QKAzVgosFb/pSlH0Yj
	 jxl1Uz+Tzi6wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 701B840687;
	Mon, 27 Jul 2026 01:14:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E73B4C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3718B40042
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yclAjXB4sUUc for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 01:14:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8C16640015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C16640015
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C16640015
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:14:20 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h7gbs4Y0Fz8txw;
 Mon, 27 Jul 2026 03:14:17 +0200 (CEST)
Message-ID: <af758a22-b8c0-470a-90b8-a3ea92db1783@mailbox.org>
Date: Sun, 26 Jul 2026 08:41:44 +0200
MIME-Version: 1.0
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
 <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
 <a164c15a-9331-4361-8a50-692e9855512a@gmail.com>
Content-Language: en-US
In-Reply-To: <a164c15a-9331-4361-8a50-692e9855512a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: enfyaqjmsg8ah45h7f9qpyeqod6iez3c
X-MBO-RS-ID: b076a5f4b8e3254d83c
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785114857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUJnBfbxhy6ylJspsNVBctS4D2oLP1UhD8lA/w2MATk=;
 b=MIyxz6GGgdXKST95WvWxMIgCM9NCDX5dy4RhbeebNOuqJ4R1LDP8IqccBL0+5Xe0RDGz8+
 Q3xVoGtAv8yKmiVM5pjkwDZrsoQhJqG2bSNnFClgDE9x/NlMUwyJh5Tx8p1Q0wXNHmovpR
 99qtmPQOLBMoLWfIe7JBWX7t5dujKO7MfZUXQkYe2zHhihmrCU4boR0RIgACM+cymZC3bH
 ZDSg66evB7jYRscxI5Hgw5n/8MXD3BN8wuRNqmYEriGmxwOHWV/d2zPGxqhIJslAQAE2qy
 TaXbmQy7Mw04+2WDIO0uT3lYcwxdWJvtmKVnPOS1ynSgjc6Wvgtg/rCImmtA1Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785114856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUJnBfbxhy6ylJspsNVBctS4D2oLP1UhD8lA/w2MATk=;
 b=gLKzhoJ0SZ1KDLOLNTBBk6iMfgpBgR3sZFM5mwnEbD06m1EqW8dMMU4/I4K78O8jVa3Bb7
 S0/HP69+qc8RSgLvxocLCB6L7VeZJ2Am7dRJz5xTSyjiPknU/T6kim3hiPZtuycjTDE/r1
 NNYTyZbey+0jnJiP9I/EbnZPIBFWO0MeHpDO+j7AKlPrBJVN9IeJFPesREYY6TgHAojwpf
 vFxsbgZJCIlG5g+njDuVxVyNbzkyv26VnLdME6iDyn95Q/u3m0XxllYTuBIwmgpyXeOIva
 emaEF4O9P2o8/Km8A5RtB7KKd8tXicBB75XpRtmF4AB+7WVNKHRXCxzSmwLQ1Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=MIyxz6GG; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=gLKzhoJ0
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/24/26 9:36 AM, Emanuele Ghidoli wrote:

Hello everyone,

>> Regarding the timer, how come the timer is initialized so late on MX7 ?
> timer_init() called in initcall_run_f().>
>> The Cortex-A7 should have its own ARM timer, that should be available right
>> from the beginning. Is that ARM timer in use on your system, or does your
>> system use GPT timer ?
> iMX7 uses arch/arm/mach-imx/syscounter.c.
> 
> udelay() is called in initcall_run_f(), before timer_init().
> arch_cpu_init() (arch/arm/mach-imx/mx7/soc.c) -> imx_gpcv2_init -> udelay
> (which runs schedule/cyclic).

Yikes.

> And this is interesting, udelay() before timer_init() leads to a 0 us delay,
> so there is another bug.
> 
> I have verified that removing this udelay(65) the board boots.
Can we start the syscounter sooner ? Something like this:

diff --git a/arch/arm/include/asm/arch-mx6/sys_proto.h 
b/arch/arm/include/asm/arch-mx6/sys_proto.h
index 7845fa8e569..5f6759a3306 100644
--- a/arch/arm/include/asm/arch-mx6/sys_proto.h
+++ b/arch/arm/include/asm/arch-mx6/sys_proto.h
@@ -36,4 +36,6 @@ static inline void iomuxc_set_rgmii_io_voltage(int io_vol)
  	__raw_writel(io_vol, IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII);
  }

+void syscounter_init(void);
+
  #endif /* __SYS_PROTO_IMX6_ */
diff --git a/arch/arm/include/asm/arch-mx7/sys_proto.h 
b/arch/arm/include/asm/arch-mx7/sys_proto.h
index 5da0037b2c6..765764cf1bc 100644
--- a/arch/arm/include/asm/arch-mx7/sys_proto.h
+++ b/arch/arm/include/asm/arch-mx7/sys_proto.h
@@ -11,4 +11,6 @@ struct wdog_regs;

  void set_wdog_reset(struct wdog_regs *wdog);

+void syscounter_init(void);
+
  #endif /* __SYS_PROTO_IMX7_ */
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 02df86156d4..641b5d813ea 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -437,6 +437,8 @@ int arch_cpu_init(void)
  		 */
  		if (mxc_get_clock(MXC_ARM_CLK) == 396000000)
  			set_ahb_rate(132000000);
+	} else {
+		syscounter_init();
  	}

  	if (is_mx6ul()) {
diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index e504c1fd52a..82d851b7817 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -331,6 +331,8 @@ int arch_cpu_init(void)

  	init_snvs();

+	syscounter_init();
+
  	imx_gpcv2_init();

  	enable_ca7_smp();
diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
index 96fe2c7c17b..7b902540737 100644
--- a/arch/arm/mach-imx/syscounter.c
+++ b/arch/arm/mach-imx/syscounter.c
@@ -60,7 +60,7 @@ static inline unsigned long long us_to_tick(unsigned 
long long usec)
  }

  #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) || IS_ENABLED(CONFIG_XPL_BUILD)
-int timer_init(void)
+void syscounter_init(void)
  {
  	struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
  	unsigned long val, freq;
@@ -80,6 +80,12 @@ int timer_init(void)
  	gd->arch.tbu = 0;

  	gd->arch.timer_rate_hz = freq;
+
+	return 0;
+}
+
+int timer_init(void)
+{
  	return 0;
  }
  #endif
