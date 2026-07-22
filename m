Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0D8C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DC0F607D5;
	Thu, 23 Jul 2026 00:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKzX9-H0hN6Q; Thu, 23 Jul 2026 00:52:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C90C6077D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767937;
	bh=+2EGUZ1P8Ct9i92cksHXxPOcQ7C8npEF6C0FTtUSUR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1wbaI7HJBZ44GgABCsbarShoUgNC7PWsvD18nlbBVAO3Pk3Up/9wwoKPVK0BtNEB
	 W9F9sGqo1mbKgpSL4S1LcMiOeCVaJeT21+PWxRoJ2QFjCi6XE3X111+TlBWqt3QYH3
	 ll32Di7a7npVLNV8nrdKWGXOP80XYb+Hb0OZyPrKPFEaS2AHva704UKW3s/nJUPpL1
	 9wkMz8NTjW70ailmG2SGc3cAcXG1cRXkopMrUQo4L4sEQqLviPBpHyaFJlKNvHygBH
	 D6yMgnJa+dumOZWbdQ9mILi59oxfTNrA6src/x1gX2PzcFN1ti6X8t9EZT7WAOZ2q9
	 90b545PHrTs8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C90C6077D;
	Thu, 23 Jul 2026 00:52:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBE8042A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD7D0401DD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGt8AXEa7pso for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:14:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AFBC140176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFBC140176
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFBC140176
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:14:02 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3FB903FBB6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:13:59 +0000 (UTC)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso9823340a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784729638; x=1785334438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+2EGUZ1P8Ct9i92cksHXxPOcQ7C8npEF6C0FTtUSUR4=;
 b=Pu6AHeX1NlGN4piDw8DaSi3q+Hf4Lzzs10Ykeetkbi11MadVDSRV346tSWgYr01s64
 GSPAJlqdR9JTBBHzMU1bIJGV4TpC+dJ9vBuYfmLI4Vh9hBY6mXiD6heRz/zPl98o49vJ
 LwVZTeIaHa6GWvqqbU9YvD88IkTlFnGArBFVHaq5IhHltOB70DzTfzYq+H/jtOjF6+AF
 Yh4VcBKU1exNjR68HoUiovInAUUa7SO28T91gIs7nxaTDIRf0IKcC7PT2WfS/nBXo6uQ
 0Vt3mqma04EoOj7/odqivpeJCpZa20DKQiuOtr4c1cYIA0rUVFfOYIAOIcdRNBHcFdeC
 FMxg==
X-Gm-Message-State: AOJu0Yx/aXvnlCf+/vULZ1g6U7EC3u7uH2tMY+d5+4K3LXgTnN51oWq8
 0HcVjdpgES9NMIezdSOYgR61RsL/hbrQ7FNQLR7/zmzDMjL1jShkLCfLS8n0k302eGiG4cQ/jUy
 OSc7h7KfpP4CETwY7N9lxx4BWbZ4Ed/hyz+ZUzYzmIbNp5mqWKikLc9im9Y13lJQkMy3X9WigIY
 8tvVLD4xgRBA==
X-Gm-Gg: AR+sD12ywhT1QaUrGva4IhfW49Zaf3TmahAqbGNFIEo11Yp8IqG8red9/RD62VV44jo
 4Ven7o8S9MlBOxCdbwPAUormaAemsl6VHK1E8Bsn8OqNqUG4dnGZ54i+znptBp3NUqzjHbKzw8K
 bnDJ2G4pVpf1gbeeAdmYj1w+8aeJypq01OJwSPmWUpU13f+3g1mj3Zb0vD1nB/J6eUCelz3hgpX
 zJKlpu0X4apZK4Y4sO1yipgodsHk0oJ50iKV0+UYI/MRrH4/ngMXAc1C1Lqa+Rn6Qvc/4SFVn3u
 iJ1iBH+XSwEn0YVSN7ZeCVb+fhMjGdf4+hkc5GVq+Pvp8gthzZpims54KuP7Ukj0zQo4RiTJnVW
 iUYdxqU4rsM+ScIfRNmg+4WscTfCJAfZPGEbqCt9+XaUfh6sz
X-Received: by 2002:a17:90a:d2cf:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-38e4b446353mr22505801a91.11.1784729637363; 
 Wed, 22 Jul 2026 07:13:57 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-38e4b446353mr22505759a91.11.1784729636820; 
 Wed, 22 Jul 2026 07:13:56 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38ea7aff836sm1164697a91.15.2026.07.22.07.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:13:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, d-gole@ti.com, quentin.schulz@cherry.de,
 daniel@makrotopia.org, ggiordano@phytec.com, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, s-joshi@ti.com, upstream@lists.phytec.de,
 w.egorov@phytec.de, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v3 0/7] mkimage: detect FIT image load address overlaps
