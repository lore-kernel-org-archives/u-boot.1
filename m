Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5170CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3284440D48;
	Fri,  2 Oct 2026 12:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niARAwqP8Eil; Fri,  2 Oct 2026 12:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CCE840D77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943979;
	b=rkoz9yfpxTT96fBYT5XQU5cDC3/5V+4SY/vmI+ARBblZ29uA/+kxCnVOiF5GMitnFamG
	 RXAlvVflKsAOKIQZFOJ0Kx2LHA5PktEqJcxURW0LUMYjmF60pOHX9NXauAYqjwif4B6wT
	 6g/ZWRHjFFmxo120RbE2Qe1lpS0jkb6aG7TIqTWNeaoSuiiX2j2zAFhizpiNFM4jcgVuM
	 5pRMJuyObdi+DFuO20Hynos/R5ZfmobUO9qNzP7uQYYPhSSA6LXW6bb4OUNr9idFHG0Fx
	 Oar10hi8w+iuQ53HFtOdVMF2YEcbjqIjx0kEHryrxwhp8raM+oOLqtDyr+X2JPN4vNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943979;
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
	bh=DrN0GM9vsJtle69fxDb1xywy7K78kPsm5JWQ7ghizN8=;
	b=V5pUjXdgyeui9MYqUEBp3sRNdHbukn4v+L7OXOaPnzBxBDpI2gMMyChzydL+Z43+w+Sy
	 35ya/hG1uCNi0qnK3LSTVg1Wu0To//y4p07iQokuh4gEFJ3lw+1yjcqeizg/gFj+jjJY0
	 1TeFKUlfBCnUoykCDT3yUnVNBDg+OUWLWvHU23/8XG1oA/ED1H2VkbOxt2eclD9xLm0Hu
	 T3gP/dJcN2qng7KapkUrD82G7NTiIaZZL9L3jGH0leehRGsgO3qsH2zLd1bvLkmJ7sag7
	 sVd/yZ9w0KSh/7al55H18F/lrGm2tWYV+YdX5siHKTcCSqKqNppfBybShTlXIrdB1uQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943979;
	bh=DrN0GM9vsJtle69fxDb1xywy7K78kPsm5JWQ7ghizN8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bE7gTkyGswvbsSylAvIvPHUsOMO06CjG0qGLmcEBOwleGvzyVTnTGvi0B5rHJ1rJg
	 7/ZD/gfZBJyANBn/aUyVuFxXsb851Lroz053YrTjebdwfD2KFDYeLAi2An3GVDAps0
	 LyPE8tSNu4LLertDqdkU4wut/IvaG6aLgUO+QoLSF7aYNRv9abdAwOHY1deIq3nFm3
	 6ouD6jHBMzumbVzdfRUEVJOZbom/bPvdkzVzmzNXhLlXna05V+afBzMLBsb5z33ue2
	 Rte1ltZNrCybwKo5j73FNnueX8mwWP5m1SGmfEyfi/4m1rcN+89yy8MicDSpVTbSZj
	 1ZSr8M3HFUFNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CCE840D77;
	Fri,  2 Oct 2026 12:26:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 062BA4D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC457400E5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70Qpg4Uo-KJx for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 184C040062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790912193;
 b=XPWdpNohS0xUB2S9NYKu9koJf22PclD/mXk0PBIfRMTph3Zd9xDWRZvvDhBqA8IBGGJN
 6SuTfZ4DYnjP5JDLTUOOo9EUCVPJafXo1gqLUubZSlPuM8gugcrnDSw5GjRmpvIBu3QdS
 MkRlZBoJiT7BfwKWtJY5BY4ggXRj+X401mmjXDFc+D5IoMfaY06ZZHMjtT4cQrFvlZ6Iy
 DZWxo/0p/6wcfXVaaggYbAleqeOXFFmjxULECDTKNlDmZzSEbDSWwBwmdVgWC/saRxJkh
 ZLoNGh0ZCaExWZ8INSZg9OU+DFHJ/AE+OI/ANN27m8a29NrZMU6q05xVhxgVsoyAv6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790912193;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DrN0GM9vsJtle69fxDb1xywy7K78kPsm5JWQ7ghizN8=;
 b=TNCtTWSVdy+ClpECUz2+hgRXBeoQfryxPKho4v8QBxE58OuR5Bp8FQTvPeD5o3ZjB/Ob
 qrIlXZUZneSpXIRPX1ny9tgbEYA+OJwRC6rdy/3v6vTDwPJIunOSWNoZx8zcUiYPHXDI0
 1F/JVmwwOtyQ5XW1FAqZSqFgHbsNk9QSpi3kSjJqNd1far9MWieKozKyhFlPJhLJnz5zy
 iCPvnhJ264M/fC9P02QuQRUkT4qw181jQXk/lU7SH4u7K+jL75I6EOOz3jAAW1n23nHiP
 APwTDYneS0zx0K+b7oxj+ad5iSb2mx86xKleJ2jenUcqW5GA6JfaXY8qdYYVhSeBFkw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eTWtEz9A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::c;
 helo=mail-pj2-x0c.google.com; envelope-from=sycamoremoon376@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eTWtEz9A
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com
 [IPv6:2607:f8b0:4864:39::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 184C040062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:32 +0000 (UTC)
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so4734775a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790912192; x=1791516992;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DrN0GM9vsJtle69fxDb1xywy7K78kPsm5JWQ7ghizN8=;
 b=eTWtEz9ALPCO649/E75ZXi0wMJc8dREsMQat5j2nMHou+4T+8IODcnjC3fWhcntyuB
 ONtyyrKM/8bwF7Xg3zGJ8aqUWOhxuHjeT0M93mYN0F1LgXbn2rpue7WaFYu1riQV6o1l
 qzOjixILHpLIsTVNUM2LAnVEhKoXRi6zDA3yW8EE1XAdosNWHY2A6s8I3ZFiVupvSsww
 GIykPh/b60KHLGpWsP7JSOT+IMuDY7sqWuE7hy7Oyhbnoz6uW5ZTRI9hrd6SDTB0xzOG
 wCFws/5RcCIH4PBDKY1buPPAv/rKKTrQrzkke/WHDs1cpQoymfrIFKpO8zujbrweKfwS
 4stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790912192; x=1791516992;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DrN0GM9vsJtle69fxDb1xywy7K78kPsm5JWQ7ghizN8=;
 b=nOzFOAat96UUfBnKSaGmcOq0gi17rE52RVh/xfnGhkghJWnrHrR63BHKQshZo937PW
 V2tis4uqfnRNfSuS9Ngx8GTC2qSo45UNofjPN/7T5gIabP+Jb9tBwJdIb4b8iWHXfVTd
 bKiDe9ERP4u+oVJMaTyoxqsWdRgEjs5ulqDyE2RaipQkHqycb3Ga6KRxD58aD6JLa2/C
 DIEAhbE3S/oujb1fuHI8rFW5JHU9qM/rRcNGyGuAOa1qDpUEz9qBTvJSPo+lJKbpQC2N
 uVk4JP6QEy0P0ooVbOZR1xsU704F+t6NxoiX8FkW/N6yKw0i/G0ulzGikCAWYtnXVIwG
 RWUw==
X-Gm-Message-State: AFq9FYLWDyBcPjJP8YZ6hiHOR8vnwsVfpivAdKHbPeb+tXKtX/gDXV8w
 3Pq0QpvAJtgdY5Vf9mzivaC4nR2XmzXSdOcPiK17Ujl3awbn3HH/yYlM
X-Gm-Gg: AYBFou1N8xFm7HSuJdcSthlXbDwerthiyI9mJssVln2UotMc/EuooHF3MQXbNwfkuRw
 oKs7iaj0SpRktFqOD1g+ln85SMjvPURaiqxTR1ZKSqawdaQ3FFw4sLdWvpWq+xxkGlnXaxwNjJM
 fpit1hfn03K4H3ku36HDWr7TA+x2TIASzFk1uRr7YPZciRie6E+QstWSkiGch0nQLmOHMppyAic
 feB6eonuKG9Afwd4fOoP2rnRQ43gMCFxpmSppk/WkanaKj8CvQ3xvdckwyQ+Avviay4ZSzXbG/c
 +rXsgEtfdGNDiuXtAQNLRS3p/on5oqW+phsZkBm8TxBxtLi59PAAeMR2WXvAbzmK5EIe/pxxV1j
 MmH0RhucoE/sz//Bfji7SdZfQUtSPpiQpAKrRpIaciyu77VfHeBJ7pY0l0z1bNZVulv2zB5Gjhx
 /qIgijvi8zC6o8eaBSUZZpebHoMK+brrT4rTsdWAkZ8UA3xyfXwlAYSRL/OoZPUHNUADNHNnSIW
 ibP5Y00TG+zO6OlTMcADpc=
X-Received: by 2002:a17:90a:dfc5:b0:3a1:8b70:d46b with SMTP id
 98e67ed59e1d1-3a6ce80d87amr1128530a91.42.1790912191716; 
 Thu, 01 Oct 2026 20:36:31 -0700 (PDT)
Received: from [10.27.250.254] ([58.194.169.253])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm2083232a91.17.2026.10.01.20.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:36:31 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH 0/3] net: add SpacemiT K1 EMAC support
Date: Fri, 02 Oct 2026 11:35:24 +0800
Message-Id: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMz3SQT3WxD3dTcxGTdtETTNKMkQxOzNGMLJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAHHKoPtuAAAA
X-Change-ID: 20260926-b4-k1-emac-fa5f2b146f38
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790912185; l=1449;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=Wzqmy4wmCkgp9qRO++Ho6VOhRy5Wob7fn8x1a9U13n4=;
 b=6eq3D/wiwElwcrFO9feMattKvnt0GDc2p2iUVvs8uxAmSjuUk6Tkv6zv8ldNkGcV6KmWUpA+7
 7hXsDPCe4ZdAKl678elkLISFQpZpNLvHfXhMxe1dgNT1uEn6wnZBq63
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

