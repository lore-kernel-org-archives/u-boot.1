Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC278C88E50
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 08:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 593C840611;
	Mon, 14 Sep 2026 08:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIGR2XsgRQ6g; Mon, 14 Sep 2026 08:31:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5A57440603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789374708;
	b=PZjImKs8DWPQOtATInutukd3o6cXqR7BzS8GcfRTULGaNesXrzR8FDq9vJAKgGC13OuB
	 e8N+oJ+KtTzImoWjbu3QR3HOMRardF/TQMas7+LPBKLQFp+XkEfMJP8+WMCYWmL5sM7uR
	 pvJypqep0NkE3/PAjZLSZcIPdjzNFN2dV2nFE3/OyNELZAzIl12f+r90wfckSsjFh83fQ
	 9QgcZiMDT5aEQfxDI6IZWzsBhFvNoEKaDV1eFQFYhq4zm3UxZqXF0m1IHzddW5sNjc9nE
	 THmCaRkvtGbl8t3IOoPYPS75FXuNiHuHfRcVoLzecNcq5M6Dd/KelkuMazaCdVUz+hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789374708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OffLs56NenbxoKkMnsrxtxWPDnOAtQ0KfWGiabpGvrk=;
	b=bKaCMardA12xQN/eR3v6zRYOpm392f7VODDkWQZKCJ4FCTxqF/waKupQZ/r8Yh0Jvjn5
	 RSwZnKIh3CteTTtlcrHvZKtyiMpfDEZpIKMb3EWWtrqP1VdMAwyEXY3QwTljLfzBoV3VR
	 +6q+tVvQs4xTQgSBauT5kj9zX4NQTIrfjPc0Kl+8FEnG1/1fHJ9aB87+x1CJPaEkWOdrN
	 TycSLFSpJC90TL6WBmQsOYl2ukZs0ByuHtk+QBgfRqElDxIMOOmMu2Iqu08L1i6ouuI2f
	 fueOGOHjFL7ytPkNOpf1WX5oeIbbnzj/ArdV4UB/YMQbrgBJ8tVtl3GvorJeLa1OTzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789374708;
	bh=OffLs56NenbxoKkMnsrxtxWPDnOAtQ0KfWGiabpGvrk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rNVNwWmqBNpST+4kOnGRgtliSK3X2fsE1mx+nglNlNCN/bCw1k6tOaXiQGjJyk/w8
	 Uy67fXhfFI+0baR4crbhOaWDvBIjcKyz6CiOzPzmcHw6imJ8to6HYO8jNvbK7Fz4QE
	 hCB9boutjFB9avCQdBH2DGV5ZjdXDBbUoxWa0vHbxP5pDG1RlUIxwNZuzZgOo35gPS
	 jhHZgdycH0k9UPgIdHOWWl3FvsFfp2EESU4ncPfhl5QB8/w9X027jXE+lDwmN8gem5
	 ucaePGoa8KtlF4/Jta50KWjtaRHJfqerVZw7yB5HD3UzmJYhMAdeTCNrX9SdCvmtQk
	 rMcmm/hMliAQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A57440603;
	Mon, 14 Sep 2026 08:31:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21EB3259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07C2360677
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHaX1En1qIaM for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 08:31:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A4FB460664
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789374706;
 b=PKrxlaTmHKXLhL3NzvWRsKPg1LnG3OSa5den1hiMpQXbGNtTjbYZ6ysJFEJxRGIAsjpS
 0wDtj522ecoNnP7HpFVJa9gQUnbaJSJmOhCcMbR3um2mB7CyefIFiOen4AF1UklqzUCR1
 TO8/a/V3zUlSXqqgRphUoND9qUwOf8C3kgOhqK08HrVJ4oy+4XEvjGxlOALdpr852KRLY
 rymHIJJf0V6XDYjW+B7EvL97r2/0WixKwa78By42aayT6eBKjKHoV2KyE3WeuRfTSiXEp
 zE6A9XtYgug/WyZhMQfH0xY/Tuo8aXbgeKSNILHO6P3SeYmhqJxnrabC3HE2H8coMhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789374706;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=OffLs56NenbxoKkMnsrxtxWPDnOAtQ0KfWGiabpGvrk=;
 b=ZEBBxdZAQT6pG4cUWkVw5dIEZm3MYppzjSr2yDcNny/kycpbih1VUtqywx3kWkYgccD4
 JO+GSF0pq4/oX1Aywhcg9//Ed8VONL8pHSoSFMwgJTc9Vp1K5MG5lJYmMazOgSHxRSVr9
 iieUDtCLXwih93A2qnzEVfAyHdsMH1KACwoYVLgEh6/aUGSx5i4topTlT8M6RUzhE+n2j
 w9GR3xk2PKuoXy+SROo56PBO7bEjAiycuo1jXUooZjk2c/47zqEXhPBHkigHG7hbRZEP2
 Jp3XiBQZfJb1OrLZqt2mntv2sofdg8EAo54GEhfV14zzYZ03Popk7ohTNG4QtPi06iw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TE+2z+2Q; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TE+2z+2Q
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4FB460664
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:42 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2940ef15d3so238021366b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789374701; x=1789979501;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OffLs56NenbxoKkMnsrxtxWPDnOAtQ0KfWGiabpGvrk=;
 b=TE+2z+2QK48fwdujZ6TfSLoJrF1bAAaw0OIrcKu707+J2OnbffwmMUQjKT/y4/Yzrb
 b6xZOCTHJdnGWZ7m7vu8ttQs1/CdrfCxJ/b5RzhC7Hs6cS8/SE4lwlKvXur7vWp1u+Nh
 1UTA0m3tQ3e+6Xn6KQsiKTAwCz5EI3E3m9OaTgnNHorJv5fhSpbBy1/AUg2qmAVIZS1M
 SCzhauQCqkrTBBV+vJ2hORAjYo/+9HdLpLL20FevviUErpWY3tunWhgUIlbY20LuzKUj
 zc0JyD0PMpuUQAJ0Zp+nvRH2AOVfhbLe3ZoatuslSHUdeK9NwdzeWyKoI6WROyGeNaKu
 MEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789374701; x=1789979501;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OffLs56NenbxoKkMnsrxtxWPDnOAtQ0KfWGiabpGvrk=;
 b=h698jrzXoS5Y6xId79nYEvE349njH64kqedU84qt2ZdXNer208eLA8wfkBzcVHAYLu
 jblhoBBmEBkB+lnHet63Yp8E2F9qdyWKg9NpRvOW/Lxmvr/qQJpwolnsqX3Es6tpgstm
 0ZPrLr9VtuLfWA0CcQdxFw7+YQLGnfr7UeM8Xikvg77gyF2QkNpnzcgrujPKEAKUzmpC
 ufgmN7Ry5MOVXlEU59ub1BnuyMDQVZC373DYnS02hraAbjz/9EA9AgKLMy0Hn04ueC2R
 POy5uiGFZPcYNPE9/BkCmg6fqTk9XdX+U5W2uKRs12BzR191B/vqYZ4ySlrIWgCCBNsG
 s26g==
