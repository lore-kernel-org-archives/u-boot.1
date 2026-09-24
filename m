Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CDC98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18F0A81E1D;
	Thu, 24 Sep 2026 16:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYFV46gK1cR0; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 599C281E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266381;
	b=GWniIMlRMEq3fx5m1MbLn2DZUU+t0Phkg1O6JZs01G0GLy4TEUF1CgMMwtXf63WHUoWr
	 sQa6Fb4ACI77H6pLmHvXeoOTB4IkubwTES8dsN+W4W0YPShIRPCz3yXX8In589Egn/k/T
	 7IznE2MM1Vvjm8exPFoMKyJCB40WHEt6ZuG8Wk9KeGYfBda+i+CdPGOM9oChJHYmSW+2Y
	 0FBMsXdB4J5I9th70ObeUAg57ZtuSt+wcbCkPzWU33xkH6dwLkQCYyloPDBh/T5B7ikia
	 +yOXy7v82/1mevc0QIqYj7fgXDwP6xaS2wZa0TPENPSmL9CN7Ezommu13LMzxW7fzjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Dmrjv1QgmzlektrMws475jhWqnxyBIXGrAaIYaj1RzY=;
	b=A7sOS3OiEarNx+Min52/CpTrdYPEh6lrxm6I3njeF5sr9vLzerkHaXSYc+K7Fj/Q1iQq
	 wRYzPHVIqL/bT84JxcUVJiGiDTz8uuCeAhmXj2tb0ZrJHd9pJDKkYVZLtgY/WMfUutAD9
	 i2zzKmq/OyhJoiauVX0sT8t9F8F4rvLa180NoZzUoMCcuxIQmPFL1BybO2GI01XgQyDbt
	 SktzoP43kaeLGxXj6TpjL8QeKwjZmDd5ShLP8zLDzcDgeU2jSxMLrf/kXtfohaRLivb23
	 ztUDSwprKZwVgJTHwc0f8sEA97y7EiDE+w1ybw+MvKJyQl4u6kNmtbbCTY6u/0MWLkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266381;
	bh=Dmrjv1QgmzlektrMws475jhWqnxyBIXGrAaIYaj1RzY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oXj86ljMEPHhkfEXehxU7viAwlISnroVufQ04dHO0SLDoEnA36nZExVg4wfTasfVv
	 UXYL1Qd3/tLdkuRY6xdW1ODr+zjJdvxXlexzpd0F9gLg0z5gdWg0yqYu+cCNMef+L0
	 WiV3RyVBtPuZMW4Elk99hSVSmIP4nzWg4NKxp8Qvbz+O1uBOBNNLe+iury/Ngv8dsd
	 A0RDmjT5McnE0ztzvneKqccUw8xrYE6oiWqxBcHurJoyrIjf1Iu8yHVHE3B9jqp5Ja
	 +UTkCqryqoY3QJD2tYt8Zsc7XEGQMp3QqncLzlLh7Mcihs8+ZZwY8K1cVGAMRdjHyG
	 WzGbNaODdXxzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 599C281E09;
	Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CFB835A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42A004086F
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0K368LkqMml for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E93C407FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266379;
 b=B8ptJOVqGoBdNKhspWLgcDIKyvT1AKZaMcGJAylddmfngJetIrqSO+dv9i1QOEnUoorw
 /AXgOKPK9a/w5ACZjXSztUR4rM4QHE+NfCK7cNSLm5+Uz7Xc+R9YZ2PdgJxR/C46SyLog
 o8FqH+fw0PNlzXEyQy8K4Wxxgv9qBqaaqy5jmnCC0ORZGM1I6zY5GV/s8pP57uAI1wFQY
 xMHz8c5EvQMTTHMcGfO649dHtqWZleO3fN9VSVhSOefNLmGBTsXNGIeli45CFJCcHgTSc
 xZUGSGbFAhIAKzgZ2TG4Bj4LsuVfyoiFISXZ6bMCdbpkdhvGlcMx2qYtNXZg0/IG6jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266379;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Dmrjv1QgmzlektrMws475jhWqnxyBIXGrAaIYaj1RzY=;
 b=PGHT0eZ0CdeswC5Xw6OFS5ShNEVhVEkmIODP7Gzv3f0wZVbmbwG9m/zuv3u7yZI075Sq
 Ykhw19KamjDH1Xmy+wWx3UGlwa9e2NoKCxvEc7xvsEWugxz4D7pcH+Du2bJMLh+aP4uds
 C9aURq6c2lnGVB+lZMdVAk+wTPiM+sYgKtibgj4YloTimU5s/uuqHhd2a+JeQeROXkqIQ
 OAm5c3LYV/wrBPwaG5kq96DFJAD2vjMF5TdAVI5B7qvKSSiwD6IJdSLhHVB2b79Axc1iG
 NjhbW9jql2a8Hkj/pcOKazn+eiYiW0X9OlMe29bwPAVLuq0zmoUQOcph0oe/WUcifHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=Lf77atZd; 
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
X-Greylist: delayed 601 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 24 Sep 2026 16:12:59 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=Lf77atZd
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:201:9162::2;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E93C407FA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265829;
 bh=Y8TJhO5+KfiWZhNzy4RcsrdHTdoVp8rYZp5+Bamq7HU=;
 h=From:Subject:Date:To:Cc:From;
 b=Lf77atZdFjq7/S2OjrA4sDUPDoPVAkRPgIDd+sp2xLo9vXnqSTK1fMrwsaCGIHzZF
 IRqhoul6IifGk2Q6+wYhTOWhJY5oivVIx8NgCCHsN0aaTWZ6rpx0OI9NPKGj+HC6va
 FGAbOFXYSUcemUToXX3R2PogKu4WAzuBW+1R70TuPtE+oBdwboZxesjzJu/5N9KFRl
 Y6PKZx4AHdRSpDnn0js9wmNJ/YQiNKsL3R0R2VyF8IoKZRqRS4FCvruaIUEe3CF32k
 VxDSg1jFyCuf9ru1I+CY4JtF+Vq3w4+oGHraulvd38ESoTcQ2SRNbkNTIvHTczarLh
 Ampbz/k6NII5A==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A150417E04DD;
 Thu, 24 Sep 2026 18:03:48 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 0/2] pinctrl: mediatek: add support for MT8196
