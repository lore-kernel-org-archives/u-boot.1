Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21E606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iVt0W0m3;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HQ4EBcx1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43CDF80F20;
	Mon,  9 Nov 2026 04:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoDSG9Ta5Sth; Mon,  9 Nov 2026 04:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D556480F1D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794198845;
	b=fW2zCyq319aRXtGDmcCTMfxg25KZNK4IRAabEMQxBPKAa2UBaipC61bnmGeY3ITdtUCL
	 ttqLWNtxJwQpsn/vuAcc10PUh5Nhnh1nLaiu0PDhiAEf05ubIypwOjnuu6HD4ZN/lak8N
	 lCdmUVSUeU/uPCopBkiRzCX7HipekS3qWreLmojVSv27mdidybt7CNrwlZB3xHEfNT+OS
	 w5c/uDPCmGC7u6qiBSnN1KuSnTcWJ+8fj13YR+rMQRdLQ7t5DUjSBxTVRYxhOv9DL7ABF
	 Mum2YWehpIsU3xYcgXyKAY9zynmQMr5RXsfOL81Q2v7mwZ04h+dvV7Zjwa8A6GsFWJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794198845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Message-ID:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:
	 Importance:X-Mailer:X-Originating-Client:X-MBO-RS-META:X-MBO-RS-ID:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5oPRWtAFAvQCyu4WnYvksLQOkjtfnG41CibWu748Gek=;
	b=N/Vp35f5xj1Rp25nbXA5J3wDz+I8vjy5WIlNQaaFeQ9Fo96RS0vw3eJfEpKQjdjGFFSn
	 FPRbYWXgXE871V2BwayWWU1fXtNG9luTwZaA9Tt0c15AYSBUvXXynGD7gU1PWnsUH1Gz9
	 5Gh3LC2HRQWHKE8mBScPg8v31dbgbgLgthmZKQ0PSdAOMR4iqCK506ywigIFCJc3DsZZU
	 8e2oCHBnwdqLrduGhKqceKVbhw814teLQwFw+I3pZm7duaQfTu0jLfb0H2atQwyPqtVZj
	 Sv3KDpPpcCsrSdNImbqbUtTRI3Ad+35Hrps09QGhUikzi+HhR/WFumYdo3gv070YvCA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HQ4EBcx1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794198845;
	bh=5oPRWtAFAvQCyu4WnYvksLQOkjtfnG41CibWu748Gek=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iVt0W0m33n8jAaCGVBlELyyHygyHHk9e+68S6q2fUcRpgyRhs4YLHJdUMh9vGxlqR
	 FKndcdPiPRQMUXNkzG58XmzkJLq0U1RfdkKGclWXqz4ZUUmUuCkxGQ9CcwQPAiN3jc
	 QhxJyHWLgKXi+Kx+5jDmixHCWgpt1yUbwynp0zA0XE1RqL+X7igEBNQBtrVyIuq0eX
	 T6HUr0vE0kOQSVwu9zJwXBVGd1UGFRrZG0BTQ9ORp6jMfhRAeirQ0LgEhx0LNdssTS
	 GeWl0RSEROD5bzH6AWZMW9gL2l8/prKeDRV5iWARVek+ZV0X1el2FaqpxiI6YFRAmV
	 2XNArHyt2aE0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D556480F1D;
	Mon,  9 Nov 2026 04:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05609932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73E0680E34
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNvjdHRnesaf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 03:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD23D80E1F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
X-Greylist: delayed 559 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 03:09:41 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=HQ4EBcx1
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=timsurber@mailbox.org; receiver=<UNKNOWN> 
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD23D80E1F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:09:41 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jNDzj3023zMlSl;
 Mon, 09 Nov 2026 04:00:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794193217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oPRWtAFAvQCyu4WnYvksLQOkjtfnG41CibWu748Gek=;
 b=HQ4EBcx1Yqx0QQtxGo1t3WXvHCJMJTAyJ8QN7qFPb9exsUw/JyoDXpxgTjCdVnKH07b0/F
 U/eOvdkknPbkUJUT2PE619Hf4lihanBfjiCMqg+7kB3UB3NDNqZkTleWhgowfrssFKUKzg
 IyEZrMyaeooS/LOnQGAUDCEWd80xWNMk0h/Ls6rlX0mCCBTxtzzt10HK819oI+QDHjiE/w
 qQlG+FDW8zMV6ejNwxuFYb5E37blg411e9PrDbGYHIRfhCs3mEw869ncOW2fgGerPdAQ6y
 kpQz0nwk+EN/iP9N00m3Hz3CxsA//H2ugmTPzmyd+vt9IaH06blocoKg+yZszQ==
