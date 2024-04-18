Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0B5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB828864D;
	Thu, 18 Apr 2024 14:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fQtyWjS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7473788646; Thu, 18 Apr 2024 14:56:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885DA8864D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-418def30e50so5078455e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713444978; x=1714049778;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuvjtcDFy7Ob6JlJUPsalM6JO9Lnc48LLujxsDYs4xc=;
 b=fQtyWjS4191FrqgJe/F4Yr6UJmwTqx81VIoNdECmzcB0aBqIPBBxIZuOnpXc193Ok1
 2Ohl7+T26QbXM3mYPZcVykNQR+DLqnmhNx05Jyy5Y1ab0/eRCYKhciBLwX4lXmn6rL3T
 XUKrzAtuG2xVQGivCKdJpJhINm9r4LLiRX0Q5KmRYbYLx+YN0doCh8VFbfnCrvB5YJgP
 HKiSzJ3nqrQ5irNbgJX/no5GQKdsDd70IbitYbdJcC5Eht3pT10Zy8Z6zNFedmBQLn1k
 Ys/TLhwmaMLvgDoYcqp9McJt9y9GROOr6Cu9UBbPmaJzq1o13IZvfjV09nK8+ihMagZ2
 ZZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444978; x=1714049778;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuvjtcDFy7Ob6JlJUPsalM6JO9Lnc48LLujxsDYs4xc=;
 b=fOwyprg3a2gn4FfBTrF1eczdqUB1V5IeflwV9SrDa+g1yLSbiAddYR1bVd+dDI95EH
 Jdd9GPd8BAupKbT2Pc4DADQ+1lKPP00Vnw/8GAYfdaWfk8wJPLWl1dCS0tkPvjwyxqwb
 7Wr+rODyJWzLCfLp2V7G1SXUZxVLqxiUQc+RP+P/gG8jw8IrWwo7LNNp9MCX9xHU+29E
 PAhhYa0/yioNByBq5WuHtrTLDRDQonhE3TCmri2jkgEQXOJDdNo9UeLagdCIaDv9i+Qy
 HjpPIBoG7UYrTYRWFmBcdmwGSWOBVh9gd8EwjHH933UxB+QM8wkIgIT07qTS6rap4gXa
 pJuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmVitzpYQayIX+cxhO6+yobupnwryUu1GPdzGADikq0/cY/rHDn6neQ6p0gFySxyMAiatHIzA2u4zjs2jx8RezKUpCsg==
X-Gm-Message-State: AOJu0YyfSTmNqiWbA06VUeYJZF3yfZ/0u7E7E2+ATOV4jaUYnrAVwkqE
 oCEcjpygM7UH+Ta2yt3+XqD9dyC5/h0wbyZWLkT/pWfiDoOD3NPSvWSk3acx7ZFW4TdffcJHdyL
 G
X-Google-Smtp-Source: AGHT+IFz4RR/QACMQxPkBPidIAuJRzw5VEn3P5gGGUUcyA9Flat4T0i3utjK9QfErVgmlexUdiY8XA==
X-Received: by 2002:a05:600c:4ed1:b0:418:d2c5:5c65 with SMTP id
 g17-20020a05600c4ed100b00418d2c55c65mr2256005wmq.37.1713444977953; 
 Thu, 18 Apr 2024 05:56:17 -0700 (PDT)
Received: from [192.168.2.59] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c260e00b004188a8369d9sm6323683wma.47.2024.04.18.05.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 05:56:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: sjg@chromium.org, hs@denx.de, sean.anderson@seco.com, 
 dimorinny@google.com, patrick.delaunay@foss.st.com, 
 quentin.schulz@theobroma-systems.com, 
 Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
In-Reply-To: <20240418100129.1691822-1-avromanov@salutedevices.com>
References: <20240418100129.1691822-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v5 0/1] Introduce fastboot oem board command
Message-Id: <171344497714.79554.14279665680701879683.b4-ty@baylibre.com>
Date: Thu, 18 Apr 2024 14:56:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

On Thu, 18 Apr 2024 13:01:28 +0300, Alexey Romanov wrote:
> Changes V1 -> V2 [1]:
>   - Added an example of using the command as requested
>     by Sean Anderson [2].
> 
> Changes V2 -> V3 [3]:
>   - Rebase over uboot/master.
>   - Add documentation.
>   - Remove example added in V2 [1].
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: introduce 'oem board' subcommand
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b2acf59baf917c3b4002c1b2094ddb46c03ab02e

--
Mattijs
