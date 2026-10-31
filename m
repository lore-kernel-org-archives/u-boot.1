Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD5606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gSYDxSgs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90BC440A95;
	Sat, 31 Oct 2026 11:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhiqgS5goPaa; Sat, 31 Oct 2026 11:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C62C40A6B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793444984;
	b=SjlJZxJLRIRyP3EZ4zI/zTpj02Edqgu0WkxFqi/RItsfsTubzVtcf2qO6DmcBQxe7XMO
	 Jl1mpzaCyeWqdeY49BW2jFWC7F8Mo4ox5c7/54LrGfsvm/62Vb33IdCt5bW1EkXRuco77
	 PzB8jFer9sacZfssB2jRTfxj/pNLWl2NOymVEasla0SPrQ+FO+IIr2VMyNV64fw4/M/Ey
	 ro1Z64SEsCG6Dkc0gaxYWIHPf5+mOzTrzwe24upj6HGAEAAsDTAe/BbUReDN9fr12j8NX
	 nnuEjWUrVhViHoFHhPOeoBUvmPO1rVGou9ACceXDJEILce1g6+S2UhPvw91sp0DfZcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793444984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=h4xf8VqnYcXjbML5ampUuqnhttd1zofj6VwWWrm8lQk=;
	b=ldAk6jL9D6HFNKGQEj9m/r1RYBJ4hKO9EYWsR8ZR3e3tFdq4w6i33tdXC7JwMQ5Xf730
	 Bi6FyZw7LtDweCRDu7Fup13doDTfQ5Z0lz74ubmvUuIW4G5n4uDIWPiJeyVO8LeEn8Oyo
	 hXrYeOqIesXOobqsRVHMf9LDWKNm8ItTYRVnUE2hWzUGR5LVYsV5lhFbXbjejilj9021/
	 tRVSw1ElsyeIm1LN0RmpFFrJVcekkf6NARfZ4emDTcJ4UroD2/Vwb3u74RNmgZoSLe+OX
	 ViRJIhY2dpHKGGlPssU5puYFZ7wxen/EPnwvYzXKIXzWkPZFLv23IIA4lETxYuKlG+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793444984;
	bh=h4xf8VqnYcXjbML5ampUuqnhttd1zofj6VwWWrm8lQk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gSYDxSgsiv2cRvuEYCtEqFZTgvgR34o+A+XlWHwgiH1idSEuWMk/Qv7ysMnjXhmuP
	 ZmE0PiVpNzaCQsC5dRsOq9cknNB4Xa1/OKH3Mrdjf1kluQcW7q6cyKIalTSKXTVB5M
	 9P/yEuZHrl7u4kdrt2O/UnQG9amuNUWFSCBWM/3U4avHW6IKMQ/XBNdpxX8es5iMdM
	 jIOHLeyOq+jea/QNWVNVtrBlzXkb5y2dNCJq+kgVCjEP3U2MP9GZsFPOBSISqvQtqV
	 8jfqqGu0ES6+5d8212l9tExV3nsdcKZPyNUTaGUG9npxeL6sm5bUSIvMRVEhC9hh/n
	 2QSBWYwX5oJIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C62C40A6B;
	Sat, 31 Oct 2026 11:09:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 261D9156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BB6D40A6B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3G7ezbtrqf4 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81F6B40928
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793444981;
 b=NNDbkRf3BNaC4r/nj1HGNZajithSm1ws2d3bOERBflcbVFYQ6eMG71hPOPU+Uz/KyBHf
 pQZoACPvpIUEaEITSQrk7ZzQ3iPmWSbUgMl4WZkLEKEy7Rx4g0BJTEge0lJ3ttC+bbn+e
 t8WsWWSnKyROyB4qN2RYlIQ82VkUIScRhb4RTCZCMJZ+4icljaxtmBzJTOROfbw8a3ZaC
 cF1zFii87ac1GeRDIgfcdfqWJbdXtJi61yJaD7iQsVrZ+kWbMeUM/PdnsOqMfIDyyoEew
 hNUOxotvemJ6Q1ctWDA4I/WmJuP1W04lvMAc6LbPs3gucZwpJ6dsVLDwoWw0bohQ+6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793444981;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Disposition;
 bh=h4xf8VqnYcXjbML5ampUuqnhttd1zofj6VwWWrm8lQk=;
 b=T44DpELm15YDBsDyuckgl8FTzOvNm0nzniYvZwrFzbBezqtm78t16JbzIOup8Jv/p3tm
 KhwQ3+UwlcoPanaVO7ufZkGHMMw476KmyjZni/bJXwosvtHahhmcOm3gk3GGn9pm1vfYd
 1eLcKJYOFZqvD8aISd/x+bHzdTG6sjH2D1nY0c/y680qm2YyF0P1wyUuzkeoU4/NScLiX
 grigoRZ0p8mn+zW75W4iOfJ2GE/BrSzFjNq3fTuepzknRX1Wf6avT4ZTvbsWzNzZrwrhw
 JMD4juXySIxJqK1xitJnp5WSKn3oPIIupKKI+LZNVD23CWM/vFgQIfNoVDCVCw93Pww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81F6B40928
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:09:40 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6uh-000000003Kx-0P4K;
 Sat, 31 Oct 2026 11:09:32 +0000
