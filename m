Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94393606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ttPqkWaJ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T8zTcrfB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 674A48100A;
	Tue, 17 Nov 2026 00:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LT65swAOMCc; Tue, 17 Nov 2026 00:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9F7F80D83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794873992;
	b=pA1bjyyVIcbHI8vn+0XpQcqkaoIMAOv+4N932vgV+ebDnkG3y2x6W+vNfEi+OwVn3f9f
	 zaVRwkbbki3lKWTsnIVDURNNYFRTLC66Nzfv7jtIKMqWcxfSTa21g3pYrvS91lGvTuzq1
	 8r994CdbKSKHJrLH2Shm3bGBRZbcRS1lykrKyqpH7b5cQYJ1hJvkdUaHS3wjuwFrv48MB
	 AKT9mLRPgk8crWbIONLRqrMQ2O2Z3laCHBdb8hyWUtBIl4y3TTuAqohoYfWaNth1yDqHP
	 zdG3lf2sTr64G79R/Yh3HwhYJNfsWRmSaGjw+qEwndn6YxF7gr4FAAQPTjO3UwuY1Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794873992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LKa7nLQ/OY+8uzsjaELR8HjeURqxpqJKcJY5cLl/E64=;
	b=NS4W2XWOg0dM3rNepJCStWtdwH3z8QdOHgUkHV/OGpEXrpsR/AexLQtHgs+cePZYVjv3
	 neVa/JJPU9G+4v/LvYyrBK9N9OoRxV2JxaVbua7GEJLapckUqWqjfnPRzxZPJt4nNS5Jn
	 FoAoJrS5JMHZB8CTZfKvbRo5VijaADqSlkocIuTUZOTscSXVw77ivuV1r7Tyc0LPWQKFq
	 aSeuJpO30wB60iAjh+HRgr54kz8Wzk+O82zCbfXVovr45KAWwfOYE1VAcWpbVJSKXyjJw
	 mFYFsyL/VKRHrbjX8pAz4IZIcGvs5PNv4A8CVb0OsW0tkEgyPGNV9xmEyPKVNThL0Tw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T8zTcrfB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794873992;
	bh=LKa7nLQ/OY+8uzsjaELR8HjeURqxpqJKcJY5cLl/E64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttPqkWaJrlwzeJPxhfY0Fd48l6u1bifT+qq1XmoCsYB7H1z3TsPnlWSRARWlyiKKT
	 hLIiXKDT6ZS5jTgXqHpil89ppcSkwzo0XXYf0+vGInMOD1DmoHMHid/Vyu9Kvfh7ws
	 sc4YQdfENoTot5vmrf9ul8oBUl3/q9KFLexe398lEDW4RpaFWlo/asnvcTUSbegMAw
	 3Gl6OzalK+Daql9WO+pv9WJvi1WiheJK35F2WxRp93naqwI1Am2bqV4FeZUCkFNKPv
	 uUKvGiaBsPT0tzPkIt2+3VHg5OMcd5O0UlVorKsShkbAMlX/GGsY21awicWjhstsKh
	 4NEa3fGYscbWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F7F80D83;
	Tue, 17 Nov 2026 00:06:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDF8670B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAE5280D83
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHl3CZUqfrLF for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DB8A80D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T8zTcrfB
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB8A80D80
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-717080a2d50so4202079eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794873989; x=1795478789;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LKa7nLQ/OY+8uzsjaELR8HjeURqxpqJKcJY5cLl/E64=;
 b=T8zTcrfBzgloG24s/wPxdpjb787svDK6V+qJAHRQsXAmYD2rwCltRzgOjratrQ/JU7
 gIT3FcjBpxnr6C423sgHdunD/P4YtnQB9rbWomolz0fhefMqA1t4McsTNCQsDFvXnnf4
 PUq5RHE464vZK6/9szX79j606FlLCQFMTqoqE8W7kZxHeDVPd+7tNWlSNwCgCeT+FyYJ
 oKLp9bNHj5GV/Y5P9D0ZTBEjTLXpv/KE+KpNlitdjVHQnf4YGSWeJ4JV1iv+TAIL6AQh
 DFE3VHHZbgc9wA4cpRDaw5XJU50HZulkvwAor/ziL1YaDU9Yo/OedgJSb2OiSdY192td
 Q6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873989; x=1795478789;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LKa7nLQ/OY+8uzsjaELR8HjeURqxpqJKcJY5cLl/E64=;
 b=R+pEG6Bb/vwl1n7fmA50UCoPt5iM1Ou+gC+nx31lYaGi6wIufq4rSi2SXrzewic8EV
 mUKrD1n4TGC9DgUobRjO2Uq3U9EB6E1k6N2E1YjwhXMG1DHlBjtC7ov/NULKIECNN9Jz
 BYS4N1dpX0CzgsWenKicikNrxntZi8IEfO4p2tz6hG+fnYejWeg6G6k5i6IxJWVTAjW7
 NmBGtcZ5w+PZr5vSsNIxrHHCPl0ttIDBSxpuGV1HJWT1+hKm4tE1liR6+knOPxuPkIyU
 EiznmeLSdn0Jx5qskLxnoXXoKK6W833FpJBsrcTIdflfKOLLbbgZK1JIbuunK82/6v9S
 AXBg==
