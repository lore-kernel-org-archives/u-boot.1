Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A3606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GTiOBwcC;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Wi9gXzni
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2A8B4084F;
	Wed, 11 Nov 2026 10:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VfHAVgm2PyoS; Wed, 11 Nov 2026 10:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67D3E40873
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392011;
	b=FKGxOq6IVuzQK9JeqWT3U/0A34bAJ6Wlkc2Oa5aJnegoKLGYZdaXilxmW0xflYAqrE4D
	 7UsdvjP+SdCkkfaXV3pL6sBjUY4m45NZj65255oJnjNEOwylsVhQwCaKX++97jzD05kMH
	 rMgeIytRLF2WWHdQcfrkUNSMjfqbHzM0taw2f927HFOU9kLHvaEbMy7eLoHS49GVqFGXu
	 hWqbeXdCRlxMit0jpw4Iz1QfSYjgpB/jamxROlI2BhDw21cXyqeLQH3Y6jB4Y1eRAi5JR
	 WFbnPhh8kwqQmrB5GzHVRgrv8hyrEQUjgkSfxn6AvCI/mHW6tNHfUKUIxOQW40esC1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m7sPSslMp/XhHyrfu0osRwBQ9BwtAetyLUbXF3FxBYE=;
	b=oNbWjFasXhBP8MDusNWNmifJqAgCluHvTJFVrVWa05twYLpFC1ZOF84YyXl/d79L4LWq
	 PaZc2HzaQaen4Blg02JUmvB1Ibgg/GoqlVGFkVzaSc3GpcLT9imElc15snPeaESW+rrJA
	 Ffo2WnAYLdgqksU8YnGI8fwj9X+I5Xz4Juxc/l+9wWpCjSPpHf0Y3nob5P8K6odWA/I71
	 ZRlycnxf7+L/ebCTrTrK7x6ZFzZifTon+Ufo1wXskQwdJ7gXG+2425h/yzQeq8F5dPO0F
	 3fH0dlLbcaNWqFqQvElKWFy6eqLCQy9XUUFDZMLopaofFzotwq0R6AirhVOnFkohU4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392011;
	bh=m7sPSslMp/XhHyrfu0osRwBQ9BwtAetyLUbXF3FxBYE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GTiOBwcCFAthzOagrWd76lEJHDhDd8qN3S8GQQLPDStVD/y3/d/DFghPt+5Rj4FDa
	 e5EIJrAvQBTyy+emg9A+9qFOKtdc/YeOrTGfVifLNAbux3cvPsh18uWlICzknDzjda
	 MSnemLyH/0P7OG10RJtY4dlSTrtFX7902fknjbfTzKg92tinLLw6CHMkNuWHPTIj+k
	 +G8yUVCniDQ8Zt0yqeAvy0Sv4nGjl/MwFonge+rZ+lzuFSPiY2AeNzY0UYFc31qXgN
	 9JwZgUHqdaCVuOOTw9fEDHjacRHwQ3SjFbxR5Hkgnw9Cj+tHy7mweMzM9lyTd3B1VN
	 Vmigj/FVefi+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67D3E40873;
	Wed, 11 Nov 2026 10:13:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED07D1A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEEFD40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgaz2g89gYgq for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E67940070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Wi9gXzni
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E67940070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=m7sPSslMp/XhHyrfu0osRwBQ9BwtAetyLUbXF3FxBYE=; b=Wi9gXznixN9UvfXA8kOi3d5UdY
 EjYDbXWIVTvkgOL58KlMNI4NRUel7EcnRh4v64fB5BoT8wvrSdiNCoT/RAwATf4gTWBqiOcEtOhV/
 ZzOfucR+V7KuXK1XBWGeVolpvLjG3GOsHnKIxOHvXdncYg1PXdQ8bavmImnlX7jCqOG9RVP1B5DlY
 vPvZz0gFTGGIQrhuEXERY0Z1V+TzD2fQnenlS3SSw3hhugIJnWN9mlseM+qr+RA5rVBI11tnpIgn5
 H+Dnz4+8n53Ifj+iwrzLZbB+bbV7qRa1kVrmDU9ANglZEQMn0ByObslMGqvUgOonc3RZPDNVhmKGK
 i56oHSiA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KU-0004wT-2r; Wed, 11 Nov 2026 11:13:22 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KV-000Lq2-0O; Wed, 11 Nov 2026 11:13:22 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 0/7] i.MX7D anatop regulator and GPCv2 PD support
