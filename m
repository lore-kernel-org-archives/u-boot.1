Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2305606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FlOTySCC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qT0oDOU0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDFF981128;
	Sat, 31 Oct 2026 09:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzrLlvEkJgY6; Sat, 31 Oct 2026 09:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 497ED81116
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439160;
	b=iO0nDxF3aQf+nYcVBvL8jljv4qdpCXHafbnYHlRXyCgb3rZ7AqK0qn6Ii2/ESs9yX2uc
	 3lkUelssHQwUCq49F/StIZhNwgPKrnozttbQb48cRctrxgJWuV1k1kdZSRR/b9EVzZmXt
	 1Sri0DTe/OAKT1rm4Oz7+Iw6GMtuo1OeMrgfV3KvQgw9dIorXypEjQv/cUXONDg7iWHny
	 aP6sTj1h6fAtHjVTPIJQ/GlIhehg4qgH6PiIpO9vr/kSeyLwNgFvT1wHSz7sP2z7klNA9
	 ZTCU7Wa3GwrJuXp8QZxP3MDpZ6BgVUZrsCaP5xXkWBzy/L2V+Sxj38FDE30X5Ll+fig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
	b=F69SfGhg+8YUv2JYk/W7CXZJYfjneVFZp0yJ5GiRyKpi5nUSAxu236SdWI45x0qtX1XB
	 oawYFVxKKWjDVwV5ZA5M+2KUxflI/bFCCoPldgNafRB4GASpAsteyTW40djfnJJ0q927g
	 +Inb8Zj7vCg+O9WgkYIYo+s+foY1U2ah2dji/sfh2rdv4jgqIJg3mMEjDvGgsL2BztfaW
	 nh0LW9UEM/F1kjhsSp7g36hhs3M4nUWVof2nVUWh1uwFtGyLazHoikyLvkWrllXAQlvSe
	 5uuq4+9eF09/bSV366cCpQIvwyeF3wPZnz1loJijeEc7J0ezPE0g2Uv/t9RLW6LYccw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439160;
	bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FlOTySCCq8U0QpP+68dI71g2Lp/SHHyA5DIYOAENwKQhoDwLuQsb8p8VqJ/BjeO1F
	 O4lENLfQwy5q6scCLNLtp5tYjDciuITGJPtvRDRhTnV5w8p0UUntwtxYY/zXejeMOb
	 EJH+vrVX/qmlKohSsz94m8f4WZ0yshYNW96b7BMv6S22+sAXzu5/mxRqid8K2i/tuf
	 +f8AjJ1D+F7zugqPHzL+M/GIbcJH4bWiELci+x1uL4hD79DlfDrGgTmZkaSs/MgAZw
	 Q/HG8d7juP8C4qaOmyQs/1OTSe5+PyNJj/MJOMMCz8iHsHKmFlC/zLgYFQ+mMcCA3p
	 3L5DbQNQLOJcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 497ED81116;
	Sat, 31 Oct 2026 09:32:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 779464BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74DE560667
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:32:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNAuTCFXT50n for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F007260639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::733"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439158;
 b=X9Bjt24qvfUwJ8vTrAuqYoe9fWF8FUz7OyZuMq1UdJHHKhXcBZP/JX5upx/lyQbQ5SXL
 5eMc0i9qcZY+ihxmChtAfUnm9fkOv7x+MlNuGeGkQpHDU2F+O2bBaDghjr2aTGC9goa4b
 jWtY39+yK/IB1wDkWU08gQ4/80Pr0esJE+jHMwNAfy0W+ahvoXUWWvsYDBdaZ3/pKPVYV
 mWOO43+LEMyweH/254M82DSmM8ZgV/nYEZ7y2Co7TepGE14B3VqmcjVaEwQv4ua718ng7
 L53u81kzRl6hu23IjqgGC7NYZw9Qq50vCMACVfGv29O8cUf9I/dv7Kt8Nre0+r6xciA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439158;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
 b=ruTx/oIp/SEd3jl6J/9rgJ2uIw+5MvgvhEdVkv+SM1VDkljwZdhdT2XrzpI26+by9y5e
 oA7hHxEBahG1rxG3sO6FUWxKpubLVydqTtb9JfRlUSWyCY7lXuYeoy0epLKDPgghWv1/n
 sUEGKo+4VLzzJ5X5jr4MeAOdE+cralVY5PjXDDk4gQr2tUPB2hPis5N0WkjYqwEyxMjhU
 x19+CT5a5DizyjGkeBzGb3Ij+VgkqhcgJ6qEsvjHgltyI6RaEqu6+SRRy3rmMGwLxuyOf
 xLfKrI+9pAz6ny8j9eMjZmZejLhJkeni17/TMFG57sDTjy3Br3MTBu6vL+TQoVHQAJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qT0oDOU0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::733"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qT0oDOU0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F007260639
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:32:37 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-93e515769d3so147254485a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439156; cv=none;
 d=google.com; s=arc-20260327;
 b=NubKGvY+fLSsLzMWA5/VtMUdXykejel0JkGriNw5R1LfyJIBDu5kYiHnYGlszJkfeT
 5BfQ9pkK+7VYSCD6ii3xf++Njpn1JXRt8T2TXnkBE7fHT5ox+sWsLT1Nm2az5rWTJ4a+
 qi4JnmuMbnPtjrhG+QiHQPU73wt6jsNpvxWlaveqpCccVYU9sLsiOVkJi888JCswjriO
 tnSeNAJtqV9y4IOrLt/QZYfZC4+UJgwFchkf9c3qitgiAvovj+DRLhiDBJ/h8/FaPvY5
 lCu1mjWJuZZIlYaBSkhYPWGvs4aYrCQins9JXsMwoDXQuC1A8MlLRZfvZXklpDWKKXZ9
 XCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
 fh=SSiWI4hR5gkEn8Qzo+h/RZh3rKlqhQ675k9ic39yMYc=;
 b=BEP5ENBQs0AQQzLYIrKjiWqaN9ijYEdJiBhEt4xbaBsV0twUU1hVS0JryBLP5Y/Zlz
 UUoDG0jae11U00OZAuTP2BCTOhipoXkDmZvlGh0SkQQ+NHJ3xilLV4qbQRlPC7TquCVu
 zQ9jMIIDm4HD7npuWJB/BRu1ywkYIK9fFjSSkp3L7FXgk1UktZMfG4ZYrEIWxzYDIl79
 ZnYAGmqOmGIJY2GdvOlr/4HeIqGmR6ueSdrQAlFm+E1QkfQWHwxNm25IaivWhHskV5if
 shl7+pCCYIKjygXxSZHwSRRlT69ao53RkUTtFjcKNXWVCpxx45KszRwOHSeqFEJ/dSvv
 z0Yg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793439156; x=1794043956;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
 b=qT0oDOU0mT2MyFcjDW5bfgeMS+nNTONDRci75uS+aj+txTK0lSUQZq8wPLL21mHai8
 QI8ayUrZtrgIUJ2WXK5cn96U8pgjKXnzUbUm6PwzZ/eiFwhcKl9JQ+3zs1gKwD/B5Zy/
 P5SumMtlfWbgWdrHmYujT8JDjSyEn14pqkLG7W3bMj0iU4zPOlvurtY0rQXF7E4Ro4UG
 uAgFFYTQDvp/EpJxr0KgmNRp9/xEi/axl1FJv/hSOFo1wcCadqyIWbRGOU/FDpWCtuoK
 TlGkF/TfitGX4hunZQLrhu5mfYKECX56P1T9o9SeslCnjzLeZoCszf2CgOWSO+VLVn8i
 31mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439156; x=1794043956;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0Mp1wofDMhhWOzDjFoNnNLk7peMsegRGzUYUyzCMEX0=;
 b=j8z/5BBNQ6NDfjWilgY9+hQIh6CZ5dkiJFfH2li9CNWNIlbiPhSLao96CLWersmiVM
 +u1SwrSm/+6Pee7o3BbuMmzgU6l0nBtyiv9Pg86TMRLEgzZmXAY7J5+g9rMrm3WmvR6b
 Jw41vkR+nUsyDD/JIBKRRykAPkYxRIDxspbgW+NcJp8Nl5iUzKhLqoV6B/7iaBB+3khu
 QBKL0eDNqWxcHo1GHfbXaZQ7+VkIeDW0W0AbPfLKTLEgcxYPgcaOQj5Cn0B70HX5EfGl
 7WeaXxPawzjvDnei5o+8kcxLOa+uuNE8iZhe4tKXc6OLADBhjod4k1bjtgryDarT5EYI
 szgA==
