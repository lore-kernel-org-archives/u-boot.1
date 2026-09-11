Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB3C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7930606BD;
	Sat, 12 Sep 2026 01:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mofbTy4D8ezv; Sat, 12 Sep 2026 01:07:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6DBD1606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175260;
	b=rLiXcniSgQlF9G9FeJXhD1Bfy5R+JZ2E3Y4U9hb8LexprZIxkhCuJJo2yKyk9nxGa8F/
	 vCPCZan4hlX8ph4pGBz9pLB2DCUH12cuureh6hyXvl2d0hHpt6k1wSEkSDcQsY8is2duX
	 BGV5lnDmZrVfR81B3+psf09qFY8iaIYpX6ZSofQ87wVQxZ+wmOauE2ZvjSvMDso9+8Mx/
	 S4bKje9hPqYGpQAeV8TQaGmIhxO9u1AsUR0PcdlfSyjfFQ3fepsCS4hkW7nivditz12eX
	 LurcqLs4UO62H/aKeWjDh+8htwXva2q80eEyhobimhy4B1qnN/aHFyh5t8Pc2kIs0Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=eO1DzABQ/A9kseeFA2Beoh2b1u/UCC+hwXAQD7S4l2o=;
	b=pU8vZ4bSjTh1k8DXPZdBWg5lSNRHT78MgWeG7d29Gupjbr1u1VTx9jEagjkJViSeROJU
	 LDgz0/XEdUMTSmstv2by9EOfokAav1P6yVUcupycgtgjnxG5VhyK1lmUVqmTm2RJyI0b8
	 gTR4MjAxlQln/t0MiiaO4mbrDyY8zpR0dXVTdcSbWhnvkHzWd7fPdZkFWwXxBE1BUVYQm
	 haobr1TbdF9qw8oRQs78DOq+Mt6879mC1E817sjyD2sZfrfahVz7Jb4ZwG+9NJaYhDGU7
	 sGwlnAcMAXObVEfeUw/IzkHfiHSby63KFGMrIjtnXcgsZimsKi2TRj07UiQXZiCHUvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DlUE9qYo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175260;
	bh=eO1DzABQ/A9kseeFA2Beoh2b1u/UCC+hwXAQD7S4l2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kFmUCvnjxmzb+so9BTqEvnoW1JVz23GqfRtKC87j5CjJEniooZROVxkQc0a35/7WX
	 Yw61Pf/Y1K68CwRZ4SUWX67RoXFD7+OO5mMg67mUiLW8vg6IMD96S+hYv/iqYa3S6K
	 LFtguicR6KUOoR3L0osxihSqGTRXtTUdyMsxyuRxLr8em9o6yB5KKiZP1AIH0lPiEP
	 A3jMYjndEk58VA0yZjd/zqkNZ0IizFoQgz29kBPWR1cRmN62OU2QI0fKMCDJvhlHDv
	 N3iWM+tUjDvdnqZnQxSnXr/T6yHbMG9wkHrMSl9BCn0yisZNj8UYSnN0gtqu9Isoc5
	 N6Lbki7dTbl3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DBD1606E1;
	Sat, 12 Sep 2026 01:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7203EE45
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57EDB60617
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9Zmd8OoxHxB for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E04E605ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789151120;
 b=ZFZymTeSrzEK9NazcL4cVYfDKvxHlwkkuNq+BSbjYI3wxfqifN+WweA0DHYewtsun/9X
 M/KZWj7F6WSlYrV5pw2HwMZ0KS+MCyeNr3D72LcNn2UFMASUk3sLqpg9ksbl6pr59sJyv
 40fC4DVoiVEDlg2wkJqMcugCEs3lyeOi7ZbOxabVcsONFJLC/TkHRGVM6j+XxezZolY+L
 u6auvXDNwcJx3IQhNlV98mCNab89LESMuBc4zE9/1rr1FhWJCnNlD3DnCxzKXgfYcOR2L
 L5qOcKrpXMxvZNIX+wYroPION3GfzelcHCTRax7mINk5VVezniRkpTwu8HDFivIEsUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789151120;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=eO1DzABQ/A9kseeFA2Beoh2b1u/UCC+hwXAQD7S4l2o=;
 b=ZXDmZLWj/DId1Mkh63FdOHXLFwEMyBMfAulrzcT09WG5Y2SgHKihUcMrnZgBNVWq3oPh
 c/Bbj8m40/RkqbQ26d1Y4+RAtCqJjhcmghLOXJkgkpLfXF5uMhkNft0OpU7iw+VE+yXY2
 g7xZDdKRtlg7fVkARlXDEh2yNclJ9bikBiu2bycrBUGjNWvYrqYyo4bZWdzvnalYSBVSD
 3z5hU5i0VeqfmVu0WdeilG5ffYYraLxtZnsRhfjptXlbTyICu/U45RZoCyOpEp4HIC/+z
 mjAiZFC8h/UzYgDqgWBAD24FCQG/0BeHm2UvXAse6/W4BRleVrNrEz4WLKotqhp11rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DlUE9qYo; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DlUE9qYo
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E04E605ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1136160142;
 Fri, 11 Sep 2026 18:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC4CEC2BCFB;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789151118;
 bh=mofdvK62VvJrpMY8so9KgOHlfbNsC3Jv01OHTuPHCm4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DlUE9qYowA6M5G/xOx3PNg9L8qp/exZtZu3uDvEbW5VvDA1h2vvj10ndx9xjwwSIa
 CLMWfbEnPOeMfvz/FQfP2WK2vGIpknFEqZMZPK5uyI7zBqfahxDldi/WB6fngpW6cR
 jt599Un7x42OwuhsT9Wl6x4PQuqg0v51SROuU3Ymw32TZoeHi1VS7W2w97drMYEKNz
 6JKLRjMgE1+UWWkXwBEBdh+JH/n/cbpkeMrHwJs5OeLsfOZ7Mu4JPN/3zOKtQbatcU
 Vh0gwfuO7MVYYnf/R43Hylyknx0RyQCpzwBbYFB2/l6pT5Rh+ehbl4Vrhyxxr+dBRW
 XSlWi4K/81j2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A21EFC88E4D;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:25:17 +0200
