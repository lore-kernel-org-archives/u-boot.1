Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB16CCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 14:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5216683768;
	Sat, 18 Oct 2025 16:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fbl5cARx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342FD83631; Sat, 18 Oct 2025 16:07:33 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253D983631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 16:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-443cef59836so265569b6e.3
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760796450; x=1761401250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b+YbaEyZ7hQVsnPxoXK4fIg2G+mQqXgJhUg7ubZpcdU=;
 b=Fbl5cARxJ9ii4ZR6Tn3k4xMGrDedUs8pKDbqXkMrIBy+hSJGUQBd19U8ShtsCXbQN9
 sU0jfOFo93HNtlhVY/ARgRzInokxN8mNLx8F2AgBHFGPCAEvAOpim6Ew7iYlCdW+7LiQ
 AKjd90JyrjGeA6K9z56z/IIFrKdXDawqbrplU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760796450; x=1761401250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+YbaEyZ7hQVsnPxoXK4fIg2G+mQqXgJhUg7ubZpcdU=;
 b=m9lL3MFHNyDs+y5uT3RHfoQHaWtk/nZTi76VVw8LIao/hDKj9LwZHN6hbNHpkSA/wy
 3zZg63x96BkwqyiIxVPoAHcRM9DhS3i5+vQNDnUzTpffQ6XxkeiP/nrqnOsSf6sDHM6u
 8hZRaDrx7JROtG1dHeMRGIvTjYOgERroh0ER2PkrN4kRO7U+tdD1zaIMnFHy6pAFc/Dn
 9pkMDINpg3h5j6Xmwailmhw2Z5OQwY+5GScCTsafvSpF3c+7BW7wIEIOUPEPeWkOFkHg
 INNwdjXt5Osa68NLv9Krn6SABUPzQGELc+C1vj7mUMcTiFdyfZbT4K68lMQV7dqrhtys
 5+aA==
X-Gm-Message-State: AOJu0Ywqw+o6Bxf7M+KuDspQ7hDwjoJvpbMf2zwR5gtOuKGarbqXlJld
 haZrGKIASa1jt+as5hghMTDWFj5swsgpW2H+9YttvBru01IJYYfZ6NlJCuckloDUiUAkILGxiP/
 oha8VTNE=
X-Gm-Gg: ASbGncsxXoaaAZNr309/IvGugsx/DzN7p9wUsosYCcelL+lg/hlT5QGF7CxIKdZOPv4
 ByB0QkhSPHUQrThulq/uPgGKdjGxdGbPwsRIZdpRH3iO/Fzhd7kZw0xTAW7dXSfizQjIToW/MtO
 4heoiZBNlvdjQBh8W2pXLEyaTRf7cWcWlUG0CBgJIy3IJxcVOIxV2Gmd9wMIV1UZ57ZNFKyHcOq
 OYqzdY+d1sUxdTdF9NtTBJEzqlPbItwUhVwbRa9h3nwpTLLos/zx+Mc8Ts1xXMtDWdUaNvlr4Fn
 NMRmZ0Ees5Wt9bRiGWoHsrikVZAbo8Cb7zZrYMUCJoNO9dO0RkXw03XoKVOm4aLGmCyYBRiXdKc
 CqxjMNKifoWqAF/hQ0PoXXD4iQDEHUCH5xUZukstvQJL0ZjU8toKdDjrCmiy7ospdcMkyc9m526
 0E2xmDw7SFIF/f2fkA6a/y3Nq4XRqmlrfQiZlFgWo/TKScntEa
X-Google-Smtp-Source: AGHT+IHIFfNvtWuo1DbOuVMhaIsBOeRIF4kGdNZ3oSvn1ktDR5j/RSerz5gyBjnv4rJeXGF0b891gg==
X-Received: by 2002:a05:6808:21a2:b0:43f:1dbb:752f with SMTP id
 5614622812f47-443a2e72389mr3493767b6e.7.1760796449875; 
 Sat, 18 Oct 2025 07:07:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3f2fa57sm618972eaf.14.2025.10.18.07.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 07:07:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251017232759.151857-1-marek.vasut+renesas@mailbox.org>
References: <20251017232759.151857-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176079644832.1878470.3972642716014228254.b4-ty@konsulko.com>
Date: Sat, 18 Oct 2025 08:07:28 -0600
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

On Sat, 18 Oct 2025 01:25:52 +0200, Marek Vasut wrote:

> SH HSCIF FIFO fixes, R-Car V4H/V4M DT corrections, R-Car V4H Sparrow Hawk PCIe
> shutdown support before booting Linux.
> 
> The following changes since commit bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2:
> 
>   test/py: Update to a newer pytest release (2025-10-16 18:03:27 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


