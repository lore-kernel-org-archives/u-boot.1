Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DDDCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00D2846A5;
	Mon, 25 May 2026 15:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="K+wxBB9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A2A846AA; Mon, 25 May 2026 15:29:06 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E3B8460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5753a289955so3277186e0c.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1779715742; x=1780320542;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k5UayhjS7tLxxe32aqziP8W9VsJwqs+yKb3AqFf2DwA=;
 b=K+wxBB9XWKJ9cF1+O0nY4gQKvhRfS/gdZhbjAZcrP706WPKj8FuItJNLopJxWFznSd
 z0215jj0mH03/EfbOsm/+MqVqAHBeer+/w5n3X9i9indlPxvTHXgYlwt07rtGX84b4P5
 JMx9pacvJzr5w6XmsRQhjxv7tmayNUFVjGhWwepZxSjcOdwuSUKROpjwky9rRnk4LY5n
 s6Vh2QgmpFp0Smz5IjczzhpGe7zar1DMTusb92xED5Auns/tmwvNwr413rkQ0yNgiDnO
 9Hoqe2JLkoT3v1N4aID+ku8CG+P/JhJou2yucnQSk4EuDkrExqw1axhYXKdJgzTUPdhK
 TV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715742; x=1780320542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5UayhjS7tLxxe32aqziP8W9VsJwqs+yKb3AqFf2DwA=;
 b=Izn7KfN1gaB/WvMi/FgUpnCNK3jNJyCOWKxliwHKZe8fbqQaxbhsEWB94yqIHoSi+W
 n21xtzikty4xV9dScGTFU0amjJWfAQY0eLEaYf7RISsWUUKgs68Yy0o5fbRMc7T/FPiF
 NepkQ7ZJ/7NoMx0VbxVMgslKAqCg+LU2Px2+0r0hRY0MHCM7BjK160zIFdoMRPesTEPD
 4cHzo6twum7eF9JD1HvCLXUJrprDd9i/uzVd5ZCsCPfnBP6cmzspD76ZMfFk9+Iv+f+2
 2jaw5DCfWazI5Y/lzXskOQfKjJbuuufYAN8Ky3RS96YEIBjeojp75w/P8HS0KuDz+Axj
 3Xlg==
X-Gm-Message-State: AOJu0YymEn3LFuWSzho2C7KYpR6wqyOV3HIT8l+GL66gvS/qWC8WbpYL
 KhKSU6uHvzLcWkj2/ikHiYuzSDDjby5Y1fhETXDS510fVYcYqCB804UkRHi4m6hDD3YgBfc6Aoz
 mYx3+
X-Gm-Gg: Acq92OHn85veKfi2eRS6uIjsiHss65dko3wxhUO23e8ucil9s9j+DftdirqoBTxjhNf
 guDndGe26PV2Sbxl3bcaaPOiY6RZGiN/mLDOJlxrXeXpZlpIudlSvbpIZJ5MQA6GuTIXol2JN/3
 EpnZrNtVpU5ZXVMHYpSeN2MOS2aIrkvJWtUcVvzhDQ22ekUB0OoAKp+illLf0nSsByCOZ6dKP7V
 5PR+tduidtxDQVYAOhll9RrPYBA37CIolvQJsXKS8Pu4woQP7qOxfVCQLW+USyBfWQATLZBma9M
 Rn+eKtifMERA9+qZrti5OiABnUJ2myK+Kh0JZbONbq+OK10d5A6ArkPYhTfFreFeIO7zo/54YOk
 5urxx9lu32xEpO3alkPPCb7RevyvsfaYWq8CeVsWlXOCL18NccGtEvsTzB4xlRTOFalbA6jx1nJ
 +sv1dS174q+ye5mFMyFEofpKW6oEa+33kQSAve/wFbiGTiMmUhP4YE
X-Received: by 2002:a05:6122:2215:b0:56c:ce8a:b07a with SMTP id
 71dfb90a1353d-58660d810c9mr6731865e0c.7.1779715742140; 
 Mon, 25 May 2026 06:29:02 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:4198:c5e1:5c3b:8861:210f])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f791f097sm11647484e0c.9.2026.05.25.06.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:29:01 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v5 0/2] binman: add PKCS#11/HSM signing support for X509
 certificates
