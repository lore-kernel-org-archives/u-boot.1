Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AE9C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 18:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC5F801CF;
	Mon, 20 Jan 2025 19:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YHJoPKWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACE6806DC; Mon, 20 Jan 2025 19:07:28 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AB8800B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 19:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd01781b56so59945486d6.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737396445; x=1738001245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF5PJ2MipWI9g1UDOU44QGHMm8a+L+xR1wJ2XCmdsLc=;
 b=YHJoPKWde2VbVI7ZUyjujBQE6exsEAbIF7Z6RFUJLgQ/YYjexfhN4XbvuKz/2tc9YI
 pA13L7AOzSys9jZoZq03FWTXJjWcOyxjpE4Zh+NczcLO+siKeuA6BFdpd1M5j41bkSmW
 uqp4UKDYPm9+HnJIH4haqvrPGLiXGTgXl8Tx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737396445; x=1738001245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lF5PJ2MipWI9g1UDOU44QGHMm8a+L+xR1wJ2XCmdsLc=;
 b=iOJkuNy66JMWf8l4fnrtjnizPw5M8cI14liu1yp22Ua5tK4kKizfLOSqssksE0lgZp
 2Onjgdy1PuUpAP/L8+FXJWQ/+TfhCUaFp20j9sn7Rr1WsTcZAH/Uy6FVyEO4Zy3buPPB
 TdeacM5kmXannxorVMpyJ92XNHxgGfL/0QfQMsRQ5hLV8OHqdmuDmVfEoHk0BVGE526J
 CKfNBp7/BLExJFQORNXft/kHEFLUOAsV2zp4TaCvjueFKVqaKuhdYhpMari4k9OLpI/+
 i7pN7CNcVmwi9DY6b6u5zyekPOX3wZi/1PyH/2J3gS3mf4ReDiYaskLcDbOKfC3W0yec
 Fuzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoGFJ10Hwu4xdx20sSbgyxxJYqEsX1bodzbks6yI883mA6KU1Zvn2lW4u8UMla0mUS8D28JLE=@lists.denx.de
X-Gm-Message-State: AOJu0YzV3ZWV7jbHbKdkjKf6YPcH/NDK5vOir9Tt/SNWpgxjLa7nzKTs
 uAee2MvLccSFzDePE3QhgC8RpqWbR3S+UlrwfLzFRQBaa71iIdTCHjqyJRTzYeH7WhYWnmyNGbO
 D
X-Gm-Gg: ASbGncsPCbIBPGwaR2g8PHc4Nf+JDvvBqH4m1+HMpWcNIWXLS2/d7RYzTZpPlEN3Og9
 VBziCZ9LgNH4TVeiaQONcu1FlqDTqRWCib1N9Zo6xp3DqAFchnRj7PxyV3VWJdHy+DCRrs7YZS3
 txU1M4AGnaZLiK5pS/+CmWd/Z7lcYeXBS/a/TF2Fo0fOAQAOch/6HpPZlg9XllqMfYLMrQ3pc+3
 sAZ4mQLCIjw2yMA2HT1HRVwU0W58lMkWt0eH6g08uvnC+10zHcQapkCuTqGQ6TbrA==
X-Google-Smtp-Source: AGHT+IHumC7xyd7esUD8C82YeVAFqxr28vq74SgOriUCjbSF/Laxmit9sh68JRPAC7Jwav3rDwJ9cQ==
X-Received: by 2002:a05:6214:2aa7:b0:6d4:27fd:a99d with SMTP id
 6a1803df08f44-6e1b218060fmr261731946d6.19.1737396445689; 
 Mon, 20 Jan 2025 10:07:25 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc230a4sm43258946d6.50.2025.01.20.10.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:07:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
Message-Id: <173739644462.2747182.12652565280798458747.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 12:07:24 -0600
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

On Sat, 04 Jan 2025 01:34:02 +0100, Heinrich Schuchardt wrote:

> Upstream development stopped 2012.
> Linux eliminated YAFFS2 in 2010.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


