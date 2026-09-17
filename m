Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B606C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFBC8608B3;
	Thu, 17 Sep 2026 14:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNjxOCqhkCYL; Thu, 17 Sep 2026 14:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C768560B0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653777;
	b=RIL2ZpJK3uvPfvA8mepfAio8jO/uXlSHWmEVG6l1V826qUbdHfU1xJKcufttN2hdVGkL
	 C3Flq0BR52YEq0x6e/qud6QhUPfDsLm04OJnaeKZHfShMNhERAN/0pAs9QVuN1TojmUIR
	 A+EpZQCXGK2ctqBoerWPanVvNjnMaGGokHOb3gT6E9JM1EgnAp7eCNmFRKgbRNnlKQPlN
	 qEODMd/pSB86fmEGic0Q9YImanK9V0Lj5+2uW//zhA/18i10g1yYVGmjHxpW6+ARG1P/y
	 d+X/gCgnKSw7vaa02CMnK+NMTyHZUJ+DIb8njICJnx0S+ZXQZblvxrcVwQVR5DQtwhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EuzdIQvDBQ3qeTn0hUCjn09KDg2bXvmTIXUcvSr0KMI=;
	b=htJXHGMJk+rUnlIJp5OZNyzZHp8NCMvo06v9Af8Wj5P4m9qu9n2yX8kCZQfuCRYSyRx9
	 LXVH0TLRExPA7nrib/iMVdjUUCijHTUulq9w9MdxcssTpgxyRzge1OAM3NSg6le9qTmcf
	 WfiT/hjNetYBZSOKmusI+fxv8jlngnxdT+mZyAFlbbgV9WJiD3nD3PnBp8JXFcfQo2cJW
	 ljgQMNRpDeu3nomYhDDR2tAGuPAiXGcNL7n6kV4ks0p6hM4w34rLJVSKvlO570t6kuAkY
	 bkLJopkmRW6+ORWKAvE3cqJYphxvwLiyL2XQ5crg53rBj6FycCaxarJ3eB4ptjXzHDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653776;
	bh=EuzdIQvDBQ3qeTn0hUCjn09KDg2bXvmTIXUcvSr0KMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jx+W+c7ufe02peMNXUOztnUrHEDG9FWUE+Px8dWKgWkk+mviVHIblp76ZEagtuQTF
	 MK+ncc95TbqQHX9skpD6Er5XO0oJaIZGo1T+0Mpl6jR5Ez/cG3aiiHxaBCB+y8Td7j
	 uaFLHxqUyb5mWX7+2xzQA6jnh99LBuYu5UKc83+Y7QjUJAcrYIQv0o3dF09mJVyYbU
	 ReBsY5OSZWXcQSFZEKV6U6JrRyZ2bp+NbY2rgwriGNaBo7LpZXedtTJ9xDZ164xJun
	 vkuXmYAmL3l78ylAOkbfuLPPxcZV/cv8vHnQFIdnY9N7wLiw8dwEmCpE68LGisV7pF
	 /SSRX18G0VgpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C768560B0B;
	Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BCD5A29
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01DA380F6A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYQThP7FslXe for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF8D580A54
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653775;
 b=ShOI4xfvvPllFN8DgJWmG+mN+L25MPsHCFBFW1uqPvlYjuzNSYPp9uJ/oBBmdtgSe9lh
 U+VoWXDlzBttpPJjdBbEhtcQ5eSH1G5wujfUAxucQKPLXIE9qyYBIfJrA4YURsHZqLq23
 2BPMENIFaitUs5N0YPPVePby197W83lp/r5az7uD4idqG2x/Zy/YDBwBUZ7fjqE/2Acpr
 1PeHhh67/VpcueB6DCg+h6OLdYZ/xZ+mj5i8KfR1pFqmJjobkPsjpRuud4OKQ3rNZNdlw
 D5UkBlURgorh1cw+mNoF9x8QUy1uHxjdpMFMhVCu6vrVgZbKIT5brlT1JYERbTs/Pvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653775;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=EuzdIQvDBQ3qeTn0hUCjn09KDg2bXvmTIXUcvSr0KMI=;
 b=A2yLGYd9T/Z7EyCuLxx9DcTjSb3xuTVHqQnnrhy/cA1CDKlGI8cZ9rEOyhnLTUvrM+C5
 gTo1vzH6KQr8AL+uxf0KoLF7DSx9kkC/nrGu4jU+uIWagI2sU84Ax2kqwFpPFHv4zzkmL
 bmbIqIAPRzcbCZIkQic+txxR1DPqbFmmTOG2vVckkR1ja60RqJCrThwTCZYE42lJuQgzN
 HcqziE8QC/GhvtIK+n7U4ChjrtEwyc/ABHnirRE5tIN1nUIxm+WAe5sb140Wz8XaXJAvD
 jpiEeqRnGFOtFXyU/WlPRfS50yo8juwGWmELTeWSpgbNwraOSsw8Jx3sAyNZm0MJLgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=T58ygslF; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=T58ygslF
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF8D580A54
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:54 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48439feca17so745892f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653772; x=1790258572;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EuzdIQvDBQ3qeTn0hUCjn09KDg2bXvmTIXUcvSr0KMI=;
 b=T58ygslFcxKaKnlTJ3W8hIS7+rs+FlrwR8F28UE/F9gMrgAn4fknPzqPhuDFf1Fu1Q
 D0OZv5ixg88W8CKtdUow9FFuoeEWfeM8XH9r0OHMW7ZqUNi6F7CDMoKfGC6kE3xhixuQ
 F0KKgx2c1LHw8O9u3udb7xEZOPRN5RwYCXDhECc7kLfvfosnXp1qvMT5WlVWU0HgTto2
 L7j8MO5UNryqM/4uTORT0twn0PWcXN1ZLVTbX+tlHzYKXoFQN7/SKgm4/BGCMYS084h1
 23FJNh9OsuilMndFGZuxHLj6cFnlRP00035Cm6c0vAYKnPrR6+DTO67QXjgXhiVQYkYr
 7olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653772; x=1790258572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EuzdIQvDBQ3qeTn0hUCjn09KDg2bXvmTIXUcvSr0KMI=;
 b=gmHIUgupM725bbtZsptNhrwxg6bFxR5l0ej5qEORbVsc7aM8I7Ui9hsAhtuo0HRcZy
 MDW2gQJg7sfZL/dwU9ykyd4WKk21B7qmx6VqUE3/0TIKafEc/rY/Z7hVYSoZwKT+2CFk
 5cgvs20HjbCo1tzADRxHmm4Encn3uayGPWqmbTjAI/T5+kBJgCRPvN94TkIYzT6HZIvv
 CiaLxfyeBlf7eOlB6UPYUm3BV4Qbyfs+N8+snvyQhWrtzJVMAtUhqc/JTNXTTGj1qP/0
 7vrB2C+Tim+cCEQqwGjFTdiycc1WDPCevaY2c7CDzpsEl82Cnh9ZsmjFAT6j0xK/DZkH
 9N2Q==
