Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED55C79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 08:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E15BF40528;
	Tue,  8 Sep 2026 08:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKVviCvQHOxB; Tue,  8 Sep 2026 08:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D6F8140517
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788857185;
	b=Vjofbdp58aX95VVSetdKG+QtrDbgQzZwQrM63RVoOdh9ZI45qdDY8NTRW4GQDDANCCJV
	 qIrM5YWhgrTI2azP7TuOLkMJeurNGDUvWNdqCszNa3iyjqAp49tAX/OkogfcZMxa8JJiu
	 bWIl7rFgX1CqjmdNdWamOaTGMV7MLr0abdyAnzPYDsGEBRkn4AaAhqq6R10rmYsWUtyxZ
	 VlRmIm0a2dZq7P+5+BWSeT1GDkWT/Twu2gVJuINVb1Dm85f0jAInSaS4/ej10TZwh37vX
	 +Y5Kmk1Z36dHjPkvLs3IDgys0Tw+Afc9fl8fBiSrZwdJ2UlOUSkkkMWmVkYNNjqIcFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788857185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Nd39XRZ8Yqljg3UQfvbRs5Es9ECvqbLUAQRbuNIcxs4=;
	b=Tlic809VkgO0RgvyE8PZUMUbRq4DhEqpInY2tdWSKgzuurQmIwHtY9xasnhhV4C4XASZ
	 HaSxnT/IXMWIayEso4j/mZK7CzY9gf2KTtpA9DCQgq7See9M09vVufG1NS0Gkk7KbrXK1
	 +nd+qltUdiZinGqbZ2opWFrrgCncYFhEyPF3J8klbhTfeKjd0fBeqfkEhIL5K0v+IEc5I
	 RZd2LnbAkvKG5163kktSkKY+CInLTIFbr/EFJS2oHLJKDSVMv9sE3VL4vFgbPbJkWu+B6
	 zN8fObMoa4lzF5+r56K7sEvqlA48+oR0PngmC0Z9WNhBWdxZaHND38NFRYXfi31HZuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK7Hdsmp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788857185;
	bh=Nd39XRZ8Yqljg3UQfvbRs5Es9ECvqbLUAQRbuNIcxs4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mX9eTsNS4ix5s9O5kIdBmD/vK24AVTEcy2ixebeE/CFtoz9hiHVZ0NOaK94QxPcFc
	 kfa6EjRGJ5Uhly6snjsZZAmehRqTLOZLAyB85nZIYM39DUbHhUch37MjYojKjLM68U
	 AdDfmRLtglFRwgRxeo7pTIXHbNY/fhzss7lK+wghxftSJprUxzsvJoykVczQR0fQaW
	 nmdMnXbyM6GQrGvGSGC9mIbFtLkjK349YYGSX3qgCsscFSWD9/aNItc+5egujbthnb
	 fflyD46JVoHAAS/a1I5VogXAPCx+6uUzecUeGyJizdI2Lj5RPYnwrhWIzMinnTlyqz
	 n9SHzSEOHfB+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6F8140517;
	Tue,  8 Sep 2026 08:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 095DA72C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE98E40517
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hileFZQpqcSA for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 08:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2C07D40513
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788857183;
 b=RWR0JjWP+DxlPVxspTbqd/C1sK1dQe+Jw8Ex2pJk9irrwz5HkSXH2c7nAyexDajLcPki
 61nceFQtJneREiQbqYfV9vOQSJzx96bG7adq62rrrOkn76AoiC5oOxmh9zTyH+KKtaCbz
 fnF1x2TNuwoCDoRaEAwHJ5Ls8pOeFe29CsPjWyf8Xn+su9NFASs5cTsFwBERMXwUOsRG2
 XTayDVhy91mUwgcW5E2U7/2hJogCAhsjprs/PbmdJbg11iSnPNayEZbA+Zxui+oJc2rFi
 fpMU0adsoZG6itsch0sxR/9MNPKyCN25RHNRH+ot1xlWPE3rAeQr/URngEmVqpnAZ/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788857183;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Nd39XRZ8Yqljg3UQfvbRs5Es9ECvqbLUAQRbuNIcxs4=;
 b=mL7KVGGzDvKqXyGxnbgEMVPuD6GJ5+EqwzhMsJY8GdjoTMoXdj925VAK/QiDW0bpb2jq
 kwh8EFNKCnULPeNYY4y7nS50/wNeJ92Z8YU9nB0XKfB86YO1KO1vZV5pu4iP2HxOmYBWI
 g3GRLxcwP8zsHR0yBZ4he/fhQGXBagLiskNagTGxlL2Oo3mvQPoplyPqhEUnpTQw12Kfn
 TeeFWDvbISF7f5g1ZNG5whn39dyIZEuF+x5TngAEU8k02HsuUXDwhN/p3WTuk8jLOkq/R
 7S9CkZUZRL1MqtlzmmII3yBRhLghE66R1riAXwxoc9FiT6H9Atf9rQ7l4OTrnvnDXWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bK7Hdsmp; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bK7Hdsmp
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C07D40513
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 08:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BB4E4033A;
 Tue,  8 Sep 2026 08:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DBE1F00A3A;
 Tue,  8 Sep 2026 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788857181;
 bh=Nd39XRZ8Yqljg3UQfvbRs5Es9ECvqbLUAQRbuNIcxs4=;
 h=From:Date:Subject:To:Cc;
 b=bK7HdsmpLBmsAt43BgTlObDpl1ZT+hngM3v7jEuqzvFiGaX1mleAWaBYnpymL33FW
 HnQu7CZeJcJdgLULtniN0sLdeD+7Jrnk2J1rbuy79C1qc1CW2uB1H4dhOvxfVMmGk6
 qnBE6FXdXWZBAdzm4omcYhfWcBNz/S8edbafuBTmuknfybZbYXCcclk82YSnqwRYkm
 Y+EB+itrUJaaozg37GqyXD6YVuuIfYzLdZM3rwcRKRWsUmjyCZpsP5PiuaM8KZBzf0
 jQJvE7dOKtfB5UJSGzxRJSzibJbUj3ancBYcorGe3h+AYCSuYlQGy3Rt3rqehJfdRd
 W2CirSqpbeupw==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 08 Sep 2026 08:46:13 +0000
