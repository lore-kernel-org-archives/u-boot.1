Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88EFC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0050587D83;
	Thu, 21 Mar 2024 13:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uOiNkF13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE9C88049; Thu, 21 Mar 2024 13:15:12 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2D387D5E
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-430b870163eso16589621cf.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711023307; x=1711628107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXu5DlmyUMXRb5doCptFSjfcOBSZ/iX4OCBlWPOlWP4=;
 b=uOiNkF13KAb9KgF9msFHYeaZnRW45uAnXawg7iab/6UGS4JkILsN5aVNJ9jmp7UpPV
 imu43hZBBvTwBUNVas1pXy08mNqDfMdtOpkspCGY8XFwuG7Dy2Y2W28F7ktIwOs6dJuJ
 PWs/oxX1sDKEhqFgcaEtWCejYm0LyD1AHUi8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023307; x=1711628107;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXu5DlmyUMXRb5doCptFSjfcOBSZ/iX4OCBlWPOlWP4=;
 b=B6BWeYpZTjh1heg6jt6MqvqbkAI8aPwGNCSp+2cZZLH6F7KIHtylI2f2z22QZa8GvV
 aRjN63BcRbkAyCJAJUa3clC+GkTOt766YZYT40O2SRAxTYfwqXxGQliBrerbqU0erGuI
 fqwubvLPfOTA79Gv23RlbKir0N+CzUhWHmEvvDtUnGtca+mHBzQ51jtTExRBRyQr5NeR
 qOmXr3FYGAFJOZPQ4HOJnMsRpWCdDBcK2uIgrhgB870WNE5sHUBcmLFD9by8D3ern/Mb
 ZWHoZR8vZ5Z7tj8Q7MAcq8wFUEmhVAgy9hPmp0uvyIkEoDVGlvZ/1+RBUeP9i1oCDuq8
 myuw==
X-Gm-Message-State: AOJu0YxQKFsurnK17avdZvMA0cPxMecdvFznl3Xx4IFlIHeVUUJR+UPY
 0InqIL3GSUM1DQMIXFGY2K3QZ91ujz1hTCBhruMu9FLBIO8Oma3LkDKnIsfV3dJFTCzslFFgr+d
 k
X-Google-Smtp-Source: AGHT+IFMK88Pno6ZBslfz8eM1r0RjqW5unKCdYNcA7AEW3vh7kA10XUky0XNiDXgqa78UAZhxM7lcA==
X-Received: by 2002:a05:6214:e64:b0:691:abc:ade5 with SMTP id
 jz4-20020a0562140e6400b006910abcade5mr4309738qvb.27.1711023306826; 
 Thu, 21 Mar 2024 05:15:06 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kj25-20020a056214529900b00690df461ecbsm8990690qvb.10.2024.03.21.05.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 05:15:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: sjg@chromium.org, seanga2@gmail.com, marex@denx.de
In-Reply-To: <20240313065315.118326-1-ycliang@andestech.com>
References: <20240313065315.118326-1-ycliang@andestech.com>
Subject: Re: [PATCH 1/1] spl: Improve error message for SPL memory allocation
Message-Id: <171102330582.1913497.14158562270371832337.b4-ty@konsulko.com>
Date: Thu, 21 Mar 2024 08:15:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 13 Mar 2024 14:53:15 +0800, Leo Yu-Chi Liang wrote:

> There could be two memory allocation scheme in SPL phase.
> Explicitly print the corresponding error message.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


