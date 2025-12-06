Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFE5D3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114A183A9A;
	Sat,  6 Dec 2025 15:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VIj57l3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB1E839E4; Sat,  6 Dec 2025 15:11:07 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD35083A64
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so2970473a34.3
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030255; x=1765635055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iYyw/i/zb2mn+TG1gk1YDpVEIdLm0EzpFeX7MXSRGJk=;
 b=VIj57l3lDTJvNE3OVaOWkqy+L1+LIqqgLsfkR+UBuHWzEQbGkL4isbovfNFH1xCtoc
 b4lqVqFoIh0eyP1VpDU4k8a/DW1TldadYF4Vg1sBeNHTf2Se9v5I0kkzVsKkHDwMyfY+
 RVXfTjNYrdykHGFn0p7bIEB50BqLgQpWH4i1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030255; x=1765635055;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iYyw/i/zb2mn+TG1gk1YDpVEIdLm0EzpFeX7MXSRGJk=;
 b=h8Qz4qYe+htrBKQmDUiFn9WCphQWAIQ+sIjyZsXgR6IQhDuVj9bUF7GJrsnRNyCLrk
 TBA/Q/BE0CxiGTlxYdNubXinslALNQffkwmWrrZ/13CON919DNeL9BhYHM3GNFG5uy5X
 AecWTM5v+R808j5VYt/a0PwFhPwpwvUpv1hixDfA1DULa1y9aJbbDvn5V6veaozMkD68
 Fe7C6YvKAmGF2t2Zz3Ye3vQfIgB/2KmRTLPJurKdUTwmstALixT2uKppzEjxxb9DnJsp
 4PlI6bg2Q/pdaudDp0MDHmvG5lx4vqyGzLF0r2vAiE060Lma76dZVlEZIdaY9uCId0ll
 RZ1A==
X-Gm-Message-State: AOJu0YyKg2SmuCA0535yWXKLU1D33PIjXgdmLl3EHSBmBlJsh8iL/llG
 i5kYYqTspvfYuBsR34ogz9V5ngduWzw7DOZQpAU7F2hiBG61z522INvVn704M+nypHlVFvToKh0
 5rQyKT6Y=
X-Gm-Gg: ASbGncujXXGRMNwx8rSVoBQgADytPPI9Dho0kxbDME2ySElv5s4l1pg9y5LUqJwlT6W
 vek9ek4Cshpeo9bto3FnQjDWSqbEOhWZZlxDHOXwoMA0pHLCqJgerZBxuIG0pL4mEzyQ2ov1MD+
 gw7R3vrss71vfDjhYhn6G/Ptm4/9JNGv3EMs2NlGXzrxP6vKYLu/y9ZKNB/fFnIV1mtaqdacIo1
 OOBHW5by4ItbaCMdzwwv0lmMpnMlnc0yKdWrVebFodmSriu7HxXPN8LMaR7tdpJpHyedPrvMvX7
 WReWI4qSpmyq1VxhQPnf94fuKYmVGqcGuTaEzoSViF5gVWDe0Bns0zts/jmo7CQkZ28xCZGckBH
 Mj64Skrne6psMuvxKy+kP80O8+Y3WA4sESFZlpCQBmYV3cdmloFNPojWYXaEBrWTDf+QRfuZhsF
 LhoLzgP2y/0sEoeHSFZR04F+Razdqn68BY5/TT71trsFUHQe5sW6tJzDWshMA=
X-Google-Smtp-Source: AGHT+IHhDu0EhHYklHE2BQ+ZcgleifbyNU7D61wTO9GZViPuBv/D5lqjWbJRBoSn3/G6I8VGDKEP5g==
X-Received: by 2002:a05:6830:2b09:b0:7c7:6da2:6d67 with SMTP id
 46e09a7af769-7c97076d70bmr1430198a34.3.1765030255049; 
 Sat, 06 Dec 2025 06:10:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB2805F70B5836B5CE97A190F6DAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805F70B5836B5CE97A190F6DAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] examples: Fix checking id parameter in thread_start
Message-Id: <176503025437.2523567.7052979757603557662.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:54 -0600
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

On Sat, 22 Nov 2025 21:45:02 +0100, Francois Berder wrote:

> lthreads is of size MAX_THREADS, hence id must be lower than
> MAX_THREADS to avoid any potential buffer overflow in
> thread_start function.
> 
> 

Applied to u-boot/next, thanks!

[1/1] examples: Fix checking id parameter in thread_start
      commit: 43ca62bf1943eb3e170cd408be0d2c2a2404b4c2
-- 
Tom