Subject: [PATCH] MAINTAINERS: add new SpacemiT custodians
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFTLn2oC/yXMQQqDMBBA0avIrDswBqtpr1JcpMmoU2iUTCwF8
 e5NdfkW/2+gnIQV7tUGiT+iMseC+lKBn1wcGSUUgyHT0o1aJEIXAuriPL8lo181z0FcRK5tY41
 lc+0aKP2SeJDv8X70p3V9vtjn/xD2/Qeg7iIqfQAAAA==
X-Change-ID: 20260906-00-add-spacemit-custodian-e184828e2574
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, E Shattow <e@freeshell.de>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=dlan@kernel.org;
 h=from:subject:message-id; bh=2rUlPjQHldculuvLgSy16Q8ffENUjDuJ6meDrp/1p74=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqn8tXldb8zQc6c3SO4qq82Kca0yj3MUb3qoBkY
 OjaLxOXv0yJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCap/LVxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1SfQ//f54U1IUat6VyUb5pK/vHHTxcHXe36l0EKWFh7xmZE/wCkGEms0BBg
 nPYuzXMmNiU6qckxxSguRYoaxrRSD2PcddP4FL243Rz8zgJ7boe3n2As2yluDpxfImLa6pBGFzE
 SQm4l6e/CgHB5rZTM70daEpwYgaPqSJ4+nmsgh5aaoEaw0m1qTf3m3W8kMtQVdGQ5y/BcW8JREs
 31RmQfZ/c3gO0EgQksYrQx6r3zEQUhxlt4h38lpLoBFnReOiMxgN9Kt0/IxKzpQ2P5E52d0TPOL
 cXB2GVJ81yjxzQONpUiF107E/OEXxm+klFaxIYpC6//adkysg7Z3Y24P9QA0cgdMC2kljPysFb8
 gE9FdPXybw7FxLPY8U/CH7qW3QXwCDfZkRpT9lZi7WfRcLPrudxrGN1mE4r5aq9ChbTx1Bw6uAY
 m2bfq6L7qXwblsDmhaxwXZWkh7ZuuB9DZfBkyfvSzPfDxFK3bmcJbXrQHfO22RjenAUbmGax43p
 /QKeeJWFMPjAh0puMi+brdoKAuu7M2gWfS3WM1xOFUmeqED/AZeWwwjW9yqXs5AwyumR6tTRWIc
 8+5b8l2vgMQZgw3wg596Ps9mCfKatV4jKnT7x6I2+Rds69pszNCnJcf3x3yIHavnP3E1SQ66KBj
 x1ngk9eyMotm/ky2M8w7mj9jpbcH0k=
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

Introduce SpacemiT custodians and document custodian's git
repository and management information in the MAINTAINERS file.

I will do some u-boot development for SpacemiT K3 SoC, and also
help to review and test patches of K1 SoC. The idea of having
a separate tree from RISC-V realm is to better handle SpacemiT's
patches which not all RISC-V related, and have better dedicated
CI testing, also off-load some burden from RISC-V maintainers.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b3a9ac1f2a..1bbdcc8741b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1529,6 +1529,14 @@ F:	drivers/clk/clk_k210.c
 F:	drivers/pinctrl/pinctrl-k210.c
 F:	include/k210/
 
+RISC-V SPACEMIT
+M:	Yixun Lan <dlan@kernel.org>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git
+F:	arch/riscv/dts/k1-*-u-boot.dtsi
+N:	spacemit
+K:	spacemit
+
 RISC-V T-HEAD TH1520
 M:	Yao Zi <me@ziyao.cc>
 S:	Maintained

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260906-00-add-spacemit-custodian-e184828e2574

Best regards,
--  
Yixun Lan <dlan@kernel.org>

