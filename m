Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB47C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBBFE4099C;
	Tue, 28 Jul 2026 11:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOhUjkfiQSgI; Tue, 28 Jul 2026 11:35:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FF734099F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238555;
	bh=w2FKY2tLO7ZOFdnIA4uwHRNXqaaZhROodpsuT14x/PA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zs8u5vAf6LCGVKavOneMODGsWadMuhjaN6miFN43adylacDmGneOdugFI47DyLbj1
	 NBB4ApFnaglGB4JsYlAI5Dg9DP4zrfIyGtRSpAk4BryjrGjcWAvTRHwuTHDT/JizRv
	 zcRzKYsVMh+VwmpfarHWqOvS91NSuffy4KJ3GRTEK7X72ZEqqazD2ai48/+SaVv5+c
	 zSOea+qmOXqqCZOSnRF0zkZmDiIhqO+l3crILLn7c+Fd0UlKN4BMoeoO9FwWy8BFip
	 Qg9bUUWYTv+9Etp7CkWp5rBLEC8cjs1kP1YqbNxKXWI7eHMinHGCfrQJfQ9NyqvvgW
	 xEaXwUsfH/jbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FF734099F;
	Tue, 28 Jul 2026 11:35:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A29942A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FDBE402D8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMIWAlZjeN4i for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:35:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sergio.prado@e-labworks.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F2D4400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F2D4400D3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F2D4400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:35:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A02B8494B; Tue, 28 Jul 2026 13:35:50 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA77482991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:35:47 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so2569864a91.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238546; x=1785843346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2FKY2tLO7ZOFdnIA4uwHRNXqaaZhROodpsuT14x/PA=;
 b=kfjNJdDBuXQTjgysnb432LKTINYKG3qqDWPeONgX0GtlDP8UGI39ve6UK5rqrH/2W/
 rAzppgBbEJHgBLgR0E5sStWJLjM1VkT7g1r9eX39bSrZ6Xqa+qh7fmnYUbhfiAZJu2bF
 Ub9uzJ4I0rWwAB0N63q1vcei9rBXK/+pNN2n8C9HSCfL99zqMlOBsxKzvlArgA66d9Gq
 p93swgE9RZ1yZS2h9iITvM575U3luvds1yTHA6lWxtaEmuJPWMhpjEgScOY69kqhgLsd
 QzVQRicFN2ox+uSFdzh6xAL8qormy1I9XNtcWl/p6mzWIqawuoEqCqKek8qP4B4eWE6X
 VjfQ==
X-Gm-Message-State: AOJu0Ywu+Yye4YVRtMOECtPEr2ggLDjfUDe2wK7xedoAfctV8bybFdZ2
 00Zbm6Df0cq+lYYs9J5dPhjsmlAgE10kDpCqb0tCvOsWJKFB4Ti7le1OuEggCXBRl1vPo5IXzoU
 t1ALK
X-Gm-Gg: AR+sD12phiUIAP3S33CIZiqgRxfGuKzFbZHDLK1IVDXVDliv9yrWULgSxE+WXf400oN
 kWOFJ4eh9o9GHW+Jxe2tYU6yZmMGakBW3uEO/2gpBfxZMf0v59PC3NfkAoTU+i8e7w/Vh3noD18
 qe4mNIjAvs5dCi3GKfTGo8dCe/XLV2cc4tkL4G7Vr3tjTFoBbEl4z/zutXhVaT5IGEF8HFO/L34
 IPm7T1nRhU9dW18LFTzvsKQDXAI2i1uW5XAzR2uxGqtA3QBkRVXvwmM0v1vr/Zt1B6ed9kVLLMS
 GyIm+P1KbLMjApQ/u1B5YIisoh6vEpWWL4BefkK4IcGRhTAWRPYfvn9FrQvfDeiIKUlP7XDg0Pq
 m/hsSqdZw10A7b4bJpAlb/W6ixde7AM6gsUlO5vbaPcXJzARkFrWLIW5VG1oRC+oKvfa2rmXTFb
 iq+h49faKT2Q==
X-Received: by 2002:a17:90b:2809:b0:387:e0db:bc28 with SMTP id
 98e67ed59e1d1-38f6a5aa230mr1936704a91.40.1785238546061; 
 Tue, 28 Jul 2026 04:35:46 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:35:44 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 0/5] binman: add PKCS#11/HSM signing support for X509
 certificates
