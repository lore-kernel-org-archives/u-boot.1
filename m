Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98180CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E87580DFF;
	Mon, 19 Oct 2026 10:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNgmFnZCFP3K; Mon, 19 Oct 2026 10:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEACD80E0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406077;
	b=nusVE3DehBtnSJeJVNJuALKqj4Qvz9YgwKj1l0tjFV00fZopvrghqnrmXNInWdhBx68b
	 Ki35KptcB0oKOX6tJOWWQ6sYHOoF9YG5SBr7oe+vh+3/2MJrk7f0med2Qi5VfOvcgXfy0
	 SH2mzDRHPd7z3Hx0tcO6fAVCzNyrLJiDdWai9h0jyhBXvPYE9VyZFklGiYF9VB9kYAQdO
	 UVY1MxX/xm0vYdbqp29Djwz0PZZUYmzbDAIN3IF0s8ZrpVGbkMKw0P3eJyagE1F2onk1f
	 vUZwrOhlAWYZlWS1jmp5QHsUrgTWOp6u32suY1aK1e8YSWXz5PMH5fcvODz5MqFsPLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Oe/QUCIMa3CdOCnCSuTICDz4Jjjf6/H6g+TaVAUYkx0=;
	b=g++vVgwnKDqBMwB8A58HkOb4zM0s+ld07R2FN1qGIEZZMpHIdCpIWBBrNYT3vWoysMmJ
	 XGPDETA2xkc9KTQVhfO9UKllMpEhnH64/SXrq2c5Fc8We3fRugbNx+Ipoeay0MGEM82dM
	 xMUQk9eoL1bEVcwE1fuRMaOe85xGicpZsObxCEBBXFoN3keiqN/s0fbE21Hke2Ug5dm7d
	 wkQTSmhuUWecKAeu3fcak3o3ccqXDmWg87+1H7CNWqfvzmQJTKS6gcZvK8BvqrV/nHI/K
	 nJvK3fFi1q5Hi+TcYmpkUILHsTK9PeyOiOhOirckc4qwdoV4FOcQaAXVAtffANy5i9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406077;
	bh=Oe/QUCIMa3CdOCnCSuTICDz4Jjjf6/H6g+TaVAUYkx0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G2bsSmc/yQyCrm+kFBus6QwTrDtQ3GgA75DBiNkR533v31MAKrfs/pKoxzWT7iNI+
	 EtvGr9B4L2r78/r08ITt5wor94i6OmgTeeJSGD2xRkQmzKkPFb62VI2nCXgnb0CyHG
	 +GEzZgBqUUrl2xFVqnQk9V2uraxX3BdZmfr+7F9HTj4AvldSASQHEtfaMmK+ZMbJBm
	 +38D/nsN5EMvRgsO4VgB+Pgmo9b5GM7DEZu96d/vYpe1n/rtYAVt0n4gWnT6C3kt3W
	 5OHmk8EYbaQhYWeP+zxRYNW/fXXB9SDiIB7OdQjC8N74qMzRTTtELHlrmxBCqw0pGB
	 fiL+2cE3pE+TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEACD80E0F;
	Mon, 19 Oct 2026 10:34:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF1431DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B115A40080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vtj2tOnljb1A for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF44440079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792406070;
 b=Ol19qm42C6P8TyABgcVyk4cRAvxdNcd5V4naKa3W7qVeKjQaME/wEmftIMB6H5jIpVLh
 klKTpTKwZQzSK2FcphGXdzQDgGJEUHbpMh5L2ApNJMzt+EYf9kYuAtjuuC6fimZbDkNyW
 mr0rE8qOThv8vKgDyoe03eOa+0/BowTNuUsN8138f190FTVO56Z2uThFv1DAr/o+t0FEW
 ijdvX/ImN13o7rrJ09Hmnt2GS2f47EXLOgiLLvP9PS+cQk/MBK9eiI/6lPapxBY3TmH5A
 iZCxWscxGY0Mdx1S1TAYJLeqpAuCSEsQHolFTbkM7mPyIlganlfpxNwtnqPo5oFejNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406070;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=Oe/QUCIMa3CdOCnCSuTICDz4Jjjf6/H6g+TaVAUYkx0=;
 b=sKPC57/4elIncvHEACSBe+/xd9IX+IfbxQNFBjcfYGEbkZS8lpIZZw8miJtUB1Fogfli
 BQ5xC7W209l6167VxaOF8b74Hzgp/6lQ3o+R5niJcxJKRYjlm+BArL7/Upmgbuc/sKVGa
 L08whxPMSK86uscyrjq9qtxPMi+pVbIFLyGBbRPijXWrrBjELJOtovAki6ZdHK9dyJjY1
 YykYH7keF5pmjiZPCWb+VH8RAhjHG8nG7QA8dQmKnG+PKrSLbLnhRszs9U+CnE+D2Okfk
 X5Kkvr7ngod/3vVa6kp49P9LO9JiJkUCADTp3GT9+1F7+ktgeEu5jHGWRW25/V06l1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=qf7IEcfW; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=qf7IEcfW
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF44440079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:28 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792406065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Oe/QUCIMa3CdOCnCSuTICDz4Jjjf6/H6g+TaVAUYkx0=;
 b=qf7IEcfWAI1JLQOyRLuYnUpRDW9yCU4GgiV9Kn6+naadbBZSP5KlDG3vVMqOACqMHI+5Lv
 wbi30EcdWKSJn/AOiMSgjR7CU6Z7wrKnS1gdQz+zsYtxJ/WmBYsxYrzvKEWW1HDnedIkPP
 7nBqIsLS7cymM7tW4GWD8HujUZrJ7v911jVop0Kur1AgG8740FLomkjCazilNguaVLwTL0
 nnCJG22NNXwUZ4/jGMtp6ItU+Vd9jvoQkSwf921SnO7al3cfG9fTcu1NqdKTnkDp4HdF7A
 at2WAPattViujjK83K6HE7d/uRIR4HZiXYh2ELpOPsRNXoqllC950hSntM9W9Q==
