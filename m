Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA055C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 12:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38B181E14;
	Sat, 26 Apr 2025 14:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7bGPSnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691C7810EB; Sat, 26 Apr 2025 11:17:05 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B7A8056A
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 11:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af28bc68846so3196507a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745659021; x=1746263821; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jkPw+cP9CWLbxHgT6phA6r9jBa0IyPY1Rh59WH2M308=;
 b=W7bGPSnJv2PuAxiZ9N8HZe0cZxzFJ5lUAX0jpKGFwDLLEjM/5ITCJht3+imljReNxW
 jp95ND5Ba8cWOW59+XkSAn+ppkNFBz1YuWViiQivS9YNGGdpOpiweBstBp1f3p/agzpM
 LBZt9FfgPlbH9a8bJP/ut9Tri5O61uKbcz51Eq0K6dXYCzffffmNU6SNfiOr+Du/54B3
 YHNMLzHPUfPMiHlakH0m7IaLloTr1lA5eUgr4RCOd2s4im5EnZaOeMjAJkuIX+Cf1lbC
 SzPkaikNgCjx+RNCVdUpGYQcglttJTrhWiDnQf/14d9BKYQ1cnu8LGkVI7irBTqhenS7
 1MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745659021; x=1746263821;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jkPw+cP9CWLbxHgT6phA6r9jBa0IyPY1Rh59WH2M308=;
 b=GevikYiZHq06fMDW0LFZD2IZx/hlTbEgZS90ZT0sYK0igZVUg8pyzq+X5xSTUwlHxR
 OLzM5X7602N3/qBR0szGYkIgq3nQiFznwLokZe9JzY81lkhmCHaYHjp6qdihfC9mhY05
 ZaVx7AQk7sGapSVvzlX7w9SRf5VlBfTZJHeCilCL9dm3wbgLtxLpM7eHVc44yOkQzV0U
 zlfBt2FesZwyk7r3uOqCjRr/5O8UjIebILoXh0WtNJ11rRYu4s+UQc+yiGntm3kXwjxe
 oVWoPnmw4903bU6tp4qoXRydhnpvc04UNgoBXk8mKHZXxeIRkZg9hF382p7JO61qwDdo
 RtwQ==
X-Gm-Message-State: AOJu0Yzyee6r/Vt+LOnY/Ty3qaQOdyHkvLW+oU/g2xScKf9yedDFoaT0
 V+zBLNaXJ2gx3GkIPpEbQfNsme6UwixamkA62wP+n1cjls+zYAyQWMujJoa9xf+cTwdpemCUxk1
 mziPwIj96tq1SijKs/RZlRfwyaHQP30J/
X-Gm-Gg: ASbGncvXxvh6F6ydaAlPF8q/+sszqCV67vdukJiGyPjdfQuqcFrMwZgoFH025GtS6qK
 +LESpvi+NBwaeu/hFWOaHZc/nJkW6UmgNf1IOIKiljaF0nPHnRQCo5PRSgq7b+dPuwLKyIQ7EQ3
 INP38ATpnSuCQhFnG50JG3
X-Google-Smtp-Source: AGHT+IHM8837jEVmD+BRMNZbUczs1FUS082Jeq9uM5ltubcmRYOW5j+ADY/kg6eBnyOlxYlnckbEOAyV7hJ4tA8XzJk=
X-Received: by 2002:a17:90a:7343:b0:309:fd87:820e with SMTP id
 98e67ed59e1d1-309fd878b25mr3562362a91.26.1745659021145; Sat, 26 Apr 2025
 02:17:01 -0700 (PDT)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Sat, 26 Apr 2025 11:16:50 +0200
X-Gm-Features: ATxdqUFV1yZJaNlh5oR9zewKPkU89y4gDwcUpZuby-WNZYPqQ8BpSI9sb-SxDfE
Message-ID: <CA+DkFDZM_zM9vWBetcTJ43QBA1RYv3eXYTg-OPnQABGg-4WCBA@mail.gmail.com>
Subject: Question regarding arch-fs-layerscape in the context of DDR
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 26 Apr 2025 14:23:26 +0200
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

Hi
I've got a question regarding arch-fs-layerscape and would be grateful
if somebody could help me to get a better understanding of a few
things before I submit a patch with some changes so that I won't make
a mess on the mailing list with unnecessary changes.

1) Looking at the ls1028a_common.h - it defines
CFG_SYS_DDR_BLOCK2_BASE as well as some other defines used by ls1028a-rdb and
ls1028a-qds boards. Moreover ls1028a-rdb and ls1028a-qds defines (in
board config files) that they use 2 DDR banks (CONFIG_NR_DRAM_BANKS=2)
which is true as both of them use more than 2GB of RAM. However, what
if the ls1028a based board uses only 2 GB of RAM? In my opinion, in
this case, CONFIG_NR_DRAM_BANKS should be set to 1 and
CFG_SYS_DDR_BLOCK2_BASE should not be defined at all, am I right?
Is they any reason other than the possible compilation errors
(CFG_SYS_DDR_BLOCK2_BASE is assumed to be defined always) that
CFG_SYS_DDR_BLOCK2_BASE should be defined CONFIG_NR_DRAM_BANKS=2 even
when the board uses only the first DDR region?

2) I've browsed through the code and it seems that there are some ifdefs on
CONFIG_SYS_DDR_BLOCK3_BASE, whereas when the code refers to DDR BLOCK2
BASE it uses CFG_SYS_DDR_BLOCK2_BASE, like in the example above. Is
CONFIG_SYS_DDR_BLOCK3_BASE a legacy name and should be changed to
CFG_SYS_DDR_BLOCK3_BASE? This question is based on what I've found in
doc/develop/system_configuration.

Best regards
Patryk
