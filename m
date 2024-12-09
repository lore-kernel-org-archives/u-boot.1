Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700EEE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4128975C;
	Mon,  9 Dec 2024 14:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9vkRF+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD508975A; Mon,  9 Dec 2024 14:30:05 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B85E89750
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2155157c31fso34161305ad.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733751001; x=1734355801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FjGlzAVaI9ROKIol3QINSwGfyOpl+LVUayomuB7tLz8=;
 b=d9vkRF+zyypiRo8AFKuNUPRIRA9F0cZC8xzcfkE3gnx8kT93DRg2gStXnoFOnOu9j6
 WCq2Cyyg/ZPMRi27TY8YVTbJMIUHkFoQcJL2UXn3vxAbuwxqwGBNy8Kt6pi44omr1f6w
 FCm1AL/y3hy75CPNZGbLfus+t2VEDh+VpdZF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733751001; x=1734355801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjGlzAVaI9ROKIol3QINSwGfyOpl+LVUayomuB7tLz8=;
 b=Gl33T0qrw2MkUoVRLaQ9WfjRCuwEgQzqM6LlBNJJ3wiHEvD5RUohXh4NTXlJHiwEDA
 sAKMUwqodcLCMAiCmvt5lxnhYfvq2gAF9pGpIrZE6/9z/9d/wb4nWJUqALC2H397+5Gf
 X2GTytmJniWZ4Al89y7jzQUP0xIq8eca1v4B2xMuitgn3ouvtIyC6j75vHbppqkk2/FR
 Ksijy3y3ZO69+iLCGOkptSaC2BTy0yFyTQgbuk9ApjXVkv+pTUUldX42zsbGsUyQJ4oP
 iBIvFYOwP6avren4h7U/wQvY7UpjEzfjKosXbinpM21HYtQYjSXtm84PDTR7lqWiPa4w
 ozgg==
X-Gm-Message-State: AOJu0YzxyriOlz10Akxzh3c6A/7Cq1qkMDzf0UjCN7AplAOCZOfrAJ8f
 BLJfshKLN9B5roA0vspQqz54d/Ak/VY2VKCAVs+3cUNlL3mWr6CndVcvR6kz4Fs5x6y4KBZeM68
 TrgdBWuaY/PN1rm3AVNSpv1GU1EYyc99kEH6j
X-Gm-Gg: ASbGncvHRU3Zs8KnsrWIFbRA3a33ejHa7aw5kBbGtBXSzvJFdQsUkk8A6RL95fnQgI9
 pvQf79ZqXODkqv9u+suDh6+YEy2ihy7Cw
X-Google-Smtp-Source: AGHT+IE7vcU3GhlMo9zvYtji7sI9OcvvKX9JATYbfd2upxKeDRCZajvEkVvGFclNJBLnHiTI2rUjxZ2yi2sYZ6lEY3k=
X-Received: by 2002:a17:902:ecce:b0:216:4122:ab3a with SMTP id
 d9443c01a7336-2164122abc1mr67817665ad.1.1733751001712; Mon, 09 Dec 2024
 05:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-6-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-6-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:29:20 -0700
Message-ID: <CAFLszTjpt83j-zPCG8wQb5Te823BLu_R8Lr+Sqe60F2Lu-ad1Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] Gitlab: Avoid downloading all artifacts in later
 stages
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> In the test.py stage of the build we mark the pytest results as
> artifacts to save, so that they can be used for reports. This however
> leads to all of the artifacts being downloaded (and then not used) in
> later stages. Optimize this out by using an empty list of dependencies
> here (which is the keyword for which artifacts are needed).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
