Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F0CD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 09:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF1A839A8;
	Thu, 11 Jun 2026 11:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="Abb8lItk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D861183FEC; Thu, 11 Jun 2026 11:14:31 +0200 (CEST)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E30838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so11196125c88.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781169267; cv=none;
 d=google.com; s=arc-20240605;
 b=L4mhuXrPmrZCZgGmZ+EMWpqZoLN9z1XjEctyOTqBL6X5PJJ91rUGJQlEH/iifIFNyn
 z8SphrAadfYMYIXvwRQaunCKLdZGtF7iETPouI+9KsRkFQPPQWufqlO4Zrdba0dpt/kE
 A5ER+DekMtTSxG8mwVIq1Z+eR/OwdkmuaVUM1DdY9H/5yNMr27299jH1hRVwAdqUKN6+
 VNo+EMuRg5bfbEtGIOPhZIXdty1gI10TeCv9eInJVjgXceC6M4PVVSpxJCpOlAbSI7ik
 kjBBCGPKfk3TwA0qIbd2rxHKvV4/KvYKbYp5lomLW2JKC3p0j7jIsrpZ6BVU4U5pdBoT
 oYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6flcW4PCptOPUrUxAwWCsOtyfvtoagnaQ+Ma/0sLrM0=;
 fh=zdWX9PQXCCW0wThMBhYeAWSVGDi73dzVKSnwkWaMNXM=;
 b=OdmOD65z82Q/FoE/mt39QPhI4gLmm916+0YePdvW9u9NbTz/krLPbltukV3wjVSvqA
 O10JHCbDwMVY1qR5jmNwHGhwHar4++EoBsFH1ponTGENAHClkBj1EiCFUWFCLtu/kyLu
 7kshOILGvGpSgV+pao4uln91Inwa4NDnp5kZTp0J8YVrZXBJxJ+780hAhAr1fdqe/cEA
 CmTwZVK/oVMCfKPFulWBVoaojBwZl90Q7xBsZ4L8xOiuKWE7bMzg4+ZoEsqdsUCdymDc
 xFk4UXUf069p5idtJGGv8XqvA1DXnLzRh4p2J1kDlZl286gaPP+CwLB8dbIz1wFIcISS
 RIhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1781169267; x=1781774067;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6flcW4PCptOPUrUxAwWCsOtyfvtoagnaQ+Ma/0sLrM0=;
 b=Abb8lItkL4tVyMeZ3nmirFTPHOnYI61BszKkWNzfcHhSnWuBWIwrVgjIUDhJm3Bsf0
 uEqGIjQaFZtbBXvmWxn5bFqqDIEqyGf27YaWYD9Cynl/XxR26arBafGV9OK2J9Y+xOVv
 exoxvGyMvOAaSRO+Iz/7agY54bBFEMCPnRsth0DifyVrWD14bxTl5aaxa5bbIaia0yEr
 d0ZShUkkSB0mJ2GPhFTPtyXk3Aaw9gjceWoK61vsoR2ly5w0BSmMZMaN7yAyZBKnzlMY
 UNUcHidrnnHRmrY3OcfoLeBKVg/eDhMoU6c4ar0iykj1w1Qy9/uedRsIsbuSp/RG09VR
 AMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781169267; x=1781774067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6flcW4PCptOPUrUxAwWCsOtyfvtoagnaQ+Ma/0sLrM0=;
 b=e4mUfM9KGUUBmdlUfXAaFXTH5PfENSu4kzDrCNOj+X1OzsJODu2y4x0Pg1wCflj+KS
 OX2U+pLCtHkyt/7t9+63FeJIb6l2X/Y82ZMQQoIYubVJLz57oAKOnUhxAS4OfBd69ndH
 YF8pWITPvEV6AmEwroQxKGyNGGmzWP6z+7bEh57wz0MWfrMpww7hKpA+NUtTHY0y6uIv
 HDuPsvPMJqij5JWDW2JkX7GHL0l511WB2lLTwNa1tAFMpf117dAhffVUu5ztC/jv7pNf
 7eHdtOiAubGqucLxlKtXA8TS37mLJ2eaVmCiNoEI12vlhmLStDJcTr18Ch7plLGcf+6O
 2z/g==
