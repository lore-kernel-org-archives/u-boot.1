Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACDEC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4433540D93;
	Fri, 31 Jul 2026 00:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SF_8sEVmMIHT; Fri, 31 Jul 2026 00:15:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CCEE40D6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456935;
	bh=41FIE+ra6c8L4R02ISVWym4XIazOOWFCwJrF/tY7Rt0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=zGZLAq3UAfXj/Xf+Bg+TzOf0cseFXZ5GLhsuZW9hdXPVnIynjhCI+OPeX9A/8S8K+
	 nbyMC+C1AAPtd9zGMVPHZ5pOyW5irmOeNfZa8bnpdrw20jdQcZVp14T82CatZ/ZF+H
	 J/MVTui2+qD7HUfuSboU7aZuZBatoo2XJCnmk9c4pQwHCFiki+xzNaG5DgQvq2sugL
	 4aCX/e24VMZm3sosO48HCq2uKD88FC7SCIaJGa6IkS+1zola5r6qGhzRU+Tmuh4gR+
	 HoPIll2t1e331ifNRCkzidIRkpasgsx3r6w6gEs8F+W4udOY913xyiPBCfWgGcYCBl
	 3htysNLPEpfeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CCEE40D6C;
	Fri, 31 Jul 2026 00:15:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24425197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15FDD60674
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4hnYwVMUFyK for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 324D360648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 324D360648
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 324D360648
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:38 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC0BE3F9AC
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:35 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso257419a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456874; x=1786061674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=41FIE+ra6c8L4R02ISVWym4XIazOOWFCwJrF/tY7Rt0=;
 b=Udq3UIrCgK1RO9tSbzzyjOlkQM9iTDlCWzdrwbVcjsvqTBEMCtVIleRf6dQHYWW63W
 NUN5DtAyhQiYUrkUnB6fIO5n2ZST9gr8gnXiLBSzuzbjrdhuB1IpR/tNetrBOVCBdjt6
 GBf9caIjltcgIBNuNTew2AdOWkoOc2SPI4yxMzyFc+oTE8frXl9owW7ufTvLJKNvqDY9
 UEBe0TtDpdeOC4hP14Yh5h7DUTVkYBWWvCKtx01M3r7IG8g4ddXnopYE9t4qwgYddVoD
 Z8OaTbywOta39j7C3J0edKbJSqJ44vIUj7A3ABMx1X1md6NAo4yHwPlDX986BpCKAxWm
 08SQ==
X-Gm-Message-State: AOJu0YwWiQEs6Xwoc0YQe2cSEICt1N8S+7DMvMdR3CBRmL/65/KH27iw
 SdzzUCBF1n61+Xz6IACHIvmoT7MkoUUEfGyDms3haWTpXEwOd0cqaxQU6miOyIjA6pK+7nK4IAr
 dx37+wAXIP0GeikmI2A7QvKaYEZLqfEx+m2+yh1JP78reT5pjdtmrTuMJdsoSa5SrxcB72VOueG
 HjpD1u/k1IdA==
X-Gm-Gg: AR+sD10V0bYUxJcGXbZt3WVJRc5fE6TUOi444PSFj6Bax5TqAZkpRPemNBk9HAh9UZu
 BLNRVKXz8stcEtENsl3g+yccjuxEgZln6lBP4c2G1EMm5s9eKCSMWDukDs/N7IXFfQ81vdQuvWV
 j/nZ7qk25eUfdUfP6NO3oghUy9WZusOa9xVX6IS7j1MYr3+5pD6/ECqxRUbDVrjSTTluYP0Ekf8
 KnfSrtKN3IgEoZsv0+/TDiyO758HHMQNG61kGO2qnSCteN37L37x6RJ5Pz1uVjxASNTWSyPBEpZ
 3dQptnh82mrejF0Oc14PVOjvTLndxLaPVJL7gARhtYAQViUKnDOOfuYxC7ue9YfnHDP2q5YBiwW
 yQhSMQuXoNMAsVWsex3IqpLyDU7MSXlpeNB/3NWjMtB42Gnc8db8GOm3RlXMv+xowhViRtQ==
