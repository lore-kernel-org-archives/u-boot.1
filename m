Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0C606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b6SsSM7T;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hy7zB6Qr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2916281589;
	Sat,  7 Nov 2026 14:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29_XwhPwzO9m; Sat,  7 Nov 2026 14:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76338815CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062011;
	b=r/AP4HkQyugTvhaSDbtQRK9WR9YWNw8dIeWq6rMAiEO6RAkIsAuYb78RXj0ao/7NJ7TX
	 7tRLYMqT1U7ztn172S6dhz4P4yhQrysOf34wcYwTMSnB3tgwCDOYoI6LTAmaOtr4kWOfz
	 WWxOv+CEyQQJUVWi/3uwbGiMqdXF7Tf4ImiF38sOdU7sirlDDaBO507IvObQl/98Xv5ad
	 wsdw5JvD1D8qNsY9RmGGqpNE1wTVpWWLCKfFX1fgWMSCyDTzThQUItFjJEF6ax1L6CvPD
	 1mO4x6cgYm2Aa4FbbEqM3ALPe8b6S2h5C61qONV7eE/gEhTUQ6IkLWbEcgvNTeR6rLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oxzdIbNMiruQbzBl/L+GqJDFRIG3v3UUfp9diZUrV4U=;
	b=olqK7Cza0/VMXOHPexPO7DJgKHm25GmBZLhEcFQhkaU6e8smn1oqQwu4fEVS+D2VlqqE
	 pnLC1I3zJIc5mk3aWHzJ9KFRbDyQuO69Hb9igs/cGYnATijKYxmQpMC7jusviljnO3x4R
	 uV1AjriiMc9VyXQi1W7sUQczhrJZ3QykwG54SxpB55VQj6PXhTHzx6Z/TxYK17BdMuvX7
	 7VNsF1y1oMLwjTLpah6pqdXQSmRJEAmKiYPWGNWWWlFnk9Qvctwhz+uO0usvIUcSdq7qM
	 QxXbKJnRLZYTw4/9Yjju5o7apOh+hoHZjnT5CzcVPlhgq7oaTmUEXqBoKcuYkyEfnPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062011;
	bh=oxzdIbNMiruQbzBl/L+GqJDFRIG3v3UUfp9diZUrV4U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b6SsSM7TjreScXh1IsbhZO0ytkWdolZVJLiePRUDbHM1GZ0QgfBO2RgdErfaNyFZ2
	 LdshPQAe1aMRuCjUZHLmFK39INw6d+HFSw9eJjpBPzc/XCWbSJtP0BbzDmNhV+Oa3g
	 qx3W38oBTKby5C7SZXOJwYtg7hO3AUtRTvK+vbXPhVk+4OC73/wf6x0h0IFPzzfDiX
	 Ruph2m/NLjgntRGDEn+PntzD1VCxqbw/8Le/ybxNTVrzZEpnz1mlFzl6dg8jznPwXT
	 bo25OujZ7lBc5JPCjMkVpxuIlY44EOqbq8bI1f3OAtUDZf5m+xfjEDVFeaMPjYAhD6
	 bCwAJi/hwCeoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76338815CF;
	Sat,  7 Nov 2026 14:33:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D45B5211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA75640785
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkNvT7FxGwCR for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFF8E40761
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hy7zB6Qr
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AFF8E40761
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:58 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ab30d04674so1870131fa.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794061496; x=1794666296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oxzdIbNMiruQbzBl/L+GqJDFRIG3v3UUfp9diZUrV4U=;
 b=hy7zB6QrkTk53NOf8CZB3aCgUwDqjz4KzoMT+RxDDVu9+Mf/JbmT+A7G1/+X8Icbhq
 +u1iwR78CHVVrC09X5ikrmuM7Sbqwk1cOy20wWW8jLUhsTUn086z4wtWO4wHMnfkeBRT
 /aPdcYMDR2Vm40vWOiBbeOs/8efDurHtJFLc+lNph9P1+dDY//8hut4E3FQt3hTxlYCB
 740y7hozBGpM3rYXWLdVTzeljSykByxnhi7tIHoHtw4U9Yh+4lhA1sH76CC6hn0lBPw4
 shWuQImX/uaAA1R8xXUcCt7yEx6mGFKo4weJcLH0u7ChYQUfWamoCTEPb7SIybvceNVv
 aJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061496; x=1794666296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oxzdIbNMiruQbzBl/L+GqJDFRIG3v3UUfp9diZUrV4U=;
 b=TtWvMnniK5O9XoQyDwTZpWzLpZrIeFaNAIaHnhaimnfr4NfsvJGKsmPVcja70fX8g5
 eiQ9/Z6LaNpe+JV0ojJzwtZ89ogBVFQ4AzUjchuajeQ79X442SSNyVB+oqiGaUxSuUXt
 NCn8l/ugkQ4xuvf8pYXgwN3v3Xj25xOqCnzTJwmPXMPk4UvEEXKaTXqg9ISzEt3NeqVG
 mNrF4Gn23WNidFdJIZ5LhP1qayC/yWYxyfHvkt3B+jk8FdVBbY+QHTRn79eNAR8Yi/ay
 tpu6PIOHptpLA8DzunbtKSDmwKYXsHhY3v1oo/hRmvlYBP9jeMd1HDqMpaeDFg6K24rx
 z2ag==
