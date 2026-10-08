Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692FCA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 06:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 500D6811D4;
	Thu,  8 Oct 2026 06:49:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DA3G57ZBMDdA; Thu,  8 Oct 2026 06:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46364811B2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791442170;
	b=lz3iyaWlb9VT0IyOz+iOa/rG9r8dUr1fBzhYCLehf2yvuvO73MffcEFLlM1CYm6LRdn9
	 OzgvsJ2I7pi3i2SR0mw4Y5rJDLDtkkt3nrvRSxCIIf+D7be0L2uL/wD3WxmQrzexlooM9
	 GFIFXj2HBJnvZN/DFXShsYZMEw6vGX+G9bTZ18YmnHAfRj6UvroJUxVIuCh4i6VFlUf/a
	 nMMgVS5Fb4aZUd4kOhs17+LAltmMXXosdC/8IGF3HERgWUmUe8Gkd4roberiWE1xg/6G9
	 bnYpaNAGN7Kn0Bm3Kc2fiGqSfTGpjBocjYGbC+5lSxSiy/zqPWmFF6FdV8BBlp1NksA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791442170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
	b=Y1oWEb+vXXS6y/UTEAmeuA7A7bcA6K41Q4xUVyHwX5dhYz/ypJm8gogejHfkcBjp83L2
	 o2rfle5xFPZy3xGkGqHYOLlN0oWC2y2FWNCA6B3C3woxO6xrZExQNZ4YciP+3Gds5O3AO
	 ubTHxB+d92YDrEvnb5Pkaj29KtjJPjoOmjxPKU2JOOJpAF0VNYp+q3k2lSCVRa8LG+tER
	 1Ap3wZyTS1lonPfnNme0Notu5gUHFr/nUTtzTENn2GpscjXSk++4wpaHW0zlcuVFgQ45N
	 63rRr9yH0cIbIecKmu15H/l9ZtB1OJJG1UN7Waj6wdlggbNdlqgNR6nCbwaSuVZdgWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791442170;
	bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIURjNFy8diAqW1zPWWfR8rCTx21akiF9qOicrZu6YDIlpoBDR/fy4e3iNL2mTEvO
	 uN2hIGovmpzqe9ujwJAyA+IDDw7OOmqZW70uXd+50CO2BtWQp9vXOBzYuGB6HX27Pg
	 mMX02suVW3iUmT47OsQgJqtfJ/Uj6lZDnsJFPzkyibPm5d4TL3qz8vCguTUOSeu/mb
	 cyEaFwdQ4fLQQmtXVSSyvkVsFnNgQskJRGuxDS03NRc7kFxuKvPCGqGbbmdNbkFrj8
	 UNNH/HBFkakkFSYjB7co4LKznse7LK7JkIMj/ES30xMR90fh4uC/Q/75qATfKtZzX5
	 9hu2HUqgfgO5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46364811B2;
	Thu,  8 Oct 2026 06:49:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6483338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBFDA4082D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cC57PMPgtR6U for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 06:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1385A40827
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442166;
 b=W4oYQ1WBANryMG9NsfJ551WanhLU3xaylWrBlQoOzR/RiBBhzAZ7uTKhe/pz+F6Qu8v8
 +x5mMzjCaqgruN1+QcxKH5MufaE0PQ9HBiCXk5YTrwNntVwThJNUiPo15NEwOinp9lH53
 dn/oc58tQVYS4CoI1tNnDg2eT9ko3qHxFAL2xVYXFUv/95V4o0H/tJFVmW22BGTPzYOmj
 dfO/GLOlNkHGdDJ3wPlvdCDv6NSdZ4XCfglSjzFy/y8IAPvAekxVIRUqAk7ikOls34Gvg
 16+A1jEoPMPYSlWgbIKFEuGb7BfuBTFy3FARguCGx5LSKv66hJHe4N21lOk05mSPVMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442166;
 h=Received-SPF:From:DKIM-Signature:DKIM-Signature:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=IqMauTPKjWKYuRP+fWZQUMgsdtJN5WNk97ButBgDsNrGC0zVTPX0l4nqqCerOvZavPZP
 ddhAbWeO7JqYnF6KwT/7aMsEwDG14KbVUk55H/rH625c4NlwjU07CZJz7Gk/tqCdGh0KK
 p5dgAiIET4dsLM9Zamz4veTfPQDjNO2mgshS/MA3W8WrUHEhJrAlvo6LoaZKewEPXcaSy
 dbYCNk6WLdCj1/PaMlKiawFYLRKlDAi7VwnD0Z1yycHO/KaxZY1JO20KcJ/AVjK2xje1y
 ztw2gGLaJhN9Ry31n1Rc/f96Zc+VMLk7nH66ZkwWZ7aFhBH44h7qP50BwLs4XEF9wKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linutronix.de; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b="mt/NXiBL"; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b="wzHZVFP/"; 
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=mt/NXiBL; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=wzHZVFP/
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1385A40827
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:25 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=mt/NXiBLtSXrKa/elwSQoHInZoGEkNbw+DVi8R9eYWpfsMQiACjh/+Oi/j5GFs1OtOOLBf
 U2xChobF6KAqkQQnviG6qdBELrfi21H8xnIppgH51IrVGFA62jsSJJo/XpN/bMxe3RHMGf
 n491duIh2h8/mzzRt9fw2LqRVRYWgWkOrPeH//2uthJ8yrC3jhi0mwd/qhLiVsmRauTl24
 Ceas8zdYOdGkboX5693VsoBNQWaDsYJJr0CEGAvfFtI4zHPEbgMoS+jAZWi2Lil7p2zdPm
 ZkhmYDRBAL/uYDYmE3J5eMtsupuY0O3O5U161rpVtlsxa7RKbvmF8bqymm/n4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=wzHZVFP/oEppYHX/o4fnLmZSmJzbEi5TNApAxH6hp/QAe7Hcl2AKvTddDLrbVSD2E3f8KB
 SZ1sMo5u+SthiDBA==
