Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2494C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5A9560A8D;
	Wed, 29 Jul 2026 04:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0To5O0Ey2pTZ; Wed, 29 Jul 2026 04:55:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F82860A81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300933;
	bh=6cufp725ISkx7HD+4bH0Gg/kULAoMZPptUY5bz6kQnM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UDSjJ360ojSLsfXccTfCwmZX1fbcr5yn9ECeYk6THhNBw4w89F1TmwkSLgYWXK1bU
	 +YVCbiQM3OHZoop9ORzF/rVbzvWi5JN7E7vPNZ0OZloVjy2KEhcZnfACapAd5/nveg
	 cUC9PiqD4QOkbgeiuB82BeEmdXOmmBJbHeQf7MObz03lWiSVePB1IFc534nfy6LmZS
	 kqnqLo6/Gfuo91GF/BzNlKfzjJ0snQiwsXOi8QYuw+f2gGmx0hvgHhvthFP0jDERJy
	 MYu4sJ4xSq34sXD+YSp0hx1mltsL65+tockjdF2Fhi+JNTKHFmhlYPTn6p5Cy9aZcw
	 Ar0Cew4eFjFZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F82860A81;
	Wed, 29 Jul 2026 04:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F02B4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CAF3409BB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVMfVwIrSrXI for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:43:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF2304096A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF2304096A
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF2304096A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:43:56 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso120848a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260635; x=1785865435;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6cufp725ISkx7HD+4bH0Gg/kULAoMZPptUY5bz6kQnM=;
 b=SyevfNcop2cz6Q3A2zeNjWfldzzu8aVQY7Vakw7yTbgg44FEn5Cu/00/LPaqT0V6pr
 DVKSjLwm/3NDkfPAdC4MgAlQX6q3qIjEqiSUYUl3r2Vf+/vCjyIdzBBS2XkKaTb8PIoP
 HX/JmNqBlb78VUO99qm8dLzj7lan5gcdVOEiXHZWexlndjUHpLdpjZOdD9Z7/LY4yJnN
 dI/KE9ZK2TxtNqlgumb/GIpxU6ZAQSsIwiVy2EHax4Tzk2I3nMzgoW1FEFp7rI3b6jBs
 rmsigDG2I/qnTkzcHL6AB2tJrTBBp1Nsk7wVrTjghjupo93AN0/5BJkTEGuRYzRD1R9a
 /9vA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqe6e3gOv2vmq2LIOXw3VbOL4D9c+WeS2ZgydXFWF1o62lAWx4tQwQQqH8KDiFTxyJ1YhZx2no=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyCdgXNfWwLnCu2IvkBT4Qmi74iSt4Ev91BT8gD6aaytmb03p1r
 wBgLDHuZhmgpdVAmufiLwG50bp8A29NsNvN97V2/myvM3PBE/mZEWw8/
X-Gm-Gg: AR+sD10y5xMMZZU8bhiAfiRIx8AzCgOK5HBkOAggYox/mjqlo4naPQGscw0sRwtK3jx
 wZSiU32SXGK1wpbS3t2G34iZmr27jSJvsRonBOhcEvZHkC7DYfw3Jb7Q1D9AxvAMT2R8TQZ3IF4
 0q3yCuW5oNhFxv+vik7xac+6CdiUjvrcLk1oVu3j+equqt6s3qM56gGlLjnoqS6cixUeu0YdqiI
 cM0KvS02iqIkvxw+D2csV9oaSMmzOFkSHyC1v4o4WMDZ5I7gA44JFoU8UgHboLH8hVKZzndbvkA
 iPkPNSdHaM0FdzqanJ4HNMqNqTV4TkxlU8SSJdP36rsc2ylhO/ymagAHavhxQs7rRj/4PV6i9ki
 kmrWPMOEhfAQpA3p8h+VZqPf2uUSb8y64eS+PLDyEPjEoxg4mv8iTJ/4aS5vg75bsh51fPjpZR8
 H2kxdNuF1mgvmQbgF46WUEkp89euhRdd3QQYhjclNeKiGbXad75iAGQa4hvSNjhiox6cRp/gecd
 ddA00gUHAPeVwSAyKAfEwXRRg+vo6rIqB1pWYdiJbAmgBOvhp3vqjEM
