Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39C0C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9489E838C1;
	Thu, 24 Jul 2025 18:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t85Qv15B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C73838C7; Thu, 24 Jul 2025 18:01:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A345E83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so7513805e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753372865; x=1753977665; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KABcojOawYe8XKkff94446IoxbbbhGQpTBaV86ZBTL4=;
 b=t85Qv15Blu2giFiG/OdR6LbX/mlPMBQyaJhUMIl/zcaNoZNKrjnoD/8q0psUhi74g1
 rltLEhCLWCxOEO+TcrBTEqQVqFRtJQnABYy6J/RcafheLer2RcD2RWOmjsZK64xTFY1W
 ZOx8ZROnY1b0EJXcf1X2gYiP1JiBj0893caHTGeRnpiFE3ct34Jh3KsjbrobCkGCaU2I
 tpW0h2UvtU6gWTgcY2u5wOEgYMY1c5g0mo2CwDoVZb0CgA9Uf+gcEMlaZ0gmAD20M4DW
 52q2U9YvMYtUQfSr5D2psk2k3b2XS91/yXgRgezuXk+k3xWtI01tIYDPnIQgVt0dR+Xf
 LpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753372865; x=1753977665;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KABcojOawYe8XKkff94446IoxbbbhGQpTBaV86ZBTL4=;
 b=HnfmXv8D8/xqOl2PHknZmi+531zZm1oe9EpS0aapVVTYzSL9TQnPvrR7n1YJkdcMoZ
 ja4b1DWGEEKT68JZBTHr4mly3NEX0sRRqME02hTbMsoJ79DV6ZaKpUd7Xej3t4FupaHG
 vpmMoq6uRvDGZV4fS6FmglgB/2J04sB89MZPtYnH+KDFIA4TWT9kt8ekX9AaYWYLWFrn
 gvNMmxSHIpaCJf49NamZzklKD5k79vjzQTEKHRrfXHk9qgZAXOXyhlf+A7wl74LeZcpQ
 2trKHTeaLw0mEPzL/az6D3BCiiRY5UaWeXjUYffremft7SnA6Nz2kJFjux64E1FF68K9
 e4QA==
X-Gm-Message-State: AOJu0Yxd1s7CxFq1eNKxld/S72we6ZdfrWDgJc3yMIEFa8CYupWeiuKi
 0b91l5DWL2lkXFwn2tR+rBFwbfFRvmYsTZBCV0y6CDmP1zkZvZ+aTscXvXOJiVWXAqSpGjke1vl
 uAYf35wk=
X-Gm-Gg: ASbGncuMhj7F99Egj2NsSTG7pXNG0Ln7XBvfRKccwW2ufietUD4XscRJ8LlPMifsX/B
 8BzPN9q4gr/XZsgTh4O5r8Fnn3Yswp+NjUEIw+A+7Cjmk1qyN9DQ/Wx/GqAf0KNAlvnfXqim0s3
 tWEe2J0i7CquyTnriBy/HGnNQur/OE6EfLZkuj3gycrgeLkpAB/jYY73Hp4buUBwo56/sIGOf1G
 FTfiZfYatxjUZrVILWf38lupjCksLDS1nz+sWWbISoMnbcTVmNilASLlg7+8jCv6wGwSeI2W+BZ
 eEUgs22tAES+PS/zNI/ERW2ivGrIWCqvYsBdLcDrqgUNwMBUqR1mBktNha2VV8CfzOTTGQ5WTBM
 Jl6tTUpknVxeQAl5Qd91LB1rqAZrCW8NN4iBOUfVaGw7XBGJHavjUPTfUyk2R7uKt9b2Kgk+Wf4
 vSrQ==
X-Google-Smtp-Source: AGHT+IGilcm7YIu9jzf1QSv7zQb2y2iM0xLfcY6fHQYvFz8ixMz6UzSYRJtPHkd7Qa8s2d9nyQh4iQ==
X-Received: by 2002:a05:600c:6208:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-45868c9cccfmr61614135e9.11.1753372864918; 
 Thu, 24 Jul 2025 09:01:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b77078b335sm2312674f8f.6.2025.07.24.09.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 09:01:04 -0700 (PDT)
Message-ID: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
Date: Thu, 24 Jul 2025 17:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefan Roese <stefan.roese@mailbox.org>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch issues reported for Marvell a38x DDR4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Stefan,

Smatch reports the following issues

drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029 
mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less than 
zero.
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192 
mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270 
mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
mv_ddr4_centralization() warn: unsigned 'if_id' is never less than zero.
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
mv_ddr4_centralization() warn: we never enter this loop
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911 
mv_ddr4_dqs_reposition() warn: always true condition '(delta >= 0) => 
(0-255 >= 0)'
drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924 
mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than zero.

As I have no way to validate the correctness of the code I am not 
confident enough to attempt to make the appropriate fixes in this case 
as it could affect its operation. Perhaps you would like to take a look?

Thanks,
Andrew
