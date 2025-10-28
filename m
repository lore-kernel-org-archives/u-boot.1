Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBEBCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E69838CC;
	Wed, 29 Oct 2025 00:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ue0MwDRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B333C838C8; Wed, 29 Oct 2025 00:57:38 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F0A836B4
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c67d9577b3so825121a34.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695855; x=1762300655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Om5DbJNxL8+GzTjv+yIrNfiWY1kKMWl9JUhYdjPHAXI=;
 b=ue0MwDRM5kU3Lr0DQ/5V81vxzakonhlj6DgtXBa1XkKQDY8++YkMhw0V32+qDlXuw0
 DkkCnQGXK/kc5G3L4qJ6HwmAQHSIPQYuKyQF99N1uY6yn+XMQmF63ZntG3y2VqyWsJUb
 +vgCYHeA0SAPsPEH9J4LgQnx6peDiO+XCfLQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695855; x=1762300655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om5DbJNxL8+GzTjv+yIrNfiWY1kKMWl9JUhYdjPHAXI=;
 b=BGt0EyxkVRy6Lq/kpUU0zgY0RKzWQrHMcdoQb6Xl+42Jm33uLiIUtO7uT5XYWmFyn7
 5BVrH36fEA0bM0U2yFg/Xj4dcbmbQt8UPlLzjg/sIWK95bxpQ17dvNcEbXLCaWpfZ8bA
 +fZAF/RXQJRH9kzYJ4Gn2H/2MHnYC5z0OQfaWMgpfY3CgEvOujodhLWdW5oFEuSGJCcz
 +R7LYIcofz3LQpTJ56lOJLOhKN2O/6PcEwx3TGxfvj++R7PtssC5S7CC4uZIcfAl5FPs
 y0rhof5cECyE2K0b2mrFCLssoO1sZdbLiWOMfgX/5rv+m8m5uzfCmhq+7smmxETKTIWT
 +JFw==
X-Gm-Message-State: AOJu0Yw3wxZEMuFaSW94BjcPcvXte+MeSZ0A+c+C27fABL7uszGJa5Wc
 gpxXY5lV5kz/uUfk8ioBJLrTg06jqgbmSoi8luuS3xUjaPbY63s2JXhYqrQ4ZuI0if4f310cBrr
 TTdyU+FGRNw==
X-Gm-Gg: ASbGncuEr6vxNEn+pKhD5XSm2XItQau3u+7Q2R0q+kNI/tb432zc1hpk2of76vej0e7
 hnV6g0BqQ7VmIZ50PbI4uWSNzYOJfvIQko94FzjXM5HrJYKkaCljyKGA9Q2u13KDc7iGVzkDp86
 CdgoZmlurRBthv+ZDxG6x+XGra03Mjgour+YeGqewjZ9/r46qLUGKYCvBDakNFgUOd/KJHlYfNd
 4N9YxcYuvp4jMkqlGo7kumepaNZw6AViY2znP8CqutD03x/vmmdpXwO7ZtliRzwIqcg4F1I87BY
 Da8QyeVpqObbOFsL8eBN8+87SGisLu8zPcXPsvzp6htfhPgprXSQq48SBBZmtEXCU+ySh/bYfG0
 bpNF+OF2gS+EjJPo9kHbz1IgiuFVHn9OoXCissANP2ed5IHxAjF5e/L+P3d8kMi8W/1zMd1I9gq
 I3anNb2FGK0nj/nmB6pnd1AsZjQX/AHg8p/if0Ew==
X-Google-Smtp-Source: AGHT+IHg2oIcFbZnDHJNTkodRW1FRdUi0RZeRih+8arVfM6kunm63Uk7ZhXMUUIrWZ7/Bu7Yvxd/gg==
X-Received: by 2002:a05:6830:638b:b0:7c5:3bd4:18f6 with SMTP id
 46e09a7af769-7c683078525mr800476a34.16.1761695854799; 
 Tue, 28 Oct 2025 16:57:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711151557.2224209-1-trini@konsulko.com>
References: <20250711151557.2224209-1-trini@konsulko.com>
Subject: Re: [PATCH] mtd: spi: sf_dataflash.c: Make use of 'z' for printing
 size_t
Message-Id: <176169585369.2287207.9315816434468815053.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 11 Jul 2025 09:15:57 -0600, Tom Rini wrote:

> When printing the contents of an size_t variable we need to use z prefix
> to the format character in order to get the correct format type
> depending on 32 or 64bit-ness.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi: sf_dataflash.c: Make use of 'z' for printing size_t
      commit: ba05f1a8d7d8f2d4f7ff244dfc29c1a7b87477d6
-- 
Tom