Subject: [PATCH u-boot v2 3/3] lib: qrcodegen: optional gzip
 pre-compression of payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-lib-qrcode-v2-3-c5291fb7c646@protonmail.com>
References: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
In-Reply-To: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789151116; l=4601;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=qD1iJ4/0y+YXjHalgq/zQ4IJ/+Vz7XQPPIgIapq2z2c=;
 b=Vd08dXipyHTgu7lT34Za8KijN1Gu7fWxfPDno0M532Lkn4okNmt0yuBiV5TlkEPinxIeLCA+Z
 sgthJeGoAHhBMEy4m9aHerB2+A2UgUYkTmpVF9lK0Ky/bvQiiYo8bvi
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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

Add CONFIG_LIB_QRCODE_GZIP (bool, depends on GZIP_COMPRESSED) and a
new helper qrcodegen_encodeBinaryCompressed() that tries the plain
binary encoder first, and on failure transparently gzip-compresses
the payload and re-encodes it in binary mode with a four-byte "QRGZ"
magic header so the scanner side knows to decompress.

The compressed payload can later be decoded by:
`zbarimg --raw -q <QR_CODE> | tail -c +5 | gunzip`

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 include/qrcodegen.h  | 14 ++++++++++++++
 lib/Kconfig          | 15 +++++++++++++++
 lib/Makefile         |  1 +
 lib/qrcodegen_gzip.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/include/qrcodegen.h b/include/qrcodegen.h
index b67b77a30fe..590b61cd871 100644
--- a/include/qrcodegen.h
+++ b/include/qrcodegen.h
@@ -235,6 +235,20 @@ bool qrcodegen_encodeBinary(uint8_t dataAndTemp[], size_t dataLen, uint8_t qrcod
 	enum qrcodegen_Ecc ecl, int minVersion, int maxVersion, enum qrcodegen_Mask mask, bool boostEcl);
 
 
