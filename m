Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F433CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 307E8607AE;
	Tue,  6 Oct 2026 16:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxfIZ4HMz_Yb; Tue,  6 Oct 2026 16:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D036607C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302571;
	b=ne8+9o0oCL3DnEZxK8D1FqD7YW96ziKJ4CW03TPcnf2fqB+OJlOoJhGjdgXk3I+s5wmm
	 0ul81B+pEinsrAdUr5NiD+GzzVWkyza3vJtWZEqJaLdmAvfCYV1za35xEm2je/lrSDPBb
	 9stctNlDeT/ehitsbivi95zJctaFVletZkmesZDlXRKVoov1wXrdQVnQ2PVRh9BamaFuJ
	 AwtC+feQf44Rjp0SP9jeO9z8e7oNJH2RJEdqImZPTFjHDsjbopDvYtSGmgZeTLDRw4Qox
	 cTdaXeKSm5rhjum8UQqc/cXVpHAkt5k0nNLg0XjTIP0HA6/YYoPYS5m2DKRb+Z24zLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/xfjJnsDS1VP3rOXwbDZhy/tSEOX8daUF6G1vhGlaAI=;
	b=ZJ3ubLjId3QBdWVpdv50RM75GbPYHSq9GInqWKqFRoYTUDUUGA6vSa5/0YHe91HuePHY
	 fxnaI9irkMYyO+OJUFEMIg4LrFgdfadwHdq/eAk8RRzNpUO/W5xnUxDHPCF7e9gjdyAZe
	 rhbXrzfdF/9tTyfOWKyRL4IljjaafFLieqLw3KMUH8kPJnz4eUthLnlj2bAN6AROJF5Og
	 i9VS94NegHNY7lgXfw5IJg75XFUcCtULVh++MGTsXl3oFGUBVspJyFU1y0thi8rxuLXOh
	 dLHjIxloN2s0/FeH6pG5m4faSbXkoT4dicAiCw8zU6GN/yDHPiV6NfV1ih7pgXJScyQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302571;
	bh=/xfjJnsDS1VP3rOXwbDZhy/tSEOX8daUF6G1vhGlaAI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lfZmPwjZ4bpnUVFRFwhAQzWcRS5rEdcE8B3WcKQqG1yHgXPYgs4EeyVCJ44IhIqHJ
	 Mf5s0tBKWUjVk9cjHviXYdjiFR14G6hawbHJdyg2zZ+esG4t3PLOUDkdIL6ARi8g31
	 D4gfJNzrq4+VywRVOi/PIox9HYa4ppIZ+asJiwth3vjKd9ZBlhjuTwSJtmUhIbNSls
	 dzFxIQjVmXAp5lafEQHjyBwL3h8PCywOsGPL4Q0WD+lL5LyjovZpLk2uVrJNUxuF9/
	 BvwBtz3yYkTFUx/N9ck3RHFdpe97nY4t8HC4V0+3ZspB1RplytBI0MqLq2QwV6pTyg
	 fH7tSp5vhoA7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D036607C0;
	Tue,  6 Oct 2026 16:02:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1714332F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07CA840296
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kzd1_qR1jGwr for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 31F6F40274
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791301722;
 b=aLwe+YJAnAJX/8rxFJ4/Ldi6jC8lhSq+yKPC2PcJTxSEH36qX4RRZ7tWcVRf0NPAG8sN
 /s1GWkvZtsmQzMQaAjG7v6vL0Cl96W9P8yffnCYZgzZqTPYAhN7jkBYiZb1teLZnzvG90
 KMzIbpnfmXmtVSZR/xvUGYQtqnVeCW4D59aobZOBENr/cRAVqzSgQVETxyAfm8G2IviUS
 hSTaRUrbovPcx7Gy6lBpQh4O4i1J45Udmi1+hay53dPnnB7RXiYzxyWDapF76xB/EOjOz
 G4gvUPLdYN1eK4j8jlUkAbI2fDbNMB91rZbHxS9p4SeFejF9wsT4cKDs6tnDxuwpbkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301722;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=/xfjJnsDS1VP3rOXwbDZhy/tSEOX8daUF6G1vhGlaAI=;
 b=Sw3fG9QbZP4++b4xIWevJE34I6H21QWTQrA7kO11B9lTcd61Q69LMxa462+EbCSzbW1g
 geJjYQIwHE5F6/M2DFtchrj5RTz1zgBCyIKjkvvqiLnRPzlaCRr12ohJkZ0sNJ+hdERhg
 rNA4Sx6b5uyef54oxgwafXgHkXWhGzW1ceY52KSZA9QJ8fpPi/vJqGc1/1T4Z1SqR8CNW
 ljIJWS3XamIcS5XWgBau3AcTEx8KxypKKY3gKgGXLjT+LTH+Wg0oZzdlY/qyLEpZViuw7
 EdXB/tfEN+arjR4GbRlvmUrzZb4VZsjviXBktqS2rd4JEi7fvhR+gO/a9q8AzwcMdrQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RVGWgVyj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RVGWgVyj
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31F6F40274
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791301686; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T0TwP/exdA7KHnTFmmRHqzkenQd6uAjjM7tYAQomEKoo4RbYXfVYXQGcFZ3JtowgQyiEQb+bqv5HCWYoC9ydHzf03fn7BKriMbgMupOB2wf2vA2k3i4oNaE2w0Zi0TDgRGjMH0sbW/SFYlVM4xx0SMsTLdYEIqMKeNjpTx8PAC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791301686;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/xfjJnsDS1VP3rOXwbDZhy/tSEOX8daUF6G1vhGlaAI=; 
 b=cvq+gyegwz+n2huZExsZv8EYalA8iFYigWMSiAXfvWMtPkw+e+svjpPHqaq2/3zUi9x8cMeRPsdOAXWcUCmPYQPWoFm0IdUeZAu4Phseiu2H8YdfDBfvExzu510G777SeYtFrbAOfAraluCUY2ppPVgA32nn2xsY1FCsxg/O8kE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791301686; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=/xfjJnsDS1VP3rOXwbDZhy/tSEOX8daUF6G1vhGlaAI=;
 b=RVGWgVyjNbA3iDYKBuDyWbVjDUisKnMZbROrpvjBU5pQwWTQ1OGddJVw2mPgG5V9
 jxoh7IFhEJ/j3HJmI5smjIuc0BaW9jHgwRrPPaVEKqRfdVnCA673LN5WVCkfnlRPZ96
 3EjPLinrLt901+YKaURzLN5BuoGDKi9ETzI0bD1g=
