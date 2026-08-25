Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3E0C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8442980CCE;
	Tue, 25 Aug 2026 20:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5W7d01w2m8J; Tue, 25 Aug 2026 20:02:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787688158;
	bh=cBah3B2c3qnt4Ktm3GOTJIAw/4gB65vlAEihC79d07I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ONEqnUMEekbsfsk6ScmSf0ldXjMieGgfL1+sIJYqt5ce1XcC0nYo39t7yMJSirrae
	 yTPDWMP/HghvLjRHeigKceUQGq7bwYjhs0TDj1ANgCgYAdpM5Lhlw93KlzvsKhH19Z
	 /O9xa6iil+pmvHSPGvsFt9kndBO+uyWY3JrMt31P1lTUi4qqvVR52ZFKlrcYeuytpJ
	 02hcVFNP9VA/7kVYu+T0nnSe/fAULlR5tPFEOhw0eNM4LH6ltX0C/JtzyptfmuCFOl
	 Mqm8ImUetijfLMoA0wVS6B8BlHLOQiJpH9m+rN8FZTv3qAQQTzpmpm3+evvCyhSdff
	 uLLtF8KhaNX0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A74C80BFB;
	Tue, 25 Aug 2026 20:02:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFD9A105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0BBC400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_DdbRpstujI for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:02:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jz6yDQnb
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B775840055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:35 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 46e09a7af769-7f3a9f626a1so72568a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787688154; x=1788292954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cBah3B2c3qnt4Ktm3GOTJIAw/4gB65vlAEihC79d07I=;
 b=jz6yDQnbAVvPE9mgpVErhjpZFUoYaFqwPB6ouBKgo5y/9AW/wVjZ7NUFBHQyA88KqG
 jj9Q3whBidbPYSxd1mjfHpLNSSyxjwdUovVgV5ckZrOxu2OJ0t9lHOpUHV0FNL5MdzLr
 5GKWKYtYpg+lDBdD9J3gb9Rx1vh2K7877RvVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787688154; x=1788292954;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cBah3B2c3qnt4Ktm3GOTJIAw/4gB65vlAEihC79d07I=;
 b=Po4EBbbGvCp9CmKRKpIBrr935GQZwZrC8ZyIrIkOBUhsLWf7YmTkGQ7zehHac25G/S
 WhaNIGEYgwgrogptYr970IiiofKBloGuMVSsup9ltIpaaBUIUoeyff6F9NS6LY0hHpQu
 YSW2Vlbc59scdsyuW1q+zvKkxqTTaWwQ04fZRZrxZa9nwFQQSoCe7odr7HM6fFBBUaTI
 wq+51Jc2asnqkait0ivhZ7DbcVo70uOvXmzMV810hZFeIUlKZetXr8e5pOYOXMhTq3bp
 JiN690SvCK9L7o98ZBnRfLDRRo5YLGb9Mq9p7MOZbW/1w6wRu4juqhi2HzZqEvHKf75E
 P3HA==
X-Gm-Message-State: AFuF++kS8792zhAgfW5y2ZyXPY8VBUtHGFoj6qXIjsVMecb4P19vD2XB
 UyRlGUOkhElb1+IxLUX54jZjkSg1Ot+Z82akP4ekQYkxkytOyyAVS5LzkJG+IdxR2ScLediehZE
 XWZnEOM48NHJHuio=
X-Gm-Gg: AR+sD10l5EPJ7pGyfeA6CCsbLy1KirltvB2HF1erSj3aM/sDxzn++Bn7gBRSbHOgj5Q
 zySlSkEQ6ZbjQT9K2Jn2NzOkOB4V+AfGLXIQ2tTkNnv1I4a5dUioHSsrtNIAJFU6GIlZ8bwhleg
 OCfvZSdcQ4zXyz1dGciGdOFU1EsuK9n8qzDb4Bl3YRiTMZ4N4CAOBjGXAjdmersms4Dw9mZjW3J
 b+y27bCE3jK7ri3iMtbHzXgBsq4afIHPZDg9kshqa9SL6c9jpzDSkF3bT3O+RZHdTgwCv7JiAwZ
 u9XGoMUiA018kNH7Sdv9f2gAjaiaduje0JQOtGkLeNAHzcWg51KHsanQFDVD1uJsy0Aqqymx1l1
 ZruboKMm63k5qaziz9kx11kFEXY0HZX+4PWslSqoORgnlvGbFV4B3fJBd1tAVn1M3FI9IRcI2Ew
 XXdatGWsQw1L+62WptEY1ey7Xxczw1l/PoNosMwsps2Rai8uRmbS9TiHmAgpV/3OqrQIYvW8TKp
 Mzerj0LU3S0U2HDSyT3pukaXq9bQsj93NBJkpyn/YhLfNhyabunfE+fTekjFdbz9eeXreSVzMCh
 NlqYQGlq
X-Received: by 2002:a05:6830:f8c:b0:7f3:c7a9:c4cd with SMTP id
 46e09a7af769-7f4c4b7c747mr1551739a34.2.1787688153886; 
 Tue, 25 Aug 2026 13:02:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c421063fsm410994a34.2.2026.08.25.13.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 13:02:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260825011050.2805858-1-dlechner@baylibre.com>
References: <20260825011050.2805858-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-08-24 into next
Message-Id: <178768815283.2351905.3228685399702801930.b4-ty@konsulko.com>
Date: Tue, 25 Aug 2026 14:02:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 24 Aug 2026 20:10:15 -0500, David Lechner wrote:

> The following changes since commit 5a92645e1f9020d24d19e03fff2ae63f30080770:
> 
>   Merge patch series "Add eMMC support for Axiado SCM3005 board" (2026-08-11 14:55:40 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-08-24
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