Subject: [PATCH v2 0/3] ddr: imx: Fix repeating ddr_init() on i.MX8MM/MN/MP
Date: Mon, 19 Oct 2026 12:31:06 +0200
Message-Id: <20261019-feature-main-imx8m-ddr-reinit-v2-0-be22a99c6fdb@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dkxLoIIr72FYVDqV0dCSaSEYw
 t0FvIDLl7y8/xcRkQmjuGaLYJwoUvAb5KdMtJ3xTwSyG4tc5lpJVYJDk0ZG6A15oH6uerCWgZE
 8JaisKkqHrmpLK7bGwOhoPvr35sdxfLywTXt0NzqKKfDnODCp3ft3a1Igoa6Li9RKa2PN7R184
 uDPFkWzrusXEH53et0AAAA=
X-Change-ID: 20261015-feature-main-imx8m-ddr-reinit-8d145fef8c5d
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=5aRa4R3IzBvCpzmVvzf5KAPELBzhjVkN/C8owU8/3+0=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevqJwWmv9/mte/MMA+3XGYgxLFz95W8q/0r45/nFmzrs
 lvh8kOgo5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCJcCxj+qfYee+jNs0jr4Y+l
 5yPnWDjt/pU/0+haa53B+jpO643HZzP8lZ5VfeYh//U/78tDHURaZpV+51YuMPx3hI21mcNUJKW
 PBwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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

Some boards probe their DDR configuration by calling ddr_init() several
times with different timings until one of them works, e.g. the Kontron
SL i.MX8MM and OSM-S i.MX8MP. This only works reliably as long as the
previous training run failed. If it succeeded, the DDRMIX is left in a
state that the power up procedure in ddr_init() doesn't expect: the DDRC
is in normal operating mode and the PHY keeps the results of the last
training run. The next ddr_init() then reports success, but the DRAM is
not functional. Depending on the SoC, accesses either fail or freeze the
system.

The OSM-S i.MX8MP board code contains a workaround for this that was
found by trial and error: a short additional size check before the
second ddr_init() call. It doesn't fix the root cause, and other boards
run into the same problem as soon as their probing tries a configuration
that trains successfully on the wrong DDR. This happens for example when
adding a 4GB single rank configuration to the SL i.MX8MM probing, which
also trains successfully on the 1GB variant.

This series fixes the issue by bringing the DDRMIX back to its power-on
state before ddr_init() is repeated. The DRAM traffic is stopped, the
DDRMIX resets are asserted and the DDRMIX power domain is power cycled
through the GPC. Asserting the resets alone is not sufficient. The
power down sequence follows dram_enter_retention() in TF-A.

Patch 1 fixes the GPC registers used by the existing power up procedure
on i.MX8MP, which uses a different GPC layout than the other i.MX8M
SoCs. This is a prerequisite for powering up the DDRMIX again after it
has been turned off.

Patch 2 adds the DDRMIX reset for i.MX8MM, i.MX8MN and i.MX8MP. The
i.MX8MQ has a second DDR domain and is left unchanged.

Patch 3 removes the now obsolete workaround from the OSM-S i.MX8MP board
code.

Tested on a Kontron OSM-S i.MX8MP with 4GB LPDDR4, which first trains
the 8GB configuration successfully and then repeats ddr_init() with the
4GB configuration. Without this series and without the workaround the
board freezes, with this series the 4GB are detected and pass a memory
test above the 4GB boundary.

Also tested on a Kontron SL i.MX8MM with 1GB LPDDR4 to make sure the DDR
probing there keeps working.

---
Changes in v2:
- Fix i.MX8MQ build failure due to different macro name (reported by Fabio)
- Link to v1: https://patch.msgid.link/20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de

To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---
Frieder Schrempf (3):
      ddr: imx: Use the correct GPC registers for the i.MX8MP DDRMIX
      ddr: imx: Recreate the power-on state before repeating ddr_init()
      imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround

 arch/arm/include/asm/arch-imx8m/imx-regs.h |  10 ++
 board/kontron/osm-s-mx8mp/spl.c            |  14 ---
 drivers/ddr/imx/imx8m/ddr_init.c           | 196 ++++++++++++++++++++++++++++-
 3 files changed, 204 insertions(+), 16 deletions(-)
---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20261015-feature-main-imx8m-ddr-reinit-8d145fef8c5d

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

