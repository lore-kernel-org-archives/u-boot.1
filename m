Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4851CA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88FF541390;
	Sat,  3 Oct 2026 12:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Akrp1cnTkV4; Sat,  3 Oct 2026 12:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A33A74123E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031687;
	b=XZA+9y/ZqNtY7/i2vWCPHE3oP8xRJ9dJgOWS8NybPC+QDr6tQmbRGQ08AASdkJR6a3h4
	 D9Yxh01qnJOT1SCSWnbc2vVYwbKjF2CJajtL1p7AVWQxou0SHgZe5o3n1v9YzJ6SI/I8d
	 scWhN8HScoSUQAItYoSxtv16v+tRtWMaGgkpbkTMv+lCQ6c19jsafv6HLN+Ff/3KqHExQ
	 UD9nBs2wVn23SPBwxdmtq/FvAsfeicvaOSsEtamSNIzHmzKiB0vJQ2Vwfs/S66uQ9d19o
	 8Xo1/Z1s4DU8ilHNcz0guGV2sWX9/UdX6UWRJPfBr1fDM3fsf3TPqThu9N4GQudJwOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lqMJr3mjwDMpybG5juE/xBOLrVPgnk2dD9vW7PWg00E=;
	b=VDr/L3XJjY2DJqa14VPGMd8sM9XtonEZHOjiENlWZ/oPlKSzYLUH3uOqhcOtPjtYzbSi
	 l3HvFetu7fUT9iPpqWblWkzU8JUgIEMGf29+tws72II6phy0fgdghMqq5N2ZcAv+kUzff
	 FMnlWXftP74t9D+8/Z/qO8oY2sentptOaWnU8BxWUy2aDCgjJvFWdZ/QMTIv6NQfc7QRb
	 jH1jjQbIrNt20kk+uNrXIb5/v+gMoava9961ZOylDOfLO5eKmIKWCczZI1ivV2XZcHPgs
	 zb+VVpysJxXLgAZ9bBGqo2yDRdOZymUaAkWB+ZYajtuir++Togu99qD2D0KQOG59Dzw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=QQr2wL22;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031687;
	bh=lqMJr3mjwDMpybG5juE/xBOLrVPgnk2dD9vW7PWg00E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ljcdzQAxJ+pPYqHyfmP9HmGjVuFEHfCP/MadXVEqAric+Jb6S024m/d2A2OZcr4MH
	 dKxfazEM1NaGUzgfM/fTmE0q7zqHzU3YmZeRQ0cGERVfW1hE8dxLfEMEGF77G7rhow
	 HY2WyGTw1OWobwNjSirSRVG6kEYN045gyHAAL1jWBX2vQVo0OHM9ayslt6XbjdInBm
	 K+i7Cn+UM7Py0hJx0hnTeW3zuCrZf36TyGR78qhqpvsg2bIEc/UAEu1fldB5Qmy61t
	 zzJGwwYDyCLYoaCZ9nN8VKRwWEx9nXeZD9G1bjno7SegZPUIp3FXwZ+hpxtqEcp/6R
	 O4bgybfOzUEOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A33A74123E;
	Sat,  3 Oct 2026 12:48:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE2112E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C457440E4B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfW3P5Fp6hcC for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B03640E49
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791028676;
 b=lQyk/9poecGi3FkZyPlM8ppwMUPtbgpn+FWcQhcBSxDGdhORPajdbCQFC+FzVxUbMSG6
 y3Oax+6FpM4blixSITOWfZFjgg50hh1rIXjA1Ju1hW38WKMXMvuh+bjxSj5fueDBObwwU
 7knMgBDj6Y6yn1A6htgYtMiHl7urnKxsbNnVvCu9oQhL4DVUuqXSErNcyiB8v9a4/PJ9a
 pHxY9m7eH8vcNFOssumqPzcr9QRtvgdfjjBeJzvGboQHAC93m1DCNHDKPgV+TYT5ydEhw
 0wgflQvVntZ+iKUOshVsk/u1iS7WPvSTy7X5SoA7snYnKGHPsvuQaG/hpJFoR9rf2ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791028676;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=lqMJr3mjwDMpybG5juE/xBOLrVPgnk2dD9vW7PWg00E=;
 b=lg8EgQRAYQteR4D3pZ5G/H7zb5DTqAVqAXZhd+jBWzK1CefIRjWmRK+U7uajq79kM8x2
 V8/jR4IQWHII9sI6S46MhvQdIWtcUTHDfC8atI4Urk9ZChJAXhsJKYIUkHK5PZqu/KMB8
 QAxFlbkU3g7NLnU0PFEwEBo7mhQu8rvOzQrFS5B96KLT2bDyX1CHcWUcyWr0Avwx76ayg
 k2IyggqMXOlxWC6bi4jJroyUFVJXEwP7pB3H37R2YCKY/xuIBEut+VCi2YaPdMtaQNfmn
 xsGGKN6eVLfczFPX0RrF86y9grPk0dA+GqgHGjJld6v7hoECdt9batosuQAPj/8Ijwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=QQr2wL22; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=QQr2wL22
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B03640E49
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791028640; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g93jyHRY38yW0LKW4MMbeR+M0KVjfCnEpfK47LdejqOMk/BSv4EZYTvwXnEbKl/EdGWLhxgC0J/Q0oLaIDWcKEyA0imVwsaQvFQ9q+8CwJrxlXt+kXJAKfbObTN9dikVoT8eioRSwKRhOS255146rrZJaNXJgaBs0mynwPL59JQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791028640;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lqMJr3mjwDMpybG5juE/xBOLrVPgnk2dD9vW7PWg00E=; 
 b=Q97jYMQeyWR8/YIA3plx4+20SUFKsjlb6xY6hP4GzzqACcNi0j9r2uBGgMLpnPyRx08yBrkBMloInE31wla0vA+74/sx75UsR/L/YEoh4wfXfOUH5tjVM/4qj/L6sTX93V+ebicFLpTTSod9aikmmM5xX3s8abI5oal6lu00lFo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791028640; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=lqMJr3mjwDMpybG5juE/xBOLrVPgnk2dD9vW7PWg00E=;
 b=QQr2wL22oc93qiNx2Ke3NM7xN9QU2/xclI1elAsGvp2OC0lYF2DVHL1z9hzfs+mJ
 GamFc0smHmpAqi6x1DSVdgO+l7mmQh2WbT5Rfb/hfR/S9qOQH94LsSU3+0C73/u27PT
 VEB661OqVtOZJMcnQwxsnn7V3Sop1x1UoDsf5wyQ=
