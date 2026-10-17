Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC4CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D30E0409C8;
	Sat, 17 Oct 2026 13:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZUyWcwH0MV0; Sat, 17 Oct 2026 13:01:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E78340998
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242095;
	b=pr/yTtiPQUEQKrLmUM1YH8oZzC/JATYpZKePnKsZ3Q8NL2OxnRWwUy5iCGv6+XmarIPM
	 02TotO0udbOf9xqsn7Q2PWZVWyQCbmPiyHBC48uudw5wx9SBLTg488BfPPUk+K1LDew7g
	 FY+i7HUl6GCvaYlmy29p0ZrcijWExB4bViF47RX84UfSNF7D1VKtHIXjJ1y20w4L3/kUD
	 5PK0LpMW7y0zxl8ZYWZ04sii7ZlbP7hUNNjayV5n4fLlS1mm/rYUzyLAiFnp4WT+iLv7E
	 Gu668BADlQ9dKAwgbyY5cccgyePNXaDM7244tnxqPaR2FEhqq0vx9ROCgnoSOi10EQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mZV6Z1lx1AwXK7nuQY5D9qt6fDI2dy4ETBC7xx/FKII=;
	b=rrH6UXZD9zTy9mXScX2JY7ATHoevnEfwvFagkjle/IBK4N40TIZqMI7WmVz0k95FJPKK
	 +J4EszzT4Mjla6+sAtDEM/QGX+8iNFoL9sErvHerUfYxXrgkStHJYxVYlu9ZikHuXbsmn
	 ERNPtXTGH2zczGDnivXU2Hqgh+v28IGFiL6a+HNCCAjR+gAFSA+WE4rJ7l3SsoXG4ds9V
	 cJ6g5AQYJRZlgM3CRrBm6uEgB6d3AXidKV/EgOXT7wy5KZ9b70+L4mICgWeegUXYrVcFz
	 RnunwHVWiecOgsqqdEactmdQFO48Ppl3q/WaD2whU5cCqinCJZgtrvTYFd9g0mOLObQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242095;
	bh=mZV6Z1lx1AwXK7nuQY5D9qt6fDI2dy4ETBC7xx/FKII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HjvUYRba1WvZ92+BvtPsBLkmxStZ+iiK0WoiyJROja63TTnwA9WTAI3WIOCp/l9qb
	 p849pK4rihn6B4KpT6RPoBr+VtKFchHqu+dq9qzCS7DLSo8GqEo8orMpfhUJXU+w/b
	 gDkpv8fLe5LWyYxevENxOIkPnl2UX2MnMHp5shyWjmpyCanx/70HpmvLXi5+M5j8u2
	 aD5WV2EFjDiZnG5skP8OtW7FVn9aIpxDJMwurswsPyqEIj26coYHEf4P/QllgWg6Lw
	 2+I42HJzR77pyAlBvxCYG801FHwWFb8ywZeepJ04sHiN++Yndj7ewXdgamU059a/FO
	 xdy3m0p2g06VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E78340998;
	Sat, 17 Oct 2026 13:01:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26E97362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 190C0400C5
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cX-dw_jlvTdy for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4D84B40082
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=lDmPFBdxKkBMkb8aqmQA8NZaoNW6hEVepMfBiBiijU/0esqRcuKKN+g6vq4HkXzHj3M4
 MvdXcJKlIB0nRSPCegv9DfIIRS1i5RHd6tYQy22plaxkVWVanc5ijxeCA53gvjhZSLyjB
 jeNbWc86WdkFPrHT8SU9boLR6FfW4C5W3Zx7c0MT+h0EKegRtlaIGVzWUcoo6yFnrgho7
 u0krTv0a6ylx4AGZVQ71fh98XMSw7qdFPggi1t25cIjMl5bBMx5YptJYqMEZ/IkSlbhff
 qmr4fk1+h46TSwl4LUksHr2lVpaCYiSJFhnHQTeHb9Jp3iTt6RaxPn7fvyQxJ3WmSNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=mZV6Z1lx1AwXK7nuQY5D9qt6fDI2dy4ETBC7xx/FKII=;
 b=CR1Po7QPcsArPwkovWqdKFXqE9HC9Kkutz/1I3BNkMv5fgapMeNEgJcq8i/lv6wqlPjz
 c7yNftMEKDP6tKGUziBnL0X90WXsNCoUXD6M5RdoIv6MxZEbGai220vdXx+86ARGLjYPq
 VYJQfpxrkTUd60WT4qmDDJ6BD3etHJu6EuhqNAQGZKkgmD+t08a/lEvRGRLa2AfyXXEHR
 tw5uiObCAo7jKnax2ZGXqudrjvGM5QdK/qzIJGAHqgVYGL3k5l4qZsGrBFQlXJzGSyxo4
 AUEBw+xvjo/u2v/uEgVP0rJnhHcr+kqbEieLOnPSLNLcp1IPuH3QyOkRpaJRVQaufGQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jFhdwmAG; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jFhdwmAG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D84B40082
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7000360AA5;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24F7AC2BCFA;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=4nDaQrAviPf4L3WXaNcZOKfqQHNGvjHkCZy8y4AfygY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=jFhdwmAGImGqsYVWYAHLrI/pOgyWuzTU9/JjjEcIxMKMO6DDLH1phKvoZVcJ+U6il
 LmQ8jDoT1k5+BqKy7VJLpcF8tjN160hsZlDT5AByn0urz1MDzUvuDSwgDcfOhmf6YP
 5B3zVFDpHEN4/kX3lckOFV0L9/8ZwKpU5zm6V3UpXb9wNy/j0NbJVsTf68NVPO96Xu
 90w1xkJFeJuITwnr00Fgl1MWcrxBG+g2NZJ8drbWD8zJ6ZasfWvKnSmrWeGJlw2lNh
 vLtSe6sVM92Zp43A/R8tBW+PjA94Et2qI48Uy2r7KuTherfXwlJX4S1br7f2909LNF
 SiA+P8dU/KpMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0F661CCF2C7;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:02 +0200
