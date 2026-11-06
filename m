Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31429606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axaIkvTy;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=Z6MatYTT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E1108118E;
	Fri,  6 Nov 2026 18:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iy12jmPrVfLF; Fri,  6 Nov 2026 18:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBD0B813D0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989382;
	b=Ar5nU0yLtWzcSfZJDNaEhBmuXjczDIzByXRxOMAoZUsrOLttX+edhGLUsXa6vAJw3xeZ
	 kZs/kIuxh4Y5WDOPfzXLQZ++DYEpvJoPNzqnEkS1povr0veoBi2HyBt41FPlmGmZca81I
	 EePgaEyv8AiNVcRVbQgLu7u5wFG7AvAfXX13Amt8M2yYXyc1haxTi4tPb3fhzf6jpPN4w
	 k0Wu0HlBKptROvIJy9gHsdp8coXfNWeesngwg/ojp7Mdj5damcMnTwA7VhjUh5cre+uds
	 bsDQzGVc6mBKDYuyqJlNyYuUIQwj6CbwpkLB58sVipySY18cTJG3V/UwndYY71Vx14g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oWDHm6MMXnKojEP9esP7IPzbd8ChvXD0K/ayuj4m/dQ=;
	b=qMDRTWsqt3fAD3EOOhb/fNAT2KXNxlx5+UlMl2DQkLksMISJ81aMPiHAIniVaJk2LZwc
	 eLzRAfhYmKyaP8ET5C49IKVT31pB/xvcwzo7KaLz/A+5gHuBUA0+KVl7HPdXPsyV2mby3
	 skYhHBdyLB1PkEILXATI19ri+QI9EBlCGqQY1ZonuyC4pV4w4DS/VKkBe4Yvbzm2Sj6Oc
	 PJG2s4Ma10q1PgTL8msVQkA/m9dThoxKcQzxaA0gjNYSG3nyWN0+mrSf+vW4gAccHtai5
	 ktgSioGYLWB5PO0Idd7q05zmFfW59feyWEKuGbubmib2MtGA7pyKEPuGhxcXp10aaiw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989382;
	bh=oWDHm6MMXnKojEP9esP7IPzbd8ChvXD0K/ayuj4m/dQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=axaIkvTyvVhLS/LRGrkpjJduuWxYytRmjsevE9seHzr+BYOW+MfOXbm5x97RQVZAN
	 sv2lr2LxLiH1jaDE7PV+AbsWOGkRJiN1liW2kRUSnn3xATLX6G9SXbtFp4wmeur8dy
	 5Q11uTOYYZoPggXYnojFEe4ubjeWQO0ugzdRa1ajf3XLPGrOfXzw9oJ/inNkx+XkhY
	 8N143oKnAtSJm6CeVK1ICvappV4MzGmuXB8Gd2B6cNS9Ugjdk+T7AzWRBzIA6bw6NW
	 39mai9uuHt3/VtNIQHVqfTEhP0qi3sm7xTflk2JqgSjCU+dl2vgVqpLcSvfygmOBAW
	 GHrhQCzmakGEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBD0B813D0;
	Fri,  6 Nov 2026 18:23:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9D3C34D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F79640802
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6u_Z5QS_yZco for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79F3E4072C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=Z6MatYTT
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79F3E4072C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:12 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-89f28c3ac7bso333957b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985012; x=1794589812;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oWDHm6MMXnKojEP9esP7IPzbd8ChvXD0K/ayuj4m/dQ=;
 b=Z6MatYTTKZHvZpuxE2muyDX4KBBw2+gN1HZzJCUeEOEii7WyvrgESe4Up7foqGvG/m
 EIiaGJ9brlzRv1oE1LHc2xFKfs88BDPxGaYzywhRE7VJRoEENEELEsRoNrGYbynvRSS5
 Uu/jY6773tk2BF769DX/6PwgcTMeFIzoJJgMLWBA2y0q3qAMZaZItPZqVQ2CT7DbUcNV
 nu09eYQKM3Agdid3qkq63SHsgJT5yExOdx7DSVQ7g4LSQUZqIAlWKllEW8mVuRd+gL77
 DWl7pgijdAxd2TgKFbIHCuRIuhlelBlF1B2tlmqV6Zk/dUb5/NodUW2aBFcE14kWzzCq
 miIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985012; x=1794589812;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oWDHm6MMXnKojEP9esP7IPzbd8ChvXD0K/ayuj4m/dQ=;
 b=Dg6LPXpgTY8VfnNFPlyNdMu2hwrYgfQvXTZC2v26BZ6ysP0WKyTzLUARUe3VJHiUx6
 10W/59U5n/82Dihxi1RKVneM8LldEvf3JDmCXfnfWCgxCH+nDLhOo/0J6MzYV6NxZTws
 v/qc9qz2HKcHDfUK5fesd9AUTbbI14LLQcH6CLHNI1KtidV9mvQciDqxSeUr/9/KboiP
 OOEEMIqSzhZSvhKGyIugDuWrGse6Nu9LuXYVEijQ+Xn9OHwORGTbNjhbqoeo4knSisDj
 KRCZ21mV6IWWT0S7NrWz8mLAOh/to+dk3rqgjL2qemXwqm9wfj0nWbGI5MIXs9H0UOXf
 UhRw==
