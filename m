Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F3C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 19:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC028056A;
	Thu, 24 Apr 2025 21:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="bZ9gWy7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1FD80BA8; Thu, 24 Apr 2025 20:27:07 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E378056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cyrevolt@googlemail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-52617ceae0dso485088e0c.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1745519224; x=1746124024; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yym5wAPOockvuz4sdr6wAFgM3+YHymN4he3igZpInIg=;
 b=bZ9gWy7UkPwnsNHZ/klIa+iKjavwP8YQg2fOZhggmQu+rt7eeVTvqb78rMcb5VEx6W
 bCf2vfLUerJkKthdY8/VC4m0ODJ8JyXDLGIr4MJ9c2YN6alofHihfnWbYq26u+ll7hpv
 YnW+hLKTioY5VeNJssX4vPkvvpabMcChk1NyYPOzlPxRGqG3kHHdXxWCQMhG+AvQwwJF
 XDOUT5net3X6GeSHCmEK7DaNXRUZEujkgP62LuYXBpUKBXYFVLZHl0j8sB5qKJY8B3yt
 scrwV/YirsW4Gb3dSWX89ySGCPnkuyHonMv3cYx6ndp3Qa6fiNjPHiG8U7m76D/1wimp
 N1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519224; x=1746124024;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yym5wAPOockvuz4sdr6wAFgM3+YHymN4he3igZpInIg=;
 b=t7X+MYO3M1UxmMDvZzg4VVMGh4KfWQE+/dnNJqJ3BqlFj+M/oizDejhIYbk8ot0NzC
 Mju92uKrkCZT0FWdcn6aosb9pdtOWoCZo3cEr/mCpZoKXDZDcNHreG+N35UfY2MPj80W
 sLVssc4IUwUDvqfwzqkiTSVFAEET3B2jlVSflxBFVAauqeXTtsNXQwjsclPe04ZxCvN2
 g9sRDCt4Hokt/WFn6UNVydeoNDr92scGlCcWtzXSf6m/2dZBuNVjOhrj9RMwscWOwfXZ
 dEUCv6jTj0wjtcE6Ep0aVL/3VP9gJZTBbptBTTTDfItuPQ251MD4VzkGaCo99cEs7eib
 bHlQ==
X-Gm-Message-State: AOJu0YwNz3UZixaMieaY7QcFCb/UBkxKhxvUXP5as/m0WRk8Xvezaa74
 ysH48yee2SezHW2Ls1qfVNzOcoJxeh/oF/ZcCkd73ZqqaoWToVY5ayb0PM2V7ah3KQqd62jzT14
 3IAnvzgW85uyh8quC0uWE522LS3hRwHJNLHc=
X-Gm-Gg: ASbGncumyxzXDEkUUGAGQtKbiXGhz5wkG7/dSYNcD10C09Xuq/maKHjXg1hCsYTdVVU
 j2z2fuxCAswrUaX8ldahz9ULQaBhxrTj4vq8t+njeBLvYbhVNuahWc6+0w1fRyTwbX15CuDxCtS
 MiGo7Z7PVShSyvUh9V/GU=
X-Google-Smtp-Source: AGHT+IEm81k3Fo/X13R+W9ECsH/1WoiUrQ7nBJ86jbLN9Lefvb15KarMYJo8+dUQK4b3x+1+Ay0jVPjEzpNx0v0JJf4=
X-Received: by 2002:a05:6122:32ca:b0:529:d7e:d13f with SMTP id
 71dfb90a1353d-52a85b1faf8mr958016e0c.9.1745519223658; Thu, 24 Apr 2025
 11:27:03 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Maslowski <cyrevolt@googlemail.com>
Date: Thu, 24 Apr 2025 20:26:53 +0200
X-Gm-Features: ATxdqUFFFaoeQgxO3W1hVCTBbRR72U6nwmJkxQQujzY3rMYjjmvqrkPUbTW7WWg
Message-ID: <CAJCpOFyMyXZK7Hz7mTOwHRREQEWf-=ghgLXU5RgzTMxQj7MnZQ@mail.gmail.com>
Subject: SpacemiT K1x / Ky X1 DRAM init
To: u-boot@lists.denx.de, xypron.glpk@gmx.de
X-Mailman-Approved-At: Thu, 24 Apr 2025 21:30:16 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey everyone,

As discussed in the last community call, I have written a fully open source
implementation of the full DRAM init for the K1x/X1 in Rust, based on the
vendor U-Boot code. This would be trivial to translate to C. I would be
happy if someone could pick this up for upstream SPL. Feel free to poke me
should you have any questions. Thanks! :)

https://github.com/orangecms/oreboot/blob/all-the-things-wip/src/mainboard/spacemit/k1x/bt0/src/dram.rs

I could not find a RISC-V specific mailing list. Please forgive me for
being email illiterate.
