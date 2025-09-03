Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA60CA1010
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CA083616;
	Thu,  4 Sep 2025 00:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FgXoK4WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEE483655; Thu,  4 Sep 2025 00:54:31 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D027835C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7454cf6abf9so238146a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756940067; x=1757544867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XztytljZvLN1eLKN19yiSNm8tVklL8gnqgVxbRS0eGs=;
 b=FgXoK4WN0RUlrAr2fz4shsZ8Dbnze3vK/ehG3DtYdSuCnCDBuZmcqKuilDm22dPzwI
 Qbv8K1F0sl537sCbzltqbNs4x8M5jcKZkVRcVIDNvP9DQ8EObI1+UQ0e80DjocIwCuiw
 bqrcYhrUEauki9FFdhRfrf18zjUqSoZ+bUCrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756940067; x=1757544867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XztytljZvLN1eLKN19yiSNm8tVklL8gnqgVxbRS0eGs=;
 b=GsisyPqV9GtppyRohW/1kySQFUshY5DRzrcmcbV9unWDbCR88wh+0BF4vKBP2cSNb3
 0KbyNC1Jl+dFlVoPCoFliTfR1ArvUyVJB8dDX0UtgImdyKtkIZhB9F/sz5f5XhO8xsCs
 lLZC2V8A36oNoHxUor3DQwJ1/eRyHHICYvVVRXAX7tCkG+5V5dVH/NQJXfF2DmPyHA2a
 0YTFXlWJV4oilFoY7IgOASKSiVIN1CfupMYFH5xd8m8XBkUOAnDaSP2TiH/CuIRpcnkx
 nMMfl/neacR9kU78gNiyIgp2r2rcmKpFkA+ysoLD69Jo2rzF/y37IBdyHstQZshzSy15
 D9mw==
X-Gm-Message-State: AOJu0YyCCC+fSZ1HhjAy374hJZT5qPlreln7E0Gg2bZZKsb1j/OtJkfm
 4XoK+xBSQ6z5sUsLjla9uyW2uhLvTTEToJYalg5bsIi6jlsSJvGQLGhLBuyRVfXo0WE=
X-Gm-Gg: ASbGncuxPcA2iqOfNGSHwLzhPuu7sUnLBVwC784K4OZattPXjY12LHD5krawl/kYoSx
 oTAAgl2udgAU3SvR8Wss4eZqW5bXbSI48xl+Rp2IXiaFHJbQQUW5bMRv8AeOLros9qEd82EwyIX
 fOykkHdG3QymLvvHZbblC8Hd7S60r+/sjORUSCPbL+c9wnQkinHHHgg5JJ1e9HQZy8vJJLQKpWJ
 PtJuLGG09rH+6ZFJL5cX6iLUlfZUesWFWZskfbsdeqV+o4RUMDBOGGvXFcFykCrqQGvVgmoOgxr
 PsZNaQbNv2uTLk6SygQqYejGQlIrlZ7MVmjpiWEgCJq//OZKcKoy5+IAxzzarpZN4fxsED/5woi
 j7EeSbVl+6td9m0qk4fEALtXJh6vKynelCFIrk35xKhhehKjsOIoGEnU=
X-Google-Smtp-Source: AGHT+IFiYa+HXTrJ6I/RNsOPeon/9czKKTQiUsMz/vNc/pWFb+ACvMc5EJBVjkJxflxlkUePIa6HHA==
X-Received: by 2002:a05:6808:4f27:b0:438:2907:2eb7 with SMTP id
 5614622812f47-43829072f56mr1530074b6e.15.1756940067046; 
 Wed, 03 Sep 2025 15:54:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-437ffea70c5sm2164834b6e.4.2025.09.03.15.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:54:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250903053925.6190-1-clamor95@gmail.com>
References: <20250903053925.6190-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <175694006583.3532389.12858561752911987960.b4-ty@konsulko.com>
Date: Wed, 03 Sep 2025 16:54:25 -0600
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

On Wed, 03 Sep 2025 08:39:24 +0300, Svyatoslav Ryhel wrote:

> The following changes since commit 54fbdd408873413af86d86de03a490c5abf280f1:
> 
>   Merge tag 'net-20250818' of https://source.denx.de/u-boot/custodians/u-boot-net (2025-08-18 10:54:44 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


