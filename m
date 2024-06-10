Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361EC27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDB788659;
	Mon, 10 Jun 2024 18:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ix9CkmbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094138865F; Mon, 10 Jun 2024 18:51:11 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EEA885E7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d21ebe1c3aso55187b6e.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038268; x=1718643068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvbtI7ULQTTNtTCYlomwrVoY232KI5jDIqW1rghdB4Q=;
 b=Ix9CkmbAVAEfSN+DuOwgLXyQiT62wUBKGmcm+bTT/EJy2okdwQ6R3i+WSzBJtxBJQg
 ErSAPSenR0U1WiPa9zqzDE0esievvWnZ+s/wWL+682hqpC7UIDHFDdA31pkIQugS90bA
 PgV0QZaECD9vmS+rx6TpZvga5UKRM1jpo7TJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038268; x=1718643068;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvbtI7ULQTTNtTCYlomwrVoY232KI5jDIqW1rghdB4Q=;
 b=MYwi8gwoVGuB0LJ1nQ5i2epANhS9RmsAMA3lbLDyZfgUiuhLjST6AX+3NgTq694azR
 Ubzp6iXKLIIK3IqgNXnOLNA29Q44WF3mwa3FY7OKL1YNhVuAZ4WeyQN7wm3WLy9FS0Jw
 7PD+yKspgH1dNq9OwbUhHXwoBTeuIuhbOEcqJSLIPUgohbkPLiYA0QFXmntSv87SBlFP
 wbcEvIOoRn8NHrzFQWZJ7kbfIvCvxKYl9QzoH8vvZFN5vES4XRM/4LooqNFFJXP2h+tw
 oo2zoXb6vbCYvXtAXthvk2oBhxJeoVWLp+A2D2zqI0GLCfw1gmnC5MF+vL6gRfB2pHsK
 qvJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuInwoTdFyUGH9LXQjV8QJWHxiEvAXL6N93/+0uwOo+rANuQXdByzxMGKJpILXgzZ6wd9753jx7aZEprO69GBlnkztAQ==
X-Gm-Message-State: AOJu0YxoIj8Lxe4c4KSBHkhFidX4n3EdsKszP1ZrSOxWS8pys/wVrqHn
 mHyL7y7SNQP9ZUi/jpJOhqM49cByXamIA6bcp0uh1an9eFHAsd6/FYrhtlccaj4=
X-Google-Smtp-Source: AGHT+IH8oJPMdWvXoSRT3Fa6Ko8Ip1TqhZbu+omeXdm0zkj6QYT/LWs/wPd+PXbU6h4VzBSh/AgUrA==
X-Received: by 2002:a05:6808:1413:b0:3d2:20b3:ccb1 with SMTP id
 5614622812f47-3d220b3d7fdmr8771652b6e.7.1718038267593; 
 Mon, 10 Jun 2024 09:51:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20240523-image-partial-decomp-v1-1-af036235963a@baylibre.com>
References: <20240523-image-partial-decomp-v1-1-af036235963a@baylibre.com>
Subject: Re: [PATCH] image: Set load_end on partial loads
Message-Id: <171803826634.2405130.13366439141379355987.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:06 -0600
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

On Thu, 23 May 2024 11:27:09 +0200, Mattijs Korpershoek wrote:

> When decompressing, it's possible that the algorithm only performs
> a partial decompression.
> This usually happens when CONFIG_SYS_BOOTM_LEN is too small for
> the uncompressed image.
> 
> When that happens, image_decomp() returns an error and *load_end == load.
> The error is then handled by handle_decomp_error().
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