Subject: [PATCH v2 3/6] binman: test: Add fit,compress device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-3-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=2463;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=+Mpu+0oug3ucO0VgvXFvEiJfvU4lS6VnLgo7Vdl03r8=;
 b=HTHDI0K/iBm8EjgmV6yTZTOHtJC0rz66xjuNlvmJ4110tb+RNLUdlEFwyTEPeINXqq1Sn/FDd
 PdPQ73C175ABoAQyiZYIb2XJ9Q+utcwORkU3MA3GoFUj2jMuPnESVFw
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add two minimal device trees with a FIT containing an @fdt-SEQ template
which uses 'fit,compress': one with "lzma", another on with "xz" which
is currently not supported in SPL and one with an unknown algorithm.

They are used by the tests in the next patch.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/test/fit/fdt_compress.dts     | 24 ++++++++++++++++++++++++
 tools/binman/test/fit/fdt_compress_bad.dts | 24 ++++++++++++++++++++++++
 tools/binman/test/fit/fdt_compress_xz.dts  | 24 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/binman/test/fit/fdt_compress.dts b/tools/binman/test/fit/fdt_compress.dts
new file mode 100644
index 00000000000..77c38fe9e05
--- /dev/null
+++ b/tools/binman/test/fit/fdt_compress.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					fit,compress = "lzma";
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/fit/fdt_compress_bad.dts b/tools/binman/test/fit/fdt_compress_bad.dts
new file mode 100644
index 00000000000..93ea20272a4
--- /dev/null
+++ b/tools/binman/test/fit/fdt_compress_bad.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					fit,compress = "bad";
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/fit/fdt_compress_xz.dts b/tools/binman/test/fit/fdt_compress_xz.dts
new file mode 100644
index 00000000000..6c2d1c89399
--- /dev/null
+++ b/tools/binman/test/fit/fdt_compress_xz.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					fit,compress = "xz";
+				};
+			};
+		};
+	};
+};

-- 
2.55.0


