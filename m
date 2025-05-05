Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC9AC3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6380D8288D;
	Tue,  6 May 2025 01:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I5BGhcox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14489828B3; Tue,  6 May 2025 01:35:32 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE72D80079
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f6eaa017d0so3990084b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488128; x=1747092928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OW3ImW0hKWUhABAePdZfdNMkINgZoKHhhQSdVpIy3pk=;
 b=I5BGhcoxvDGopNhoPx0gh8gWOAVdJv+LMrAjWwJzHQscVsxhidzzDFY60b9JYhRjyO
 1arRtW2Z40mU66JFYVFL6KEUNQUkc7v3VZocw+Smyazz/Kk+3osU35afYITMpwhHl2zF
 M0+DvfuYIMvrPPhCXMA9Tpj8NligiC/krX5aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488128; x=1747092928;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OW3ImW0hKWUhABAePdZfdNMkINgZoKHhhQSdVpIy3pk=;
 b=PvS7YcKMndIel+EIBfes0Xv4gV/zMDjbSOCqTIW8TdtS5dtKFJA3/Qtv9oNMGrfWvJ
 zme7VnN3KTxU9PzMSUwgG5MXW4Flrd/m37N/q+QukxwijDsUjwcsoQXmjGztLE26mPzu
 to95OBhWwV+DIwdKLGrbNEajCAuJVpZXyCVaR0VMgFvQCM1JIVmq9vIY0ReIFTskxh+q
 WDA3PWPL8C4gV177qhkB0TWpsBiZlgq9mZa8QjKp6NtlzJ3JUGvj5/Ve46ZnByjE5d7z
 G/BMMZMOctHyfQ2VAhb5lNMSG0qJlnJP1gfk5XsKqfjm2Q2KIen43K3ZP35P3nAeZ8uu
 GgJg==
X-Gm-Message-State: AOJu0YxQZqjp/Q+pAw8TcIc3J0/v1Rk2+6Od3EDts+GQ30YC/iv0BwYE
 R20jxD1a7lqrrez+BGl0jPdi8FbquV0v4l/QewrxUH8A5spZGuA4leMQCdHE054=
X-Gm-Gg: ASbGncsZvllvEUxioenG+attVyIM0ukNjkvN4Ag4Zxzw+26C7ag1pYHMcoqO0EVooyo
 wEx7rJKrTaw4q4ee6PZZY0GuIcS0KPq5OERx+s7h5Ps2Ce+fCBiQAQOw4zYjR5m4GJ0S1/t8wzO
 y2+IixrwTj/BiuVysqTONg7iCeJI+OzGl+r/H6ZSnnNAlu2caxKgSXlj22Bl91MRedP4ELJpg2i
 q9V72hhYP5h6jxffaRkLugzPbi5geSEJpchj1qtwwBpog+3bc9xMl/HFUKkpTBgEuSPrqO0GPuP
 5KNUB98gdTW/HEqWEPNBTRVY852C/DaHdqdrUwRqrUOInjTALL4IbKbTnDUKa/Wj0qgrakwNvVp
 4
X-Google-Smtp-Source: AGHT+IHv2SjUL3dtosTQF1CH3Fcg5tA+NKiyaOgpKjrDS+ODKoK82X1jhcQxKrM+dDEjCkJuutjRHA==
X-Received: by 2002:a05:6808:1510:b0:400:b3a8:2cb8 with SMTP id
 5614622812f47-4035a5c4e7emr5469434b6e.25.1746488128679; 
 Mon, 05 May 2025 16:35:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: aristo.chen@canonical.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org, 
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
In-Reply-To: <20250430022325.156922-1-aristo.chen@canonical.com>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250430022325.156922-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 1/1] bootm: improve error message when gzip
 decompression buffer is too small
Message-Id: <174648812710.69658.15788440211481241771.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:27 -0600
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

On Wed, 30 Apr 2025 10:23:25 +0800, Aristo Chen wrote:

> Currently, when decompressing a gzip-compressed image during bootm, a
> generic error such as "inflate() returned -5" is shown when the buffer is
> too small. However, it is not immediately clear that this is caused by
> CONFIG_SYS_BOOTM_LEN being too small.
> 
> This patch improves error handling by:
> - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> - Preserving the original return code from zunzip() instead of overwriting
>   it with -1
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootm: improve error message when gzip decompression buffer is too small
      commit: f717d798becf2dffd5816484962c350808e98a18
-- 
Tom


