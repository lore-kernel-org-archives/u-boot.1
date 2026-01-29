Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD3D61015
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47ED983E48;
	Thu, 29 Jan 2026 14:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNqZ9lCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B8183F20; Thu, 29 Jan 2026 13:13:17 +0100 (CET)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8E983C61
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-124b117776fso649180c88.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769688790; x=1770293590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+Kc3lpoJw28u34DUjpQczO+vV0WFlDD5gbDlbjqAVw=;
 b=aNqZ9lCyggePwrA5qcAqJIw8QQStUghtpE8Qsc1UJEfI97BeVOyu28akJGfKfrEjeX
 oPMW3E+X44eZtXUPZ7Z8hVck9lE0AdkVbfYcWskReOHsSz5hbZbKUxpSsvO5mX6bK65H
 VtOkiNBVkAhuEEL9KwkdK66aGfnIVCCHoHOOyPNI3x2nK0dEDIebirzsdeyuYaOHXNLZ
 Groh/M/wuYAblovOcX9HXN7xBnU+PiNkvtOuK4MhzA9vuEeiEm1bJu744FKSmYWPYdoF
 sry16PiFcnqvMATegUfjUio/nGhAIezTaBSr3Z46CfqJsJgeaZZI7HUI426j+tuQcr3o
 gfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769688790; x=1770293590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8+Kc3lpoJw28u34DUjpQczO+vV0WFlDD5gbDlbjqAVw=;
 b=ozlXdmBqONBmIk7vAMX4syrRf35DB404kyIfDs9hD9sFpLameBXdf6eV3U6+SG3kop
 OXfLDnVSq0v2Ln/DOKaoAxioFApghwzAJd5k3uS+fE4blNEMEYWxHEszXbP75ofXBWdV
 3v/4Jgm+8TqPipdbrYkWGeIB/WSxxOw4JCZx32JH/sNH8Rfw+EGTOod/yFmBPrMlZXYq
 8saQkFI0odCvsLxJJ8I7hHdm6mdcsNeONORo1RFoQgdRI0RHIAw5v3pEUHr1z5rcsokM
 Gyr4inXQ80xr/+822LH7Nczuf5vezPDo6g8Y2KmSFoQ3w92cTf4s1QBih4RVNm6zzlOj
 h2yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5AkNZwUMmUZ0ddgr+p1HtspU6XnhmJWqTqPZhh+RzNAbnlHQm73gZO7w3o7UGQYfqQsyWtRI=@lists.denx.de
X-Gm-Message-State: AOJu0YwuySvRWb3sDHzYF5irhJFgM1Y4ZBVaoT57ea/gvff0Ub6UIpuj
 t28X7ys8BXpbY4pW5RhAkgXnrhjMMSiqrbOA6bFHLYLnQCgetqjRspq2QVr9Iw==
X-Gm-Gg: AZuq6aIC1XGqMyqLtjN3kYDVB4DFHutulws3PoNwwbT8eVLV42UUREwi9fzbFst73pw
 Yuov0b82HM/Omxq1Ua8eR3wg2JCALo0tEX8losiy26xcHzxGPED8waPvlY3078R2v4dV5fI0JHq
 JEJFRNX3H73LUYOVZcMTeI0RzZdCKuKhmgM3f0i/thMghlg/f3APafo4GzGj/EpY3GSe+Te8J1z
 RBkVqQ0hc5AZVvUiBG4ti/zY5iq7qvwgF0p8GmroSgYdDGmMS/YJjF91220UAHorw3MDVd2a3qs
 mPsR/v2UvZQjto0J61ASSK22Oc5iEXa+GByGC9Y7LNskmhCqgv157xlfvvyRa4OlRsggqjqMFDk
 j1iUROsjjpqDNiSMFtHL5AKejJ7xv0V6sRvRoFEq9MV4vrP8j5K9RPh/TIXmyRtufdw9mWxMkAj
 CE0yGjDV/XO4k2lp5v+CrRJBAidontl1mixN6vmbFvlPjr
X-Received: by 2002:a05:7022:425:b0:123:3364:2ca8 with SMTP id
 a92af1059eb24-124a00c6b3cmr4527892c88.39.1769688789854; 
 Thu, 29 Jan 2026 04:13:09 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d8ba78sm5901431c88.8.2026.01.29.04.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:13:09 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: marek.vasut@mailbox.org
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 ssunkkan@gmail.com, pratyush@kernel.org, trini@konsulko.com,
 tudor.ambarus@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v3] spi-nor: add support for XM25QH01D
Date: Thu, 29 Jan 2026 20:12:40 +0800
Message-Id: <20260129121240.4052-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110203000.9999-1-ssunkkan@gmail.com>
References: <20251110203000.9999-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Jan 2026 14:29:46 +0100
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

Hi Marek,

Just a gentle ping on this patch below.
Please let me know if any further changes are needed.

Thanks,
Ssunk

