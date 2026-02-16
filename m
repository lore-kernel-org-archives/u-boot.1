Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84638E63F15
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EA883C61;
	Mon, 16 Feb 2026 18:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fBVB9sTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4705480325; Mon, 16 Feb 2026 18:18:17 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D944480FA1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4c65d772cso2804663a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771262293; x=1771867093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIFHozuORgLTZPODwCSweUAXN2f8Hisxm3txSyfn4d4=;
 b=fBVB9sTYZHYuXKGDKeBVIdGdSUiIpZgSQDm4flXXRAIKpmYKg+m5L7D8WCGCs9Go0J
 3K/pw7SJrwPDiCz8ddZFUWMI7Bjvh9slpkfzIqTDKJhoITijkfMVaow/pzT34tK5H3hs
 9v/xGZWgrohAvSPAHsdGuvB80SImoGuL/5CkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262293; x=1771867093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kIFHozuORgLTZPODwCSweUAXN2f8Hisxm3txSyfn4d4=;
 b=anYFa+gUVIxS1FfkHkPX+mhOBJY5UefLnRLqL4wRkz+zkXOg0AZT0GcqU89jC4j/8B
 5cumw0Fa4x8KmlOH4l3dAGDMHK9TtMUktJsT6xJSsOGdF0JeaEarJfcIPJrt8VFav32U
 ek48UgyuK7aSgc+eb9DWVIp0wyjkOwIgzJaLuawtQ0p976vKTs5xXNnMJubli+6NhbqP
 31jEwYAPQqperz6o9v7aICrMdhPXiqtUtH9B1d5GKDTK7FAZHf9HqvGFolt42iFE/rzo
 T8PozDMXLSvK38AlG6JaNXNKNZhVmmWTbj+TdUU2YrKfZzKRvy4ScGliU/JcqFl3BmLO
 FUtg==
X-Gm-Message-State: AOJu0Yz5K5lMKnJ/qaHlDIQu8RR09XWm8n4P3QjDLGt403osQqd0Cxjt
 JHooI5+LlEE10yRn26fPPedFxfdm2Cj9i5SodxwlvnOsBUDlMH7gdLQ7dHjXc6KV704dyPqip59
 BXLVA5y8=
X-Gm-Gg: AZuq6aKWduI9ixLrG3l2DaoIKSDme4u5faA+sPPnyXmBfYhOU8LRM74jmrRe6xU+YIg
 hmS6jtuWpQkgR0q2ZLTqX4dgpBJnWlwvE6xkGwYVMvjkcQTOJplclBFEX2KTpB3fyOwnU6bE1YZ
 rmjb4+UzoTcldKh+ak5Q0kpelsRBFmBZs1O2SMSUg9jVtJYnLpQBc7KrqoUrypEeqdKImOplq6i
 G5Oaye/zkZ/ys4CsNckFjpUNlGNjde+Z+mdDl9jpap4uoLvw6TRw8qn0nHFdgv88r+86cMngGda
 uYXsjvhkZ0yT5J/pycEHMhWUtGvlVN7ojfBe5gzTWM2uTeIrw2kahTmWmcx1l8dR+eKpZK2nrbR
 KsxFvL4keBiHJkeXe0JtCSnBEJ6T4JFo/XfxD6AhbjTpq+Yxaa0OiEp2yjS6mYqK2Ugz3V4o9Mm
 /akiRenpNSZPo757WFofu+ss+JItNuj9LXova/wBfY9K6yvteVv/bWxLe4GpLHRN6NnkkI9IUWp
 t+c+MQj5TgRa9Gh8SCD6GNgiYqYEYigDf11IkiV8FL6GQg1xw==
X-Received: by 2002:a05:6820:4df5:b0:662:f837:e6ba with SMTP id
 006d021491bc7-677667ed0d5mr4777452eaf.17.1771262293611; 
 Mon, 16 Feb 2026 09:18:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-676f444f315sm7276998eaf.1.2026.02.16.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 09:18:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <aa956239-7433-41f9-9189-10a95e5633b9@monstr.eu>
References: <aa956239-7433-41f9-9189-10a95e5633b9@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1
Message-Id: <177126229295.2533124.1657633635906064410.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 11:18:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Feb 2026 08:37:18 +0100, Michal Simek wrote:

> please pull these patches to your next branch.
> 
> Thanks,
> Michal
> 
> The following changes since commit 9e6b66409a3235ae73f1937929fe025911165bbb:
> 
>    Merge tag 'ab-next-11022026' of
> https://source.denx.de/u-boot/custodians/u-boot-tpm into next (2026-02-11
> 10:42:18 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


