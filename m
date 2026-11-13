Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340A606A8AA
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jn6YdME+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyNexmoo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C130409EE;
	Fri, 13 Nov 2026 17:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyE9rAEhi-im; Fri, 13 Nov 2026 17:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9513540B4C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591117;
	b=YPH6xaObVE98G9eqJ7tUV8EDZnup3LlyxN3u3X/DiRvg7ScZTgCPFzoIvOzb/4O+N6Gj
	 hXBfxBMERvSP8hsvcBKyLkSeEXdNOCGqV8E0+Hw9W5IU7kRoYFDZk30rb0wmflDkTBb+Z
	 wrIEp6jfkeRH6xxxwLuIeoZXDRIeEpAb98UZuOYBKCfSrfKFj49tNnI199aRG8VzYDQAg
	 or9+exDE/SDaLC+fJiHQdeGUVcAO8f+1yQRcYx+zqaFlM0rWG4aTidoHgRmZYCyFoBAfc
	 zfeslJFPJ0+ZZWhQ0pTx4SHmaQs7O73rbEQdSz471rK5OlyJ71uFgFFMvVoMuliczOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m2F/qpgy+v6xekIwYVsftlCTL+2yxECl0qHOhwWE0Vo=;
	b=e3uuEhDuDBwc1H+MbBifJ2iFeN3uPyQlKCpLYQdaIA1qmAUZ7INg3GLuqdA4SBmfTlF7
	 btgD0vUwct/zSM5T/f7Sq+y1Whmuw94x3c0Oq46o+SpyqnJ+3Jv5jsBsaeZn5rEDPB4Lp
	 RvK5OCaYE7NYObAX/nNccejGVy0IPM9wXE/1ilKeiiqWWeLUYjxPWdLNXO99QHwhkcN9G
	 3xfZvte4pqAjmmPrjv05adMSPEcps7YZuUxc+wzfb3JgD+KsBak86CPGp56FzRnn5+yq8
	 NyQciCVzufi5CjUX1V9SrTeAuq/DXS/t2GlDUL8fDI8Rh1o77WEbKmz1xsabLvZa5nA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591117;
	bh=m2F/qpgy+v6xekIwYVsftlCTL+2yxECl0qHOhwWE0Vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jn6YdME+XROKboskfB0si/vsCvWnnGwek36Jgml78YzSgAz9Y1k7MPT6SsQ8d79Hy
	 q266NAfLXZ3xu/d9KWn7vqls+9kGJ8ChIjaxj8QQmB1fJVKe8wYiSJXOBphSyVitiT
	 76FTTyquwvzSNCHSebriITFnrbqnDyRJiCCijzIDrywL4A1Vt7vxS7eTGGRLy4uPiL
	 V9lmmFG910iMKZ//2MYI83skrT7iqC7mgQ1Ed6ReJf2S5QXZQ2mehIu6oFH8BgIQJE
	 7V6nExTpBpVCqkcDnmp/cG/uG6HTjQx06O3H1VecKWe3fEuH0pqqDIR9hVrxv6LPT7
	 Xxg2YOw3kyW5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9513540B4C;
	Fri, 13 Nov 2026 17:31:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 243312E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16D6F606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvFlS5c1vKN7 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D60B60663
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xyNexmoo
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D60B60663
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:53 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so430116f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794591112; x=1795195912;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m2F/qpgy+v6xekIwYVsftlCTL+2yxECl0qHOhwWE0Vo=;
 b=xyNexmooNQd0FxYbd+JebHv40UITATFHdqquOp8zgo6/qUV0UsyuRcdwl4V6aZuHX7
 FrXCaTCFUK6qlAdN7l96PXVWiW0AF9j8/NCZYCenDowsH4H55FEPyHQa1WBFYK07iNbD
 SSkNZnfmvLO94to9suH5sAGM9HirCVpR2hRLbO8iS+Xshgbjz5MMSbpvr/WgGOHQ7Mad
 1tT1jdzF/0mOn7QgN+3m2LbMpbZXw6mj71Yc7I6UTrYcLG9z9ELWoHAbZxmWEsruYX8i
 ypdiz9mfKKtP+GNpAf+Pmm1Cjhz3tEMKYtgHj8cpW3naA/D9h4wD2flCs5LhvU+elBvM
 b+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591112; x=1795195912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2F/qpgy+v6xekIwYVsftlCTL+2yxECl0qHOhwWE0Vo=;
 b=jqny64mQsuBrZMdBPIT/9FCFVvVYpnu77WNjC8speFFVC4aGY7S24QhP7dOaGX0wz5
 OE9njL/HdDVYwduSWPy7TPsNo17fJExLe9POejlUshISgXqAiXVDoMqecRzX5ll2awhn
 gsKfmxOjqgmi9aKP/bdJ3810Cocswy9F0dkun82YNooJ4AVJ2vzaRuXxq+gu0HlHYe2r
 lVIUc8pTkcSiNCrlPNS7OOaCNmiZMjFDIsF7DJjtICu0sLuWkRhYWPG4sMkDuBW6NFlK
 2rRv/hjGMF0cLviEwfuC2tiRzNDb039YLY9pfmx2G3XUldI8nQDtYsLQFXbdtEFoW82H
 xTcg==
