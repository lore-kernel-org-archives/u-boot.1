Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1167606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vmgQcRg9;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KKui2Y5W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B330817A7;
	Thu, 12 Nov 2026 21:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rViJzgylQ5Hj; Thu, 12 Nov 2026 21:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B11AF817A3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518201;
	b=VgF9K8Vka3/U4uCbdobM71NZzBrTXSUeKb91BM2imAjoezekGp1Y6bsyMdF6xcfnoDNL
	 TaS/dWE46qfK+2eCoKxXn6CP8KfkLvmBNMhEqC7SgRb6wrzn5H1pap0W39wT8yjXLel7/
	 KdZKdRRi8+ENLhpu4Mh7RhALrLrKUgUk5+WqDyLMEhRtGkqPsjvnwD1aNDtVuppilUpzz
	 JX1lfxHKX3mjjqbGtrooOoli1rdiXuJt5qnFhW7suynemW5MF7AcvyJQxmHuf6AWtGvgQ
	 wPZ9hZqslwnRJqGtpzToZr1z7Ek3aI3uC6tp58zZCrb9kE9HLm9+5NVfaFdNvYYWZDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0PyNqN+9Db06poBduvgvmEz2m2n7uYHNEubcv1AQHM4=;
	b=W22ZoJ0NzXsKT0aUa9toBCYPfuYto2A+QgXTbkzlwv3Kr4tS+eQYiAw/3B2nqf1gTQYS
	 d5/ankpgtIAhhHsevgOvxQAMujSByRkcJu02M9ISfPntYyfczFlhAcmrQ6oVKLUWTHX9y
	 e9CuZPT+ydhXLEtl5W7m12RCUjzOV+Or2FJaOYOCFyR3RoAKVTZmqy2TPoCyWRe9mCElU
	 /xD+ZwDc19Juu2Ku1Chbagb4k+nS7b/k2llSeKFTtw+YWZU9D/98OYvVEFr4MVtM8dAMH
	 RWiwPdXCUlrbFXRTPW7JWJP//k3hXCkBtXG5gNzSdI9nhvzS2bFno7ODnxVVL4DIqBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KKui2Y5W;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518201;
	bh=0PyNqN+9Db06poBduvgvmEz2m2n7uYHNEubcv1AQHM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmgQcRg9kolnE6XoLVYozrBHKqwZnCUagjnRmMZdratUd1gGSNtWi5psA9ilcDRRV
	 cY42aI4MaMEGL/pf38Q0bitnlt6bpcOpS4pnAbK/TiLxDrUbBfUjTmu6Wh97SmMcKR
	 jNOry5Ev018qfeuwdPeRD+j1Qus9g+tzuEPDLL+2Esk/+7H5NK39qsB2uuuG5w6ml7
	 Hmo6ladnDovSdMJ/pe0R/TXotxI8NDd4KaFxqGH3NNYja7gdYYZ/p8SE1pt1wTxvJG
	 ZakfA8QTNMgOqDYSqIWYxRkjrbCiFutUL8BkQ+1++qBxn46hl3hhGu5AV8KekLIrvY
	 By94ECs1xpGCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B11AF817A3;
	Thu, 12 Nov 2026 21:16:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C4F11790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D799981762
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uc5ZLSUwTQoo for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B431816D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KKui2Y5W
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B431816D3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:36 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-85f34b20042so192100a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518195; x=1795122995;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0PyNqN+9Db06poBduvgvmEz2m2n7uYHNEubcv1AQHM4=;
 b=KKui2Y5WthqW/fBVCYI2N7fU/zdRPIaQytJM8AsiRtJJwyBHXUm33QTMkRIwrHXdQ6
 GOJPBs/GkcLS81MEj9s87lP5FH/ZcHyd/sTd0MUDFQy/wecvxD2+2v61UPMscyBiRbWi
 vi8tMNO+V6tBxyzwmkBYjgur0+q944xcC+c0P3BZtRydsZFJWMXm+PNybMsdf+EszqYY
 Uw/gF+JWmj8F2zqKRZ8HxKjtVEclQbhCzxgL/krlDkV6EK/H0GPPcTduntizSxf6wR4x
 lfkbkhIGoQdixeEkuqAS5tvsO1SfuRAas7efpzzil7SmShg4uhQdjrBCOcY+B4Xgoed0
 4gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518195; x=1795122995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0PyNqN+9Db06poBduvgvmEz2m2n7uYHNEubcv1AQHM4=;
 b=VgAOgv0w+/WxGcYCXOzTIbI7iauQsXkfmAdMjhh/lC/Kxj2esXlFpIHFqcVFQ3TMEY
 6rjv0TM6KP1SfdIiBBSlQ49zN0Z9/5bq2EQRbFZxgAy2k9ALqNp2ZLoVS3v6o0pEyVU5
 90lCias1vp5YlWPetrBdSgJrFYNo0C7R0gu99p+h/+O14ZUgxaHLbIys9LH5DMie7Pdt
 ZiPLkuBw5MArCs+CFpfW1hoJJesMX3RRVO/iiwaEj2VYPw0HJGuiJXWNwVs9lkaGE1q7
 bYvV/OYIG5iRXZGEvHiLNaOcMzbITC9In/YhxhlEHNTj/XxaPJKfGmDGcK1wWFeS3Jzk
 jtyA==
