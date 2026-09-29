Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F5CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEAB2404E0;
	Tue, 29 Sep 2026 04:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TtxdoR9_Z72r; Tue, 29 Sep 2026 04:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0E2954047E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790655464;
	b=LE0EHT29udmCWe/pUZtry12/GcGkGx2VSo0P5D2rAybVWDmtabe+4N+E3sOe5YeYIbCB
	 Ghb6NFZuTcqxr7lfBqAxC36YGLokmGkEakEteVUBhs64oSiRxBgXm9h01bgMl6YnGC+4B
	 UkFIOsX8vOB0hC4gT7N/3kHFFzQ42E5LwW1fOSv6YqpBo3HMhrKhEBZhqux2CTXqdM9Tc
	 3M0ZWFOFZX5ad/JO48v1DJM49OPbrEuMv7k2Y2rycQWp3yE3AVy2dvVHEiqWQtVfuftcP
	 E/VFvWS0EO1h0CGC2uKkJDfWJ8oNVJY7GuFykWLoaosjWT2Gi7OvDPNbhZPDH7pc4Qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790655464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=urpyVrWh3xgP0/9X9IcaBLnDCaos6QurD78hecrgmEc=;
	b=U6gBt5KLfCx+L3KYmEYQYa9GgVoZF1wuLJ+oJEHfHPpi/z/G7+mXGvof5cy2E/UX8ohN
	 GR0BmG6Pv3ZQTcY7gIurAqvo9Y4f0szTrCmgL5eDWTbv9U6HSxwd8ALni1VVHahaMZxmr
	 rMbxz2ImrEUwDCYVgS17Y4dxpandP65AD+OCmqOOUHCAYC6c9tvk7Gmiw9KFdiTGAhoxT
	 6cBu7ciTq1dl7oLk6j3hVfrzAbQ2n17tiNt+mV2z3q4tUC3m8JwAecA2VxpIyTY/IA2oT
	 FictbcU9FZfUxE+7Bip9zTfUNBsNoJ51/+HqnuR8gzPpRid6x1oiTDY7/WZxmRUjBeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790655464;
	bh=urpyVrWh3xgP0/9X9IcaBLnDCaos6QurD78hecrgmEc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ejhjK8pdKMNbWjcUTvTHueS+iVZY2eUyW8tQIss3D1eK+7nMRJCq7KFuXFWcGfg3x
	 44fDHDA7XjmDGK1Or0SEC9V4ThMDTu6VpgusPjVzUZAdmcVlk8kyZWsUZ9moNyIYkO
	 pWZeWpvIUyoJ7Xvq4rsV9WhaiP3SoRBljyMTI1mcPtb7f/WczNnSr1gJhRvz+yX8/P
	 q+EZ7TlvZasadFbqD3HF8Dl4VwkDgxOa/5VtK+3/Ai89nYwyWmbArUTF6ogFLrP32Q
	 0uT56CquGC01Re5ZQYIu4qe2GvvO6e68fZlIAPorKEbcKbfjLf5VynPErdVUBtrq5j
	 M5XFeJAcXoJOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E2954047E;
	Tue, 29 Sep 2026 04:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC30ED1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B6A80AAE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ljdhwYl1em5 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 74BCE80AAD
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790655461;
 b=P3Pm/q3zW3QuNKzqfvEe9juWw1osLwKH++KxGID5gTqU4QsuWv8DZJatfUvhiP+C1Gq/
 ZNjOl1hp8RA/j5j05NuGybhUXJKEGQHYuc8MxCrRg3StHjeCKMJIN0oVzr1vEo9e07dv6
 mmk/Z1/IsMzrOpqHwGbeYC8mDJCfW2wgjseyq4yh4fJvKnbCTY/t0cvIjc3FuSI3TwoGQ
 +ovnegh0WedH8UEBcXgATJLzHyxC5ZYELZ45EY5zVc4HZdty5MeTjaAyurpG3SgwCCp3K
 EBT/7mJ15Xhv9KUr/Ct24bRx22Kgepo7EaTWK4HkOhxqYAPq5OSeyF5rA1165+9BvFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790655461;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=urpyVrWh3xgP0/9X9IcaBLnDCaos6QurD78hecrgmEc=;
 b=gL4RtKKEiE4AkXhkSE/tflZ1EdeokSwYEw0u5cJBAV/vxCug3zLuALeWI0TO2vBPdfy+
 0py6ooyZvkucgtVr1C1bfFz5LeVa9jdTCv8Vhpxotqbq81MUf9dR2wFbeplWcWyC8N/+6
 E6rV48twpmLO7wXztCg5URNhRFC8xzXfCtZNyZF3yOeV+PnRl+4qzoW7tqIHAjc4EbtDS
 lewLWyq8P527/9QS1p5n9mnrivriiImPozxxKSDjoJV7RmpmCkLzimFc8pmctEQ7fsINw
 //KRmgY1VpZIDItyFW+wWu0Rfe1ZG4uDljUX0sybzAKpOKNuxu8UbFh6j9sKhdxpcmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=dz7ZIAIj; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=dz7ZIAIj
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74BCE80AAD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8748D106095; Tue, 29 Sep 2026 06:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790655452; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=urpyVrWh3xgP0/9X9IcaBLnDCaos6QurD78hecrgmEc=;
 b=dz7ZIAIjP7+7wiUHYyJIdN4Tjm7vz8u1SNy5IilP46NPiAn1HAkpZUC3mrNU91GpRXiFi0
 jSmfDg7XY5FS1tF4150MbbhSjh+dMZb3O535vaV6At4JHtIh02L3vJPf/lSv6VXAhqgASA
 hhEmxexrUKMx95ka9D84wXlzjAQQaj8CnpTasYOzcGoiz6Vz/pXIfby4cg6PMd6paUbs1d
 UjsB3Dd8R03QDQvc8HahTPqFghOti0Othxl4JsJ/v5Kbx4xAhGuzJtPajvvVF2TMrhez2E
 cPjcSDT3I3nhOQLstEzGDtxoFdBK+m0A6zGghCZwdfy5qJPQlrLzaryZXviK/w==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Peng Fan <peng.fan@nxp.com>, Stefan Bigler <stefan.bigler@securiton.ch>,
 Tom Rini <trini@konsulko.com>, Utkarsh Gupta <utkarsh.gupta@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 0/2] imx: deal with the RNG self test of the i.MX6 boot ROM
