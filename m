Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D2D46C15
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 23:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40A583BFE;
	Thu, 29 Jan 2026 00:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/0BAp5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AB383AAD; Thu, 29 Jan 2026 00:05:32 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C00D83B86
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1890f7cefso250102a34.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769641529; x=1770246329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUpuAgKlliaa3MtH1BZ3ZRLK0zEjnyyzArziHmfpJec=;
 b=a/0BAp5qnfdIDHDJONLms2HQiIEBi3NMaNjchkQHdELHq2HFcGqPUb320CrKKz3d1R
 ptnStRSl4vuE5RJj2OHhDhnoqzOq4vRvznDNefdI4HmfzyZQWKnFTDF2yezZlkn/daD8
 nI8GzCMqVmctq6EatqOAOPrPAdM2lmJZxRexA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769641529; x=1770246329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUpuAgKlliaa3MtH1BZ3ZRLK0zEjnyyzArziHmfpJec=;
 b=vHrNlUlGsvb8mZBRJo6n4MyG1Kd2lQhM7AXCu1lEWlvd+nJnh3PRMr22zNFz9qKM/w
 KHrGsyUeti2XcMIDKlg+0jCZhAR4EPM8ANM9DSlDwfzEfIIS3XrlQAVXnx7FJzYMy5be
 yXWiT0ygzn1nJO45jClmju6CKE5mtskXhprMVklx63t74txu7LEKbS5MZiW2bW2yY/Oj
 VaLdhcT22Zd1KQFhOGyCogSzGMf1PsBH/4J2GS5fp4N+5WtkGQD/xPvJtXUvh66TBfLe
 iUeLa6B6c8xPEJ8+8to9DffQxGuTFg5ddwHnYPSJOd5k4lGmKQ9nzO6jPCLyTMlBd0RW
 9EeA==
X-Gm-Message-State: AOJu0YyvES1EkmuGwK0GwBqhhipzsAInWVNtImsZ2HIRbbmCfJf16C5Q
 fKcQkkgUUn6GEHGVBIw+BEr3zN3/86bzsJQVM1K0SseJgfkGHPn7+MMmGihhy7hskXQqLk/2yZJ
 HfoyYrwk=
X-Gm-Gg: AZuq6aIWCz8AswYcY+DPCT3S/I+nyXKcueqWokKQeCyQ8Jgn4AQiBYq+F4PovYPapUk
 kGlwf3Ox0zNYcIC0myy2Evk7rPbiUIaNuJTNmkNSGvAAnGx1ZLIT2BtXPNUyY2dF0HSkepO4rC5
 7gtdyvxx+SXYZp6kebqTQvcpqFBVWMMhDlrXSGYrTFxdbTKUVAz/BqioHsx/EVxYjiW24UoLGLQ
 1ICrVainndLLXiadNe13Mx1mhe/D6blnhGbP0YmjF+OmVmFHMsGbfWQav11hQdlTJNbav2bWeD2
 0/9HWwy0iYS4zWOYmmsCZUtgWDVeswo1yHPPSNeDsIhLnsy0n/TwDBQN5dqJjUVy6l+UZsCYmLA
 rg250vBG8CBAYh6Yf0JVqWwayQOcSddTmKRsD0hjcbIwlKfryBq+OAROksXRz1GeIOEYUbH8x7h
 o7a6oI74VDLTIPa3BW7AHaEpePJgHwIyjSrTP+SAqsCylx8TK6gtayKsv7LM6ijh0g3nwwz58TO
 66hZ63FcuXF1pmGOovEu4YSjeB9Rxu3XMV+ow==
X-Received: by 2002:a05:6830:658b:b0:7cf:d191:3a76 with SMTP id
 46e09a7af769-7d184fd847fmr4703694a34.2.1769641528869; 
 Wed, 28 Jan 2026 15:05:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c82e494sm2598076a34.28.2026.01.28.15.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 15:05:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <a937a2e4-2bd0-4158-9b74-55131054c2ab@canonical.com>
References: <a937a2e4-2bd0-4158-9b74-55131054c2ab@canonical.com>
Subject: Re: Pull request doc-2026-04-rc2
Message-Id: <176964152825.1796592.8303451057903605998.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 17:05:28 -0600
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

On Wed, 28 Jan 2026 23:53:20 +0100, Heinrich Schuchardt wrote:

> The following changes since commit e8ec8d980a31c4a1d665e4aa9089d6aa27cb0d0b:
> 
>    Merge patch series "dm: core: Support same compatible in host/gadget
> musb drivers" (2026-01-28 09:21:17 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2026-04-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


