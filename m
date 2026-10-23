Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D8606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DC1UK00K;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOG/cCiQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D207460A6E;
	Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoTuT4UCTptd; Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DB4F60A5C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793925;
	b=HfqdwKIa2dsdat2+JjtUO3gdUAFUJCiuYs7B4PRJZ9GpA1EelsaL99SoztnqWaTyyr7O
	 6Btjk2t4abCt+UL1fzOLJX8rCMwxsZNtghI/XZC+hPlHMHb8NXzi8NLIBQJ2CoExYg2Vw
	 YauSNW0tGvt7oPQL8ILghI11Ao/6//VsJeYa22IMh6HsNU3PDG9WxvBP9uoHAljMpLEwm
	 YDr2lBeThz5AlHoeQQOALwKBC3AQUduN4o49BH1Ir+uVjHHP/l73AvsuXy7k18IRbc75w
	 9jk4tvM0+Opc2991buGZw3IXBkzNJf70LSBlCbBk5DkKlzKXkhrsouZ2i6vUZiWm+0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CnOdE2lfVJLLajofeAv0Lx8uc8EUR+GbRPOKWDuTEyo=;
	b=kAt3Ju1QLeArzNsO7qNuashBG/o+zibUxOPsdRPNFLR9eaC5KjgFiSDUi5Ee/wS5Q23r
	 hO3MCtpa9QDQGs7BMA9oM0f9XsBZ9w+r775yJh3UwugPkKOHUu8WQIZmAjqPfdmJ+z4dX
	 HSG85qCeleYQjA/wdcJgm7OlT+7TUXbn1OthieAFlzNvS+2J96UVMEtbi76wc2N8QN1FG
	 0Vl8EbBKuZZ9OxF/L8uAo/r+N6c5gXIow/gscu9IcWCoQmwNzLLchbg9PuIFacsJjKZF3
	 8ac1pnXOyg4KviNSf/Kxp3WZwH4nG5AmWFeTJ81sRI6XbydbQjxfi9PtO8BLmuAaOvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GOG/cCiQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793925;
	bh=CnOdE2lfVJLLajofeAv0Lx8uc8EUR+GbRPOKWDuTEyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DC1UK00KQbsW+hZO7fPKepdv8ORVJjg5MTnkxbr/3D/kVsS7oOtfNdZroLfzQeiek
	 BZWlSiBtT2Nv1oyNq4/HZWuxm6volVg/JuBc8nyvMqrZG6VY9unY80BmpkV5dcSaqj
	 3BybaajGDdJc6xjkiv4FcNaNEatY+scXz2PtM2QM1GMZpxBKoqOJ2hekAMX6cNhin+
	 QjGbd1ogrW+QBoHiL+7UTNhl2WsztDXh8jcUgzgK2TAb+ivjjZX0zZzjR1xzU+L3aT
	 Eyhc14EgQqaH3TcbFbq+b5WkpJgFVILGwXfZU7qjKiWFMvMwDmBLyGTpUJen8rQMJ7
	 FqLfCj5R3RV5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DB4F60A5C;
	Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08230235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA5A960A7D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3iTRGlMbf0W for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3286560A79
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793921;
 b=QBwmPvxqWvK0MoqcTc+hPBItJcGwxeUh4ehz/kIhzQ+jHNEeo5QwFeUlR0kagCdYfM5B
 gjAY/I+Y+wNd41wmZ2AStz0s997h7RpScpP0/x0N8imXwGdbcABBcqwc3xQApsrnTL86t
 RUwSt48Vnk0CgBjPqD10ahZJSOnQzpachqILbbBCS5I5MxKvzDfQn2sHFwmodGZMLS7QX
 9ybfGrEnd33kveXzabP/uihjm0X2kfli1TOSt8Z1dGtH+rtXsmUtyB8upee2yZm/j3W4e
 +F6EyRKCvgeVrMKymT3VSE4cE7+h4jEkeN1RKD2Z6D2dMpcZ3Dg0KkJgbvTuw1Q767Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793921;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CnOdE2lfVJLLajofeAv0Lx8uc8EUR+GbRPOKWDuTEyo=;
 b=sxWx9p03ZCdZGhekHFjWk7VX4VQ4LQjcj3RhLR0fHnATI/ZLdVhM8AsTkCla7hruYJg0
 8cGkHFfItKx6UUv3Y3BjGH8tt+d/9R7JKBkcc54qqHVh9xKydW/9cxdphyHK31dT3tv76
 zI7u1O92wRHXUuspwdgBmR34fv5BKCB8qEToAa+8tRVKs98KJnuV01hZnnEJI0IV8YofY
 DZboJg1+swtbqImWloFeoluFKIUcMvZVxuKEqW3mSUDX0hB2ju7ItUlUDPF3O6U2oPtZs
 TQBw7gvLaS3nkid7Jj+WQzPuMjShFTl7rmyUzo/hHAVkoyQxmdTcPL88Orj0WxcxlLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="GOG/cCiQ"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GOG/cCiQ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3286560A79
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FD4B601F6;
 Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A00F1F01825;
 Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793919;
 bh=CnOdE2lfVJLLajofeAv0Lx8uc8EUR+GbRPOKWDuTEyo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GOG/cCiQ4hXm06k6ajWqOCXraHXtwIB2wJhGoeg2EFpk4sw5HRuEsYhty+hks2wg+
 NychO16HgMjZWlhHFoTkGUdgebet+zw/lwJEGekVVBvAIt/uJyYfzWk/2x17hTOxn8
 xPYP9OvktMZDgaLcfQ5kO9CsXhrU9lLax0PUm8tmyVHIgF31CqplSAEKHU0T2Jaq04
 qEpPjJL6fJTWz/82/j+YzU3qVpADfu14PFhoHY5t4TZMWeKonZyhauOTg4YC8hRmcN
 LpARRrxafgvDdJyeVN8tR+mjuyt8SS42h1eI88yvSo7ZJVU9inKEA4Lb0flhJBUkVb
 6FZDFvy96EEUw==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:30 +0200
Subject: [PATCH v8 3/8] arm: u8500: Enable SD card regulators
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-3-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Have ARCH_U8500 imply the fixed regulator driver needed by level
shifters on the supported boards. The architecture already enables the
regulator core and Nomadik GPIO driver.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 00f3cd9ec4db..93a0c663043f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1307,6 +1307,7 @@ config ARCH_U8500
 	imply CLK
 	imply DM_PMIC
 	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER

-- 
2.56.0

