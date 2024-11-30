Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123C1D73618
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 23:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D8889920;
	Sun,  1 Dec 2024 00:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T2HT1Ij8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F19898E5; Sun,  1 Dec 2024 00:37:41 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E10898B9
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 00:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8a13444fcso240066d6.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733009858; x=1733614658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6obRx9kB7wwyDcuSltfwBB1doyDWHsYRlQtxHRR/Jjk=;
 b=T2HT1Ij8NnXzDSOYzR/djDoaejJMoIoib79GB6/1er/m4JHOAbObwYoqFSe2ewerfD
 qY+8zOoU6nh7wIzt9OiMq6GIUHNt2jYXmWTWSQcg1Ei1r7YHLC/1LEk2WINLUILzkZIS
 aH0qkg63ztp87XbGOO2+rBo9nwfdfAAE6dHLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733009858; x=1733614658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6obRx9kB7wwyDcuSltfwBB1doyDWHsYRlQtxHRR/Jjk=;
 b=IoZL+WfUk0nOBTMkiaeAUzi7GQi2rOXlFAoRiOq+ziybrlv/P/CSJRiPalzgFuuOuS
 m2JhU2RvclAD8o2p+7TjZ8u3r99BjNZUgJ5x7USKpbggVbKrXdu5pO7HQWEjDuJCc3WC
 QrJeuRaouZcC5tkAn7tz4LfEnJF160ZYLXConzDlVO11JNg6qufiMncqpaWDc3mAAr6X
 Tf08tJh7AVucajNVvCtHe7HT/WqWbweGSEa1hJwgpIfgAQlXnJGp+unoM4xa/8ZIOMB9
 O7wEyuV7FqgW3WmX5BViZxGIWJoLw8nUIU00UNnVQQ6xyzS+bs0vQ54r2s25Py8H195+
 VAvA==
X-Gm-Message-State: AOJu0Yw7my/HvLRbTT4KIFmlA8UpWRNz9uNkOcvj+cYmIm2rS4K5xWt/
 yEz4xRYKgT/lXMJfub63lczTRCOhY0PA+m2r4vPGOhLpERDJ5Lk7JxaXTfVdEnE=
X-Gm-Gg: ASbGnct/IIANci0NLn1/YW9SPW8JJAAEoJ3vpRv/T76+oySHEaotzQxMmDZ2LhBTmJa
 fJ0P0fVoRvM6/h3ZaJTggiFbAHiqcltr1Q0GkPKg9Q0UoNSewzXLBfef8JpvogH871yk3LCKOH7
 sn+EswCMKX7qyzFfOBu1hVpIJjAsOmczmkC1lL8BSYYa+7t953darfVtYORTi1oIwnHeWht/c2/
 Qol3oeyYZPmxXyBd+fh9eg+rwWVEXX1MFYg197vO3TKSVjQ
X-Google-Smtp-Source: AGHT+IGOQ9xGciMLyx7VRR7V/WSGkcCmZ7Wv7nFzd//YBi3RYLFqUYZFNjyo7GZn0hCEUVkfViQ93A==
X-Received: by 2002:a05:6214:410:b0:6d4:36ff:435b with SMTP id
 6a1803df08f44-6d864d59e84mr257815026d6.20.1733009857959; 
 Sat, 30 Nov 2024 15:37:37 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89b158778sm5725926d6.96.2024.11.30.15.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:37:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
In-Reply-To: <20241125093323.1135253-1-ravi@prevas.dk>
References: <20241125093323.1135253-1-ravi@prevas.dk>
Subject: Re: [PATCH] arm: dts: socfpga: remove spurious execute permission
 from dt files
Message-Id: <173300985610.2282108.4184128081229466066.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 17:37:36 -0600
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

On Mon, 25 Nov 2024 10:33:22 +0100, Rasmus Villemoes wrote:

> It doesn't make sense for these files to have the x bit set. It was,
> probably accidentally, added in:
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


