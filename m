Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FEFCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BF1040752;
	Wed, 14 Oct 2026 16:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQaZNHVdnOMr; Wed, 14 Oct 2026 16:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26E2F406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791994594;
	b=llwkDX33JV2gIVNWuLxMAHWL7kTYmJakejXP+UtKUyuDbDEk+Ibj3uhl1dEkxMamFFqG
	 cRZq84+FlxAlqN3QEUBDvFIqjEyrQy3cpXtsS5MVGtEWwD0EwVR9YT1DQUNneFcaaeUzR
	 ZbaUnOPWXLTSpqET0a7FZLuzFdJ+VeEVBe9x9p1fO00b6AZnmuSgXyHj/eEttV3sAleon
	 m5r5XI0YzPb6u5HqpOp8mKi3KMqVoONzqs1rF85ZnLqYULyqB1WY6KebtdHmVch1pzkom
	 G7vwtAzH9BkMoThVMtKV6kSQPm2axoBOEyhvq6inSTO/MzRbTde5VcaZ7qdQOb4waag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=86BlbpCeL+GoelB6tkTHsNCYhnFmVOK9lFM+W2KKOUU=;
	b=lVY/XUtsHvsJpLPv39EHuQ9yV1CvXkr70hJGFKooNgHJmrZZRZz1QjkUpaGA6pLBrjj8
	 pRBCzlyH3oz8WG3kuLymMW/t3TWDxTjhuw+LMLQfLqFGY3KlAUMdQ6Zbm80UJAAYLbBAM
	 5gQg/vIteHpIwaLxwXv8RK3YYS6r7qtk1H6fd3fRIx3HV6fJ5mT8RvFqmD0r/GlBTEvNH
	 HHEmkK17lgfJOijWtv0WKhZ2hvqw65WolwXXCFBSdDBuUS21TrVIg1nJKe+LdHZehgtEE
	 zHA7z7OX9ONDSNsxP3ROVyXqq/10T0es5cTy/qcFxyjvL89NM8udk/1iIJJBYgJIxRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994594;
	bh=86BlbpCeL+GoelB6tkTHsNCYhnFmVOK9lFM+W2KKOUU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iRkrvsQbxXRdWGWMYjhK9e6TqZPjs7972WTKmtT4RnXPjxgABhPm9ToZfVggG4Roa
	 EUzgvbUySKtCzzhd16pShhbshpkPxbWl/uZVPunHt0H9431EukjB5SNqKOsYqS02Qz
	 pc3+TBUR1N6v5KG8pJN6v0NvcUIRdJ24evIUQOdo50KTfSHcbV8hAtQ8JMPlDpCGln
	 LhXK9QroNLXdLd9IO/DjAS6ObBOkJr3uByCJaWarn0WEC6YwJUpMoRBVpyAF91GnlV
	 Jq4QeaidYh+KXxAX7vtzXlWdZkd7kwsxlMf01n/gy9LMTwa0RlrBhcMDA448SeErYj
	 yW05ipKomzMMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26E2F406C3;
	Wed, 14 Oct 2026 16:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F81D769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 264DE606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynyerrNUjk9g for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:16:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB105607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994592;
 b=UH9qBomPbDuEUS3GXhOWR9eyDiAeYLfHjyMiUMv88GNsdef7cw+A/QPA4NXBQy2ekunk
 jVYKdysLxvZtKlbZeIXLCew56Ksmka09hBMjVv43GdiJKczaTUII2gAv9vSWWpTgsDmGp
 ERF/c+ZMhR+d6hTGQrgEC/Oi1X81jPHxxAVxHLQ1lUpYSa9Icg+z54mTEO8BsEUIaDYni
 Jk81dW91pd5lZdtNlq0QqoLJfE0y+lQ70MPthtaLK0epctUy47ROjtgraLqAYNH4QNds0
 GqECBSn5P1dQ1+1sMlnK9CdPOz/1bfKYN1o8vQwhbRGkL5BpEdCa/9GtH2GN8PAvrVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=86BlbpCeL+GoelB6tkTHsNCYhnFmVOK9lFM+W2KKOUU=;
 b=YLVSEBJZKMb/7kjUYWcOHx64CCcFxWBPCtfsEP89qBarpstjidM85ImXo1Yb71MvWa8C
 29SA7AYWvEqNIrz2p2mcs87vDtBY1VlSBlN6chm7og9btLJdAkk9lmKBw9UBdz6pFcsDP
 qY5ZHBnHC5RC736e7Pyq3XDqZeZcxMfvNkOYXuMo73erUh3rHgBRHvOq9mIGMX+jsp21+
 dYlQk9nN9rzUN3L3IPwxBw5X/8/MqyXA0EFbFxu+RGRt7PI5O97pd63rUFDTnyLScw1vq
 I+6CIEy2oCbQUb3lQTczSDYUGBnmNlPTOLzcC36wnVAMOUo/ZzdzeXlWy4maFZs6Zww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="M82Ax54/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::b;
 helo=mail-wr2-x0b.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M82Ax54/