X-Gm-Message-State: APuU4Z/DnRXoh+svwUzSYCQ74iWwn9DilpQRHLlLnf6q7mSkYrJ5bUYQ
 A+Q2Yp+q5kePqJUDZgZEdJE++jpp/WkBeJTCx20m+Uv9SAfBwLr2ITti9RuZdSrXbQw=
X-Gm-Gg: AYBFou3uUD+irdfLiLtZcCEwflIvOZHR0oq/9wFFqjUikXeffwqWyBJ7UNJD+T7rPgZ
 F/WSE4rLwLDX6F3RycB2CSbVvOYSoaC4kLZ0P9YahC6cI8f2ivkQkIwVKe5zhVHhUYeQc7TcSnK
 D4RzawDtt9pHxzX/9ZUiCVYzED5vCcb/V5C6Uk5kNxUVbR6WwyOEEePlqSsONLxUIpFadpAq04p
 8JqyO6Ln72mtIyqO/cVWF0mkhMl5py0O7JTGBs2ovtTUBXKXPahbAk8SjJdTdoDULZtGDLDlQIF
 d1piQDVP8jYPPzuQxCTyT9dqWt+DfzKev1u4G5m4EkILsoGalbC2ZNJQ9da7gvAimUXrZ4qOI+0
 ddwF8Y8Bhw3uwZMIHJ/yjmfjxAQTp5BefiCSjHago+jE0FtNf+HuxwjvRk4R+IWkAZu659hZbQ6
 mWxZ43vPqFVu2blS/L5yz0iaJmkucoOcS4q21/6JAJHqYfUbLDURSw27wB4m+Ybv4xeHrRUZqNh
 CPior/BCtAlv2k6HUuId7cyjbP+O0FPEok304pdDsl9N4PVI9/7GS2WdgCA41AFf+vOlOImuLgM
 aSeS7w5k5WQ2PKEQwmZUKBgDfnS4OZRXBcADgUKsa7d7uU10UWYjGI8j4VAcfvKCsjxSYF3XJEK
 1
X-Received: by 2002:a05:6a00:8c05:b0:89e:a2cc:8263 with SMTP id
 d2e1a72fcca58-8b37817fbdbmr3055453b3a.5.1793985012055; 
 Fri, 06 Nov 2026 09:10:12 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dd36d3sm767461b3a.37.2026.11.06.09.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:11 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Subject: [PATCH v4 0/4] net: zynq_gem: fix resource leaks and shared MDIO
 bus teardown
Date: Fri, 06 Nov 2026 10:09:03 -0700
Message-Id: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAJ7moC/4WNTQ6CMBBGr0Jm7ZihVRNdeQ/DgtbpT4RWW9KIh
 LtbuYDL95LvfQtkTp4zXJoFEheffQwVDrsGtOuDZfT3yiBInNqWJH7m8ELLIyYeY2EcuH+gEur
 YG61ZaQV1+kxs/HvL3rrKzucppnl7KfJn/wSLREJhSLAmEtKcrxPtJ9YuxCHaGbp1Xb/q1qbyv
 AAAAA==