Date: Wed, 22 Jul 2026 14:13:07 +0000
Message-ID: <20260721152110.283998-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784729639;
 bh=+2EGUZ1P8Ct9i92cksHXxPOcQ7C8npEF6C0FTtUSUR4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=FJ+cOabxYaCnj75yzwMga63p/iA84GmWPtGdKVfjdJ1SGhGIDganrTKSQQLfpFKlE
 OUuabkn3zRddYKdcSihY88kMNncHnVm4b5oJsmiN6P2JmCTLD1HUS9wZipsiyDAHY3
 ZQ5XEquP4j2CrbI1WbtPCSCNKVUV9SiltEVRTbxThTX3VTS+/7H445jPBsqIa7tjCP
 aZJSTFkg84UNyQPVsFsEeVhnzdkNDPcp5YxWRyxC/Re1Q/ZjD9oanenI3bw7CaZeyT
 RpElAIWt+W5jikooOUe7UlaX8Pco30JmchyHbiEarlsmKkzfESkWgs5keaGPuS57o2
 TYQRhNOSQ/ZPugs1fuTp7dZPBCzv/wPRR6zj5I6y4EHlNRemvOjdnJXR/X05Kkc+R3
 8vfjmnQnCfAIMEUDmlWEfOTekod1lQC/FsK0qC0/5reoRKLnAE9Q8/DB07nTlPNx1B
 F204LpcW9MnQRxttAsvLhEJP3vsqCHhlqj5vpdgyqxiovDCQOyHQQnD3rswNf43p6q
 Z84lt16yOxq0iz/MEpvFv6OmjHFNdnP/S+ObDX2pbTBJBK3rAc7zhcGQ/XWMFfiH7F
 F3EievwvXCt20BcD8sMkD3tdXsFPXGQiUNwBNeMojSHsBOEOtKoYjXxUID+YmidEWA
 ItKfwXKqnLhNRu4fRc9TiIR0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=FJ+cOabx
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

This is a resend of the cover letter only. The seven patches of this
series reached the list on 21 July, but this cover letter did not make
it out with them, so the series appeared on the list and in patchwork
without any of its context, under the subject of patch 1. My apologies
for the confusion. The patches themselves arrived intact and are not
being resent; below is the cover letter as it should have accompanied
them.

