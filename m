Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C3606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bLDtcPEu;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=v6oJQ9gs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE64460780;
	Mon,  2 Nov 2026 09:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3xDEst3uPZY; Mon,  2 Nov 2026 09:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 595C6607B8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610256;
	b=SwhE2swRgD49Rco5Rz4xPGhPtSbSaMPut2Y+IsbVOG2DHhpcC/DcoIW4lfiz72w/gH2l
	 YpvZIlSbbrBmPC6jBTyPKmQSeVtA9sY1iwTA5NVXUtNuyOddjA5Jm4TLzdxOpaJFscxfT
	 y3z4oSVT+u7oe9z/esSZcj3ChO5vG866jnpoeQZBS/UfEsodGNAMHpM8SYEo25UKRRYVb
	 Q/YIsJmut4C8cr7iF7Z8Sok5wuhJMg2Cnam1z42O4JEQ2co9yA8eqZ/lbodsIojm4n21o
	 hHZvf82yzvsg7HzJjAtvklI8PBieQu4l1GGHbOJDwJ9/Yq6sVgcT4AJzJ1pjZF7nERw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MyEvSnzJx61cBIoI7jQAHDxLl9YSyTpHr7PwkF3HKYw=;
	b=sGs56s15vQF+dIH7YvI2TSlpuGQI5zpNMTABu0FS5E+VczBDH/XkQa7sxWTwzDazQFKo
	 MYfWArKzNM8NEvpUpqFvefnH+2VUvao+rPbLmpZB1q6Nq3WVzwuvFOE0ec8vO25eAXbC3
	 8APzsCc2RgMA5at1QJBnfmBWrIEI60rmjfiwVI3pjULS4wGU8/Fj84oAI5O60CCVH8dCg
	 /BJ0pP3MAuNH/gBlVFJHJcMjtE59sOyNZw8JUqFEGSidqEFwU/XIMMJw+gBLfiE5cFb5I
	 dJEhd+qaEvp7B8qBJCCu+0TqyUZCYipOFdCfbUI5d76/mmZG4cPD9rjlKq5xaJXwHZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610256;
	bh=MyEvSnzJx61cBIoI7jQAHDxLl9YSyTpHr7PwkF3HKYw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bLDtcPEuGuubUvEnHgNgRlvc7XOKSdv0FMvlsu/uGllgSQYdOPhPeqK1SIbGRsmr2
	 bsGx097sao2GIrUbRd/kLZRlYAZ10z87J0o70EkPYNqNLXbL2ahDXvGBL6GFXxqGIh
	 +0Bch/Tyif31z0/jIl+kFunn6LirdM7Lkk+AMK3Bi2rdf34Vr8R8fOVbfeWaQdn01a
	 QyHkHpjszWwoEzF0EykLGefPGt83HVCFa/p8Uu6oFgkRR6wpR+qxN7fYhbLTKZpPzq
	 VSBacSihmdO3kPy2mmKd+yzkEnRVyvnH57+O0nV8k3lz0Q1CEPcu/L1T3u/AI3Fzbk
	 ModuYiRIFZ4rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595C6607B8;
	Mon,  2 Nov 2026 09:04:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F64EF6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A322640715
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDSIBwxVg8gj for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC072406EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610250;
 b=R1vP/xYYXdnlR77E/N8negFKX+ZQXqUgVPzNhBDOBaZ1VQTXUsAkwb71kPmyy3CjMfhw
 4fOOf3VDe9EpokdGkyfROVoMPx84GZaqO0s+qCvdXjWpx0vcNcfnDJ6Unf5VBangClVH/
 KXPTqKtcxZZ7JXWvua24jh3AsTIs24KFFfK7WCU2ERkJvQxOGJdY1yAAFXLXtzAO3wLTx
 tj6CNrvq72rMx3yD4vmz3gHKS7Af+jtKIFN4f0k29vs5bPgKqBK+p7Q3ZSOcOyN7orz15
 4cw5En0sF3JAbcRUV7JOntPuU7aBwhKv1Up24OZtPw0wUXsXykw5sLlufr+RP7P6VpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610250;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=MyEvSnzJx61cBIoI7jQAHDxLl9YSyTpHr7PwkF3HKYw=;
 b=aXd4Ittnz8WUPJkqgYoeG2Uej/+swKvDWHuVA+QDoZuMgKmrd6w/JmT898+9Kr8GtBR7
 Y4AFHm2FAht0ESyFue8cNU1GHhH3JZpy1Sc2kXU1AzNbzW0vfiZbDGCxc0yt6A3V3v1hQ
 0MCj1ELpkuHlLILisljYhZzKlQJ6k7WMLXsa3uO/suKis+IgI6nadIxLStIuonu4+GsX/
 oA48Po9JuyIhb4dm7OfspNVAGYPCvtsmH0rPe1+r6u1F1YcbwSA2q9WWNozoxgA4YGy2y
 nEzgeQkkJwnpfMcyFRDb+gxyhUr4gzgqezUM1eNcMX9x9oIh+BR9nYcK3uwvpuTWBXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=v6oJQ9gs; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=v6oJQ9gs
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC072406EB
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:08 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793610245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MyEvSnzJx61cBIoI7jQAHDxLl9YSyTpHr7PwkF3HKYw=;
 b=v6oJQ9gsdGurT6wdZouRB5yeB4LUzcojyeDioQxAUB7F97UUI1oSfuEI3pB6l5kbAcRoDc
 DVS7iLWDnogXY+bmbhZfLSEuWXvWPS5iO2V6V2jS2GlI3d10gH5rkJJSSGeLN17G6QhFmZ
 h74sh789XwZjteF7s8GkuyVf6HVemKGdX4GI/Dtc+tjYmoOAVS4LMxWyCP0eFdyVJ79z20
 G1Es2Y/ZoCbKmNCp2elHcmnjVXFgK5+E9WCR0lE7YAvd/UqAgxmOGHKfirxsO6ozcerEr3
 9lxbCeYzbJNfxZy48mx9ZTLOlC2z2hfGUg4H72heTuXjp++l5DgjOl3DFkD8Jw==