Date: Mon, 9 Nov 2026 04:00:15 +0100 (CET)
From: timsurber@mailbox.org
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: "jonas@kwiboo.se" <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 SuperKali <hello@superkali.me>
Message-ID: <1551247609.687446.1794193215725@app.mailbox.org>
Subject: rockchip: rk3588: big cores left on 24 MHz oscillator, Linux boot
 takes minutes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-MBO-RS-META: 1o1r559kxi5c41n3p7umtztoi1tujd95
X-MBO-RS-ID: 7d2b68c5d5bdf00fda7
X-Mailman-Approved-At: Mon, 09 Nov 2026 04:33:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On RK3588 with mainline U-Boot and mainline TF-A, the big CPU clusters
are still clocked from the 24 MHz oscillator when Linux starts. They
stay there until the Linux cpufreq driver loads. Linux prefers the big
cores for work, so early boot is very slow: on a FriendlyElec CM3588
NAS it takes over 4 minutes to reach userspace.

Setup:
  - U-Boot v2026.10, cm3588-nas-rk3588_defconfig, binman build
  - TF-A v2.15.0, PLAT=rk3588
  - rkbin rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.24.bin as ROCKCHIP_TPL
  - Debian kernel 7.2.15 (cpufreq-dt is a module and loads late)

When cpufreq-dt finally comes up, Linux reports the starting rates:

  cpufreq: CPU0: Running at unlisted initial frequency: 900000 kHz
  cpufreq: CPU4: Running at unlisted initial frequency: 24000 kHz
  cpufreq: CPU6: Running at unlisted initial frequency: 24000 kHz

Timings from the same SD card image:

                               unmodified    SCMI CPU clock raise
  initramfs unpacked           43 s          0.6 s
  Run /init                    56.9 s        0.9 s
  systemd-analyze              4 min 29 s    11.1 s

Cause, as far as I can tell: rk3588_clk_probe() in SPL programs B0PLL
and B1PLL to LPLL_HZ (816 MHz), but it never switches the big-core
clock mux to them. BIGCORE0/1 CRU CLKSEL_CON(0)[7:6] stay at the reset
value, which selects xin24m. TF-A's SCMI clock driver returns 24 MHz
for that mux setting (clk_scmi_cpub01_get_rate(), src == 0), and it
only changes these clocks on the first SCMI set_rate request.

Armbian has carried a workaround for every RK3588 board since U-Boot
v2026.04 [1][2]. It raises the CPUL, CPUB01 and CPUB23 SCMI clocks to
1008 MHz from U-Boot proper, after BL31 is running, so that BL31 does
the PVTPLL setup. That produced the right-hand column above. I also
tried setting the CLKSEL_CON(0) mux to B0PLL/B1PLL directly in SPL. It
builds, but I have not tested it on hardware, and it bypasses TF-A's
own view of the CPU clock state, so the SCMI approach looks cleaner.

Questions:
  1. Is the SCMI approach acceptable upstream, or would you prefer the
     CPU clocks to be set elsewhere (SPL, or TF-A at BL31 init)?
  2. According to the Armbian patch, the vendor U-Boot also uses
     1008 MHz. Is that rate safe on all RK3588/RK3588S/RK3582 boards
     at boot-time voltages?

SuperKali, you wrote the Armbian patch. Would you be willing to send
it upstream? If not, I can prepare and test a version on the CM3588
with your Signed-off-by kept.

[1] https://github.com/armbian/build/pull/10125
[2] https://github.com/armbian/build/pull/10543

Thanks,
Tim Surber
