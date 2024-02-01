Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F4AC4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70D787CE9;
	Thu,  1 Feb 2024 13:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MnjIb8ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5317687C43; Thu,  1 Feb 2024 11:14:53 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D65C87C1F
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alon.barlev@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d8d747a3bcso5797195ad.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706782488; x=1707387288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v47QqO9foTE1w7WAlv+nidy69Ol0LdRE7c61hsVG2gI=;
 b=MnjIb8eaNaan/IXImCIt8zjsGt2Fsybfl+B0M52jLx2pRcIwyX+iPJh/Ae6QAhunRX
 tsUPJy/NrAky57w7rrTQ0dRiIUczPvxKL6jmNJBzcc31/JE+ZMEnWhFDkyfmrGq9l48E
 pyIZZcE2npdfVrrZYq7vUEHzAiHhY6T/Y/S2T5IDEXWhW6ze7uv5TAcXAXutNKSeq1qc
 Hb+rccdgK7n4l1ydhCENtOPb6JElE85AVBY1or4KXDFo4Rz25k9lp4c62X/gTj3wUQse
 Rub4dReOIZROuPxb8g0Z2swshnV2r5uAxv0yj1Ml6WjYoQUVq/8Qt1KFpwdCSIbNyzlG
 L7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706782488; x=1707387288;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v47QqO9foTE1w7WAlv+nidy69Ol0LdRE7c61hsVG2gI=;
 b=TsWWtqsk+W57egcmVK2/eCL3HyUfZU5dwikOATOexWWKj0eSJFgnoxhvpymnpvI7sm
 NxHZotE03PI5QXYC3tynOUehuZy5ALqMbYLVd9KX7FwsorHVRd+JCk58iBs2K/xT7Ubs
 z9ll3NSJfo8A2EhyfM0tTL1MKTsufEkjBljrRN+RrEli0c5CxrQrQ0QAPfoRJisStMhO
 o1tRxO7EyMc7kWexZdDg3WaKq/K7DHIAyLbTCQmAKpw4nwYCDXzm6OjX28+Zp+3Tk3f8
 vmLlBLx3APMujqiZtaH3LiBVoTS+fp0+ogcQXkPWrykiRLEMCEqV2ejiomcPXC12juf3
 AP2A==
X-Gm-Message-State: AOJu0YzV4SMQqtewOXTES0/ZiAabj07NwzRVLoCEb2UQkVmWoGidI3lX
 XY2dlmVObnRXqsF/FE7i/ma4GbfCMtyEzd9q6H84Le7umUUILIaXATC17mb+FySz1IAEQPm8iQ5
 InF89XgYNP3eRe/Wfl2SSeagEv1FBfFXFc/9SWw==
X-Google-Smtp-Source: AGHT+IHAzY8j2SRpavFE0kvvoW6YJK/H4cCVNs/hqZ2IhGVfKzzjvWw0cRiX4ff54V9Zw8Pl2R21TquUcfk4+QvjR0k=
X-Received: by 2002:a17:902:eed2:b0:1d8:ceaa:1a4f with SMTP id
 h18-20020a170902eed200b001d8ceaa1a4fmr7745896plb.25.1706782488247; Thu, 01
 Feb 2024 02:14:48 -0800 (PST)
MIME-Version: 1.0
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Thu, 1 Feb 2024 12:14:32 +0200
Message-ID: <CAOazyz3GJCCq9R5xo8E8JqZx0xnfJLL9ceuExTCR3Lx93bwqEA@mail.gmail.com>
Subject: u-boot on iMX.RT117x NOR
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>
X-Mailman-Approved-At: Thu, 01 Feb 2024 13:25:59 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I just found out that u-boot has some support for RT117x, this is great! I
could not find a better forum to ask, I will appreciate a redirect.

I need u-boot to boot from the SPI NOR flash, I have the EVKB evaluation
board. The SPL that is generated is not ELF and no instructions of how to
use it are available. I am using NXP-MCUBootUtility to flash in SWD mode,
not sure what I should configure and how.

I tried to place this on top of the flash as raw binary and it does not
work, I am waiting for a life sign at UART1 which is redirected to the
debug USB port, as far as I saw the SPL should output a string to the
console once started.

Any hint of how to progress? Any documentation? It would be exciting to
have u-boot as a bootloader.

Thanks,
Alon