X-Received: by 2002:aa7:9067:0:b0:848:8027:cb6 with SMTP id
 d2e1a72fcca58-84ebc3dd029mr3781423b3a.45.1785456873668; 
 Thu, 30 Jul 2026 17:14:33 -0700 (PDT)
X-Received: by 2002:aa7:9067:0:b0:848:8027:cb6 with SMTP id
 d2e1a72fcca58-84ebc3dd029mr3781398b3a.45.1785456873269; 
 Thu, 30 Jul 2026 17:14:33 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:32 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v4 0/7] mkimage: detect FIT image load address overlaps
Date: Fri, 31 Jul 2026 00:13:34 +0000
Message-ID: <20260731001347.35624-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456875;
 bh=41FIE+ra6c8L4R02ISVWym4XIazOOWFCwJrF/tY7Rt0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=S09DQMnBmehqwcLIehVvIfJCbDuiyZ/wS8ng8J/ZUbC4fpVeqMMhlLXNu0pyE2GOY
 F6ukuZJFmrQLuuQJYDrj1X20Vi0NmTZ3/q7uuEZtirjS0en037IfivEO1oIuG7OCGk
 b8HXF3HcJUIAPW6SJEdGdtk0vFhaG/l/06D6OacXSIJsyrOowI8TqT+lZxD6pEy5Q4
 0JLVrueKi+MAbIBFyo24u6p5FpbZuGfNBIfFpHs43Y8VvQyRWb8Gly5PxuBkXlpzaP
 6xeLj9+bAuvBB2DHesKLFZNNb2EYeCo+qjofgsRAlaRS9cdxdeNMbA8xyECCChD/qz
 aRU36o4ez0F0W2sM53NPbkt6VQhgVdxpW7GkZmFI4pQ9lOQUCi+os4p0bN3qhr7CnE
 uFtHI7uCTB2gBaoOzRmhQQHaeAeUBe6Ufh7V2v4R7oPh17Tq44sbhQt9wInMJzX3yu
 7UlWA6PmqA91Zf+otTdiUXZvbNr9/F8zhynSQySKw8Fjpd3xFJ2qRB8508mDO4L3Cj
 2WDnuKAvmzQK4gkjA3XhDPOKM6jbAcaG6FajH4tbopOWMLuU+zY0fwnhcadyBW8dCY
 uv9wTky1qx23WaPExr6RV31ftHx+1sz9/Zw6mkCA1rjMYwl+lOJR9F73zZW1aIRGnJ
 NV5fdyDHmrPOeGDoFhlFDu/o=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=S09DQMnB
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

Changes in v4:
- collect the review and test tags from Simon and Wadim
- patch 3: reword the commit message into imperative mood and add a
  comment in elf_sections_tee.lds noting that it mirrors
  elf_sections.lds at a higher base, so the two stay in sync (Simon)
- patch 6: also assert that the configuration name appears in the
  overlap error message (Simon)
- patch 7: add blank lines around the command examples so the
  generated documentation renders each one on its own line, and note
  that the overlap check compares packaged data sizes and so assumes
  uncompressed images (Simon)

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
 test/py/tests/test_fit_mkimage_validate.py    | 136 ++++++++++++++++++
 tools/binman/etype/fit.py                     |  26 ++++
 tools/binman/ftest.py                         |   4 +-
 tools/binman/test/Makefile                    |   8 +-
 tools/binman/test/elf_sections_tee.c          |   1 +
 tools/binman/test/elf_sections_tee.lds        |  35 +++++
 tools/binman/test/fit/firmware_loadables.dts  |   4 +-
 .../test/fit/key_name_hint_dir_signature.dts  |   4 +-
 tools/binman/test/fit/signature.dts           |   4 +-
 tools/binman/test/fit/signature_engine.dts    |   4 +-
 .../test/fit/signature_engine_encrypt.dts     |   4 +-
 .../test/fit/signature_engine_pkcs11.dts      |   4 +-
 .../fit/signature_engine_pkcs11_object.dts    |   4 +-
 tools/binman/test/fit/signature_multi_key.dts |   4 +-
 tools/binman/test/fit/signature_no_nodes.dts  |   4 +-
 tools/fit_image.c                             |  99 +++++++++++++
 tools/mkimage.c                               |   3 +-
 20 files changed, 334 insertions(+), 32 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

-- 
2.43.0