Received: from mail-wr2-x0b.google.com (mail-wr2-x0b.google.com
 [IPv6:2a00:1450:4864:30::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB105607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:16:29 +0000 (UTC)
Received: by mail-wr2-x0b.google.com with SMTP id
 ffacd0b85a97d-48afbc2b18bso881022f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791994587; x=1792599387;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=86BlbpCeL+GoelB6tkTHsNCYhnFmVOK9lFM+W2KKOUU=;
 b=M82Ax54/Z+Hz7p84G7vsqW7fA7exxLsDQdOv0/QMmn1GfUtqQ7Aj9W1ABrDFM2m692
 ApoxHs5RrA3lfQsu0H76AYFEblTN425erMv82fUybEwKNoMUO95OeAbOwnoN1jkil3v1
 kpzSb1KzxA0OxhGPh7bElm6RUzhHmB3zg1Xiq19iIeOYfK8+xJwv7sjOtwnH4Jz3rCUC
 f/bmMDykQg6bwGCZ/aUdLTFiUHOMPNo1y+vA9Mh+eugjHpC+iq1MFpjO8QoRTj+4T+1a
 w1L8MlF3emjdgW9e0aQfuOLBYtVgzxzFLdQitSpvKJeVWa2B8uzz8vxm/bPpLUmeO/nn
 8fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994587; x=1792599387;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=86BlbpCeL+GoelB6tkTHsNCYhnFmVOK9lFM+W2KKOUU=;
 b=yhefsfCG3ulCuwWvdUvg0PEwQm2m3DyvGRh0rOn6sI52+oDvTykgcQhH3ZUVkKVGgK
 lNpb3A549fx9Y4FaPPG/1x8s9QZgEpdT6cswZhoCS24/ZleafZkDUOtgCDrYq1f041Nc
 3YuVyUQ34XuTjdIc77K+5j2R01vvt1ro6VeuGNmp/WIvnHL9qlPjJgpf8z4mwF78B/7a
 PqKKo6+hrEuzMRzwpo52x9G/fPxemUhN1Yd3T+wxmQ59mCZvnUoDl3l47w1Bnrg1mfNs
 0aNQXHHccIR2YilU9GW2Dcw1/D1/thLkvVeClzqH9jFngNCv26fyrHsfnQnlVM2BdoLC
 qo2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsHMeO4OoyBdIjMOwtci726rYPCj4egJfshsurVA/2AnA3EhmEnCcDKNJ1jCf8yn1r02xJ7vI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKD/1gbuEYEJD67lXWqxmg7cUcnqo1ZJ4vSaGvgiBtaG95p3I3
 6Fph5UYIct1WSe3Mkir1vhMeJk5YuzDjy3rmqy5U4pE3VsQvS6aUzV1VQjJth29E1Bs=
X-Gm-Gg: AYBFou3I4/j3L4YAHvI3LElEXLAAlfr7P7+pKuCFEvhNZUsOlUtcDYr6M19SJol58nB
 5PtyUv12iPiXAa0Eg9S1zAYKrxSvAjQUE7ChiNyMvE+xjaFm9qcHAWAJEGRS8eycSzvdaYIs3GK
 9dyIpJ0/Vl3ARc+b+uKYi7gDsY5VQqVNBuGeRKhYWz7FNJceYfb5OjrewJT3L9WKlRvwhHg2ymB
 Tdno56dwlpwopiRY1u8E15cO0ug6FRRHSBAYWby720wos5ooS28fP2CmCGjQedc5VExU14/CcUs
 1F16bLXFedxiL4cI/oeEBM25uI2YK3DdE7ew+XG80jAbiw1QrgGDs7AnGDC45LbUeWCuK+5/qrT
 W+lJgmkjqiXk4f/egeIZqriOTf1DdQg+35r6LicClKwfhIIkg5kl/iO7s8Mtp55tLIjJvehVHpX
 SZHHWPhaPCuUqqVuhliPWgNML4qB+cNgW7qSZheRXgvImTtojc/rXE8juHyfWo0KShPb5zr55Xq
 mThhC/Uqjnu/YO+huWRlXQpReRASHI6UQCd31v/7U6BtzzXa3T/5Z6KW1x0xkgGWqmX5tyuH0i5
 D5VuBMn2UyTmXOfdYtUDGfDXM1xNjnauR1EjI+S5qFTGMJo9eTGS7ZI=
X-Received: by 2002:a05:600c:3ba8:b0:4a0:174:579e with SMTP id
 5b1f17b1804b1-4a18e4ab221mr376110015e9.28.1791994587557; 
 Wed, 14 Oct 2026 09:16:27 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9934eesm2204315e9.10.2026.10.14.09.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:16:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/3] Add MediaTek MT8365 power domain support
Date: Wed, 14 Oct 2026 18:16:43 +0200
Message-Id: <20261014-mt8365-add-power-domain-v2-0-dfc3e6eadfd5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQy27DIBBFf8ViXSrAmEdW+Y8qiwHGDW1tp0CcR
 pH/vdjuppW6vNKdc4/mQTKmiJkcmgdJOMccp7EG8dQQf4bxFWkMNRPBhGKWCToU06qOQgj0Mt0
 w0TANEEfqgVtZKxaMJvX6krCPXxv55bTnfHVv6MuK+2kk/LzWybLXiIOM1E/DEMuhQcsDc12LQ
 mmDDJVsbasZQrCuF15zyaTTvFtRA+YMm2tV301lNX3/rVjVubF05pRRcDYYH1jPOBwd3D+iS/h
 ct8kqe465TOm+fWXmm9uO5erfB2xYp5UJmjtjO/8HuyzLN9+dg59uAQAA
X-Change-ID: 20260902-mt8365-add-power-domain-ca1946099a87
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

This series adds the power domain (scpsys) driver for the MediaTek
MT8365 SoC.

The scpsys core so far only drove bus protection through the infracfg
register block. MT8365 also gates some domains through the SMI common
space and acknowledges its way-enable protections via the read-only
infracfg "nao" mirror, so the first patch extends the core to select a
per-step register block before the MT8365 driver is added on top.

The domain tables and bus protection sequences mirror the Linux
mt8365-pm-domains.h data.

This series depends on [1] for various kconfig cleanup

[1]: https://lore.kernel.org/all/20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com/#r

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Add MTK_SCPD_STRICT_BUS_PROTECTION domain cap: some domains need subsys clocks enabled after bus protection release, not before.
- Fix SMI common mapping: no syscon fallback compatible, so map registers directly via ofnode_get_addr() instead of regmap_init_mem().
- Add probe-time validation: fail with clear error if a domain's bp_cfg references BUS_PROT_BLOCK_INFRA_NAO/BUS_PROT_BLOCK_SMI but the regmap wasn't resolved, instead of leaving a NULL to be dereferenced later.
- Fix commit message: correct Fixes: tag now points to actual upstream commit (ecaf11aaee98, "pmdomain: mediatek: Add support for
  WAY_EN operations").
- MT8365: fix mis-named/mis-valued PROTECTEN bits (MDMCU_M1→MM_M1, INFRA2MFG value corrected to BIT(25), add missing MFG_M1).
- Link to v1: https://patch.msgid.link/20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Irving-ch Lin <irving-ch.lin@mediatek.com>
Cc: Julien Masson <jmasson@baylibre.com>

---
Julien Stephan (3):
      power: domain: mediatek: support SMI and infra-nao bus protection
      power: domain: mtk: add MT8365 power domain
      configs: mt8365: enable the power domain driver

 configs/mt8365_evk_defconfig               |   1 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8188-power-domain.c | 164 ++++++++++----------
 drivers/power/domain/mt8189-power-domain.c |  74 ++++-----
 drivers/power/domain/mt8365-power-domain.c | 236 +++++++++++++++++++++++++++++
 drivers/power/domain/mt8366-power-domain.c |  40 ++---
 drivers/power/domain/mtk-power-domain.c    | 166 ++++++++++++++++----
 drivers/power/domain/mtk-power-domain.h    |  66 ++++++--
 8 files changed, 564 insertions(+), 184 deletions(-)
---
base-commit: e91d0b53e2678e0e6439370ead9bf2c71404b715
change-id: 20260902-mt8365-add-power-domain-ca1946099a87
prerequisite-message-id: 20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com
prerequisite-patch-id: 349b47fdcaa519c4bb9430a7d0a9cf34db04b64f
prerequisite-patch-id: 82685c1627b230ebcd75603c5b199ca61b53e53d
prerequisite-patch-id: 102fc1198a2b104b6fe2052d7258a97ab1f6033c
prerequisite-patch-id: 410192d9062fd4a4fe9152a0656cd00fa960d377
prerequisite-patch-id: 65651c5a260e0b28b3561d504b494f6625932a2f
prerequisite-patch-id: f710336972a49695622783e0724531fb2a2eb07f

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

