Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC82C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D99F4606A8;
	Fri, 11 Sep 2026 16:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzrOC93geVY6; Fri, 11 Sep 2026 16:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CA5EE60635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145861;
	b=aCY6HSsAyJEr5QmNqB/o+3WzT6Et5+7IFjQlrQduUyfk23WOzeppl33VtGpqTLKZnEgl
	 OxtyxdGLpZSC2Cznw2Phw2Sj5+1THlqsugyUTOm43kIORMs3VQMlZCKSa8aao2eEcNpM/
	 zal7Hh7obJosp/ZX3RbonbTD/4x4utgueK+B9e9nyD1EqU6Qqm3GfXdX8tw9Ib94zGR/B
	 rhC2Pvyu3sTd1Mi7xvMIo8PnylgYqkOqVA4fMhkisib7ctmwMcBbz+j/F1vsn/CVCQV4x
	 cXwywgEgc3aStKsEbFQakMp6pYznc9qj71zHRZL5Zp8cBsJ9o+rP88pjGPWk8JzCsTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EVLBm6kXQgRwuNzeRkEObkxd649ARmB2nHMoOqj6EPc=;
	b=Hnx2aCJXpyQInzBiBTHXcG01EbsryPekAsUU7XUcGJ7gsuG/h8jz1jZQwICnLcdd3OSJ
	 JrxB7BZ/rBrNMcpDn7XK45w805TaFcmZAjoPz5ocSLvSeBd5ad9eNm/mC4Q+SmKSGB5wE
	 r8TZHDFA847YN+EKPW+DGphUPXa6TEeS9S3GI6hrbRY1kXUcmJsq3qXoLTJ9lnSCguNzs
	 fjDW3QyIe2gYliACh/Ys1RBx2HC769caMLKdhTHMTQwJRvcyRyhwiQXY/9wKEzFfgYly/
	 JfZUJ5V9rS/Q6s0MsElC0hkGlBzUttjc1I0Xf4vA+N9+LTjFypuQHqca7bOhLdqXQVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKleN+kZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145860;
	bh=EVLBm6kXQgRwuNzeRkEObkxd649ARmB2nHMoOqj6EPc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FVO+Rv1q/WSdIyzFbNvjr0ot9o2ewZ9cS9l7M+TojcG/pg/gVorFU1Fi7+xjkDj7/
	 cxDX9Uj5omWR9aWVyAxxE4zhR010Sh/U/DzgaRlWRPyM0VAJxJxjRd7vurxTbU2DeI
	 bTbrc0LuP6JldsXPw+zr6Orwu5SSYKVMyylnuRu5zxTjuTtTslpRAz2m9pwSH0+M6l
	 xqczrlthhHWC745xZJ9k/2KJym1SiZOXWGD5Be6+TbJ6LVqousvIYOF+g4u8uutmMf
	 P9568+1jXgNu9I2aWurGNSQ/cId6IHrRMINImOwEVXXW0KVXD5PAi/cQ2ZVpqExxBu
	 ENCQxxVmQ1ZnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA5EE60635;
	Fri, 11 Sep 2026 16:57:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 259CF3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 171B160635
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aewkybMvcOMJ for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2592B60625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145859;
 b=OWy62t9LhR1T7Xpl/dh8ImcJMIGk3SHax9fChl9IiP1BvKOtviNmujMEpsOl4o62LOGN
 yvQi6P/vyfC9MQcBKHODbziliamf6Id0BkqTbIRWmr5EwznpIgnpkMcvaNQ59JNO4vpH2
 CEze37yOhf2xj0N35zTIqsD5+xpgqtGx2cukj9c8APcol7qMq6xP+saMmk587Oucgd5IR
 YzkeKhTpZ9dN2G1XrRbIeLv+AAwyX8kslTLLKqUunPLPuSTYgZhKh5H8abbqln6Xno9/b
 aLo41CxpUvLT/Y1JKW5utQoU2nWvC8AmZ5vpzn3zNjZct9fzGfYloiSByhmPWGEeKLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145859;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=EVLBm6kXQgRwuNzeRkEObkxd649ARmB2nHMoOqj6EPc=;
 b=oYKXC3GiKzZ5NnNTsJ2iAR66Iktq0Ir+ofDblw5KStQXyrHKh9jHkCWADwsFk8LvoYR6
 uJoFlhzXzVzLl1HLlRkhxpyxMMZba2ySesPUqgcTLsnb9z03HU94A0WlvxeQ11uA3TFBA
 YGRW36IfP3qATDIxu4JcmzIuPuIy8TNBT4GLCngvQN81+eGBeAw0Tu1PzUpqnqJdr2L8u
 9qnc++m87y+FL3903Y1mfkjR7BOTfFeU5nuPFStRaaMI1fuxoDUXlT/5VPbZhUpJd9z0B
 7nmLxcSfiOkcwh3abAytqjEbEqvh0KuvSw2IYdRBrIQNeoBFmRSfPyBmsTM3JA+Q8UQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UKleN+kZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UKleN+kZ
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2592B60625
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:57:38 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2db858d60e0so11580375ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789145858; x=1789750658;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EVLBm6kXQgRwuNzeRkEObkxd649ARmB2nHMoOqj6EPc=;
 b=UKleN+kZpDKwLyUTb/gaRww9em1QuOkd8Gqi1hC9R2eDowffqBrQxogc89yIzy/fvZ
 sKT94D3V3Svn94ISZ6vW7yYkeEz2A6Q1tpYSohs4ZPJuX+emlcaqIsimgC25Da+1vY3B
 nMYFFUi9xg/EYWbyQUvGNbYXgESyVUP+nK5gqfuyZwRdgj6DOMpZ2+LQ7Ab1tHVUL5qa
 cT3Wu6CVkP54S/diXkW/TxSMRy4cYRyAwWznx+iTHng0fZ7+IybbKsqhCT+mn5k5QCIs
 x7WMgJxM1HjNvC9KwO3zKQOgBKNlmXR0l2wWdcKWJigD7TleZgMtaDmFLQArLsOPfwCr
 QNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145858; x=1789750658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVLBm6kXQgRwuNzeRkEObkxd649ARmB2nHMoOqj6EPc=;
 b=hNyUs/AeoeCskICz03zJJuoygxBGMdyYMLTcWcQ/LYnGzPGLzyzTgMyTnUr1GbozQw
 hY/bTq5anwL1VDWb0j5Qmtfr27qn3zWh85tREMQYlY6lRhudTLTMnfvX/NRPV/WXbfEl
 7aEvDM+5KphaaoL4azVzu1co1YDlPxZi1t8yUoenVqhzmNKXkgRbaiSdXMZiIsWvcMq9
 fvzlqvjlYr1Sy/yKqx6a+yX0YSkMuMcOV2/UNpDO9NZH20KWUsovt0ErX3axCVEidRqW
 VjL/naI7IOPvYm1fxJ0SEZnPbfUC2aW06/DWEuH4UzQPsHQ8CcGQGOR6IYGgHPdtawrh
 1VeQ==
