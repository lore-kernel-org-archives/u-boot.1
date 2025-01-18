Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6387C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 20:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1558F80141;
	Sat, 18 Jan 2025 21:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jilq1JvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBC6801CF; Sat, 18 Jan 2025 21:58:32 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C8C80077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 21:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so32530031cf.0
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737233909; x=1737838709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d203k98MnlSUAl4rE5QYL26WJ5tugEgg9gN1qqYaJ18=;
 b=jilq1JvJCOUk7su1mlo3f9VRLuFMrATAqlFLQcAVfVwMyzxLEk9WI/ll5k9FWLMR1x
 1UMwMjajjRj881IVDHowcw2AZZ60l8yxSdQAbWbliNS+YYMNIKTp628jV/n82MpATwRH
 Mu0PLGhW7xqJJAxhV66ATXcxSkdfhtvGUZNaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737233909; x=1737838709;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d203k98MnlSUAl4rE5QYL26WJ5tugEgg9gN1qqYaJ18=;
 b=JOXbqn6B5PT6yCUA8FpyI4W1rUVEAD81QguAO5zBag9pZnfO7kgLVcP7L++6FEB/AG
 3Ine1eGk9gQ2iU34RTQ5ehOhUAyyLzyxeORr23AxQqVvdSQ9DkZdeNPJPWT0ZlK5QpyP
 qv6MTB8ZTtYzDQG8Gp+72Ty7REz51eFtj1J6wzEI9hFqX6H9zit1qbLYklC282acp3yp
 +uOgaLt67QDsWu9djwm77zT3aU5KgRTZf5XSi13vR2xuWCo5wZaxjIUUGOg80fXk4Hr9
 j3N4rLx/tpXXIs/2XTyeArNpbsebfcWjENwxbU1p+z1rY3YB41OKv2Z/c6j9hFFQxnr6
 yKpg==
X-Gm-Message-State: AOJu0YykoGK3U/p+CXUYWNesLcA3sT9+m3SvdgSCkOPwywxktDOD95qX
 pSxGoIzechq0SL1wJmahoPdFSEkCax0v5wj5DyXgTGNGta9hU1GqkB2+Oe3/fCE=
X-Gm-Gg: ASbGnctogObmsHY9kI3twF2Vnf/SmoSwr3sPMTKnIt5LP5OZLtQFfc6LJNbroOwOPZS
 ArlbwJm5PhmooMRt39ZAv9AWRXAe6RojaN4U14HhkDtDMlklziMi4y/YPJknCiBDPLyYkQPqzuQ
 X/SiEPB2NL0KE7gsBZqi/Pz4Kk1krxNH082Y0c4oUgB0iW26SnmI0+EUzty6CpsqRE+Az6Txn/z
 2cIhz01lqk5/HtM8a+L9sdqK5z1qiiHKh9gJxUUet8El0w+dr3Bqrj6lKekEFDZBg==
X-Google-Smtp-Source: AGHT+IHBUEKIOUPXPTEN80s7pT4c4O4jOFYtcfT6CO29dXpl3+LtW2jNZycxHA0aGqs8hX852GVguQ==
X-Received: by 2002:a05:622a:134c:b0:466:77d0:5941 with SMTP id
 d75a77b69052e-46e12a25347mr98667311cf.10.1737233908818; 
 Sat, 18 Jan 2025 12:58:28 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd3651sm24869006d6.80.2025.01.18.12.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 12:58:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Andy Yan <andyshrk@163.com>
In-Reply-To: <95436c0e-14a6-4771-859e-30c62e2c4df2@gmx.de>
References: <95436c0e-14a6-4771-859e-30c62e2c4df2@gmx.de>
Subject: Re: Pull request efi-2025-04-rc1
Message-Id: <173723390702.2590043.17030464061072914513.b4-ty@konsulko.com>
Date: Sat, 18 Jan 2025 14:58:27 -0600
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

On Sat, 18 Jan 2025 16:43:11 +0100, Heinrich Schuchardt wrote:

> The following changes since commit c11dc783fb4418393dd08d39ee01debfc2dea4d4:
> 
>    Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
> (2025-01-17 08:27:40 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


