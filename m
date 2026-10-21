Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B2606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cLM+jMAm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D3B781179;
	Wed, 21 Oct 2026 14:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gX_gf7ajw7LD; Wed, 21 Oct 2026 14:09:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2851A8116F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591758;
	b=R7vL3ZPLjWjjYQEsr91TOlY1DWeLa1KhAcL0E85sczE6+7WcguL933Om+RNQ8nYqGaxE
	 TAeCA0bkTp9oDX3sWpDkPTJJOsbwccUnQtwJcMQzu5FYL7mQjQgFulhacB5xSbFs8RneB
	 pXIpoLHF9wy8JnPfy0lCf9qKBBcn2KExnhOjrmJH2gqwkAuMrBFz1FTrevpeCqC2h9T1A
	 8aSE9AewZMiE/jkogfd4dHZ927rQWel3YxgdMja/EEezo4x+deVP1vOBYIgJEHxkPU5N0
	 xaS81Sk0Y5DnCL4xC+0PmFfqMNO4wkcJXIEwNz5TCSfCpmL7RYxeYCIudFr9kiqFZuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QFwzMZrbRvDb1uziFF1mpm4Ga4FddR6qRxi1RbPJMu8=;
	b=qdHwE7OmlOAIp3vSLyzByw3vXIK8+HCUFQY3ybi9u2HWM/QAvUhHPNO1AtilOyvoLMWO
	 8XMZErystygB1z8K3vgCtxmTz7OsFgIUO//XnEEUq5IdHJHzpFzyTMbmO+GGw4vbNI/U6
	 fpqHGfezzRmwmPLXHQ7YoFXa2P76uSc9oH1SLDVzbVFmYjwtNAO1jIFmQnd+fYRYnWUc5
	 qIgHVWn49Gu7rC70bFmw8XcgdXpM4khO7SleLG8qvIzSko4wjY0XdfoHzsn4qJtUNge8b
	 q29STKFWw8Nx0mU2XvivKjq84R8LJwmQeOQzFJtdy2J2OImM7mViNtoMQYqfHABwdGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591758;
	bh=QFwzMZrbRvDb1uziFF1mpm4Ga4FddR6qRxi1RbPJMu8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cLM+jMAmI8gATSdrs/EaZpBg8fEnixXB4H0qWtif0IYxA2urWHW0GgH0J14tTmKhe
	 kWHuH+Y1UxDQh/0H22qHlar6ndk+99sH2ePVV1t19qKfUQofTweYUte7xmQW4iRJeP
	 HvD6vqSfifK1DKUf54bElwZj8QgueGs10Ds8XPvuyelX/2GzcJJGk00BFUwrN4aFSW
	 +fo/9uAL76RzJ+9APZ/3kZWgqDwtW376U5TnFgD1vOdfKgep0IuNQKlcA/nmfjJP0z
	 PC2UJ3sbsb2OKifRhn5z6UKd+g2gVwDrqV7+I13zFDoCls8FrYN3TpamKU1AxbFTV6
	 RjqF9oFXYbJGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2851A8116F;
	Wed, 21 Oct 2026 14:09:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78A8A3AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ACDF403AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GwNioFLN3u6v for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 461954039F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591755;
 b=OK0QGro+KBhUIa+orsbxDQZeDYysDLu2dZtX2o+fYDRKksLf7we6vQ/iK3R5AO5nlHL2
 tkNmDW5y7IG8wwBLA3rP4Y7gnOMgZYmiyX4pFJAsy8CVncx73CIiF/zdeE1toK6gM0ya+
 1UHtXi1/4shWd4Dy4RkEw7arrM8qo3AF5w+MJAzHqal8RVkeuUC9N/sjxaVF2D78/atcZ
 i1QMWzu/tr1L+DoKKcZPN8PxWwRh1dxh8D+fRVDIMrhnKWfZ3kXn4mIwf1cFfbLecGREY
 wJfhPRebP5rApNwQW8ro0//LBsXVRpBBk9baEX+WZ291MwYnC8t5/bQWJ+MYaPHMecA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591755;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Disposition;
 bh=QFwzMZrbRvDb1uziFF1mpm4Ga4FddR6qRxi1RbPJMu8=;
 b=rm8OlPh6H/ks95jji1S+XR3FPJqPlZr9rnLZ3gKktghfEW9FzQpt7N2cZP6EGna7Ytgd
 9AMvbZIBuqTgRDECpLDVaWscy4S89RwYPBSNpy3rss+gruJ1PVyTYSdjmL7SB83lCMlOy
 iN/dCKijeorCIzm0HW43pdZaIGrJrHBgq2iF0gAHnzZ4U4k6/Jo7ppX5uR3wZdMX5op8f
 Pb5uhl8LmvtljBBMUdz5I0KMmzNUSCGGLsmN4UU6iyeHryQrAwpcr89PR0u1md4pRNHjr
 kQtSADiLY/z6Uc/5P3JaXRXVnaeaPafscq0efbT86E7VvLR84RP/UIEpebzUhETQIuA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 461954039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:14 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWwx-0000000022O-3ayZ;
 Wed, 21 Oct 2026 14:09:05 +0000
Date: Wed, 21 Oct 2026 15:08:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 00/11] imagemap: structural and cosmetic review follow-ups
Message-ID: <cover.1792591479.git.daniel@makrotopia.org>
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
v2: 
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
 test/boot/imagemap.c     | 121 +++++++++++++++++++++++----
 test/cmd_ut.c            |   4 +-
 9 files changed, 351 insertions(+), 135 deletions(-)


base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
-- 
2.56.0