X-Gm-Message-State: AFuF++mOtLyPQNhVBQvKmRAn5hMhsxDFeoHIlplsE7FxO3UVVc/pjsFI
 xK0giZTUc4XLL5OtAm2bJ5ociFY4UVc4xxD5iEpUQiCAG45HKlcl9QPi
X-Gm-Gg: AYBFou1gPKH2JALBK5AfvyjZYOVW3Ujz+J9LuSdkN5EBR7USI8EB8OGh2UmMuQh7dlO
 jdlj4jL0TdyAxs4QJmSlYbG8EA9s7JFFmLMmn+4jNP6lZxeAFIASqFJ2xN15ZDNQvWQZB5cpDhB
 TJPUSeUto86vZ/qFYdfYb9URBa7dkpH4PCQwr8f1QqnZoUlIlZXJ1XAeIWUg3Ts2nrSL9EW75NF
 rYF6svgv/eeSaEg2ZTM7syqcZT8UiquQVqvBONGbwnjUc3FBN62KZM6om1jsmICCxoUleA9+0IG
 Tcuky6Ab5Ie5B6hUjdLOPQNI2Un7hQ7xsVmTc+qUenV0jNpElY22GXVaoBQlP6Z4sa+R/+2aSU+
 3k9lRz0xeMDIWl9bSbV0qPP625s1+tD/WMSX2S5mfQuulHC5RT+vJwj5QPyc/eap3kmruA37kCL
 HZheeW4kgSRdk1P3FDXJa1ga58AeJ3+8dvwl+n1OcoGLGkboAVgs3+aTGqMZCIJuXEBskGT4o4x
 Q24/u50y35jYiCi6BPuB63thLcEzpm2eNqQz17ZQj9y+OrNHw==
