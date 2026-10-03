Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9586DCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 00:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AB8740D98;
	Sat,  3 Oct 2026 00:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKObkG6WE0ws; Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4398640D1C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790987727;
	b=UV0FupbppGWXrxfcEbLKCqoBi8X3Z7bb8tzf8XuaOVp34LoWa8BsN4LfgfGI9bnlMlW4
	 1xI+XXNe8e0kgMNFzgQDoA661wQfhcOajAuhplaHdjBvtnrhvudY4oowl0Ex2wvQ9R/Ri
	 27/c5yvDOKviK+foHlHMhOLHB+itUXGfGmE7LaE6q+VQxfLTWvP58CzdtcD1KoLYJzGUD
	 hFLD5he2KdcZMWjWwBh7AwUw+c3YB7pUvQdw9ZyGMPQZAsRTl2JGgvrMg0ourHtNp2eo9
	 Icrr9wSBR/o62RJfm1xlUwcGkMJhqsz5ID+tbOwKlzwG0DHgRhKBH0HIWne6fRq3cBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790987727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CE7/iC3Y5JHpVMNrxmPBSXNAWc+6UJ+2ujhtsGDg/to=;
	b=WGkPsn67oyWj0EOLfmTP3VSULxM4/S79sLBxDSeysesEzOGUnPC5uYH6YqCnJ4n4+1qH
	 ltOGrHYZPK5ChCVPfgf8ejwpDu/JpzKiIhPXRlTM5x10wQ/yFRHACEfdAqdsrE33U9R/p
	 6zCfSQGdp2JDm0sKtQDuXsV5tEJKM/nQ2nKrJz/8XkEVflsZBT/LbriDe3WmiogEmQ6NQ
	 mKIWUhlDMISrYcl2MiCoFysD5ulSgi9i030HRgIv1sp/JX8SzSj6REa85WOgdlEgW0BD+
	 8DN66PaTHgbr7MS7anVfiFoONEyEAYFQ0c1N0Gz4zNpjeKhl4To9K25T3340uGHQHdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDK9S1Bb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790987727;
	bh=CE7/iC3Y5JHpVMNrxmPBSXNAWc+6UJ+2ujhtsGDg/to=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fh0fVa0NvMggt2qJQW3vb7YSgEPvcBb7YwUwMCUYUhdG4Z5G8RgsRPnabg0CzwTix
	 5KNpIo0pHtvkNZMU0wleeZW25dvcmv+zkgIYT/OHVgqqowrFwdFDdL6xjcbaqQW0Pp
	 UlvqpbRCMrQy5VZ8dmG8c25S/lGq0iA+B1898MeD2EbK3fSPao/p5IrfnhXvrf4QDo
	 8D08TfsNpn5f21GnnyBpGFeXyOeEmtTgYt4hFp6uzDXfYA3zAzWlpUo971QqwDmSar
	 LjJ8KyM3OT7OucNbBuAHbfMs0u4AEvi4fjU00aNW95I1mgA7sJx/DFEoVIqFERaVus
	 FAf7KKuGP/9sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4398640D1C;
	Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B8A2E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FCE040D01
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubS3JY4oqR8n for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 00:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 097BF40CC5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790987724;
 b=qwpILaF/X37AtSWUDK+6KAKZRobedFKvBv24cmjYu1HVwT9nWdLUsCmgn6UAcUKb5PGf
 BRq0nMJaXfn8IXtxREzOpItBYW9EptgIXNpIjwjtkQBLXhOdFHylayeY4YTnDJzlkRl9Q
 SI5DLhUG6gj7cZH5M4xcUhJiFPReVIn9Xc4pXbeaufDTwTzBSGoDJLGjebbYzUZdV/ip+
 lsamPXPPa6SosQLp3O54ohqSZ9O2FAajK/dadSassPU1NI1zx58Rnq8JluYc5yhG/Jvlo
 uYryVnzETnGAQDIbaRjnOdxItDjSIJCTZP+1gXKN0/OHWvGXmR4tXHCIkoJ9OaeNvjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790987724;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=CE7/iC3Y5JHpVMNrxmPBSXNAWc+6UJ+2ujhtsGDg/to=;
 b=dVljI2d9XQlvzBUdkUup2I6inpyYcmOZyP1wQX0AAAPt4aqRDSzyW6kVw3ou/a8Gq7vg
 dlBsZJjzfSS/AF2+slP6jaOn5FAxPcBNPbNtLPxA/7VHZQEv5lt3WD7fvW/8th4XHPit6
 TwZR9LwZqBDDwD5JxXpy535WBJ9yH6YrTCJaWEfETaLkI0xss/ZJeIdbqyY9A0LldHXFI
 TrLshD4MBAMNKOq2zHFQykw2sdhFNxYezQ1zZWS42FGMQ1dWCbP9DMWxJcxkeh014IVH0
 jYm+cDtC0dGsPIsDPuokRPdxcG7eaUm6p4s/JrK9pjosdjVy+vqhBDYneNzgJvSd6zA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YDK9S1Bb; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YDK9S1Bb
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 097BF40CC5
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D9F360A97;
 Sat,  3 Oct 2026 00:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D76A1F000FF;
 Sat,  3 Oct 2026 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790987721;
 bh=CE7/iC3Y5JHpVMNrxmPBSXNAWc+6UJ+2ujhtsGDg/to=;
 h=From:Subject:Date:To:Cc;
 b=YDK9S1Bb1xb0Yzg80PCfV3z+zrNzFeLGZJYbBeD8/mnIir+EFC+bB9pEVZhqd94xk
 mQ0KQ926abgYY6snLIK5Gsiohsu10O+n/mppQNLwKDDudhR/gzYx3pgTy1SNX9x2O3
 o6dF2kBX7lY5Zr7wdTvnBywdR4Fvr5jOMvizcichaw+FhC2Vv0f9hz0NRWCGPvZR7O
 uMgZJgH6PXBNfAY+ceeGraiKOXkfsQFIsgmeRrfFeob5RBEYFjILKmzXHweYlZYmbO
 ofB8o0TrXXXvZp+H5aKLXceTRNAhTPjcVIfTU6sPZp+Ate4SeKVTUH0YhSJDXUSFM/
 ZqlZB9jcdLsBg==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v3 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Date: Sat, 03 Oct 2026 00:34:38 +0000
