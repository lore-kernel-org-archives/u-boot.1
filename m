Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA78FCA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 22:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACAE833AD;
	Mon,  1 Sep 2025 00:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7t/pneg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A7D83938; Mon,  1 Sep 2025 00:38:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CBA830E4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74549616950so2634558a34.1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756679900; x=1757284700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulKps9hpKAxjftBifeJAvlknavWrQI9E6pFN/NEbbrA=;
 b=k7t/pnegZP4cvCi+yhB7NgsGhVLq8yuxjVuyGDGosy3P16MYfSHPWE3tSA60CDRlzk
 iADrN1aOdfSHZ4y6Ak4AW8PIuRAseGAfikUvSJwBvx+3s1nf99iFiKQT2V5aNU24TLBY
 ZnMnXnmORzSVB3O55oUZ2jGtD/0y6zNtltZ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679900; x=1757284700;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulKps9hpKAxjftBifeJAvlknavWrQI9E6pFN/NEbbrA=;
 b=wdfY3Qb9hSur5mIqfsmrpjRWoQ/wDKFjh9dpe4VC5Qt3j+XH3cic0CiF9M1cXUqtsC
 t0Z+sOdrUIQbithg2ASTvNpe0K3FOyzqBuRd6GqCzW7OW7eezIQZnbJNz7hf/vqvLXRi
 BWapitiFzHiDXlrEkIoRWvfBj9/T4qVKgVWQegUVQsHOLQeF93vNQktIwOap6UAW2HxJ
 H5r533oJbWI330zod8FwgzPOp5uB8dmc6VDDPgXiKi1t8Y+06hY2J1d533snlsmFL3Lo
 nl/e6+tmub1x2fsacKpZapzP4Vl7UsO8XvwqvQG/wmqkDnS/qQ9NhwBwSU090AWOEcKF
 D9iw==
X-Gm-Message-State: AOJu0Yz92E6/N6MbxBcNIEkBjqeLr/9n8yxGU+YS97NZjdJvfwzmdNgW
 AJ5xgxgF5QbCxlpRhGdC/Atop35MfHg74W6QiaHFhb0q3iZFo6kIk3zMwujVGtnk9gVtmSL78ol
 P8Z2O4uU=
X-Gm-Gg: ASbGncuorY4/9aIU+jnMphVs+22DWMK+CLIy4OxKePb90sxnaI/Cil3lyS5jmRxc5ML
 2ZjHmSjzNHU3M6BND/V0SdIU3vU3hVUF5MtBJHhdDXYQ2YuXOX2Jdoe41qIj7Xu4jfGlAEXgbmD
 cEQch62OrKvLmqbwMaQ8xX5kucwTIawfZG3Io7q2EQ/LUm48KiERZNm7eoqr9U4WYvJs/Aryty2
 J7cdNEN42ihGZLx9lX4Uwk0+nuQnf7ZZsoqN7qkuPo8PEg2ISW3+0hit+76vON/TF/3lzQXAcr0
 tSeOp7qGGiwkUuN2wMwprKRruqkLS096PmyC5nmfpCF09D1Qawf6bRA+wU9CzzsNv00mL4nRNkw
 7juxXKGBDPeF0gbCrQfft/ljhrw26N7s/HHEMj8p/pDdDKM7UqsNY7NfTm3g/sqGSAj8FkDWwoj
 OG
X-Google-Smtp-Source: AGHT+IHDTxX8qpXjQZw5ztVNB+vDx0EWTUvs/QSWRwwrkwdttM2W/wW159ByxoVaySpdWCySfhXyPQ==
X-Received: by 2002:a05:6830:658b:b0:745:6512:abc with SMTP id
 46e09a7af769-74569ed7c0emr2985312a34.27.1756679900214; 
 Sun, 31 Aug 2025 15:38:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c153sm692089a34.8.2025.08.31.15.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:38:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
References: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
Subject: Re: [PATCH 0/2] power: Address two Smatch reported issues
Message-Id: <175667989911.2964020.11162341901596596373.b4-ty@konsulko.com>
Date: Sun, 31 Aug 2025 16:38:19 -0600
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

On Thu, 07 Aug 2025 15:28:56 +0100, Andrew Goodbody wrote:

> Smatch reported issues with two power drivers due to redundant code and
> an unitialised variable.
> 
> 

Applied to u-boot/next, thanks!

[1/2] power: axp: Remove redundant code
      commit: 446b7b8f2d9b5b9bcd473c91f1e45cbb77be6c5f
[2/2] power: power_i2c: ret is uninitialised if not DM_I2C
      commit: aa136393c8fd448e903e3fd3297efb13e54c42d7
-- 
Tom


