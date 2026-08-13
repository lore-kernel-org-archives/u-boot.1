Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50BFC5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B82D40CE1;
	Thu, 13 Aug 2026 20:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pn04UQOpTAQI; Thu, 13 Aug 2026 20:17:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EE5740C6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652264;
	bh=iR1z24ph6NdG+Rwmeb7AuTZEwIwqmTRbEKZ47c+WrPg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DGd+u9l9Y3CsSfqSVrp9B1ik7zvGJ/OngRnY6kVjPB+Z/5alX0lndZ+x1AhQniLJm
	 gEjVUFNXUtcvE7UrjQRZ/2u274vwTO1OCjfiK8FiaSVEc2FV0p/JZVFaTmWw7P/71P
	 VU3o/qT4C0ImygLQKd/e1KJqqgC7htab8b2reU7pQvx168KXnGHCZrlE6s6Jgo9x+z
	 hdTjptjoocU1VMu7Sk8G7QdWtKxXCksKbcvoLOo3gQYqNS7s6ANoz9fZeu97FTx8WP
	 TzBQfjy5jmcHeZPLOCuPfqaTNC1pooVh9upbyTxwVp8zB1zFaYC7sl0frfC8jNxApb
	 U6eKf/cd9wTiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EE5740C6B;
	Thu, 13 Aug 2026 20:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2D1C33B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9464840147
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0f0Jt7R84gv9 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 24DAF40106
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24DAF40106
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nwdiOWEL
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24DAF40106
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:11 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ee4399c423so277754a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651150; x=1787255950;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iR1z24ph6NdG+Rwmeb7AuTZEwIwqmTRbEKZ47c+WrPg=;
 b=nwdiOWELCB3DyjEDEw2wztj8zo/19adeHRy/CwotTkfuzpc27wnHFkryJX9++pKhFi
 9MCkrCGbkMjOe7N9dqk5UOWAg42LtbOb5jKbQoXpHo7Imwg/0LO0vW3bFzGTrduss+H8
 G3X9b7vn4FlvmQWfu5rTcknCRlqiHhIFXLr3CtQxPus9a1xX4E3IgA6xMgGBhnnplMJM
 XBVjcNreXgLgp3UGwuUj4yLDQ/f8g6D3HSANdRFgzzky3ReoKAxQd6moUjM+6pdYvOYh
 0wxp0YOe0OMynVT6GhXVcUltE+P4usDEwytqD7Z3XOKNzp5F+pDkwjNPtBsTOcibFpvw
 c5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651150; x=1787255950;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iR1z24ph6NdG+Rwmeb7AuTZEwIwqmTRbEKZ47c+WrPg=;
 b=BKtGb0iret3nI54yO7f9lo8aNOFkboufq0apcnAsFK/CT3HxQNM2PNkzoq1VuXOTPi
 J+rnshQ2tpkSoalHfOoTlz3EqPGlnQAwOn3+TlU2lyfpbBoPDIotEkEVYaE/yrQwfyTm
 VSJQcmtD9139I6PCwFUXctzAjkWpiphZcJyoc1G4khs6qTVK0tPixcIUKAy6uHaz3Xxt
 ct0cqaHyAy+ZX2zEO3qNcLYgZMObdQLtV6to46vAi76WTjyTeBxb4i94U4mh8sXpQiVi
 2AURF/ejFG6LuVEKhT/21aIJ721LisQJ9ppLcIuP8HKvpeN/PbfE/fqG++oBRzs+3fFE
 PaEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2gX/Cmh6EPbnXQoeYcMbJ8jR8e3zfS/bb3zuCWZSilulpwZRXXYWV5KdfFwn5j3c+5CmE2ZA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxLKlpVW/BPfgRa4PFWkNlOjB1FKU7F5MwY0cVDdqVxvTGWKRG0
 0n8tzUBD/Od5ZSCq+wEyGrAjTzxqx75uEwdBRfN8kVb0H7sfyC6WZiw+