Subject: [PATCH v2 0/2] blk: Fix duplicate partition devices after
 re-probing a block device
Date: Mon, 02 Nov 2026 10:03:46 +0100
Message-Id: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFtQ5C48j8Miz4GGTEtaUujI
 fy7gGuXJzn33AUSRaYE12qBSIUTB7+BOlVgB+0fhOw2BiVUI4W6oHmNOOmYcfaGvUNqjG57qW1
 rNWyrKVLP76N4736cZvMkm/fMbgyccoif47LI3ftfLxIFUl07ZerWkhO3Mfgcgz87gm5d1y9u4
 +p+wQAAAA==
X-Change-ID: 20261027-blk-part-unbind-e6ba8f1ac8ca
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=Mvl1LVSXq+p7vE6gKFJ6tC4cURUSKvFWjN39ZtSQvRE=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetF4E9XCT3t/y/FPD9yxHv8j5vlc+jdedGZvDmWPN9Yz
 HfXPFrRUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCcBFxRoa2gyePCGbOPfBh9/O9
 yfw/b7yUiFTf/25G/1MmZm719/5sjAyfox7J2jzuMjxtquRcm6a5d1+htebyMJ2mUJOUQ5k+fow A
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The partition devices that blk_post_probe() binds for a block device
are not unbound when the block device is removed. When it is probed
again, a second set of partition devices is bound, and the EFI disk
code fails to add the stale ones:

  Adding partition for mmc@42860000.blk:1 failed
  switch to partitions #0, ERROR

This was seen on an i.MX93 board where a single failed read during the
first probe of the SD card made the card unusable for the rest of the
boot.

Patch 1 unbinds the partition devices in the pre_remove hook of the
block uclass. Patch 2 adds a sandbox test for it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Drop the redundant device_chld_remove() call in blk_pre_remove(). Since
  commit 3632b5d63c8 ("dm: Remove children when parent is removed by
  flags") the partition devices are always inactive at this point. (thanks Simon)
- Fix the comment and commit message of patch 1 accordingly.
- Fix the test comment and commit message of patch 2 to describe what the
  DM_REMOVE_ACTIVE_ALL case actually tests. (thanks Simon)
- Link to v1: https://patch.msgid.link/20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de

---
Frieder Schrempf (2):
      blk: Unbind partition devices when removing a block device
      test: blk: Check that partition devices are unbound on remove

 drivers/block/blk-uclass.c | 13 ++++++++++
 test/dm/blk.c              | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20261027-blk-part-unbind-e6ba8f1ac8ca

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

