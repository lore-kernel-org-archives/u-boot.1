Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282F8C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 12:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2829C6081D;
	Wed, 23 Sep 2026 12:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvFtn_yAb4L4; Wed, 23 Sep 2026 12:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 49E74605D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790167643;
	b=j2x1YW77+SP6zeTiAFXO2UWeziaochAEq/t2oojkOrfl3gpVXEVEWh9oShD+OHvZ3agh
	 NRpKNuNB5Qpe2zdbWOZDvKF9lF7cEPrIjeJY9lm9DnDDAha+LNNtyygftX4ig/YY81njx
	 pFLYJI87UGB0Lm/7xN05b+Aw6DklWghCJPawKbmqE0rht2lsmcXOfjAvyrMiGG2eHPO/j
	 i6TWgYvCHcaRyYp7o0sjnep/bSsqVkm+um3CsL/p6bTd0pLvG36Ncw81n2Uxxh5TBtd9E
	 W3AJZNvtyvf5S8UuuPQBXgPzSqhiBSDwzQ/SWWt3j6iqyKaFjjuvcDn20kk2OvuKPIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790167643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B2E/zpaOjK6YP/MNcCpQE3Rjtkox3XfD/Yr7X+SR3+M=;
	b=Fth5dOI0R0Dy6Be9aNmtVMbY5xriION/TB5uKY08fqWjVVvGi2XaQ8o4mAW/DIpAfWaX
	 Ir8q5rZB0KGsgaos+NCnAxFbsjv+u4XPYAOj68qGTzkmYi+gOgqOiD8yBRC0evJihT16x
	 YwRKfoSQOi3eq5azZare0aLSN02XDaNn4TYFWa61YecYUZHSMJp0gLPWBfyq1k12SPmUS
	 5Fexfy4akpIi+RTANUyAE+1sYDo3eGSZtNdv/SyOhj9NwEQ0pvUTIiR0laPlwbpGrAapg
	 cgN9uBnQM4/bnYmK1KViI0MAzvC3XN0spEycdB5HlDJn8O2Jaqok9XaSEKk9xzDIISQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790167643;
	bh=B2E/zpaOjK6YP/MNcCpQE3Rjtkox3XfD/Yr7X+SR3+M=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y7FBc6isHp42Gd4B/BtuDklKvfCOxZ8Ooxx/AKZH+CemOc0EHb9iuzPxdkENnwrZx
	 CIkzJMMgMPvKij7ARPIL9gs+OKWyvUyic5CmE6y6HUwdsUjD/sc3F07+C7bbJ85GxI
	 06Vo6xd/82q7G/XgfbOHovZsh4HlcOlcWyJBCJ7xKJ6SBfS0LkSVuLaigeaIzMMzoK
	 9GuQK82z4rBYPJ65Mx76YkTHt1eiCm/MFFj0Dn6gfYnbCR9s+RfbLtsAbNxeMEXFD8
	 /yWdog2cmaaFQlLVnOBRHHrV6ETvVjXIv3ilZXMS6RicJRF4fDm6WRbFpd0RAuP2EM
	 i2xuz0ysg9ttA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49E74605D9;
	Wed, 23 Sep 2026 12:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C146334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 821004035D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXZBcPrgvu9C for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 12:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 88D7040353
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790167640;
 b=jOZ3xzGJ2omZw0t5x0ADNm7qNQncIURLLDjaUabz60Nq3vK3B654OlmFSPD6BmrcbouL
 ZntIlK0sz8k7l5LQXo2I+Ta6YN8fVs3J0a0g8nHO38vLmVP0o1u9kSEwNBRSh2gCV6GKV
 xh8g+8T3QFodnhcWvaryRXPHsU5HdDJ5KJ56HcHbyHE8vNTPRbF/dLGF+xN0mNPuwq6BH
 sRybnMD9NUmaVmwlNL1fjazaYd2/h9xnj1ks5tvt+Lqh8gSPTYxnUexpOqvLhk7Zyvaem
 nsMtSkPezaNvs355JiBXpBGDXNB/MhZqOGqzFy2t47k5flQnCTMCsmLR5UO2JTq2+iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790167640;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=B2E/zpaOjK6YP/MNcCpQE3Rjtkox3XfD/Yr7X+SR3+M=;
 b=jmmIcgJuiRCMKVC6HytJiS4bfP1E69k3Np0oA7UtxFBGjwL56q3MNeGYsq5LuOxhHswn
 090SdDz80/EzIav/iyY2gP+97mhY9gHFPiX2m4p+bZ9kmcDSM4+EvLQddvdulmdngJa3a
 13HSC3KcBMVkZwSMIYhLxsNCZmVZVDj2+ktHYmXaaCs+ZXxRKjDtHjkCAW9ig4d0FQQxK
 o/szmkqPXM4M3UJiZB0q4fPjFQ2mqfCTjNX7zyY96ILxEpNBTxfTFK/e3YzEd21a50iBm
 B7DIErbO08G9bkOXxLKL6XJy5ISdciJXlwQBqYTo3a6YEziaHQy8I1e0nxv23Y8igzg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B6poAwHK; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B6poAwHK
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88D7040353
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDBE5600AA;
 Wed, 23 Sep 2026 12:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AF91F000FF;
 Wed, 23 Sep 2026 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790167637;
 bh=B2E/zpaOjK6YP/MNcCpQE3Rjtkox3XfD/Yr7X+SR3+M=;
 h=From:Subject:Date:To:Cc;
 b=B6poAwHKFc+G2+3Ot8KTGVLNX477PqQDkxSThxNkE3KGuMqjK2eqRx4HHFD7/OBtq
 zuH9+cdibl6DTENoN28r1+Z8caX0ZTyvHiIK+xxPoqohPkbmVatJkp0rM3O8p7/Xh7
 ij8KIkDx7DCPiX081HbXRbFIH1Tmdx49TXLXIJ/V7/8q02He2/jksbgw0GCjDHcLZF
 AHfQlKAJIY/2awCPIxvtP+kl7TfWa4MjKJWbS1QGe65FAxkrW8TXV47xD2nQRfpMz7
 c9xLRNzHtiFLPgeZrjYSnYzhEZB8W7tuR36LwAg3STEXUoK+lb78B47w85D7V0bQZ8
 gI162azaW58iw==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Date: Wed, 23 Sep 2026 12:46:44 +0000
