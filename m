Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88EBC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7183F60C0A;
	Sat,  5 Sep 2026 09:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElizP2MYRUv4; Sat,  5 Sep 2026 09:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C8FD60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599641;
	b=cplVDrA41UxlNLgqHMF4SwAp/bIZSYp6ORtKYbLEjtqcr2ZwM8+g1N+6fywY1iaDhc/r
	 nggDuXSuU2kiRdsKRfxxHJK9Q9EMnzGmCbsVqQ4L/wGVSE4Jzf1p+ODczlZjn9vdR6EUA
	 +d9UYZLg1eqRsequzieQG4kdMOHWb68wgtr4gtekFuMTKfcNpm4cW2695fRroR/r28xLi
	 LAWg+emqajvpyKSV4NfEPIQKdasEGskmm8bqRad8k4Tj4sbYDWyRRKLEfD7Ocsi5C0Df3
	 b3X1e107gE3IFA0H4H5EB/oQ4ZLvcBp4eqcqgrsPTdG8z5HexBNUYwhPsjLTUHKHXCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
	b=dDzmr8TDyBKZwIWzYOVYv+9RnrbYKb5r15ZfKLoDbujdC3Ua9osWHUEELs0Z1n5gmcZT
	 biw3WCnmSJsk0ryierUEmgsk9px30nmF1u+nl5680a6/8qVSnzPLPk9gMI3K9/ZfItQH/
	 nWRvoitxjgYISt47415Zof3HszKj80GP5qumVNtAIIHSbB4kf9FIyXAFtFVG3UTKa2ox0
	 XG09viWiVZ/3nYKJwuNLDa5C/WLoZrxHCdZrKjnqV7cNtVV2EF+yJaBjk8q38/l+rQwvk
	 zSF/1c+FNoDnkY/HV3OkEpLMqKMMI12Zb3RpJYlx2XljbD2jr3I/6FQktgSLvs0pEGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hUsnND56;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599641;
	bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isToLkAfeITis/hKr7bROkE1T+25/GpMH0v/QgkDY69ur0jeQjuc4gR4W33oHR8sV
	 qgKyhcABdUawdK11+zB41sM62/zzz0019xvafOrX1VxHQN7iF3Ow0Wn28+cNuMYR60
	 zmO6TnyvPA9q23fCU0Xap59fOaBCJzqOAUUtgNJ+Uq3k9JG2X4MlmMe/prR3AIDmm2
	 FJyKhlezDclFckeDGafCxbidx0Kkp1I5dQPvbgWcp9IQ2/Xetb6DBxluDvZDGguo1j
	 qtX9MzA+Vb5QyupsrYtO9AtBC2TKrTLK7yunIkYriwmwdX1zCodQyFtdsfHH0kZqOp
	 rQtSlR/k2rlMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C8FD60621;
	Sat,  5 Sep 2026 09:14:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1250749D
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0470C60621
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Md79ebV_c42 for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AAD060616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599640;
 b=U+7C88MFgsk+7DTiZn9gBjKJH/gMfK4ATqTmIHEi4N3YImDV3PuTr+UMFQ/S9INifWML
 Y/NETZyictXfLlVbXefEi8mLXUqD47wL+Ax/eYYkXpBlo9OZqbSxZZ3lbAakfN+zPtr9w
 JjINCPBDZUl2jmC6GshGUgHs4u2GrVpLlabkY/NpFbjjM+mAgJgMtHj7wS7bRBKsARzGP
 fUsFc5fl5YHcrVK/DqaBfIw9HOkJrmkPpUTzv+QmNxW4AKJUpUF4IDsR5VDObh/Ai/lq+
 8FqFL9vsJrTTHDKE1j6/lT2oSqdjlpiCAcKv2MLA+kbyX3fD8i7VQC0ByhAGCxuzU/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599640;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=J4aEuk8RCTPQ/+If2oWUV7GMBx4MCCZftTvjCgN3GTpqpOVLHDXYUl/+X/tpgOnQHXSg
 uUc7BU8TOTX7IhcBBtKov4ZoetLEOvD5snAgqs/N8yNodc6rJMSJy+NsHgzPy08kb+5sT
 Bml364UoyHoPOV/eEpSgpjVuduiLRPppBb/NHHZeU6Wu2EEznS/9aBxBpXzrJY5MUtJvk
 +N/b1fjGr9HQi6swx3fI3sHzWCfznLX1SttmnVnUQ+q3s2HIm7+t2XqTMrgjovpiVA+/j
 vDd24imZoXhz2vFALllpK9ollRYrKQvasxKS27BSWvUfIUFDKqQgtZa9HbRG3v+laKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hUsnND56; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hUsnND56
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AAD060616
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:59 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1500904a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599638; x=1789204438;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=hUsnND56sMqxI69PAHtiKdjlHqv6aMuuUWkrIskJ8vNUB6lIZ4GWazqtzS9cGi+2Cg
 J1tKPtMhkS7QF00JxQZhlhDZWwV0sFDw4dFs2SpR3+WAxPxl5sZwL3onVdVP2yICjG1I
 rgKOvHJXAKB6LfRh9+4EFu49QnLiENjCKLK9KAu/Ncw4Y+DiZFkB1g0Jt5c1NaeHlhyX
 T4mHGPUGXuTj80gVFobPvtslgUUXGtdgURBu5pjpzDdxCaNYsUAaoaqBg+kDPFcQUhaF
 AcKV/6JqqVUURmQjz8Mn7/AIvfHzL8qwGQIrkDzvwPDexKasrWdMkDR+ZEFHPnvwjAC5
 +qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599638; x=1789204438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDB1BNQWzhg8NOU1aLVoDPHg5S1VfIFvjI2+335xO2E=;
 b=GZpS3dEBmAmbeAp7O4wUuKxBuRf1MnUT36egk9VXXG6tQpZXzdrhNKP1MqZZAXfyIb
 uPdZ0NmOxXn2bW7Nk+dRwYcPuUROPhCeoPZWaCoa1LxCHhRsbdb9xVzeC14j/pkJhFM7
 bUAee+Ld2mBYiQajqPxPb3pVjWHjVyW5XxoYzDQOU3tw15gA62UxgIa9KdX1qHNQ/4mK
 JjlJKwanePspwxjUh88XVulyag78BOcDJhgQhFpZtkZMC7z2lDslsealVuhb877oBoNU
 4B0jjwg4iRLZalJkVqBdXzJtp17DLffR9++eLSFqOGfz3l5V/5vb/5G7jSFeCQZT4UAu
 ciTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3xFS1Vj8bp4Q4MmmAZUYImdUF4x/UU9ye7jq4ymLtOMFK+X3CGKijxde7F+gXaTiA4U6iS5Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mJBMtPgDYh76U9nID9wstuOWAwrqN6YXFT0NisvMBQV7aP08rT
 d9H4xKVx1gt64Rp2WOPU5nVcdDh9KuoNW0dES1rWr62B7pCO5/NEi5QmJpHMkdh46Tc=
