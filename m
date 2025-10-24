Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94945CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 04:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90F1832BC;
	Fri, 24 Oct 2025 06:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eMUz7SjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45A38331F; Fri, 24 Oct 2025 06:15:33 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AEB82E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 06:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.guo@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-290d4d421f6so14793695ad.2
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761279329; x=1761884129; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mQq3YBgsr2p7B6Y3zsuuBGooZWPeLELRt3xWi7DnngA=;
 b=eMUz7SjEov0zGhAZfAgBWzAyu+Q3dczuT5ZPQVY7DEsRM2AwCeSSy78ZUv44f7K5m7
 RX9MBCFOdFRi2NRsOB4FgqRwsORgzrgW+HKixuyEQ4LWpQraY0caC0QL8m8/ybk0lQTl
 MO9WnC3kSfZry5XJK2kqi8hpLsdpDqWzeSwoPBQuzs+NUGEdUnfURvLvt98TEiiORe7y
 DMIffmtQBpTfYRHb79yzPEYEfHEsxlXwY+o/Jye48W7jYZExYobCX0L0VYt6Ci8nTw/X
 i90s8bZG9snxrSYesIZQfN4gI44kwajBRGwsOhnsQqZlecg4nwEDSNr2P9RY0eoLg3nz
 NgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761279329; x=1761884129;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mQq3YBgsr2p7B6Y3zsuuBGooZWPeLELRt3xWi7DnngA=;
 b=iBWyRUCWVs8p/0f0i8CZpHA3T9l8H9tEizmPQTObcHWM8ozSNu7jjqXN2yhMY55fAI
 l/v7+JPMNC6sNFLBFxEvjLWUSkHGvUxlDGXtzlA/96w2BlxNcn7V8W9aV7ucNFsAO+pk
 DQ/L/RhUWkEsQGZVTNRRhc7rTfSGxlnVEiZ2kBVASHIrjp5kO6XyGGR/HCvC4Au/5B/y
 9w/+OAv2lmKd/YMxzbeL1Adn77vQrZn3VgthB+BgiFGKO2YcKJdb7EgwXgWSJYnDzVfX
 jKQBN4M1+z/C6vnlwUb9+EADA2nO9v6/k3gq68zrAPTgu2IrElTugnMwTvl03uCQmC9E
 xAdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjZRNW1426SmHyIvM/R5pHJOp/fLZzjv6gMlGVi7uE0+mMiWal8cMoID94LBjV5woPSfuN3Tc=@lists.denx.de
X-Gm-Message-State: AOJu0YxevxJ3yULGTkMcODUvNGkqfEWbtBzkFjNGqeshljNJQuFK9N5y
 eXLtFCThjtyJ4LXaoMkxglO4rC+Ln8YrZOyttEGnKKMX0w1G/Ucvt07TksWG6TAqoAo=
X-Gm-Gg: ASbGncttqfIc44h+YP9iwOFIz3HCFeJgVpntn1vLU0O/obWKqUSNEsc2b5F2Apof8Fr
 OjEk5sW00CkvWtfcWB6aTZIktYswc8TwStG/PTOavYnZMJVykl+1pDPN4dDTInmp+6dKsC56hl+
 o/t0mJIOkLmWde3i5v/SztXzqgkCUq3toYSNooM/1hIHD1RP75SHmPQASpEwNrcGycWa8Jpft5J
 LkC9McWIZyjkePnFiFglscv5uvosVtxH5Js2ehHmJLRJEtq01WugLQwSOApHNi6apIEFocSeJWx
 M23JsbNgEo9m/Ab1AorkxRQ8QrN4Ot9Qn5ynbQVMPWVzIAnEX99Vzg9WwOOKO5yZk0YUGJIIw9K
 bQeoDS5xk8xGQ04N/3d7gb/mN1GDNMTZVcWbabdvBJQ8wc/gvwavXke0BzPAX/vI+pq5z+Rve2Y
 ih9ql7bzbuMBn0Oc9ZWJiu7Q7T
X-Google-Smtp-Source: AGHT+IE9wA3NEAaH5n1iYVXqpiEC0/bNpm+q9Iwqig/MWfRWENcz+//DlxiXXkwmUfY29PqzVIHp7A==
X-Received: by 2002:a17:902:d587:b0:269:a4ed:13c3 with SMTP id
 d9443c01a7336-290c9c8c7d8mr343466275ad.5.1761279329512; 
 Thu, 23 Oct 2025 21:15:29 -0700 (PDT)
Received: from dragon (45.78.53.11.16clouds.com. [45.78.53.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc0efasm41022345ad.76.2025.10.23.21.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 21:15:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:15:24 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Marc Zyngier <maz@kernel.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Regression caused by "arm64: Reduce PT size estimation complexity"
Message-ID: <aPr9XCyh62ULrY7U@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi folks,

While commit 94d30f476fe1 ("arm64: Reduce PT size estimation complexity")
speeds up the PT size calculation, it seems the result size becomes
unnecessarily bigger than before.  For example, on my device, the
original count_required_pts() returns 6 for get_page_table_size(),
while count_ranges() returns 14 now.  That said, the PT size returned by
get_page_table_size() eventually becomes 64 KiB bigger than before.
This is too much for my device which sets up PT on SRAM, and causing
a regression here.

Could you guys take a look and see whether we can get PT size
calculation speedy *and* compact? :)

Thanks,
Shawn