X-Gm-Gg: AR+sD13U96y5jfxed5ZWqopderdRGDmqf7hFQaNurZ8dRiEDXdtHfV5TcLroxjBcJpW
 YtEv2H8pqkn06GfASyoo58gRwHrNM/1IjSZTqMnwnWgWoWlbR8EoOfnrG+y5K8jOBwGHL+b9Tp5
 GQEX8GLBGZi6WfU55kfCKRfjlgUrc+nd134V0A3KiKdnJ3T+OFQUoLh3kkKelnEDJBhYIcRTe1F
 4OZhHpU1YUs5QdncJaimdUZRDWpJQVRepxqcdvJpyMHr9DCzHhE/QLgWCb+WDvYKfemEYOmXjli
 yyg62hDw/Qxm5Sia+RtV2amBuygAhKBlWDuZYWfrk1SDaoB30vws5Pnw4wbze89RGeuTWPEUD5m
 aXbJUxkfNX9QN52yMTtMJnwMpsaA0j9bKBHU2qhF7jWhHnKfvCwSKKJrLwz98xewnCLU8z4lbO+
 PhFrQKqI6RhPBJJQ41aPs1JNcjKSL7GsflMDsKm35SraIG9Hh1ElmOn2+9b2u8Wlyhvxti0iWJJ
 /8NOiJJdPgiVLIFLnf+Nqpqk07ou/jqTKj2gghjEFgQN/CHQlLmdvO1Oi990CLOi3Zk35VUsLm4
 zp9+nN08ICBkpL+27fbK808mOX85SsanK1OGnj1He4QGIu7XRs31shxbP+9nNqRSaRUJp3DbXh+
 1/n2z7C/Vnf6pekL0
X-Received: by 2002:a05:6820:220c:b0:6ac:b5ae:65cb with SMTP id
 006d021491bc7-6b0d618d1fdmr810348eaf.14.1786651149823; 
 Thu, 13 Aug 2026 12:59:09 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 00/15] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Thu, 13 Aug 2026 13:58:53 -0600
Message-Id: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RzU7DMAwA4FeZciYoTfO3nfYeE4f8OFsQXSHpK
 tDUd8dtOUSjIOViyf5sx3dSICco5LC7kwxjKqm/YqCfdsRf7PUMNAWMCWdcMc04LTfXpYF6oGs
 lHTkVVmvXaOaV8QQr3zPE9Lmop5c1xrJX8MNMzRmXVIY+fy1tRz7n/d8BH6MxBisdBGlsPJ47m
 96efd+RucPY1sZ+22jRkKzRwRq/d/DLEJXRtNuGWObQELxm0hn7aMja+GMOiUbrRROVCkJy/mi
 oyuBm21BoGOabiNvEaGVtTOuXZ/i44T2HnztM0zf1J+b+7QEAAA==
X-Change-ID: 20260702-submit-ce-series-v2-4a77b170c68c
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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

This series enables Allwinner Crypto Engine backed FIT decryption and FIT
signature/hash validation for secure-boot flows on H6/H616-class boards,
covering both SPL and U-Boot proper.

The purpose is to use CE-backed AES, hash and ECDSA operations on H6/H616
instead of relying only on software crypto paths. Word-aligned ECB and CBC
decryption requests of at least 256 KiB use both the AES and RAES engines
in SPL and U-Boot proper. The AES child uses the same fixed-memory
scheduler for one or two engines. Each engine has two bounded descriptor
banks, so software can refill a retired bank while its peer remains in
flight. One fixed transfer object owns all scheduler state, and the parent
polls and retires each completion snapshot as one operation.

On the H616 test board with the CE at 300 MHz, target-timed and fully
compared 64 MiB AES-256 decrypts reached 561.4 to 566.4 MiB/s for ECB
and CBC with aligned and word-offset buffers. SHA-256 over a 64 MiB
word-offset buffer reached 190.4 MiB/s. P-256 verification took 0.015 to
0.016 seconds.

