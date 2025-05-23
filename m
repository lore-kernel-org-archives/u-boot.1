Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374DAC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A810883242;
	Fri, 23 May 2025 15:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VIRE2pjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABA583249; Fri, 23 May 2025 15:18:16 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38032831FE
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso288616a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006294; x=1748611094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sJy4U4I6wQRZ0M63y0NMh1KARq6RUgKpaGneju22z8Q=;
 b=VIRE2pjqSVxN+wBq1WxrGbwBkXg1VnLRlePGA5JdgiiN/7pKfDgjlECpjYdYwP0jZ/
 a2HyErKIg25pcaKzPdk8VLXYzROFYD4MJPISlyWI0DbWXlT7qIEK99lz9q8cGnkH+8ls
 HV9qkL+XkhiRxNX56y8T/4sZLVKNo57hFIcto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006294; x=1748611094;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sJy4U4I6wQRZ0M63y0NMh1KARq6RUgKpaGneju22z8Q=;
 b=ab07pQuHyBDq7aL5d5PUXAqcNwUdoFUErJXFAF/5j3Ytaw4qNAiVx4PesSNG/1h+3s
 QBX/aGR/wJBH+gBKIy/LhXPA48TcmzbgWMXLYpkZsZfhjrU7LN7yZnCkmF2s5di1iC9r
 ozJ+mHuKy5cFJII6V8k9czWCrlQZjNFtoU8HGzhkyyVCBwfl7jX4mCt8Ly3kkHEPirxH
 sKFYknfiFtsrsRusa5G80BCr1CURDweMFdIO5+4/nX0bXxU/gmicBHh+GYhLCiNZyt/r
 eH+P059jZrFw9cquzyvC62Ckexjpny2GfuKS/KWR80Kt2eHIz1WY6o2L/D7VSIsHz4gn
 ZBMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSFZ6vqA6Yp2cnMUAtyR6+ENGVDe0dvHQpnRQoAVwzpdt5b/TSPN2iY1UnxDupL+5ZYY1XjcM=@lists.denx.de
X-Gm-Message-State: AOJu0YwnkFZVuLP1mjfoRLrmihjpJxeXJ629kyv46FeG0bLBxgs4Glqc
 /nYnn144CP9OyiX/LEDCaYcttTNd1QzzLbqQOCHrcUTwSKbF/DrTrUVKBByFTBmi8MmEDPzI0tH
 8PqsiHqUZntg5A3bAfMkspI5D5Vq4xfl5woCXznT1dQcGj6UIt6Q0lHKa
X-Gm-Gg: ASbGncu7TbjCh4JQA9LqhcsQ/crF2YN++NzUKQmmAQiUvGIaEz5peD+7s/6JHX8Xg+D
 +L82ovPwWhP5KqFVBgE4yNvRpQR4lOTXEXUDctqQ7JSg/X6uU0CMl6sE+9IVudZJuZYnc1tUn0p
 OK2UV60yFnjEC/IpOr6xqxfhNxJMLVWjBg+N9hAJoH2NUC
X-Google-Smtp-Source: AGHT+IHHh5x3VZvhEyz4egk87/07rC9N/1Ssth3Jh2Qz4r6q0ed2AoSB0lBT1kWug0P61LtJB5w829B6fHpmi+l36vM=
X-Received: by 2002:a05:6402:4416:b0:601:a857:52b8 with SMTP id
 4fb4d7f45d1cf-6028d7114d1mr2881603a12.6.1748006293680; Fri, 23 May 2025
 06:18:13 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:12 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:12 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-31-sjg@chromium.org>
References: <20250504132356.2317305-31-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:12 -0500
X-Google-Sender-Auth: RJmq4hmEPYTy0A6RQG5u3mpan0s
X-Gm-Features: AX0GCFs4XtDlzGVUefSyKIU4Aa1E4vhpm8X9ERDXDTk-LqOeXaJtzh6PzNZQLZo
Message-ID: <CAFLszTgMY5oM8O0Ljbqf5GuNR31gG3WfTP1pMe-Ef9DTfEMeUg@mail.gmail.com>
Subject: Re: [PATCH v2 30/30] patman: Drop the old status code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Now that we have the new asyncio implementation, drop the unused
ThreadPoolExecutor code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 125 -----------------------------------------
 1 file changed, 125 deletions(-)

Applied to sjg/master, thanks!
