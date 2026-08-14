Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEFAC5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 01:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B4A781170;
	Fri, 14 Aug 2026 01:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3r1OtyyWitH5; Fri, 14 Aug 2026 01:48:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CB6780E50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786672097;
	bh=tSLSBt5JLzqWgneXCjpvZ8sFM+OAxP1KkbeRATSQLXg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LkaiBiEveNATuVQZEY9ccWw38dlFSBpOlTNupYAaCrCHBYYTg9b2hsO75dzTHZsfC
	 C+jYB6VK3aGSG+24VpNN4LOo9iXiFS9a/ZtxIarXPoSvH01BL+dymmB2thPzqvpSwQ
	 cBtQOWnOsCWaufBfJqxzTex+Q52P0dcUnLRWnVrcUJ4zE+Wpc/ZVxcW3+vxhe4/hKg
	 D06eHzN/2FKhAY24N+UigkTPbB9B6swokvZgna5UsXTAIjRYqLQin9+5KBVAYEJSfW
	 Rv9hJdJfUqi69pAGdMHygEv2HG7AGkGbd++NKDEwXU7PtaeWdPqvbLsOcQ6YHkwshz
	 x6m7mx0IyzEfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CB6780E50;
	Fri, 14 Aug 2026 01:48:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 172D9282
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA95F605FF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xzvZMtZ4Yfze for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 01:48:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD5F860633
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD5F860633
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=X00jtZoJ
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD5F860633
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786672058; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IgcrZW+N0t7o1Aam9F8yG25QFV4Ku/yaLc4kFAAqvYPI94KKZhHniAivGOOSJR0WLxSNYHb+g7aI24TeadNV1kX2aSUnggfIS4L22JhTNA95DsyHBGhtGhn/e1tuPBZFmy9faa7+e2vjseP3m2L8B35gx0syw9dzhDAn0oa7uoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786672058;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tSLSBt5JLzqWgneXCjpvZ8sFM+OAxP1KkbeRATSQLXg=; 
 b=calsyC2c9t+CNIT4v7YHQZL7kbsQhJS8Xc25Rsyu1ckxYcO6YknPryG3kX4elTSzqKMjKjNWWH1W6Vdt0lcbar2pWHgiubFdlliW4nmMWVkHBrb1Gb8OAXbpBjA/4nP7PpOqll4Ckx+8w42VdKXez9IyDFJBK7/l40pppOuiauI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786672058; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=tSLSBt5JLzqWgneXCjpvZ8sFM+OAxP1KkbeRATSQLXg=;
 b=X00jtZoJOglvOWIi6FjM3Vb+RdltsTN5qrxMXq1YLIxOuMzzsm5Qzv4pora7tpJR
 GqUAXb1zIxQ/DQKxhfnVul3ASgAdK1eih8e5Z002gKygpdFrG+8LPjuhO+LzNENZA28
 VgiSSa7TLS+E7F8n1tSQHNj7vQVfEherVEO+PkgY=
Received: by mx.zohomail.com with SMTPS id 178667205710498.8118656835602;
 Thu, 13 Aug 2026 18:47:37 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/2] i2c/clk: spacemit: k1: fix bus configuration and clock
 handling
Date: Fri, 14 Aug 2026 09:46:55 +0800
Message-Id: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE3SVgmuIha0gyFBWkQi7q5Yf
 i95/wWeHJOHMrrA0cGelzlAxhGYoZl7QrbBoITKRC41ThJZGez4RKGtKSjprE4bCIfVUZi/WFX
 /9ns7ktneAtz3A01+GoVuAAAA
X-Change-ID: 20260814-k1-i2c-fix-04dc9e3fd45a
To: Guodong Xu <guodong@riscstar.com>, Heiko Schocher <hs@nabladev.com>, 
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=4ck9tkV3WVeVZALHhHPqClI6hhmGDmGPxeH9xy2ZTuc=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLqipcF7z77bNq6jTsPMLgfOBVkfG/VsRnPfjWuey+pe
 LRdwdhqe0cpC4MYF4OsmCILl7/4P2sdnm9HBFrvw8xhZQIZwsDFKQATEfjN8M/I7YVJuImN4pSm
 ZyeKUiy1Ircw+h26wfWSR6mpt2F2+heGf1ozJT8zma2++5FV5sO1x9ct+X7l7dV1ubV55jK5pA6
 ORj4A
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

The first patch configures the controller bus mode using the requested
I2C bus speed from the device tree, instead of incorrectly using the
functional clock rate.

The second patch separates the functional and bus clocks in the K1
clock provider and updates the I2C driver to enable all clocks described
by the device tree. It also adds the clock dependencies required by
TWSI2 and TWSI8 in SPL.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Junhui Liu (2):
      i2c: k1: fix wrong bus speed setting
      i2c: k1: enable all clocks for I2C controllers

 drivers/clk/spacemit/clk-k1.c | 41 +++++++++++++++++++++++++++++++++--------
 drivers/i2c/k1_i2c.c          | 19 ++++++++++---------
 2 files changed, 43 insertions(+), 17 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260814-k1-i2c-fix-04dc9e3fd45a

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