X-Gm-Message-State: AFq9FYKEwL94ZlydHBOnsgMTGigUaX6hU5wvEQ+DQtioZf4FOoHbauOa
 +lNfYqmWlBeyvQTmVNWUefj/LpWVGwHfQz9xIfRMP6afb1CRMV+vqHTQ9J5w3eTNum+TMjNE0ps
 lF1ClU7fIrOd4vAE8KbDIMIUt8gJ8tWs=
X-Gm-Gg: AYBFou0XrQaGIClSMwWrp5mxuVTP9R271IFsOnwSE49OX9tz69Dm9H9LQyLbY+c/GoG
 UY5YGy3DJpsAn9Ku8H8sNM06FjUlIOs5IpvB3idOjxfzS3Qq2DIyyIhnOn25ZMUSFhNwgDNqaCl
 aMk7/9Jn2DabG5UvdeiYLrqFMgU3b+8PfqtuAAJ3Jy0LZuJhrOWTFM6Hj2GK33IQzZ9FMTzIc9N
 tCArP60k/pT/pm56SCDF6HCGQHSs7sdJpb6LiKTQV4KKqsceoAvNZ0lEs+11XLeI0SwhIisoEYu
 lOzsYyln/KO6KgK2+bPg5wpcpp/fQxCq6zIQjsoNYV+hb0FWmsuhqUbewDd0OhVZZeo/F6axq6U
 C023/6MNVnwQyUafkMhF1fM6W1exWQeBmL3OKcXPjZfOlcHEeq60CwzbnoFb/m8kKStGjh5piNf
 QKwIyQTMA2hin56EBKPvQmXhpwUrFeHmxaB7aL/241+9chpmVmO26tpYUv5yBJQIkFRHtqW33m2
 1g1ykBw1NvtRFKTIUJMSeR/wSYnj8eog8+W