This series adds support for the Ethernet MACs integrated in
the SpacemiT K1 SoC, which includes adding a k1_emac driver with
MDIO and PHYLIB support for RGMII and RMII operation, enabling it
in the k1 defconfig, and adding MAINTAINERS coverage on new directory.

The k1_emac driver in series draws upon Vivian Wang's work [1]. To make it
simple and working, driver which using small ring-buffers operates primarily
on polling and only implements basic functions.

Tested on both Banana Pi F3 Ethernet ports with RTL8211F PHYs
at 1000 Mbps full duplex, and tested command: dhcp, ping, tftp, etc.

[1]: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Zixian Zeng (3):
      net: k1: add Ethernet MAC driver
      configs: k1: enable Ethernet support
      MAINTAINERS: spacemit: add K1 Ethernet driver

 board/spacemit/k1/MAINTAINERS  |   1 +
 configs/spacemit_k1_defconfig  |   6 +
 drivers/net/Kconfig            |   1 +
 drivers/net/Makefile           |   1 +
 drivers/net/spacemit/Kconfig   |  15 +
 drivers/net/spacemit/Makefile  |   3 +
 drivers/net/spacemit/k1_emac.c | 952 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 979 insertions(+)
---
base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
change-id: 20260926-b4-k1-emac-fa5f2b146f38

Best regards,
--  
Zixian Zeng <sycamoremoon376@gmail.com>

