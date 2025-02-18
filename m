Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A961C021AF
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88AF80BA8;
	Tue, 18 Feb 2025 20:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FW0Jk/hY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1228B80F18; Tue, 18 Feb 2025 20:35:14 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B434580BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-221057b6ac4so58784795ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907310; x=1740512110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0ouT5ECDQAftuCYyVRkHxpF/dezoj3BsP5QXi9Qgdo=;
 b=FW0Jk/hYOJVcHy7t5aJ7ETgGz6ArYJjvsn9Kfmqu26h/FUbetiv0YE6pMaXD+3AE6w
 S1lDMlnAjbM8b18gKgC3WFs7+wkTXiBEwfiMX5AErtbJ7VTGXxTrDzHLFNWyFbTZ4gyH
 0ygLDxuMcDsZ+iUlYpDHHmhh7fPrXv1Wsktwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907310; x=1740512110;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0ouT5ECDQAftuCYyVRkHxpF/dezoj3BsP5QXi9Qgdo=;
 b=CF1vhqL3ZrScj0t13iZm87xEh2Ik9CJYFkMQAzVB8aQRCKauHmuZXY0142+dpVw0P5
 1JwqZl54Gzl9E5CZDZuVXTnEOsGzpoWa1sJldpborMwXvOkRTL5YswR3IyYxK4iDB2h0
 S+tRzSk0Kkc8MLHEH6CkDqaWLsyjyIKQMh06r150JUVlhXV1pJcNIi1xPLRqmpV/vacn
 cYynz/6S6KY0CNJ2Yxtjv1Liu2n/SRJyizCHMESMXjmc8DcNu8O548uLxgFxhxZf+RR3
 GMbG7TxvckJFP93kJxwCsHFgaH+4KC7p6CpsdTqp6ChOL6iAzIMNQjMzkQABlHu+5Fro
 YV3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxTpm+oZzwG9nKRb/3NexyN2VNK2Vzm4PXoKb2rgS/ybMwqMQ/Kb7628EKmi2TzPjG9TUbc7I=@lists.denx.de
X-Gm-Message-State: AOJu0Yygd0FvFxbAwqypeM8wC6RBWSUg5+vh54MJaxFZe1+mH8KrAZmx
 hwxb4EA95HOyy3O+0Ob3/Q8vBtAEticn1itCcxQTzRBvoRyzvnC58QOllqjkCn0=
X-Gm-Gg: ASbGncsMw0H1qFMIIjS8G+m530ZZ5Andp9YHOEQDJycVMcZEfxk4SmqpKXQZgKnRQym
 1KAa15Wm0+YcDCkjRw9skjygiITo95QiV2LuhCDeBP/Y5avFVkgb0UdKdfoTonXclewTLQEKbUn
 Aom+5p5F36IBl3l4P+ZwJEj0jlL+/ODc/+nZ5z8fqMPxQkcjTVd3otedhRTN6G6P1hX+w/gACUK
 +aF8/44WYegAGUdEfc07L5e3Je/IDugxrgo7xhMP9Up7gDYMaKzjnEIQl2XWo7pumJAZLbD8Uxy
 8vfxwbvOpnVn
X-Google-Smtp-Source: AGHT+IHYR5yGfHocOPMJi8DRe992CCb6VLU5wnF46jH3wwj3cm/CzsS2RyrY+UyrL+x9FKWhJn0WFw==
X-Received: by 2002:a17:903:98d:b0:221:370:de17 with SMTP id
 d9443c01a7336-221040bd798mr275351295ad.32.1739907310342; 
 Tue, 18 Feb 2025 11:35:10 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d52esm91875995ad.121.2025.02.18.11.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:35:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Alexander Kochetkov <al.kochet@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Rasmus Villemoes <ravi@prevas.dk>, 
 u-boot@lists.denx.de
In-Reply-To: <20250211135522.47868-1-heinrich.schuchardt@canonical.com>
References: <20250211135522.47868-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] tools: use cryptographically safe RNG
Message-Id: <173990730879.1542939.9215342804811799684.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 13:35:08 -0600
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

On Tue, 11 Feb 2025 14:55:22 +0100, Heinrich Schuchardt wrote:

> The PRNG implementing the random() function only has 2^31 states and
> therefore is unsafe to use for cryptography. Use arc4random() instead.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


