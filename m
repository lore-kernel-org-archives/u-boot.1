Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B053C982DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1C5660DC5;
	Fri, 18 Sep 2026 17:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZT1DOs_vCHX; Fri, 18 Sep 2026 17:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4421D60DB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789753547;
	b=KhErUS3x8mTaba9CSTCO1exPSORoWlWc7Vf2ejrGd09/Rz4cOtoJwk/z4io3ueBjGAok
	 bS1bEYDD6gMxPuCqoN6fv53QoL9BEQ6iDEd/bw9273OZLxCd9oy09Xp/5f2SdJtTBfGeu
	 /6RZxVXAMAdUPwlr0fPKF4173gu/NXiBxMxjmNv2RxQ1pQ1wtwyQ48v+9ZxsuPVA5jAFw
	 iv2uwgvO4ALbjP1hPd5UZjL7iM6Mhxnef+qupiyHL+oU6qMoPbtHkjeYhr56PT22i6tsB
	 7m/aLWQySDh9OUyJ1VG0oth47l+kaRTFgN+nfQkBLeQhjGEiU9wsDn9zaXbjt9x5+ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789753547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pk7G2I4/KK7TmdJ0mfdYR4MqwWT7IE8QYEFZb/tYoQ4=;
	b=NaJNolzH/DExnHmaTwGz3p5wq+esQvcrTcouvBfT8GwLIeQplPAabBFp8SBDTFlFMa6b
	 EVy6dBYOM38AmwlvVjC1YDBFJNTX4bA1vhrQHKrHZnMForMKI/fUFJdPF9e9M1gK+86IH
	 WUiLxzIY5MeTsK4ItG//uBFaqhpKwqYbW1vbjT0FVCLbBSr5rVD1VoOrBDCr9sSWILEsb
	 3mLjEVmFiyioX1MieDT2o7eibRGP5B6tYIG9zx/8Ailxeg6A2vDuQCNFskrGxKJJQbVzr
	 QWN17R//2tPdVBmh4cP5YPx02Mrs7jMvE9HVxL+43NCPsVo6eegU+MIT9EKjRqBnCxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=D2Y4Vfgt;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=CpzS85NN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789753546;
	bh=pk7G2I4/KK7TmdJ0mfdYR4MqwWT7IE8QYEFZb/tYoQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Txovu3C4sqEajF5RxgzjFF9YYTizKijKZc2i6oLx6mz+JllUW77rHNvEf9w/HajtS
	 V4YBC/CNOREVMXtCXTaLh5GrzyzNz7re/aCr8kG6qHoBF1WImnQ1Of5bN1iZMWLdvA
	 BWOOPcEJpiTjrVKKoG7vF3onqGKi2fje7Qc7ka62zK1eNQrgowXistRarF+iU9XyLh
	 8hoxz7vvnYZr3EYxIkZQXLVaLtjZdWxxDMChfXOD1NnA4SR9LWGoVkHAlPyrrUg/Y7
	 qFdjXAvXFPD2LkoXTOLeJpQfXGBniFP5YzYFeRA1DJBflJG3Qp4accV+9Q45h1Rg+c
	 VCYVq5HZepmng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4421D60DB6;
	Fri, 18 Sep 2026 17:45:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B544513D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A762260622
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qA6sMQi9csWi for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CDF0560659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789752170;
 b=mJSj7VsU9h+qLSHPUDxd6ZVDXI9/cBvMsbdN5aa0M1fbg3QOUibuCXPoFC7oc5VBUfnO
 UN9PKX8K90XGfBrSQt34YZhiu8CNNULyBPZEWWRxxCLK/oyGHcEQkmXFbGkxg8r8z5y0k
 iWssPW+w+vqQr26pLrdnqySJvfhIaMSq3XoRn2JRFVrfHuI1oMVhLZyijV/fPCiu6V+su
 uN9+frRWMxP0qMRMT/fsc3RIgUHNWWoEOLU4h6AUWyu8O6QaG1b0Tq0JswSlCP+ObwJtm
 /xUKkyMcTlJXhV8MsXySblC9FWNHRRNcReDQE0ke/TYB2bWZNGiFpLZrDFNQ59kGSvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789752170;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=pk7G2I4/KK7TmdJ0mfdYR4MqwWT7IE8QYEFZb/tYoQ4=;
 b=U29B8sUV558bygKiA/LDqCk4N4zQahym2qWci3PwwBKDADboATRtQ0l/aRPtc0Mh2pfA
 src40eZm+PqEE7uJfCx+udgGXX1+f/f2wSRXkDTnQ61rTRliBVfkWRfeB5OczF60rcXyW
 OLXjMKBaHQ7OhwCGidaVozRaU+u+J+T5uEuJKuOHVoyJPh1qFAhDVLaFvT3mEJ2YSXwbR
 0XTpIV2V/cfjqLYb2tAYnt+k6Fdj9cEUl/hwsTdiUGWMr09gTN12pPY0o37KwXKTxGGSZ
 QGHe1IJGV7BOxF9/RzAOAJ8Red/bJJ5eFZLxFk3z4azEMiDRp0oa8JhI1FkKU1xHQnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=D2Y4Vfgt; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=CpzS85NN; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=D2Y4Vfgt; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=CpzS85NN
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDF0560659
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789752104;
 x=1790356904; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=pk7G2I4/KK7TmdJ0mfdYR4MqwWT7IE8QYEFZb/tYoQ4=;
 b=D2Y4VfgtHRjf6cKY3Kl4Yv5TGsX7lcKCTGwOBFjcy5XvfiiFWVbJ2R1jywA5n0W3f5HzTTDpVMh6Z
 rGizxgsSZeooUTihUMQtYGW3TEUnd0W0lh19FQ/zpLr8aTIrbdn1VbuGyG6iInFroGIZ1vsi8khx7b
 ADUYY9orfbxM4jO7MLd/2pD1dkDKknNctE3Rn9fDG+MQz/aG7ijx6HxyuutVXs0ujMa/FwtyJhn/Z1
 5Gm/Ycsg3rNarBkkecMTYuSd8qyt9cwEOwl1E87vFDqMhJ+eSFwX6DuTCF14YspdYpMYaaMa/ASq35
 rGSJPXKaH0yCIvyEjd419zBxvEXMiBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789752104;
 x=1790356904; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=pk7G2I4/KK7TmdJ0mfdYR4MqwWT7IE8QYEFZb/tYoQ4=;
 b=CpzS85NNAJ9eVspkqULBYn5XsMdxBp4e0RG80eja4iXOJk9IfXAuFY/jXLgk6kLdPH8q9aySBkh9U
 zT4d4sVBQ==
