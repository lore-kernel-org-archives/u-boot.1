Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81F9C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADEA488B21;
	Thu,  1 Aug 2024 16:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VuTUYEav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FAD88B0A; Thu,  1 Aug 2024 16:21:38 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F25D8874D
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-26109c97728so4278421fac.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722522095; x=1723126895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30iADnwUhfx2i5j74z2uENqOJlCkxQcnP2lrEyFP2Hs=;
 b=VuTUYEavfV4d9yhP76tbLb9Cxll5KrBg+trZNCm7EuZ2RP7QwTWQLxJ276i2madtQh
 bVR8C0dthttmLWuDzNLmXTLXCDgzeAiubN6fSCzmJ7Wbww6rzl4ZF6gVnMn3pcYao37i
 0OSpT1+TCDAL0ZM+CyjmNFntF4TwoqYZwBDCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522095; x=1723126895;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30iADnwUhfx2i5j74z2uENqOJlCkxQcnP2lrEyFP2Hs=;
 b=mNpdL8pPTcN35RK/fFuZrKSNxxfijO64qiVYyE67oCE0UjeR4Sj+rdHMXn87nX7bc/
 c6Dk+7d4xbRwNFCW5N9Da4hoU7UZ605vUvtIkgAQMjZAlvGfuVuL3/1353yBdqnwt+BP
 S6nYFsry/T3Z7BiGtkXq2rm5WRoKFdN+apjsIkAO5vqjN1xhwuxe4Sa1IGIdiP20KNQ1
 +GGFhLPUmPUopCUQMdxfFOA/if8i87S/W1g3+jGARv2UStl6KmSBS9oOA3ArEuX+ojY7
 1Ymp2y/hLOy8kog2JFuGvCrMO3G4e/tH0burZDvwSfrzlaAQ+FQ4QRCKvtfUndE34P0q
 aASg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzgEPbXzNmAb4D2C0LsqMIYQcDzFtNIS5NooX/AmVSkuPy4cTzh8UN2gQKOuPpwVHC+h4cbct8QsjmBqhi5FuvSk9Qtg==
X-Gm-Message-State: AOJu0Yzvmhwfjse1HTy8kA0YOCjtoNDy4AKTvDkck3F1GKjg3t5dlRR8
 WyNsXlXaghh06yfu1lM5qxMOCAQwt9xyfSf/GhEazxUbts/tPPnjsjWA4QlkWL0=
X-Google-Smtp-Source: AGHT+IGp97nCFbAcudsgs7orBG5fOMyR/aM/DYWWzzH79PQB6E0KcvfaX9ghtnl8VJV3kqSix+XDdQ==
X-Received: by 2002:a05:6870:9124:b0:268:2189:f0d with SMTP id
 586e51a60fabf-26891e9306amr244069fac.33.1722522095007; 
 Thu, 01 Aug 2024 07:21:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e63f463sm3087486fac.18.2024.08.01.07.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:21:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20240712094754.2901920-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240712094754.2901920-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v3] net/tftp: make tftpput working with servers that do
 not use OACK
Message-Id: <172252209384.4049041.9420272355672284889.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 08:21:33 -0600
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

On Fri, 12 Jul 2024 13:47:54 +0400, Mikhail Kshevetskiy wrote:

> Option Acknowledgment (OACK) is an extension of TFTP protocol (see rfc2347).
> Not all tftp servers implements it. For example it does not supported by
> tftpd server from debian-11 (https://packages.debian.org/bullseye/tftpd).
> 
> Starting the "tftpput $loadaddr $size out_file" command with such server
> will results in the following packets flow:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