Received: by smtp.zohomail.com with SMTPS id 1791028639572122.82354148984132; 
 Sat, 3 Oct 2026 04:57:19 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH 0/3] rtc: cv1800: Use the RTC node for time and system
 reset
Date: Sat, 03 Oct 2026 19:55:05 +0800
Message-Id: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2O227DIBBEf8XiuVuBMRisqsp/VHnAsGloQpyw2
 HIb5d9LLo9HmjkzV0aYIxIbmivLuESK06mCeGuY37vTN0IMlVnLW81ta8Evwqwr5OKBfikjYYH
 RCI1aci07w2rznHEX14f1a/tkmscf9OWueiUyXuY6V54xNjpC8FNKsQyN4xqNdSNX6Fw7Gtl1Q
 bVCCiutlVL60GvuUN1VCYnc4+fQfLxu9pDi8bBAmCeYz1QyugShECwKOPQ73VkjUVkUm79pPyU
 Xj+91+5Ntb7d/zunSAhMBAAA=
X-Change-ID: 20260929-cv18xx-rtc-sysreset-b816e6306348
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227a9296a75a5978acb3d318a55000028788b3b82d2f1ccc9078e62d04d157b649adf77ea94c174ad:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

The CV1800 RTC subsystem contains a seconds counter and system reset
controls in a shared register range. U-Boot currently binds the system
reset driver from Milk-V Duo board code and accesses fixed MMIO addresses.
The upstream devicetrees describe this subsystem with an RTC node, but
U-Boot has no driver matching that node.

Add an RTC driver for the seconds counter, bind the existing system reset
driver as its child, and obtain the reset register range from the shared
devicetree node. Keep the existing reset requests unchanged, including
the warm-reset sequence currently used for SYSRESET_COLD.

This series depends on the CV18xx upstream-devicetree conversion sent
as v5.

Tested on Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Zhuxu Ran (3):
      rtc: cv1800: Add seconds counter support
      riscv: sophgo: Enable RTC-backed system reset
      sysreset: cv1800b: Use the RTC device node for register access

 board/sophgo/milkv_duo/board.c         |   5 --
 configs/milkv_duo_256m_defconfig       |   2 +
 configs/milkv_duo_defconfig            |   2 +
 configs/sipeed_licheerv_nano_defconfig |   2 +
 drivers/rtc/Kconfig                    |   9 +++
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/rtc-cv1800.c               | 123 +++++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig               |   6 +-
 drivers/sysreset/sysreset_cv1800b.c    |  90 +++++++++++++++---------
 9 files changed, 199 insertions(+), 41 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260929-cv18xx-rtc-sysreset-b816e6306348
prerequisite-message-id: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>

