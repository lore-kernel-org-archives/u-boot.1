Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E76C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B04C80D32;
	Thu, 13 Aug 2026 17:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDj9Dyb3oKQA; Thu, 13 Aug 2026 17:59:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E56780C92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643958;
	bh=TMXpke5mNdKZZDGYY2gPsy0qHgHGjN9oold8m5NSu8w=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LzOV87TxBU74qunLFxeoOrOCdGdnEptBTxBYNlf4BlTYpyqGe2mXjTtDxn+NDjxGX
	 d21Hj/HEvhaCgM/ccezvEr2T/eI/ynSEKMpEe/0cRSZXr962e+uJz0etvKmkvPTX4l
	 q6Nzv05GJ7grUzRQqX60vB8BWGZmfORL5rZngxW6bca0lxKB+zwUIFQc+QhMYe5vlt
	 +506O5gBCl2/j5ZwQBrFRjCreedbFuhRtgiaPhBCtAisYzPsf78Jsh3xwOV1aawZjL
	 0BWZEcaEWlhQ4cDzJ2zQrYH78cvFB51PTSqX6WHJbfui4NxtO2pBzEhAwKwBB5BdXR
	 jjL3gEb568Zow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E56780C92;
	Thu, 13 Aug 2026 17:59:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34D871B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32E1B812C7
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCu1oi8hAiDU for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:02:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7FC7C812C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FC7C812C1
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FC7C812C1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:02:29 +0000 (UTC)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C6D23F135
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:02:28 +0000 (UTC)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-836c8fc09cfso936517b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636947; x=1787241747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMXpke5mNdKZZDGYY2gPsy0qHgHGjN9oold8m5NSu8w=;
 b=BFol+azkRHnf77ktNWxSyIFEI7azepN1m1OYwk+ZEgxNtzcOXYAtRLTKCp1nd3/I8E
 aO+qjSkhVoEvqRus0gYX1CHpc4OmHgCUe9Fd2K7DnvFk3A3me808hZPbZpYdoN91albH
 RP00i1IrS4dC6Cpc4kKYQRx5rtu8CxSJVyQXIKuidZNwqC0//8c3Jlz4KuCOXQdrWZZU
 pCbpIxloBGw1kVWSyMByV3wOme5Z31BYrprJ8Zt3zMnvnE5fcJlrl4Epxzw8mYr4cz0K
 W2lZMMhnaIN+P/L6j+DW0o5B6zxkoh336SCiDUlgjkDDHFx7eK/C2uL0C0WwiVqJ+kAM
 koWw==
X-Gm-Message-State: AOJu0YyZqfWiL+IsN82sVsYqT5M3Slin0b8EZAWlR7WCYONx9A2rZuRy
 yRXTpJf7xgbfXPYuQlYu1ZgUDFZ2VwlMuGx70oNduiiA2Ro7DlxV8ttrQNa6GbwFWQiE6JMoJhn
 a3JUqI+oZgQPqoX8fs2NsIdakiDYyzuSt0jonNRyHm3q/Uj3uDt6k55GZyafuCFsxc9h3/3MOFN
 zCL2V3JqkZ3nc1DWDxCw==
X-Gm-Gg: AR+sD10DUcL/ENBZPVxugMmVVlFU1EBfjCxL3gXDGIwtlJwdv3UYEN4rT1hdIH1Bj1o
 sWe8Bc1wCPEAw64StWaOYnQqDwAdE2Qs1/b7dGd2g3UuR/Xaqs660q9f20KKdrZB6nUFpLx5wVo
 cnhgMxXDyERaql3SnjlC8MwXU6+CHgMt4F/74tNwMogZqyFVMZfwPKF4Xe0lPHsE/ec2qZ/NFvq
 2e1rsBV314ff66PfEhFU2lhuuFuV7XwM8m13L+qLL8obQW6GTvKqEwFmwFINGTQms0iEQF+ohPP
 TSvN1XMqiF7h6QKX36LEHxU08uilJO/ApAi6DnKPGKylJeOI0GySAjBxBcfF54zMofmTqy/IQ9R
 bYMwaj8fAz8qoQIniQUVdpF+DlrnoRodIHYIe5WyBAJ+Uuy4sYKM=
