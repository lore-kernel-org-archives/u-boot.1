Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AABCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DAF839EC;
	Thu, 14 Aug 2025 18:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YYWAbg52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D9D839C7; Thu, 14 Aug 2025 18:54:36 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06735839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74381ee9bc9so787659a34.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755190473; x=1755795273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsW5OF9grF1K7uo50NGZKUB/HYrJUzBkusZ2e8XdEUA=;
 b=YYWAbg52Uz8Yt92wP/nXxb0Gwb/ykHRP6XbiSKC8sr0yuYbJoVjPAfehmoV8KTZkzv
 zQZQqWkGht+e3CXWzCvsATmzZ9AnqzmEeF6otvj+DSggAYnA0+f/4BnXcb1NrmGVziVv
 FAiU5sztdGTH9ZJDMjUcOy4URmCxds8OslQdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190473; x=1755795273;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsW5OF9grF1K7uo50NGZKUB/HYrJUzBkusZ2e8XdEUA=;
 b=kt+jB/6pI+NM/+b7VO8nXZOcKXDvmamXBgn8zhW/wCqB6Fmves0tJ/5ul+b8iQSFmW
 0I3iJ4VjIBdeEHjTjgBiCZHdJHFSWYES08+CA3oUtjniHu13ACxba6lMIDVeViHP/t/q
 alm67grKwpJ5K+14h2YV6V8118Je02/1NogsMJcp0pHXermmy0zNn4ZtOYJYG8bXnZWx
 d7b4eGMJSSSwuPgZXcbuqGc50OJULHkFVSwqh1FtYn4v0Ru4LSD7FtgSfPgBIN5AYOO2
 Zl/SPmLr7RiYppBdCl9EF46fTGqxVCw94Xxaovh98zxA7O9SJE7kYKNjORGHrv0Dhnn3
 RFgw==
X-Gm-Message-State: AOJu0YyfBabwYn0P5Ppw6uffpGgrYNP+qgUpum3OetyeWtyZf7Q5VKSa
 l72XisVSAbt50QkncEkI/WDlMpH/n9wSejZvxaL2r73T8uuS7z+8pH2PckpylIdWH1Q=
X-Gm-Gg: ASbGncs3wy27PfbSr0RbiTSKOvgC+UrYw+EDDQTKukHEQ2Qk+L2jos+Rg1S/5Yfzgol
 XsOznKjNvWZdYHVg7nTAn+zBIdKFIgXwRg9J6uDaSwwcHDz937ysYTTVBWpEUWcvXqcCJpQD/C4
 A+4TrJKdUHsG3whsRDLWB1QKatzc60jXrw6Qq3RTuGiWG4mBmzO6wdCcNSemf8SvK3oxzloYDPZ
 dWnwcNe7LsMtSKkTrEp+ABJUWosUMSjQWFBVfx2OKBYWoVDaRN526mY0sCREU/Fb0d/5zMUfR11
 YCj92+yjRG4+DQl8r7YzWyn7JGtG0vst1KDvGd8auQhKaR5IB13/ETgPcuSSoNELOKJaIRvhfQ5
 UBkRlwUgrZykc5bDDGd5ffm7h5zxtkeUleQvtvp8Cl927t5TimbFdmt0=
X-Google-Smtp-Source: AGHT+IE9Z+jSmdSelr5Do7brpiiL9ile6c14izLXI0a5PIjM9XyCjrFMwI01xnz+BktxSEsUZKm2OQ==
X-Received: by 2002:a05:6830:44a6:b0:741:7901:af7b with SMTP id
 46e09a7af769-74382b5e2bemr2090825a34.10.1755190472702; 
 Thu, 14 Aug 2025 09:54:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9c91417sm4378449173.89.2025.08.14.09.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:54:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ben.dooks@codethink.co.uk, 
 jamie.gibbons@microchip.com, michal.simek@amd.com, sputnik@on-the-web.ch, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <aJ29JN0YOKGS5tBn@swlinux02>
References: <aJ29JN0YOKGS5tBn@swlinux02>
Subject: Re: [GIT PULL, v2] u-boot-riscv/master
Message-Id: <175519047156.3586279.12016593617333469858.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 10:54:31 -0600
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

On Thu, 14 Aug 2025 18:40:36 +0800, Leo Liang wrote:

> The following changes since commit 869217ee2907595919261b6d4ae81fd76a8ddd81:
> 
>   Merge tag 'qcom-fixes-13Aug2025' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-08-13 08:57:49 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