X-Gm-Message-State: AFuF++kR82yC7Dh7mZTObszxswn8W7pslJCHXXKlcUoqdX4eychR9clD
 GuS/qV/EnMPtk/bUpaUfb5Zn2GFO8ZdUrGoSytIoJ5mx44QMStskV1mk6prXD1wtybk=
X-Gm-Gg: AYBFou1e+ONURaRLYiB7VpVBfc4wCG6yHQtjUZendMfZy89j8y4h8VCaX9CPXRsCvNh
 UsvJjH5HOLGnFtNLTCdE1WPOLd7fhwBO3JpnfVb7VkvZbBjb7ttpagxF4OztIK2HFSpsu9oRvZe
 2qW5IbXJJLEhAlEE54JM4vO4JFhJAJkyHV8WnjR0wF3KlB+Du3U8/cFaLkAoBdIeUpsmxzMtXYy
 w9Edi/1iWrbF5t+3eI0HeTuAdkwyb9iC9pP1QeKnz4hEb8Hb/Xg9BGZEx3aVUbnCpIye6VcyFSF
 h874EPSVZwR32hYtyhD4T+NmjWRq3fQ3c7uguHG7HHve7hTK6vnlgMzivX6kWtalc1rSirYh/wC
 qFNeFr6QhKaREo49gOlinabyZidhr37glDmkVPBtWXZIvxGC68GnrT3Hq3I9ORIBijzmIh9kSE+
 NqfSLvvsvwHpv+EO9yN2nje+UCLcK2KQuLeF/y6G7+1y/8FCfQskqDCKmK+bzn96aO8J/sdbULQ
 f67DXweLy1nGwCHcPZ3KdZs5rtkzosvO3Vl/Cb5DDgFWln7grihzCSJG6vMfYWpbaxgJUQbUsKC
 +Yq/2Yu24n6aLxZO
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr194127866b.2.1789374700760; 
 Mon, 14 Sep 2026 01:31:40 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296598e8b0sm383944166b.0.2026.09.14.01.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 01:31:40 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/2] Support board-selected raw partitions
