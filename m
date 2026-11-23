Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8137606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CsveiRDD;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=llqqfLun;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=Hn92WAV8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DF3D40743;
	Mon, 23 Nov 2026 15:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqS_TcN9qpCt; Mon, 23 Nov 2026 15:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4646D4076A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446437;
	b=O6W8f5QR/zeHLXqT7dLINVF53fqP9y+x4sNp/BYeJp40JYlaZKzPB+SrUBiCKHkHwH/b
	 csQy8NpLuU9bpPPF+xnhaoAeUJEU/aNKps/CphwLGtdJhcLEQCIk86QxldmAZt+nHHCbZ
	 5KgLf7sQlq1hOZBK26zHh6uddTxbLhhpb/kAMUZ48gR3z+/4wVbYFPbtGaI4XxnI+KnMR
	 wT6yMeN+Xbmcjb5CC7IWOzdHhHrNpHDA27VopMqptn7oOvgDg1Jdezu21XvNSpHDjXbo3
	 o9BYFH08yT86Yc35fDKN7HDlQlpP6xsB2Hh4zEjDApWSzIoh43tjc3zM9Vlv0Sd1QEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NdjRShNG7ofvInvYeCTjQOqeIpFRW2B66dJ3Xqxz+Cs=;
	b=MHXBEyNeq8n7XH1LqP/BKznjU5qiSaBH+wVBgzlMsXy/UYvhftKOy0OGO1DzVNk+ht0j
	 0C3+67on0Y8Do4qD2ItVp6VtoM5oVpb2jpj3yHdpkKHiPN9hGfxMRgf/bQLHTlxY/lEfx
	 XiaCfjbIpHQbzul7bkSKH+8ezQpGQIIiHSMb8+qp18z8McH4lyKDI8MP6jQIb736pTAUq
	 z2HIOV8jGO0L84u1c8zaTODrgLy4F23OBi+7+Gh/n7/0ekdjEAn1YsghZBb/U9/MYGvEE
	 wn1BHhL4OBmM4BqtK7/vgHWICaRg8SjZ4BBb6AFaDrBpwN9uZuKCuVynmZE1ywbHhdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446437;
	bh=NdjRShNG7ofvInvYeCTjQOqeIpFRW2B66dJ3Xqxz+Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsveiRDDnNaz1r+VJZmkIDLpPIaIovdvwtyQkgWVrhO4glQ6aS1W2i6zcq0U6S0Om
	 jl6KdGHmlMjQ0Bq3UkZczjg/U/u8M1B5WtvzPV683d7QhaNSdBlvco+PdREzbZ05ig
	 0Tr7P/z06qN4ZRrRuySBdWTbKVlKDxier4kmAlqF2oZPvZ6gY9XuxOgN525JLRhU4G
	 DUchMRiHEVeuv38AyBJdcK1Ktb4mKt+Mo8V6TCsEcRAz2JGJjPXdq+eiFJ951qk59k
	 xJMmw6ULggPKCS9SRhMjfr7FffiUQZLkkTHfwcLg+9WItzOKUJHdAXlR/ZftED0Wo8
	 vkUGSu9C+e2UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4646D4076A;
	Mon, 23 Nov 2026 15:07:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26AD3759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18C0580DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8SvOfZ8Kvmy for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:07:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6571180DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eede=jn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=llqqfLun; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=Hn92WAV8
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6571180DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795446433;
 bh=NdjRShNG7ofvInvYeCTjQOqeIpFRW2B66dJ3Xqxz+Cs=;
 b=llqqfLun5GYR1RTQxN2lE5W07YL6sed3tNCs7bKAuG1mdj2gmylmN64BrGIfwPe+4GumPb2Xh
 GuWUMDWnIz8bhRjOFYJdKpaCeOEgp7YYWpQvBTNpxNwgnNCE8fxgi+4doCdJ59QBxJVeT4aqhcg
 f1eKmGyM7vm9gdL/RaboXRdzyieYfiOY8HqUY9++kZS3EsqbcEHVZi+FwgNF5QEd8zI6cEBIWp3
 crgElYLBFlwgO78gOLlgELROENbf3n+ItQ/LmTE9/6tWBxLuQ0Jsla14GnM5e3NBkKJc4hNt91d
 49WMlv/ko7hE/eufkCLc5csL6FnGXCMxfrMdjfPbIxsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795446433;
 bh=NdjRShNG7ofvInvYeCTjQOqeIpFRW2B66dJ3Xqxz+Cs=;
 b=Hn92WAV8HTuVtQX2U3DrKFIpLjbgVgLlyxHJWYfLdH271BpFkPOe7WpS+vT2JOvn+Zc6WSA9n
 D2Gl2NeeO93Eou58zy/EVOkBwI3RlF2bjFSIOnsfK2GsSxEDf4O8oppZMoYS6cJ7g+Cc/YEjMhl
 pw0xrnqjls+ktlb9R1dQwJs=