X-Change-ID: 20261103-zynq-gem-remove-leak-b2b5afccebcb
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>, 
 Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984944; l=3983;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=93LlcTIPHiFWcICN0HD69VMlDDgfG4aqLZF069BNFqo=;
 b=NiwLAnKpCZUH73gVxQQ9mfyzDAbhinlbhjSXp15vj6y0257Lrs12E7RlXJMswh7+45AGDkH3F
 lGergGdoD5gBrF0/3xaln1g3GecoSkuEph0lw1XQid6/R8aLfjOzO4L
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes resource leaks in the zynq_gem probe error path and
remove(), and stops zynq_gem from tearing down an MDIO bus it does not
own.

Patch 1 stops zynq_gem from unregistering/freeing an MDIO bus (and the
phy_device on it) borrowed from another controller via
eth_phy_get_mdio_bus(). Patches 2-4 plug the probe error path and
remove() leaks, including the SGMII serdes generic PHY.

The eth-phy patch (4/4 up to v3) is now sent separately, so that it
can go through the net tree.

Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt) with a DT in which
gem1 shares gem0's MDIO bus and PHY. These runs were done with the
eth-phy patch applied, as it was part of the series at the time:

- repeated unbind/bind of gem0: heap usage is stable. Without the
  series the remove() leak eventually exhausts the heap;
- unbind of gem1 (shared bus): gem0 keeps working. Without the series,
  gem0's MDIO bus is freed and its next use data-aborts;
- injected failures at each probe step (except the SGMII-only ones)
  for both gem0 and gem1, followed by a successful re-probe, without
  leaks.

The SGMII generic PHY handling was tested on the same QEMU machine,
with gem0 set to phy-mode = "sgmii" and a nop-phy standing in for the
serdes (QEMU does not model the PS-GTR):

- repeated unbind/bind of gem0: the generic PHY's init and power-on
  counts return to zero on each remove, and each probe re-initialises
  and powers it on. Without patch 4 both counts climb by one per cycle,
  so later probes never reach the PHY's init/power_on ops;
- a probe failure after generic_phy_init() (no PHY at the phy-handle
  address): the generic PHY is exited, and repeated re-probes start
  from a zero init count.

Changes in v4:
- Rebased onto current main
- Drop the eth-phy patch (v3 4/4); it is now sent separately for the
  net tree (Michal Simek)
- 2/4: keep the SGMII generic PHY in priv->serdes rather than a probe()
  local, so that remove() can release it; drop the zero-initialisation
  of struct phy, as priv is zero-allocated (Michal Simek)
- 4/4: new patch: power off and exit the serdes PHY in remove()
  (Michal Simek)
- Link to v3: https://lore.kernel.org/r/20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology

Changes in v3:
- Rebased onto current main
- Split v2 1/2 into three patches: shared-bus handling (1/4), probe
  error path (2/4) and .remove buffers (3/4) (Michal Simek)
- 1/4: also only free priv->phydev when the bus is our own
- 2/4: free priv->phydev on failures after zynq_phy_init(), again only
  when the MDIO bus is ours
- 2/4: call generic_phy_exit() on every error path after
  generic_phy_init(), including the early returns after
  zynq_gem_reset_init() and the rxbuffers allocation, and
  zero-initialise struct phy
- 2/4: use descriptive error labels
- 4/4: rebased onto the eth-phy reset control support; also release
  the reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
  guards, and reword the subject accordingly

Changes in v2:
- Move mdio_free() out of the mdio_register_seq() failure branch and
  into the error label ladder
- With CONFIG_DM_ETH_PHY, priv->bus may be a shared bus obtained from
  eth_phy_get_mdio_bus(). Track whether we allocated it and only
  unregister/free it in that case, in both probe and remove

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
Graeme Smecher (4):
      net: zynq_gem: don't tear down a shared MDIO bus
      net: zynq_gem: plug resource leaks in .probe error path
      net: zynq_gem: free buffers in .remove
      net: zynq_gem: release the SGMII serdes PHY in .remove

 drivers/net/zynq_gem.c | 70 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 23 deletions(-)
---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261103-zynq-gem-remove-leak-b2b5afccebcb

Best regards,
-- 
Graeme Smecher <gsmecher@t0.technology>