Date: Mon, 14 Sep 2026 10:31:36 +0200
Message-Id: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOzQ6CMBAE4FchPbumLZVYT76H8dAui9TIT9pCJ
 IR3t6AH48XjJJNvZmaBvKPATtnMPI0uuK5NId9lDGvT3ghcmTKTXBZccw2IJlUIhj5ET6aB3vg
 I5dSaxiEoFFqSLJW1BUtG76lyz82/XN85DPZOGFd0bdQuxM5P24FRrL3PluB/tkYBAvKjUEKZU
 ptcna2ZHs562mPXsHVulN+g+AdK4CD1oaIKk4e/4LIsL1C9TEIwAQAA
X-Change-ID: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Boards may need to read on-device metadata before choosing the raw MMC
partition containing the next boot stage. This series makes the existing
partition hook usable after MMC initialization and adds board selection
as an alternative to fixed partition numbers or types.

The board hook owns hardware-area selection. A failed dynamic selection
stops the current MMC load attempt without filesystem fallback; other
configured boot devices may still be tried.

Out-of-tree spl_mmc_boot_partition() overrides must accept the added
struct mmc * argument; the in-tree STM32MP1 override is updated here.

Changes in v3:
- Make dynamic selection a peer of fixed-number and partition-type modes.
- Move selection into a helper with separate branches for each policy.
- Share the partition-loading guard while preserving platform defaults,
  explicit loads and existing fallback behavior.
- Link to v2: https://patch.msgid.link/20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com

Changes in v2:
- Reuse spl_mmc_boot_partition() instead of adding a second public hook.
- Pass the initialized MMC device and boot-device ID to the hook, and
  defer selection until after any raw Falcon boot attempt.
- Keep explicit partition loads independent of next-stage selection,
  without splitting the MMC loader into preparation and loading functions.
- Make dynamic selection an option within existing raw partition mode,
  select its partition library and hide the unused fixed partition number.
- Restrict STM32's fixed hook and MMC2 partition setting to fixed mode.
- Keep a weak default and diagnose nonpositive dynamic selections before
  filesystem fallback, while preserving fixed-mode behavior.
- Link to v1: https://patch.msgid.link/20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (2):
      spl: mmc: select the boot partition after device initialization
      spl: mmc: make raw partition selection a choice

 arch/arm/mach-k3/r5/Kconfig          |  4 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  4 +-
 common/spl/Kconfig                   | 13 +++++++
 common/spl/spl_mmc.c                 | 72 ++++++++++++++++++++++++++----------
 include/part.h                       |  3 +-
 include/spl.h                        | 21 +++++++----
 6 files changed, 86 insertions(+), 31 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

