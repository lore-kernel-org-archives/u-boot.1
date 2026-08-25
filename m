Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B07DC5B572
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C835380CD9;
	Tue, 25 Aug 2026 04:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSiDANfwDbxS; Tue, 25 Aug 2026 04:25:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631911;
	bh=U1DQvrb6q3sugiMe+cSUD0ZgCWCGmLlQbB48pKpZHwI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lh/o/NMGUyOSZ2k+N1fa/ssVP42be3AvXgotCSnAsYsERR8l1uJEUmJmEG+YmQXSE
	 8lV//5AFkYWhR7DmaFeypy9oeZjW4IgmbSs36QcE9BQyLnC/qtzoVVzRc97vFUJprq
	 0R6ETG278fgcUQRcUuViN32N/kSV9zPguhHV5bogQTm9nYeS9aWZjBKxXYoiQKmcyc
	 Zx1gixfAa7GY4CvbeURo+5MWz7V39jUCFjyL0knHqs05Y9PECwV+uMWJca4JNvBYXC
	 sGxoHLRC19It/7nA9aKMcpR7m+/JeIZGOeq+JD7s/FKHj2Wu7qgQK7x/amIgwOAF3t
	 BY7iWIaz5jujg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F355580C33;
	Tue, 25 Aug 2026 04:25:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FCD71465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1176F60672
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJ8EIdOs4Wid for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lYTYDRee
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5239460667
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B0966011F;
 Tue, 25 Aug 2026 04:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3778E1F000E9;
 Tue, 25 Aug 2026 04:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631906;
 bh=U1DQvrb6q3sugiMe+cSUD0ZgCWCGmLlQbB48pKpZHwI=;
 h=From:Subject:Date:To:Cc;
 b=lYTYDReexvSL7J6syuLOWSTAm8HCShbXqj8Vdq4AqqQIzMk8ZGhDu20CWEyvO7oaJ
 KwvHpP72w8qKAUZNmh6TqErwPKXtIC40J+oJIFfK2bIFuMmEhV3xOatZgc+PKm+Cs8
 BE9A1hOtT8jf8dU6OnX2rXelEvYtSBFfj1t/9rXDtvxBA3wvw8bXHNaspNdQr5bENd
 jQuhBaG/x9791gT413qn+sEmeGZEiwO6EhcgkZwG/cjEmj7E/yQ/tKPBVeJF8ipzY9
 5nWYH4XGJaKrJb3VoOO1Rq6p9lxHAIpGG8P9XQ8LY/mUF5hDHUek2yP1i6Me8KM6/w
 FrG3Qtyl8Rnvg==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/8] spacemit: k3: add clock and reset support
Date: Tue, 25 Aug 2026 04:24:10 +0000
Message-Id: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoYjWoC/yXMwQrCMAyA4VcZORtI6zqGryIeao0aJ2tJOhHG3
 t2qx+/w/ysYq7DBoVtB+SUmeW5wuw7SPc43Rrk0gyc/0Oh7JIfTHtMzpwmVjSvaUkrWiqMLkag
 PwQ8RWl+Ur/L+vY+nv205PzjV7xC27QN36amMfQAAAA==
X-Change-ID: 20260824-01-k3-clock-reset-support-815a0045526a
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=dlan@kernel.org;
 h=from:subject:message-id; bh=bk8kX0jjYFwIm37q097lkHWQM5iI/j1unEMWDRz0vr8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkDOicEd/Dp01cIzGTm8nN3F8P/XV98ZeplK
 I6cHa268CuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZAxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3plg/8DYsBzSSQNgdGzI73dp0bDT6nl8NOB1HW1+8V+FMM3ddslX8v7D625
 UJ4bD8n/kR4TTuzXNGWv+nVNvlSBpPGY+kxOtJX/q64IYSzYmgd6WEqp842PBM53nLk60oIDNlO
 SSR6MfSIuyiWZ1thlJJpWnUBvz96F99fryVsJxe4aWd8M9hUbJJapG1D6PEyZvRxGV9eYfbxv7w
 ORVGO19R1b6B2B4EC69OzN+o5H6JQryvlVT3z/LTljMVnZoUiSvNPd2Z3Avdg6/y87Uu9LedV/U
 PRAT3D4s41OwkVufP0FmWrj9AILy42goJ5LyhBM6jS61VsnqEJtliPDtUQG0wlFID/yKlaLbnke
 rlORxFV6hwBil9GZsddP7SErXc+TF1DA9FvyRp5pLgEbdXQM8IKUaa/1qVzcBIi/kHqD+VtGsrS
 HD/8amr8hR4yKxfBkN1C2y+onsWbCjYvUN+QQIDvxHVGTDhgEPjxoWg7399dzUbFgrNEt8xzcEd
 SWzGqNw4UM0NxFaqI5DnT/hDXR0IPfytU6Yww8zXOMi84R0WFmLvLTofklIuN0nESN4afP03J24
 p0nS/CuLI9SQMa14JvkH1IWaNXWBoTcxRZe9LQiAx84iqC3GSX20USxkBGs7sd9gZSrrAwk/VZP
 LpCkD6kpqRa9yRsgDO55u/hklnTplk=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

This series try to add clock and reset driver support for SpacemiT K3 SoC,
the patches are largely based on upstream linux framework. Patch [6/8]
truncates the full clock to make it better fit for supporting SPL image.

The reset BITs definition lives in the same register with clock
controller which make them tight coupled, so I'm also putting reset
patches in this series.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (8):
      clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
      clk: spacemit: ccu_mix: add inverted enable gate clock
      clk: spacemit: ccu_pll: add plla type clock
      clk: spacemit: k3: extract common header
      clk: spacemit: k3: add the clock tree
      clk: spacemit: k3: reduce clock tree for SPL build
      reset: spacemit: Extract common K1 reset code
      reset: spacemit: Add SpacemiT K3 reset driver

 drivers/clk/spacemit/Kconfig                   |    9 +
 drivers/clk/spacemit/Makefile                  |    1 +
 drivers/clk/spacemit/clk-k3.c                  | 2084 ++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h              |    1 +
 drivers/clk/spacemit/clk_mix.c                 |    9 +-
 drivers/clk/spacemit/clk_mix.h                 |   27 +-
 drivers/clk/spacemit/clk_pll.c                 |  124 +-
 drivers/clk/spacemit/clk_pll.h                 |   43 +-
 drivers/reset/Kconfig                          |    1 +
 drivers/reset/Makefile                         |    2 +-
 drivers/reset/spacemit/Kconfig                 |   22 +
 drivers/reset/spacemit/Makefile                |    4 +-
 drivers/reset/spacemit/reset-spacemit-common.c |   93 ++
 drivers/reset/spacemit/reset-spacemit-common.h |   40 +
 drivers/reset/spacemit/reset-spacemit-k1.c     |  128 +-
 drivers/reset/spacemit/reset-spacemit-k3.c     |  244 +++
 include/soc/spacemit/k3-reset.h                |   21 +
 include/soc/spacemit/k3-syscon.h               |  271 +++
 18 files changed, 2992 insertions(+), 132 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260824-01-k3-clock-reset-support-815a0045526a

Best regards,
--  
Yixun Lan <dlan@kernel.org>