Date: Mon, 25 May 2026 10:28:26 -0300
Message-Id: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
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
key at build time. Until now, binman expected this key to be present as
a plain PEM file on the build host. For production use, however, private
keys should never exist unprotected on a build machine — they belong
inside a Hardware Security Module (HSM) that enforces access control and
keeps the key material unexportable.

This series adds support for signing X509 certificates via any PKCS#11-
capable HSM (YubiKey, TPM, network HSM, SoftHSM2 for development, etc.).

Design
------

The 'keyfile' entry argument of x509_cert (and its TI K3 subclasses)
now accepts either a filesystem path to a PEM key, as before, or a
PKCS#11 URI referring to a key stored in an HSM. The URI is forwarded
as-is to 'openssl -key', which resolves it via the pkcs11 provider (or
engine) configured externally through OPENSSL_CONF. This keeps binman
itself free of any PKCS#11-specific knowledge.

A new make variable, BINMAN_X509_KEY_URI, overrides the 'keyfile' entry
argument for all x509 certificate signing operations:

    make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
         OPENSSL_CONF=/path/to/openssl.cnf

The recommended way to deliver the PIN for non-interactive signing is
to configure pkcs11-module-token-pin in openssl.cnf under the pkcs11
provider section. As a convenience fallback, the PKCS11_PIN environment
variable can be set; its value is appended to the URI as a percent-
encoded ?pin-value=<pin> (per RFC 7512) so the PIN does not have to be
embedded in BINMAN_X509_KEY_URI.

Two URI forms are supported on OpenSSL 3.x:

  - Provider path (recommended), via the pkcs11-provider package
  - Engine path, prefixed with org.openssl.engine:<engine_name>: so
    OpenSSL 3.x's STORE API routes it to the engine

Testing
-------

Tested on a Toradex Verdin AM62 (verdin-am62_a53_defconfig) board with
both the engine path and the pkcs11 provider path, using SoftHSM2 and
YubiKey 5 NFC.

A SoftHSM2-based integration test (testX509CertPkcs11) exercises the
full signing path end-to-end against an in-tree test key; it skips
cleanly when the OpenSSL pkcs11 provider is not installed. A unit test
(testX509CertBuildPkcs11Key) covers the URI/PIN combiner including
percent-encoding of reserved characters.

Changes in v5:
- Split the Entry_x509_cert docstring expansion into a separate
  preparatory commit (Simon)
- Unify URI support under the existing 'keyfile' entry argument
  rather than introducing a new 'x509-key-uri' arg; drop the
  Entry_x509_cert state and override logic that v4 added (Quentin)
- Percent-encode the PIN before appending to the URI using
  urllib.parse.quote(), per RFC 7512, and add a unit test
  covering PINs with reserved characters (Simon)
- Detect the OpenSSL pkcs11 provider via
  'openssl list -providers -provider pkcs11' rather than discovering
  the provider .so path manually; drops the 'openssl version -m'
  MODULESDIR lookup (Quentin)
- Drop the 'p11-kit print-config' / softhsm2 .so discovery from the
  test; the simpler openssl.cnf relies on softhsm2 being registered
  with p11-kit globally (Quentin). As a side effect this also fixes
  the test on Ubuntu 22.04, where 'p11-kit print-config' is not a
  valid subcommand
- Move the test openssl.cnf in-tree as
  tools/binman/test/fit/openssl_provider.conf and trim it to the
  minimum needed (no 'module = ', no 'pkcs11-module-path = ') (Quentin)
- Replace 'pkcs11-tool --keypairgen' with 'softhsm2-util --import' of
  tools/binman/test/fit/rsa2048.key so the test runs faster and drops
  the pkcs11-tool dependency (Quentin)
- Recommend pkcs11-module-token-pin in openssl.cnf as the primary
  way to deliver the PIN; PKCS11_PIN env var is now documented as
  the convenience fallback (Quentin)
- Drop the incorrect claim that PKCS11_PIN keeps the PIN out of
  shell history (Quentin)
- Rephrase the URI intro in binman.rst and clarify that
  'pkcs11-provider' is a Debian package name, not a path (Quentin)
