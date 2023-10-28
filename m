Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC51C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 12:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3754D878D7;
	Sat, 28 Oct 2023 14:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbaDCwKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2026B87881; Sat, 28 Oct 2023 12:30:13 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B98C8787B
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 12:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=viraniac@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so4630011a12.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698489011; x=1699093811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mg4LJQvk+Tueb9IE5aguOSaICgurfEH2Lts/tdGq9Kc=;
 b=ZbaDCwKnnUnSey1hIQ2+rRjcY+EG2HV4WZHDks8I+Jj1kLICa3s+A3+xzJfd5GV1WX
 vFAtLu8OW+VVQYKwiyocuVjh3rKqtpXPBJU2/9rIV1AskFR+rQSNkAu/EZ3JxJFZ0CuA
 /24oiJt9gcckH2AV68ym2TR062Ldpa3q316WNZwkLDRTkXn8WtgBn3iOF/Nv9QGxAlmK
 E73BSucMb5+npYGcHzJI6WzGTIfpqmV9j+CzBxHT1XxzZL7C1EldVKU6eOYtsVyecKVf
 /b3bpqcMw0fslyzBcWJOaJ1DvdB8A5Hs+vtmdPIWU1ckxMPYBlkdSe3jwFmZTAeLOfGV
 5gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489011; x=1699093811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mg4LJQvk+Tueb9IE5aguOSaICgurfEH2Lts/tdGq9Kc=;
 b=XYdHDpUvxQdF8Kwi+GxrO4J+5F6SMXf1xWkGTbNkmOSD2+NvNg5be/53yrTdfAmIuu
 YDBpb0YWxYTEwpqDea4HEnmJNUICnTM8mz6/jPbWIVD5jCg75wnXeB32DI49SnSs/Kjq
 /cnWqOY+92EKi0+ohmUuCOmz5IQQIjmxpCbb3WpHSDBSc+rK9t8KR9UPjEgXH4PY/xCt
 GoyPkulipqmmSPD/mG0iAnGzN6qT6TSnNJ+FZWu65yDoCoZZTt4nbw5A9XK/sBOpLhu+
 SExxNdQZH1lMdPT2tLxVjCBW9z7Rt/fCObqgYcwIih54YhQuLUiNApEJ2NQunBDi/fBz
 Sodw==
X-Gm-Message-State: AOJu0YxOnuLRb/WG/aTvAbqO+42TX+LDzDd9Ads3RvdJDJ9E81VGxNjr
 O1xfqXvd8cq0BOXErZ9+4+Ojm3IFqXlt5Fimmwo=
X-Google-Smtp-Source: AGHT+IHYym988qIYMK32l3W75LcN2YUyrS+YwCjie3tOzWj9XZxjJ+Ot42KQwb5aVoSc7KxYEptVPb/ZFqtnEB8VO04=
X-Received: by 2002:a05:6402:2910:b0:53d:f180:3cc5 with SMTP id
 ee16-20020a056402291000b0053df1803cc5mr3625802edb.20.1698489010623; Sat, 28
 Oct 2023 03:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231021011025.568-1-andre.przywara@arm.com>
 <20231021011025.568-2-andre.przywara@arm.com>
In-Reply-To: <20231021011025.568-2-andre.przywara@arm.com>
From: Gunjan Gupta <viraniac@gmail.com>
Date: Sat, 28 Oct 2023 15:59:59 +0530
Message-ID: <CAJAzxbUcH3OK7famdZSAzDZM9gP6qDWwRL72ks9WDj7YVNjYPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sunxi: DRAM: H6: add barrier after finishing DRAM
 setup
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 28 Oct 2023 14:59:32 +0200
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

Tested the patch. With only dsb, it hangs within 5 reboots itself.
Adding udelay(50) moved it to once in 20 times. But it still hangs. So
this patch does not solve the problem

Thanks & Regards
Gunjan Gupta
