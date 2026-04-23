Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A5FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29A484314;
	Sat, 25 Apr 2026 20:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="zlkTSDCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66D284370; Sat, 25 Apr 2026 20:29:58 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E8C842E7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-899d6b7b073so94168416d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777141793; x=1777746593;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6no6ML6Iq/qveYgoXgq5rlTzz8LOIQ3UBaDqH7XCbUA=;
 b=zlkTSDCF7xlQ7mE5rUfvvOUQC4/1EDnqlpkh89IJdMoshNalOavYySyEfPyNDqL+Nz
 dRP1U0sVS7PcTAPGDimLzTdlNS6PGw2pmrWODSYQhGPKkB9bKupfXDNEGvcu2s/MCn2/
 AwahS3mylBLhgXNIgZARhkYS44LWrlU76H9uyfyMSfL4JJ8BR5tMy9xZFrUJ/MO6afcA
 VSXcd2LIEyffuiJ41JHpSyQMb21IwKzlDeFPGRB7BdEQAg2vxs6z1urJgE8Vga+dgWkc
 ySHAyezOXUrybXg8FGQYq3rLcpN82d4q0U2XcSP90J70nK5aNoxQgwCrH0DPiIcqdkvR
 4d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141793; x=1777746593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6no6ML6Iq/qveYgoXgq5rlTzz8LOIQ3UBaDqH7XCbUA=;
 b=OM1ScKdRCaIwb76x3NKH8e8J63OVy6sF44h7nVzLUoisAhti2JQsCliz4kAgSTRZDQ
 2GOh0h1e+BZ7JYldGn9r2gYqDHpYyxxa3NdZ6WO6FooNs4ZsKmQOAY6g4d1rJs+4BKal
 rrby0TOxZxWwJdLCh7iTAmVK72x4lcPdAwNV1q8ArGMi5Xk2b+N5RqfJAmx9WtZeNI2U
 06bpZHLZND8UlpVD4ATcrIVnF/qECJcrjFp6g50xA0JvXXcY+9hOn73GFAU0m7lgiVdK
 vPynT+PSvR5f2xiH4KFAqJi0rlFkQppSioye3KiOlCHkvYOwdYTvfdIMyu7ewigX6KkG
 qGoQ==
X-Gm-Message-State: AOJu0YwoXrsGhY0tVl3IfYR5BQBbd/mveB3FZx1lEdbIpcIbIVazafd8
 UbdqnlOqzz28lgvSizzqE5FG9vS4dOyj851Lx9wfm3n695+nDC9qnH8qQ2XRXcQ2SmJsGkvmplL
 ZngTk+lVmAg==
X-Gm-Gg: AeBDietgFtqUmPoFAtAHI72f6JeET9B+Of/CgFbMK2iqbSBqolwaC8xJY58Misarz7a
 DxmqZ5AlTAQnPV+5PCAzsNZ8IekIkoiRL69yF9bJ8Ljp9YF1C4zX0Lmfq0XKKSKJ6g1z8Ai/Acp
 YiW8KTd7TkYqe5Ka2hcgrLaHtNWQDfqNdzffLCdNQve4dq2QkcIalqjFZ1AScStisSS/I0zbqNJ
 qI2WGPQ9dLtqO0FvNzA60nyx1yfGDuvIelmEQr+WLD89ahO2zG5OsjK7xzOKtk2q36PYk9twD00
 PW0Rh6cwD1YB3Hvoav/krbVQwS7BTpSV6U9uosIuTcEpK0JNd3L8vCczAq/M3r43ht5V6NapzbV
 I/aNlMnpscvEPSY6rd7EGN6gk/o5Y+2zME1qDSZwdKbL1PYkbH/mrUxAiWlmndOQG9p1AX6+EaE
 Ygz/fk59GOmK8MyWrXuJ43eRrcCebz/mcG0RNp8Tb1lw==
X-Received: by 2002:a05:693c:3007:b0:2ea:5057:a2f9 with SMTP id
 5a478bee46e88-2ea5057b737mr6662607eec.16.1776959181212; 
 Thu, 23 Apr 2026 08:46:21 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6401:dc31:4200:1760:44a0:9daa])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c86sm33732055eec.1.2026.04.23.08.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:46:20 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, sergio.prado@e-labworks.com,
 jerome.forissier@arm.com, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com
