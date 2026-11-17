Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE0606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mx+duFwP;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=C33JrN8Q;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=i6FNNxOg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EDD081096;
	Tue, 17 Nov 2026 10:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZaMIbJ4ABLI; Tue, 17 Nov 2026 10:07:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D995481067
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794910034;
	b=k8EpxBga0oJvJjjMjv5XsoVhwjQ/IlToT53BHGbcYwPBq2oK+6ukR3hpRzshyFhWO7Dh
	 QEX1xdAAVYDjmrGUEVzPx/KVPXLkItXmZi6jCJlvIdGejSmtKGsOJOsjqApOgIdk7awx7
	 7ftsa/EqGLRMGy22mdKXSMNjI//MKNeON1sS0/UBSgj/nx1Sh8N1P/TugVDOFknW8Cnuc
	 LBJnJH2+mBWKI6Xj9ptXm8VtBFnF8HJArEw+Q8kgvpwZZ7rCDU8yPn9tN+iiDoJmOBxoL
	 MlcNEYBdG7k4h8FNmqtkBXnGP2X5S+UCQ5UADscNZkrTrpJqYULctnrY4n8w2mOUoSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794910034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 From:DKIM-Signature:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
	b=NnFXSbzq+hAeiX4DFCGo+q1x1GNuOlzepk2ml/rZGrYmU3dBSndKkOPnBzwOOPu9e2vW
	 b9/ZdgzDMLvruzX2DibxwAUtL2tMTYRGVPoMCaIVP9xvk0TOrw5Cf/Rw5+aoxEZpmIDsR
	 EprpsHLBXHKAUeQEhqs521RIXRhRXKK0N7MwgbC9zlP2o8CqQk2pXk8IwDT2nYohbNoFJ
	 nELzYscXGjJdU6cD9O8+gB85yoEjaTqJuPqHSDGFGquqq2JeRlCWhpw22fDSjzKdWK5E1
	 JGm7TONkDiJcNBuDau8sYt5kN87nXdiqQ9BoJqsDfkGZMXu2DDSzzmbt9xDATrjX0+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794910034;
	bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mx+duFwPKJbky78BktJSW/wWXnHTrUvoH3FWygi4al4arT3MX245Lr1hNj+jcLBsI
	 HjNdwm/resnJ1ZaQ/xa+SrHyYa+fDrrzPfRpynDAlOSiNEGMbsBGf7UjpuSPZWg0Hl
	 IBvtGXDGohSQ6mb3ppEcIJkTinhjNVMkkjEJLLot8xlOfcYuyb2binyop24uK4XS6u
	 7oyPuCGqVXenuCUY/MHbXB6zxbpWQweM+bytXfXQJ9yBV0nkbp2dS8D4GpAgdfazAu
	 mWwdKUJz+k1u1N0GDicuCQTzQAR3SA3utV/FqDsXDz8yZFtg06BwMTweUnCexEWnIC
	 sFchZaMjDkW2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D995481067;
	Tue, 17 Nov 2026 10:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA47C1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F4B140301
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYHWkOi2nFWy for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 964D64008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
X-Greylist: delayed 430 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 10:07:11 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=C33JrN8Q; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=i6FNNxOg
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 964D64008E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:10 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1794909595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=C33JrN8QXZ4la9q8wHoMNAUNmZdJiQYTBaUQZYpg3LtP8Kh4wQJpLd+qPLsZnlMVbZVlYT
 s3+HpN6bNNwltcjWPAKlxMXO2jZuiP0a4cxrViqqoAXbzQcJ/VRn6N4e3bRM8b+ZUQuwDi
 5cHrcQnn9IYblUUIFM8aL44MS0/Gul0o656Z49J63TzPh9l/5abo+kfZVp+F3nRtJ5c2Mq
 gBYACB6P96IYFWwrFDhP98HtNcvZU3RoGug04PvefUQrV66kOuArNIEztk8dqGx8ch63I/
 poaCKxb07Oeg4fDbq3AH54jSTn4HF+CsR+F1oKZIKfpDjgElTaWb1H6B/JcYrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1794909595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=i6FNNxOgnBQFWEZrlLR1ElgB6M9e6bodou/jQiKbzpwTKcvU/KlCHkVUEkteyXKGsf1D6X
 RZaftfrtduuQW+Aw==
Date: Tue, 17 Nov 2026 10:59:45 +0100
Subject: [PATCH RESEND v4 1/2] rpi: set boot partition from devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-tryboot2-v4-1-d59fa66de789@linutronix.de>
References: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
In-Reply-To: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794909594; l=1357;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=4+bM65tNui9B6ZZpfMJj/iUKxmOuDh9UNLJF+ikkIho=;
 b=szPdR2QkquW9WJPCmjZ1qj562bMAJVCSxweGNB+Ix/DtQILPJC07DKc9Wg9jBMLicTZS0gB5d
 572BxJBLA/SBbYkk7+gLE9hzyl6zYNqgqgt+Gw6xW0/zBETcMSBLnRC
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