X-Received: by 2002:a05:620a:2901:b0:93e:4b3c:19a1 with SMTP id
 af79cd13be357-94421679a9bmr797483285a.44.1793439156407; Sat, 31 Oct 2026
 02:32:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
 <20261031065006.343477-1-nguyenanhgiau1008@gmail.com>
In-Reply-To: <20261031065006.343477-1-nguyenanhgiau1008@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 31 Oct 2026 09:32:23 +0000
X-Gm-Features: AclHuK-QZWqFbf7LNnClULK_4VLkHQP_FCReGy71MgURBHD06oz_HYDunyoNiUQ
Message-ID: <CALeDE9O_BH_GWrkhOdKTPpE-4RFxSZC19G1VA3364t9=iK_GBQ@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: Giau Nguyen <nguyenanhgiau1008@gmail.com>
Cc: u-boot@lists.u-boot-project.org, hs@nabladev.com, mbrugger@suse.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Giau,

> Mainline U-Boot currently lacks an I2C controller driver for the
> Broadcom BCM2711 SoC (Raspberry Pi 4).

May I ask what i2c devices you're using to test this on U-Boot and on
which generation of device?

> This commit adds a new DM-compliant I2C driver for Broadcom
> BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
> (based on Linux commit 32a0a94aa09e ("i2c: Switch back to struct platform_driver::remove()")).
>
> The driver dynamically queries the actual VPU core clock rate from
> the VideoCore firmware via mailbox property messages to calculate
> the CDIV clock divider, ensuring accurate I2C timing and baud rates
> on BCM2711.
>
> Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.

Typically the main config used is rpi_arm64_defconfig which covers all
64bit capable generations (3/4/5/Zero2).

