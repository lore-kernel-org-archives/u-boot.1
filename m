Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D82CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6047E831C2;
	Tue,  9 Sep 2025 20:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LAtlHf6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3E883192; Tue,  9 Sep 2025 20:31:38 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BCBD83192
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-412a2fe2f31so3924315ab.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442695; x=1758047495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzvg7AfXW7W5gFGCQFSaJmL03H1lrA0dwbaHr3hfKjg=;
 b=LAtlHf6uyhcESgXt7vrEUXc8Fs2XJ3wfxP97zblpXClqf96jYAiA86Am1wrfr9ZTk/
 JhhThcPFqx2uDvowNNHKVjSbsrnPq9S0UEmuYYzdur3rf9KERxqR2SPF71SXurK3a4fk
 IPfk1EgQgnzO077mN5u7RBKpUQfTu7/gbvOYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442695; x=1758047495;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzvg7AfXW7W5gFGCQFSaJmL03H1lrA0dwbaHr3hfKjg=;
 b=wMdIywSTQfbRXweCOB+9VGl7O3i7sqvbdlDX2RoH6jQ6j1him7f2aNl7zTUgAAr1VT
 suGZE+CB2Oypshyq48rd3d2qWrSaPu9VY7xU65DpG3cYKv5xIJZor5IqJNwGuOFVJUu6
 cAD5ZoOxN3REMPljMkeEB2Fi2sOM+/AbO1Me5y1kvaz6gN6V/WPuxFYbF87AnDY8gYRl
 OkcNJtgvhVETPt3GK0s6P/cmgEE1/DrZ+WQNk7FZRAOtX1l0Gsq/CoWxsfxIO0smvv9h
 XyARW/KXsOgTVLeo0vkYLwNawirWa97y52NPPUkbEK/McferFdD0qxwXZieTkKimU2+K
 K+Og==
X-Gm-Message-State: AOJu0Yw0jAyh7YdAufMNAtlRbtDx/p9C0sdItRJBiRCJzQ1tK3EutTJc
 WXf0zn1yukRkp9Hf1AFs7r9Act7dshiXC3Y5TgNfLlvwlupLrzzj3Cz6HaamSVD6t5RE+TNiPGB
 VV7R1WqM=
X-Gm-Gg: ASbGncvd07JGak+Jy7la9l7kODw7Jerh6g/YAmVpVetsOQh6DHB0LFsuD9SuuDXKxLz
 IFQQhfDKPkUzUbsPphJ9n/JaVdeRdKFN4AzAMP0ltsv3uzgz2J4asBOnLi3rBzg4s6/f0b+/zDo
 Ek3LNuUMwN79F3o1A3D1L0FOKLXogWwuQxe+jyQ5eXnjXrYy5D64EJYLjTY66kAi9EQa3uib+q5
 WbPIHPxa5LOpZRLKc+lsCfo+k2AaoEFnxxw+VTjcvuzpwBEcEOmzQqpfRS17ZfKebXHN2/unjtv
 zzIbGUF60zUQGypUdLU+J9zt7X39QKtTFHjMj/IDKUCzgxekzQfLoGmi9wsobYERjdgO7MUn/wT
 cb0t/F3c59xA1NKct3MkNtbS5XDUATBLem9SxARf2b+d4DYhfnwmUN8k=
X-Google-Smtp-Source: AGHT+IHbJDbQJa7XI33FVhjOQUvGkGs0RJT0i8Pn4aVU6LYr83CfolAYb/UnB1lShRTKC4VMXI2g7g==
X-Received: by 2002:a05:6e02:1a2f:b0:3f0:7ad2:2bf5 with SMTP id
 e9e14a558f8ab-3fd7fc21aaemr173221875ab.12.1757442695023; 
 Tue, 09 Sep 2025 11:31:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ben Hoelker <ben.hoelker@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Bruce Adams <bruce.adams@alliedtelesis.co.nz>, 
 Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20250818102959.1.I51da487efb143e03f6609e584f452e5aae1c9e9a@changeid>
References: <20250818102959.1.I51da487efb143e03f6609e584f452e5aae1c9e9a@changeid>
Subject: Re: [PATCH] drivers: rtc: max313xx: Add delay after setting date
Message-Id: <175744269381.1809471.2826590006152177900.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:33 -0600
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

On Mon, 18 Aug 2025 10:30:00 +1200, Ben Hoelker wrote:

> The MAX31331 was not correctly updating the seconds when
> setting the time and would return the seconds previously set.
> 
> Like the MAX31343, a delay needs to be added after setting the
> time. Wait one second after writing so that the date command shows the
> correct time.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] drivers: rtc: max313xx: Add delay after setting date
      commit: e0f9a4fb576c3f4233393194161e48941823cbc3
-- 
Tom


