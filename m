Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962CDEE0AE9
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 15:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE3383BC4;
	Sat,  7 Feb 2026 16:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HNU64QwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8BB8341A; Sat,  7 Feb 2026 16:36:22 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A96383A64
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 16:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4094d7d71a9so541295fac.3
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770478578; x=1771083378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kpgs0KW+WSx5i0K7Cuai/oXv+EbVAa1X4vXHejSlyzg=;
 b=HNU64QwXNH+plqEevl3YQRW/O4lhifqBEE4MFoCKP5WCXypLlwLlreQYLIG2bdo1fg
 jfelpd2rZGwxRs4H8o1BnPwIGtu0aecWG7FoS7uYx2HGmAEQRDhvFGxaBf2gxyBJgU9F
 bWONIGakVToFWKjRY8AxSWgsOyq+MwYfJ5ILY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770478578; x=1771083378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kpgs0KW+WSx5i0K7Cuai/oXv+EbVAa1X4vXHejSlyzg=;
 b=mzC7oT8WK7m4rMJf3vac9rig+DWC7Gu6VIfLuhpi6JfJqTXokJQBrqTWUlalx/J6Wd
 IvutEDZ2LTW6XK65qA6LNafGPS8A8U6LGj8h7z2DzuzCUOwBDMi54gmGxHjwM405eXVt
 Ml+01TsLPNQDh/lJEy8wFWgPb4qf0OYC+3k5ObccZm3Tcf3v6mAK1jWC88WCYiCVb+Yr
 0qlSX7TNPBrlwN0mZNH0UC0czaQTe6oxRwK7755dHsz0tGLLs/CpWdl7OBp9f76xg5Pm
 wKKGs/C72lHLvxZG0BT+ZU2C4BWq67EiZW91HQAqoE2iPjBUVZVAR43g2r3y8YBV+gyg
 DiJQ==
X-Gm-Message-State: AOJu0YwiZCVw5IYJhHU3CMWXPRU7o5WRL6EiLg1PhHejkSgs7DFpZSPm
 2r6pkQObQJx3D6KDVcTCCzVfJqI4YghbR+hXuzE2+geJLZX3TEHrj1xYx7GN8dkvKmU=
X-Gm-Gg: AZuq6aKFa7+1Gl55ML9SG31ofEGRUEYoUCBHUPezuk/M39K/5jnXGRrh9Wmoh+gO/sT
 B3iDHx0awI19fyIG/kS8wL/b3IjHa0pXIKJ4Eq2WyFH5Pdv54Eg5w3qYbfn7Bxfp9AE6qlsk3gu
 2uIARGbVkebSnAzBOIU/nTIGLLzgBs2CaEgluPQHR+ms48d67xPNIWgLlHYzebjUUGy/xsVWK0S
 e65g5Gfdemt7hSCKYsjnj1yMjGu+hdEHqA1CQxYjsHvQjwUWOQyY0B4aVa4fUbodOewnwqJEw3v
 Vt+w6xAQFeDfJArilEQEJwpPU55BOEC+J8JzyVT99kD4Tp3WAL9WXU5+8PQiO7fCLonppCMeqXP
 tTN9wwPkoZO1QXiQe6ZHPrSivb9hh+4CFl67OAlcNSnO9VFoNVqeYZZf/FArYlRRK82J/ZlZASB
 53KmVW3QB9zhYUSIybjjMDJuRVu+dRB74ssSyRV4gIJ9Zy2ClUKbCmd6/aaPo/dLAoP4hIhVo8/
 vxs/26wWjIByf37f5YpCazPZtG/MuCAvq8OLw==
X-Received: by 2002:a05:6820:2225:b0:663:40d:4897 with SMTP id
 006d021491bc7-66d0cb3efacmr3180022eaf.70.1770478577935; 
 Sat, 07 Feb 2026 07:36:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm2941332eaf.16.2026.02.07.07.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 07:36:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260207120017.6415-1-marek.vasut+renesas@mailbox.org>
References: <20260207120017.6415-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <177047857711.131189.1710838655462708068.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 09:36:17 -0600
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

On Sat, 07 Feb 2026 13:00:08 +0100, Marek Vasut wrote:

> The following changes since commit a54d613baf742a95b6deb7a016ef6262737d1918:
> 
>   CI: Update to using grub-2.14 for our tests (2026-02-06 09:29:58 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