I'll test/review in the next few days for a RP

> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> ---
> v3:
>  - Added the Linux commit ID to the commit message.
>  - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in drivers/i2c/Makefile.
>  - Added Reviewed-by tag from Heiko.
>
> v2:
>  - Clarified commit message: U-Boot mainline currently lacks BCM2711 I2C driver.
>  - Fixed line endings and code formatting per checkpatch.pl.
>  - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction.
>  - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard readl/writel.
>  - Moved mailbox clock querying to bcm2835_get_clock_rate() in mach-bcm283x.
>  - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>  - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
>  - Removed 'Assisted by AI' tag.
>
>  MAINTAINERS                              |   1 +
>  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>  arch/arm/mach-bcm283x/msg.c              |  22 ++
>  configs/rpi_4_defconfig                  |   4 +
>  drivers/i2c/Kconfig                      |  10 +
>  drivers/i2c/Makefile                     |   1 +
>  drivers/i2c/i2c-bcm2835.c                | 370 +++++++++++++++++++++++
>  7 files changed, 417 insertions(+)
>  create mode 100644 drivers/i2c/i2c-bcm2835.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c6c0c2a4bc..3260024a736 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -215,6 +215,7 @@ F:  arch/arm/dts/bcm283*
>  F:     arch/arm/mach-bcm283x/
>  F:     board/raspberrypi/
>  F:     drivers/gpio/bcm2835_gpio.c
> +F:     drivers/i2c/i2c-bcm2835.c
>  F:     drivers/mmc/bcm2835_sdhci.c
>  F:     drivers/mmc/bcm2835_sdhost.c
>  F:     drivers/serial/serial_bcm283x_mu.c
> diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bcm283x/include/mach/msg.h
> index e54da86e353..d6adec07ae2 100644
> --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
>   */
>  int bcm2835_get_mmc_clock(u32 clock_id);
>
> +/**
> + * bcm2835_get_clock_rate() - get the current rate of a clock
> + *
> + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_...)
> + * @rate: Returns the clock rate in Hz
> + * Return: 0 if OK, -EIO or -EINVAL on error
> + */
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
> +
>  /**
>   * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost cdiv
>   *
> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> index 4993c0bdb81..74f847c5e54 100644
> --- a/arch/arm/mach-bcm283x/msg.c
> +++ b/arch/arm/mach-bcm283x/msg.c
> @@ -115,6 +115,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
>         return clock_rate;
>  }
>
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> +{
> +       ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> +       int ret;
> +
> +       BCM2835_MBOX_INIT_HDR(msg_clk);
> +       BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> +       msg_clk->get_clock_rate.body.req.clock_id = clock_id;
> +
> +       ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_clk->hdr);
> +       if (ret) {
> +               printf("bcm2835: Could not query clock rate for %u\n", clock_id);
> +               return -EIO;
> +       }
> +
> +       *rate = msg_clk->get_clock_rate.body.resp.rate_hz;
> +       if (!*rate)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock, msg_sdhost_clk, 1);
> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> index f5fb322aa8f..2ddaf003558 100644
> --- a/configs/rpi_4_defconfig
> +++ b/configs/rpi_4_defconfig
> @@ -22,6 +22,7 @@ CONFIG_MISC_INIT_R=y
>  CONFIG_SYS_PROMPT="U-Boot> "
>  CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
> @@ -34,6 +35,9 @@ CONFIG_DM_DMA=y
>  CONFIG_DFU_MMC=y
>  CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
>  CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +CONFIG_I2C=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_BCM2835=y
>  CONFIG_BCM2835_GPIO=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 52067fa7c1f..1b26906e403 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -164,6 +164,16 @@ config SYS_I2C_AT91
>           i2c-gpio driver unless your system can cope with this limitation.
>           Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
>
> +config SYS_I2C_BCM2835
> +       bool "BCM2835 I2C controller"
> +       depends on DM_I2C
> +       help
> +         Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
> +         This driver provides standard I2C support for Raspberry Pi
> +         devices, including the newer Raspberry Pi 4. It dynamically
> +         calculates the clock divider based on the VPU core clock
> +         queried via the firmware mailbox.
> +
>  config SYS_I2C_IPROC
>         bool "Broadcom I2C driver"
>         depends on DM_I2C
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index bebd728e7da..aac6ce4b6e0 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) += i2c_core.o
>  obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
>  obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
>  obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
> +obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o
>  obj-$(CONFIG_SYS_I2C_CADENCE) += i2c-cdns.o
>  obj-$(CONFIG_SYS_I2C_CA) += i2c-cortina.o
>  obj-$(CONFIG_SYS_I2C_DAVINCI) += davinci_i2c.o
> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> new file mode 100644
> index 00000000000..e6abb076bdb
> --- /dev/null
> +++ b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM2835 I2C controller driver
> + * (C) Copyright 2026
> + *
> + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> + */
> +
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch/mbox.h>
> +#include <asm/arch/msg.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <i2c.h>
> +#include <time.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#define BCM2835_I2C_C_READ     BIT(0)
> +#define BCM2835_I2C_C_CLEAR    BIT(4) /* bits 4 and 5 both clear */
> +#define BCM2835_I2C_C_ST       BIT(7)
> +#define BCM2835_I2C_C_INTD     BIT(8)
> +#define BCM2835_I2C_C_INTT     BIT(9)
> +#define BCM2835_I2C_C_INTR     BIT(10)
> +#define BCM2835_I2C_C_I2CEN    BIT(15)
> +
> +#define BCM2835_I2C_S_TA       BIT(0)
> +#define BCM2835_I2C_S_DONE     BIT(1)
> +#define BCM2835_I2C_S_TXW      BIT(2)
> +#define BCM2835_I2C_S_RXR      BIT(3)
> +#define BCM2835_I2C_S_TXD      BIT(4)
> +#define BCM2835_I2C_S_RXD      BIT(5)
> +#define BCM2835_I2C_S_TXE      BIT(6)
> +#define BCM2835_I2C_S_RXF      BIT(7)
> +#define BCM2835_I2C_S_ERR      BIT(8)
> +#define BCM2835_I2C_S_CLKT     BIT(9)
> +#define BCM2835_I2C_S_LEN      BIT(10) /* Fake bit for SW error reporting */
> +
> +#define BCM2835_I2C_FEDL_SHIFT 16
> +#define BCM2835_I2C_REDL_SHIFT 0
> +
> +#define BCM2835_I2C_CDIV_MIN   0x0002
> +#define BCM2835_I2C_CDIV_MAX   0xFFFE
> +
> +#define BCM2835_I2C_CLKT_TOUT_MS 35
> +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
> +
> +struct bcm2835_i2c_regs {
> +       u32 c;
> +       u32 s;
> +       u32 dlen;
> +       u32 a;
> +       u32 fifo;
> +       u32 div;
> +       u32 del;
> +       u32 clkt;
> +};
> +
> +struct bcm2835_i2c_priv {
> +       struct bcm2835_i2c_regs __iomem *regs;
> +       ulong input_rate;
> +       size_t msg_buf_remaining;
> +       u8 *msg_buf;
> +       struct i2c_msg *curr_msg;
> +       int msg_err;
> +       int num_msgs;
> +};
> +
> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +
> +       while (i2c_dev->msg_buf_remaining) {
> +               if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
> +                       break;
> +
> +               writel(*i2c_dev->msg_buf, &regs->fifo);
> +               i2c_dev->msg_buf++;
> +               i2c_dev->msg_buf_remaining--;
> +       }
> +}
> +
> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +
> +       while (i2c_dev->msg_buf_remaining) {
> +               if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
> +                       break;
> +
> +               *i2c_dev->msg_buf = readl(&regs->fifo);
> +               i2c_dev->msg_buf++;
> +               i2c_dev->msg_buf_remaining--;
> +       }
> +}
> +
> +static int bcm2835_i2c_calc_divider(unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       int divider = DIV_ROUND_UP(parent_rate, rate);
> +
> +       /*
> +        * Per the datasheet, the register is always interpreted as an even
> +        * number, by rounding down. In other words, the LSB is ignored. So,
> +        * if the LSB is set, increment the divider to avoid any issue.
> +        */
> +       if (divider & 1)
> +               divider++;
> +
> +       if (divider < BCM2835_I2C_CDIV_MIN ||
> +           divider > BCM2835_I2C_CDIV_MAX)
> +               return -EINVAL;
> +
> +       return divider;
> +}
> +
> +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
> +{
> +       struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(bus);
> +       struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +       ulong parent_rate = i2c_dev->input_rate;
> +       u32 redl, fedl;
> +       u32 clk_tout;
> +       int divider;
> +
> +       if (!rate || !parent_rate)
> +               return -EINVAL;
> +
> +       divider = bcm2835_i2c_calc_divider(rate, parent_rate);
> +       if (divider < 0)
> +               return divider;
> +
> +       writel(divider, &regs->div);
> +
> +       /*
> +        * Number of core clocks to wait after falling edge before
> +        * outputting the next data bit. Note that both FEDL and REDL
> +        * can't be greater than CDIV/2.
> +        */
> +       fedl = max_t(u32, divider / 16, 1);
> +
> +       /*
> +        * Number of core clocks to wait after rising edge before
> +        * sampling the next incoming data bit.
> +        */
> +       redl = max_t(u32, divider / 4, 1);
> +
> +       writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
> +              (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
> +
> +       /*
> +        * Set the clock stretch timeout.
> +        */
> +       if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> +               clk_tout = 0xffff;
> +       else
> +               clk_tout = BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> +
> +       writel(clk_tout, &regs->clkt);
> +
> +       return 0;
> +}
> +
> +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +       u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> +       struct i2c_msg *msg = i2c_dev->curr_msg;
> +       bool last_msg = (i2c_dev->num_msgs == 1);
> +
> +       if (!i2c_dev->num_msgs)
> +               return;
> +
> +       i2c_dev->num_msgs--;
> +       i2c_dev->msg_buf = msg->buf;
> +       i2c_dev->msg_buf_remaining = msg->len;
> +
> +       if (msg->flags & I2C_M_RD)
> +               c |= BCM2835_I2C_C_READ;
> +       else
> +               c |= BCM2835_I2C_C_INTT;
> +
> +       if (last_msg)
> +               c |= BCM2835_I2C_C_INTD;
> +
> +       writel(msg->addr, &regs->a);
> +       writel(msg->len, &regs->dlen);
> +       writel(c, &regs->c);
> +}
> +
> +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       i2c_dev->curr_msg = NULL;
> +       i2c_dev->num_msgs = 0;
> +       i2c_dev->msg_buf = NULL;
> +       i2c_dev->msg_buf_remaining = 0;
> +}
> +
> +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
> +{
> +       struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(dev);
> +       struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
> +       bool ignore_nak = false;
> +       bool done = false;
> +       ulong start;
> +       int i;
> +       u32 val, err;
> +       int ret = 0;
> +
> +       if (!msgs || count <= 0)
> +               return -EINVAL;
> +
> +       for (i = 0; i < count; i++) {
> +               if (msgs[i].flags & I2C_M_TEN)
> +                       return -EOPNOTSUPP;
> +               if (msgs[i].flags & I2C_M_RD) {
> +                       if (i < count - 1) {
> +                               dev_err(dev, "read message must be last\n");
> +                               return -EOPNOTSUPP;
> +                       }
> +               }
> +               if (msgs[i].len > 0xffff)
> +                       return -EINVAL;
> +               if (msgs[i].flags & I2C_M_IGNORE_NAK)
> +                       ignore_nak = true;
> +       }
> +
> +       /* Clear stale status and FIFO state before starting a new transaction. */
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +              &regs->s);
> +
> +       i2c_dev->curr_msg = msgs;
> +       i2c_dev->num_msgs = count;
> +       i2c_dev->msg_err = 0;
> +
> +       bcm2835_i2c_start_transfer(i2c_dev);
> +       start = get_timer(0);
> +       while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> +               val = readl(&regs->s);
> +
> +               err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
> +               if (err && !(val & BCM2835_I2C_S_TA))
> +                       i2c_dev->msg_err = err;
> +
> +               if (val & BCM2835_I2C_S_DONE) {
> +                       if (!i2c_dev->curr_msg) {
> +                               dev_err(dev, "unexpected completion status\n");
> +                       } else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
> +                               bcm2835_drain_rxfifo(i2c_dev);
> +                               val = readl(&regs->s);
> +                       }
> +
> +                       if ((val & BCM2835_I2C_S_RXD) ||
> +                           i2c_dev->msg_buf_remaining)
> +                               i2c_dev->msg_err = BCM2835_I2C_S_LEN;
> +                       done = true;
> +                       break;
> +               }
> +
> +               if (val & BCM2835_I2C_S_TXW) {
> +                       if (!i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
> +                               break;
> +                       }
> +
> +                       bcm2835_fill_txfifo(i2c_dev);
> +
> +                       if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->curr_msg++;
> +                               bcm2835_i2c_start_transfer(i2c_dev);
> +                       }
> +               }
> +
> +               if (val & BCM2835_I2C_S_RXR) {
> +                       if (!i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
> +                               break;
> +                       }
> +
> +                       bcm2835_drain_rxfifo(i2c_dev);
> +               }
> +               udelay(1);
> +       }
> +
> +       if (!done) {
> +               val = readl(&regs->s);
> +               dev_err(dev, "transfer timeout: status=%08x remaining=%zu\n",
> +                       val, i2c_dev->msg_buf_remaining);
> +               ret = -ETIMEDOUT;
> +       }
> +
> +       /* Always abort/reset the controller and clear W1C status bits. */
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +              &regs->s);
> +
> +       bcm2835_i2c_finish_transfer(i2c_dev);
> +       if (ret)
> +               return ret;
> +
> +       if (ignore_nak)
> +               i2c_dev->msg_err &= ~BCM2835_I2C_S_ERR;
> +
> +       if (!i2c_dev->msg_err)
> +               return 0;
> +
> +       if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
> +               return -EREMOTEIO;
> +
> +       return -EIO;
> +}
> +
> +static const struct dm_i2c_ops bcm2835_i2c_ops = {
> +       .xfer          = bcm2835_i2c_xfer,
> +       .set_bus_speed = bcm2835_i2c_set_rate,
> +};
> +
> +static const struct udevice_id bcm2835_i2c_ids[] = {
> +       {.compatible = "brcm,bcm2711-i2c"},
> +       {.compatible = "brcm,bcm2835-i2c"},
> +       {}
> +};
> +
> +static int bcm2835_i2c_probe(struct udevice *bus)
> +{
> +       struct bcm2835_i2c_priv *priv = dev_get_priv(bus);
> +       struct bcm2835_i2c_regs __iomem *regs;
> +       unsigned int bus_clk_rate;
> +       int ret;
> +
> +       priv->regs = dev_read_addr_ptr(bus);
> +       if (!priv->regs) {
> +               printf("bcm2835_i2c: cannot get base address\n");
> +               return -EINVAL;
> +       }
> +
> +       regs = priv->regs;
> +
> +       ret = bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &priv->input_rate);
> +       if (ret)
> +               return ret;
> +
> +       bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
> +                                           I2C_SPEED_STANDARD_RATE);
> +       ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
> +       if (ret)
> +               return ret;
> +
> +       /* clear FIFO + status */
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
> +              &regs->s);
> +
> +       return 0;
> +}
> +
> +U_BOOT_DRIVER(bcm2835_i2c) = {
> +       .name       = "bcm2835_i2c",
> +       .id         = UCLASS_I2C,
> +       .of_match   = bcm2835_i2c_ids,
> +       .probe      = bcm2835_i2c_probe,
> +       .priv_auto  = sizeof(struct bcm2835_i2c_priv),
> +       .ops        = &bcm2835_i2c_ops,
> +};
> --
> 2.34.1
>
