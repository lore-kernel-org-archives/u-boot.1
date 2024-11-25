Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6522AD58D73
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA82E89A56;
	Mon, 25 Nov 2024 18:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eF7dZFbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13CC589A5B; Mon, 25 Nov 2024 18:27:07 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0409E88E81
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nareshgbhat@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d43134d574so28298986d6.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732555624; x=1733160424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LgEnGXARVSVPR5OERj5lkRbjJd7JGdyhQ2fSf9hnLrU=;
 b=eF7dZFbJM1e6Loja+v8czNd9RsjA1lFA85H2aW4vIiP55/wV5/cL2fZtx527fxUUvK
 jj7amD8iP7XXr6APmq1ebMHp3Vmwmmcfvqdx6veixtBnOXgQytQWqoPNdDJuR1IQRCBv
 GtoXm7DKpmA8KUmG1bJDQDUXPQw/N1I1PNxqydZ55aU0LvphlxOCInmsKwg4Ci2r2HU/
 GkhF0beyADf1ahgYIW2zOMbukPqd48KpkcW4UYVIrV56UnQZEJampIBFjBbfYkqtL1Yn
 TTrniHnydLMJ29weBlL1bKeWwO/Yaqx/rQt/b5GML4yJxMtCEaHQFLo/tGY93nePoOwB
 hXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555624; x=1733160424;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LgEnGXARVSVPR5OERj5lkRbjJd7JGdyhQ2fSf9hnLrU=;
 b=cZkzhfG9Ghv4Q7jqm3ewVZYwLdA6uhv3kbSK17V6EOJaNEV+nqixz/89J4rZXy8x0e
 UE7T3RCBTVZqBbBZ0oJia7nNmMzxv8NxEN3QZg3xddav1HWOdqVvd+Yij1hEsW/zFW3c
 i7JUGZHouygk1K3PSOtu5oaQwIZ9ejK8XGYC8TOuEXGX0sHpHhx3IUPlQGj+CJkqPYyR
 xvOP+gDJdzplhJkGOcI+Ixs6rYH2l5ZLB9UEE1P2SHXD1nh4vb2CfTjrThH+Bv8PLswQ
 uky/UzfgkXLebNyh1GhzNeiGBorfmRhqpkkxGOqxEKiqcimzVmOYUXhLU5aPcxj6j/f2
 ug+w==
X-Gm-Message-State: AOJu0Yw5MqCQMJTXfP+Bt/D793P5QQE6CpM25VoXy6X8EYlBrg5PMt+m
 rH5bNRY4GlsaFTKmDAh5ukS9JL6lZ6fBERCMXFf3/R41wgNRbsUjmoKTA78cleeof8TIZNsLcO+
 9IknT/NRA3FDn53FIuXf+TioOf1E+BQ==
X-Gm-Gg: ASbGncvrwPghMh8ZT/H8GzBm83mlgnxy5Q2Kz8hNdhBT098mEvJ2mT+Z7ULBDJ7u+RQ
 aS9Mrw7RXkif5xQ/LxD/AJq5HAFQKp1045RaQmkoZnlN1WxlFdPMqOOkjTZTx3dsmpw==
X-Google-Smtp-Source: AGHT+IFRt24ajCB2Qm/a3gDlUYMbsOZJFlga1bCoVugnNPxPXSb1gIcXHf9UDnWAr/BIlljVPaPdEAT2KCK6MUWEqD0=
X-Received: by 2002:ad4:5c89:0:b0:6d4:35f5:1f98 with SMTP id
 6a1803df08f44-6d450e9899dmr209571836d6.24.1732555623668; Mon, 25 Nov 2024
 09:27:03 -0800 (PST)
MIME-Version: 1.0
From: Naresh Bhat <nareshgbhat@gmail.com>
Date: Mon, 25 Nov 2024 22:56:52 +0530
Message-ID: <CAJXQGf+zViFSdRzBMtxBMKTV-iZ1fB5qDkiT6hcH9iYwnz7PwQ@mail.gmail.com>
Subject: Question: Looking for x86 platform for u-boot development
To: u-boot@lists.denx.de
Cc: "sjg@chromium.org" <sjg@chromium.org>, Naresh Bhat <nareshgbhat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 25 Nov 2024 18:55:21 +0100
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

Hi,

I am new to u-boot.
To learn the u-boot source code development (i.e PCI driver in u-boot),
Can some one please suggest any x86 platform which has a PCI slot ?

Thanks and Regards
-Naresh Bhat