CFBL-Feedback-ID: 6b04569c31d91c9369aee1bd:f211d03e64a316ec30266b018a35328b
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04569c31d91c9369aee1bd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] rockchip: rk3506: Enable use of SPL_OPTEE_IMAGE
Date: Mon, 23 Nov 2026 15:06:54 +0000
Message-ID: <20261123150655.1397175-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123150655.1397175-1-jonas@kwiboo.se>
References: <20261123150655.1397175-1-jonas@kwiboo.se>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Vendor OP-TEE blob provides PSCI that is used to enable CPU cores on
RK3506. The OP-TEE blob is expected to be loaded and executed from
0x1000 and uses memory in the 0-1 MiB area of DRAM.

Add initial support for loading OP-TEE firmware on RK3506. Reserve the
first 1 MiB of DRAM for OP-TEE and use ROCKCHIP_SPL_RESERVE_IRAM to add
padding to the start of SPL text area to allow loading OP-TEE to 0x1000.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig  | 4 ++++
 include/configs/rk3506_common.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c1dbcce1e27c..9a2d5ff77ef6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -332,6 +332,7 @@ config ROCKCHIP_RK3506
 	select BOARD_LATE_INIT
 	select DM_REGULATOR_FIXED
 	select DM_RESET
+	imply ARM_SMCCC if SPL_OPTEE_IMAGE
 	imply BOOTSTD_FULL
 	imply DM_RNG
 	imply ENV_RELOC_GD_ENV_ADDR
@@ -352,6 +353,7 @@ config ROCKCHIP_RK3506
 	imply SPL_FIT_SIGNATURE
 	imply SPL_LOAD_FIT
 	imply SPL_OF_CONTROL
+	imply SPL_OPTEE_IMAGE if SPL_FIT
 	imply SPL_PINCTRL
 	imply SPL_RAM
 	imply SPL_REGMAP
@@ -359,6 +361,7 @@ config ROCKCHIP_RK3506
 	imply SPL_SYSCON
 	imply SYS_ARCH_TIMER
 	imply SYSRESET
+	imply SYSRESET_PSCI if SPL_OPTEE_IMAGE
 	help
 	  The Rockchip RK3506 is a ARM-based SoC with a tri-core Cortex-A7.
 
@@ -679,6 +682,7 @@ config ROCKCHIP_STIMER_BASE
 
 config ROCKCHIP_SPL_RESERVE_IRAM
 	hex "Size of IRAM reserved in SPL"
+	default 0x40000 if ROCKCHIP_RK3506 && SPL_OPTEE_IMAGE
 	default 0x0
 	help
 	  SPL may need reserve memory for firmware loaded by SPL, whose load
diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
index 5e4ef67289f0..c008fee8211c 100644
--- a/include/configs/rk3506_common.h
+++ b/include/configs/rk3506_common.h
@@ -11,6 +11,7 @@
 #define CFG_IRAM_BASE			0xfff80000
 
 #define CFG_SYS_SDRAM_BASE		0
+#define CFG_SYS_SDRAM_RESERVE		SZ_1M
 #define SDRAM_MAX_SIZE			0xc0000000
 
 #ifndef ROCKCHIP_DEVICE_SETTINGS
-- 
2.56.1