X-Forwarded-Encrypted: i=1;
 AL+hErFDvKGni6E5kJRD7LRs+6Kggx7Xkx82CLhp24sVcbdkB3cnB3TWhYWLXH1F8lz8wUMRZu4kIvk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9U3GoNpPDgeP6mFODJQngOXBTf+5HygzrttrtygjDHmng0vEIk
 uOaDTI1ebN4OiV2jhMwqieJHXS7fl3DEN7AOD7pFrBHE1oUild6WI0OCmnKwIhsAY44zJ18s+rw
 /Z50BIEg=
X-Gm-Gg: AYBFou0Kq6JoJcbwt7nd6QscX0ZWeK+MSNDoHG7zf3JuXN2jmJDSQZjAooE+Je+z9tV
 LJnQT0GpZuCwm32XzipsKgiaIVwEPw//tih1yoBe1bfHrv9P3/Tskl7AsKER8zIsEX2YkUWjS8o
 kJOviA9aM3oeYk8/ZXsR/s8NM7L7jVQG6zQZJkwJiQWWQFzJ65zGz7+ulYbL9n0PfHFDv+rgFGd
 WzNXs9ZLrQaQHIYvbPOgwYa/8yIDqZO6DIlK4Dp5r+PZF7Q9GCLOtrmsShyumYnbANsvh2GwEff
 SBVukp3wRNSOnDCLeZIzDLlC7UktcGIorg+0AdPvC3+GhCUyWpIIyDJLXMl5q6Nv136d6fKGjVf
 PxxW4wcqpefMJmWGQY/riSTll7vWOqaIJsmH55VUbjH5Q20bWOOGDUR0FuY7YnLJ8LjyrFiQOcA
 FFx+9ZL4lv6wQsCg9RYDgOBJCPYlisyiIBqHOSFNOviiI3dxn6xhjxtzxlpGFQGDWcCOo2kb/fZ
 mWfSG4XQCRky4+FGytQ/xN1bdXdBU47/amuo7nN0SJkgHIu863x/BqjpHrUVbfji9f/TPYBQy9g
 CQWa160qdk6hHiC7hWYywxfb+pvKxmASyto=
X-Received: by 2002:a05:6820:8590:10b0:71a:fb4b:a988 with SMTP id
 006d021491bc7-71afb4bb77bmr1620304eaf.47.1794873988810; 
 Mon, 16 Nov 2026 16:06:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862beb11508sm5097254a34.3.2026.11.16.16.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:06:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 18:05:53 -0600
Subject: [PATCH 1/3] arm: dts: mediatek: prepare Genio 520 and 720 SPI NOR
 for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-genio-720-spl-nor-v1-1-7a926f80dc78@baylibre.com>
References: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
In-Reply-To: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Xu5UZOdfElh72Khc0VD0/i7J+JBrnKu+EgVwfedvnYk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+5prVIRJ5JyaHuOW+UKt33dlriFTng2DPjHKi
 pPaGDjnFvKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuaaxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaJEH/01exdDxYoxcVyyMJwwQ9AIAakaeEGM9PJQKSTO
 5D8KBeIJCwTjghMqpNJoxZ8cte+6BUwCc0zxVzQQNsn5zemMfD8F+ZQc5a/if0d1m+yvloSvCE5
 B0RbVDgIouzMITXYvB3IiddHu7TSj3Ikou5DJUunTOaCQYYDmrAogu3P5xvgqDa4IsM6CEHrhAj
 9Z4T1XI3ykI6I8qBmD9neRuWl+JuRVQ5C/LZz/2I7+J46Jt8ggojPoYuCAseM+4FkUQjADbKbYa
 8fbmPnHzv2NvpmJuWWeXsjgsmvF6+ODWfdmQ/371/I5ELrPF6p/8wMyar0GKhqpcnuKR2xp9mYO
 ehj8=
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

Mark the SPI NOR controller, the flash and its pins for SPL, so that
SPL can load the firmware FIT from SPI NOR.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
index 7f614323c93..7785400384e 100644
--- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -79,6 +79,14 @@
 	bootph-pre-ram;
 };
 
+&nor_flash {
+	bootph-pre-ram;
+
+	flash@0 {
+		bootph-pre-ram;
+	};
+};
+
 &mmc0_default_pins {
 	bootph-pre-ram;
 
@@ -115,6 +123,18 @@
 	};
 };
 
+&nor_pins {
+	bootph-pre-ram;
+
+	pins-ck-io {
+		bootph-pre-ram;
+	};
+
+	pins-cs {
+		bootph-pre-ram;
+	};
+};
+
 &uart0_pins {
 	bootph-pre-ram;
 

-- 
2.53.0

