Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74BC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 13:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BF3811E1;
	Sun,  2 Mar 2025 14:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jos+4xcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2BC811CE; Sun,  2 Mar 2025 14:49:12 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB19F810ED
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 14:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so2919507276.0
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740923348; x=1741528148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMxnpH4dYqm/+TtWK41uQw36cp6nWPYClhKzg/0OwPU=;
 b=jos+4xcHivSDE1JuItxsQkeQ4ARajQ5CfM94B49bCfiOnXyfm1kL31icLWqCI8gcno
 TX5OBlgkaEzxeQKxifTC+ieweRQYrnRdMzPyJnjOMQQVuIZojI9LivvPDnO8wUHPeJDm
 QJiubDA3RA3mZ21r28aNOCyDp3hnd3mDO1Vu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740923348; x=1741528148;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMxnpH4dYqm/+TtWK41uQw36cp6nWPYClhKzg/0OwPU=;
 b=MR98DQ2/K6p5aTQAWF9QUOBgMSvxDQxhXUAjjH44900INOti1ujfj7Dh91yZAjZY3F
 kr99gpCs3nEuvyKipIDd0nawqZQfr06SdJVbxH7zVS2RDmGYQ9xoSMbP4glCQqSMJeP3
 2IlvGcn7FkVybdoMhTxil8OQ5pq7Idioa3iR87gk5/MNcRRhnjxntDCh3spveXc29U0K
 AaVCTJ2/FtmI89PWZqVLfMCmk/cs3B1PEYcimBQnlxDIKkacNuj83KxFFBU3c0TWeufy
 veiWBBT3MdbgBdcE05g6vxvvK8oxC9ShgrRuEMz1tiLRpQHwPvb5PDbTjrGWtOQl5Mq5
 Q8XQ==
X-Gm-Message-State: AOJu0YxND5yqyt3f0BnBTWzm4fJ2STLbuGctrP5zua3MToDtuyRbDirW
 0yioorhT4oR7cVr8yTAJuDEvL4RxLR+viUF+yPJmDcGkKUGNR1tGWbbhlyDyY2w=
X-Gm-Gg: ASbGnctJtNKKihxGV4tlmTYr+7adeYymK4A6M2RsE6HGfptBt86cmA7K8NZxIVo49YM
 IbvwGzICiFWloi9DsUUxfVgKEPEJAoQULboGkRTv8v7juHeSk3y1Nuxy5yXFuNEyUcfEDnDgkWX
 Yl8rzaJ6S9P6JgL+2kL1b6ItVVtfxgi1rx5kLnMm1q8FJLqrN/cVM+VW/dAm0TlMhBJIGo4SW6E
 HOH0aB2Pd3/dlJqpEd4mJfUglEMIvUkzyOt4xFkDcCShVS06pon7+Sefo2uBU1e4v3KGQGBShgf
 T9v92V/uJRLrvc44i9ZJcGTSAtRy/X8hrP2GpZH5sQ==
X-Google-Smtp-Source: AGHT+IEuoGQq97UOVXVW5km7fb30v1My50Ng6uWUR5zUkVM5wWfcMkIwljOZipVyxXzsuwRaCU9Z/A==
X-Received: by 2002:a05:6902:1688:b0:e5d:fd9c:f4b with SMTP id
 3f1490d57ef6-e60b2eb7a01mr12478387276.21.1740923348338; 
 Sun, 02 Mar 2025 05:49:08 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60c2268f17sm1384552276.35.2025.03.02.05.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 05:49:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: sjg@chromium.org, paul.henrysd+nodisclaimer@gmail.com
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v2 1/6] rsa: Add rsa_verify_openssl() to use openssl
 for host builds
Message-Id: <174092334639.1368644.14401163531377651369.b4-ty@konsulko.com>
Date: Sun, 02 Mar 2025 07:49:06 -0600
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

On Mon, 24 Feb 2025 22:20:50 +0100, Paul HENRYS wrote:

> rsa_verify_openssl() is used in lib/rsa/rsa-verify.c to authenticate data
> when building host tools.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