Date: Thu, 24 Sep 2026 18:03:46 +0200
Message-Id: <20260924-mt8196-pinctrl-v1-0-4df08627ad64@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNj3dwSC0NLM92CzLzkkqIcXfMUcyMTy+TkxGQTcyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgBFOpoMcgAAAA==
X-Change-ID: 20260923-mt8196-pinctrl-7d7249ccac47
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=745;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=Y8TJhO5+KfiWZhNzy4RcsrdHTdoVp8rYZp5+Bamq7HU=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUnkb+0/CFSYedcSOFckIXGNu1VPxhkrVt86G
 UAYeC8EJe6JAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJ5AAKCRDT67WWa7mR
 lvGGEACjc6O3m9s+H0qAOvVhr2AUKg/1LK0C/Y6wDos9/nyIRC3ayYgG8oF3LewgWZQ7Y+C2R18
 8ko51znmGyM3GVf9ODM2dS6O9+RM0vsR+afJPDyptx7KASUKNT+PSEtnWcFriAAR9oy8rt0aKj6
 SQCoW/p2cz4lgM5fTxZ6KGgVpEqJEh6m6BnfoHBROfs+t6S2jropikzFnWD1tDuw2goHW4tsCJt
 OYJtfAaAvHudPCJVLK2uHG+WBAPGAHg4Us0//gabRo84TrZiRrg9gFsZ/11Yri/p0eo6k6EOM0m
 EHzNcNi4Q9FhnurNYt9Oy7tBQR/sXf2EK0VVYPA9PXPf9ZfS5Z0GMBxSr0Y9XN67h/PeHIW1GLW
 lw/9u4zK5pmJP9yihzUkM+ZnLDrOI7pzYlW7Gzj5MeMcu3qflEEiI8zXXZJ6YMM004EnB2N4Ty2
 xvUBRMoEkxOnvUmn9/FtyId29/83KgGz6jtPmjDpA0QzmPMDc/E885gaXthSN9LPq48A4IkFtsA
 l1XI+3C+nbbqiAHT6JODhuTeA6BJ/DLB3CkC8hwlTGAJT0hPQOH5irh3r22BLFxI3Zd/x6VDzCH
 7AE2OGtYWAa2IBTAKQaGvza1CORCTwhbvjRbDBylYN+6tFjMYcSyfO1bAvt6pQ05fcwAVXI1hKz
 ezT5fJOAhHd2L1A==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

Add pinctrl driver for the MT8196 SoC, based on the corresdponding
kernel implementation.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Arnaud Ferraris (2):
      pinctrl: mediatek: add pinctrl driver for MT8196
      pinctrl: mediatek: further increase max number of base addresses

 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8196.c     | 1905 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    2 +-
 3 files changed, 1907 insertions(+), 1 deletion(-)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20260923-mt8196-pinctrl-7d7249ccac47

Best regards,
--  
Arnaud Ferraris <arnaud.ferraris@collabora.com>

