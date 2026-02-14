Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C79EF5851
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 18:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721E083AA9;
	Sat, 14 Feb 2026 19:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6tGvoDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557F783AB7; Sat, 14 Feb 2026 19:54:11 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D42183AA7
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 19:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso1911530a34.2
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771095248; x=1771700048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DlA5GR8ZHiB81MKVNNzvCFNaEiOu0j7aF5nvB85LUPw=;
 b=b6tGvoDrYJweg6R+eEqD9aF1RnYeDEZ1zVhMRXGM6mFIxMAt5LHVTsbJZzySr0TqAF
 ZdWOtQXU2utD6EnUeYqTPhbEJcX+QAPKpT+HDoHV0Lsw0T2xSlt0Xa57gxbp5Ksyx8K3
 aX0v3xDOHTATCgDSbgJAwLemRdwpZ6ARX4WOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771095248; x=1771700048;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DlA5GR8ZHiB81MKVNNzvCFNaEiOu0j7aF5nvB85LUPw=;
 b=FL6h8L4wZIhgRc4mxMzWXqYYXP321B9L/HwI3obdkbQ0dlQZguRpWkDp9auHcZpfIM
 FJ52ctcYgX/HYLeBA618ltGuWfAUqBGgCbn8veeX3KJs86Ui/Wo21QMTUeYv4fgAO2mL
 m7Eg84Wo056fWbTn++jD5oWjJn2hmYsjJTYT0gb/WkS/g2J25dMghaG3jWhIDtED5t5D
 6bk6/oNw91UskW2MUc1Pi2VO7d5vjEvKCeP4UtT/eAdOCql+UisjEEtNh8gFevHyrFQi
 mJx6NrkWKCyM9EHuo1fKKcd/ml/qbRqHGkoiXB4sv89wF9/wuByPWJXEpKqJm4nHBZ9Z
 5Agw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUCgeEXEwlhJsj4MOrAMRcZ5dPmJSO3nnEtT97cJJUEqkgaE/esbHLLBpuX/PPahCVJXHSZUA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+zxY5LSKlI8wzQZLV8P5k5L171Y0Fid7GNESYOQ3rVpFeNLZP
 WpgV2M45OuO3pwguO/THfp14Vr0UhmmVBRXXh1HWg0r+uSy2q9BSQHsfCDkIwTkf+KyIhw49pYV
 XjQRMxKM=
X-Gm-Gg: AZuq6aId/kAqvPdJw2I+xc+2ModrtUeUsM9kEKH7vkVI8SP4TsXTDqWuMf4KZuccKVf
 ATqAsgikFZVDKL09fw6+7kKQY933oIfsvZ+vjKR4GOwfw5y9Lfb7VBewNUTOAk10fYDUva8EOTJ
 WTuyDmSu6yVTvoW+TciO8RdlmMAZGu73Z7DyKE2nXhUvAM77uy1L+bTEW+BHERc+Kkt1o1FHlLE
 s4qyZzfqkgzVXuFvNREbewb0FNt0vaJi6+LzZlLoxAk42oiCinekZ4Uokz7ENLn2qf0BSj9UHUG
 n10Q/7Mm/xes6qsBgp2IjvXaZb2vTW0U1of1gp0nbVtve9jlxY3ZoouqOQJAESTQotqtUpFRfLw
 DCQcRxVovKz3/RmOxPz9JypVmEq55br8s4SxydSnVQYEfCbg34Zypqk9xfCfgjmMdyhShK5sjCx
 tv4P45RmcWYpZyiw+xgVEgYZyYypIgeRZ1CHBpG7lH3raG72qvMLcCcAoX0KgnxBGj6uGAVjuE4
 O5HhcdrXvZjNQ4K23al1wcZ+uZjyfwr4W8a2MuxQsv553Ie6b2i/i6CohLO
X-Received: by 2002:a05:6830:6b03:b0:7cf:d05f:3e57 with SMTP id
 46e09a7af769-7d4c4adf2bcmr3156307a34.25.1771095247822; 
 Sat, 14 Feb 2026 10:54:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a733f033sm9264072a34.0.2026.02.14.10.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 10:54:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: jmverdun3@gmail.com, u-boot@lists.denx.de, verdun@hpe.com
In-Reply-To: <20250610163835.26874-2-verdun@hpe.com>
References: <20250610163835.26874-1-verdun@hpe.com>
 <20250610163835.26874-2-verdun@hpe.com>
Subject: Re: [PATCH v1 1/1] soft_spi performance enhancement
Message-Id: <177109524713.1755024.2722298192082555615.b4-ty@konsulko.com>
Date: Sat, 14 Feb 2026 12:54:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 10 Jun 2025 16:38:35 +0000, verdun@hpe.com wrote:

> Add a test when delay is set to 0 to improve performances
> by 20% on ARM based systems
> 
> 

Applied to u-boot/next, thanks!

[1/1] soft_spi performance enhancement
      commit: 6caff66ce4692b78faf0c5c654f223eaa3aec774
-- 
Tom


