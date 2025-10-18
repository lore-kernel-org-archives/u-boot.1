Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457B5CCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 14:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B790883771;
	Sat, 18 Oct 2025 16:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RC3LZZbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4A4837B6; Sat, 18 Oct 2025 16:07:30 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A89883631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 16:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-441e193c001so1353926b6e.2
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760796447; x=1761401247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3S76BXPXEcqXUBK4d+xUovYMaaIg1Frx7cJy6Mbk3k8=;
 b=RC3LZZbbtILkgHtqMXEEyM240zRADuAIfnDSsGbx3r2T8eVdEC3gMQWNYndU1xDUuA
 gFkO5wzNzHVuX+U6vrHl/2HcoEyJ7Kx7PAkRzAPLmDrUEHpndaxpvCDDgrgN4X04NOi7
 fJw0/Mb4TZw/BJeKcMBwVsNR2ruZLHdCUNWt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760796447; x=1761401247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3S76BXPXEcqXUBK4d+xUovYMaaIg1Frx7cJy6Mbk3k8=;
 b=AAd6oaTqo1KJzO9cY3XdoqtDvjPdc9m7yknpa0XK12r7B5mCaRfcSYHXQR4wZT/Cqb
 zTgzBMG3y7iwBdxgo0hi7NAB8m6kIM9WwN6/SUxS9xwamn4RYW7tJmV+V4RAiwpGu4fP
 Ww516ixuBnqjlD7zDabWmfqTUoADOkgjFgwLNpRhbcS9Vh6bEFs0bHAMqsLO1w698VXR
 IfN/BODI5t506GaX2hzxVGHiUhtp7yNMO9fJ5zfL95U65qOK6aogLr5GoH22Um3o1I4/
 mnWD+d+gF1SIvzYMza+8NT40033INrHg8qmQiP6anZKv3DxetVEbLJJjGZpGgZxxUiSx
 qvgg==
X-Gm-Message-State: AOJu0YwF+7hPOC1NEqM4YwdxXfWWB9MzquXt0VqvyEr9JNUm5UI0AaNq
 gEDc34YsK36eww64TY5yBIycRhSX97oW3ouByITSIYKrpsKOjU0a4wvA8PDeTh9jIPs=
X-Gm-Gg: ASbGncvbjkdwCFcB/SLuQY9SJS5or8mb/TdvkrLGr3yeuaBo/T4p/3kTxQSzussbUT0
 SEPHYqlyUjlU+C5USST9lwXGZt06lI3pozNqL1fO//CBzuAyQVTCTdECHwGuJKIhnmV44QkeaSH
 IjCAVHIXaou6lVUMLv61DJ47kbW58LVIy8OsEP3fgbN8IsKbuq4kMZD1MjzUpPFayrw1z/XZ0Fx
 ljJmYmJ+mdFLS6g76Vf9Z/e3SodJHQaoSSOMU5xpDCz91e3UDkOYx+URVAIkzfCZ60LVNDlUVRx
 4TPZsdzJFuG49Tdn018D06atZecW9FFX8nmKfGDFJvyLnPpbJRpqCBS53dGdRYY7cVxg5xsmDoy
 oK6KUx46C50o3bbZS2kf+nyzBKlSruRqPFfuXouK2L9e9CCjROA6R/uVwHWHjTcFAebgsiR0R9d
 xvo8J70983ZmOlDt4ByOsa6cHPpbm887DcHgqtMaS+T0XYZCW7
X-Google-Smtp-Source: AGHT+IFxfvLDi0NUQg7Z7FkE0LQStzCjwdjRrsNdRBOlUGxC0vXgTLQBWAmPEjFU7u4axXYMADHeCw==
X-Received: by 2002:a05:6808:181e:b0:438:430b:3dce with SMTP id
 5614622812f47-443a2dfa130mr3174007b6e.10.1760796446815; 
 Sat, 18 Oct 2025 07:07:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3f2fa57sm618972eaf.14.2025.10.18.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 07:07:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251009130844.11703-1-patrice.chotard@foss.st.com>
References: <20251009130844.11703-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH v1 0/2] led: fixes
Message-Id: <176079644510.1878470.6565620492889693742.b4-ty@konsulko.com>
Date: Sat, 18 Oct 2025 08:07:25 -0600
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

On Thu, 09 Oct 2025 15:08:32 +0200, Patrice Chotard wrote:

>   - Update led_get_by_label()
>   - Fix led Kconfig
> 
> Patrice Chotard (2):
>   led: Update led_get_by_label()
>   led: Add LED dependency for LED_ACTIVITY and LED_BOOT
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] led: Update led_get_by_label()
      commit: d9915318b5d8dd9c31209541c1d99ab0edb339ac
[2/2] led: Add LED dependency for LED_ACTIVITY and LED_BOOT
      commit: 827ccb84ff433001b59168d81a59489e339ec2c0
-- 
Tom