Date: Sat, 31 Oct 2026 11:09:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 00/11] imagemap: structural and cosmetic review follow-ups
Message-ID: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clean-up half of the v1 review of the imagemap series
(cover.1787272661.git.daniel@makrotopia.org). It applies on top of
"imagemap: fixes from the v1 review", which carries the correctness
changes and which several of these patches touch the same lines as.

Patches 1 to 4 are self-contained tidy-ups without any functional
changes: the suite list put back in alphabetical order, a derived size
for the header probe in place of a bare 64, a corrected rationale on the
imagemap_lookup() guard, and test locals hoisted out of an anonymous
block and a mid-block declaration.

Patches 5 and 6 correct the documentation: the imagemap_create()
signature, which callers a reader can actually reach, bootmeth_openwrt
described as a future consumer, the index entry sorted, and the section
on phase gating that the commit adding the file claimed was there.

Patches 7 to 10 are the structural ones which do introduce functional
changes: imagemap devices are named after the partition they cover and
hold a name driver model owns, so two mappings on one block device stay
distinct. bootm_start() sets the imagemap itself, keeping the invariant
in one function. The data-position and totalsize-alignment sequence is
shared between fit_image_get_data() and the storage path, which also
gives the latter the range check it lacked and settles the two spellings
of the alignment. Finally the two imagemap pointers compile only when
CONFIG_IMAGEMAP is on, reached through accessors that fold away when it
is off.

Patch 11 adds a new unit test Simon had asked for in his review.

The sandbox defconfig symbol ordering and the FIT_VERITY_NODENAME
rename that the v1 review also asked for are already in the tree, so
they are not separate patches in this posting.

One review point is not addressed here. Moving the imagemap out of the
global images struct and into an explicit parameter of
fit_image_get_data() means changing that function and fit_image_verify(),
both public, and their callers under arch/arm, arch/x86, arch/arm/mach-k3,
cmd/, common/ and tools/. It is also a design question rather than a
cleanup: the transparency of the verification path is exactly what lets
imagemap hook in without touching the FIT code. I would rather agree the
shape first than guess at it, so it is left out and proposed separately.

Tested on sandbox as for the first series: every commit builds, "ut
imagemap" passes 14/14 under "ut -r3", host tools build, the
documentation builds with no warnings, and a full test.py run matches
unmodified next. Built with CONFIG_IMAGEMAP=n as well, which patch 10
exists to keep working.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
 - Patch 11: the region pointer is declared const, which fixes the
   build failure Tom reported on v2
   (20261030175906.GA3333978@bill-the-cat), and the three buffer
   sizes become macros so the guard array has a constant size.
 - Patches 1 to 10: no changes.
v2:
 - Note that the series applies on top of "imagemap: fixes from the
   v1 review", which carries the correctness changes.
 - The sandbox defconfig symbol ordering and the FIT_VERITY_NODENAME
   rename that the v1 review also asked for are already in the tree, so
   the cover no longer counts them as patches in this series; they were
   not dropped between postings.
 - Patch 3: the guard rationale now says "same width" instead of
   "same rank"; on ILP32 loff_t outranks ulong and the subtraction
   stays signed, and it is the LP64 unsigned conversion that makes
   the guard essential.
 - Patch 7: the named path duplicates the caller's name directly
   instead of copying it through a fixed-size buffer that truncated
   it.
 - Patch 9: the helper is renamed fit_image_get_ext_data_offset() to
   match its siblings, fit_image_get_data() folds the embedded case
   into an early return, and the message explains the dropped
   signed-value guard.
 - Patch 10: adds bootm_info_set_imagemap(), keeps the bootm_info_*
   guards in step with bootm_imagemap(), keeps the device in a local
   in the storage path, and shares the release between the OS-GO and
   error paths in a helper.
 - Patch 11: the scenario comment no longer names the reviewer, the
   bare 64 and 256 become named constants, and the pointer
   comparison drops its casts.
 - Patches 1, 2, 4, 5, 6 and 8: no changes.

Daniel Golle (11):
  test: cmd_ut: keep the suite list alphabetical
  boot: bootm: derive the header probe size
  boot: imagemap: correct the lookup guard rationale
  test: boot: imagemap: declare locals at the top
  doc: imagemap: describe the API and phase gating
  doc: develop: sort the imagemap index entry
  boot: imagemap: name the device after its partition
  boot: bootm: set the imagemap from bootm_start()
  boot: fit: share the external-data offset calculation
  boot: build the imagemap pointers only when enabled
  test: boot: imagemap: caller-owned region not resized

 boot/bootm.c             |  55 ++++++------
 boot/image-fit.c         | 175 +++++++++++++++++++++------------------
 boot/imagemap.c          |  37 +++++++--
 doc/develop/imagemap.rst |  30 +++++--
 doc/develop/index.rst    |   2 +-
 include/bootm.h          |  31 +++++++
 include/image.h          |  31 +++++++
 test/boot/imagemap.c     | 123 +++++++++++++++++++++++----
 test/cmd_ut.c            |   4 +-
 9 files changed, 353 insertions(+), 135 deletions(-)


base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
-- 
2.56.0
