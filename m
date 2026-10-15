Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E004CC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F4D8121A;
	Thu, 15 Oct 2026 14:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAGkijvNHz1u; Thu, 15 Oct 2026 14:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17399811D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074161;
	b=TedpLABcin+HlqItcC/qUcYGuUTLpOlQ3qgjjzqjUbNzacVGM5Olu9vn52g6hsDCCrOR
	 uOZHXVzwJo9FZKC5/eXdcMsggGGHWgTyHyY51VrR0Izx7kES94dlM+MJilv/g4IAa9Ye3
	 KNj7umenvk02wJ3gN+Sn56pD/WHptuXZSSWHxeHbO27+yFvV05W3SOiZ7V3EyjJscAW5a
	 5y0ZYh2jBCK+CcdsozZ+fMFhqwtdGNv8asGYsnRRKP76lcwVYp65NlbO5a07XF/ovuUir
	 ETiwtdThEjcDibJrysup3AKLwMBzphMCRGhQcBmcwymlgevJpG4/SGX9s3NVpSlu6WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9JaDwCDXC+SWcV3cXctowXIADSkIL/38Nz7IUa6yplA=;
	b=JF7Idy+aOgIuYQ19M3xynK02cVR+Im1HUP4QA/evuxTFtjAiv5a7H5LqUyUx9CQobQNz
	 vY+M5X1EkhOtWZPS9Wo5kjQCWbm1JLdUiiMjtkh/Uc1M6d44Tc1ZjF3E4cQMl5v1Ax/zw
	 x9yLwSVlW5DJeInFF/SR0cearlr4nPRT5AhPlPknLnOQcLqZh3w+lOdevaBxCOXM0+AZP
	 e2HLiRB546c9Nd01EQWlGP3V4FJzPYq665SKNlC5lxb97837Zf1hsqI/SC6FRDC5BKdP/
	 2JPgZZ9C8HdFmZS4UHufzfKp25mDSutL0vz7SdI5SQOzzBmp39+LwR8X/F4Ldo+jX6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074161;
	bh=9JaDwCDXC+SWcV3cXctowXIADSkIL/38Nz7IUa6yplA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lgIoJ/T3NFyBTeBUFuNo7ergtr9DVn0k3pxYiHrt5j6sTUSInaVwlId1SxqegV5R4
	 EVoaa550VcRM+1YqQv+/qRizZdz4SACo9hEU1BfpHCWo+2Jc/8mKVF5eWpanNj4/xm
	 2sNlaF+2qTL+upg9YIH5bFEkvGGQ7a747A4EMgIeUMKX2oIXjPPQskZhSbEva+iGyI
	 zlE8WTeHQPFuYFntRrWz02U/8H0YIGJ1mO+OCiALqUMIhQmARhc+Y4RZAefohPdTPq
	 XKgP3o8cFDJ/jM1/flUGNgZ5mPN9y/IQVaowrOLWH8RxRxsL4Nm2rhhknMiUkC5OJN
	 WAYvt/bNVoK+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17399811D0;
	Thu, 15 Oct 2026 14:22:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CADF105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E987408AF
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGPui91OxXFh for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:22:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A9634089D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074155;
 b=pjrQwAlJfndB00ct6PmRuIH4LeO+ysBNzRqeShqa/NoZHWSnjXVgWTY93hWThf60qXf0
 fuV6c4GA73FiwRTLp5qV+DBIu2wbKxrB3rurk09ctt7Rg58eP4sHrogOvv74leGE6cbVK
 sQMz2CdnLDGmISx0Qpvr3z1+DfGQV0cArS81gYWfLGA474JO55VX8ZjpPd1oL5sgkkdku
 k4Ii1qBh1PBAQb4EUWyYu9naG7zyfMfewnhelaijxQYIY6oWc5uKMs9v8Iq8wLiwP7Nga
 gHA9wbkJt6YOy33lHezBFZbec1KKmGjY1omyJtmfo6pNwdo4P8ZUDdpdGT8BBqZ95CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074155;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=9JaDwCDXC+SWcV3cXctowXIADSkIL/38Nz7IUa6yplA=;
 b=MqPDgYwmEFZUUNfZB675CibXtv6cxH4wosy0/lhlQl6/btzEXB20hELlOKNWwu5UYn8D
 RFrl1RJARd4o9j5LywnrQfnFotZuqXLV0iN682cdsnjP/ML0w1IDWFLlN609HL6whBWyh
 ethheWCsA5PT9JhJS509Zo5ZDpAI4MwCM5mkHfj73/g32RBzv6G0BqR71aF1YLv02REok
 gf/rZjjNVpoAp8GPKNpZnFR7KuHW7vKtB0pCzQZ8ekVkHoHbRoedR3Y4PpQ/aDP/Gtecs
 Cpqjb3WvGftujdXJ+n77QlGSNU1sf5faPgEZGY44y70zmO0fCPmjdI277EWtP7LrOJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=DvTfn0P1; 
 arc=none smtp.remote-ip=185.136.64.225
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-294854-20261015142229826799e6d6000207e3-dfu7h3@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=DvTfn0P1
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A9634089D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:32 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20261015142229826799e6d6000207e3
 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 16:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9JaDwCDXC+SWcV3cXctowXIADSkIL/38Nz7IUa6yplA=;
 b=DvTfn0P1E6LkdAKGlD4tA/6teCRTTaz5ZCvNH0KuQ0x52ED8+AMY0AZSp7OfPopNdK8Xwl
 NNe8nntGVwjM97IwuZQIXopbeYdxL+3URiB5YZb9xj/22f4P6oXUIaS7WR9EV1+h4AWeRMzn
 5DzhcDqSrU/dG+VTkjiMWOhHW0xK+dBqI4Hpc3hg/dv3RxHt+j3g9FYHRGbvdMNddELYoT2a
 ZwLEWLMWxvD8RtyfqszdQX8y4mN6+aILdsly9+c2otwA9SaO4vttQSKZWCLL4yl8R9Vza4cP
 CeNQEEbEQY/EkkKzYuHZf5voSkpfjYHOgi+sMkkzVNA3JPzAPQEgpNEQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 0/3] Watchdog support for qemu arm and riscv
Date: Thu, 15 Oct 2026 16:22:18 +0200
Message-ID: <cover.1792074141.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

On non-x86, QEMU only offers a watchdog via the PCI-attached Intel 6300
ESB. Add a driver for it and make sure it is probed during board init.

Background for adding this feature is testing complex system
integrations that include watchdog-monitored OTA OS updates, e.g. [1].

Changes in v3:
 - reload after timer preload setting
 - initialize max_timeout_ms
 - null-check register base
 - code de-duplication *** BLURB HERE *** style fixes
 - prevent reprobing of already activated devices

Changes in v2:
 - fix a compilation issue of the driver on riscv
 - add late probing to qemu

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core

Jan Kiszka (3):
  watchdog: Add support for i6300esb
  watchdog: add support to call initr_watchdog multiple times
  board: qemu: arm/riscv: Probe watchdogs late

 board/emulation/qemu-arm/qemu-arm.c     |   5 +
 board/emulation/qemu-riscv/qemu-riscv.c |   5 +
 drivers/watchdog/Kconfig                |   9 ++
 drivers/watchdog/Makefile               |   1 +
 drivers/watchdog/i6300esb-wdt.c         | 152 ++++++++++++++++++++++++
 drivers/watchdog/wdt-uclass.c           |   7 ++
 6 files changed, 179 insertions(+)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c

-- 
2.47.3