Date: Tue, 28 Jul 2026 08:35:30 -0300
Message-Id: <20260728113535.128601-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238546; x=1785843346;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w2FKY2tLO7ZOFdnIA4uwHRNXqaaZhROodpsuT14x/PA=;
 b=E0ImBOE0ti48kd9RRxW28K7U4A4yKjpM2kINIohP5k6hdT3pgFh46mc0nWsCoiK6HS
 ZFavnM3mb/p/rnzhFZQdYslGY+IXwEVtBXZ/bzx0eABX/fPLoD3KLQg2YWlu2pLr2G0Y
 MAozoKwJbJsNdCOTfTiI7rW1fh+BatLHuZB0fW4CCCHCQUU7fjD+6ssULhZV53t35ff2
 o+J1HhFOBizp5UxEk19aX6FBn10MMoUfk2sFJlRzsfZfQLoJvKqqO255geBsqJ/wKlZn
 rwLBH1Hg2rAdDvXVhoNPExpz8DQm3XyhlX5GVs+XnloOIDAtoUQPi/7M3LHMu0X3UIII
 HKsg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=E0ImBOE0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="E0ImBOE0"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Motivation
----------

TI K3 secure boot requires X509 certificates to be signed with a private
key at build time. For production use, that key should never exist
unprotected on a build machine - it belongs inside a Hardware Security
Module (HSM) which enforces access control and keeps the key material
unexportable.

This series makes binman usable with any PKCS#11-capable HSM (YubiKey,
TPM, network HSM, SoftHSM2 for development, etc.) when signing X509
certificates.

Design
------

As Quentin pointed out during the v5 review, most of this already works:
the 'keyfile' entry argument is handed straight to 'openssl -key', which
on OpenSSL 3.x resolves it through the STORE API, so a PKCS#11 URI is
already accepted today. What was missing was documentation, tests, and a
convenient way to feed a build with a key and a PIN which do not live in
the source tree. The series is therefore split in five:

  1/5 documents the Entry_x509_cert properties (unchanged from v5)

  2/5 documents the PKCS#11 URI support which already exists, together
      with the OpenSSL configuration it needs and the two ways of
      supplying the token PIN, and adds tests for it. No code change.

  3/5 drops a redundant re-read of the 'keyfile' entry argument from the
      two TI K3 subclasses of Entry_x509_cert, which would otherwise
      discard whatever the parent decided. No functional change on its
      own, but 4/5 depends on it.

  4/5 adds the PKCS11_PIN environment variable, so a CI job can pass the
      PIN as a secret instead of writing it into openssl.cnf or into the
      URI. It is a fallback: a URI which already names a PIN source is
      left untouched.

  5/5 adds the BINMAN_X509_KEYFILE make variable, which overrides the
      'keyfile' of every x509 certificate entry in the build::

          make BINMAN_X509_KEYFILE="pkcs11:token=mytk;object=mykey;type=private" \
               OPENSSL_CONF=/path/to/openssl.cnf

Two URI forms work on OpenSSL 3.x: the provider path (recommended, via
the pkcs11-provider package) and the engine path, prefixed with
org.openssl.engine:<engine>: so that the STORE API routes it to the
engine. OpenSSL 4.0 removed the ENGINE API altogether, so the engine form
is specific to 3.x. OpenSSL 1.x is not supported.

PIN precedence
--------------

Quentin asked in the v5 review what wins when a PIN is configured in more
than one place. Measured with SoftHSM2 and the pkcs11 provider on OpenSSL
3.4.1, one freshly-initialised token per case:

  - wrong PIN in openssl.cnf + correct pin-value in the URI: signing
    succeeds
  - correct PIN in openssl.cnf + wrong pin-value in the URI: signing
    fails
  - with pin-value given twice in the URI, the last one is used

So the URI wins over openssl.cnf, and blindly appending a second
pin-value - which v5 did - would silently override a PIN the user had
put in the URI. 4/5 therefore skips the append when the URI already has
a pin-value or pin-source attribute, and this is documented.

Testing
-------

Tested on a Toradex Verdin AM62 (verdin-am62_a53_defconfig) with both the
engine path and the provider path, using SoftHSM2 and a YubiKey 5 NFC.

The binman test suite gains seven tests:

  - testX509CertPkcs11 signs against a SoftHSM2 token with the PIN in the
    URI
  - testX509CertPkcs11Pin does the same with the PIN in PKCS11_PIN
  - testX509CertPkcs11PinEngine checks that an engine-prefixed URI
    reaches the openssl invocation unchanged, with only the PIN appended;
    openssl is forced missing so no engine has to be installed
  - testX509CertPkcs11PinNotUri checks that a keyfile which merely
    contains 'pkcs11:' rather than starting with it is left alone
  - testX509CertPkcs11PinSubclass checks that the PIN survives into the
    TI K3 subclasses, ti-secure and ti-secure-rom, which are the entries
    this series exists for
  - testX509CertAddPkcs11Pin unit-tests the URI/PIN combiner, including
    percent-encoding and the pin-value/pin-source passthrough
  - testX509CertKeyfile checks that the 'keyfile' property is read and
    that the entry argument overrides it

