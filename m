Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F0606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S9BVe1NW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mVBfPy5i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6446280F27;
	Sun, 25 Oct 2026 14:30:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnfZBnRQF9E0; Sun, 25 Oct 2026 14:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26DFD80F33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792938647;
	b=IQ2QzBaliLMkwsQEIddKZ8hzYRhPBu+T7iqBsE/7eAAURLeHRBFDx55SEbrvJRoElhTR
	 Oba/9ashZWK77BK/teaKD2cFBB283uDPSI/ycvkpArsXVZk3bduVlcY8mASaC1mzFtmPO
	 WoXMGHmh/Qa2mKpxETUbdDAH9jIgAZzepbNdFFLXQRFV3Y4lcTVqai0aOGsQ4BvfxPMU0
	 l7UIrvRt+o/1iYnfcRjyH2s0A9R/c1tKRBPMyj9Speq49GDX8NsCEIhZeiRO6QzwBKUab
	 hk4UZkv8hBd9mBtm+LAHmtBEBMGyVu7fGsleEkWwzEam39+kqf3BPLNHKlFm2OZrpOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792938647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XH7GXEvrA2/9F0Rjf+uiCdCPpvtcS1lOOj5WI7IMzpo=;
	b=ZOfflOtbY3xTLgnsWh4vqTLNANA63xYUH8uS5MjPUxlQcR0Xy6s8m8XMSlpL1sBmBslV
	 QfXrMFx2bgHYPwll/F9QzRKXTSW7IFZqqU3+ZiAI1bTQVPrcJK4nSzSny9acEfABkhrOM
	 MRc8zzxD/Xj2u2y/Ks4kucdt8+q9deqXyCrGWlY2clLz2qTUXWk2ul/T0Ggefp011hVg1
	 5rCN83vrtybb30AH64H8fCfmIsQj+WLvbq/G4GnsskXdU6WBo4kAcP4X48BusE4UE4rua
	 X7gqAlJlJWfAo2pAGu/oqHSvloXi9HRmBRWSiCiL7KN7QuSkaQKJ/C7w6jJF6L7LlFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792938647;
	bh=XH7GXEvrA2/9F0Rjf+uiCdCPpvtcS1lOOj5WI7IMzpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9BVe1NWExXVmZV8ZNpniO3Wx6vKtaoQDqSfLta0NvnkEABAe+pW6J5Ea1f1h/3mQ
	 VpFRrQO/gORghJKH4xxmriG59ZV8+dcmqSkdhrvN3qRvc8Xrl0z2wpwlTK2ZRKoLBr
	 kUAU6yKburaAIbh+uJUxuBb6scfxKubSpe320kUNwh6qsLHIoHkywZa56L/Ht4Xxq/
	 6SUTL1h8Jah3bdLaExQ3ODcM96ew5oQwMJXS6nlwH1HweFfnUC8EG3+2CSD9BpmMHr
	 O9dI7YHy9Me6QA6Zfhz35KMvNSfUhXdh33n6w3aAdwTnVnROaX6+g68cY2Yb/FI5Dt
	 ZroOWiT5vJ+Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26DFD80F33;
	Sun, 25 Oct 2026 14:30:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AC133AF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C4F2407E3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqF3ONCLoVqy for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 14:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EC03940FC2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792938644;
 b=rldHt/5sAcpHJ/YpZlRFr+HWGig07ZCj5ACfZrLRHinW+wvBLqvvtdIvq2bf2S9xFOrE
 bAN52iAFqnLcjBkZU1Oq2yOal1JvBHeAZO7HIm1XnJh/HT1qDiZD2WUJQS8WeSKscW8Gh
 N9LTQyxqUFAly1yg6FzIhR6Wx+1fm23mLD/q2TEAFHza/c8aGLT6pCyxY/ctZoNhuLkDs
 LgNqkdbKSRc4i2t3hxoq0WOeNK6g4AgPDZccmOGq9ZIL4N4ovr/WA/kOmdKroCXIAOSnF
 PUDBZWHD1WEtOetM4tLcnGbghBV2ScSvCHeWJFndZ48CUBZ6myVWybkx6XzVv3xHFiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792938644;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=XH7GXEvrA2/9F0Rjf+uiCdCPpvtcS1lOOj5WI7IMzpo=;
 b=FZnei1VnkqQgmvknn9C9oWrvUtCE34fLpI0NlzPHkII19LPDfV7O5qyqbpW7l1bcwA+v
 g4JwiJyPTf9Omu5p3p1WanHA2tGO+urnDY7hjaCeEabPgYmFG52HpnL7XyWfR35EDV6VT
 5++9xJE92qw63UQyYmdJy33TZWFB3lkpBcmHY7aVRAOLW+DhNh9VMIXOUFNn4QgqRiI9t
 3G5wu17NG1gTIJDa++Axn6HhxoQJlAQuNUvgTrQLIyCI4piSLykfkRLzoFzG/Bg+kxrsO
 yzXdFWFOdI1vukgz39oR8lRxDTzOM5Hc9cV8xGAHFvqdC78ISvqFI3RyoHnhEZGgD6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mVBfPy5i; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mVBfPy5i
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC03940FC2
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:43 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-7907f01e487so637054137.2
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792938642; x=1793543442;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XH7GXEvrA2/9F0Rjf+uiCdCPpvtcS1lOOj5WI7IMzpo=;
 b=mVBfPy5iK9NESpOgTkdaK66ndmcHYuo6c4jbsIUO+mmfzjFtTxLDQPhIRXa8bcJF7s
 y70Qj3Jy3aUIHchlyMdX5NEXWDnW72xEmrmWhWJYvx9Uwp9NyaKXatbhNVtu+JUTKRer
 zKmJ3mQ846kSkNCMEvVsuMFsShwxzT/Xw4hmWb2qzBaQB7KFdmZaRYK1Y887JeDjOBo5
 ANPaW9NC0sFJf0gCPHVKPij+tQXHQO0vuMjrjGx3RCuss2dvngWU1DwLYinHqpOqiRBj
 CFJIY+QN+/ghDJSPuDRH6uslCwYBf2Vo8QS/uGlBhLOj5fpI+xJKv2sORQ4L51maJkAn
 w1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792938642; x=1793543442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XH7GXEvrA2/9F0Rjf+uiCdCPpvtcS1lOOj5WI7IMzpo=;
 b=U+mjEQ1DcfKaMvp4Ync5FuU+Hm7hggoxVyl4Lg2dfZPv6/yRw55JlZFXp/s0K3kNlN
 TdZpUIwJWQp85+mw8k3qCCCrLdGYZIJxatb6WtbDnEEJZClPlZFMnwOUCALl51PlNa2B
 SJ3pC3wFR5CTCfl6Jg7kLPQlBwI+lTzN0YbiagDaiI2R4HU20SyHD+2UXJ4ZsguPu5kK
 bnKDxCtMQNtdeI3JmfU1cBqimBGbjkMxsazRA9OW6EKFwEQh7UB266+C1y6rUApePKHg
 MwhB+6YMjT4v/3WmN3Qld/Y0zgvScJcEFVGN3EKvRV2sQKFU9L/vCTljNAN2Z8vzco+R
 FlSQ==