+#if defined(CONFIG_LIB_QRCODE_GZIP)
+/*
+ * Encode a payload, transparently falling back to gzip compression
+ * if the plain payload does not fit in any QR code version up to
+ * qrcodegen_VERSION_MAX at the requested ECC level.
+ *
+ * Returns true on success, false if neither plain nor gzip-compressed
+ * payload fits.
+ */
+bool qrcodegen_encodeBinaryCompressed(uint8_t dataAndTemp[], size_t dataLen,
+	uint8_t qrcode[], enum qrcodegen_Ecc ecl);
+#endif
+
+
 /*---- Functions (low level) to generate QR Codes ----*/
 
 /* 
diff --git a/lib/Kconfig b/lib/Kconfig
index 5f37a07e512..ed67d2f8161 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -321,6 +321,21 @@ config LIB_QRCODE_MAX_VERSION
 	  pairing tokens or short URLs and want to reclaim the static
 	  buffer footprint. The default of 40 matches upstream Nayuki.
 
+config LIB_QRCODE_GZIP
+	bool "Allow gzip pre-compression of QR code payloads"
+	depends on LIB_QRCODE
+	depends on GZIP_COMPRESSED
+	help
+	  When a payload does not fit in the configured maximum QR code
+	  version, transparently gzip-compress it and re-encode in binary
+	  mode with a four-byte magic header ("QRGZ"), so the scanner side
+	  knows to decompress.
+
+	  Useful for diagnostic / state-dump QR codes where the raw payload
+	  is highly compressible (printable text, log fragments) but would
+	  not otherwise fit a small QR symbol. The plain (uncompressed)
+	  encoder remains the first attempt; this just adds a fallback.
+
 choice
 	prompt "Pseudo-random library support type"
 	depends on NET_RANDOM_ETHADDR || RANDOM_UUID || CMD_UUID || \
diff --git a/lib/Makefile b/lib/Makefile
index 60e62d5e6e2..5f3e5300462 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -129,6 +129,7 @@ obj-y += linux_string.o
 obj-$(CONFIG_$(PHASE_)LMB) += lmb.o
 obj-y += membuf.o
 obj-$(CONFIG_LIB_QRCODE) += qrcodegen.o
+obj-$(CONFIG_LIB_QRCODE_GZIP) += qrcodegen_gzip.o
 obj-$(CONFIG_REGEX) += slre.o
 obj-y += string.o
 obj-y += tables_csum.o
diff --git a/lib/qrcodegen_gzip.c b/lib/qrcodegen_gzip.c
new file mode 100644
index 00000000000..fe0c6567a00
--- /dev/null
+++ b/lib/qrcodegen_gzip.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Optional gzip compression for QR code payloads.
+ */
+
+#include <gzip.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <qrcodegen.h>
+
+#define QRGZ_MAGIC_LEN	4
+
+static const u8 qrgz_magic[QRGZ_MAGIC_LEN] = { 'Q', 'R', 'G', 'Z' };
+
+bool qrcodegen_encodeBinaryCompressed(uint8_t dataAndTemp[], size_t dataLen,
+				      uint8_t qrcode[], enum qrcodegen_Ecc ecl)
+{
+	size_t buf_max = qrcodegen_BUFFER_LEN_FOR_VERSION(qrcodegen_VERSION_MAX);
+	unsigned long out_len;
+	u8 *scratch;
+
+	if (qrcodegen_encodeBinary(dataAndTemp, dataLen, qrcode, ecl,
+				   qrcodegen_VERSION_MIN, qrcodegen_VERSION_MAX,
+				   qrcodegen_Mask_AUTO, true))
+		return true;
+
+	if (buf_max < QRGZ_MAGIC_LEN)
+		return false;
+
+	scratch = qrcode;
+	out_len = buf_max;
+	if (gzip(scratch, &out_len, dataAndTemp, dataLen) != 0)
+		return false;
+
+	if (out_len + QRGZ_MAGIC_LEN > buf_max)
+		return false;
+
+	memmove(dataAndTemp + QRGZ_MAGIC_LEN, scratch, out_len);
+	memcpy(dataAndTemp, qrgz_magic, QRGZ_MAGIC_LEN);
+
+	return qrcodegen_encodeBinary(dataAndTemp, out_len + QRGZ_MAGIC_LEN,
+				      qrcode, ecl, qrcodegen_VERSION_MIN,
+				      qrcodegen_VERSION_MAX, qrcodegen_Mask_AUTO,
+				      true);
+}

-- 
2.55.0