X-Gm-Message-State: APuU4Z9MjKwwsrZ6/nLh6OZ2I7Oo0NlJ4/BJfrj7biVHIJYSF7sJWZXZ
 rm39BqdXpg8//GYqWR5Y4wndSYcCrcrA7nOzSuts7iVh29S/0NtSEVANW5BtSODuMSc=
X-Gm-Gg: AYBFou2Plc7VH5leollZxTjSV8xOblIntWVMNoTGueuvKrw88UJeV7h+EF64hUurTKb
 SnxmjMLx9CMqhNhCpZYLkuDfuAqA64Z8HdBsOj/wW8qdNwwtuHypIToHNktiRepBxHxFpM3OhmT
 PrePhQSCqBDadtlB2oPv/WPBUcQYMV3P+c/M9w10BZQ4ReN5+lLgmh8rNIvn52KRAu1aZcJj/VB
 BiIetNEse/HQhGODJnmz1zXtpIG+iMTZCUvU5BuE4kmPxtm/QthAJDXaY6k5h0PV57XykdyTZsc
 WjMk5cfL+/Nx9X+zpB0E9Vx66aaZ7vY+FpXQ8wvezO43lBTaGkHglYhuFLNeuj3wsehRpvHpyGr
 8DNgA6gCU7iQ8Z5TlrFdjyW+SJTvaCV/DPPv13dYJWbzVRKwiyOX+7JJimbprkn/XHzce/t8DBj
 pM6RW4S4yfJxtQP52qxeUdWKFM3COAL6GtLIVH0b+sCnLIfBgdpNRME0AwcmVkcZzM6O4MGXN0U
 2E7CTBofyOW6VHyeW0RIOUdW3YOAyXhUW6eTxiU/Vqt1/f8L42GTVjaadjoXBLvqKrG81R4psaB
 jrlwA3g6yvH4EIU41klit0+ckE/zbNh7Ww==
X-Received: by 2002:a05:6808:1584:b0:557:308a:9e9a with SMTP id
 5614622812f47-56e63ba5734mr476530b6e.21.1794518195561; 
 Thu, 12 Nov 2026 13:16:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:00 -0600
Subject: [PATCH 05/10] lib: Kconfig: do not enable BINMAN_FDT by default
 with BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-5-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QQrLh57noO3ZDIAJjobo/qsoimxg6jaPhhCDEpe6oGc=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGr2LH2h57H4GNpVx6sKedTndzwr/ZP6fVnxJ++HrSfBR4J6P
 4kBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJq9ix9FhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8CW1Qf+IMZiwHOJ7AUusfwIHzNXPYTjtdTfFtEwKAgPhgxQMvXzIW/
 89zd5NpNUY+yGJNH401LdF1SCQbn32PkaXA3j3StFen6iVm5Q6Jrx2+R08wC+lpBIqs5yZKAE/Q
 YkvXA/aReTzUFPSTMGQ490LVHoxn32L34/aXrBFg0iXXHTYSegpieMi2xQ4ewgg4RpwsufM9FJt
 oKn99MamHOp+1n9t4usah97KmjaVPi5sd8YuLfw/RIS5gyU02VR1WL+s6P8HAQ2ELUeEJdSxwo9
 JK0hgkvuYAfPu/wi71WBFnKVnsYvvpSRrqLJQzHKMqubzQNe3Ivw9dgh0KO1JtO4y3tp3Q==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only enable BINMAN_FDT by default when the binman description is part of
the U-Boot control devicetree. With BINMAN_DTB, the description is in a
separate devicetree, so U-Boot finds no binman node at runtime.
binman_init() then fails, which stops U-Boot proper during init.

The boards that set BINMAN_DTB today disable BINMAN_FDT in their
defconfigs to avoid this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 lib/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index d4e876fccff..8f257ecf51b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -38,13 +38,16 @@ config BCH
 config BINMAN_FDT
 	bool "Allow access to binman information in the device tree"
 	depends on BINMAN && DM && OF_CONTROL
-	default y if OF_SEPARATE || OF_EMBED
+	default y if (OF_SEPARATE || OF_EMBED) && BINMAN_DTB = ""
 	help
 	  This enables U-Boot to access information about binman entries,
 	  stored in the device tree in a binman node. Typical uses are to
 	  locate entries in the firmware image. See binman.h for the available
 	  functionality.
 
+	  This is not enabled by default when BINMAN_DTB is set, since the
+	  binman node is then not part of the U-Boot control devicetree.
+
 config BINMAN_DTB
 	string "binman DTB description"
 	depends on BINMAN

-- 
2.53.0