X-Gm-Message-State: APuU4Z8oU23ad9WgjMti1kO58Dyhk03ARN6d0XzBRBsILBIL+ToCdSVh
 ckIAOWYenb4S125I8qePAmN502eVimEIsdeaRK3u5vO2X709vkBXZhhNtXsItyqUdij9AJYb
X-Gm-Gg: AYBFou30LhvC4F+j57FNwwRR7J0CMr0VJ3TJ08eUp+bXxBO0g/37etjV19ji5KsgMRl
 ngfR0yYto41CRlllnetoOgFz/IfXWxi3fJITCZ0EP1VEbBDO3HIzX168bSDkEzjMnYY5o9jCJuU
 SFCKFD5fEkBbeomSN0RulFSkD5drCQpyRrZqp5N7odzUCWTDjsTB55AXNL/tAZUW9t/iekYuXuf
 8RILr3XJQwOmXaQu3E+UXkDcf9E4dYPnXoisbbgiIS3vaiiE0IrIEdZFMRwGpjzS/QkAXdRmzLS
 9WBtMdVHDGZZZBl9rS2hopRDfj4NZJdc9Gl9d+ct9N99W+Ga02hs15ZD3nywTnJeE7foP+LiAiE
 DOvTncNFtJ4KuvQo1IsMueRAyA1hY6cOYBsRGMOlMBD2FtuWDjAmEkmnn9mIG7ZMax8BPkxpQ1U
 UcSJrOnyMGHTH5if+sdGiAvZWfgdI67ZEG3E6khNGBmlr87F3CN4JnPJNTSXH+FuVX60+MhNQI/
 sP6DjczgU3gS9NyPfXHpSsYFXy79ZIVCXHUbKZZEhaGxvMHdUDYcM9P7KCQ2pgoI2qTRwqL4DqS
 JlUW+UDpSDqE/oFgni355Z56pCJjNb7AuZL2kXA=
X-Received: by 2002:a2e:9686:0:b0:3ac:e62e:ce93 with SMTP id
 38308e7fff4ca-3acf39f2b1amr8674901fa.1.1794061495868; 
 Sat, 07 Nov 2026 06:24:55 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acf60c9cf4sm7125971fa.36.2026.11.07.06.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:24:55 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v1 0/3] net: mtk_eth: an8855: fix packet loss and sync with
 Linux
Date: Sat,  7 Nov 2026 17:24:37 +0300
Message-ID: <20261107142441.2104669-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:33:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series aligns the U-Boot Airoha AN8855 switch initialization
code with the upstream Linux DSA driver
(drivers/net/dsa/airoha/an8855.c), fixing several register configuration
bugs and improving overall signal integrity.

The current default U-Boot configuration leaves the SerDes with marginal
drive characteristics. On some hardware iterations, this results in
severe packet loss (50-60%) and timeouts during TFTP recovery. This drop
occurs because of marginal signal integrity on the internal 2500Base-X
link connecting the switch to the CPU.

By correcting a bitwise shift overlap, enabling link error recovery, and
applying the proper TX FIR / RX CDR analog tuning parameters used in
Linux, this series ensures a stable physical link between the CPU and
switch across different boards.

These changes have been run-tested on the CMCC RAX3000ME and Xiaomi
AX3000T, both featuring the AN8855 switch, confirming stable network
operation and reliable gigabit TFTP recovery.

Patch summary:
- Patch 1 fixes a bitwise collision bug in the AN8855_RX_CTRL_8 register
  that was accidentally overwriting previously set bits.
- Patch 2 enables graceful link error recovery in AN8855_RX_CTRL_26
  instead of explicitly disabling it.
- Patch 3 ports the SerDes analog tuning parameters (TX Eye and RX
  Jitter Tolerance) from Linux, resolving the packet loss issue on the
  internal 2.5G CPU port.

Mikhail Zhilkin (3):
  net: mtk_eth: an8855: fix bitwise collision in RX_CTRL_8 register
  net: mtk_eth: an8855: enable link error recovery
  net: mtk_eth: an8855: sync SerDes analog tuning with Linux driver

 drivers/net/mtk_eth/an8855.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.53.0