At a high level this adds:

  - SPL driver-model crypto plumbing for AES and hash providers.
  - Driver-model provider selection for progressive hashing, so FIT
    configuration signatures can be hashed entirely by hardware in SPL.
  - RSA-local PKCS#1 v1.5 DigestInfo handling, keeping RSA metadata out of
    generic checksum descriptors and ECDSA-only SPL builds.
  - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
    decrypt an encrypted U-Boot proper FIT without allocating another full
    payload buffer.
  - A shared sun8i-ce parent driver with one exclusive task-session
    lifecycle, a cacheline-safe DMA mapping API, and one completion
    poll/retire path, plus AES, hash and ECDSA children for H6/H616.
  - Parallel AES/RAES processing for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, using two fixed banks of ten task
    descriptors per engine and requesting completion only from each chain
    tail.
  - An H6/H616 ECDSA child for CE-backed FIT signature validation, plus
    common ECDSA curve-size and key-encoding fixes for secp224r1,
    prime256v1, secp384r1 and secp521r1.
  - Driver-model AES and FIT hash-provider dispatch with software fallback
    for unsupported operations and hard-error propagation.

The AES child supports software-provided AES-128/192/256 keys in ECB and
CBC modes, including exact in-place operation. Word-aligned payload
middles use direct DMA regardless of cacheline alignment, while fixed
per-bank edge buffers isolate partial cachelines. Byte-unaligned payloads
use a fixed 64 KiB repack buffer. The hash child supports one-shot and
progressive CE MD5/SHA1/SHA256/SHA384/SHA512 operations. Progressive
contexts buffer partial blocks, retain the intermediate hardware state and
build final padding from the total message length. A fixed 128 KiB repack
buffer handles byte-unaligned input, and no allocation scales with payload
size. The ECDSA child exposes the H6/H616 CE ECC verifier through
UCLASS_ECDSA.

Tested flows include:

  - SPL and U-Boot proper verifying signed FIT configurations whose
    discontiguous regions use the progressive CE SHA-256 interface.
  - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
    AES decryption, hash verification and ECDSA verification.
  - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
    decryption, hash verification and ECDSA signature verification.
  - U-Boot proper AES command paths using the DM AES provider.
  - Target-timed 64 MiB AES-256-ECB encrypt and decrypt at aligned and
    word-offset addresses with full-buffer and edge-sentinel comparisons.
  - Target-timed 64 MiB AES-256-CBC decrypt out of place and in place at
    aligned and word-offset addresses, with repeated full-buffer
    comparisons.
  - Target-timed 8 MiB AES-128/192/256 ECB and CBC operations with
    full-buffer comparisons.
  - AES-256 boundary and tail cases at aligned, word-offset and byte-offset
    addresses, with cacheline sentinels, exact in-place operation and
    partial-overlap rejection.
  - Target-timed 64 MiB SHA-256 hashing at aligned, word-offset and
    byte-offset addresses with repeated digest comparisons.
  - Sandbox progressive-hash provider selection, provider fallback,
    hard-error propagation, AES decrypt input validation and all supported
    ECDSA curve sizes.
  - A clean Buildroot U-Boot and SPL build with the software SHA-1 and
    SHA-256 implementations absent from SPL, followed by a verified SD boot
    of the encrypted and signed SPL-to-U-Boot and OS FIT stages.
  - U-Boot proper CE-backed FIT signature checks with secp224r1,
    prime256v1, secp384r1 and secp521r1.

The previously separate "crypto: hash: use DM providers from hash command"
prerequisite is now present in U-Boot main.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Rebase onto current U-Boot main, which includes the separately submitted
    hash-command driver-model provider selection prerequisite
  - Move PKCS#1 v1.5 DigestInfo prefixes into the RSA verifier so generic
    checksum descriptors and ECDSA-only SPL builds carry no RSA metadata
  - Add generic progressive driver-model hash provider selection for FIT
    configuration signatures and hardware-only SPL hashing
  - Add progressive MD5, SHA-1, SHA-256, SHA-384 and SHA-512 operations to
    the CE hash driver, including partial-block buffering and retained
    intermediate state
  - Fold the CE progressive implementation into the initial hash-driver
    patch
  - Validate a clean Buildroot build, targeted sandbox provider tests and
    encrypted, signed SPL and U-Boot proper FIT boot on H616 hardware
  - Link to v6: https://patch.msgid.link/20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com