Date: Thu, 08 Oct 2026 08:41:58 +0200
Subject: [PATCH RESEND v4 1/2] rpi: set boot partition from devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tryboot2-v4-1-0ecf380c0e1c@linutronix.de>
References: <20261008-tryboot2-v4-0-0ecf380c0e1c@linutronix.de>
In-Reply-To: <20261008-tryboot2-v4-0-0ecf380c0e1c@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791441722; l=1357;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=4+bM65tNui9B6ZZpfMJj/iUKxmOuDh9UNLJF+ikkIho=;
 b=Qf4uK7PgxuZ4tRGcpt4uLAlKvwXayUzc0XthyM9E9QnVNQSYcsPo45Lwiu512/Vy4au8afRKn
 SbYlUNCMpvxBHWxQ2C5TRNYrGCM6HgH6XaB1JPk0KzPZqGETSPr8vFB
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
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

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware sets 'partition' property in /chosen/bootloader.

Set the env variable boot_partition accordingly to allow boards to
create a bootcmd based on the boot partition.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92351c..8354fec833cc 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -480,6 +480,20 @@ static void set_serial_number(void)
 	env_set("serial#", serial_string);
 }
 
+static void set_boot_partition_fdt(void)
+{
+	void *fdtp = (void *)gd->fdt_blob;
+	u32 partition;
+
+	partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
+	if (!partition) {
+		printf("Failed to the get partition property.\n");
+		return;
+	}
+
+	env_set_ulong("boot_partition", partition);
+}
+
 int misc_init_r(void)
 {
 	set_fdt_addr();
@@ -489,6 +503,7 @@ int misc_init_r(void)
 	set_board_info();
 #endif
 	set_serial_number();
+	set_boot_partition_fdt();
 
 	return 0;
 }

-- 
2.47.3

