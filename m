Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62509C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E6082DB7;
	Mon, 26 May 2025 16:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D46xxtdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C8782E17; Mon, 26 May 2025 16:11:06 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8708382D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso4207612a12.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748268661; x=1748873461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h9McJOhMDyetjmEDtTZj/9FqfWeQ0riZLmGAXmzxtt4=;
 b=D46xxtdqV4ZekxOCdnwqBaiQctcZ7hfXQzaorPHR3Ti6SWR0XqbQJxs1Qts5szPCml
 gb+xeUgZbpF1qtp1DbDzvFbaxfL2H7aDMPX24R6NGm5iYwnoBPWy59lEvNxJeeKOlJnL
 qbkdFtjTypQHFedys3sewLFvGkcsUBqY7O77g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748268661; x=1748873461;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9McJOhMDyetjmEDtTZj/9FqfWeQ0riZLmGAXmzxtt4=;
 b=LxTPqegevuboxB3P7z06d8ATE43FmpnZleoB01PiZO4kmJITrwpTHUkA+4fq8IUP4/
 h+1MtLy4spZWE04C2bgvcNd54NlEV0yQZzwi1r8ZtYwS45f2aEjCA3HNzpuLjsG0cg2s
 jb13gdWSdPSnCR0VjdYeC0XgmX/mm4+SG3CdMdnadvcYGIAKvqs7mroxpIZfIWM8/LP0
 cGDp9WfuySnqeIvuuM+4thyRVzt5FAkRFqwPL8b8vEvEDYQSMZvdw7IVWCiAY/6b6Xqs
 1e/ETozV3Ti2icxxJ1sR6gXFYP5EIpjuvS49DF2ZU4x8USGoRnvFixxlNZ4Q2/dO/1+t
 CP7w==
X-Gm-Message-State: AOJu0YwMPYRGcLctTSRD0F67vUKKVHDMQyS/EwVuAclb1kUny/Wm4Ppd
 1MbHJed+dH0HzY+PEvuToCaZBr2JqpTPv4BEDLmcZ0l5hXu1m+m3KGFDbPVVuJBsqkvuH7e01RY
 somzwDEvOdoa97vRZUF6z+k/jgKTTSpNfdbqR2717jtXICSUSQge2bg==
X-Gm-Gg: ASbGncuMTyoWdPCu0UfUx2G/qzCBYeIVuqtCHcybiA5ZpovxI2dljwG1vdLOG4mHII3
 2nOv1s0lcwGuSoiYNZP5Mmya08FR1cPVTSh9t4GkJUZqQWE1qHoS4O+dore5xjBOkQbekK0GpaA
 G5sTLNbALs2qOPZveMjb/npHerwJ1t7vM=
X-Google-Smtp-Source: AGHT+IHIAjLtXNA16lnaqb3cz0Aq+CLzt02DECpiUaXu+2AyvX6B7tXiuj6np63j2lCXqV70zKjWEnLDvtGH4BGtLlI=
X-Received: by 2002:a17:907:e84b:b0:ad2:2a5d:b1ab with SMTP id
 a640c23a62f3a-ad85b31a7ddmr931517966b.59.1748268660986; Mon, 26 May 2025
 07:11:00 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 15:10:49 +0100
X-Gm-Features: AX0GCFsAU6YaVa1yKXqVDtZQZrUbmBZ6zODe7bKBiDhb4U1TIBeoce2OkkHA_eA
Message-ID: <CAFLszTjtw8s2NnrS+B6-K8i_YF0ZGU9JB+O_vNYmT+AD7Km_AA@mail.gmail.com>
Subject: Booting distros in CI
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

What do you think about having a Linux distro in the docker image so
we could run a 'boot' test in CI without needing my lab?

Alpine Linux has an image which is about 250MB.

Regards,
Simon
