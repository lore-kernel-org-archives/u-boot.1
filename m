Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F936C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 09:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D44F82103;
	Wed,  4 Jun 2025 11:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F/7lzRpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C25482B07; Wed,  4 Jun 2025 11:22:10 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8664781FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 11:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-606741e8e7cso5246336a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749028927; x=1749633727; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2qQPrb5VuatBnho54Ty2ihSEOasqqe9IgIhcq3KLCr0=;
 b=F/7lzRpUiGelCIqn338FoHbzEfEX1OhnG6pcrrDpGoB75w+3M3RPlhELWHf1EwQZzi
 HNfkKfYyu9syWud4dnDvGnhOBhRtuzVuwat1WV9otR5x+lSGVP4AW0ugGXho6t3wsukD
 kT7coUlBU8qaPi1Vvb5NhsKFZRFt5tqyAgdkxiDy0q/EfBebPeDfy6u65EzF9XvnwZOJ
 WeD0mKqIXaUdzMKbIaYztm2WK67ynHV5sl+18ggbsxkSEzQjQSvcfzcmUVenTiOdq8aH
 Nb1du1OJLS32AlBbD3eRYo5hUKbsSic/NdVZuKKKp7QkI3/Alx/oxJqTaw6F6qWEsU0M
 JqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749028927; x=1749633727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qQPrb5VuatBnho54Ty2ihSEOasqqe9IgIhcq3KLCr0=;
 b=QRFI2JNknA0tagKLVJ5YI3L3fO455EDYDv3RCRFcH+VCZWrC5Ix+VQqmfAzgxzllBP
 n4j4ICniW4ZBV7PCbKvojyQePDm1aMul8xXjtTvs1eO0Het/NxszvQGRGIW+URby+cA/
 RqJTFE+HnO1m1VT0DcYx3mqqne7Ua3BXAuEsd3Zx5lmKhnftQk3z514uLkWCF5ka8WyT
 YRDy3hxfXTze1m42/Jls8bUnycMmMhMVk9o/72MaOS4rlOkMw/O1kGWbW2OHhyNxVLrp
 xXxM9eenyCcAISelXTL3HKsvGtb3M/r5L+Q3JwWOHpc0zjJZp5MNukRbhsl/Z9aqTFkX
 gp9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpVYhqzobCIfMeY9kAYnEnuICSdo27zNSbdADibgQS1MueQ+KsXuN9cVx5dD+VTkkebwfsg5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyIcnCYrVfzW/QDapZfDzoNsh+Hzzhg0nA4CoPIATnvrhAi8XlP
 eH2MVMlk48h936ouZwATfijMX0YmOYCrVeKOFbNCaHKfMiD/F4R3frRCH7L6Xrt2xZxOXKg1x1b
 aRSmF
X-Gm-Gg: ASbGnct02JrSgazbwTnYsSeyBcpfSRtFmtV77QavIvKXfi1wLaPHNFpynKqZaZLsr8M
 BtxRzqfpXvBE1HeYoDqW4nHDaQK1YAih2cL6ZYd3AiFNCTeiYyPS5nUT/ZlRTGGGMG4HmsNfWtd
 7PsUvsMwM/bAmMMDHxmzrZYTzGdWgFaai9E2/1hlKDJLc1TXE33CZkj/MrK7YRoySnHoIkk4JB2
 KqPUbtlYysExrCtDpArA/t+PGBofUNL84dyResVWVv6NKOer7ENDu0YvGArQAv/vEA7ZWhi21X5
 fEZGGF4Xhq+E3/W5JOGeivfrQF7GLOmMAEfX+wnEPiWTUvh1fy1Tyf9rLlZvGg==
X-Google-Smtp-Source: AGHT+IH4Q1qLbCOh923XOFPxBfDtaedVf7xgSIS/msgNDFIFUpjMBcO6NIhKQF4i1hDfMQlpespmQA==
X-Received: by 2002:a17:907:2d28:b0:ad5:56fa:1904 with SMTP id
 a640c23a62f3a-addf8faa1bbmr167069566b.44.1749028915847; 
 Wed, 04 Jun 2025 02:21:55 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:68f5:c95:7678:409b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb325c829csm915498366b.145.2025.06.04.02.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 02:21:55 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:21:53 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/7] configs: qualcomm: use mkmbn and stop creating
 ELF files
Message-ID: <aEAQMapUyEQsTQeV@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
 <20250602-b4-qcom-tooling-improvements-v2-6-c7d19c0d4a8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-6-c7d19c0d4a8b@linaro.org>
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

On Mon, Jun 02, 2025 at 06:10:57PM +0200, Casey Connolly wrote:
> Remove qcs9100_defconfig since it is now identical to qcom_defconfig.
> Additionally remove the load address and REMAKE_ELF from other Qualcomm
> defconfigs.
> 
> For these platforms you should explicitly build the u-boot.mbn target
> which will have the correct load address and Qualcomm MBN signatures.

What is the motivation to require explicitly building the u-boot.mbn
target? Couldn't we do that automatically like before with REMAKE_ELF
(i.e. add u-boot.mbn to INPUTS-y)? Or is this because of the additional
Python dependencies (the cryptography module)?

BTW: We should probably document the Python "cryptography" requirement
somewhere so people don't get confused? qtestsign is Python 3.7+ and
cryptography 3.1+.

Thanks,
Stephan