X-Gm-Message-State: AFuF++kpCw+AWmp5Hs+KmNpcsNwkQ7F5r2o4L4ilVnib9eOpAVNaW7Qd
 DLZCMwlHh51+LB5j3r2NojubgodCCeFick4WLlnuVl1yqD/Ms+S2x+sdUgKfikBNXD8=
X-Gm-Gg: AYBFou0BU+I+/YGmkygsTYxs/QeLYgHhVAuhZ4P+6j3jlvld8p+O3bG/UvD79hCj0fh
 m5RV1k7+PAdHqeQSP0Sm3hYu8uLjY26doq1EO0j/isA7ttAgtLgO8dDAZ7d2XLcc0pXe9/Gn9WM
 1DGUXcNCctTBL3jdqVLLR4hdEIPSorts1oOR7Gmhf9GPHc6AVXdy1Do4hoSp5mryp7f3OraQCSC
 1iciZuKIiL1+c7uLWPivrv1PM2I2Xandg6DkMd9DQO+QXt0ZonM62A1bO76/C1yAaltv+D9DJWm
 vApR+pVQTliAGPdvYUEAdYUIqsKh8aa9K+jMzg2cAQImOX43FX4IneA3yGPg3z/8q1HoPVtrUWv
 K/P0NRvrIFTzCNBDAQsFCSex/jIivKZLIQXBuo+c4gfeaLvKVphadDZkjC5AmKncRWsJMy0XYBj
 YfNt+C5L3gx7nCFfR4dyZGbTdHu6LxM+wKq1ew8rxXGwfoyka1wqv+pDkdMEl+R2BBnWMRjW5WY
 m1zB6PkERNQZyDvsel4tFe+VfBhAb1yXjPFw8rV2Hgq5mMPSq2g
X-Received: by 2002:a05:6000:41de:b0:487:951:20 with SMTP id
 ffacd0b85a97d-4870d26b463mr9186252f8f.46.1789653772183; 
 Thu, 17 Sep 2026 07:02:52 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:51 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:24 +0400
Subject: [PATCH 03/11] lib: Let SPL minify zstd on its own
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-3-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Cnxw+XZgkX+ZrQvLh7FixX0z3pDw5G5KjdCi4E3RAqg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vTrW6/cTt6dx4RK36e9NWC44xqzTfcRe6YP1/HP+
 fNOZ6qldUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVdycxMnzZ+3P5+vbmWSr8QVONzqyI3La04+Oxhx+Lra476xee+/iZ4Z9Vd11
 wwfGFZ93/at2Y/aPLztBhh6nlJM+250n9jWKJhXwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
enables zstd for SPL alone gets the full-size library in the phase which
can least afford it.

Add an SPL-scoped variant of this option and key the build flags off that.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/Kconfig       | 12 ++++++++++++
 lib/zstd/Makefile |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6e6df5b3b191..87b5f3f4864d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1025,6 +1025,18 @@ config SPL_ZSTD
 	  SPL_SYS_MALLOC_SIMPLE that memory is never returned, as free() does
 	  nothing there.
 
+config SPL_ZSTD_LIB_MINIFY
+	bool "Minify Zstandard code in SPL"
+	depends on SPL_ZSTD
+	default y
+	help
+	  This disables various optional components and changes the
+	  compilation flags to prioritize space-saving.
+
+	  For detailed info, see zstd's lib/README.md
+
+	  https://github.com/facebook/zstd/blob/dev/lib/README.md
+
 endmenu
 
 config ERRNO_STR
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index c9a7dfe405b4..9d1b4d4a4f72 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -11,7 +11,7 @@
 obj-y += zstd_decompress.o
 obj-y += zstd_common.o
 
-ifeq ($(CONFIG_ZSTD_LIB_MINIFY),y)
+ifeq ($(CONFIG_$(PHASE_)ZSTD_LIB_MINIFY),y)
 ccflags-y += -DHUF_FORCE_DECOMPRESS_X1
 ccflags-y += -DZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
 ccflags-y += -DZSTD_NO_INLINE

-- 
2.55.0

