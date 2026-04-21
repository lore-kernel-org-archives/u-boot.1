Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F2CF8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B61884380;
	Tue, 21 Apr 2026 14:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lEY29XrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251E184258; Tue, 21 Apr 2026 14:31:49 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1672083E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d6ab4476eso42774231cf.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776774706; x=1777379506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FWq0kv3FP9GIyRNMnlMqN28gMBGa1sUh0YvVaXghZI=;
 b=lEY29XrUu7jWML0y4Y9W7XHLHahoclo1ZObnAMNlab1HvDM380VIxmFNctgKUXn+dQ
 aVHiEvHm3C3kztMyS0jxCix6DWnjquX1Jdhws0/nXEomhC/0XN/bP6X1EMaAaJsL+zZu
 xMFID8ilKDlFohGoxkuxU3zxPgt76fkoHhUT26tEYRykbkG8IIR3hNxnqGDr/1+Z7jNm
 6bq3Egq8nhDWbh0pmUtN3dnwsa8KNNqAKcaJZCbpunG1DyQsxTHK+87AVSI/l6Ic+3qU
 DJIkyNaBvbvQqJW334bMZA9hrJgim08S/uFzGSpdXKV5Rks1z73/cn3E5NWJgliwL2RD
 XpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776774706; x=1777379506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2FWq0kv3FP9GIyRNMnlMqN28gMBGa1sUh0YvVaXghZI=;
 b=n3ip62AM7PohUOk6HXomygZDJnpW9GZkoirrbj8OH13m80HxpU7VpDbYHScUUsCR9f
 cB7SFyd7wQrsPywrifhfC+hKvXVV3W0AvfHj0fBBag+TkxGxOikhYIWwC9bcjZZ88P82
 xUJS2mdN2DT7B6BFxvkXYyhOq3Evvk92Ppmub7/dAFUjcoG5lrtIm6bB9oubNxt1qmnt
 Ej7a4GXvNVKA63Fc2O3hc/iF94KvwgwA1IYQcCQ2CSyZwf+pf9tKkkGxW0y/QNCYWWKH
 pJF9HF7DBMla7ZAuc2iG4+wKgopLP1dXRRKZ6z48VBqQpm2Xc0RkvPXF/dM3aICSSHit
 PZ/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uI0yTeP9zdC3H/dFLq18G2hVfh9BZ6mWt3a+xLWZyBH4BzYCjfzBE1pbXCGolB4IexM4cU0o=@lists.denx.de
X-Gm-Message-State: AOJu0YwhhRxuIWObEtkPtSfz4nfAoWMVmvMjy3+sgGLVeKg/nDeDi756
 UnaPILwxQvsm5FGsdey2QTGcW1V+ygAVnop3Xp+AiUxFkM6dnqgtdJTB
X-Gm-Gg: AeBDieullrwp6pVeRZ3Ikrl14IUsv4EqnDzkwvcJdkUJM2E36Cja4aavjvqH5/GdSY6
 gz1GAWIXCanuB1ob8W2MRgzDc2gANEWChGJ+DO8eXuP4huyZ82JVUha7J7hbbta9j71mjTBKqpF
 KRGmZnpwZ+Ky1H6OiLXJdVLxSKVT4MxsuEzCLYUWrlUXFMJPNVLVvnTPh7yHD0zvnuqHJ7uInXW
 9ttefpIih0h8lMbuptNSBYmyv9PtB1yo1Vj0FAdFx8IYRfRt5eQ2aSCIyoAFVB7F4lyjbDP12fn
 B07AuGWfWLJfpvZAtKv63YEKwkzjjnNAI9cY3Da4BVDATAFs3hs/1fAWU8dpEVATJI2Q2CwdDCf
 F6pEQJzY0uzAzTjcF2x81hwVypMQmGOs6S0PM4EFqivMojwa4IMMeWzKD51NExHtAP6OPY4F7Gi
 Fw7ogEVrZCrFabZg89PPLHW+ejUtO6aZ5qnUCGWvzOJUiT
X-Received: by 2002:a05:622a:4acb:b0:50b:2eee:4b38 with SMTP id
 d75a77b69052e-50e36820d28mr266107221cf.8.1776774705851; 
 Tue, 21 Apr 2026 05:31:45 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e392e4db4sm105672861cf.11.2026.04.21.05.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:31:45 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v4 05/14] mach-sc5xx: Add USB boot command
Date: Tue, 21 Apr 2026 08:31:43 -0400
Message-Id: <20260421123143.5121-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszThmT1RoqXef9vYc55prSW6KypHUEv-4t=ZtfRrwD9eiNw@mail.gmail.com>
References: <CAFLszThmT1RoqXef9vYc55prSW6KypHUEv-4t=ZtfRrwD9eiNw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

Hi Simon,

> Just to check - sc584-ezkit has CONFIG_USB enabled in its defconfig
> but this patch does not add USE_USB to that board. Is that
> intentional?

Thanks for catching this, no it is not intentional. I will fix this with the next version of the series.

Thanks,

Caleb Ethridge
