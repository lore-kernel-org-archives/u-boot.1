Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E3CC83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A85835CB;
	Thu, 10 Jul 2025 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="moBUdbX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CE5835C3; Thu, 10 Jul 2025 01:19:01 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121F8835C3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73a5c41a71aso206504a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103138; x=1752707938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zXIynjABO23PBUFbuNICnxiKJV+CIIt9MfbkLyebhKY=;
 b=moBUdbX0h6zt6ZKHiNWqjMH/V9735DQDFDZs2JLLqCfP5nO+DcJHIJey46v6J77rp5
 /BPa3mmFrn0QATf+wPm3S5AlsvNHJtNBKzwqbkis6HKLzqErPZGFB7t70owncRgw8QJf
 lE+vS87vzf2bjAAa0uEgn0n1KqS5q8Ya0SeKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103138; x=1752707938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXIynjABO23PBUFbuNICnxiKJV+CIIt9MfbkLyebhKY=;
 b=rKAuf0mP8GDA+WOdjnKDUsdc53a8lhCB3IrJ/axU4v9sn5NM6jc220d2wkoEHAX1ew
 50fsY0FMJZttkv5IBuiKIXUVMpnt7IedwHHdYr68F1IihSvmvMEf4ZJFHu8r+tR9xOGy
 Pfwnzdqlmd/M+uFs6o5XdZc3EJUZKtyOH4I1jLgUmpykLaydqMTJ1g5C/3eEmyorwtLL
 lxRnQHzq+luhHtQ5kE9HA+rWSO5A1pA5Lqolbi5kZ5SKHP2MUPS2dMBZpcvlxydNkyZ4
 tSKGs7VBjRaWl+IhVcYToAJcU9bSZ8jj27KX4RVERebc++kL0tjofHh/zRRg7PcBjeMI
 vEkA==
X-Gm-Message-State: AOJu0YzSFOFtjul6If/PZIxCSmYFXJwFbdsJI5bEbdX7hIiUpH64Epf6
 iPJvYsmD3DIcGMZfLio55e3eAoAC1uptV7rReURKjDsAzxYmNuL6uWhUb2XGXYHMpkj/ZJakK5V
 eMWtC4QM=
X-Gm-Gg: ASbGncsrlJd3JBDjrEIeXvLwyRZDnlPPPEt0wAsQWcSi9jSoTeL9uyEF5wf+XxSnmQy
 ISvEp9rxDA0denqT8mcv7h0AKKX2/15G3fOppvf7zdODR5o/Re0xX9gvNQAJO61H3UBGL/QPbwR
 /QM5lGe6QwKy+eqiEGN/Uk71Fe64nurv07MpEUeAAF2/eQquLhykx06XgV70eZwmOVK/XSbzKYn
 MNsqCqMVS1ziQdMKydB/g0xg+wMROlfhvatJt5QR9WzhUIoI8+lv450xSnFZ/gTl2Lf8vG8vXwy
 b1vo7E1G8P3SdAAB6xeOUfI2m1SSRblHxgXUiL0edmbh3c16p7JQsdMzJlVU/PWsVtqRjvzmFGQ
 MXa6LAxskDizkS/uubiGrqNJAU2622w==
X-Google-Smtp-Source: AGHT+IFmMVQVAVDdmyGnn8f/psfW6EP1fvQYrNNzToRblldbFuPs3TBS0s9DmBhglYlURd689eINWw==
X-Received: by 2002:a05:6830:4c98:b0:73c:aceb:fcc4 with SMTP id
 46e09a7af769-73ce60a5e8emr1926786a34.1.1752103137742; 
 Wed, 09 Jul 2025 16:18:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:18:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250701184232.3191405-1-trini@konsulko.com>
References: <20250701184232.3191405-1-trini@konsulko.com>
Subject: Re: [PATCH] dma: Remove lpc32x_dma driver
Message-Id: <175210313698.1870480.3133443602217712676.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:18:56 -0600
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

On Tue, 01 Jul 2025 12:42:32 -0600, Tom Rini wrote:

> This driver has no users after we removed the last supported platform in
> 2024.
> 
> 

Applied to u-boot/master, thanks!

[1/1] dma: Remove lpc32x_dma driver
      commit: da31f4a07ce5fc0e167bd7ce6a17a7a70725ca54
-- 
Tom


