Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F17C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3BE835C0;
	Thu, 10 Jul 2025 01:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="beFE5C0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B57835CB; Thu, 10 Jul 2025 01:18:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876EB835AE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73c89db3dfcso99215a34.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103136; x=1752707936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxgzwtql1Ywqr5Tr1MgRE65N1DU5LT4xgZ2FvmMU2ss=;
 b=beFE5C0YqrwmIRrYbLG/6t1iR228iXlE0gum18HwwliTPql1Jg18O01c1uq/VODPyw
 DOorVFDV2N8+kKmWgZFvTzkoyRQSyBosDAd+QKWnxvHoqE4nKsB3njHpnxiw1KH8fizi
 N12XEDaxHlhzVJMLuQIxSpUH8yIUfoMrS9y/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103136; x=1752707936;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxgzwtql1Ywqr5Tr1MgRE65N1DU5LT4xgZ2FvmMU2ss=;
 b=rkrHHOOgqEmzN7IJmGfnMc+BEY6hhor7RUhCsASZddCOKk63/AAjD6srgjR24cIe5f
 b4XdVEgemPIOUNX3MEPwvXpZgBR6/De9VRmy0TaPL7gp7yu4TZ1zMoQEIMdK73C+sBF6
 9ntaa25QpZ8KF45ghpYl+g2nEU8egPxRc95bLQ6P82x//q6gDpXfu5uqR2tKYwGUgHEE
 l/3/7uPG2vQtyauzBgDyqDpVM7MjALnJJ/7o7gvSr/RmHsnncxIRtImG0V+bOUgZnXZ5
 2+4Wu5+ji+CfctxnJbsymEYBP9rbYek3dKJ1VZV2nUT1UA5FhaN7yAOsnM7vxuxNpmXh
 aFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwQslb/C5Zfi4WGjiR9m8N55h/W4F1jfyN0fxIU/XC8R8FbrHlCU0uu6lJ1t3XUNR2lkAdudY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxsh7XIQYBJd1atuzinYy8+Cn6avl5KoBGd3xDzTB4ynncL26jv
 H7Zp0U3OZq+tXc45vuuPybvHLEHW128GyLz/sXC5H91FdZIFtjDAhafLV2sp6avEqmw=
X-Gm-Gg: ASbGncvpwE/PGjTY94W8BR0byaqeQGgy7B+ePkX/cTIbyholLuXzRXfA6DGWgI71vqz
 UUwlP87KzhNLG+0voCKmL135GIeFtFM0JmqMwbfpcyaluKPTHzGHh7+SZfZnx+CahiOcC/hpqX1
 LFaeS5ID34UoVwl3gDYVr/NVge5iCRYzNH7oh0j3rBZa7PhwG120Q3uSHDE12b0cfi1b74NE6cC
 IDcVDflLUczLH0ZVNeIDKjXl4hij7xDjfVePHFh5asnfg3vgFk9Sn6nq5mCz2JpNePyI5Nu5AwF
 N1ZxUtIbkaf2yWn8ALF3YOp9PgvOGOtjZB+AOCDzDhZxfk5pFNVUEKKwe2fk+Prw0VhfCdVHxyg
 eJ07+46dS2338ICY802kJJ2jNsbStUQ==
X-Google-Smtp-Source: AGHT+IHNE9ZRZJgzhyPuFd4LEbx8DYBMtEDGRh9pieuzhgsRQy6Ug9ihoOdGQ+mCvQMWtfNuNc7jmA==
X-Received: by 2002:a05:6830:258e:b0:72b:9d5e:9429 with SMTP id
 46e09a7af769-73cf0606d88mr386521a34.12.1752103135977; 
 Wed, 09 Jul 2025 16:18:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:18:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Yannic Moog <y.moog@phytec.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de, 
 upstream@lists.phytec.de, Bryan Brattlof <bb@ti.com>
In-Reply-To: <20250701-pkg_resoures-removal-v3-1-270188b335ae@phytec.de>
References: <20250701-pkg_resoures-removal-v3-1-270188b335ae@phytec.de>
Subject: Re: [PATCH v3] binman: migrate from pkg_resources to importlib
Message-Id: <175210313488.1870480.3949394322282242612.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:18:54 -0600
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

On Tue, 01 Jul 2025 07:45:37 +0200, Yannic Moog wrote:

> pkg_resources is deprecated, use migration guide in [1] to migrate to
> importlib.resources.
> Keep the Python 3.6 backwards compatibility.
> This also fixes the binman version test which failed for setuptools
> versions that print the deprecation warning.
> Change from __name__ to __package__ as with the transition from
> pkg_resources to importlib_resources using __name__ results in
> TypeErrors [2].
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] binman: migrate from pkg_resources to importlib
      commit: 538719cb6a77934d069e0e64f264457a59a9ebfc
-- 
Tom


