Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A4AD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7E683B22;
	Tue, 20 Jan 2026 15:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YiC9gQmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744C683B0D; Tue, 20 Jan 2026 15:31:08 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B12383A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45c819ca0f1so3202488b6e.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919460; x=1769524260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgAS8e4myiPCu42TnFrG7j6Oi21syes+SYo2y9SJBmI=;
 b=YiC9gQmdAUcdLPp04cIcJlpkkx5mNH9OREtl5u+ZQ/XcA4X0yjKQAo8coaYmCUh6SE
 60o+0GdSyT9TOAyudPKWtUTze57WN6YuA5NLXraefh11Z+bIKvHyUnSZvmEjti/axE8T
 I3Dn75nF+vw4KYhRr75s9URKchDsNPRQ8JEog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919460; x=1769524260;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CgAS8e4myiPCu42TnFrG7j6Oi21syes+SYo2y9SJBmI=;
 b=tR7/DixMcoB+Ick3j/JnCAWsYIeQ3JtC2FE+yAr0r+Nsy59NukugPi1jL+sg6krR0t
 nNP3RoeYIZ/ba1ru6a3SAQb2Fubu0kSga7tAKrh+LWbiwu0qVdRuDC5dgmj31F5ReFQ6
 f0QEkEankzZn02yojeftrES+KmVIm13Q47ZASPumE8xClZGkWGd5S+o1JqthAUB5hC5I
 QaZ0bno91sZam1I2YzFO6fzmENPd6PgHQMiaqsWxD6wQ/NqMW96NbINNoOut4updqe14
 YFNiyqYkmlwEO7+ex5jiMF0RMQqUzcwGLpMQi8VYexOJJmCtAGraqv2s6A5mpZyr+hzL
 9Xzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxuZ6zLEoRD9XodgYJZpnXXprc+PuMWg/XGfVE4ABwI1x9vYro2HivDRgsHvqDLwQlPHZS2is=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdgec/z2/GHD/PLN7jxTnYNxjOxXxk8GnBPavUqeFf2H1fHLhP
 Uikm55A2A1hOobgMKRRu7Zegjqh7NIp5LNIxyeNMfw6MA17vP9ewWKBaEsdY4zlwpmA=
X-Gm-Gg: AY/fxX6WVbfmf1cGwZgwk6uAamRUjnZupbBpps12diCuSkvBkTueFxANP4wf9LqxRK7
 vN/Dn4XCS7QUZAea1JaRsCqZ9fVp2fLpgDw5y/C3J+hsVDgLo1qlQOeNQ/VjGTCcT06saDtqyk9
 a9pqX7YIznXXT7LGauXiIn9pUwBoPlateYJ3n60gpyj1UVbbDyuNiz517toU2XbNSbZMzziCWBo
 29uZjL4QavW60k0nhdKnwJiEQGuTQ1SMJVWYEmTia1mBZc2WVmWsnUke+/a0SKwi7K7/EEjejQ5
 RkPM0ElrE4n5ODJKU8R1544kp0A1fX0ArViQqKUJIrZnd2Dh7cDzUxKd3G+1Pxnpke2AMNTQ/RM
 EuhjKPTvLf4Ndl6R9tNEhZX20Y9ZfXbdt79W0A6tfJV5vmbRjPVQxXNItcvJv6A0jHW0doJfwQx
 PV+yMVQSzonQDAiSxGBaHustDvHP9TkA4Gsrrp3fSIHeMsWlydzMPiNDkNkm1/hP/QewgNg/UP2
 bYupYUEUHQc21jVUDxhv7LXpJxV8XnMQYUjvA==
X-Received: by 2002:a05:6808:6905:b0:450:c6af:7c10 with SMTP id
 5614622812f47-45c880ff49dmr9349723b6e.22.1768919459932; 
 Tue, 20 Jan 2026 06:30:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf38ffsm8657418fac.5.2026.01.20.06.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:30:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 Ray Liu <ray.xy.liu@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260118200416.690517-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260118200416.690517-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] Revert "arm: dts: an7581: set r_smpl for MMC in
 U-Boot"
Message-Id: <176891945905.379251.12739237678736346622.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 08:30:59 -0600
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

On Sun, 18 Jan 2026 23:04:16 +0300, Mikhail Kshevetskiy wrote:

> On my AN7581 board, the same change in the Airoha ATF-2.10 source code
> causes instability in eMMC reading. After the patch, in about 9 of 10
> cases, ATF BL2 is unable to read FIP image from the eMMC flash. Thus
> BL31 and U-Boot are unable to start.
> 
> Lets revert commit 7cb79f8d3d55 ("arm: dts: an7581: set r_smpl for MMC
> in U-Boot") until the issue will be investigated.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "arm: dts: an7581: set r_smpl for MMC in U-Boot"
      commit: 9441ad8715d19e3408313d0b5f51e3ca42d21595
-- 
Tom