X-Forwarded-Encrypted: i=1;
 AL+hErFqscWcZdBgT3k6vBx8YhbbEf8kSRRgpSmuaRkFVSLdxMSpyck8vOqiqj9VC25yOcP8P5OA6uY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+2ZbHNYUO+OAcXoIgQP8YdEWhRVcJw5HKTYgX9HOsU8Yd5ynyX
 OyV6Zrc7L45VzbLprfoFKuzjBia+cRwkaaKu6nyvXs0YLLz60Tqm+aKwSqzvxhd6
X-Gm-Gg: AYBFou1FJg2musX0Ad10ltsfRhDLCtjQDoSLFEVlxDgQRPfligugi5IVWWEMI1mlJ0z
 7o/keOUuHA6Sotvtl9giSWaD7SPyGFVZ/ZI2YqB9XcBTHS3YoSEiAIGXsFof7v4AMGgkgOpNQgl
 oS2vSEiXNGHwtNXK4nNVq/LONLnCxZqoy4m6i4fV6cmlLELikbP7js9baeJOcmmff+rD53SokrK
 EhjC46fs9gxKwifrzBBaGsGK7y9GYRCBvwhUQSYwPJSjD2jG2fN9PVNfqhbpK4aqP+Cp/X7zt5/
 wRqoncTo32vLwWMz+UHKZF8dyDTMr9qMDU1nB/CyED1PF3V4TE33WHyflAFC8XQwsHTSC6LFp0D
 So0HAE6vj5pPQMwrQirsgeVxDpStLYMa3nBBjcZ/P3Toog63OdqExbzLJCrF0D4P8wVQJFa1fA7
 EpFmSEKxQChSNrKwIpjT1HxtwUzeSjA9YZJpPhEYagUC1xaboACEAIVbnIEmZUt6bBs21hFI6SZ
 n0PhFo19iP2D1mWp9NGC9+0wWJDYEG+XvMObvcGKupoWEK7kirT0FOg1LQVmdfd7e6iVGvywoqt
 9ElOqKgPIOIxBoD+LP8SzfHWF4GbjVyus2Fx7wT8quHa8ynbhRmCS1+O3kdNFw==
X-Received: by 2002:a5d:5887:0:b0:48d:fd4d:7fbf with SMTP id
 ffacd0b85a97d-49c6d4539d5mr8241742f8f.4.1794591111528; 
 Fri, 13 Nov 2026 09:31:51 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm5587810f8f.4.2026.11.13.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:31:50 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 13 Nov 2026 18:31:41 +0100
Subject: [PATCH 2/3] Kconfig: Improve LDR_CPU prompt and help text
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ldr2-v1-2-dd7dbf436494@gmail.com>
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
In-Reply-To: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
To: Ian Roberts <ian.roberts@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the prompt string ending dot. In the help text, emphasize that
this configuration option is related to LDR format support.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index a049cc80806..6381c523a93 100644
--- a/Kconfig
+++ b/Kconfig
@@ -795,12 +795,12 @@ config HAS_LDR
 	  automatically build any additional targets with make or buildman.
 
 config LDR_CPU
-	string "CPU name to be passed to LDR utility."
+	string "CPU name to be passed to LDR utility"
 	depends on ARCH_SC5XX
 	help
-	  Set the CPU name for the -T parameter in the LDR utility.  This is
-	  generally used on processors from Analog Devices, but may be also
-	  be useful for other vendors.
+	  Set the CPU name for the -T parameter in the LDR utility. This is
+	  generally used on processors from Analog Devices, but may also be
+	  useful for other vendors using the LDR format.
 
 source "api/Kconfig"
 

-- 
2.34.1