Subject: [PATCH v3 0/2] binman: add PKCS#11/HSM signing support for X509
 certificates
Date: Thu, 23 Apr 2026 12:45:34 -0300
Message-Id: <20260423154536.768603-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Motivation
----------

TI K3 secure boot requires X509 certificates to be signed with a private
key at build time. Until now, binman expected this key to be present as a
plain PEM file on the build host. For production use, however, private keys
should never exist unprotected on a build machine — they belong inside a
Hardware Security Module (HSM) that enforces access control and keeps the
key material unexportable.

This series adds support for signing X509 certificates via any PKCS#11-
capable HSM (YubiKey, TPM, network HSM, SoftHSM2 for development, etc.).

Design
------

Two new make variables are the sole user-visible interface:

  BINMAN_PKCS11_URI    PKCS#11 URI of the signing key on the HSM, e.g.
                       pkcs11:token=mytoken;object=mykey;type=private
  BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so), e.g.
                       /usr/lib/softhsm/libsofthsm2.so (optional when the
                       module is already configured via openssl.cnf or
                       PKCS11_MODULE_PATH)

When BINMAN_PKCS11_URI is set, binman replaces the on-disk keyfile with
the URI at signing time. The PKCS11_PIN environment variable can be used
to supply the token PIN non-interactively; it is appended as a
pin-value=<pin> query parameter to the URI.

The openssl bintool auto-detects which OpenSSL PKCS#11 interface to use:

 - If the pkcs11 provider is loaded (OpenSSL >= 3.1 + pkcs11-provider),
   it uses -provider default -provider pkcs11.
 - Otherwise it falls back to the legacy libp11 engine
   (-engine pkcs11 -keyform engine).

Detection is done once via 'openssl list -providers' and the result is
cached, so there is no per-signing subprocess overhead.

Testing
-------

Tested on a Toradex Verdin AM62 (verdin-am62_a53_defconfig) board with
both legacy engine path and pkcs11 provider path using SoftHSM2 and
YubiKey 5 NFC.

A subtle issue was discovered during testing: binman uses a
ThreadPoolExecutor internally (etype/section.py) and may call multiple
ObtainContents() methods concurrently even under make -j1. SoftHSM2 and
some real HSMs do not support simultaneous logins from different threads,
which caused intermittent "login failed" and "object not found" errors
during multi-certificate builds. To fix it, a module-level threading.Lock
was used to serialise all PKCS#11 signing calls.

Test coverage: btool/openssl.py and etype/x509_cert.py remain at 100%
(verified with 'binman test -T').

Changes in v3:
- Split into two patches: bintool infrastructure (1/2) and x509_cert
  feature (2/2)
- Fix global environment mutation: _run_cmd_pkcs11() no longer writes to
  os.environ directly; it now uses the new extra_env parameter so module
  paths are scoped to the subprocess only, which is both cleaner and safe
  under concurrent execution
- Add module-level threading.Lock to serialise concurrent PKCS#11 signing
  calls and fix intermittent login failures caused by binman's
  ThreadPoolExecutor
- Fix URI query string separator: use '&' when the URI already contains
  '?' (e.g. module-path already present), '?' otherwise
- Test cases updated

Changes in v2:
- Add tests for _build_key_args() (PEM path, PKCS#11 provider, PKCS#11
  engine, PIN appending), _pkcs11_use_provider() (caching),
  _run_cmd_pkcs11() (with and without module path), and end-to-end
  x509_cert signing with a PKCS#11 URI (testX509CertPkcs11), ensuring
  btool/openssl.py and etype/x509_cert.py have 100% test coverage

Sergio Prado (2):
  binman: bintool: add extra_env parameter to run_cmd
  binman: x509_cert: add PKCS#11/HSM signing support

 Makefile                        |   2 +
 tools/binman/binman.rst         |  18 +++++
 tools/binman/bintool.py         |  15 +++-
 tools/binman/btool/openssl.py   | 117 +++++++++++++++++++++++++++-----
 tools/binman/etype/x509_cert.py |  47 +++++++++++--
 tools/binman/ftest.py           | 110 ++++++++++++++++++++++++++++++
 6 files changed, 286 insertions(+), 23 deletions(-)

-- 
2.34.1
