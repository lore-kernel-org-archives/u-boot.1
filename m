Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30648606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CLLloZ9k;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=NQw510xJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 043A880E5F;
	Tue, 24 Nov 2026 07:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hqxnif1uZsFM; Tue, 24 Nov 2026 07:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4418380BD2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503905;
	b=RLrpBI+r4SzshmNcpO6G3cTFRbmvqm8C/zT9ymoSglfArdQMZf1xOOl24CUdafybA6Ao
	 z+KE/y+7dSFfSYXmSdfISk+cymNz+HMLNZrnQxP6vwF3oujdKNilvNcsavlNvUa61Yzb7
	 mQOzBrEPxvq8rbDfiuoHii72LxNXDE8HaBKfdKMsOQp45hFEune2VO6pyqZo+LYu/8Kwk
	 FTIScfM42hj5aCnXZviC+1FIISmCpCAVFWuCxcWNI6c8+4lXHJOUK6hhK3IprCWMroCfT
	 z+faqtycp6+X6BGQHW5Ra3t7HrJd4TpIzo71fvejgSA6FMisO1Spd6jo4NXEvcUE8EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:Subject:Date:X-OQ-MSGID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FNlKuAQ7DcSUta9Go1vtCP9fXGe7uMnQwgmhbLcRveg=;
	b=qKgLbl/VrXqnQrYrmyU209pKm+P2XXVZpqsrlDQOSO/z5IipkrGJ2bVu0py4y1s9tkhj
	 TpHD94E5+vBJGs3Xh/RVcopVLq8xQ+XRo9XYyyLAucOjPqZtaIF98IQQyRzLWC/tkPGKf
	 frCNdVx/UYrrbc0Jy0c0D+Gs9pT87X/bYCHiBmbCmDPnp9Rrv43HwpuOe9RalDNARvme7
	 qNNlHiQhjefH5hNhy3wG/f7BfehVqO0X3XgN0TdbgLP5yyogwDbjl0d4ingpuaw94Ako3
	 fbGubIgGeIqxKKgAtwTRVf2XcZvwBs7daXVETqzHp+nwZ0+qbgfIePya//Y4Drmpg5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503905;
	bh=FNlKuAQ7DcSUta9Go1vtCP9fXGe7uMnQwgmhbLcRveg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CLLloZ9kG4qI6o1SPSkx73sBoiFlJ36v46IXKYX3C9iy3lcYBGLcBQUN+90nQ8e0n
	 kbjcKbaUzrB4QKTAsUI6oYGYbYIEQnY+0+UAUSGP688bJY3/LL93uJdQ+IAloC4Icp
	 rfZTU+Haw5dHZbDvbN7Ttfw4yCFFRrJtF37RbZUUn6WWKUwRkCpnJMzIbLWWy1/nbb
	 8RoMEeqxB5ZXGU0nGum+agZvboHO3qFtlCzgqtOSPKmTWEAnK/TkYz2yTTR1Fkv0I1
	 JQXZRy7wdjWlWZsPmxj1QioV67I8FF5APeStVHLzqA9PsHOOQS4+5tthLZeyQODBRe
	 8MhQTBnv1L91w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4418380BD2;
	Tue, 24 Nov 2026 07:05:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F57DFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05300406E5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BHcUqTo63dI9 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C47E2405CC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=162.62.57.87
X-Greylist: delayed 392 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 24 Nov 2026 07:05:01 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=NQw510xJ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.87;
 helo=out162-62-57-87.mail.qq.com; envelope-from=fragrantorchid@foxmail.com;
 receiver=<UNKNOWN> 
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C47E2405CC
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1795503897;
 bh=FNlKuAQ7DcSUta9Go1vtCP9fXGe7uMnQwgmhbLcRveg=;
 h=From:Subject:Date:To:Cc;
 b=NQw510xJ51NxSwsNnYHkA3UGqK0LKlB7yC9/UBwrHoyWIQoUIZ6pSrGr7iDN5mxje
 8vn6lSXubCS19ax1GezK7rd02+EhwizEd22qkbwzzZkyqCS59rTtJr+dY6PDFW720D
 S/ZIyAw9HAkyDW5cqp9a5U6T2vSY0QFVYmHaCBTk=
