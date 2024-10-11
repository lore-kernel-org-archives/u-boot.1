Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7D6D0D785
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 12:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F8C892B9;
	Fri, 11 Oct 2024 14:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728650567;
	bh=GChvqh/gYMY9g+SrEubJNdazavdj4iL8246HD7DPw5E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cQtwncuhviAdKL0Np+kZolmSTxaWsHWi+5unGyUzf5fV305xQTKxCsE6QIV7sCLpf
	 EW4lIDmg+oMxBU70LdPQMqS43JD0vTopERRHnaqHoFy9TbK3NHsMkXCX57w2HUQOxm
	 6XDtUCeubDv/+qsQkRSqW2ov7JI2bo99V90oEWeDhOuZL4D98NfCaD8BWlg7Z2VO85
	 Jd4ZfWPZ2OpNh7enpaFKdcLgCwZx+m8SkQ2XpKKh3hWaWT63dRI4+LLCOTXZPCLBWe
	 TYcQLCH2sUGAFCCCXCAd9zASp+qjIWhiWHxNGGrC55XJFvrpAjMnH4qMm/xxs2OSXR
	 cXFQOwPfMHHew==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2A537892A2;
 Fri, 11 Oct 2024 14:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728650566;
 bh=GChvqh/gYMY9g+SrEubJNdazavdj4iL8246HD7DPw5E=;
 h=From:To:Cc:Subject:Date:From;
 b=xgqqk+VxmpA+nFMhHNR39dkcR8ZOx6uv5RZHCt0waujMvZW0LmyT7IhVKdmcdQbF9
 6lDlMWi4SB0twavwICc7uZRk3YYLbJD9gF+d61iYp6WxjpwyIg7KQuXPzCyQi1f2/e
 UhFu4GHZdssM486Bdh1Bi8RQNa8xfHXb+bis4C2Ppn9KxJSb6iKyx0PfWZ2E9yE1x4
 dFTtIBr4h0W5GTEB5U4hFxgFRfuJvH0/abW2pmnm8zWzIvBUThO0Dv5VfC+I2RQcQs
 8XPYl8tbZuU4Ku4Y421hHzoSrAUeDZMFoyvEEcX5h97TFOa3dubzTvHPUV2t+e9Qj+
 iYvUl5VM5Eyhg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PULL] u-boot-usb/master
Date: Fri, 11 Oct 2024 14:42:20 +0200
Message-ID: <20241011124231.9198-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The following changes since commit a404065479be2c1fe1167c3c91367e8194a69d1b:

  power: pmic: pca9450: Add missing newline (2024-10-10 12:17:46 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to c69ba5a4fed62463fb137eef8ed1fdc1aba2ff1f:

  usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case (2024-10-11 05:11:06 +0200)

----------------------------------------------------------------
Jan Kiszka (1):
      usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case

 drivers/usb/dwc3/dwc3-generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
