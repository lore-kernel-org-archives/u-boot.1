Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B90D78770
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 19:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268FB808AF;
	Fri, 19 Dec 2025 20:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fs3OV5xR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F27835B3; Fri, 19 Dec 2025 20:51:47 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E74B80FA1
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 20:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65cf050a5cdso1665464eaf.1
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766173904; x=1766778704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9hW+bOrzAbfan3DOplEi+MxssVFBklallShH+QPy9w=;
 b=Fs3OV5xRiaRHq114QuV4pJnjA8j//nirX9Ihm4JxpxmqDQyFj9Klk94KHHOEQbRAVF
 FcHRHaCO4nayMCkNNHDVterj/auKBa4IXEiqSeMRDIdZqP+Ruul464ZcWPJyvn0MTlTL
 doOmhHcm6x/t0NV89R7FmY7gkT4dd5hrOaUtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766173904; x=1766778704;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I9hW+bOrzAbfan3DOplEi+MxssVFBklallShH+QPy9w=;
 b=w0feQ7a9m82uNVeUPqyE58jtKmNwhSt1mC2T82eDAXOEqu2U/lECdrQo0mFOgBbyw/
 LUEbIGTIH2ndeAu5gAQyOwvc90hFeH27rGI6z3uwFY67FfoGusAelmEhSuM6CDNB0rTy
 08kiB++dTDHr3GyMckQUUzXyjg4ROebEOsM/y9G1AYlIib8VE6LFK8I84cmzJosmSAbq
 7Gv7oNQdieT0irzp0GYOQXdlK3sBP2AQtluIWP7fkiHwoPgHFbzsN0xjXfqgYjSWl2lq
 Sof8XIoarpNTbgneYMExEY//vtAwKlhrp+Ao7fDlJrmtj2gg2LmJ/KhDg/m0LPNrkuI8
 6K8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrZmK472hEJbgpBHhlR6+ruV0OYJ3uKD30Si7VHSzUKgJSo8OV4tR8gCwfGeyXRs81E9C5rS0=@lists.denx.de
X-Gm-Message-State: AOJu0YwGXppkM5Rnrxu17U5D9u4gfIGfEx+Eb0lBjNlhZ5JdGBkKYG1K
 RMyY6Y5JmZ2uCMe5urtwuf8ItQ0QP7QoAqZ8/2BLFaSEk2/IysgmYC9w8viLwte7MThzBwli1QH
 K2Eu57kM=
X-Gm-Gg: AY/fxX5uW85S4E2LlD0Dl/wi30CokrpFtoLZNe7J3zfmVZsRyrqiPsxGMsGHVGNFVNc
 e9If9KvU/A/IsSaI7XhuOAjPsB4s8pS3xlt5TRmbXIZbW5SpLxuci1VPJW+V28iEAUvt7KozQEY
 ywEsjwej3Ye8k8OWgLiYaLGVZ0OYcz0CfDOsoe6oWZsd0PE2GIFi8H7KFKXwd4GRXdWr+zGqsXs
 u6XpNzOTaKeKYdk2CwhYC9OMmzRVVWPhBMiZ/84+oPVhXi7zw03MIhJT6qHMMY8E5d9N7bF/jse
 1Pf9S/hIbbae2JydJhUsWdHN4C4o5moLmULcF1hxjjw7pn6aah3rAo7UT+8aRx/OYiep4aRxKWk
 3JrLWOFUfVQRn0fg1Of3elwhw6ig0r/Q9+hkD/ExROF9To7UzIN04aZAsEtW/dyXUpggm+7mt63
 V4sR4DIWUKTu+pVXwjdJzoJbaamYWYcFy1W7s7YJD4ghuHM50A
X-Google-Smtp-Source: AGHT+IEFb27LK5YbJd2WGyWKs8PFt55AcougYIjUiSXm2KFjF5xZHt7Z/w1swdo+WN1WCiLgL98xHg==
X-Received: by 2002:a05:6820:1507:b0:659:9a49:8ee1 with SMTP id
 006d021491bc7-65d0e385a90mr2213225eaf.21.1766173904254; 
 Fri, 19 Dec 2025 11:51:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f46c775sm1899236eaf.5.2025.12.19.11.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:51:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <e151667a-9f5b-4baa-84b6-5a243ec88545@linaro.org>
References: <e151667a-9f5b-4baa-84b6-5a243ec88545@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20251219
Message-Id: <176617390351.4176400.7397979823572847097.b4-ty@konsulko.com>
Date: Fri, 19 Dec 2025 13:51:43 -0600
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

On Fri, 19 Dec 2025 11:32:47 +0100, Neil Armstrong wrote:

> Here's a set of Amlogic changes, the principal change is the initial SPL implementation
> for GX SoCs, ditching the vendor BL2 by an open source implementation.
> Then a frequency lowering on the MMC driver and support for EFI capsules
> update for all Amlogic boards.
> 
> Thanks,
> Neil
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