X-Received: by 2002:a17:90b:3847:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-3931dfe5048mr7597392a91.1.1786636603319; 
 Thu, 13 Aug 2026 08:56:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3847:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-3931dfe5048mr7597338a91.1.1786636602682; 
 Thu, 13 Aug 2026 08:56:42 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:42 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/7] bootstd: rauc: Clear bootmeth_priv after freeing it on
 error
Date: Thu, 13 Aug 2026 15:56:12 +0000
Message-ID: <20260813155617.184928-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786636948;
 bh=TMXpke5mNdKZZDGYY2gPsy0qHgHGjN9oold8m5NSu8w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rkE9d93WandgUL16yZwhno8xXP4qNSJbt8rTBxf1ego6qHKsqoevK7A9cPDVe4ETO
 /TWnGlHRNQpWd5S5b28gShOUZrPejKxD9kzHhQ3u6/mRCA9+hYCKJlVVkwUqAcLyXd
 EwIOGIb9aTf8RpbY+p5JDr9Ev0aW6U0K9lhKceQpDoB9N/ENrkOpABT6dO76GcCuCX
 62caPo1dlACFeEA0J3bfzxzNEqcd1k1fquOf1oOAFNZ270v2I2hHbuLIREDq/BSTHA
 wPvQpl80IknJExv/LRvvdzm+ckfxgKWv9JU3pPP/vM3bYQhbMhNtgCNKT0jGLK1q7d
 MmDk5mq6xB3BlkGJS2adazSVofuxhfJFtRlM+YSIT5kV9wY4LNvb6U3VvaEmnzA+x0
 wOvdTUjCWh/ec77Vxd80CNxRVoYgufCK+vzJuMu5RW05tOsYhQrkZ8sMat+MH6fGq7
 sfYhAQTTAvrCCzlpGceBGm54s+LgKogrtAyjtkaWZ1m0grMh0DJwdhaj43T16NJa+w
 m4waYxQQqEmb2dDA4FLl9CVoV64KF+6n0/RHVKgPxj1cK294JGwQ+CV7TOnn2sa2mM
 fQYZT2icS5fg/oj59ltQ8nkyqfDIOlKHZ5v/HDts5InwGdIRNAx0gEvnCSq22XItpi
 NQ5aY74JhPRd1+YhpOxWSrQ4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=rkE9d93W
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

distro_rauc_read_bootflow() stores priv in bflow->bootmeth_priv before
calling distro_rauc_scan_parts(). If the scan fails, the error path
frees priv via distro_rauc_priv_free() but leaves bflow->bootmeth_priv
pointing at the freed memory.

With 'bootflow scan -a', failed bootflows are stored in the bootstd
list, so the stale pointer is kept. The next scan (or any other
bootflow removal) calls bootflow_free(), which frees bootmeth_priv
again. On sandbox, dlmalloc catches the double free:

  common/dlmalloc.c:816: do_check_inuse_chunk: Assertion `inuse(p)' failed.

The scan can fail this way whenever no slot has a valid filesystem, or
when BOOT_ORDER names an unknown slot.

Clear bflow->bootmeth_priv after freeing, as bootmeth_android already
does. Extend the bootflow_rauc test to run a failing scan with -a and
then rescan.

Fixes: 284855320282 ("bootstd: rauc: Free memory during error handling")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c |  1 +
 test/boot/bootflow.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 32be641ab54..3e76eabe2fb 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -239,6 +239,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 rauc_read_bootflow_err:
 	distro_rauc_priv_free(priv);
+	bflow->bootmeth_priv = NULL;
 	free(boot_order_copy);
 	free(partitions);
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 837c5a7a4aa..8fa8835c20c 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1458,6 +1458,19 @@ static int bootflow_rauc(struct unit_test_state *uts)
 	ut_assert_skip_to_line("(0 bootflows, 0 valid)");
 	ut_assert_console_end();
 
+	/*
+	 * A failed scan with -a stores the failed bootflows; the next scan
+	 * removes them, freeing bootmeth_priv. This used to double free the
+	 * RAUC private data.
+	 */
+	ut_assertok(run_command("bootflow scan -a", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+
 	ut_assertok(env_set("BOOT_ORDER", "A B"));
 
 	/* Restore the order used by the device tree */
-- 
2.43.0

