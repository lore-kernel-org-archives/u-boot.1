Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8499CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B41846E6;
	Mon,  8 Jun 2026 19:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TBarorJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0F5847B0; Mon,  8 Jun 2026 19:14:23 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A528405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bf0170c80f7so756077666b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938861; x=1781543661; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9LTDWmLbPQ9XYFvTGkT6eGShMC3npmypZT84m9bJAgE=;
 b=TBarorJPsnAJq5+IUsBNSKM34KPSTA58IfMOmUk6rSaS4eFJmVN+EdZQhaYfDawcTt
 6m7emDj0iqcWJakGQcjOZuv240T7AhbTdsrRCbNRIgHRPztxHOj38kiVnixFgCNWW9J4
 xH764VJZEcMZvmQLH6HAPafyqWkKIJ67oppnCK/lDv9Dfv7pLQCwNsjIk4JTvk5oY20A
 dcC/gweK45Mp4/I4ziTWsI8P52/8aSB7YRo3bNtaeGdA3vXpL14U/p4dCNsr747AkjJY
 nqMO28AwkcAoRwvWq383uQO2o9yOu7HwT6HIhWN8G55q3mFz+/VnGUaL/XWJFLfphfGC
 Rn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938861; x=1781543661;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LTDWmLbPQ9XYFvTGkT6eGShMC3npmypZT84m9bJAgE=;
 b=Zl88nt663jPkUiUuEkor2fh5iQ3+KK8zRtRNHfnAzayMivPZa57mqV+mty+fS4u6QA
 GG8beE7bR2RHml1bnw5jPuo39TAlylzqcwoKvCz1kIRgloyj8VrIiO3kF0AYLOn6u3Lu
 vJe7fhaH0zBakW+2v30CI+REhQAPYu9uDpPZwiHl4la5EUvCf6IBjpJVypw+fCd4EWIz
 pRDRS+Y6BkalG2zuyJk3//vWWY41xIeSZlzQJ/zsjQZ/xTxtzbVqpiXKbq2gXtlZSOML
 3S6zfqEDl5minuZW3mUr/Q5Htw1oDLk9zV2MtmCKXkpiovJH8XbFnxtPoZ4Z6RTHVq0X
 0P1Q==
X-Gm-Message-State: AOJu0YzG8m1CTnVGCXml/7M3JVbjuqrWKN1uaKgtku0EdCASiHb/pVqb
 cyBe/WCQkvX2v/0MkVP6ViEd4nG0Riqa5xFBW1o6oIjcfemt6BlofHvRyhxfa3iRN7Cs54jwtJI
 sRsZq
X-Gm-Gg: Acq92OH3g8vikkIWusbHdlAoHPwDdvtx68aEJ2BQsIA8/vcU/O8NeUj1weJc+6qpPiV
 49Y8oAFStZukWLS9oxouuktHD2sCdmeQkgiBHE2BDTLZdmPZcDdZwvKpFxYh1/m+zaam4uABoxL
 +6ij5ZK5/sACzQHE7WQWq8NTEIETXDe5qEosaaRA0/VJFaw6G5ygKDeSWvc9X/NP2mxlqQRhdrk
 2LvOtmKP+WBLnZwnrncLHLr5897kqGsNMW7CXaEOFhSBWKNJQv2tHBtqN0eKpbKDBF+KdJfS3+Q
 t+g2fSUltLrLACGz3N1kdgMMM0rQQroBklCgha9EB+IqaND7ccwjl6nF9eAgkCz3DP/FMz3FbKi
 0AAPcF1v6bHspKXgcp5gdbFqoppDwhnFFK8OVY5NDBvGeTLhKwi7rw+w0ijlWzM5+/aUwpz/bYl
 lk5wDmI8hDHOeOf5G051xPaT5mVqPZ8iB7znN9ZgOHG+5CPoBZJqD7DE8RE5OQZCpLJvthrDZsT
 wPR