Changes v5 -> v6:
  - Drop stale AES-128 wording and return -EINVAL when the
    software AES provider has no selected key
    (suggested by Simon Glass)
  - Leave signed FIT metadata unchanged and require/verify a payload hash
    before unverified in-place decryption, so repeated loads fail before
    AES processes plaintext  (suggested by Simon Glass)
  - Return -ENOSYS from the allocating host decrypt stub
    (suggested by Simon Glass)
  - Add Reviewed-by tags from Simon Glass for hash-provider
    selection, software AES dispatch, and CE ECDSA/hash support
  - Send hash-command DM provider selection as a standalone prerequisite
    (suggested by Tom Rini)
  - Drop unrelated hash_digest_wd() indentation changes from that
    prerequisite
    (suggested by Tom Rini)
  - Add Reviewed-by from Tom Rini to the SPL DM AES patch
  - Document that no in-tree configuration relies on the old SPL hash
    object key
    (suggested by Tom Rini)
  - Preserve the existing fit_image_decrypt_data() declaration wrapping
  - Link to v5: https://patch.msgid.link/20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com

Changes v4 -> v5:
  - Rebase on U-Boot main
  - Replace independently claimed channel and engine sessions with one
    exclusive parent session that tracks per-channel in-flight state,
    deadlines, completion and abort cleanup
  - Add one cacheline-safe DMA mapping API for AES, hash and ECDSA, with
    descriptor-address validation and complete-cacheline output ownership
  - Replace the separate one-shot, bounce and dual-CBC AES paths with one
    fixed-memory one/two-lane scheduler using two ten-task banks per lane
  - Use AES and RAES in parallel for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, with fair refill from a shared cursor
  - Direct-map word-aligned cacheline-offset AES buffers using private
    per-bank edge cachelines, and use a fixed 64 KiB repack only for
    byte-unaligned buffers
  - Replace the payload-sized word-unaligned hash bounce with one
    continuation stream using 64 MiB direct chunks or a fixed 128 KiB
    repack buffer
  - Use the normal DM clock and reset lifecycle in SPL and U-Boot proper,
    select the required SPL dependencies and retain the pre-RAM DT nodes
  - Harden ECDSA input validation and use a cacheline-rounded
    private result mapping
  - Validate secure boot, every AES key size, AES-256 alignment and overlap
    cases, bounded hash streaming and every supported ECDSA curve on H616
  - Link to v4: https://patch.msgid.link/20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com

Changes v3 -> v4:
  - Enable CE ECDSA in SPL and U-Boot proper on both H6 and H616.
  - Validate FIT cipher metadata before accessing key parameters.
  - Rebase on U-Boot master.
  - Try all registered AES and hash providers, preserving hard provider
    errors and using software fallback only when no provider supports the
    operation.
  - Treat -EINVAL as a hard provider error and reserve fallback for
    explicitly unsupported operations.
  - Require SPL_OF_CONTROL for SPL FIT decryption and fix disabled AES
    stubs.
  - Correct AES-192/256 handling in the software DM provider and add
    provider, decrypt-input and in-place-decrypt sandbox tests.
  - Map SPL FIT destinations after post-processing determines the final
    size and size decompression mappings for the maximum output.
  - Exercise all supported ECDSA curve sizes in the host FIT signing test.
  - Fold per-channel task sessions and engine ownership into the CE parent.
  - Trim redundant CE scheduler state and checks, and derive each NIST
    curve's a = p - 3 parameter instead of storing duplicate constants.
  - Run CBC decrypts of at least 256 KiB across AES and RAES in SPL and
    U-Boot proper with double-buffered ten-descriptor chains and tail-only
    completion.
  - Support exact in-place and aligned-offset dual-engine CBC decrypt.
  - Submit ECDSA and hash work on their dedicated completion channels.
  - Add target-timed 64 MiB AES-256-CBC and SHA-256 hardware results.
  - Link to v3: https://patch.msgid.link/20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com

