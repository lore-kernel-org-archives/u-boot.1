Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA992C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4005805C5;
	Wed, 22 Jan 2025 22:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ie3LtF3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4894C803B5; Wed, 22 Jan 2025 22:00:56 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFDF801B0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46783d44db0so2056081cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737579653; x=1738184453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeQ2gQDDp+r7EUiyM6UdvUXIWq9loLih9QDXVxS0n1A=;
 b=ie3LtF3IP6aW9YDcx9NSouUWkl99b2t2gI5QresXaVSHleq9+HeXM/v2z6OgSRLMmR
 e82MRoMeCQM3tb2Q2kEmKx5jc0ALWkIo79r7fOkD5uFIli35BxGQGxxDYRZnjOrzi4eC
 4JvXfQ/62PyK0iFzLep72Tt5LDC+o15U6b5Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579653; x=1738184453;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeQ2gQDDp+r7EUiyM6UdvUXIWq9loLih9QDXVxS0n1A=;
 b=I3gaxYoaRRxuLuHRg7Z4mvKLSocfwy/w0w6AQv8qsVsdn2Ak+y/0DGYjg4xuC/Pxvv
 lovrbU/mPEMhN0NLFnq+QtMjl8PxXwipEz/dQ3q8z7rtSyYdukNOKbDdW/CD2Co8gzST
 WI/cUTRUk8shnJWC0UNI/9U+MwLNOhbN9zj7ueFyiYhufgsIj0sl0F016JzRYLjpvciI
 cNNwO+FX3rn5nx6UAEUO+iWW7VhUZORXqN25mBCESpRhvXZGBKWPkuXp0utTE28u6UgI
 Ejt4wFwhQtPhZTBET1A4fyfSZmCf0PvMm6HIgZKYaxNbAG7Emkw31EpT6Br5HoNIWw7w
 cjGA==
X-Gm-Message-State: AOJu0Yym405hWuMU87opdulhBWOUwprftOGLhGmAsPT2CCi1UGffe0eL
 u+97WezD9Jlie290cIvRFTaakZ4euFU45/Hmi2huoWGO0t7CQUxPwoZFBEXobIM=
X-Gm-Gg: ASbGncvS/LqzFUpWlsRfiSQ6DV6JpzVSSwJAqvJRrI00E7icO3JFBaL4GSJ4zU4ce7E
 1ROMCWn0X9hQlynZD68GImAxcHMvJZ4skb5ZRYEXAquYFcPV6Rl1MGzzcXU4jHMm9xY1y2wcG9i
 TQfknqJs41GEyDKF48rxphOq6qn5KKw6ziF+FqS66lZjtiitramIq+FSM3A5QokUZXKri5NwSHJ
 yE12x44RRCRmlbLxQUVQAc9E1rLjQ2qFIMeq7j6a9fF6HPZ0AGZ2YbPZalvsBkvVCFB
X-Google-Smtp-Source: AGHT+IFTgCX8Gg36i+e0N6K42xc61Xxzr9CXSBJ62KWP586K4Lu5v/Yv8419AFs0Er2l/ubO6I+EBQ==
X-Received: by 2002:a05:620a:400d:b0:7b7:1118:907e with SMTP id
 af79cd13be357-7be632761aamr3446077285a.52.1737579653024; 
 Wed, 22 Jan 2025 13:00:53 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10305328sm67560021cf.32.2025.01.22.13.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:00:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
References: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
Subject: Re: [PATCH 0/2] Update my email address
Message-Id: <173757965144.68186.3436015044286510246.b4-ty@konsulko.com>
Date: Wed, 22 Jan 2025 15:00:51 -0600
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

On Wed, 15 Jan 2025 10:32:57 +0000, Christopher Obbard wrote:

> Update my email address for various locations in the U-Boot project.
> This will (hopefully) stop any mails from going to /dev/null.
> 

Applied to u-boot/master, thanks!

-- 
Tom


