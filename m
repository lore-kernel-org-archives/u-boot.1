Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C4C982E1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4119E83A9A;
	Fri, 16 Jan 2026 19:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jjSM8ZrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95308838BB; Fri, 16 Jan 2026 19:03:23 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CEA8397D
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-655af782859so1864891a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586601; x=1769191401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1R0NggZ9Mc0OKfhsx7/sUeWKopAGXdaE2Efk7o1zL8Q=;
 b=jjSM8ZrYnrTNqeUVHw3a02E9dcsrn7Vl2NvxBEOkJJ6dteLIhUc3wuqaLtIVigIrKd
 TfK8F/Lm79dG6cBXj/0jSYAjQKVznMQHC7xe4Bd+XswhJyFpGE6mgq22qF63vyeqBNdy
 MuVY3OGva/RjwQPdQLZuFjFex7E7k2nSXToRQca8qgUVGKWTJ63hryIJ9wmbfNUQN9OL
 fXDo7kR8Bkq9IPQuyYKeoMSK0pKJPa0ike6dsvKb3CNpk0VX2EjJ6KXUFCCFwBhr6j0X
 dex9YnHh3hsl7A7Mk/YVPu9y1BKhHVanr1S3zCqkZTG7cjd8LQ/fPn7K8wCUiDQe9er+
 IMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586601; x=1769191401;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1R0NggZ9Mc0OKfhsx7/sUeWKopAGXdaE2Efk7o1zL8Q=;
 b=OeJdrT7dXdd/cvIu5HAT7UCZsBp5BPgBRQ/BDFdJrziMC9TXG25m86ZMVTe1TBBZHH
 FLA17rFrvAwqa6gQGH9aOBHfWdTVYEMRJFX6wngL/6mTWpG7ytCLBSFnQLgxSGwxGSKC
 8E9BsKgr4TqD2Xlv9HNYyzer+a83rv4Vn4ofKP6uhlCffT6+gVu4SGmrCbSmaGS27haL
 jn6nOAqmo6cQ9wAI1Wl5BbcWfLjd1T7wW1YTg6g3K7vRLvPILzGtw5ABG27QTz74teD5
 R7FkEiKrC0VruCa59j1skA7YtisuOHM/jfEB/vBBL58Fl/8KoUSUu2n6x541oixv4x4X
 GjSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRG8Y72QbsV7hia3TAHYuTAO8jDs/wddZmLchxMZRNwzfu5ucpnVN7w7qehV8yyqnWFhUG28A=@lists.denx.de
X-Gm-Message-State: AOJu0Yxyp+b/ynW4VeSvgCulbDM6uwiOrp9ljRl2T0Xq5rWnv+OStq8C
 WLsLOYH/xiZNhlS1FQm5cAgOsj2qJEjsE8o/dULNFjLwpOLYDUVL5kVY4NaHR0MprdU=
X-Gm-Gg: AY/fxX7m3aX0yMNwWYnSPr1trh5qsu+o/Gg/ncZjdUgTsMzeztnGqw6vUUhGVm6Lbe1
 5N1GAdhFhrctzdBwEClSoZUEG66poMu84izzPo8rRyddXDPwR635g5vFxR2AmExHl+Nfw4UbO6E
 S5ti8u8m9muAmUK7VDv/4327nibay3EkPauuw4wHnXjKmJhNQS46ZMpEvZJwweg3bxxWFIXCGrb
 M9YnTHWzaJzlpobhpot6wxemLURvrKsbX/LESlW5YZvh8/yfhPG75vxUCW3LId7mRHMGds9QTGw
 IyOo7PuJrp1ZzBi2+CaCKH60/L8Yxh++CFc5XJEXl+JK8PpwzHR30crpStzt8+wEYvgJP56oDph
 AyG8th4M6ArtHsau0N3vUJhXG1MEMf9imgjAq5FQRRpduFtMpfcuZsX2hXCBevIzr16Kt6DlZFK
 D+JQtUIlWKMNAJHsX9IOxXSU01z2GgqDKNexKoa3ajOqzNBIObVXEmaQ==
X-Received: by 2002:a05:6402:3644:b0:64d:56f9:47e7 with SMTP id
 4fb4d7f45d1cf-65452acb596mr1727074a12.21.1768586600800; 
 Fri, 16 Jan 2026 10:03:20 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:19 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: aswin.murugan@oss.qualcomm.com, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251119152312.4175482-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152312.4175482-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] configs: qcom_qcs615: Correct debug UART clock
 frequency
Message-Id: <176858659936.3399278.16616508515694409425.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 19 Nov 2025 20:53:12 +0530, Balaji Selvanathan wrote:
> Adjust the debug UART clock frequency from 14745600 Hz to 7372800 Hz
> for the QCS615 platform. This correction ensures proper UART
> communication timing and resolves baud rate miscalculations
> that affects early boot console output.
> 
> 

Applied, thanks!

[1/1] configs: qcom_qcs615: Correct debug UART clock frequency
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7f1a1fa05107

Best regards,
-- 
// Casey (she/they)