X-Gm-Gg: AYBFou1xHl57iYgCs+udrZBMjW7rYPaJJg1hcBp1Aejc575W7CLkJJrTGutGm36ZC/2
 rD8+wonaP8sFWiyjhGnc7eKfpyXed3eazLLLmcvSRt5JTnbpg7sNSX2haMqr8eQgp+MXJ3/B7hL
 5Vrd5IG8k88UnIjKoZGFTkiVmOi9kbVneWSN5TlNLQR9CcdWh/NOiViYLk6Ge+zdhsuIhHSbnCj
 ok5yP5GczhcEx94RiLFpPXTrQcD0sM5GOvCFSQhORv+z+cubk0tBwtc4+bBbfTKi74hwks+Hehq
 GgzD+dWyVU6XK5m9YoqOE66iFYceLZF3s4NSaZYXZ8qCoZdkhJ03N74FBEsOdUSXU6YGG7s1C/2
 D/b6rsLI7s2aiYy/E8clhT57z7U2lxV9gf8BgwLkcrhnH8X1blEUGM5g1wHxkC5vjyghvHcZYtX
 sAWuEl85eL/lEI/elQjFb7hqE0OZZRXU6j6EDwVllsf7tiYMIRfLjsDiu9T25Pp0Or/MWm6UMsg
 8pJXMMI3Gpcw/Gtn/PqVsw6/kJFdWDOEYUVj5PEyuEAw9/KlWA0xp5GPcyRxmM/ojdrllt3x1Hi
 NcoWKWu0MxrZv4o154lYET95amXClHbEBOao
X-Received: by 2002:a17:90b:4fc5:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-39b26190c25mr17737321a91.6.1788599638527; 
 Sat, 05 Sep 2026 02:13:58 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:13:58 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:16 +0800
Subject: [PATCH v11 03/17] riscv: dts: spacemit: define a SPI controller node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-3-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15.2
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

From: Alex Elder <elder@riscstar.com>

Define a node for the fourth SoC SPI controller (number 3) on the
SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Reviewed-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Link: https://lore.kernel.org/r/20260502-spi-spacemit-k1-v10-3-f412e1ae8a34@riscstar.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: c580774185426ea316396b1dc3f1737a3ad3800a ]

(cherry picked from commit 2eec5923556990fcd34c88c549dd11a5843d7fce)
---
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  7 +++++++
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    | 20 ++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1.dtsi            | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
index 5790d927b93d..9429189354d6 100644
--- a/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
 	};
@@ -335,6 +336,12 @@
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
index b13dcb10f4d6..34d88334e95e 100644
--- a/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi
@@ -570,4 +570,24 @@
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/dts/upstream/src/riscv/spacemit/k1.dtsi b/dts/upstream/src/riscv/spacemit/k1.dtsi
index f0bad6855c97..f8747190d2e1 100644
--- a/dts/upstream/src/riscv/spacemit/k1.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k1.dtsi
@@ -983,6 +983,21 @@
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>, <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 

-- 
2.51.0