Message-Id: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNywrCMBQFf6VkbSQ3sS9X/oe4SJPbNlbbktSgl
 P67SUVB0OXAOTMzcWgNOrJPZmLRG2eGPoDYJES1sm+QGh2YcMYzVnKgjNFKOqOoG6XCq5loJ2g
 hCoAy26ValCRcR4u1ua/a4+nF7ladUU3RFRetcdNgH2vXQ9y9E+J3woc0rSUwSGuuNFSHDm2Pl
 +1gGxIbnn8swBj/Y+HRorM8LyUTkKsvy7IsT+biKEMRAQAA
X-Change-ID: 20260921-00-basic-spacemit-k3-838119645d39
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=dlan@kernel.org;
 h=from:subject:message-id; bh=MuFmlIxpcvVq+nhCNQBv3HO6DclI5ejiKTagB/NszWM=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqwE2mNbeXbuxlSLNjjxQFfZA/1tWmVDyezn5J1
 X6bSG9lPfSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasBNphsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1hpA/7Blfhr2WA2/YpR1uKuxxAnYMr5hI403WZz95I6jWEjZeNKikyQMKhl
 VODhOJ8svP8wf5yIJpacWx+Q2YXfbjR1arWrvd8r7lgO0n1k3jqQ4YoibJH2qA4epiHUbvg46Zs
 3YB8Cheocqsa2Ff9Y3huCpRcQ9mDmu/bCQ5OOhhnwiLwkgs7QOSamYbBW2OFXF3aw9ycPI47XiP
 SIAxrGbE/ikPXgb6cAjXBkGKfO1t/Pdm2TMaF7t4PibWQ7cCqO4SaPhHml/KcPf8wc22aKb5Zc0
 osU744n7jkKACQVBk/FKNO3+bzwrNO3MqCkUKWjjb5ZPYzGysz6sRRrkwcafQRnFSBdscujRLMm
 ye+2m1N7DDuNU4lNC35xza79TtDM/Uq9y4itZTEJ5YQHHOVnGUVSwu0oon8MbeX1o7XDBI7HS/h
 iMYd9ySmnUFfGLz7saUVbKO5eAcLDctKMRhTLC94eULJKpLqZ90Xg3c57uhilbIsXccjehh/eF2
 EQnmoYS6u+VnLiZZsVjwdZa3T59XryGS28qCbW//0qlrwpF0lOiAazmQgDIvc62tT1EnDgX1Ids
 jIwi2AFkH4tIZSDsDpZR6iN19xH86L7e5M8JBMWOShkzHkSS+vC9YFjBy22n7kiJe4a7FPrHszH
 21JJMLUy4dFlxt4j4I+b9CoOiGsYFc=
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
 https://patch.msgid.link/20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org

GPIO:
 https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org

clock and reset:
 https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v3:
- rename header and dtsi file with vendor prefix
- Link to v2: https://patch.msgid.link/20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org

Changes in v2:
- drop board_get_usable_ram_top()
- drop empty source file
- Link to v1: https://patch.msgid.link/20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org

---
Yixun Lan (4):
      board: spacemit: add SpacemiT K3 Pico-ITX
      riscv: dts: spacemit: k3: add binman node
      configs: spacemit: Add K3 default configuration
      doc: spacemit: k3: Add Pico-ITX board

 arch/riscv/Kconfig                       |   5 +
 arch/riscv/cpu/k3/Kconfig                |  18 +++
 arch/riscv/cpu/k3/Makefile               |   5 +
 arch/riscv/cpu/k3/dram.c                 |  21 ++++
 arch/riscv/dts/spacemit-k3-u-boot.dtsi   |   6 +
 board/spacemit/k3/Kconfig                |  30 +++++
 board/spacemit/k3/MAINTAINERS            |   8 ++
 configs/spacemit_k3_defconfig            |  51 ++++++++
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
 include/configs/spacemit-k3.h            |  13 ++
 11 files changed, 362 insertions(+)
---
base-commit: cf615aafae36fc49f55e3e6a3648d29201b26d51
change-id: 20260921-00-basic-spacemit-k3-838119645d39

Best regards,
--  
Yixun Lan <dlan@kernel.org>

