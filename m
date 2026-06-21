Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6561CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 15:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE96848DC;
	Sun, 21 Jun 2026 17:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T25TanDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC3584119; Sun, 21 Jun 2026 16:39:50 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E4183FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 16:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 321B23F1C0
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782052788;
 bh=HNJ5raDMXwA8wDEI/BML2mOTIASaUTCY5hAJYldOuxU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=T25TanDmaOnji4uyDT8UbIqqAOMUC7C5NTCJf1Tdm3KDJZIcGzvmf3N+0wZ1eRlcG
 vX3nBzJ6wde+AxjwSSPV5kUjoSzhLJOQn6X3B1axV98yAyz7yEft6xxbRIvEe2d8dG
 /SJsjRgSWuw+AgNhM/sB+DGRgi/5w+2AZAiv3frbjh0QDxaKmzpRxSJhB+a2gk2kGk
 vzZ3H5tWP+Awk8DtzBIQVrVujQBpyasFw5SoZ4fpNmqfjRaip1Kv/sNObJjal8H3m0
 XHj2IfmdA3UISlkPFjDAlzn9U/GbfTO5UuaMwMckPQIWmj1hb1ROkXqhj+7hszd3yG
 Vd9jx8FNEvfbNoxA1Jo/fTZyTrJgBWXW8/iMPBDmqp0GD2iotwLy3TprF0wd1Owk+q
 evZJ0EnXeqNAAmZ8uh9hHriMuWXqbgvBCUlpvj/QlH0sU+g/G2TCn/+IvqBh82QUh4
 e53Ykafbmz0ZdADcjIZTcwCwEdA+S8YavkoyLNUUzdQ2OMBEF6BGEFrbm/v9uViv6w
 LJEcegvnV9KzpWrEvtxDiZOJFbDhvOVlP1SSHu2Nu84ejBD3dnH3+kcDOqVP4uIfMJ
 Jw+TGZa74rCIpMp0UzJkr7vxfg+QhCBmgZELCoCS4MsnwTpXR54m1mrqx/Bagr8omS
 BEhWGwE9RKEBoXA47gFRCVIc=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so2137164a12.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782052786; x=1782657586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNJ5raDMXwA8wDEI/BML2mOTIASaUTCY5hAJYldOuxU=;
 b=C0tU08bocqnsrXMQI2UIWb2jQdWU/8nwEWdpdfjEV24ppzo3YDxLFJhSAFrYP3DRy9
 GH0SMQ2C7zH/yi5jL3iEx7Wo/iHy+Mo39OObHK9DreNDyxedvBYkvrBHYDRTk1607fUk
 c7go/JFYbpfmXoJRT1Jiz+hCWPBIx4nqzv+VWkSkMjpW631+zE/ut8M9Jf/C6Sj074nf
 KzGyaLX82Fr1WKO7JezmWAccwd8ddzwpVEAJ/j0RCA2SCvKR7ARkjS3rdnBhEUOmnLpq
 m4608wAxHuQ6RDcDLJ3heJTWuKVwXRd2KD7uHB41UYKSn9hY0vBFzpD/SfMdpTcgOqjc
 xWWg==
X-Gm-Message-State: AOJu0Yy+HU8mtRz9rT8m+lakBGFz5L8FG2A/neQHZLvUhLFOOH6GsL2N
 gfKr0Pw2FLy3TAmYxVI3ys8z1yCgmvEv274+Pr7W39xRIBLxu8jCkg2oVJtfXaCc3kVWrcNw4Nj
 os8VJCrvvpWRk2LiLJe7+AvVQhj69qPCIp5wEvq4Ol9mZUyof14OxDGn0QyjKj6mFt96uHtMBKG
 uL640=
X-Gm-Gg: AfdE7ckNUH1aJgoUCXzFauVhZA8cnmEg5DkFjTI8/kS10qOfz2WFzqCvFMLCJEkUvb3
 aYpyfagC7KbnPpFVMbkZx3MEoPrc3vlIyg9IZXlFfyCtqNshoKX3b+OwSFk0M5wSQyVkMAeZLUb
 9tuF6sJjPDHjUVqevmzqpt96Q1orAlfPbQF2I51Le/+JUfqxhtTzvoyOmTmtBboysH9tB78ljkY
 fYwPEhtPgs1HvP5+6Tfw/dxM6tP5qnCaXftNGegFJIms4fKu/8/osXSzjbCP3BNTRe5xlAjLTML
 nH1cEbR2DHlJKJ6wM+PrinFmO1JYFYuMlQTH3wH8hW2c1HSB7dUDQhfaewk/aTfel337XwADVup
 MaIwASSl7M16mViufTZZBIoaBSJWSKWYTp7P+54C86U+Yatrvw8azIWDbF3VfZA==
X-Received: by 2002:a05:6a21:9090:b0:3b3:cea:874d with SMTP id
 adf61e73a8af0-3bb33b45497mr12427172637.18.1782052786336; 
 Sun, 21 Jun 2026 07:39:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:9090:b0:3b3:cea:874d with SMTP id
 adf61e73a8af0-3bb33b45497mr12427145637.18.1782052785728; 
 Sun, 21 Jun 2026 07:39:45 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc31728edsm4485367a12.11.2026.06.21.07.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 07:39:45 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] vbe: bound FIT external-data reads against the
 firmware area
Date: Sun, 21 Jun 2026 14:39:32 +0000
Message-ID: <20260621143938.2863-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 17:24:44 +0200
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

vbe_read_fit() loads a firmware-phase FIT from a fixed firmware area on
a block device and then issues a follow-up blk_read() to pull in the
image, and optionally an FDT, referenced by the FIT's image node. The
source offset on the device and the read length both come from the FIT
itself, via data-position or data-offset and data-size. Those properties
live on mutable boot media and can be controlled by an attacker with
write access to the firmware area. On the TPL or VPL path, and on the
bootmeth bootflow path reached via abrec_read_bootflow_fw() and
vbe_simple_read_bootflow_fw(), the follow-up blk_read() runs before any
signature or hash check on the loaded phase.

Patch 1 is a sandbox test-tree preparation. The firmware1 node in
arch/sandbox/dts/test.dts declared area-size = 0xe00000 (14 MiB), but
the binman fw-update section in sandbox_vpl.dtsi is 32 MiB and the FIT
inside it carries ~16 MiB of external data, so the FIT already extended
past the declared area. The mismatch was tolerated because no caller
bounded the external-data load against area_size. Patch 1 raises
area-size to match the binman section size so test_vbe_vpl keeps passing
once the bound is enforced. The patches are ordered so the test is never
broken in the middle of the series.

Patch 2 adds the missing range check, confining the FIT-supplied
[load_addr, load_addr + len) window to [addr, addr + area_size] before
block numbers and lengths are computed, and applying the same constraint
to fdt_load_addr and fdt_size. The check is written in subtraction-only
form against the trusted area_size so the comparison cannot itself
overflow.

One open question: should the external-data blk_read() in vbe_read_fit()
also be deferred until after the phase has been signature-verified,
rather than just bounded? Patch 2 hardens the load step, but moving
verification earlier would be a stronger structural fix. Happy to follow
up with a separate change if that is preferred.

Aristo Chen (2):
  sandbox: vbe: size firmware1 area to fit the binman fw-update section
  vbe: bound FIT external-data offset and size before blk_read

 arch/sandbox/dts/test.dts |  2 +-
 boot/vbe_common.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0