- Drop the inheritance notes added to Entry_ti_secure and
  Entry_ti_secure_rom in v4; with the v5 keyfile unification the
  original motivation (an inherited x509-key-uri property) no
  longer applies

Changes in v4:
- Drop the v3 bintool extra_env commit entirely; binman no longer
  sets any PKCS#11-related environment variables (Quentin)
- Drop BINMAN_PKCS11_MODULE / pkcs11-module entry argument; the
  PKCS#11 module path must be configured externally via openssl.cnf
  (Quentin)
- Drop provider/engine auto-detection (_pkcs11_use_provider,
  _build_key_args, _run_cmd_pkcs11) along with the threading.Lock;
  the user selects provider or engine via OPENSSL_CONF and the URI
  form (Quentin)
- Rename the v3 BINMAN_PKCS11_URI / pkcs11-uri to BINMAN_X509_KEY_URI
  / x509-key-uri to scope the names to x509 certificate entries
  without locking them to a specific URI scheme (Quentin)
- Document that the engine path is supported on OpenSSL 3.x by
  prefixing the URI with org.openssl.engine:<engine_name>: (Quentin)
- Replace the mocked openssl test with a real SoftHSM2-based
  integration test using the provider path and OPENSSL_CONF (Quentin)
- Use 'p11-kit print-config' to locate the softhsm2 library at test
  time instead of hardcoding a distro-specific path (Quentin)
- Use 'openssl version -m' (MODULESDIR) to locate the OpenSSL pkcs11
  provider .so file, so multiarch paths like
  /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu are handled
  correctly
- Generate the test RSA keypair with pkcs11-tool; softhsm2-util has
  no key-generation action (only --import) and silently exits 0 on an
  unknown --generate-keypair option, which would leave the token
  empty and make the openssl step fail with 'Could not read private
  key'
- Add self._CheckBintool() to all PKCS#11 test paths so tests skip
  cleanly when bintools are missing (Quentin)
- Extract the URI/PIN combiner into Entry_x509_cert._build_pkcs11_key()
  and add a unit test for it
- Document that PKCS11_PIN keeps the PIN out of the make command line
  but is still visible in 'ps' output via the openssl invocation; for
  improved isolation, configure the PIN in openssl.cnf
- Document all Entry_x509_cert properties (content, keyfile,
  x509-key-uri, cert-ca, cert-revision-int, sw-rev) in its docstring
  (Quentin)
- Add inheritance notes to Entry_ti_secure and Entry_ti_secure_rom
  docstrings, pointing out that they extend Entry_x509_cert via
  super() and therefore accept its properties (notably x509-key-uri)
  (Quentin)

Changes in v3:
- Split into two patches: bintool infrastructure (1/2) and x509_cert
  feature (2/2)
- Fix global environment mutation: _run_cmd_pkcs11() no longer writes
  to os.environ directly; it now uses the new extra_env parameter so
  module paths are scoped to the subprocess only, which is both
  cleaner and safe under concurrent execution
- Add module-level threading.Lock to serialise concurrent PKCS#11
  signing calls and fix intermittent login failures caused by binman's
  ThreadPoolExecutor
- Fix URI query string separator: use '&' when the URI already
  contains '?' (e.g. module-path already present), '?' otherwise
- Test cases updated

Changes in v2:
- Add tests for _build_key_args() (PEM path, PKCS#11 provider, PKCS#11
  engine, PIN appending), _pkcs11_use_provider() (caching),
  _run_cmd_pkcs11() (with and without module path), and end-to-end
  x509_cert signing with a PKCS#11 URI (testX509CertPkcs11), ensuring
  btool/openssl.py and etype/x509_cert.py have 100% test coverage

Sergio Prado (2):
  binman: x509_cert: document Entry_x509_cert properties
  binman: x509_cert: support PKCS#11 URI in keyfile for HSM signing

 Makefile                                    |  1 +
 tools/binman/binman.rst                     | 55 ++++++++++++
 tools/binman/etype/x509_cert.py             | 45 ++++++++--
 tools/binman/ftest.py                       | 92 +++++++++++++++++++++
 tools/binman/test/fit/openssl_provider.conf | 14 ++++
 5 files changed, 202 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/fit/openssl_provider.conf

-- 
2.34.1