Date: Tue, 29 Sep 2026 06:17:15 +0200
Message-ID: <20260929041723.1383361-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The boot ROM of a few i.MX6 revisions runs its RNG self test
incorrectly, which leaves a HAB warning behind on every boot and says
nothing about the state of the RNG.

The first patch runs the test correctly, before anything else uses the
RNG. The second one makes hab_status name the leftover event, so that
the warning stops sending people looking for a fault in their own
image.

Azure build is (now really) fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=215&view=results

Changes in v2:
- Dropped Gaurav Jain <gaurav.jain@nxp.com> from Cc. The address bounced
  on v1 with "550 5.4.1 Recipient address rejected: Access denied". His
  Signed-off-by stays, it records where the code comes from.
- Disabled the option in imx6dl_mamoj_defconfig. Enabling it by default
  grew that board's SPL past its size limit, 241 bytes over in CI.
  Enabling LTO is no option, as it is already enabled.
- Added the MX6DL_MAMOJ board maintainers to Cc.
  Simone CIANNI <simone.cianni@bticino.it> is left out, that address bounces
  the same way with "550 5.4.1 Recipient address rejected: Access denied".

Heiko Schocher (2):
  crypto: fsl: run the CAAM RNG self test on affected i.MX6 chips
  imx: hab: name the event left behind by the boot ROM RNG self test

 arch/arm/include/asm/arch-imx/cpu.h |   2 +
 arch/arm/mach-imx/hab.c             |  16 +++
 configs/imx6dl_mamoj_defconfig      |   1 +
 drivers/crypto/fsl/Kconfig          |  22 ++++
 drivers/crypto/fsl/Makefile         |   1 +
 drivers/crypto/fsl/jr.c             |   3 +
 drivers/crypto/fsl/jr.h             |   1 +
 drivers/crypto/fsl/rng_self_test.c  | 157 ++++++++++++++++++++++++++++
 8 files changed, 203 insertions(+)
 create mode 100644 drivers/crypto/fsl/rng_self_test.c

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
branch: hab-rng-v2

-- 
2.55.0

