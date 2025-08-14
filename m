Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB98CCA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60441839E8;
	Thu, 14 Aug 2025 18:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EvM2Y9fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69976839C7; Thu, 14 Aug 2025 18:54:39 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F33D839D7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce534a91so539580fac.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755190476; x=1755795276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0vrobqDpgHY+lITmjmm1N+sECS3YBH2Pr3+Zprud9Y=;
 b=EvM2Y9fhdHrUcggwhkn/6iJyhaya7iN7nINaovn/zLYXXSLIhH9DO24MKi9lrfMkJF
 y8zBHt0wtu1ISnWkc/u5ZSaKRstvAQXNk7yvp5mzCdh4cSO5OUdGLXN0xhtNKFFQgUAO
 z1EgepiTSWTTb8hMBbVjdFOMyHhUvuf3B8cqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190476; x=1755795276;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0vrobqDpgHY+lITmjmm1N+sECS3YBH2Pr3+Zprud9Y=;
 b=dB6vRwM/yqwdZgmFbq5P8neAwWm26Nu3tNwgb1AB6QE2hFDspz7rsY6dZ56ISTN5nV
 AP4XklsWQ5qiwccgzH0/yjWv6DyeLyclUNQSzKrOM8kJ7KiZEGDes8IFOSNEwvO9KoCJ
 zQtpTdHuYQR53flOWJqQdNK/MYhWs71E8MjYZLxs9Og8AcAY5rr7Brq+327AqsKO1S4l
 J3MEKW/vBLQ3qMWWxVVoxRv5cTn36uNbAVcJ2uAxc0DMYOCVXr+QoFixaxeLNxYF1O9B
 W/5gG5ygvEeil6ISIHZWWeo4fW3FixTALGbNtJ46+01PowdmKay3plqgr583dWW8HU/D
 1bGw==
X-Gm-Message-State: AOJu0YzGQkEZzRDgqSaK48TX/4JK7J1Dx56dF4E7cObGkSm912fRIa44
 /0h/43b0TzaJxgCwMGzoX5O6vPPsM1w6zxvKZ+LCKm+754LSd3PTalWIj/XdbD3Y70+8x3zv0cE
 ubr5H/S8=
X-Gm-Gg: ASbGncvKi4pS9HgHFdGYrcW8hpaJweUVsjEpyU3XDqU9tkyCGvsJYzBKRm3bNjWRhHD
 6ki3nvnsgpcj7AnOd0P/tMoWs4WpC63ZTh5jqluiUqufAQnEnTEUPmvCe/DoXz/yhW0ETGNhTow
 CFHeNgdOQgqLMyjf++BR9PI8Ur1W/m9zao5StZ+VaZ+ZsM5h6xZg8F+l0QyYehuodazkMjbFap4
 /2rDCHuGsAbBH4GJKsosqT5WjveUR4rBmK5vp4kFLHFPJVkYAUoDb0khZ9PeAXJ2zKlIoQ0kH9a
 HrFgTk8VpQxJUGyd7731R23OBmgx4verYXOJhA9ib96yX1jLLeRBx21wh9ByhgGI6aFEUgjR9bW
 SeifgEqfSXq6AptH19aSBb/kXzaZnbOwyLJDv8XI9LYhKQ2+IikObdUU=
X-Google-Smtp-Source: AGHT+IGYVUDAtqpg6R6hyDeF5c7qiOp3E3bXWDYqjQJjmSK0LKX0+PyNFD66C98IWMxCdfQCAUlymw==
X-Received: by 2002:a05:6808:1495:b0:434:2b7:4244 with SMTP id
 5614622812f47-435df7f6d0cmr2212780b6e.27.1755190475984; 
 Thu, 14 Aug 2025 09:54:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9c91417sm4378449173.89.2025.08.14.09.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:54:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-wip-bootmeth-rauc-flag-any-part-v1-1-9f8546e80928@phytec.de>
References: <20250812-wip-bootmeth-rauc-flag-any-part-v1-1-9f8546e80928@phytec.de>
Subject: Re: [PATCH] bootstd: rauc: Change global method to check any partition
Message-Id: <175519047514.3586279.3482956245222853835.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 10:54:35 -0600
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

On Tue, 12 Aug 2025 14:38:34 +0200, Martin Schwan wrote:

> The bootmeth rauc should scan all partitions, in particular whole
> devices, and not be a global method. There may exist multiple RAUC
> systems on different devices and they should all be detected. This also
> fixes a bug, where both a global bootflow and one using an actual,
> complete device would be detected at the same time, when scanning for
> valid bootflows.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootstd: rauc: Change global method to check any partition
      commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
-- 
Tom


