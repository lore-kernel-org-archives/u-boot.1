Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2915C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 03:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BB95608B4;
	Sat, 15 Aug 2026 03:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVEyR_Vo5tIb; Sat, 15 Aug 2026 03:42:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47A1C60B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786765330;
	bh=oZdQcJOCTlGOzYCU/LIrOdRCMJnOh2OxYvniDB7kyT8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J6mx4VpzFkmc9J42zALPgaHbyxtVHR+wpJai/CMCXeFCLdoy+ILNXrSFx6sK/fhI2
	 zMIEmHOhMmTWqh4c4o2jKL4DqtRXz0+a56eLv6bMZCej9Q9dgfkgwcC/ldhOr582mp
	 NWV+vP/CcH+37o+tEbLt7DylJ+V1E9mmT/OISA2WGsKEfE7JFz92+vF3LlaiAPEN03
	 zfqr/76xnzUV1YXDCPuD3P7i9Ctw2+xpx8hZeSlvgmG+tZbgs3ZojV3QA2dFngPNEa
	 OT9iTRt5AcCbalxxlTY+C+a/Gbzqrgpi5Nil6r9Q4kO1vSc/x70nudmSalJmpEcBOd
	 CzDR2DrGpVivA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47A1C60B1E;
	Sat, 15 Aug 2026 03:42:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6A173DF
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B21F640CE6
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CSYXMY0qZWKs for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:42:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B72F240811
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B72F240811
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=cLwGNBEY
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B72F240811
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786765287; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SVL3xsfHPZ/TuS94lU85/d0fG9CRtzj3+hnVwUJiIBRagBbFR3DexAaGnpZyaSTyxi6ay80RrjR2AQk+0joeZV4i1Hdu6KzX2KqrsdI5lHouXV1hVoUMPN6e3qOJfnyCm3nlwIcoUa7AC0ynnJV2D21bmxk7FusnooNYNOPBeoU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786765287;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oZdQcJOCTlGOzYCU/LIrOdRCMJnOh2OxYvniDB7kyT8=; 
 b=ZLOfrDiBYDvYiw3gC5HufK+bT9dqk61bKCio8JbVmgRfShVYVSylnBfHePcKc35qvCJOBjdveEARF9RRatJDj/NaW8lszRsykNaPeI/LDW0MmLk5VGlcPvLO8KRpUgNTJDYMDoBkBY+RNCTEjEEpXN+qIF0+gVWTe7CL6yrk1ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786765287; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=oZdQcJOCTlGOzYCU/LIrOdRCMJnOh2OxYvniDB7kyT8=;
 b=cLwGNBEYWtbYETlOqZV4DwAuM/If8RHudfgPC5AltTYZJnLIevKh4iGr/+g/NIz5
 5+0+HQQqoApwuelRn/06U1QuzusP1ncAWA8Cm8g93z+NLpP3sYteM2qCxMLkYqFnVju
 yta7TtA/Xfx9/Y3iQJGtEWqyydmr3yQ9hdM1MRPk=
Received: by mx.zohomail.com with SMTPS id 17867652856591018.1355806199289;
 Fri, 14 Aug 2026 20:41:25 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 0/4] i2c/clk: spacemit: k1: fix I2C bus configuration
 and clock handling
Date: Sat, 15 Aug 2026 11:40:20 +0800
Message-Id: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQ6CMBCEX4Xs2TVtRSKefA/DobRbWH8oaZFoS
 N/dgleP32TmmwUiBaYI52KBQDNH9kMGtSvA9HroCNlmBiVUJU6yxLtEVgYdv1GU1tR0cLY8asi
 DMVCON9m1+XF8tTcy02pYGz3HyYfP9jbLtfdXPEsU6BTJ2rQktKsuI3dPH/RjP5HpoUkpfQF8t
 r0IugAAAA==
X-Change-ID: 20260814-k1-i2c-fix-04dc9e3fd45a
To: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=QKAy4+r+Gxgb8YATRTm2jGIehVdTrFXQilayxgw8suY=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLq759Zcqudl4W5Zamidl3y0j9Xb7KK/vK2eLTqrf3Rh
 hWBjbo1HaUsDGJcDLJiiixc/uL/rHV4vh0RaL0PM4eVCWQIAxenAEzk9Q6G/7GCv3VfsEXcefrl
 91zjmueah1k5/qU3aBmfaI8Wf6z8IIXhr9jPRta7G59d1/n7TfWj5/Qzeb8u9qy5VmVY1LiPk2l
 /PisA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix two issues in the SpacemiT K1 I2C driver and clock provider.

The first issue is that the controller bus mode is selected using the
functional clock rate instead of the requested I2C bus speed from the
device tree.

The second issue is that the TWSI functional clocks incorrectly include
the bus clock enable bit in their gate masks. As a result the I2C driver
can operate with only the functional clock enabled, which diverges from
the device tree description and the Linux driver (both expect separate
"func" and "bus" clocks).

To fix the second issue without breaking intermediate states, the
patches are ordered as follows:

- First add the missing bus clocks (and their parent chain) to the SPL
  clock tree.
- Then update the I2C driver to acquire and enable both the functional
  and bus clocks by name.
- Finally remove the bus gate bit from the functional clock definitions
  (except TWSI8, whose write-only register requires the combined gate).

---
Changes in v2:
- Split the original patch 2/2 into three patches
- Acquire the functional and bus clocks explicitly by name instead of
  using the bulk clock API
- Link to v1: https://patch.msgid.link/20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech

To: Heiko Schocher <hs@nabladev.com>
To: u-boot-spacemit@groups.io
To: u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Guodong Xu <guodong.xu@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

---
Junhui Liu (4):
      i2c: k1: fix wrong bus speed setting
      clk: spacemit: k1: add TWSI bus clocks to SPL
      i2c: k1: enable both functional and bus clocks
      clk: spacemit: k1: remove bus gate from TWSI functional clocks

 drivers/clk/spacemit/clk-k1.c | 41 +++++++++++++++++++++++++++++++++--------
 drivers/i2c/k1_i2c.c          | 27 ++++++++++++++++++---------
 2 files changed, 51 insertions(+), 17 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260814-k1-i2c-fix-04dc9e3fd45a

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

