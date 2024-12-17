Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A2FE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FF580224;
	Tue, 17 Dec 2024 18:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wqy4M5Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A6ED80107; Tue, 17 Dec 2024 18:18:14 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCD180107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467a3c85e11so30142311cf.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734455891; x=1735060691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3Yr9ou5BIpjqMq+yiGHmG2crlEGHQu5keKjtjxT2sg=;
 b=Wqy4M5JbBPgkzKBt5AQ2oSbPLWDJt2vpKR23SUBTNaqoajzijUVuWYDGr3l+ajrKBx
 gJpxmzPkQ3FMa7ZUVmjwBNE+3ZSdbp5QJnUx68SqyE69h3rq15yUq7BmfCOMXwizcep3
 W5JjfwPiCkKZYvWmKAXuOn8UWGWT0ioouR7hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455891; x=1735060691;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3Yr9ou5BIpjqMq+yiGHmG2crlEGHQu5keKjtjxT2sg=;
 b=YJSAi5ZjLmvxkxCn2b2AnCnAwqpex1XNblhnb296CuCtNau/OKVP04EpExTGud5Icr
 wpfHXuvAa3U1O5Jsu6AL9wHSDAXJP1CqwVa514peSze6Z1cAtPfEXLIiWJ2bJKR+2t2H
 Sce/wIIT32POhrBUrkum7qlcjl60uUowDcIpxaDik6HZ+QzOOxoePSyFKuvDO2MBYDnK
 cZvlSrFsErla8ZKrHvVi6D7tmGskdWf8xqlrNosrPRMLv4RUNo0vmK/rxBtvUSpNkfFX
 ZWrbYRHaCIfN6DdTlPvgMeJXLR4nWSvrV3Ibc9DiL8mjraql0frhdNs8pdoh1r8GkfHi
 9/bA==
X-Gm-Message-State: AOJu0Yx22MR+B10xbHbNOU6SxJpw6JFFDxq04/UwAbZ09LnJ3CklmZqg
 4eBL0Du7zNS1z7ueAorWlhGLYk4b+x9iGSTi+4El8mkHuDdsFvu+oQXXbZN3TI0=
X-Gm-Gg: ASbGncsyfEjCmmp0soG3/g4bIV7T8+bi+Wi2c1AiA4l5OkKY1sfLQNU/uIW6JEBhQZd
 uTJWl3o7pgh6yHwrMnnKY/KWdmI93Lx/HVrftWGuwiVro0AHfR/WzMBBJQGbt4nFY2PZmGChAYC
 T1YA9WhyL1wwbkCY2ABtI8Mg+y50usL8FES3uAzJSgQhRPZjYKHQkoh8IEbXv+sDPM6NUTyvHgp
 en5r2nKKiQ2sQ0oBRwLgRX1tQtrvnM3u5ptrXNHK/HIiyPHmNHmTIw=
X-Google-Smtp-Source: AGHT+IGXeNEwkF4U0r2QpgYdXwQPuTqEXmT7Qu4+t9wpSiSB44EiDUBwJk8Q91tUtJVDNmeHLyJNSQ==
X-Received: by 2002:ac8:7f8a:0:b0:467:4f0a:1b5d with SMTP id
 d75a77b69052e-467a5829d50mr244814511cf.42.1734455890701; 
 Tue, 17 Dec 2024 09:18:10 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bbe9asm336450385a.94.2024.12.17.09.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:18:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
In-Reply-To: <20241211131858.520639-1-sjg@chromium.org>
References: <20241211131858.520639-1-sjg@chromium.org>
Subject: Re: [PATCH] test/py: Always use the current dir as the source tree
Message-Id: <173445588887.4187054.7330271372420229440.b4-ty@konsulko.com>
Date: Tue, 17 Dec 2024 11:18:08 -0600
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

On Wed, 11 Dec 2024 06:18:58 -0700, Simon Glass wrote:

> The logic in get_details() retrieves the default source directory from
> the Labgrid settings. This is convenient for interactive use, since it
> allows pytests to be run from any directory and still find the source
> tree.
> 
> However, it is not actually correct.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


