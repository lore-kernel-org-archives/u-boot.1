Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B0EC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D27680FA4;
	Fri, 31 Jan 2025 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mUi8SAPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F345810F2; Fri, 31 Jan 2025 23:07:06 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E798807D9
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso32245996d6.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361223; x=1738966023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeTX/ZTCS18B+2xOmMKd9ey81Gvz2QKWsKG5LfZAmAE=;
 b=mUi8SAPcjVHuvFIYszX41eF/4/7HNBAuDgLRqLZjwy7mKf73OAY30DMQpmSH3fYHxp
 NGbyKhp4VrTg8osQVNLCKXpJfUPhyxGSXgz2pCpS9OtvUeuF8YUQTCClyrxHwaHQKCqh
 CaosMpC3RFvZF40in+LK+f03Rzc6gxCLIX4Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361223; x=1738966023;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeTX/ZTCS18B+2xOmMKd9ey81Gvz2QKWsKG5LfZAmAE=;
 b=fin+P2G9SArBkLN+yyfafKBgPC94Sy/y6gHqDuFN0pevSg6eY0tRH8HGOjIEriJ6JH
 IkVy/F5bEg00r3hq07MqYh2ua7yCzK+UutY1sS2ItLaTRqylvLjWfFgMuQ3XMearQpd2
 hDSAJXLP4lbnrgggjQ0+/UD4lkjcMc9282F6/2IQRi62XXJV/gF4JjommGp90zuIurv1
 J+w1LX1AHv5iyBPm9BTQ8lfQlws6g0sOCrNXpkZMe5uSw6VTXhst/SxJO6qxrp57l7ES
 bOA0EynaXHV2NCK8bmSSSlNrrbkpRdLkQIPWREXn0SEfJ4YmAERqrT4jFNfqljqy0vmb
 w/7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefW2jqkZ/vgoEmHTFf8o3Vy4uFcjsVrmFqASXoYglSXYX+0B6B9z4DZpBOJrVbtrHO/eUUAA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn6mQ6t+OvMzueWzI86gUh35pArfrjasPzfLHiRyZAevPsmztz
 m0iTrkc6Kmhbp9MWUjM2jJkK5nusNoV36695wf3h49+qaH4uNWRLE1RGtCtnvQk=
X-Gm-Gg: ASbGncsofP6acvOuxkrdmeWW5nL6HWmv6wtNHuQ7hoByXgaDqXggk6WYq/khQ+ImkLm
 FDoeR5AkIeOAh9AWrFzgW7L5NVHVOIgct2sqzWGFeqXf1sVIMUX/MHjQYypWN5LqBPwboZYZl0Z
 FAcklxz30D/ayp6o5C8OsQbyTbTGvlEwfh9us+0Gvo5dXTLIVZnDWqEwQREC+uk7IuoKJ/9z7NI
 xvXkTzJ3XTF4iMODoop9dMFe+shr7VQ6IdJ8YIUzHQmIXMKdu0kDPuce3bSmfGIK1FO5AZWBA1l
 xGYTb2jOfKdTyw==
X-Google-Smtp-Source: AGHT+IFK1C5F4w6tFl6JJd/OyYghZ7q5quRXy03L8iJxB0iEt0ht4IUURXEmxPr65XApBZezYBNZhA==
X-Received: by 2002:a05:6214:b6c:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6e243b9627amr203573996d6.7.1738361223232; 
 Fri, 31 Jan 2025 14:07:03 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:07:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: n-francis@ti.com, bhupesh.linux@gmail.com, u-boot@lists.denx.de, 
 Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250124-topic-sm8x50-ufs-fix-v1-1-18b7c220cc34@linaro.org>
References: <20250124-topic-sm8x50-ufs-fix-v1-1-18b7c220cc34@linaro.org>
Subject: Re: [PATCH] scsi: do not fill the LUN in the second CDB byte
Message-Id: <173836122199.3060818.11624475726775047562.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:07:01 -0600
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

On Fri, 24 Jan 2025 03:01:48 +0100, Neil Armstrong wrote:

> The SCSI specification originally required that the second
> Command Data Byte contain the LUN value in its high-order bits,
> but this field has been marked as reserved since the SCSI-3 spec
> from 1996.
> 
> Some vendors uses this byte to pass vendor specific data,
> and specifying the LUN can trigger strange behaviors.
> For the record, this happened on an UFS device where LUN0 was
> working perfectly and reading the other LUNs would get the last
> buffer data that was read for LUN0, making this issue very very
> hard to debug.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