Date: Wed, 11 Nov 2026 11:12:51 +0100
Message-ID: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The regulator and power domain parts of [1] to prepare for i.MX7D USB HSIC
support, split off into a separate series so it can go through the
appropriate tree.

The series touches a number of i.MX8M defconfigs due to the renaming of
the imx8m-power-domain driver. While the renaming is not strictly
necessary, I think it makes sense to align with the Linux kernel and the
churn isn't too bad.

The anatop and GPCv2 drivers will be enabled in the TQMa7 defconfigs in
a follow-up series when the remaining USB HSIC support patches from [1]
have been reworked.

Changes since v1:

- Split from USB subsystem changes
- Rebased onto current next

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637395.html

Nora Schiffer (7):
  regulator: anatop: fix probe without vin-supply
  regulator: anatop: add support for anatop-enable-bit
  power: domain: rename imx8m-power-domain to imx-gpcv2-power-domain
  power: domain: imx-gpcv2: do not unconditionally select CONFIG_CLK
  power: domain: imx-gpcv2: set CPU domain mapping on probe
  power: domain: imx-gpcv2: add support for power-supply regulator
  power: domain: imx-gpcv2: add support for i.MX7D

 configs/imx8m_data_modul.config               |   2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |   2 +-
 configs/imx8mm-cl-iot-gate_defconfig          |   2 +-
 configs/imx8mm-mx8menlo_defconfig             |   2 +-
 configs/imx8mm-phygate-tauri-l_defconfig      |   2 +-
 configs/imx8mm_evk_defconfig                  |   2 +-
 configs/imx8mm_phg_defconfig                  |   2 +-
 configs/imx8mm_venice_defconfig               |   2 +-
 configs/imx8mn_venice_defconfig               |   2 +-
 configs/imx8mp-libra-fpsc_defconfig           |   2 +-
 configs/imx8mp_dhsom.config                   |   2 +-
 configs/imx8mp_evk_defconfig                  |   2 +-
 configs/imx8mp_venice_defconfig               |   2 +-
 configs/imx8mq_evk_defconfig                  |   2 +-
 configs/imx8mq_phanbell_defconfig             |   2 +-
 configs/imx8mq_reform2_defconfig              |   2 +-
 configs/kontron-osm-s-mx8mp.config            |   2 +-
 configs/kontron-sl-mx8mm_defconfig            |   2 +-
 configs/kontron_pitx_imx8m_defconfig          |   2 +-
 configs/librem5-devkit_defconfig              |   2 +-
 configs/librem5_defconfig                     |   2 +-
 configs/phycore-imx8mm_defconfig              |   2 +-
 configs/phycore-imx8mp_defconfig              |   2 +-
 configs/pico-imx8mq_defconfig                 |   2 +-
 configs/toradex-smarc-imx8mp_defconfig        |   2 +-
 configs/verdin-imx8mm_defconfig               |   2 +-
 configs/verdin-imx8mp_defconfig               |   2 +-
 drivers/power/domain/Kconfig                  |  14 +-
 drivers/power/domain/Makefile                 |   2 +-
 ...ower-domain.c => imx-gpcv2-power-domain.c} | 151 ++++++++++++++----
 drivers/power/regulator/anatop_regulator.c    |  42 ++++-
 31 files changed, 198 insertions(+), 65 deletions(-)
 rename drivers/power/domain/{imx8m-power-domain.c => imx-gpcv2-power-domain.c} (76%)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/