X-Gm-Message-State: AFq9FYKZSn4KIz7ILP7mASxu2BbKn5zOv7iTm3MrNNJMXDEdZxtt2bUp
 IcUZBi+LFKXy0ycPcmu84zM2BDOmJNcwPW02Q/aLQT1E39lToQqMdc8W
X-Gm-Gg: AYBFou0RijydZaB+qyhlmlh8b9A4HGaNwLl6dpychcrsKREj6xUs1IrJ2oin5C8N6iC
 nbcHcFZQ442ZBEe3esZlDc/NgKqjspmKPBjXfOgE2pfoHbQFfpi5Rvb0daqpysZB3LKzxrY1NPY
 aoH+VCR+rq1W6Wi54OONhVgaoxEZWsZa6HZNKk3jzU3yUmBztcq0WanJtAtWMz0Q++ZO50kKa5H
 61Q3xyqv2xOMETRDeTkQbFTDZt/1rPOLNxRU1+xKlXhnxgJXCvBA3uiQvF3gNkDzjReea2RbDaD
 MkzYf2eGi3BgFLsjgjrfTDL+KO7l/aZDFnhck26qerxJP5V+j31W8oE5f+kogKar4rbODsBKw+D
 DYvmpBVZf5Hw/mcQPFEsSN5xbTqIh3BhKmd2i5uwkb6U0YJUOu5lOZxsgwefDRSEhz7xICCtrRW
 RTEGuEUlnEM+nmh0elO8ZM8r+AZOsxKUdnnXIpYHFSU1RAkqtgseeyDrWRFD6gq6bhUfsX4jWOg
 RerXStivmwPiaCz+LCG1eBHuiU8filNHB7JN5cppkl4lzPJ/X9EvhtQ8lPtaZEtjJ1I9j9e