X-Received: by 2002:a05:6830:83a2:b0:7e9:e19c:75f3 with SMTP id
 46e09a7af769-7efff07f83fmr1916870a34.2.1785260635550; 
 Tue, 28 Jul 2026 10:43:55 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:43:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 00/13] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Tue, 28 Jul 2026 11:41:43 -0600
Message-Id: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RzU7DMAwA4FepciYo/8l24j0QhzhxtiC2QtNVo
 GnvjtteKhhIuVixPzvOlTUcKja2765swKm22p8pcA8dS8d4PiCvmWKmhHLCC8XbBU515An5Wsk
 nxU30HqQXyYXEqPJ9wFI/F/X5ZY2p7BXTOFNzxrG2sR++lraTmvP+70BH8FJytIDZhlieDqdY3
 x5Tf2Jzh0lvjd19Q5NhhfQ5hrQD/GWYjSH1fcMsc3jMyQsLIf407Nb4Yw5Lhk5GFueysUptjdu
 6rgE/LvQX47pDBrEhp3uy9h1qa0Cb6CIYkCH4QooEpFcheEBp5h3EQNjtG4WLzFHgAQAA
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260635; x=1785865435;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6cufp725ISkx7HD+4bH0Gg/kULAoMZPptUY5bz6kQnM=;
 b=YDzB5i/5EMognMuABtcwrh5G2orDLSwfUKwbY1fQGjCtyIsDxy7Q8pWGtx/hvuVfkk
 +4JkQ/dZaxwKDPIECC8MB6CpfVnR54m2O1o9CRnWziYdqiMKvd9v2IrOgeJnXNR+SkGF
 AR9sxJe64tgo7Ls7JyCMo/c6/JiPEnNBTZauk2toX+ykciN6IJN+q9Pg3ZaNSOO148s4
 wXPQgvU3FjCiwMd5HuX4QEn4L4QekUU4DgAnEhQ51R78koFT7SslZRrd/ap1Te891N2y
 3VTWnI/18cpvkHebsRCnpti42Cn+qcJ75zNgFTu0ijOQri3Onp5BT3UJK6F8KG5dtZQu
 0l2g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YDzB5i/5
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
use a fixed 64 KiB repack buffer. The hash child supports the CE one-shot
MD5/SHA1/SHA256/SHA384/SHA512 methods used by FIT verification and uses a
fixed 128 KiB repack buffer when needed. No allocation scales with payload
size. The ECDSA child exposes the H6/H616 CE ECC verifier through
UCLASS_ECDSA.

Tested flows include:

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
  - Sandbox provider fallback, hard-error propagation, AES decrypt input
    validation and all supported ECDSA curve sizes.
  - U-Boot proper CE-backed FIT signature checks with secp224r1,
    prime256v1, secp384r1 and secp521r1.

This series depends on the separately submitted
"crypto: hash: use DM providers from hash command" patch.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
Cc: Thierry Reding <treding@nvidia.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Francesco Valla <francesco@valla.it>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Randolph Sapp <rs@ti.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>

---
James Hilliard (13):
      cmd: aes: fix DM operation handling
      crypto: aes: allow DM AES in SPL
      crypto: hash: allow DM hash in SPL
      boot: image: try all DM hash providers
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
 boot/image-fit.c                                   | 116 ++-
 cmd/aes.c                                          |   8 +-
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
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 343 +++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       | 128 ++++
 drivers/crypto/hash/Kconfig                        |  13 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/tegra/tegra_aes.c                   |   7 +
 include/image.h                                    |  39 +
 include/u-boot/aes.h                               |  27 +-
 include/u-boot/ecdsa.h                             |  22 +
 include/u-boot/fdt-libcrypto.h                     |   6 +-
 include/uboot_aes.h                                |  90 ++-
 lib/Makefile                                       |   2 +-
 lib/aes/aes-decrypt.c                              |  91 ++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++--
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +-
 test/dm/aes.c                                      | 258 +++++++
 test/lib/Makefile                                  |   3 +
 test/lib/test_aes_decrypt.c                        |  89 +++
 test/py/tests/test_fit_ecdsa.py                    |  18 +-
 tools/image-sig-host.c                             |   7 +
 44 files changed, 3742 insertions(+), 242 deletions(-)
---
base-commit: e354b34a6ab4b1887fd451bea8ceb7be146070a8
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

