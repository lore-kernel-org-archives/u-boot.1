Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75736C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FBDC60817;
	Thu,  6 Aug 2026 11:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKQ2Nqp-djEL; Thu,  6 Aug 2026 11:00:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E068D60811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014044;
	bh=xv1YABrvii8UrtQkjUuJYi0yHfAxzY2ARuJun5ZUUg8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g86ZUPnnmLnCXrI7mkpYXWCIyznvPB0vO1l+uW4d1TGKXN0876TcBk71cEiXjUPsZ
	 3f7jgik5myeCPXIq38KGM1/6xrOqiFI2hPGyYrJo0c7F53H45LmOaJEiSwqbOM4974
	 rawjWmDuxkNDH55lIW7JMwUgxt0thV0aLejUBU+SLYJTovh2GYxja9r1bt70KJraCk
	 9Fzh3XC5fD8AauNYwik3ZlKXtnx/9yiNg/AyE+p/ZwjiHDtuayDnstfS4zztf0E6a0
	 XwuWgEJj4s7s78BuHut/Er7tAC0Lpr6b56Vs/mIuYMdJ/QL+bZyirDSVPwQtIRdH52
	 FVYWuNkeGw4lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E068D60811;
	Thu,  6 Aug 2026 11:00:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEF852B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBC9840207
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jptsa7eWzLcy for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:18:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.51;
 helo=mail-wm1-f51.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 25DDC40167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25DDC40167
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25DDC40167
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso14198615e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011493; x=1786616293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xv1YABrvii8UrtQkjUuJYi0yHfAxzY2ARuJun5ZUUg8=;
 b=QxCBwkGW3cj9RV49UnvtXYCZark19BjG5Rht0j2BeQuU7QPX+iwkKWC8bd7IYretKr
 5yq5sT0bNrIJ+DLVTVm/uGkFNFBMT4aIyCXjD1hnhEj5/Qen7eXxr/Sew15RYl14July
 Wzuy0x67B5WnvS4VdpsI+4JQjYXdM7+b/G8EuOF073GcTk8fesPvY9PWukddbhTY7xCA
 nqF78iqjqBhAFzEjuT1WkozY8QxEDOMDk/9BKO2pAr/ytZzVNpk21w91fD/EaXYCad3m
 bJo4euWYg+TPl9jg2Xmfu/SCxo57S/pEkYQsaek2L44uy4/19ka1z9NQdQctixwMg4hg
 bPqA==
X-Gm-Message-State: AOJu0YzuLtCkY37kB/rndQyYG4XnhokJPfGaOsmoUSDpYTDbxCa6CsKc
 enC4RMBSrHPyxrKi6k14U5pCiryZKnJxIInS5o3kKCIcsu0oLzcJkm/3hYjbfw==
X-Gm-Gg: AR+sD12v4Fb2WHvySVTyl1Q0A2oy3QhrMtjE3+r9ZCxuVdUnRCPvQrKG9gKAXu3O1q3
 RC/muAAeENnj8qwMr9sRi8ViBr5TT+NsW6lhZVlQdzgbP57ln0EIfpQtUy92kbMGa3ToyFg/5my
 vq18XnrAGkjhuUS8VREsdbli+N50yBfgV9GKRFtcYCM7UjZIJ/BcFJeB8uAu7AkeFYaexMZa9b4
 xDnv/tmP1NpNzvjJHMAUSxRtqDXpjL7GE3rGmjk7m2AYE+xiQJTxtc04e0J1v7YY8SgXfpCC75f
 eRpYA3fz2w4x/jOB84OOrvYJL5Hsoj89Nn02okrzZPzupEDhVPa4PPDbr5qlsQnmZINZwzRRSzB
 6F+c8K2TBr6Om10d+LnmT9670DP62YAsRSqLIZzot8DO+Uj5srB6HuTaRzhURmCflvqfqinPnJS
 Gk7KhRcQkl+uCnEzgVRgS7DwHjVUiJA0b3EdaJg7A9WE4Vn5gYc+cIGlrxsNqbrmM6/b7idraCq
 05RSFL/4IMwF/T6gGuCFqjbVs0=
X-Received: by 2002:a05:600c:5686:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-4994e7c60c2mr122449515e9.10.1786011492992; 
 Thu, 06 Aug 2026 03:18:12 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:18:12 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
Date: Thu,  6 Aug 2026 11:18:05 +0100
Message-ID: <20260806101809.72526-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=linux.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds initial mainline support for the Amlogic T7 SoC
family and the Khadas VIM4 board (A311D2):
 - S4-generation UART support
 - the T7 platform code
 - VIM4 board and defconfig
 - VIM4 documentation

Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
(tftpboot) and cold-booted from an SD card.

Lucas Tanure (4):
  serial: meson: add Amlogic S4 UART support
  arm: meson: add Amlogic T7 SoC family support
  board: amlogic: add Khadas VIM4 support
  doc: board: amlogic: add Khadas VIM4 documentation

 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  22 ++++
 arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
 arch/arm/mach-meson/Kconfig                   |  10 ++
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-t7.c                |  97 ++++++++++++++
 board/amlogic/vim4/MAINTAINERS                |   8 ++
 board/amlogic/vim4/Makefile                   |   4 +
 board/amlogic/vim4/vim4.c                     |  14 ++
 configs/khadas-vim4_defconfig                 |  27 ++++
 doc/board/amlogic/index.rst                   | 119 ++++++++---------
 doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
 drivers/serial/serial_meson.c                 |  51 ++++++--
 12 files changed, 421 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-t7.c
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

-- 
2.55.0

