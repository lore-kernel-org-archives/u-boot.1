Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E37606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xhjm9CNV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQDk6W/j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE20A608F5;
	Thu, 22 Oct 2026 13:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOv-R24B2LH8; Thu, 22 Oct 2026 13:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A84C608BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675847;
	b=Q/UpBVpGsQDq9zkmVUDTnlzbCzcMfNPKzvNlurNG5QAtONJK8p6uSiGyjA+XKcgleGai
	 +y6EZOcUyPo+GVyW41KepIowyT6274kQf+HMyF2FtM1BDofKM5bo97nYAsKYfA11yKoJb
	 3u/FIRE9toDZEHJHMFlRrEgT7DJepgePeXW0MTJ0NWy+WE7XcEkmObqebM0kwxLs23qPx
	 GXxElQV9bnp3OcS4FDjcf2I0oey4IZxmVpFpax2SVYXVIqUC91DD8o1Myc0wJgkRkhYLa
	 mHA/LAG7Uw7Wt5CxSOu7U2a6+fL7nPyRG7GXNufoAUl7URm5uvKjoj9XbVkVbOsU3bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fSecHvPa7bV24tLKOpNsK3km2QqAjl75hkIgPbjSeOM=;
	b=mluue5uexb+NuIjk6VKrgVlNsVgKjld4goDEXNqOWlPMRaxaNx1c2z8UMKldYeioWRas
	 s8EJ0uqJ7PiutHd8tuZ08gOiwngcqSkDSiHS277b4rDOy6OdW6EMhB6K7UoF/zh2wwVHF
	 lpMRBL2rPvUdEdaQW1ck0zm3RFPQKPNBWZdcXnxDD9H58gtzDuR7EL0ZTCUQ2Z/ZAR2vJ
	 AV3fifJg/HVDal5smD8hPKRKZpFiJSWkblioWOnvZrMM9MfEx24rcZZf9lZ1m5csoar8d
	 h/MLKfDutrQ31kmVkwtVWwwbhwoOH2dfQCDhbzeT2nccm68uHBYDnRHucPAoLoK2l1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675847;
	bh=fSecHvPa7bV24tLKOpNsK3km2QqAjl75hkIgPbjSeOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xhjm9CNVoM51bkR1cw6xj6clyiQawW2dqH49l7s1bcYvEWcmRQ/YdtGw7Qq6aPlzx
	 E64GMU/7WcHUa0WoWNkfzyPDlxPgCpkd4tHfHwQTa0k6tRdmk2M7DGTx2s4P9oZ4gB
	 I28XwrTQFwadDM3TR4NasdW1714i8BwghhZ+oI/r86h2YjTBFxuREzJWiNTT2TkwcI
	 BBMzS43vONcuP1l36vX/z4t7yxeEEVaU/iA83Fj4TQSOnsujbFuTAc34DmZ/obTiTd
	 LrDmuBM0ACsGK/5WWZjj8A/zeJj3oQwHUkvhIQFjKJYmJkaFer2zCy+5bgNSM7ELZc
	 GOtIjdhCcTD3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A84C608BD;
	Thu, 22 Oct 2026 13:30:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1A3A3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7CEF8121A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7l_axb59bgU5 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07EDC81176
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675843;
 b=SODdu6wukYSBriUh1UAYUMDnh9U2dcsJSPaW/XvR7BszDYUjIrxByyHHGipyF5iLfIQP
 U9ieWkxOU7uhgqBEJot+HHiZPi6/vk4uDl3rNo48wDV+Ni/gW00mPJoqxxWZB7Nmsywp6
 CX8GkWH4WTBFWdcFjQmMBqr6OS1CiQ6NemiMuuaoNYxz5CkX2wXjCkkMHA3VI9FqPyq+l
 DiRG+VL49pzPI9TtsrjuovSit/AysFRLqAPDSuQ055UID1xEnVYquVMpxOBBxhYB3jmnw
 aC3QgkXnkz8BYuVWGgWu/QkRowVNm3a1IfJ5btJDft+CXE90B1hW0eREpYrrviuN3Kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675843;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fSecHvPa7bV24tLKOpNsK3km2QqAjl75hkIgPbjSeOM=;
 b=CYtE6iWMIAll/7Dbo2Q/RHROq5R57twy29dGutw5OlgczSnNyHA9cvWnAI0EZ+9zzrBG
 gdevC5aS4oTHOknDR2SB7nS7XZ11CY79MiqkvBFNf+XlHrzy3Bu3/UPSRUmw8AAPZSuak
 oPFsvMZIi4ifBItzUc5jdmZWevs5QXuiTHBPQplVqWCi+Jo3KvPTkUGN5e1wvfSL6KG8c
 PHNcdrJLTXUbeqzXVfndu5hEDYKzvSQLA38j+eDL5ofZe3RkvJS/4q8JasCbMEHA0uy5c
 OznPvMjPkvx70QwG6Gi+Pya9o66yhxQSsbTNhHk/W63LBq+Ub/kt8bC5a7pKnHxF40A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="IQDk6W/j"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IQDk6W/j
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07EDC81176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A01043274;
 Thu, 22 Oct 2026 13:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC431F000C1;
 Thu, 22 Oct 2026 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675842;
 bh=fSecHvPa7bV24tLKOpNsK3km2QqAjl75hkIgPbjSeOM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IQDk6W/j9yvdr6VHCkIkrUuVZ9apXkq/wUmWhNSUe7NBcp1LSCxtLm/GfvveT0OJC
 z1IJcFAVK6/cJ18GRO9iwxmzycKOSm6+iSCXpZFNoNW76P2I8mmKq9gd2/ZboEAMwb
 fmy07H4eLJ6BKeivnaSt2e/QjS0KpxYO8L/t6A0h6RG7pxVNpkygtvipKiQaDCt7UX
 ebT9vcjdn8EJG50MUFxsz767qI0XMgELt2vlzENL+7mjxqoXVNqUkqZ2Ihwl4/S645
 fG/hHl6l3y6h1Hn/xdi5+HO/9kh45EOCQA1kvt/AW6L5k5m3KvhPiQtBCpjlt9hQ0K
 owCCC/mXta9fg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:30 +0200
