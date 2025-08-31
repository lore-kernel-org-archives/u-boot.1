Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A639CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 22:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB518393F;
	Mon,  1 Sep 2025 00:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fDu4zSH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D81583955; Mon,  1 Sep 2025 00:38:25 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFFE833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74382025891so3001673a34.3
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756679901; x=1757284701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdJKg2KpMbzFxLeEC8rbgX1742JZ/UNJ2jtNWoH1OyE=;
 b=fDu4zSH/arZbaaMCV4lnVMu5RjHr2erbRpeOuIjcZ0bevt8ttKQEH7Pj/ygqU2E10f
 xlPh41C6in7/g2bXIMD8W8iaJP6UiFNMJXaX7VGpXMGvGHvXaY8T0+DieWATgN0mEqOA
 XXCBCUeC3KUZkahbqzJVgqeMPchvzCxXgUjYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679901; x=1757284701;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdJKg2KpMbzFxLeEC8rbgX1742JZ/UNJ2jtNWoH1OyE=;
 b=wJtfK56YxDYJHdCoUDgjfZuv+m0H2yMA8FLtEcj1PYnevm7oCr7dYd+UK/QcQgo3z6
 AP2MtNirZ0jJW4TWoQ/MI68mzkDGBEoiX6Ylq4Hb4IkRt0apRlKheL3R/BrbH5ywBuvi
 4e0ayG82AuVxld2T5obQJuTZLk/5Ec8dbc10/8eLPESYawoEndwdlIdK59cbQtkeWgoG
 JRD5OXhfdOyvRYUC4se3ugEwHfNG/8qh8Gu3wnbAYlUXrg7p/CaXYkHjGDBCiOpjl7D8
 f7FEc2NulXSiOjJD/Fnz8SZH/GuA3wyaxc5TLoPTNOj3ojcmwtWJlizehjjjYpi1dJDe
 6ecg==
X-Gm-Message-State: AOJu0YwqVtvMELWred+VlePEZ6fK5j9+grxZ/vMC8rfhX7n4GbGFQBnv
 SqMxFC/uCujTf9RMH/5uHNODh3gm0smNhJ67+W7Iy3wYxiJfne+WY2MMk3i+kWv8Q3Xg2ESOMSh
 HichrRAE=
X-Gm-Gg: ASbGncunb40KJhJkNk1jArgFXp8GX5hHO0SBRwhLz+BufUu1E43nN/DkrWt9F14Kix5
 k04w5HdTTa5CfrzFtovIRc1FVvC6nw8d7VGYkaa2T6bvnxKM2n5mdZlp6AYo++SIZ2JP1lETL1N
 sEB4ucpfUVQBZfybNO+2Gyne3UhNtOzv+d+UU/rEGAxjwzRbwYMVM8317CloY2Xqlwx5cXQAGJE
 ibBGtYI1yPgm3hIseEEi2ISqvUrY8WqLrZca1mlicmQuy2SKrzk9F/Txg80tJ2JhoZYGpIYLqxk
 mh/2dIvgYv6gaKsJCvwpR5sXsGg6Jgu+DdXCKTph1Mq2m8EgDSU5ku0ovPiaTXPRWl0fusPZ42W
 uWEkOAUpGrF0sv2awL98VCHweHjnYdyW2dyacxxWvrU2VM0JiR4JiAERyZ3kJttb9gw==
X-Google-Smtp-Source: AGHT+IG90fMg1L2kNbjH+l0bgh7hO6pHn16SsGzxH5VryZkzEx8PGvHIlBSD8FBlKIBPpWvJMOYrPg==
X-Received: by 2002:a05:6830:498b:b0:741:9e2e:863e with SMTP id
 46e09a7af769-74569dd02b3mr3333754a34.13.1756679901582; 
 Sun, 31 Aug 2025 15:38:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c153sm692089a34.8.2025.08.31.15.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:38:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
Subject: Re: (subset) [PATCH 0/6] power: regulator: Fix some Smatch
 reported issues
Message-Id: <175667990033.2964020.11762698027711901870.b4-ty@konsulko.com>
Date: Sun, 31 Aug 2025 16:38:20 -0600
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

On Thu, 07 Aug 2025 17:35:17 +0100, Andrew Goodbody wrote:

> Smatch reported some issues in the regulator drivers, mostly repeated
> instances of testing an unsigned variable for being negative but also an
> expression needing parenthesis to be interpreted as expected.
> 
> 

Applied to u-boot/next, thanks!

[1/6] power: regulator: lp873x: Cannot test unsigned for being negative
      commit: 42f959d0b091b779f235d7d0e54a794d4d857917
[2/6] power: regulator: lp87565: Cannot test unsigned for being negative
      commit: 8f90028ccdbfc74487c4b40bd6fe5d34c3309b7a
[3/6] power: regulator: palmas: Cannot test unsigned for being negative
      commit: 96312ed79630838b09368c8c07ec164fd40a025c
[4/6] power: regulator: rzg2l-usbphy: Add parenthesis to return expression
      commit: cdc0e32e9c56fc3d14007d4c93394e8bcc8daa08
[6/6] power: regulator: tps65941: Cannot test unsigned for being negative
      commit: c18435e648f7004dee1a80d06dbc06223d3b76b3
-- 
Tom


