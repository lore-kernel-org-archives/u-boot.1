Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD0CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 13:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2323F60709;
	Wed,  7 Oct 2026 13:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YUvYiDqUBMk; Wed,  7 Oct 2026 13:16:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9206D606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379014;
	b=QX5u9BJdR07Q0S6W5r49TaQCZAvXoSOazGYR4VLJCDk0K+mHYPiktgBiQ08zj1y/q7yZ
	 3mE4Aw3/9FqnBS1MHdaCjDio16EyXoIkHOQ+2TkCA+hJyk9ZlgFUquxiVKWtcLLZpkREq
	 /a+5PlCXwmItFcbqdsiftlgRO+fMhlaZDTiNXaacWnWkvTwvjX4lvj7+Br+j5WGjtaLph
	 caNEHHBQ2kUsKPLh31HlwksEQHAh8L7i+IQDwsjOIGRCmxv60eSC4Ly1w77NtMo3eUef7
	 lav9ECkwF8re//3p0TPwHqW8BqgrNcueqCj7y4lwT9P0ThXJsyro0CPDnRPB8nSuiMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XqC9MQ+WTVrladLWsZHaSzCZnlqM+q1l232AAZCM/IQ=;
	b=LKW6jhQLxx6olzHvhakX9lUf9Y4Pdzuvat8jDCk6Ygz89CwhbKMQ97KxlTvz6kQiSg74
	 3t/wpabHIG4N/Od2Ljsjwx6yogNykQ/Iizi68Mn/OVDqPqqJKEqCeScRlDPI+bA/T6g2K
	 QnutFbjg1MDGA5o4bfsB++Efy1dYMtL+0b2upV9QMz6Dwcpl0wfdJ4JvkGPhArWf9P+Bx
	 UKg/3FylcrZI1OohcSJhCjk7Dj5UaUJQDPHmpGY3QsJjHOsjewrYl/6MDxTk5IFVg/yCs
	 +1p0Xg+j1TLwSuUZZM8MxjXvH4pGh+YSK+TIqXhIKd4rBcnXoX681ws2BJ40uIpg5uQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791379014;
	bh=XqC9MQ+WTVrladLWsZHaSzCZnlqM+q1l232AAZCM/IQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XAEW4DPy3REayeJHtHDhIIZeh+FLoN/LSnQk9Pfm4LPxW50qb+3AUwq1VHGztcIZa
	 H3WsV82/117kaKZ/qj4V7p7HrydToNMAl8Xq7Eq+9AyW/7Ps58Sk9t8bBt22B1Xb3z
	 1azOFzM7YE1chvtew6ek3pVPh2lmDB/gtsWR9U47RfKtGDLUtjeuJe8pDR04RJC+Cu
	 OFuCqvaEBXbeuDVieuD/oFIUGfv+Wst2egwqpLfVrDCcPkhIZRwZuCY5tqzm5+0Oz5
	 GKIkYT8kDkdUrxejH82k/qI88Rgtgu0zjtYAgFIOjWXQA6iDn/Zqtf7JtXM5keSlNm
	 gGPi4cUv2nYrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9206D606B0;
	Wed,  7 Oct 2026 13:16:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B0E5317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C3D1405B6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4M_UsEaWvK1 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 04:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 37EC3405AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791347008;
 b=RaBG3mNPOMXUdqd1HualgO31cT+OZuc3TExRP9UNwqJMR+VE7hJbizzJ90PJKshlbFoA
 4XGqnSW3tJ1T8u5MdsOfgdrpQ4QCmYlM87QAm7PrgG/+NJ5D43j15aNry9iR4fc8xALJI
 zQl74fYoSKUe3nknx6as1UrP67tnXQIsLe07vPmzdvnTCCyVY7b9mdyv1irRdn912TC64
 Hu8KHddHtLV/4auYGnAxEsWjxUtNY8teFfJZH5WgboPZJsB+VAPawhlFzAh4p9EyDftZs
 38ZGZo2AdX3+RjaR8q+wqJjyGj6zNwnOOlU41Sba/wki3RIfJM4hdSpwZIhX4BT7QCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791347008;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=XqC9MQ+WTVrladLWsZHaSzCZnlqM+q1l232AAZCM/IQ=;
 b=U12nGMxYxFjJe6aWzcmUcCDdziEsYpeE3HfC9zUurIxxJquVYGY3z0xI+77lopyFvso6
 WLkK5AX+1WAUA4BUitGxhr1tRtfR5a/z/3S7t3F7JSP/Gsja1Oq+MG4Cc9V381igtIOFQ
 vsn5wiuygjhBgWrGLt9U5zjmQKgr38KHihUFgeM4634jQvG+0zBQor2bOgARKAijsd2Ty
 jk7VhT3+SkKXZyGGjLmNJ7UsNKXob2HGv45m9hSWVejhuiza/+Ml5JaMcMNtXY5F45R8m
 r8DZVl22uKALB2kmkUKFa3Lph2NztzZ7YqlTZMJ2XZW8DYIYSX+Nd8oznfT7Vy/onWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Ox6ElGI+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Ox6ElGI+
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37EC3405AB
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791346972; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JFzyBzWMOv+m/zoObuOKxGdjS19DMv/zjVaQvoU/v64N0ktDiKIme23JqO2zkiGEvyvWL6cqjCzCbEq10fSK5bZNaG4FbiuPJ+2+VYT4bdojiF227g6tgxOHeggZjcOtZjnVH5aDcddadOvxnzCtyeezwcRIxkcl3TuKnxMLD7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791346972;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XqC9MQ+WTVrladLWsZHaSzCZnlqM+q1l232AAZCM/IQ=; 
 b=aUNBdEaCqZdWjx8pvsE6Ulw85nYQbHiXitB7hHFhfMS1JtMxzyxbPUQrFatcoPBAnmSbpmTe3ZIFTooEFI/RXWp5Lb6Sj8pqBGZVwN646Ivodhlg0PpYivwckVO31a+hUdNY7Pnh+HxuNL4J8vhg6VAFI22ppI1TmEdazov3hN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791346972; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=XqC9MQ+WTVrladLWsZHaSzCZnlqM+q1l232AAZCM/IQ=;
 b=Ox6ElGI+kqyQWidtGACoNrXp5e8d89Pw8mtuX6O0EBK3syNvBYE5KCzOFqX5Fsuo
 hmzjM2lQrqytJeP757KcktTXDryKHJMIP1bHUrtJXY+i4wnqyMZwIuhACqbaFSDU0gH
 5ctdNrEFZttXbO48H27UJBIFbt6WtI9Va2leryH4=