Subject: [PATCH v3 01/10] avb: Use map_to_sysmem() for flush_cache()
 address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-1-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=fQZFl1AVTrtCVIH2moMgHoJlKA9dL0YL4NrkHTY46tw=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/8A9WGOEeeg2Ms8ZeIoQO0t7wDDzJd96rBM
 7DyG0vyOyuJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NR6XB/sGOJsVuu9h37ANbnU44yUBPVsFlPeVx9AYGb5/k2ScmQdoW0Slv3iAcaDpIGwhfVmGFRC
 4figSeJMsoylEb/euOrhxS1zVe8H3jbd2sv458KQ8EIYVJ7V5CZnnqfKtoNpO0jaHjM8UVOJoHn
 iQ4QHpTKKKN8GLd4mM7yeAwZQuyPRuvbmaKPWOTpfNFsBOMckjMFIJ7kbC1DrLJxe4L6Bi/CzuL
 ZSMsVXucaCWh9fNY6SMTOKjK9o6WRTrrKTKu9vtPzKYASlk09D78bubQKvskqSZaFX7fNEIFJXM
 ut0JzZsVL6h8JxwvrWx5kU6zq59SiDXFxNpWKefDlsWm6nZ0
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

flush_cache() expects a U-Boot physical address, but avb_verify's
mmc_read_and_flush() passes a raw pointer cast to ulong.
On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
inside flush_cache() to crash:

  phys_to_virt: Cannot map sandbox address 1a27ee70
    (SDRAM from 0 to 10000000)

Fix the crash by using map_to_sysmem() to convert the buffer
pointer to a proper U-Boot address.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 common/avb_verify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 09f1534c3cc5..d157adc4af07 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -7,6 +7,7 @@
 #include <blk.h>
 #include <cpu_func.h>
 #include <image.h>
+#include <mapmem.h>
 #include <malloc.h>
 #include <part.h>
 #include <tee.h>
@@ -346,7 +347,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	blks = blk_dread(part->mmc_blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
-	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
+	flush_cache(map_to_sysmem(tmp_buf), sectors * part->info.blksz);
 
 	if (unaligned)
 		memcpy(buffer, tmp_buf, sectors * part->info.blksz);

-- 
2.56.0