X-Received: by 2002:a05:6102:3fa8:b0:7c8:18a2:f769 with SMTP id
 ada2fe7eead31-7ce5c6df854mr1107557137.0.1792938642132; 
 Sun, 25 Oct 2026 07:30:42 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5df73970sm4848621137.1.2026.10.25.07.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 07:30:41 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Sun, 25 Oct 2026 11:30:24 -0300
Subject: [PATCH v2 2/2] board: sophgo: Add support for Milk-V Duo S
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261025-upstream-v1-milk-duo-s-v2-2-192b68915c92@gmail.com>
References: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
In-Reply-To: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the Milk-V Duo S, a development board based on the
Sophgo SG2000 SoC with 512 MiB of RAM.

The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
IP blocks, including the CPU core, so the existing CV1800B support can
be reused.

Add a separate board directory, target and defconfig for the Duo S,
based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
common Milk-V Duo board code. The defconfig uses the upstream devicetree
via OF_UPSTREAM.

Link: https://milkv.io/docs/duo/getting-started/duos
Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Acked-by: Hiago De Franco <hfranco@baylibre.com>
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 arch/riscv/Kconfig                       |   4 +
 board/sophgo/milkv_duo_s/Kconfig         |  30 +++++++
 board/sophgo/milkv_duo_s/MAINTAINERS     |   8 ++
 board/sophgo/milkv_duo_s/Makefile        |   6 ++
 board/sophgo/milkv_duo_s/milkv_duo_s.env |   8 ++
 configs/milkv_duo_s_defconfig            |  43 ++++++++++
 doc/board/sophgo/index.rst               |   1 +
 doc/board/sophgo/milkv_duo_s.rst         | 131 +++++++++++++++++++++++++++++++
 include/configs/milkv_duo_s.h            |  12 +++
 9 files changed, 243 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a0..df10354e9aef 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MILKV_DUO
 config TARGET_MILKV_DUO_256M
 	bool "Support Milk-V Duo 256M Board"
 
+config TARGET_MILKV_DUO_S
+	bool "Support Milk-V Duo S Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -125,6 +128,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/milkv_duo_256m/Kconfig"
+source "board/sophgo/milkv_duo_s/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/k1/Kconfig"
 source "board/spacemit/k3/Kconfig"
diff --git a/board/sophgo/milkv_duo_s/Kconfig b/board/sophgo/milkv_duo_s/Kconfig
new file mode 100644
index 000000000000..6ec6bd65d938
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Kconfig
@@ -0,0 +1,30 @@
+if TARGET_MILKV_DUO_S
+
+config SYS_BOARD
+	default "milkv_duo_s"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo_s"
+
+# The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and loads
+# the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
+config TEXT_BASE
+	default 0x80200020
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
new file mode 100644
index 000000000000..86533c03fd9a
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/MAINTAINERS
@@ -0,0 +1,8 @@
+Milk-V Duo S
+M:	Andrei Lalaev <andrey.lalaev@gmail.com>
+M:	Hiago De Franco <hfranco@baylibre.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo_s/
+F:	configs/milkv_duo_s_defconfig
+F:	doc/board/sophgo/milkv_duo_s.rst
+F:	include/configs/milkv_duo_s.h
diff --git a/board/sophgo/milkv_duo_s/Makefile b/board/sophgo/milkv_duo_s/Makefile
new file mode 100644
index 000000000000..a1b6aaee1489
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+
+obj-y += ../milkv_duo/board.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo_s/milkv_duo_s.env b/board/sophgo/milkv_duo_s/milkv_duo_s.env
new file mode 100644
index 000000000000..4c9f53d08118
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/milkv_duo_s.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x84000000
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+pxefile_addr_r=0x84300000
+ramdisk_addr_r=0x84400000
+scriptaddr=0x84200000
diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
new file mode 100644
index 000000000000..41a31c4ad46c
--- /dev/null
+++ b/configs/milkv_duo_s_defconfig
@@ -0,0 +1,43 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING=" milkv_duo_s"
+CONFIG_TARGET_MILKV_DUO_S=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_SD_BOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="milkv_duo_s# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index 19c9a19b1d4b..61aceafceea3 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -7,4 +7,5 @@ Sophgo
 
    milkv_duo
    milkv_duo_256m
+   milkv_duo_s
    licheerv_nano
diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
new file mode 100644
index 000000000000..9f6bf04d1842
--- /dev/null
+++ b/doc/board/sophgo/milkv_duo_s.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Duo S
+============
+
+SG2000 RISC-V SoC
+-----------------
+The SG2000 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+Support for the following drivers is already enabled:
+
+1. ns16550 UART Driver.
+2. Synopsys Designware MSHC Driver.
+3. Synopsys Designware Ethernet Controller.
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make milkv_duo_s_defconfig
+   make
+
+This will generate u-boot.bin
+
+Boot flow
+~~~~~~~~~
+The board boots from a FIP image, fip.bin, which contains the following
+binaries:
+
+- FSBL (First Stage Boot Loader): the vendor bootloader [1]. It serves the
+  same purpose as U-Boot SPL, but U-Boot does not support SPL for this SoC
+  yet, so the vendor FSBL is required.
+- Coprocessor firmware: the vendor firmware (cvirtos.bin) or custom firmware
+  for the C906L coprocessor. It is not needed to boot U-Boot, but it is
+  required by fiptool.
+- OpenSBI (fw_dynamic.bin), built with the board devicetree.
+- U-Boot (u-boot.bin).
+
+The boot flow is:
+
+1. The boot ROM loads fip.bin from the FAT partition of the SD card and runs
+   the FSBL.
+2. The FSBL initializes the clocks and DRAM, starts the coprocessor firmware
+   on the C906L, and loads OpenSBI and U-Boot into DRAM.
+3. The FSBL jumps to OpenSBI, which runs in M-mode.
+4. OpenSBI starts U-Boot in S-mode.
+
+The fip.bin image is created with the Sophgo fiptool [2], which provides
+prebuilt vendor binaries: data/fsbl/cv181x.bin, the FSBL for the CV181x/SG200x
+SoCs, and data/cvirtos.bin, the coprocessor firmware. The fiptool also requires
+the data/ddr_param.bin file.
+
+Booting
+~~~~~~~
+Currently, we rely on the vendor FSBL to initialize the clock and DRAM, and
+load OpenSBI and the u-boot image, then bootup from it.
+
+To run u-boot.bin on top of FSBL, follow these steps:
+
+1. Generate a compatible u-boot.bin using U-Boot with the Milk-V Duo S
+   default configuration.
+
+2. Use mainline OpenSBI v1.5+ (v1.5 is the first release supporting the SG2000
+   [3]). Use FW_FDT_PATH to point to sg2000-milkv-duo-s.dtb device tree file
+   while compiling fw_dynamic. Example:
+
+.. code-block:: console
+
+   cd <OpenSBI-dir>
+   make PLATFORM=generic FW_FDT_PATH=<U-Boot-dir>/dts/upstream/src/riscv/sophgo/sg2000-milkv-duo-s.dtb
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Use the vendor-provided tool [2] to create a unified fip.bin file containing
+   FSBL, coprocessor firmware, OpenSBI, and U-Boot. Note that you will have to
+   use the file cv181x.bin as the FSBL, and that the U-Boot load address must
+   match CONFIG_TEXT_BASE (0x80200020). The tool also requires the
+   data/ddr_param.bin file. Example:
+
+.. code-block:: console
+
+   cd <fiptool-dir>
+   ./fiptool \
+       --fsbl data/fsbl/cv181x.bin \
+       --ddr_param data/ddr_param.bin \
+       --rtos data/cvirtos.bin \
+       --opensbi <OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin \
+       --uboot <U-Boot-dir>/u-boot.bin \
+       --text-base $((0x80200020))
+
+4. Place the generated fip.bin file into the FAT partition of the SD card.
+
+5. Set the board's boot core selection switch to RISC-V.
+
+6. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fsbl
+
+[2]: https://github.com/sophgo/fiptool
+
+[3]: https://github.com/riscv-software-src/opensbi/releases/tag/v1.5
+
+Sample boot log from Milk-V Duo S board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+  U-Boot 2026.10-g3c39950264fd (Oct 23 2026 - 21:28:58 -0300) milkv_duo_s
+
+  DRAM:  512 MiB
+  Core:  28 devices, 13 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0, mmc@4320000: 2, mmc@4300000: 1
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - 4e:27:14:9f:7c:d6
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo_s#
diff --git a/include/configs/milkv_duo_s.h b/include/configs/milkv_duo_s.h
new file mode 100644
index 000000000000..f60aa23fc181
--- /dev/null
+++ b/include/configs/milkv_duo_s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif /* __CONFIG_H */

-- 
2.53.0

