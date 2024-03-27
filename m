Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE7CD1283
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6672C8806C;
	Wed, 27 Mar 2024 12:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bDUetcd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0F087F36; Wed, 27 Mar 2024 09:10:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DB08332E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527048;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=CQPLARJcPpXkCKw04N6ccl5miVBwWfd9BBiotUm6VyM=;
 b=bDUetcd5T1pB2422AuhlWL7XMU+OuKTnIIOZ3pVyZ/cPAf48M79KBwPW5S3BqM1pdlZl++
 7/mo15L8/mmBUxkAuAQ5odLvUvo6wZ0vHh8j5aCSiRdrAkP+JjQy+JVxI4wu1AOpVvsSVh
 /KBgOux4rCtYpwEgo/akH/Y7lB//G6Y=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-_xSm99AXNg-GPlcug0t60w-1; Wed, 27 Mar 2024 04:10:47 -0400
X-MC-Unique: _xSm99AXNg-GPlcug0t60w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c65e666609so5339475a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527046; x=1712131846;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQPLARJcPpXkCKw04N6ccl5miVBwWfd9BBiotUm6VyM=;
 b=Z3jGu9XXeuZPcl64R04MmBjF/oDQITaB9tShB6o8l678C/WRM93n9b/RlEURSfLkDW
 59zek3/+Z2EpceaWALuoowiOYo+gihupiN+XB/CHvZKDfFwNuI2DltJgg1fQbyvVRp0l
 A5yuXIz4kgnlWN+uldoFhExwWsZfMGqiBS5cgeArHL8TsUmUQAXnWp4f2DqwwhTGGExf
 LHIWjrxyvmdTP3DVMwY2+3M8+49JW9rXAA0KWIx0Zg2Hu92/NHtf7G3iloNSiDKBXODi
 O1x02bLQo0hYjs0HZa2rOfoSnFELlrdD4ZwVxIY6xP1GgRDfJXb81ca7UapbQvr48obS
 gurg==
X-Gm-Message-State: AOJu0YxzQhmt/C2nLB8Vbvs0XrIzRSGQPgvUUDg+cNJ+30JvZb0lSU/q
 l0RiBf1SD5AzPQQp/7EhmyudpgyQ890Jb+IFx9zh8IAuDJ9BbItfynr22KUI9D43P+zFLRSNECS
 ELhOe40ClpQECXyz/jid2SHCSGP1atQSawGbtVBwfQOTdtgVyH11SxKmJVRJbpXZYoxh9PCxfaO
 ExYo6KRDYVAgXLWeFJlf4stD9ODIjEp9Fxprs=
X-Received: by 2002:a17:903:1247:b0:1e0:c37d:cfcb with SMTP id
 u7-20020a170903124700b001e0c37dcfcbmr3985889plh.49.1711527046163; 
 Wed, 27 Mar 2024 01:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiZrAnavRilPkv9fCFyLHjXUweg0/HPxfXuGOf0bOWunIgaKdMthvJ0DSMo/9xYqgblXKMeg==
X-Received: by 2002:a17:903:1247:b0:1e0:c37d:cfcb with SMTP id
 u7-20020a170903124700b001e0c37dcfcbmr3985845plh.49.1711527045752; 
 Wed, 27 Mar 2024 01:10:45 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:10:45 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 0/6] riscv: adds T-Head C9xx basic and GMAC support.
Date: Wed, 27 Mar 2024 16:07:21 +0800
Message-ID: <20240327080817.44501-1-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

This patchset adds T-Head C9xx basic support in arch/riscv/,
updates TH1520 Soc/Lichee Pi4A dts files for GMAC support.
Also enable designware ethernet & realtek phy in default configs,
and some boot env option for booting linux from Ethernet. 

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>

Wei Fu (6):
  cpu: add t-head's c9xx
  riscv/dts: add gmac node for th1520.
  riscv/dts: add gmac node for lichee-pi-4a
  net/designware: add compatible for "snps,dwmac"
  config/th1520_lpi4a_defconfig:enable designware ethernet & realtek phy
  config/th1520_lpi4a.h: add more env option for booting linux

 arch/riscv/Kconfig                     |  1 +
 arch/riscv/cpu/c9xx/Kconfig            | 12 ++++++
 arch/riscv/cpu/c9xx/Makefile           |  5 +++
 arch/riscv/cpu/c9xx/cpu.c              | 51 ++++++++++++++++++++++++++
 arch/riscv/cpu/c9xx/dram.c             | 36 ++++++++++++++++++
 arch/riscv/dts/th1520-lichee-pi-4a.dts |  5 +++
 arch/riscv/dts/th1520.dtsi             | 33 +++++++++++++++++
 arch/riscv/include/asm/csr.h           |  2 +
 board/thead/th1520_lpi4a/Kconfig       |  3 +-
 configs/th1520_lpi4a_defconfig         |  8 +++-
 drivers/net/designware.c               |  1 +
 include/configs/th1520_lpi4a.h         | 12 ++++++
 12 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/cpu/c9xx/Kconfig
 create mode 100644 arch/riscv/cpu/c9xx/Makefile
 create mode 100644 arch/riscv/cpu/c9xx/cpu.c
 create mode 100644 arch/riscv/cpu/c9xx/dram.c

-- 
2.44.0

