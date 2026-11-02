Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E203606A32E
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bQaJ32mE;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=nH794Fzu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8373D60757;
	Mon,  2 Nov 2026 08:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUZaCVMh9FQ5; Mon,  2 Nov 2026 08:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DE3960661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793608849;
	b=OrWuAPaTgGNUVuI94WNvj9be14I8lm+IOSWv7R/7WaZLLFyQKrZidLqi4a3bTnVDK13A
	 QZzcnPAQlZ0dLVbDccM363kxm0IIxMAhkzKNU2+Qeq7UkBEofjtbF8Qi7LV8DzuUvFz61
	 ZKm5TjsMmfDlQMKCM0FKV3Sg+rTV0oSSwDyzCGd0l06Hg4noTcBen0cxGws93AL+v3lAn
	 hGaMUoKXv6aaVdP937bAJsVFUZX9FMApnl3E40ZbflQBnqQTNf7fJQfsV3cpAnIJb2XUL
	 1Ot0AIVm1M6Iqw3Pkdhf9TUDeMmZpuLmCmPkeDULz56bGvhRExQGrvcpRkiG3XQsqjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793608849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0chtMiraZZ5kutRGFN5CPdPl6Kag7N9MoX9NIstWO0I=;
	b=lmM4H69H7Vx1kMt1rpAgiB17A7/Ae5StO6kJ7XMrInVfsmipSmETDkZeecCaFPrEtQ7r
	 iQpDz8aGtvxywAQVbeek6vqS89mdNecFYCv9rvlHtUvVs/XvWgJZolDRoZiv8PegZo3RF
	 snS2CSYbPjiDTUMiTD11Q3qMvRi53vgQyXmlobQNT2KgrmippPccjTefLdCvfRlqtbabW
	 4FzhQvwU9hy4loeUiH/jS3OMJCsziYGahTMYbnxzplBUyX1uppSkowcVY/Uunfm9G+CIz
	 0GtUfWHwfHkSRn2HO9fX54anllqW+0998c1EyuTaKOoSoEBF6r2iRmFfIccWrcZCzQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=nH794Fzu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793608849;
	bh=0chtMiraZZ5kutRGFN5CPdPl6Kag7N9MoX9NIstWO0I=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bQaJ32mEma5ZKZouDQwolRm6SGZjOMaDT37IDh69C6Xb9QYqOCcRcd374Fx8L2E4a
	 tRusgejDmy1ojy+92n63BxmrrEOeQW0hs+LsItBaw6dKZf3MqVvVcqPd0n8sm7LzRS
	 Rk62dQDPDKmzyLgAhQvslGujrV4n06efar1CPOy4Ob1lMUiRGviWToZe6cnxutH9fm
	 1gXvtk61LZ2JlEDSP5wOytTOa0YAjOMHtpBaOheW2zI8EWZRSX35sZjcujrNakmESK
	 VKdwld0j2+1m5wfgNWFQl7XkUDKvdzaVGohQg5pdUSFxhq4kNTs7JKazPOCOIyeLVP
	 GC8wNaod3o4Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DE3960661;
	Mon,  2 Nov 2026 08:40:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D7A1323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F68D60661
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXiIjerYJlcf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 08:40:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 907F46064C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793608847;
 b=bMj1/JJ/ltZLx9PAe5Asq4nuvYbIZS7ts7ZUjzXuudZsxibdgJWseXS8+1GQzGfGIqej
 QRrpX/Do4c6UeBesOKKIu4AzMyv2ZXa/g6SAL7qxQwmGl2TSpH80sYAE68q1Xyw/duWbP
 xqVimY59uqIr24UOrvToz99tCpUm7bEcx2LJEHpB7sz5tAVIEpG+nEv/ZjHbW+euBUZDA
 JJh82bqZsJsPRyf1rJYY7S337eWVgVsmitB6+u9ASxzsYvce2gV/koijyllVUw0WBoCOy
 cHLdvUiSkDiHjkGd87W9ELC9KZx77pXp06JcGurxl54WZKkMakzcYHjLAnYopFlwtew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793608847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding;
 bh=0chtMiraZZ5kutRGFN5CPdPl6Kag7N9MoX9NIstWO0I=;
 b=I+5f6V5RNOBulNbhrkokTEC0Wnz3bOKSulxJb6SHmnt1eOdwC1FLBkv9aMYLkUqJHz8L
 XWMvIJgMewwHNIvJdc82M+OHAyEkFbDWhtE4mnGTM32Q+BO4M3ARBP7RcBXYMQHyQKMHA
 rLU8wPgb7jm8Z4Gxzw+y/JRGqgdNvWeTcKBMisN9wl+mL7xG8pg8e29cc0fOOvp2/KIcL
 STu1qKKl87yi4ohSLZdeCiPFrTqCPzXRm3sKBlVLglWIxkBEtxoatySHqm8mt4VJNkqbs
 92SGyNy5H0pCfDuZwWWiR1gtJMd4Nulgn8Tlhf+kURUEQPswbuA1/HkC6C6JNHtCbTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=nH794Fzu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=nH794Fzu
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 907F46064C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:40:46 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2262680a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 00:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793608845; x=1794213645;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0chtMiraZZ5kutRGFN5CPdPl6Kag7N9MoX9NIstWO0I=;
 b=nH794Fzu1sJVep05Bf7xLwob/Acg+CgphQ9qJueDWZdg+zGa3Ktqqv0NHDsCGuuBGj
 h6ajWhSjdc5z2hluW5eNFcvXNTcZM+5xmMTIqmKx70mxQaSye83vQjezPoW7uq3MJJCn
 LAcOdiVU5iuEUOjjuYxVkj4IRrvAeMbMQFbuLoyiPADyaBFdjUFmQBurmVRwGm/fpsNv
 Qk7IllASh0UhK4kqF4ZSAae7VuqRK/SvQhOHthUokFmbqmYtuYH6OAjQwxk68y9DoH0h
 k6gZHHhLlY7djsa+U7XdPRBITwHKduNf5DIHCygkX+pCamqh7AV0mr7659Dv3RS/KnVd
 xNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608845; x=1794213645;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0chtMiraZZ5kutRGFN5CPdPl6Kag7N9MoX9NIstWO0I=;
 b=zZZzjP8E/dbinjhXcjxduhtFWfGXwnAqaKrZCixw5OZ/ecjcCBhtYG+5Ogq2zSnyBk
 QnByyedp015xNQtVB3HCZe4pdztMonY7iqypbqYtXaWX2v4IheLN/cvQL/2aJMjfhiRc
 rPOz5+sAB3F0L0vwDYP1Q1s4RifuNNQCGcFGCv/2n2prs7RkCeZPTP/vv40ByIu+WR0R
 omWS9CZJPF//oTZr7PlIWDTCyzwTs9XtlVHKnDYjtRsSnOd3zXTaz+ZbQwGyhTlTSUFX
 dsPSyMsRIzdfiOf92ZCWZrZeZlmzACsslDJg7Vn4l9r9KAP0yESTV5YIyg17/AaVughh
 mdAw==
