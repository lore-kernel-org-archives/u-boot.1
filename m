Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A4606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wa+GptQg;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ou3fxEUI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1CCA40572;
	Mon, 16 Nov 2026 10:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LzMJXTGPi4S0; Mon, 16 Nov 2026 10:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77B8B4069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826791;
	b=jNruC26YBrzpzymx6oITd5qy9qWOtc+UwqNnPGdO93Sisu8nMznZyoGkjLeGYUXhVMdj
	 Yc9P4BpePDBKyVoJ5dYhvJhULEG8YQir3hgOQ1ZSbL5vaqgBrkwfZHwhyJTjT/T6LlA1d
	 2nEA8vrH1wiiQSbHy8nzozxoGPDZ7OBlF1iRlkMUuaeFuEDnM0quU/+1SrEzcFchLJz55
	 BieXFe5rVYDUURwM7akmEHLpqbHKvna78sWLh9SM0WRmrRC7BdG/huvDGWctNfD3c54g1
	 KiKmUD1w5keXXQDNgNPAgj+nLmUxz7t+mrsiZlIz7kZWH1tWgLjfbVkOtyXempP7rvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Rq9sFqb7zRJJNYzM8CHZXhx8squg0rW7EJRfU9XGW48=;
	b=jeb+SeZrsGoy0YKDlVz7wuzEIPYU2QuvcNJ24HzNmwMNw8AIJxH+tmp6NrTJWMxm/8VP
	 ykaQiq9CBWfbaeXhgF+URopSwyb0vel+0MMPJ84BN2YzcSMYSEExADHKLJpi+Kb1AMStP
	 mzLma2SeriH3W2WXvCi0oCz2upy1UaX+SOIsvsLu2nd5+3153951DAyjdkKzyJlMZFJWX
	 6UoJ3qkChv8z2lOLeFTDSyt9IraiUQXLufsyTW5pkGFrN70n4DLmKuW3tzpVfzeAiHaDx
	 HUuKwEKHOP51tMg9Ip59vC7wKdqpiXBB0zEckPN7BPox7mDopZbx/sqyBlxVAPuq5aA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826791;
	bh=Rq9sFqb7zRJJNYzM8CHZXhx8squg0rW7EJRfU9XGW48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wa+GptQgOiTW/f5ncXTMcFRPCcIrr4iKxbKPM/pWMSbYh8j+uKxPnDFY2nxJPaZww
	 rbULaia0xIhmtdBtkueilBzFEeiuiUj/Y6Cxu9fEe/nojyaIzSk+/yrF06diDR0GVK
	 b0ppw3kLDj11iLTLMrlz5iZXgv22gXH3tG+3bQ+6QSnjr7MqKVvKtx3AueRyv2EjDG
	 AIeZ7YlxKI+w586WinCevAWsilfyaZldnjAK+JOx0foUbD0a1SbeytgEhRxSTt3one
	 GDJ2Qi507o4Mzs5SWrKB7CABktKpvWabaTiGeoiPiuTLzixfSZXvo9qty4ltojlrHW
	 EQ4Ez8PKJOeUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77B8B4069D;
	Mon, 16 Nov 2026 10:59:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8DB01A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4556607B1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qoKH4pt0p5IA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73762606CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ou3fxEUI
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73762606CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso10578455e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826773; x=1795431573;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rq9sFqb7zRJJNYzM8CHZXhx8squg0rW7EJRfU9XGW48=;
 b=ou3fxEUIovTrd45zde8JY8Z/EvzrJIRa3GkO00NqveRkpNktABdv4yI+COZZZCbYtx
 r+Fe/eN4mMtf5kuC0nqnTnrYaXUVGHpCGJcMkxPQaznHQMDKofLdtTJfxte1z1FmPPKt
 GYMF2+dhiouijEm6/isA9PGt1i6zb033KkXTE01XKbc2Q0t0NlOIJgsL+Upc2HeU90Gp
 V0HAzT7WoaFyS3m4Bg9Y81oOs1AbNJxABk7lmBE2yQs9dxC4iaKHQg2kOi3j1EcI6O3r
 Ctk3YNalfIoBsWS63PSjY1fk2iW2KVwdc0pmKCPn9XV6TMourLZSBYC924qNvWP4Lkn9
 8JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826773; x=1795431573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rq9sFqb7zRJJNYzM8CHZXhx8squg0rW7EJRfU9XGW48=;
 b=Ivks8RQQPrtwpOI7hp4KP9ZBjzs5BhEHw3Ik1+SpCK6ZSv9VqQjiGG/fUn2Vxzao3M
 Nyo4ibGCXuCtOt7jZidi4zMZRZGj/oCUu4vCPA/YJc64YyW7pldTv5nV9Kg+opMEeWlg
 PvO+/BkfhIAMFvp1ITcVYpEorSbDT30YBu03Jmgijukt6KMsmuuxQL3bV2IM7QOL0wtB
 rBDBcq5hx09re7soxedRP1AFXWOvjkSmdnsy9LrE9ZbQ5D+Q+GV6Vcn6BH4DjK/pLrxP
 88Z4Rjx0/VocCcvWeFRcGr3sYWAa+pBsKWOOZ/hXq4SF9f6/IKX12KI0xQEI4JD0ENTQ
 m7HA==
X-Gm-Message-State: APuU4Z84Zwku5QPRxEq12ymPTfIqQsf9D5yIxCd5S+2vCefWAUSYf4gW
 yt9T1uF6Qk39tgh17GK40sphva+wyNFEs+6VWWMHpEwNZfmixmyT85sjAZnl9O8tSb4=