X-HalOne-ID: 6a6c2187-b385-11f1-aa69-6d49bcc6f3f8
Received: from xps-13.www.tendawifi.com (unknown [41.251.77.168])
 by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 6a6c2187-b385-11f1-aa69-6d49bcc6f3f8;
 Fri, 18 Sep 2026 17:21:43 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, mkorpershoek@kernel.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com,
 Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [PATCH 4/4] doc: describe ML-DSA verification
Date: Fri, 18 Sep 2026 18:21:27 +0100
Message-ID: <20260918172127.66014-5-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 17:45:38 +0000
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

Document the verifier config symbol and the raw FIPS 204 public-key
and signature encodings accepted by the public API. Describe the
single per-parameter-set workspace allocation.

Record the exact Linux file revisions used for the port. Explain which
kernel facilities were dropped or replaced by U-Boot equivalents.

Note that the initial API takes one contiguous message. State that FIT
and mkimage integration is deferred to a separate series.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 doc/develop/index.rst |  1 +
 doc/develop/mldsa.rst | 67 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 doc/develop/mldsa.rst

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 51fd68fa04b..61feebb0bd5 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -16,6 +16,7 @@ General
    docstyle
    kconfig
    memory
+   mldsa
    process
    release_cycle
    security
diff --git a/doc/develop/mldsa.rst b/doc/develop/mldsa.rst
new file mode 100644
index 00000000000..371746edf21
--- /dev/null
+++ b/doc/develop/mldsa.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+ML-DSA verification
+===================
+
+U-Boot provides a FIT-independent verifier for pure ML-DSA with an empty
+context string. ``CONFIG_MLDSA_VERIFY`` enables ML-DSA-44, ML-DSA-65 and
+ML-DSA-87; it selects the generic SHAKE implementation. The public API in
+``include/crypto/mldsa.h`` accepts the raw FIPS 204 public-key and signature
+encodings. It does not parse PEM or DER and contains no signing or private-key
+code.
+
+Verification makes a single heap allocation whose size depends on the
+parameter set and ABI alignment. Targets with 8-byte ``u64`` alignment use
+8800 bytes for ML-DSA-44, 10336 bytes for ML-DSA-65 and 12896 bytes for
+ML-DSA-87. This includes x86_64 and 32-bit ARM EABI. Targets with 4-byte
+``u64`` alignment use 8792 bytes, 10328 bytes and 12888 bytes respectively.
+There is no message-sized allocation or copy. The workspace size does not
+scale with the size of the signed data.
+
+The initial API accepts one contiguous message. Its Linux origin does the same.
+There is no FIT or mkimage integration yet. A follow-up can add a generic
+incremental API that lets the verifier absorb FIT signed regions directly.
+
+Origin
+------
+
+The verifier, SHAKE code, APIs and test vectors were adapted from these exact
+Linux file revisions::
+
+    include/crypto/sha3.h
+        f1799d17285ca99243328cd92133a9f84ee3a593
+    lib/crypto/sha3.c
+        0354d3c1f1b8628e60eceb304b6d2ef75eea6f41
+    include/crypto/mldsa.h
+    lib/crypto/mldsa.c
+        ffd42b6d0420c4be97cc28fd1bb5f4c29e286e98
+    lib/crypto/tests/mldsa_kunit.c
+    lib/crypto/tests/mldsa-testvecs.h
+        ed894faccb8de55cd755e093c4b0971f190d384d
+
+Each imported file header links to its corresponding kernel.org commit. The
+SHA-3 library was introduced by Linux commit
+``0593447248044ab609b43b947d0e198c887ac281``. ML-DSA verification was
+introduced by Linux commit ``64edccea594cf7cb1e2975fdf44531e3377b32db``.
+
+The Linux SPDX identifiers, copyright notices and algorithm commentary are
+retained. The module boilerplate, symbol exports, FIPS self-tests and KUnit
+harness were dropped. ``crypto_xor()``, ``mem_is_zero()`` and
+``memzero_explicit()`` were replaced by local equivalents. ``kmalloc()`` and
+``kfree_sensitive()`` were replaced by ``malloc()`` with an explicit zeroize
+before ``free()``. The ``WARN_ON_ONCE()`` in ``__sha3_update()`` was replaced
+by an early return.
+
+Testing
+-------
+
+``CONFIG_UT_LIB_MLDSA`` adds unit tests that cover all three parameter sets
+using the fixed Linux test vectors. It also adds FIPS 202 SHAKE128 and
+SHAKE256 known-answer tests::
+
+    ut lib lib_shake
+    ut lib lib_mldsa44
+    ut lib lib_mldsa65
+    ut lib lib_mldsa87
+    ut lib lib_mldsa_invalid_alg
+    ut lib lib_mldsa_use_hint
-- 
2.43.0