Changes v2 -> v3:
  - Rebase on U-Boot master.
  - Add review tags from Svyatoslav Ryhel and Simon Glass.
  - Simplify the AES decrypt helper guard and validation flow.
  - Document the AES provider in-place CBC decrypt contract.
  - Tighten SPL encrypted-FIT buffer handling and error reporting.
  - Clean up the SPL DM hash fallback and Kconfig help text.
  - Link to v2: https://patch.msgid.link/20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com

To: Ion Agorria <ion@agorria.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Randolph Sapp <rs@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Francesco Valla <francesco@valla.it>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Yao Zi <me@ziyao.cc>

---
James Hilliard (15):
      cmd: aes: fix DM operation handling
      crypto: aes: allow DM AES in SPL
      crypto: hash: allow DM hash in SPL
      boot: image: try all DM hash providers
      lib: rsa: internalize PKCS#1 DigestInfo prefixes
      crypto: hash: support hardware-only progressive hashing
      crypto: aes: fix software key-size handling
      crypto: aes: add software-key provider dispatch
      boot: image: add FIT decrypt-to-buffer helper
      spl: fit: support encrypted payloads
      clk: sunxi: add H6/H616 CE gates and reset
      lib: ecdsa: support additional curve sizes
      crypto: allwinner: add sun8i-ce AES driver
      crypto: allwinner: add sun8i-ce ECDSA verifier
      crypto: allwinner: add sun8i-ce hash driver

 MAINTAINERS                                        |   1 +
 arch/arm/dts/sunxi-u-boot.dtsi                     |  15 +
 boot/Kconfig                                       |   9 +
 boot/image-cipher.c                                |  47 +-
 boot/image-fit.c                                   | 118 ++-
 boot/image-sig.c                                   |   8 -
 cmd/aes.c                                          |   8 +-
 common/hash.c                                      |  21 +-
 common/spl/spl_fit.c                               |  89 ++-
 doc/mkimage.1                                      |   3 +
 doc/usage/fit/signature.rst                        |   9 +-
 drivers/clk/sunxi/clk_h6.c                         |   5 +
 drivers/clk/sunxi/clk_h616.c                       |   5 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/aes/Kconfig                         |   8 +
 drivers/crypto/aes/aes-sw.c                        |  51 +-
 drivers/crypto/aes/aes-uclass.c                    |  73 ++
 drivers/crypto/allwinner/Kconfig                   |   3 +
 drivers/crypto/allwinner/Makefile                  |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig          | 161 ++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 809 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 791 ++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 382 ++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 483 ++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       | 128 ++++
 drivers/crypto/hash/Kconfig                        |  13 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/hash/hash-uclass.c                  |  31 +
 drivers/crypto/tegra/tegra_aes.c                   |   7 +
 include/image.h                                    |  41 +-
 include/u-boot/aes.h                               |  27 +-
 include/u-boot/ecdsa.h                             |  22 +
 include/u-boot/fdt-libcrypto.h                     |   6 +-
 include/u-boot/hash.h                              |  14 +
 include/u-boot/sha1.h                              |   3 -
 include/u-boot/sha256.h                            |   3 -
 include/u-boot/sha512.h                            |   6 -
 include/uboot_aes.h                                |  90 ++-
 lib/Makefile                                       |   6 +-
 lib/aes/aes-decrypt.c                              |  91 ++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++--
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +-
 lib/hash-checksum.c                                |  28 +-
 lib/mbedtls/Kconfig                                |   2 +-
 lib/mbedtls/sha1.c                                 |   5 -
 lib/mbedtls/sha256.c                               |   6 -
 lib/mbedtls/sha512.c                               |  12 -
 lib/rsa/rsa-verify.c                               |  67 +-
 lib/sha1.c                                         |   5 -
 lib/sha256.c                                       |   6 -
 lib/sha512.c                                       |  12 -
 test/dm/aes.c                                      | 258 +++++++
 test/dm/hash.c                                     |  49 ++
 test/lib/Makefile                                  |   3 +
 test/lib/test_aes_decrypt.c                        |  89 +++
 test/py/tests/test_fit_ecdsa.py                    |  18 +-
 tools/image-sig-host.c                             |  15 +-
 61 files changed, 4089 insertions(+), 329 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