X-Gm-Gg: AYBFou3KvfF2K2fl9v7DFL6bPPsJ3g/gdCxt9e6aioL2aLd9tandT8sozpp/47sGdYf
 G3SHj+LRB0zRVXmBaFJBqrr8pyiskEOwsPkkSqi0Iqloj0qSTWzqXAop0Qyxcvezsc5kv54Sp7+
 Dsm4xEFWR6zO0vJapDrflGanpeTvublK2Z7Eo86Aqi2CQ+kH4fWNnTH2Bn9EL5zFBVJzYeX3O3v
 KIKuYTgLFGw+rqEkzlHajqvILGDr5dcYjtqq3oP3M82o7PWxRLoqKQHbYZOXM9ljA6Ej6WDh9mm
 RlAeeM5+7jbF+oDd2vEMuOCHNK+11MU7JXTD9cOJ6zmTF/ZV7NCM6thA3Ot0Rhg4d96t6cazqnm
 hT6fpi4c63stCO5cyd8FQZIPy8EbDSbq4PR93pTdVOAqUFBdg8VePmHv15PUqNrsA4OOgKJ3kcD
 19NXBNW1N7eByxQCUq36iJFVsK2QsUhtNdE/5yNdb0DhYP3EGm7DkrJsU+rZkRYVAoQnQW2Smwa
 0jgAYxPThMD+bol+GBgBRAdybJ8r/1FfYpjDKc2tNBbtP1AGRLVr2YxXnkTe8XSTL97nVeNoY8g
 2aHdbeR087rn4fSZuHVRUor9vd6MmTejIZKTFJTL9vmDkJ6XvQ==
X-Received: by 2002:a05:600c:3551:b0:4bb:534b:ada4 with SMTP id
 5b1f17b1804b1-4bb55abdc18mr222701115e9.33.1794826772841; 
 Mon, 16 Nov 2026 02:59:32 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:32 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:29 +0000
Subject: [PATCH v3 09/15] test: Disable running event_dump test for make check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-9-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.16.0
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The event dump script does not work on more recent versions of binutils
so disable it from running for the moment.

This is a known issue and was already addressed in CI last year.

commit 9420160a0d14 ("CI: Move to Ubuntu 24.04 'Noble' as the base")

The error is that in recent versions of binutils addr2line cannot get the
source reference for static functions. Whether the information is missing from
the debug data or is just a failure of addr2line is not known.

Below is the error log from running the test.
__________________________________________________________ test_event_dump ___________________________________________________________
test/py/tests/test_event_dump.py:26: in test_event_dump
    assert re.match(expect, out, re.MULTILINE) is not None
E   AssertionError: assert None is not None
E    +  where None = <function match at 0x7f0798574e00>('.*Event type         Id                              Source location\n--------------------  ----------------------...check .*arch/sandbox/cpu/start.c:.*\nEVT_TEST              h_adder_simple             .*test/common/event.c:', 'Event type            Id                     Source location\n-------------------- ------------------------...pt_check build-sandbox/../arch/sandbox/cpu/start.c:61\nEVT_TEST h_adder_simple                  :?\n', re.MULTILINE)
E    +    where <function match at 0x7f0798574e00> = re.match
E    +    and   re.MULTILINE = re.MULTILINE
-------------------------------------------------------- Captured stdout call --------------------------------------------------------
+scripts/event_dump.py /home/andrew/src/work/u-boot/build-sandbox/u-boot
Event type            Id                              Source location
--------------------  ------------------------------ ------------------------------
EVT_DM_PRE_REMOVE     dm_mdio_mux_parent_pre_remove   :?
EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         :?
EVT_LAST_STAGE_INIT   efi_block_device_create         :?
EVT_LAST_STAGE_INIT   install_smbios_table            :?
EVT_LAST_STAGE_INIT   tpm_evt_autostart               :?
EVT_MISC_INIT_F       sandbox_early_getopt_check build-sandbox/../arch/sandbox/cpu/start.c:61
EVT_TEST              h_adder_simple                  :?
====================================================== short test summary info =======================================================
FAILED test/py/tests/test_event_dump.py::test_event_dump - AssertionError: assert None is not None
========================= 1 failed, 1151 passed, 170 skipped, 345 deselected, 1 xfailed in 147.30s (0:02:27) =========================

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/run b/test/run
index 17e78815fa7..d1654dffb5f 100755
--- a/test/run
+++ b/test/run
@@ -15,8 +15,9 @@ run_test() {
 
 # Select test attributes
 ut_mark_expr=test_ut
+mark_expr="not event_dump"
 if [ "$1" = "quick" ]; then
-	mark_expr="not slow"
+	mark_expr="not slow and not event_dump"
 	ut_mark_expr="test_ut and not slow"
 	skip=--skip-net-tests
 fi
@@ -32,7 +33,7 @@ if [ "$1" = "parallel" ]; then
 	para="-n${jobs} -q"
 	prompt="Building and..."
 	skip=--skip-net-tests
-	mark_expr="not slow and not bootstd and not spi_flash"
+	mark_expr="not slow and not bootstd and not spi_flash and not event_dump"
 	ut_mark_expr="test_ut and not slow and not bootstd and not spi_flash"
 	echo "Note: test log is garbled with parallel tests"
 fi

-- 
2.47.3