X-Gm-Message-State: AOJu0YzITHpQkgI8EVsBVO4hazSqHsgpSKH/wcQGwkV6xw9Qki+hXNSH
 BemTzVeTMtmqPmQEs/WhGxCoRhFEdOWl6i7wyyNmNoJBupqz+EZZgvGobsYf0ReCHx6sfZpoirD
 WzrsTnyaFjOihVJDBCA8fna7MHYohOaLpkfELYpWYH2waKtlI2wwGNMU=
X-Gm-Gg: Acq92OERjuzL11KJuGBniK43j4paVuuSv5npHaPlRj+0R3fho6nO0jbwSTniRyLye8T
 qISp1lktY28+I0acKEWVumDpEajGq5H7EGe3dsTwSnYF7wMrBCi2B0zCgtGyd0YVi1aoyFrsVSe
 Y0xE01myWGzmmatsM9jK31UkV3x6/v7EqkrZwgkU6jouCsxgxXK00AdkDiMOuPbhH6H7HlweRYW
 OqnTW4Ta3VXJjlug/GD0jDVjB++IC9rMQO/yEUKNx4x7zXypOZEnpdwY1/rkUmziwwoZ3nHm2Ht
 QboThRuiJyD+xrJgPg==
X-Received: by 2002:a05:7022:fd04:b0:137:fb6c:5355 with SMTP id
 a92af1059eb24-1384211e6fcmr1137703c88.3.1781169267210; Thu, 11 Jun 2026
 02:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
In-Reply-To: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 11 Jun 2026 06:14:09 -0300
X-Gm-Features: AVVi8CfYRrMaYMqyaSEXgLIwQsAQJxR2R_FIgruMzoBPAsP43O2H9l29KKLlGfM
Message-ID: <CANu7NGuR3JUiV-4xZQ25sc2k2WkJxBaM_pRtKfmscTDPFDMemg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] binman: add PKCS#11/HSM signing support for X509
 certificates
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, quentin.schulz@cherry.de, 
 Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon, Quentin,

Do you have any feedback on the v5 series?

Best regards,

Sergio Prado

Em seg., 25 de mai. de 2026 =C3=A0s 10:29, Sergio Prado <
sergio.prado@e-labworks.com> escreveu:

> Motivation
> ----------
>
> TI K3 secure boot requires X509 certificates to be signed with a private
> key at build time. Until now, binman expected this key to be present as
> a plain PEM file on the build host. For production use, however, private
> keys should never exist unprotected on a build machine =E2=80=94 they bel=
ong
> inside a Hardware Security Module (HSM) that enforces access control and
> keeps the key material unexportable.
>
> This series adds support for signing X509 certificates via any PKCS#11-
> capable HSM (YubiKey, TPM, network HSM, SoftHSM2 for development, etc.).
>
> Design
> ------
>
> The 'keyfile' entry argument of x509_cert (and its TI K3 subclasses)
> now accepts either a filesystem path to a PEM key, as before, or a
> PKCS#11 URI referring to a key stored in an HSM. The URI is forwarded
> as-is to 'openssl -key', which resolves it via the pkcs11 provider (or
> engine) configured externally through OPENSSL_CONF. This keeps binman
> itself free of any PKCS#11-specific knowledge.
>
> A new make variable, BINMAN_X509_KEY_URI, overrides the 'keyfile' entry
> argument for all x509 certificate signing operations:
>
>     make BINMAN_X509_KEY_URI=3D"pkcs11:token=3Dmytk;object=3Dmykey;type=
=3Dprivate"
> \
>          OPENSSL_CONF=3D/path/to/openssl.cnf
>
> The recommended way to deliver the PIN for non-interactive signing is
> to configure pkcs11-module-token-pin in openssl.cnf under the pkcs11
> provider section. As a convenience fallback, the PKCS11_PIN environment
> variable can be set; its value is appended to the URI as a percent-
> encoded ?pin-value=3D<pin> (per RFC 7512) so the PIN does not have to be
> embedded in BINMAN_X509_KEY_URI.
>
> Two URI forms are supported on OpenSSL 3.x:
>
>   - Provider path (recommended), via the pkcs11-provider package
>   - Engine path, prefixed with org.openssl.engine:<engine_name>: so
>     OpenSSL 3.x's STORE API routes it to the engine
>
> Testing
> -------
>
> Tested on a Toradex Verdin AM62 (verdin-am62_a53_defconfig) board with
> both the engine path and the pkcs11 provider path, using SoftHSM2 and
> YubiKey 5 NFC.
>
> A SoftHSM2-based integration test (testX509CertPkcs11) exercises the
> full signing path end-to-end against an in-tree test key; it skips
> cleanly when the OpenSSL pkcs11 provider is not installed. A unit test
> (testX509CertBuildPkcs11Key) covers the URI/PIN combiner including
> percent-encoding of reserved characters.
>
> Changes in v5:
> - Split the Entry_x509_cert docstring expansion into a separate
>   preparatory commit (Simon)
> - Unify URI support under the existing 'keyfile' entry argument
>   rather than introducing a new 'x509-key-uri' arg; drop the
>   Entry_x509_cert state and override logic that v4 added (Quentin)
> - Percent-encode the PIN before appending to the URI using
>   urllib.parse.quote(), per RFC 7512, and add a unit test
>   covering PINs with reserved characters (Simon)
> - Detect the OpenSSL pkcs11 provider via
>   'openssl list -providers -provider pkcs11' rather than discovering
>   the provider .so path manually; drops the 'openssl version -m'
>   MODULESDIR lookup (Quentin)
> - Drop the 'p11-kit print-config' / softhsm2 .so discovery from the
>   test; the simpler openssl.cnf relies on softhsm2 being registered
>   with p11-kit globally (Quentin). As a side effect this also fixes
>   the test on Ubuntu 22.04, where 'p11-kit print-config' is not a
>   valid subcommand
> - Move the test openssl.cnf in-tree as
>   tools/binman/test/fit/openssl_provider.conf and trim it to the
>   minimum needed (no 'module =3D ', no 'pkcs11-module-path =3D ') (Quenti=
n)
> - Replace 'pkcs11-tool --keypairgen' with 'softhsm2-util --import' of
>   tools/binman/test/fit/rsa2048.key so the test runs faster and drops
>   the pkcs11-tool dependency (Quentin)
> - Recommend pkcs11-module-token-pin in openssl.cnf as the primary
>   way to deliver the PIN; PKCS11_PIN env var is now documented as
>   the convenience fallback (Quentin)
> - Drop the incorrect claim that PKCS11_PIN keeps the PIN out of
>   shell history (Quentin)
> - Rephrase the URI intro in binman.rst and clarify that
>   'pkcs11-provider' is a Debian package name, not a path (Quentin)
> - Drop the inheritance notes added to Entry_ti_secure and
>   Entry_ti_secure_rom in v4; with the v5 keyfile unification the
>   original motivation (an inherited x509-key-uri property) no
>   longer applies
>
> Changes in v4:
> - Drop the v3 bintool extra_env commit entirely; binman no longer
>   sets any PKCS#11-related environment variables (Quentin)
> - Drop BINMAN_PKCS11_MODULE / pkcs11-module entry argument; the
>   PKCS#11 module path must be configured externally via openssl.cnf
>   (Quentin)
> - Drop provider/engine auto-detection (_pkcs11_use_provider,
>   _build_key_args, _run_cmd_pkcs11) along with the threading.Lock;
>   the user selects provider or engine via OPENSSL_CONF and the URI
>   form (Quentin)
> - Rename the v3 BINMAN_PKCS11_URI / pkcs11-uri to BINMAN_X509_KEY_URI
>   / x509-key-uri to scope the names to x509 certificate entries
>   without locking them to a specific URI scheme (Quentin)
> - Document that the engine path is supported on OpenSSL 3.x by
>   prefixing the URI with org.openssl.engine:<engine_name>: (Quentin)
> - Replace the mocked openssl test with a real SoftHSM2-based
>   integration test using the provider path and OPENSSL_CONF (Quentin)
> - Use 'p11-kit print-config' to locate the softhsm2 library at test
>   time instead of hardcoding a distro-specific path (Quentin)
> - Use 'openssl version -m' (MODULESDIR) to locate the OpenSSL pkcs11
>   provider .so file, so multiarch paths like
>   /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu are handled
>   correctly
> - Generate the test RSA keypair with pkcs11-tool; softhsm2-util has
>   no key-generation action (only --import) and silently exits 0 on an
>   unknown --generate-keypair option, which would leave the token
>   empty and make the openssl step fail with 'Could not read private
>   key'
> - Add self._CheckBintool() to all PKCS#11 test paths so tests skip
>   cleanly when bintools are missing (Quentin)
> - Extract the URI/PIN combiner into Entry_x509_cert._build_pkcs11_key()
>   and add a unit test for it
> - Document that PKCS11_PIN keeps the PIN out of the make command line
>   but is still visible in 'ps' output via the openssl invocation; for
>   improved isolation, configure the PIN in openssl.cnf
> - Document all Entry_x509_cert properties (content, keyfile,
>   x509-key-uri, cert-ca, cert-revision-int, sw-rev) in its docstring
>   (Quentin)
> - Add inheritance notes to Entry_ti_secure and Entry_ti_secure_rom
>   docstrings, pointing out that they extend Entry_x509_cert via
>   super() and therefore accept its properties (notably x509-key-uri)
>   (Quentin)
>
> Changes in v3:
> - Split into two patches: bintool infrastructure (1/2) and x509_cert
>   feature (2/2)
> - Fix global environment mutation: _run_cmd_pkcs11() no longer writes
>   to os.environ directly; it now uses the new extra_env parameter so
>   module paths are scoped to the subprocess only, which is both
>   cleaner and safe under concurrent execution
> - Add module-level threading.Lock to serialise concurrent PKCS#11
>   signing calls and fix intermittent login failures caused by binman's
>   ThreadPoolExecutor
> - Fix URI query string separator: use '&' when the URI already
>   contains '?' (e.g. module-path already present), '?' otherwise
> - Test cases updated
>
> Changes in v2:
> - Add tests for _build_key_args() (PEM path, PKCS#11 provider, PKCS#11
>   engine, PIN appending), _pkcs11_use_provider() (caching),
>   _run_cmd_pkcs11() (with and without module path), and end-to-end
>   x509_cert signing with a PKCS#11 URI (testX509CertPkcs11), ensuring
>   btool/openssl.py and etype/x509_cert.py have 100% test coverage
>
> Sergio Prado (2):
>   binman: x509_cert: document Entry_x509_cert properties
>   binman: x509_cert: support PKCS#11 URI in keyfile for HSM signing
>
>  Makefile                                    |  1 +
>  tools/binman/binman.rst                     | 55 ++++++++++++
>  tools/binman/etype/x509_cert.py             | 45 ++++++++--
>  tools/binman/ftest.py                       | 92 +++++++++++++++++++++
>  tools/binman/test/fit/openssl_provider.conf | 14 ++++
>  5 files changed, 202 insertions(+), 5 deletions(-)
>  create mode 100644 tools/binman/test/fit/openssl_provider.conf
>
> --
> 2.34.1
>
>
