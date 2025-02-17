Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DDEC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D5B80F0B;
	Mon, 17 Feb 2025 20:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kV6/ifYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7C680BAE; Mon, 17 Feb 2025 20:23:31 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA3880F57
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220ec47991aso45139545ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739820208; x=1740425008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlxqjM3pzwEeox8eH0NOwf69DbEf/6iok1LRdbfm7Ds=;
 b=kV6/ifYx9H8zVTZcwgRFeAvOBNTbThzTZ6uRt7Gukdpva8QLAW4J4jjMIkMNx3uyCL
 2PnihNqA1whqQR75oSNS/snr4CEzcKJsGPyE5p3HkJJCWK8UFnkJNkg4FHczj6/zVhEv
 cnuX3cqqLQcfzIiyEPe4Rw2i1NRU39BlEKdsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820208; x=1740425008;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlxqjM3pzwEeox8eH0NOwf69DbEf/6iok1LRdbfm7Ds=;
 b=WT9VBClDoI8+fNwdqV2PR9hPEEwrOVw/6FEtowcN09iPTu8gPX9NYrx5QDYlCZvMi6
 4BZNBf3TlL65jDNLAh9wNlXT6nS2bX1SgFJXEXj1pOCLMFLvOC/vTG+eTw5ouslCbA7F
 LXi2fU6NoqFjCk7T7U7vcbkGRsDflN+nCV9+9EAkErc+YliCZgFH8UmD//FKwK5mv1gl
 o8kC0iAWzvvxJuBbvy+DiGACkuTTmYDhBAzyYCDyE2hkhX2Trbg3MOL+0WQl/MDZPkvT
 SIzNeDavpcYT27JKSgPPC08Qo7jUr0RTkkTWbt02Sj5XeHHzVfDmAlWfKampOR0H+h+M
 d0Hw==
X-Gm-Message-State: AOJu0YyVvPPy66LgvhjaDhNDj2Uqk+2xvlIvLeTbbygxxcfknCTW3ufs
 mU3DuGrJo2xhO4LkW7mVEPkTLiY+7d/c6VyqV3fkkXvTkCw6e5alpXHmFqXB5kT1Rfnmzqd7mOm
 O
X-Gm-Gg: ASbGncuAeSdF6FwoKsIqoivicZEUW5CrVi2emArxFSOO4lMDNr/fKWEjloQMXZWHCRw
 W7SloPjWcq5pjqOAa2kRDYU6fOE9IStBUCekN2ejdZXR1opm91XH6AHslS859/UozBAJ/OubtLU
 3hdAXk6upa0vXKoOS8D0+58pwh//6ArpYK0eWqjTaDJn9Xz3HMJwvXAd/SYB3FFI/TbbHL8k7+N
 dXCTy8bD0NUv27EBjlp3yMXaWzZE5x+86KimzuKVrLxBwQHggOArlNaXJ1b9h0yX0JsEq9BHzEW
 CUk90lEz+9XE
X-Google-Smtp-Source: AGHT+IHFcjTfjUzOAh/Ix/ei/W8eCc0CYl/+6KDFWd8epcjBoTDHM58jDquxjomfHD3x3nbC7AJPAg==
X-Received: by 2002:a17:902:d58b:b0:21f:7821:55b0 with SMTP id
 d9443c01a7336-22103f064b5mr183409415ad.14.1739820207888; 
 Mon, 17 Feb 2025 11:23:27 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22105174c73sm42911805ad.216.2025.02.17.11.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:23:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250216162903.211980-1-trini@konsulko.com>
References: <20250216162903.211980-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Add missing symlink for qemu_arm64_lwip
 boardenv file
Message-Id: <173982020704.352690.4912438788503686827.b4-ty@konsulko.com>
Date: Mon, 17 Feb 2025 13:23:27 -0600
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

On Sun, 16 Feb 2025 10:29:03 -0600, Tom Rini wrote:

> When adding the symlink for the conf file so qemu_arm64_lwip uses
> qemu_arm64 configuration information, the symlink for the boardenv file
> was missed in Gitlab (but not Azure). Add that in now.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