X-Received: by 2002:a17:90a:c2cf:b0:398:9bd1:3210 with SMTP id
 98e67ed59e1d1-39d9c21d78cmr9121679a91.17.1789145858069; 
 Fri, 11 Sep 2026 09:57:38 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a803:6c49:9c35:d64e:78e3:c51b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e5193dsm7469763eec.10.2026.09.11.09.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:57:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, alexander.feilke@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, hppiscas@163.com, rafael.beims@toradex.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260911
Date: Fri, 11 Sep 2026 13:57:33 -0300
Message-ID: <20260911165733.1611766-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit d4152edb50356338af994d1c0483f65b717b4c15:

  Merge tag 'u-boot-imx-next-20260906' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx into next (2026-09-08 11:48:35 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260911

for you to fetch changes up to 955b7931cbf6e8cc41e2f12fdd57b5ab906aef34:

  arm: dts: imx95-aquila: migrate to OF_UPSTREAM (2026-09-11 10:35:18 -0300)

u-boot-imx-next-20260911
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1253

- Migrate imx95-verdin and imx95-aquila to OF_UPSTREAM
- Rename SPI_UBOOT_SIZE to SPI_UBOOT_MAX_SIZE on TQ Group boards.
- Change i.MX7 0x911000 IVT/DCD address to address erratum.
- Fix the DP83867 PHY symbol on tqma7.
----------------------------------------------------------------
Alexander Feilke (3):
      configs: tqma6: rename TQMA6_SPI_UBOOT_SIZE to TQMA6_SPI_UBOOT_MAX_SIZE
      configs: tqma6ul: rename TQMA6UL_SPI_UBOOT_SIZE to TQMA6UL_SPI_UBOOT_MAX_SIZE
      configs: tqma7: rename TQMA7_SPI_UBOOT_SIZE to TQMA7_SPI_UBOOT_MAX_SIZE

Nora Schiffer (1):
      arm: mx7: Change IVT/DCD address to 0x911000

Pengpeng Hou (1):
      board: tqma7: imply the DP83867 PHY symbol

Rafael Beims (2):
      arm: dts: imx95-verdin: migrate to OF_UPSTREAM
      arm: dts: imx95-aquila: migrate to OF_UPSTREAM

 arch/arm/dts/imx95-aquila-dev.dts      |  389 -----------
 arch/arm/dts/imx95-aquila.dtsi         | 1160 -------------------------------
 arch/arm/dts/imx95-verdin-dev.dtsi     |  239 -------
 arch/arm/dts/imx95-verdin-wifi-dev.dts |   21 -
 arch/arm/dts/imx95-verdin-wifi.dtsi    |   50 --
 arch/arm/dts/imx95-verdin.dtsi         | 1172 --------------------------------
 arch/arm/mach-imx/Kconfig              |    3 +-
 arch/arm/mach-imx/imx9/Kconfig         |    2 +
 board/toradex/aquila-imx95/MAINTAINERS |    2 -
 board/toradex/verdin-imx95/MAINTAINERS |    4 -
 board/tq/tqma6/tqma6.env               |    2 +-
 board/tq/tqma6ul/tqma6ul.env           |    2 +-
 board/tq/tqma7/Kconfig                 |    2 +-
 board/tq/tqma7/tqma7.env               |    2 +-
 configs/aquila-imx95_defconfig         |    2 +-
 configs/verdin-imx95_defconfig         |    2 +-
 doc/imx/common/imx7.txt                |   40 +-
 include/configs/tqma6.h                |    2 +-
 include/configs/tqma6ul.h              |    2 +-
 include/configs/tqma7.h                |    2 +-
 20 files changed, 35 insertions(+), 3065 deletions(-)
 delete mode 100644 arch/arm/dts/imx95-aquila-dev.dts
 delete mode 100644 arch/arm/dts/imx95-aquila.dtsi
 delete mode 100644 arch/arm/dts/imx95-verdin-dev.dtsi
 delete mode 100644 arch/arm/dts/imx95-verdin-wifi-dev.dts
 delete mode 100644 arch/arm/dts/imx95-verdin-wifi.dtsi
 delete mode 100644 arch/arm/dts/imx95-verdin.dtsi
