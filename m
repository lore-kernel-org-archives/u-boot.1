Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C05C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCAF883F6;
	Tue, 18 Jun 2024 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JcQSksQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826BA88263; Tue, 18 Jun 2024 20:57:56 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD458838E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d21b3da741so3202170b6e.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718737073; x=1719341873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P414DitkuWuMI/xEG1qrDVkbPbRYJDohRFKwIgnNCmE=;
 b=JcQSksQjfGAzjbaGi079NEBnaO/jOiMX+P1tqDlPy3hQO/7G+Yw9mlC4zN62vzT6Ee
 Pnvwp6oe/eELSEZmdriuy/h2m/K3WiwuhmjWwvQSmX/hKrxmHyTl/6fu/g9B86pv+y41
 HUe49rQSB5j1qmBEB163BrP++975xsX5OpDBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737073; x=1719341873;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P414DitkuWuMI/xEG1qrDVkbPbRYJDohRFKwIgnNCmE=;
 b=fVGL6A7L53oS6OInch704i/9GiXuoYKk/j0+zFTs5gF9iwIq3pHbGRZK5AB0FynZS0
 OBUrMLxYiVMvSYW6h3iTTV8KdCUaOjx6/YOPbTBKQOcqrxg8QsIKVVTZdmoZbJicZKSk
 468gYn8usQ5RtjBvafXizIFMpVcNSUUwpZARcxvJqfA+Xz2D3h3zIAWXem/HC+u2CCVn
 8fJXUTtG7LhspUdtTAlAquDmKZp/OyQEb9nArunZGVoD6y90f9Vgm+x/wJeg7Lp8Nao8
 Aq7x0Whnq+1ET7E6wOhmD1x8kBoCoh8jcCZ8wXq0RKrcH92eh+v7fkbb7cxTI6X6WsXk
 BQeQ==
X-Gm-Message-State: AOJu0YzoDsNbJGj75YxhTfs79TrKUIKDlTJyzYmLrCeBmZ2aczQ4xwYb
 uXx9VFIpGN9ETMrRHkL695EI8CNdKnrUmifoMD5lsAIzcqc+L3JeDS1i1DOn5PM=
X-Google-Smtp-Source: AGHT+IEPRI6jfK9WKEKOQEu4BT5bSpZn7rrhjMMk6XohclqNp69DTcxfekr7OdmYI5pKjK/ZdOuRCA==
X-Received: by 2002:a05:6808:1707:b0:3d2:24fc:bc03 with SMTP id
 5614622812f47-3d51b9b7ecdmr670906b6e.24.1718737073202; 
 Tue, 18 Jun 2024 11:57:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31cbsm1875120b6e.50.2024.06.18.11.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:57:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240614155324.2606614-1-j-humphreys@ti.com>
References: <20240614155324.2606614-1-j-humphreys@ti.com>
Subject: Re: [PATCH v2] configs: j784s4: Enable basic EFI CMD support
Message-Id: <171873707229.3326390.4136212898329890052.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 12:57:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 14 Jun 2024 10:53:24 -0500, Jonathan Humphreys wrote:

> Enable basic configs for EFI CMD support.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