The two signing tests skip cleanly when the OpenSSL pkcs11 provider is
not installed. The whole series was run patch by patch; each commit
leaves the suite with the same result as the base commit.

Not in this series
------------------

Quentin also spotted that Bintoolopenssl.x509_cert() takes a 'cn'
argument which it never uses - the config template says
CN = {cert_fname} - so the CN of a generic certificate ends up being the
output temp filename. That is an older bug, unrelated to HSM signing, and
will be sent as a separate fix.

Changes in v6:
- Split the feature commit into three: documentation and tests for the
  PKCS#11 URI support which already works (no code change), the
  PKCS11_PIN environment variable, and the make variable (Quentin)
- Drop the redundant 'keyfile' re-read from Entry_ti_secure and
  Entry_ti_secure_rom, in a preparatory patch. Both re-read the entry
  argument straight after super().ReadNode() had already read it, which
  discarded the PIN and left every TI K3 entry - the whole point of the
  series - still prompting for it. Found by testing v6 on a Verdin AM62;
  v5 was unaffected because the rewrite happened in GetCertificate(),
  which the subclasses reach through super()
- Rename BINMAN_X509_KEY_URI to BINMAN_X509_KEYFILE; it is a generic
  keyfile override which happens to accept a URI, not a URI-only knob
  (Quentin)
- Move the PIN rewrite from GetCertificate() to ReadNode() so that it
  runs once per entry; the local-variable workaround for
  ProcessContents() calling GetCertificate() twice is gone (Quentin)
- Guard the rewrite with startswith(('pkcs11:',
  'org.openssl.engine:pkcs11:')) instead of testing for 'pkcs11:'
  anywhere in the value (Simon). The guard sits at the call site in
  ReadNode(), so that _add_pkcs11_pin() only ever sees a PKCS#11 URI and
  a plain key file is visibly left alone
- Leave a URI which already has a pin-value or pin-source attribute
  untouched, instead of appending a second pin-value which would
  override it; document the precedence, which was measured rather than
  assumed (Quentin)
- Reword the commit message: with a PIN appended the URI is no longer
  forwarded "as-is" (Simon)
- Give the PKCS#11 setup its own section in binman.rst and list all the
  forms 'keyfile' accepts, including a plain key file; the
  Entry_x509_cert docstring keeps a three-line description of the
  argument which references that section (Quentin)
- State plainly that OpenSSL 1.x is not supported, and note that OpenSSL
  4.0 removed the ENGINE API, so the engine form is 3.x-only (Quentin)
- Add a test for the engine-prefixed URI form which asserts the prefixed
  URI reaches the openssl invocation unchanged, without needing an
  engine installed (Simon)
- Add security/x509_cert_keyfile.dts, whose 'keyfile' property names a
  file which does not exist, and a test that the property is read and
  that the entry argument overrides it. This is a separate image
  description rather than a change to security/x509_cert.dts, so that a
  deliberately invalid key cannot trip up the tests which just want a
  signed certificate (Quentin)
- Add an integration test which puts the PIN in the URI directly, with
  no environment variable involved (Quentin)
- Clarify that PKCS11_PIN is read from the environment by binman itself,
  which is why it goes before 'make' rather than after it (Quentin)
- Carry the Reviewed-by tags from Simon and Quentin on patch 1

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

Sergio Prado (5):
  binman: x509_cert: document Entry_x509_cert properties
  binman: x509_cert: document PKCS#11 URI support in keyfile
  binman: ti_secure: drop the redundant keyfile re-read
  binman: x509_cert: support PKCS11_PIN environment variable
  binman: Add BINMAN_X509_KEYFILE to override the signing key

 Makefile                                      |   1 +
 tools/binman/binman.rst                       |  75 +++++++
 tools/binman/etype/ti_secure.py               |   3 -
 tools/binman/etype/ti_secure_rom.py           |   3 -
 tools/binman/etype/x509_cert.py               |  43 +++-
 tools/binman/ftest.py                         | 201 ++++++++++++++++++
 tools/binman/test/fit/openssl_provider.conf   |  14 ++
 .../test/security/x509_cert_keyfile.dts       |  25 +++
 8 files changed, 358 insertions(+), 7 deletions(-)
 create mode 100644 tools/binman/test/fit/openssl_provider.conf
 create mode 100644 tools/binman/test/security/x509_cert_keyfile.dts

-- 
2.34.1

