Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD6EFF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151ED8416F;
	Tue,  7 Apr 2026 21:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l7bzfGdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A93584105; Tue,  7 Apr 2026 21:50:16 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F3F284118
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4138136f02eso3615294fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591413; x=1776196213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0nQriX1Em613QAfU+aNtUi0EtXGPzAKpqaWgm9AnWw=;
 b=l7bzfGdmxJ4ZSo3fHFakKPtHScUv/TBHWEVh5vSJHeZDK9I90aoIzXnfSNXekdtj7O
 k/DaS1GV4TEOlTyzQZczn3+IZxzbbQqclVFMC12KmXqEAbriUJe0I+47uXzqcOovWiRy
 PH4kYi+PqnpaCboi8P03p4id0VXwhql4XoZu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591413; x=1776196213;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O0nQriX1Em613QAfU+aNtUi0EtXGPzAKpqaWgm9AnWw=;
 b=RkdWaNZPWuliLzMEuzUoN0OkfpoHqTY1+3vzsC+QSXDGLg+Jw5P4Jxma7juv+dyhyf
 20VSwzJOrQv43dyf5fRgJSWdwMLEeA/+PT86OjtVrQy/sxbWTQMmMMk3gSZeTKgUO1CH
 qhS3V5YslCP+a3XauHV+5paniJkwrzsDvDF1T9COB1qtm6LjeunwIRiT1fmcA9Tocq0Y
 b+o35OuP18kb3e6ldS2gX0Z0d77I3AmhGJZTBlhPqTKmNeo2C6fzR/NwXjLeVUHRTKQU
 CMm1uZeNWCJASBo9eBIMXi5cJyxk3K8ZNWXV70Hnwu/M5G0IhNd2XqJNMIHYx45FYn2O
 +PrQ==
X-Gm-Message-State: AOJu0YxPtZLVrGHxQyppYn5wi0Aj3nmvFUKBPz7oCkNfuaADCvQGa7mA
 3zIFVIKyDnKrxRdmBXNCzkAPbkhKXq5MOBFo0fPlj/n/rnwHGXXLeKOqZcvZ4GdwZphFJypTFwC
 JOLVOG6o=
X-Gm-Gg: AeBDieu/DMeYq3DNXNopXTysn7uCGCqG9fkUL+7zbTRk9KYBnweFaymvaNIQz8gc9rt
 4/R8itNBlllH8Zzk5lDO17kAVucWi2HggTKYwMk92u0mJWUDOAwHuApKnAp79Q2QQAGIb4o+p8r
 NZJXA/Y3UWmMMrCDIF7tB5JNjxuYDulxUDv+UXmhqT3pYyS0AhZnU4u0L8QRsLgutf6AmMs1KnQ
 UjDDQCdl0cDRaBLzMdETa5z41WkGzRB6tI+LJD+P4LXfvEieRs2RWL6s4AYCmCouSA4CMPGVLjC
 phvb4XvLrsBMbVaQLNcyuEa0V7+w/rafivD6baWTug8j59Q/ySjwgrfzttTnGoNucm8R60jZcze
 86KnkULyrejgrvAuy1as6PmOA9SQWfwjFrxm8trNcQYsVWie9eoGkhmgAKLxiDLn/N1LA7QsWsX
 IuYVDZlOZosefr7htW2NNVbJPTxKZ+98wQFrcTtbqWDyeMtWT5c0bG99hnF62b3Rm2AU1vsrjMG
 rhKtN0SbRr20wYsHT7m0/jwUOxSAX+4Pu9wuALRzvpuT54=
X-Received: by 2002:a05:6820:4719:b0:688:6d55:17b with SMTP id
 006d021491bc7-6886d5503d7mr1144267eaf.51.1775591412973; 
 Tue, 07 Apr 2026 12:50:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195247.2363434-1-trini@konsulko.com>
References: <20260323195247.2363434-1-trini@konsulko.com>
Subject: Re: [PATCH] lmb: boot: Update dependencies within BOOT_DEFAULTS_CMDS
Message-Id: <177559141233.2108693.1002921080352417995.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:12 -0600
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

On Mon, 23 Mar 2026 13:52:47 -0600, Tom Rini wrote:

> The CMD_BOOT[IZ] symbols have a dependency on LMB, correctly,
> currently. Make sure that in BOOT_DEFAULTS_CMDS we only select these
> commands if LMB is enabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: boot: Update dependencies within BOOT_DEFAULTS_CMDS
      commit: a6594e82bb93bc14d97ca16440f6387fa3e0c111
-- 
Tom