This series brings back the FIT load address overlap detection that
was applied to next in September 2025 and reverted a day later in
commit e482fdbbca93 ("Revert "Merge patch series "mkimage: Detect FIT
image load address overlaps and fix related test/DTS issues""").

The v2 revert had two causes. On TI AM62x family boards the tispl FIT
image references the mutually exclusive tifsstub variants at a single
shared load address, and v2 tried to satisfy the checker by moving the
variants 64 KiB apart. Neha had warned in the v1 review that this
address is fixed by the platform and that moving the images would
break tifsstub selection, and that feedback was regrettably still
unaddressed when the series was applied. Nishanth then hit exactly
this class of failure in the K3 upstream boot build with real firmware
binaries, where am62px_evm, a board v2 had not even touched, failed
the new check on tifsstub-hs and tifsstub-fs sharing 0x9ca00000.
Separately, E Shattow reported an overlap on the StarFive VisionFive
2, which we later narrowed down to OpenSBI fw_payload.bin having been
passed to the build instead of the documented fw_dynamic.bin. With
fw_dynamic.bin the board has no overlap, as confirmed on the list in
January 2026.

Since then the structural fix for the tifsstub case has landed. The
series merged as commit 4e7a9bb0885e ("Merge patch series "arm: k3:
replace tifsstub runtime filter with per-state FIT configurations"")
gives each K3 security state its own FIT configuration referencing
only the matching tifsstub variant, so a per configuration overlap
check sees no conflict while the variants keep their required common
load address. That series was written precisely to unblock this one.
The underlying semantics, that overlap is a property of a single
configuration and that images referenced by different configurations
never coexist in memory, were discussed with the FIT spec folks in
flat-image-tree issue #32 [1].

The check itself is unchanged in spirit: for every configuration,
collect the load regions of all referenced images that have both a
load address and data, and fail the build if any two regions within
that configuration intersect. Images referenced only by different
configurations may freely share addresses.

Verification done for this version:

Running the new mkimage in reprocess mode over every FIT produced by
current master builds of am62x_evm, verdin-am62 and phycore_am62x
(A53 and R5 each) flags exactly one problem: the phycore u-boot FIT,
where the four SPL devicetree overlays are loaded simultaneously from
one configuration but are spaced only 4 KiB apart while each packaged
image measures 5.9 to 6.1 KiB including its ti-secure certificate.
That is a real overlap shipping today and patch 4 widens the spacing.
All tispl FITs with the per-state tifsstub configurations pass.

buildman with binman missing blob handling, matching CI, builds all of
phycore_am62x, phycore_am62ax, phycore_am64x, am62x_evm, am62ax_evm,
am62px_evm, am64x_evm, verdin-am62, verdin-am62p and am62x_beagleplay
(A53 and R5 each) plus starfive_visionfive2 with the check active,
since binman invokes the freshly built mkimage during these builds.
starfive_visionfive2 was additionally built with a real OpenSBI 1.7
fw_dynamic.bin passed via OPENSBI and completes cleanly.

The binman functional test suite shows no new failures compared to
master in the same environment. The nine tests whose fixtures are
touched by patches 1 to 3, including the OpenSSL engine and PKCS11
signing tests that only run when softhsm2 and opensc are available,
all pass. The mkimage validation pytests, including the two new
ones, pass against a sandbox build.

Changes in v3:
- rebase on master, on top of the per-state tifsstub configuration
  series
- drop the k3-am6xx tifsstub load address changes, obsolete after the
  per-state configuration series
- add a patch widening the phyCORE SPL overlay slot spacing, a real
  overlap the checker found (see above)
- extend the binman fixture fixes to the signing fixtures added since
  v2 (OpenSSL engine, PKCS11, multiple key paths, key name hint
  directory); their tests only run where the signing tools exist, so
  local testing without those tools missed them and GitLab CI caught
  them
- drop the "not able to get `load`" warning printed for every image
  without a load address, it was noise in every build log
- name the configuration in the overlap error message, matching the
  neighbouring reference validation messages
- move the test into the existing test_fit_mkimage_validate.py and add
  a companion test asserting that images may share a load address when
  no single configuration references both
- move the fit,load documentation into the binman fit etype docstring
  as Jonas asked for in v2; entries.rst is generated by Sphinx at doc
  build time since commit 090a7eb9cf36 ("binman: Remove pre-generated
  entries.rst and bintools.rst"), so the note can only live there now.
  Simon gave a Reviewed-by in v2 conditional on exactly this move, but
  given how long ago that was and how much the patch changed shape, I
  have not carried the tag and would welcome a fresh look
- drop the review tags collected on the v1 posting last year for the
  binman fixture patches for the same reason, only Dhruva's tag on the
  unchanged one line typo patch is kept
- collect regions with a dynamically grown array shared across
  configurations instead of per configuration allocations

[1] https://github.com/open-source-firmware/flat-image-tree/issues/32

Link to v2: https://lore.kernel.org/u-boot/20250914110021.4103-1-aristo.chen@canonical.com/
Link to the revert: https://lore.kernel.org/u-boot/20250924135139.GH197373@bill-the-cat/

Aristo Chen (7):
  binman: Fix typo for the test case name
  binman: Fix FIT image overlap issues
  binman: Fix FIT image overlap issues for testFitSplitElf
  arm: dts: k3: phycore: widen SPL overlay load address spacing
  tools: mkimage: detect overlapping load regions in FIT configurations
  test: fit: cover mkimage load address overlap detection
  binman: fit: document how ELF load addresses are determined

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |   6 +-
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |   6 +-
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |   6 +-
 test/py/tests/test_fit_mkimage_validate.py    | 134 ++++++++++++++++++
 tools/binman/etype/fit.py                     |  18 +++
 tools/binman/ftest.py                         |   4 +-
 tools/binman/test/Makefile                    |   8 +-
 tools/binman/test/elf_sections_tee.c          |   1 +
 tools/binman/test/elf_sections_tee.lds        |  32 +++++
 tools/binman/test/fit/firmware_loadables.dts  |   4 +-
 tools/binman/test/fit/signature.dts           |   4 +-
 tools/binman/test/fit/signature_no_nodes.dts  |   4 +-
 tools/fit_image.c                             |  99 +++++++++++++
 tools/mkimage.c                               |   3 +-
 14 files changed, 309 insertions(+), 20 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

-- 
2.43.0

