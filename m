Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5D0C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 20:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5754F81B4B;
	Tue, 25 Mar 2025 21:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A2ReqNKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5E18192A; Tue, 25 Mar 2025 21:18:20 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B930C81DCA
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 21:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225477548e1so118757305ad.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742933895; x=1743538695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eztKR4zFVfZXP4Db7SgkDHKL7wWb3xCwQ+pCMQe1CoY=;
 b=A2ReqNKEX7w2nyMUVu7tF6+coLGB4QEf442FZ05gV34QiIjXzYzofWvQL97T5ivXqo
 L9ei1FgiTCd03VoS1F/0eZaSuzx+aqCd5ZskAEhl5XZvP9bvf6Xx2OtXQfThSPhSKAaJ
 MD5mg+omSK/FvqlIR/arezgx4CfM99HneKjqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742933895; x=1743538695;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eztKR4zFVfZXP4Db7SgkDHKL7wWb3xCwQ+pCMQe1CoY=;
 b=CNRozL3hVpoRTwiPkJFEIloGTZZAdRPVpfCXl5LMPNuD3Eh8fVBi2XC2Y5tAzz05oQ
 uKETf8u8fa040RRDXrTbfaWrqz4Q0vf5zIzE8kSTqpVYHcz6g9JhgM2lFDe8bq2Mv6cL
 jca1sS99syJSfImMn0iWzYu1VkMbYubqJyrWkTVIBxSlJ+fsoaOhJTPRZ5+BAZFk+Zkr
 BqbXCcjBQWhIso6ux7uCpeSmOfyqpFtBxKM93OxwkRaEDoZbRC96CP2lZJ/CKL/2mnB2
 VyKJXXX6bmeEvxJH0jla2nDVbTNLuDK7pA242F13CJmAVLVKa6VgzhRdTfArsdvLoQCe
 CmsA==
X-Gm-Message-State: AOJu0YwioPVo8TaJTcWidc4eAfVLS7zy/dvHN5ZNmj5//9u5tr6+rSP5
 BehIKZvr9KUjr7fy9AQ4iQxEvhII3VGXppmPAdQKUyhQoMQCnR3biIoHW3HQFKx6nU8JFeW0jwy
 Os54=
X-Gm-Gg: ASbGnct4C7SqhGhOiFra6BE+LQ4074kaIOq1ZrKjXNfBCIcdLntgu3oT8qoHOusnpXU
 Om6LSfJ/oV1ZjLpW0fdPhB1Gepjr0pHYskRpTKnmpz7vVShuAQlRHxUwUxHLBF+r3C7+sJcUEzO
 y3PXNBT5wvcHSfS7Blo8Kfa7ORCAKXbArXK8Vq4qBlsvcJc1qx8EnN1X4bL/gjpmfjCvJZZfLGw
 hrAEiJWdgGV+7y5FAXchjPt2SRSOVVJEcjAWXxfvrYtXg1U+mkiBjmrQbkREA0qk8kRFlhnSUb6
 TVARhXli8A8UeAnMOfEf5MXWKTnH0+NBgAJIyILLpBuz2/IL2m80
X-Google-Smtp-Source: AGHT+IF4VVW0WEZfkKq7nWeA2Z6lCyjmYZM6ehEKpztgE01AWN5MK+2Lg021RQS0RKxzaWSqUYLnUA==
X-Received: by 2002:a17:90b:2647:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-3030fe95343mr35105785a91.12.1742933895004; 
 Tue, 25 Mar 2025 13:18:15 -0700 (PDT)
Received: from [127.0.1.1] ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61a3e8sm14919940a91.38.2025.03.25.13.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 13:18:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <Z-JK2ZtWIEGwfwrO@swlinux02>
References: <Z-JK2ZtWIEGwfwrO@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-Id: <174293389404.370289.1693061857898656699.b4-ty@konsulko.com>
Date: Tue, 25 Mar 2025 14:18:14 -0600
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

On Tue, 25 Mar 2025 14:19:05 +0800, Leo Liang wrote:

> The following changes since commit 3d8be1f5ec30180748259a251efe4f63c8b4b329:
> 
>   Prepare v2025.05-rc5 (2025-03-24 20:00:24 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