Received: by smtp.zohomail.com with SMTPS id 1791346972169269.1752787813291;
 Tue, 6 Oct 2026 21:22:52 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH v3 0/3] rtc: cv1800b: Use the RTC node for time and system
 reset
Date: Wed, 07 Oct 2026 11:33:04 +0800
Message-Id: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QQW7DIBAF0KtYrDsVMDYGq6p6j6oLjCcNbRyng
 FHSKHcvdrJoqyy/NLz5zJlFCp4i66ozC5R99NO+BHyomNva/TuBH0pmkkvFjTTgstDHI4TkIJ5
 ioEgJei0UKeQKa83Ky0OgjT+u6uvbNce5/yCXFuo2EehrLuvSdYz1NhK4aRx96irLFWlje96Qt
 bLXWNdDIwUKg8YgohtaxS01CzVSjHbt2VVPt5otjH73mWGYJ5gPMQWyIwwpQm6AQ7tRtdFIjSH
 x8j1tp9H63WPZ/cyWtlsf0xRO60myWMstrOAc7/4+i2I6rrElqaiX5o+5kln+ZtR9RhZGtbqVW
 mvUNf1jLpfLD2dE6wCuAQAA
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
Feedback-ID: zu0801122717c6d81e9f017ae12c2e5f8b0000ab5684c56d85d5ffd5609c00bd4f03875f79b27ca8b78507b5:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 07 Oct 2026 12:54:57 +0000
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

The CV1800B RTC subsystem contains a seconds counter and system reset
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
Changes in v3:
- Rename the RTC driver file to cv1800b.c to match the RTC directory
  convention.
- Align the CV1800B sysreset register and request-bit definitions.
- Use uppercase hexadecimal digits in the sysreset driver.
- Link to v2: https://patch.msgid.link/20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com

Changes in v2:
- Use CV1800B consistently in the RTC driver filename and identifiers.
- Link to v1: https://patch.msgid.link/20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com

---
Zhuxu Ran (3):
      rtc: cv1800b: Add seconds counter support
      riscv: sophgo: Enable RTC-backed system reset
      sysreset: cv1800b: Use the RTC device node for register access

 board/sophgo/milkv_duo/board.c         |   5 --
 configs/milkv_duo_256m_defconfig       |   2 +
 configs/milkv_duo_defconfig            |   2 +
 configs/sipeed_licheerv_nano_defconfig |   2 +
 drivers/rtc/Kconfig                    |   9 +++
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/cv1800b.c                  | 123 +++++++++++++++++++++++++++++++++
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

