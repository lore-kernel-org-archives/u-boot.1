Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DDACA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65416833AD;
	Wed, 10 Sep 2025 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mLaKjeJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C32833ED; Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478AE83303
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-74526ca79beso6052751a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528087; x=1758132887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmHMDcID81X+SRQKPt7KtDzKs8yR+52tU3BIDA8Jsro=;
 b=mLaKjeJ9JALAcZDzo2EJtZ2RIp0e/DyXkdHjq1ESV8lzTTYDITHWwBB57t2cS2JvW7
 DVvQGEX1RzOIy2tIwffmI48/C7sD2ziZ7zAeGnr4pNjKNLpoi7gWoxSoRgJFkKDVFyWy
 AAt6auYW++KBGD/LPDdFeCoYcF8Uf9c9J7lQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528087; x=1758132887;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmHMDcID81X+SRQKPt7KtDzKs8yR+52tU3BIDA8Jsro=;
 b=eB36bHiaXZZYiOSHChpvc6s1/fUZFVvT4bEMAGPOacFnvkRPUrRRDGyG0hQJszRGh1
 KxEE+gdgJCoi+qz64pI/M1zMRTWzmgNNRnr2MJNC8InA87qRWb7qQSIPZkmlcNxRNRg/
 bxaOlQ9UGF7txpm/Y6JOIV8Daia3hv41Hd15XHbcnsIZvWy+4hJHg45aVwoIf9yskCAX
 HkvcGYSV02eOuP4KI/+BmWxjCMyqxn2wlQo3s6YGdx2YorBYvHm5V5SWKaY9gD/GIkzZ
 hOKcn2le5FpG5Vi4IAVVntNKrEC0rFmqJBeuqMVhOAoJ6Kj3GJMdBWVmnOIAE0GpU8rb
 Me+A==
X-Gm-Message-State: AOJu0Yyu0HVktnKlur0u29o8GOCdexEfP98JThpbzYdqo92KZZ7rwgWH
 k8OueBDhy4eJ24k4ghN+O2D/c3Op2K40sFzCXGocweoDG6z5r6AL8i28Nbs2AFEBeZ0=
X-Gm-Gg: ASbGncvQGP01CKCZQRWoM988RRWVTIxk+eUiuJLj+IiQh1ojgxzvBD8sar7AKLnfWwN
 T3wxtIFX66bhMbmZRepbfmEwU0LkfPECeyB9FDyM7i3iiaZTJrnkncyn9+zJfsfv/I0wXxTEaet
 RLJx2tqrKat9zfLNr4Ycb5mOmv7XbZQoRZnZaUn3lRlj50KhfxIvDw6zgaBsUG+UnS+2cFhFPSE
 Bn35V81WjZijAhpm9l+BRFfPia8vzLtRtXz1ftF85YrE58zTgrzbW48KF0Myf+9fgY5B2NxA3LQ
 E2Hz8846l8X76FGPxGh0BIfSC1YDRMbvjRtD1Khum6u9iwPWRhEgRZVfhPfIRzyQydoDalSyZXY
 DJcYpKGA3WC3u+vMUXzA+7W3YyfE0PGutftz8hh4bAJ0v73s2wlijnQYDN54ap4uvBg==
X-Google-Smtp-Source: AGHT+IF7R+Dzja2TKLVfrREgi0fmZHOO5aYt1lR5uNknqMdZWwSTuac9ArcQx+mQR+Hr9N1AafPehQ==
X-Received: by 2002:a05:6830:348e:b0:748:d0fe:3c07 with SMTP id
 46e09a7af769-74c70c78366mr8861357a34.12.1757528086942; 
 Wed, 10 Sep 2025 11:14:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250826193717.20543-1-mibodhi@gmail.com>
References: <20250826193717.20543-1-mibodhi@gmail.com>
Subject: Re: [PATCH] fs: ext4fs: Add initialization failure recovery path
 in ext4fs_write
Message-Id: <175752808609.1959855.9998774264852042673.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:46 -0600
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

On Tue, 26 Aug 2025 12:37:17 -0700, Tony Dinh wrote:

> Don't invoke ext4fs_deinit() in ext4fs_write() if the failure occurs
> during initialization. It would result in a crash since ext4fs_init()
> has already done that.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs: ext4fs: Add initialization failure recovery path in ext4fs_write
      commit: 1f8fd9d37d69ecc269943a273d3bca4c1be2384e
-- 
Tom