X-Gm-Message-State: APuU4Z/6Zb2dTU+xAscSHXz6iR77PbXtIu5cDBmd53rTv9/Gkx7qtg3B
 ziz4g6NoESu20wW+uRGohwpDSEm3arj4dbN0ylnw1nRa4cUC6WyQZguQlt/WjWMIIrQ=
X-Gm-Gg: AYBFou3KyzW1qoYR+2qMISBbesxTJ/7yZYaEIFWsmZxTZebZxcnxZCqS7+5LaD7j+J7
 Z6AyOIUtNye3phONBbvWiJTWQLNEXR5kjOD/P5pkavL6Dd8UTLcE1Lv6WXg/FYKWwVpbypWijEN
 kRXfysTRZxIycGdqB7EFf7CNFF26tTc0KNsLQTanXi/48o9lA0FNP6oLSBgO6Fh0v8xTRldzme5
 9ZuBGsCffxn0qKMIqrQhNq6EDFX8FD7dw4BxR27HfYJcDD0ZEybcLqSP/hti0vrThvBr3lkv+qr
 8Xcp33J4W9hlxc1oinGAWazyNXiNyS9dVII/NzG1Xy7CWUnw++eSbFpkTodaDpnDRRJT0749JB0
 RU2H7lVkqmuCO3EWwqBZwNnj+Uw5iYGDdMifBYwT8dRdeiyFKZoDJ1Bt0P5LkYSbdg1bzec7EKK
 +v7Xj372k1ZDjGpZzVa/y/5Td3Mr2omWoomxjeVHX6TAeqctqA/cd6DjYQgNJWYs8/ya1UvD8Nv
 4yDJEcPGbc9xZTGE1J8aszrq/H/1JQ4VHxx25A/pqvudGU+zlJBocrCpQ94pFTLqSwAKJPd6PQk
 dNkT+qS7K8Bk+Z+gDWvVt99PxuhJAermHVMUdPopl5Fv
X-Received: by 2002:a17:90b:1c0a:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3ae8986784amr8349705a91.60.1793608845179; 
 Mon, 02 Nov 2026 00:40:45 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d5b8csm18368583a91.1.2026.11.02.00.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:40:44 -0800 (PST)
Date: Mon, 2 Nov 2026 16:40:36 +0800
From: Leo Liang <leo.liang@sifive.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 zhuxu_ran@zohomail.com, nwhitehorn@pa.msu.edu,
 nikita.shubin@maquefel.me, pengpeng@iscas.ac.cn, me@ziyao.cc,
 jamie.gibbons@microchip.com, gaohan@iscas.ac.cn, e@freeshell.de