Received: by smtp.zohomail.com with SMTPS id 1791301684591469.40741489090124; 
 Tue, 6 Oct 2026 08:48:04 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH v2 0/3] rtc: cv1800b: Use the RTC node for time and system
 reset
Date: Tue, 06 Oct 2026 23:45:05 +0800
Message-Id: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Qy26DMBBFfwV53an8AGOjqup/VFkYMyluQ0g9x
 iKN+PcCyaZSl1e6c+bM3BhhDEisKW4sYg4UxvMa5FPBfO/OHwihWzOTXGpupQWfhZlniMkDXSk
 iYYLWCI1aca1Kw9bJS8RjmHfq++GeaWo/0acN9WhE/J7WdeleY60jBD8OQ0hN4bhGY13LK3ROt
 kaVZVdJoYRV1iqlfFdr7rDaUAMSud2zKV4emjUM4fSVoZtGmC6UIroBukSQK+BQH3VpjcLKonj
 7GftxcOH0vO5+ZZttHyiN8bq/JItdbsMKztW/12exMj03qkapsZX2D5MdlmX5BWgnbrJnAQAA
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
Feedback-ID: zu080112279fdc9e8464df5a6088063ede0000dd06bd3badc87347d28c9aac3ce8d9f826327e1c735f166c17:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 06 Oct 2026 15:59:54 +0000
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
 drivers/rtc/rtc-cv1800b.c              | 123 +++++++++++++++++++++++++++++++++
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