Received: from [127.0.0.1] ([223.73.111.26])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id E4D2D205; Tue, 24 Nov 2026 14:57:13 +0800
X-QQ-mid: xmsmtpt1795503433t3uc2bbjo
Message-ID: <tencent_806880C4491D20DAE7EED0513B7099E72B09@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/l7fGUuIMyTX+HOOMtHzgH7xx5RvoHCzweoyDB+y9V1+SL7tOZd
 pwxFi3BYNKr+ehjTJtgXqGXLKlyiCjJxtT5pTpRUOhS8PBWtdAJzOdTLms8xWuRST4MGpMd4IdVT
 0aKmix2nu0yfQkVgRn/jc1IrOMPOIj7EJh1i8WYL623zqQuA9TB1EKskbPbv7HiyvNl//T1w3rg1
 Q+6yC8mw8qiIk1BEtBCVJ3DmygNQZErIp2GbJ7E0L9q3YF4Pf1IHkk6U3vWiEpppZsSINyRsAmbn
 r269A76wb2B2Skpjlsp3Avlxk8+QIVnSznkyiGTto1XjZYveB5pN00lHTb7OtxdgDwfomgWMAQa7
 1AQLWejP7rNuCIpMX5cBzecdHry81XRf6aPaIViLCPxWlCYRDrb3V0PmXitLW4UKP0NYc6LIFonP
 RlzqZGWU3Q8Dypz1C8NsTydZ5LSXxh1ed7YnI5U57FIUJczZu26pbGUrQnBEhY1sV34kRQAobhYI
 +JEmKvc02tJX4/3fzdL+ChO6DJZg5xIQcp8mAVQ+ZinEUGYhuIbHX/h+p8xPUQvGTrgGgYJCWWXb
 Ob+2EMtuCYihGTF0MeHvO3Bc33JdRlmHvIRJl8ZxI8BZ0xonp+6Ibm6D1kZa/9B6vt0q+BJ7kcHa
 2rvGv4ZshVSOPnPuEpIfTH1qS1envL0Z1gEYNuiWrwZa+mmDULLhMCpXec0kxdOju3Iu9G+jeO4H
 J6bzA8XXhAZ2JE7vNIOgiL/k3s6ari9V8DuEWFvXlvrzgZ2UcKvmtqRkO+z1FaNGE/pDEAT16WKX
 lhIz5bwXSqeuHzIVePB2n5IqEleDLS7D8uuMLg7cQcspzdIucYP0crK9/5JVVHksS+mh4VqHnHat
 e/yXHj99kzTXjfMeieqNLsgmr0+aJ0Gsfju2bqgqHCDFNiorpyw0ImjSocwl4RYCPPmdynUKvwOb
 N2yFWEra5B4K4kI/kZ+6yH5lLThKwH+64/AE9H/gfaZOY5q0lnsTdqOwYYLLbThzmEIslwr8eWfs
 14SNnoNLnzV1+xvCvCCdEi0imJNKISemJKe+bSMcMNZ/SVQG02iAsACLQ8D1K5CdbotJEIjA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Xuechao Han <fragrantorchid@foxmail.com>
Subject: [PATCH v3 0/2] board: rockchip: LCKFB TaishanPi 3M support and
 cd-gpios card detect
Date: Tue, 24 Nov 2026 14:57:13 +0800
X-OQ-MSGID: <20261124-lckfb-tspi-3m-v3-0-2ade6e655544@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEk1BWsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMT3Zzk7LQk3ZLigkxd41xdAwMLk2RzQ0tjE0tzJaCegqLUtMwKsHn
 RsbW1AA3zNkhfAAAA
X-Change-ID: 20261124-lckfb-tspi-3m-0084c7193497
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v3:
 - split the board support and the MMC changes into two patches
 - correct the v1/v2 explanation: cd-gpios support is not needed for the
   SD card to work

The LCKFB TaishanPi 3M is an RK3576 based board.  Patch 1/2 adds the
board support, including keeping the board defined card detect pin group
in the SPL device tree, and patch 2/2 makes the DesignWare MMC driver
honour the cd-gpios card detect pin that the board device tree describes.

Correction to the earlier versions: v1/v2 claimed that the missing
cd-gpios support made the SD card fail to switch to 4-bit mode, and
worked around it by remuxing the card detect pin in the U-Boot device
tree.  That was a wrong attribution.  The 4-bit failures were caused by
force_jtag exposing the JTAG signals on SDMMC0_DAT2/DAT3 (GPIO2_A2/A3);
the mainline SPL clears force_jtag through
CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG, and with that in place the card runs
at 4-bit / 50 MHz regardless of how card detection is handled.  cd-gpios
support is only needed for correct card presence reporting, which is
what patch 2/2 adds.

Note on the author address: it changed from
220110626hanxuechao@alu.hit.edu.cn to fragrantorchid@foxmail.com
because the SMTP service for the old address is no longer available.
It is the same person.

Testing: LCKFB TaishanPi 3M with the mainline U-Boot SPL and U-Boot
proper; the card is detected through GPIO0_A7, 'mmc dev 1' reports it at
4-bit / 50 MHz, and an empty slot reports "no card present".

Signed-off-by: Xuechao Han <fragrantorchid@foxmail.com>
---
Xuechao Han (2):
      board: rockchip: Add LCKFB TaishanPi 3M
      mmc: dw_mmc: support the cd-gpios card detect pin

 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi |  8 ++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 +++
 configs/lckfb-tspi-3m-rk3576_defconfig        | 64 +++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 drivers/mmc/dw_mmc.c                          | 12 +++++
 drivers/mmc/rockchip_dw_mmc.c                 | 38 ++++++++++++++++
 include/dwmmc.h                               | 13 ++++++
 7 files changed, 142 insertions(+)
---
base-commit: feb8913982e4462c01fd914271f92254a25dc101
change-id: 20261124-lckfb-tspi-3m-0084c7193497

Best regards,
-- 
Xuechao Han <fragrantorchid@foxmail.com>

