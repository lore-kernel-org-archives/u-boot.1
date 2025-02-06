Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B05C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 08:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F395E80562;
	Thu,  6 Feb 2025 09:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gWvd+Zwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333D6807D7; Thu,  6 Feb 2025 09:09:58 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C905980104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 09:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso3524565e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738829395; x=1739434195;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcXPNWjoSdAt+kGZfeuLATO82voZ5kiGKycQvokMZYU=;
 b=gWvd+ZwgbU+JT107PsQZ8vCqLVaHEwBbDOgm0wiSxUnbc8t376LKQATIUXBnnmsbUp
 gEXPJbqAYCuRK5W7xEGj6KUJAAHMR6jgVCHiw4WoYnega+dLrItOWzgxVMs3qOow7qf3
 vmNnNLVmUraQIwNzQjeRoMLGYmTf3JyrQSc+VNq4C/xGnAC+gPPWwz5E6AX4l7QQMwYM
 ob2hPxkzhlm9zfCJ+Im14NgAAzckN70Mleec3LHLk6f66OTErqcX9BC6Kaz+MUR9ulN5
 g7CtYZLaEniA2Oo3kBW2JLYSCN7u2eflJzLLdstLIjRp0UXylYZ9zGde9s1uLjHVDun/
 d+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738829395; x=1739434195;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcXPNWjoSdAt+kGZfeuLATO82voZ5kiGKycQvokMZYU=;
 b=AGBbtz+FUO+oLobtfZV2WtqFP/JKEjoTcMqRULT8vrytUaFmrzEXilrJ2wVtLk7q1v
 6FI16jNFptG0ESp9UYM2v8OJLr9Y7JBKE9Uo9QY3Kxq+f2MVCzXOo+fau/IjQWe7O0pO
 U8h2Z8TsTKGzRENO6QOa5yr9RPBo28SnimRoUrrvZ2JdzOJ2kuvyAib2eGSSy8oeamRl
 EgNJcX1bNTEfRNA3YZg+h3MMWQPMG2CRPe3qbFj919JHNgn8TScF1WryJKA9DTyJ4/Ex
 PAYklTI+M2GnVSI981d8CMxQRgVNNDRYrHRZg82qGFtWKBrGsRnUPGRf0+lmIyEOocFC
 /hAg==
X-Gm-Message-State: AOJu0Yz/0fiqko81NaFPkaQgYNXPY/Z4GnJSQOF7x+4v6VugChK1Wm8K
 P1e5YD19m0I+1q89CaZ2ojdwdh7NVUeEmmU5E1hH1FjdlMkKXusbS6kgLQQXWrWL4DULAEMz/ll
 K
X-Gm-Gg: ASbGncuOzb/GYMZv4HPpjfNN8O6kil7fmEKB9xua15q3wgHfZrAuNC9IdAnFNy1fod1
 r6b6gCT1TAk34HXH8ud3K1PmfWRTThNNnDeuRyKwiJZOLPOg6JVCktB/KjRG8ZRTJrd2tqhB44I
 CoMvvjbBBfs2x7F2+fh2iFc3bC5UL0o8TcOQXkKr4nwSWFP3tqOYwnD7lsTOYcCAd2YMgpRitr0
 aUm/8UJvj1BiM3PeJ8XIsFHvLg0oPjTYHD2oYfTUrgD9ZZ7JZ+ZjFq/3e3ghxAMU3XBtnFBAqIx
 CpEiTXSDFziZqaFUFaFzHJw1o4s=
X-Google-Smtp-Source: AGHT+IEyit2++B4lxBiM3EhzRlL4OswZ75Nlk8ApPh45feTEgGBkemlYqGKbI6CMPUUzfcx6RlmpJg==
X-Received: by 2002:a05:600c:1c90:b0:434:f270:a513 with SMTP id
 5b1f17b1804b1-4390d56e3admr46865905e9.29.1738829395104; 
 Thu, 06 Feb 2025 00:09:55 -0800 (PST)
Received: from [192.168.2.172] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da965a6sm11113035e9.6.2025.02.06.00.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 00:09:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Safae Ouajih <souajih@baylibre.com>, 
 Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250123-android-handle-no-dtb-v1-1-1cb7373247da@samcday.com>
References: <20250123-android-handle-no-dtb-v1-1-1cb7373247da@samcday.com>
Subject: Re: [PATCH] boot: android: handle boot images with missing DTB
Message-Id: <173882939349.237338.4177409655175811765.b4-ty@baylibre.com>
Date: Thu, 06 Feb 2025 09:09:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

Hi,

On Thu, 23 Jan 2025 14:35:01 +0000, Sam Day wrote:
> 607b07554e2 removed the check on the return status of the
> android_image_get_dtb_img_addr call from android_image_get_dtb_by_index,
> which results in null pointer accesses shortly after when trying to
> check the header of a nonexistent DTB.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: android: handle boot images with missing DTB
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/aa817a2f1fb66067fc3c6dc7d9d1a84bbaa99df9

--
Mattijs