Message-Id: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQHxXTq5QuYhx1WrSSsSKId
 zfq8lu8t4FQZBJ4ZhtEWlj4NyboRwah92NHyE0yGGVK5YxGpbD2wgFl8oEGnvFrsbKV1q7Mi8Y
 6SOkUqeX12r7et+VffyjM5wv2/QAy5QoUeAAAAA==
X-Change-ID: 20260921-00-basic-spacemit-k3-838119645d39
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=dlan@kernel.org;
 h=from:subject:message-id; bh=VVXhsukzfx38OP+9/f7B2OBEw9VxRMjdHejtwgXQP9U=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs8pAyeIB4ZrpLiascFouAD22Ras5FoG5Y1n9I
 GnilCALdRSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPKQBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3lSA/+LYimLA2ZxFQCZgUhZ8ucnSHVG8jg/R5OBucs0r5EnKqTo9Pge4jvG
 8iCW0cmAWauhDr4o+ZVLoE0Czyhuz7GvawkByHylGtdJTwJ5L5s2k+WBSe9GUldcMAhsM/vmJhm
 rsiBBhBLTFd4gCkZ+/7ZMpN1IWwcwLFEIeA4cJLyaMn4A8c7cGiIiiliDiUTcceGaSdp+tijDZk
 hi1hT+FMaIKrygnkv1IfiuhrWnfEMAqFgHma1jS1lMB80R30ooBwki74AwBd2RUd5voq+A2BHhZ
 thextGuBQQBgV0YMbGDTaH+eez58SisLa5/Oe/H/C0cx6og3NrrRPdXLKxifCKNJTxzh/jL0H8F
 WUwl6KlpazwU52qcjN1EL9JXmkjW17Q+2y1zh3CM6iB/VNRzXk8Z5+QoVfwJRFH6XPF1gILMqry
 xH2LQO3befxkRyIiNYdDtILegep1GbsDmuVExH7EL2xVOTLFR36Z70uhKvwQd5OH7Kk9TtoXrwZ
 lJWfrxdAd39ZVyv//gI7UyPbS4fPeBnbLI2oxNoHry36ii2L91Kn5cnpWsa+i6qlQ1OZrMHrszc
 yPpR/TBSrTUSXb9XOwHs09+hazqp9C+8Dfp5tFD/P6qBvT0CkWWGYdm0+y/H0WWDfjn0uaSvpJ5
 FIea5RJMrwoReqODjiD9to8dto4sK8=
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

Add initial support for SpacemiT K3 Pico-ITX board, the config file
will enable all basic components which make it able to run into U-Boot
serial console.

The series actually depend on previous sent patches, I'm not adding
dependency to this series, but list it here for reference.

Pinctrl:
 https://patch.msgid.link/20260906-pinctrl-v2-1-729da680092c@riscstar.com
 https://patch.msgid.link/20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org

GPIO:
 https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org

clock and reset:
 https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (4):
      board: spacemit: add SpacemiT K3 Pico-ITX
      riscv: dts: spacemit: k3: add binman node
      configs: spacemit: Add K3 default configuration
      doc: spacemit: k3: Add Pico-ITX board

 arch/riscv/Kconfig                       |   5 +
 arch/riscv/cpu/k3/Kconfig                |  18 +++
 arch/riscv/cpu/k3/Makefile               |   5 +
 arch/riscv/cpu/k3/dram.c                 |  29 +++++
 arch/riscv/dts/k3-u-boot.dtsi            |   6 +
 board/spacemit/k3/Kconfig                |  30 +++++
 board/spacemit/k3/MAINTAINERS            |   8 ++
 board/spacemit/k3/Makefile               |   5 +
 board/spacemit/k3/board.c                |   4 +
 configs/spacemit_k3_defconfig            |  50 ++++++++
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
 include/configs/k3.h                     |  13 ++
 13 files changed, 378 insertions(+)
---
base-commit: 9ab84467bbbdf6a9149f6c66664c65b18c7b7f21
change-id: 20260921-00-basic-spacemit-k3-838119645d39

Best regards,
--  
Yixun Lan <dlan@kernel.org>