Subject: [GIT PULL] u-boot-riscv/main
Message-ID: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b:

  cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main

for you to fetch changes up to 22c3818159190cfd6dd378b7a628c0b339ab1c3b:

  clk: sophgo: cv1800b: Drop legacy compatible string (2026-11-01 19:16:36 -0800)

Ci result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/1815
----------------------------------------------------------------
- riscv: sophgo: Use upstream devicetrees for CV18xx boards
- riscv: mpfs: move system controller configs to CPU Kconfig
- arch/riscv: Allow booting from NET
- riscv: mpfs: Read and store FPGA design information on MPFS hardware
- MAINTAINERS: Make RISC-V entry cover all paths containing the keyword
- Fixes:
  - riscv: timer: Fix M-mode early timer support
  - riscv: thead: fix D-cache flushing
  - doc: board: starfive: update jh7110 build output description
  - riscv: mpfs: imply the CoreQSPI driver
----------------------------------------------------------------
E Shattow (1):
      doc: board: starfive: update jh7110 build output description

Han Gao (1):
      riscv: thead: fix D-cache flushing

Jamie Gibbons (3):
      board: microchip: mpfs_generic: drop system controller Kconfig selects
      board: beagle: beaglev_fire: drop system controller Kconfig selects
      riscv: mpfs: move system controller config to CPU Kconfig

Nathan Whitehorn (1):
      riscv: mpfs: Read and store FPGA design information on MPFS hardware.

Nikita Shubin (4):
      riscv: Fix IPI not initialized in riscv_cpu_setup()
      arch/riscv: Allow booting from NET
      riscv: timer: Make RISCV_TIMER definitions weak
      riscv: timer: Enable early timer for M‑mode

Pengpeng Hou (1):
      riscv: mpfs: imply the CoreQSPI driver

Yao Zi (1):
      MAINTAINERS: Make RISC-V entry cover all paths containing the keyword

Zhuxu Ran (7):
      clk: sophgo: cv1800b: Add SoC-specific compatible strings
      mmc: cv1800b: Add SG2002 compatible string
      riscv: milkv_duo: Use upstream devicetree
      riscv: licheerv_nano: Use upstream devicetree
      riscv: milkv_duo_256m: Use upstream devicetree
      riscv: dts: sophgo: Drop local CV18xx devicetrees
      clk: sophgo: cv1800b: Drop legacy compatible string

 MAINTAINERS                                     |   6 +-
 arch/riscv/cpu/cpu.c                            |   3 +-
 arch/riscv/cpu/mpfs/Kconfig                     |   6 +-
 arch/riscv/dts/Makefile                         |   3 -
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi    |  35 ++++
 arch/riscv/dts/cv1800b-milkv-duo.dts            |  64 -------
 arch/riscv/dts/cv1800b.dtsi                     |  22 ---
 arch/riscv/dts/cv18xx.dtsi                      | 232 ------------------------
 arch/riscv/dts/sg2002-licheerv-nano-b.dts       |  45 -----
 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi |  16 ++
 arch/riscv/dts/sg2002-milkv-duo256m.dts         |  46 -----
 arch/riscv/dts/sg2002.dtsi                      |  34 ----
 arch/riscv/include/asm/spl.h                    |   1 +
 arch/riscv/lib/thead_cmo.c                      |   2 +-
 board/beagle/beaglev_fire/Kconfig               |   4 -
 board/microchip/mpfs_generic/Kconfig            |   4 -
 board/microchip/mpfs_generic/mpfs_generic.c     |  26 +++
 board/sophgo/milkv_duo/MAINTAINERS              |   3 +-
 board/sophgo/milkv_duo_256m/MAINTAINERS         |   1 +
 configs/milkv_duo_256m_defconfig                |   6 +-
 configs/milkv_duo_defconfig                     |   3 +-
 configs/sipeed_licheerv_nano_defconfig          |   3 +-
 doc/board/sophgo/milkv_duo_256m.rst             |   2 +-
 doc/board/starfive/jh7110_common.rst            |  10 +-
 drivers/clk/sophgo/clk-cv1800b.c                |   3 +-
 drivers/misc/mpfs_syscontroller.c               |  55 ++++++
 drivers/mmc/cv1800b_sdhci.c                     |   1 +
 drivers/timer/Kconfig                           |   9 +-
 drivers/timer/riscv_timer.c                     |  16 +-
 include/mpfs-mailbox.h                          |   2 +
 30 files changed, 183 insertions(+), 480 deletions(-)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 delete mode 100644 arch/riscv/dts/cv1800b.dtsi
 delete mode 100644 arch/riscv/dts/cv18xx.dtsi
 delete mode 100644 arch/riscv/dts/sg2002-licheerv-nano-b.dts
 create mode 100644 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/sg2002-milkv-duo256m.dts
 delete mode 100644 arch/riscv/dts/sg2002.dtsi

 Best regards,
 Leo
