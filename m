Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD6E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5440801DE;
	Mon,  6 Jan 2025 15:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GXzX+gBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3F5801E8; Mon,  6 Jan 2025 15:32:07 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407CC801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so76436266b.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173923; x=1736778723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SM1rxqk3KKsHDVnocPO/9lGDDxUZQ8WB8Y1JQ/SnbWM=;
 b=GXzX+gBPU2lY5I4YXueJv0cmq34CE3i8kKAfV6PQAq8yv+6icfvoIplkP1CX9Kahf3
 COH8lK3huIIy5ljt7cql4eHXNDrt5axZ7vLMaUnqt0BZLSF7rekhQpm6cCFcfjhD71Y2
 P1heQOvKCBXASYqMGxwJn7QZ3UF2eXD4UFMOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173923; x=1736778723;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SM1rxqk3KKsHDVnocPO/9lGDDxUZQ8WB8Y1JQ/SnbWM=;
 b=NHvUNTDdIbLnYgKbntF/upcRAd9VkzqfZU91Ukjt/Wcowr98j3GPPr6SIbkaf0FMPe
 Rre/iseV8XZwonH+AoVsnIdhscrMM9JrKsrX/z+dMtYKwEcTt2rF+4CCt6d2sBKs28Fr
 SPWcOCSfSTFoCZuytFtN/Om7z6dpO32y+hSGjpK1lp1ZT5w18t8S0A9rEnm3S61RDAsV
 dTfOR0Fs7L+L/KMeNvp7xyrOh2dZW9I5Uyhw1B0X29DBadpzUQXyh0ZVGM9XyTiGqO/F
 X4cD7pKiMPt9QS71qLSFLXEK2495uIx7jGzDZ/deIo+uAj2wiKT8jg7KjpZ62wIkC35T
 xJuw==
X-Gm-Message-State: AOJu0YzscNpTb2R1qthkpeq3nTx9X8pe8DmJbOpyonbxQX+Xu9kpFtTa
 DVWQin11UDtkhhJLPArIJv3eYoR/fcAhJzpUtTPqQ0AHFT2UZkpmmisQtayx38tk2S/aPiKRCgA
 E686J40GvufRj2BwTeVH6sDADzl7hDP4Xhzb3SifTqhAv324=
X-Gm-Gg: ASbGnct/p7yp+Dmwc8qG0aRHsNv4/Itxb7WQU6ecKqD7Ycrw8qskHM6td/O7VHKaUm+
 L12ew/2Ln/1C3yoomRuw4K+QtBhojghCefUmX9jg=
X-Google-Smtp-Source: AGHT+IGLAAX1AaoLU/8S/VAhqFdGG/lSVLoB3gKD80B75ZPl1+M88DxseHkb05drNgCHm0wu4S0U80cU/mcFAXdNDMA=
X-Received: by 2002:a17:907:6d26:b0:aa6:256a:40a7 with SMTP id
 a640c23a62f3a-aac2ad81a59mr4508993566b.22.1736173923219; Mon, 06 Jan 2025
 06:32:03 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 07:31:52 -0700
Message-ID: <CAFLszThED3yXP0SoSni=9zfhgovVh6k-bik6fDOS0ef=X=RZ+Q@mail.gmail.com>
Subject: Integrated EFI tests better?
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

I notice that the EFI 'self tests' use their own runner. Would it be
possible for them to use the main test-runner in test-main.c ?

Then they would show up separately in CI, rather than being all lumped
together into one.

Regards,
Simon
