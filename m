Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2CEC021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 17:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9FA80F56;
	Tue, 25 Feb 2025 18:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZPWxIa7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D970807EE; Tue, 25 Feb 2025 18:59:40 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC62C80F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 18:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5208736db3fso1733827e0c.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740506377; x=1741111177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbTZpB0rMF4lEkUVTCD2Zn2X1K9OvBxQQc66oC9M3aY=;
 b=ZPWxIa7YOz+ursmEoL1KqA08Ous+F2r+ysQDKQlc9ePSbpdQgIBXxc0YjNzDXeO+I7
 YgpS777rxdiaNOT/JOs3+65fSJzBNey5nZ4MvoPPXuEC3nzX0mT+HDtdVZ7OHLdqXU1u
 SfBsjRRHoxb/2JjUdLSlwAa4NxiJCLkc65CjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506377; x=1741111177;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbTZpB0rMF4lEkUVTCD2Zn2X1K9OvBxQQc66oC9M3aY=;
 b=S7jM1fQ8m05CmhqRilsoIwv1Ei2TP+cV7zZzGsy4tSVZaCRmyudLd78uLXbPvmqzKT
 1lC3H5rPlrfBstD9TQ5tjLFZNoutaywrS+8kNyOTf8r58DPMuzxLOdPsOSX8OMNqdqBu
 S0F8qf8xNr/2eDt1QLqeTRmEaNjEunLpm0lblw9OFz2IEFyAKjJPPtfTk/28U+bLyKcg
 fSOvYYbRiAyU3Qp8luhJHAoFLg2q2aOvQxiOy3ePCQDFOa0OhKCbkoDKzwxH9sU+XBIh
 onl+AQhtnQJa/c87msQd9RxeP1z7RUhTLTgVVcEAkX4SUxFsN2txO6qUZc5Hl2Uq4+or
 204Q==
X-Gm-Message-State: AOJu0YxzgqPMbGyma2uAYIN71PnQb1vkaloqkg3hC+slmAXuVejphFlJ
 +YuahCphW3bFvtiPHE5Z59Ph/5Yl/h1eP/SrtZLpKkHmkENpWy/Eqc12mQ7fS8nhg2OZmPmu4+2
 b
X-Gm-Gg: ASbGncuEwB7SLIzRZ3IkiYO53AHZgfW+UjA6TowVlquJ+feOnJeWpFp1cZAdHxeAhoI
 IHVDvAuhEstFxx7SDRTxwyvbVMqr4TdVwPyxPSgkS6Kb6FjO0fX7WN8fQ51GQxRfTUZvqp0RRdZ
 zh1XMT7THgSO26ocL4HQjecVWAtdcaREkb0ze8Bx/HBMXEG+k+beITTN9EvXpdgPFLWmJSpmXub
 /reHDkbQwjxDOsiVH/brVKY1oO1SbuysdHVSKzUNshRWoGLsrVeY3An8dIMJRRAjTBGa48+bBXG
 HZEeseMY5XSym11vOKNLT5g=
X-Google-Smtp-Source: AGHT+IEAUL745Yx5Tg7qJ3yFpHX0MXafqeZ9YxLryJtwfVaLxmGVhbs2SpEjGfD9lS7j7bceqgTNxw==
X-Received: by 2002:a05:6122:6602:b0:518:865e:d177 with SMTP id
 71dfb90a1353d-5223cd2a3b8mr2560926e0c.9.1740506376766; 
 Tue, 25 Feb 2025 09:59:36 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5223e1e4d7dsm281869e0c.42.2025.02.25.09.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:59:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: afd@ti.com, Anurag Dutta <a-dutta@ti.com>
Cc: u-boot@lists.denx.de, a-chavda@ti.com, u-kumar1@ti.com
In-Reply-To: <20250208043938.52832-1-a-dutta@ti.com>
References: <20250208043938.52832-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms
Message-Id: <174050637511.2615009.7325252701871835152.b4-ty@konsulko.com>
Date: Tue, 25 Feb 2025 11:59:35 -0600
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

On Sat, 08 Feb 2025 10:09:36 +0530, Anurag Dutta wrote:

> Previously saved environment introduce discrepancies and may lead to
> incompatibilities without default settings. This series removes the saved
> environment functionality on am57xx evms so that the default configuration
> is always loaded
> 
> Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab6588a3535d7bbecf7
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