X-Received: by 2002:a17:907:a43:b0:bdc:9d31:3f91 with SMTP id
 a640c23a62f3a-bf370674323mr880978866b.15.1780938860895; 
 Mon, 08 Jun 2026 10:14:20 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm893898766b.58.2026.06.08.10.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:14:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 0/4] armv8: mmu: fix region unmapping and optimise
 set_one_region()
Date: Mon, 08 Jun 2026 19:13:47 +0200
Message-Id: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSw6CMBQF0K2Qjq0ppR905D6Mg9IP1EghLRANY
 e+2OMFIHN68d8+dQdDe6gDO2Qy8nmywnYuBHTIgG+FqDa2KGWCEGaKIw4rAth3h6FrRQ2OfOsD
 ccI2wZJIoA2Kx93o9xN719slhrO5aDklKH40NQ+df6+pUpL+/A1MBERRCco6ZKrmil4d1wnfHz
 tcgLUxkY+R41yDRMKIqETaMcHn6MejWKHcNGg0eBUyoIEjgL2NZljfTrlmdTwEAAA==
X-Change-ID: 20260507-b4-mmu-unmap-fixes-1f7e02c6c4df
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=eN2P+m+u58kihvumQj6ThnSQ05EGBHnD6eemnRnDZFA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiy1H9lL+E/85dyk9CLuw4LPc/MWbrjB+iWqq/zq7aQl1
 3dUH42q7ihlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATUVnJ8L+6dJPlvIql3BqP
 DWZ9DH/1R04p+FbED9unrJmrJTu885oY/gpMmTVzyhrD5Dc5L3PuFr86Kzh3zZrsvUcOpc5g51Y
 y2FUAAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Currently trying to unmap a region results in slow and largely broken
behaviour as we unnecessarily split blocks and manually set thousands of
individual 4k pages instead of higher level blocks.

This series fixes the behaviour of set_one_region() so that it works properly when called to unmap regions. See patch 4 for details.

Patches 1 & 2 improve the existing debug functionality, the pagetable
dumper will now print most explicitly unmapped regions (since they still
have their PA intact), as well as adding a new function which does a
very basic software TLB lookup to help with debugging.

Patch 3 de-duplicates some code by moving the loop that always surrounds
set_one_region() calls into its own function, this also helps with
readability in the calling functions.

Changes in v6:
- Removed unnecessary check in pte print callback
- Change set_one_region() to only change the PTE_TYPE and leave other
  attrs intact.
- Link to v5: https://patch.msgid.link/20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org

Changes in v5:
- Fix logic in set_one_region() so that pages are correctly unmapped
- Cleanup get_tcr() use in a few places
- Minor improvements/cleanup to tlb_debug_lookup()
- Link to v4: https://patch.msgid.link/20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org

Changes in v4:
- Fix the new set_regions() common function to never call
  set_one_region() with level = 0 to match existing behavjour.
- Link to v3: https://patch.msgid.link/20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org

Changes in v3:
- Reworked entirely to be correct, v2 would cause unrelated pages to
  get updated too if the region was inside a block.
- Added additional patches with debugging improvements and code cleanup
- V2: https://lore.kernel.org/u-boot/20260504183721.646712-1-casey.connolly@linaro.org/

---
Casey Connolly (4):
      armv8: mmu: add a function to help debug TLB lookups
      armv8: mmu: teach the pagetable dumper to show explicit FAULT maps
      armv8: mmu: commonize the set_one_region() loop
      armv8: mmu: fix and optimise explicitly unmapping regions

 arch/arm/cpu/armv8/cache_v8.c    | 176 +++++++++++++++++++++++----------------
 arch/arm/include/asm/armv8/mmu.h |   7 ++
 2 files changed, 111 insertions(+), 72 deletions(-)
---
base-commit: 9e87893c24d1f21350e69bc222e6a3214c933b3b

// Casey (she/they)

