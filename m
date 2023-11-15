Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C5C47074
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 08:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4D48615A;
	Wed, 15 Nov 2023 09:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="zMrWInyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B1485E44; Wed, 15 Nov 2023 09:26:57 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DE98615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 09:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-509c61e0cf4so7940982e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700036813; x=1700641613;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJyJnjuJF104phv8i6FvNGZukoXK37gheXw9j1ci4W4=;
 b=zMrWInyBLyfW2Olga4ooRtnIai8Y4EoUQ4IXDq5bgRT9FxTLWtdHiopY/Foq2InB6L
 7OWx5bdTclQDKlrIBUQAwZUMeoe3AqzdVHIY2cjN0MxNDlnHk4QQjR+bayNkjM8ND8m3
 cQFJnoNXYTh3n5poPCIeYQAMpvk6J6JSsCg4AeuU048+pDMSCcMFBZTqJYOARDpkcR1y
 C6MTUPQeK+b+1jO0rLoKaAVmzilZpA4LHmkOOWeIdqFq+IOjqyUcLkgrfzZ10bLpYm0W
 rG0IotJwd37sH6WIPpyHM5HP4IvrtZWoOMfWU7oHoQQP2MJnlokKKura/5KB+je73J6j
 ukPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700036813; x=1700641613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJyJnjuJF104phv8i6FvNGZukoXK37gheXw9j1ci4W4=;
 b=lkd6CXV3eavC9lJpyNKWCZg9QFGCkPyo7ZreCAjobgzVDhCN7IsWnkP0odr9hQQ66a
 tzA306kO4dm01fsQU/h/kXEGjZULEfsScC284Qxf9iy48PL5r6kt6iZc8rSlbndX2440
 Gwfrkb/uPw1B1Vn8jJltkYFn8HyjeFbVMOjTAcuPathC8Sgpam/Kh/+Tp/2WQ7zxMKui
 smweZFLIA96P+pVWlfLgggqIVW7QzEdIZ/1AlfdQjmeBV/CR25iA9192oTTrAOLpCgiO
 K6CiqG7NscGfjSr1DD5QTBxDt5IbzycrqBX7LEqU7GE+lC3fVG0SQ5K1thoXIFtpms9n
 MGXQ==
X-Gm-Message-State: AOJu0YyvIafLLCCXBfWMfmlaSI/6HF5RJLV4Ak2R6L5T/baoSr6COj1/
 AR0qXSfWJRumR4fVwrUN6VZq7D+JnvH6c54vjdtVww==
X-Google-Smtp-Source: AGHT+IGn0ReKxcEoUeTJWktKwoYzNTknyqHekxdXXAWq1xDA7q1WbK8JvfLhPwnj/4wYadfnvu7Apw==
X-Received: by 2002:a19:f811:0:b0:507:c7ae:32cc with SMTP id
 a17-20020a19f811000000b00507c7ae32ccmr8203955lff.41.1700036813559; 
 Wed, 15 Nov 2023 00:26:53 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51]) by smtp.gmail.com with ESMTPSA id
 m13-20020a0565120a8d00b005030c533843sm1557787lfu.154.2023.11.15.00.26.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 00:26:52 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-509c61e0cf4so7940945e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:26:52 -0800 (PST)
X-Received: by 2002:a05:6512:b9a:b0:509:8da4:93da with SMTP id
 b26-20020a0565120b9a00b005098da493damr11341926lfv.18.1700036812366; Wed, 15
 Nov 2023 00:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
 <CABEcMwWjHxNTE5wVkgaQXRBwt2WP-uE3qgRpNrqiXFCjHD2iZA@mail.gmail.com>
 <77937c9c-4f00-4721-adb1-5bc8b570c6eb@denx.de>
In-Reply-To: <77937c9c-4f00-4721-adb1-5bc8b570c6eb@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 08:26:41 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1cOgJQU=LtSc_zx0UY_Z40VzOSWNgXYfS_PAFuxKhpsQ@mail.gmail.com>
Message-ID: <CAHc5_t1cOgJQU=LtSc_zx0UY_Z40VzOSWNgXYfS_PAFuxKhpsQ@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, trini@konsulko.com, 
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
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

Hi Marek,

> What is the point of this growing CC list ?

Apologies, this is my first time with email based patch management.
I was reading articles on best practices and first one mentioned to cc
people with recent commits,
second one mentioned to use get_maintainer script to cc people and
hence multiple emails.

Regards,
Shantur
