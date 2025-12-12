Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A41D59D65
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 15:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5B78307F;
	Fri, 12 Dec 2025 16:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bsgYhszf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CD38334F; Fri, 12 Dec 2025 16:50:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93C283045
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 16:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so97197f8f.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765554600; x=1766159400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCBfmujevjiIdCf3SM+P2l2vusD0FvqTScWRKTADESE=;
 b=bsgYhszfzxSowIb26DFjz8YALTHOlUV1sxUpVrIwf189ZMabFAjVvWZEXKlpYSU275
 LyBLuY0Lk4xsuqvBwRjcabyNljLkdqLNbrwU3mD+dFVk1RV7Bdumlzrz2VmQXRv74eAX
 1Zvj/W6wfDoGBY9/Tj/vkz7pY10QADMJ3tabwGhGxwjdUuoI5x/K3XvO1MOMp3tYSC03
 r28aDuG8Hf6l6VhvZQ78UKD85EumqVYcGISR+b7dUJLvBUxvo70COP4hT3hliaBUUCYc
 yH8k+aXs1Q8NhuXIi23OSq8/f8HcYm/YaQvUXFYq5lv6y9coQ8d6u0LKgWT/Aqw1QEOl
 6S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765554600; x=1766159400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uCBfmujevjiIdCf3SM+P2l2vusD0FvqTScWRKTADESE=;
 b=wBuC+fQZPtDuqi6e3UBPl0njWsL3EahTVBLKFfNtM+lYEat3xaInUjk0bMoIzpJhKl
 3TL0gleMFDDEdmsSeNGyv2RR/7dJ/aGulBXb5o1WFFxFkWngutN+5BPQkt5q7UvLnFUG
 DUkB9uiGmmsrjzdllwZ2b5hUUXo6tT4ntTIYbyU1LImDXHBxyVcdFPzEm8p0GEhlFd3J
 bbbJfOo2c2InTrbrRJKO46Ud2GHrZ4ystjA05LrCJw0CrG1y22WCRKIKdl6jR9NKxCHA
 wpsUySJIThMpvyBoozDKHuJ+5MA5wt7QnLLXmAS+MJ5DptLWjD23+URWiRPc0i7VV3CR
 6DPA==
X-Gm-Message-State: AOJu0YyeHciEXt1frsG6f6wnMdSBvUT2mB+wDtvM6IORyYW7bJqOaxpc
 UWdnFHPiyZo8xEdhxBhnj9h5OTHik9QMpt1ob944CIor454l80gnz4D7zo1SZ2n+J9Y=
X-Gm-Gg: AY/fxX6p0/KGVdttT38ol/sB5/FNjSgYy9nc2GNZE8lETW6KyPSxYkx2DXutMBJ6dP7
 cCE4PInIPslXM/V0w77RELjD56C/viUdGudUGLjltL+ucvHBdg7h+X+3+ipJmCraa/ENrWasSLw
 1bQYpTb/Yo86Gf7sEOKrMvB5xihOYNkXCD0Af4aGh4WSUhbg5JdpD6hzL0gvh4c6EGennbZErlV
 lrRMHpjQUHugpBvG7cCgU3Q2Ah2lZK39K5gkI9Cjl8KMCvBRsfXqJW7IXwy9UrSQZ0S0dMR7npI
 7XzbrqDbLY9YiMhZm4qSTVAT0aP511AdDRgI7uVuylS1qisgFGDJE7zXRWC8pvnsNqo2q1PKJP0
 c9vdGH5skvSYC39hUee6MncRFzbzWtV0nWnjM1OpxAHjDmOdt1bR12sf1vXc7DJvcwcCin/JyBG
 urGqRny+UTQYzzeZGIUdf9kwRyuljLxyo=
X-Google-Smtp-Source: AGHT+IE58J+dC+qq30ONmII4NsDv9XISNp2N3XXi+GF9j7KbCk7AE/bUF9tTJ/rhSDKt+tvm+oNlpw==
X-Received: by 2002:a05:6000:22c1:b0:429:c7dc:e613 with SMTP id
 ffacd0b85a97d-42fb4901fbamr2923071f8f.41.1765554600196; 
 Fri, 12 Dec 2025 07:50:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a950sm14084391f8f.32.2025.12.12.07.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:49:59 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
Message-Id: <176555459951.1592278.10213529530179974819.b4-ty@linaro.org>
Date: Fri, 12 Dec 2025 16:49:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 26 Nov 2025 16:06:41 +0100, Michal Simek wrote:
> When the UFS controller is operating in slow (PWM) mode,
> the driver is disabled the timeout for UTP send commands.
> In high-speed mode, the timeout remains enabled to
> detect stalled or failed transfers. This change ensures reliable
> operation in slow mode, where command completion may take longer
> and timeouts are not required.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] ufs: Disable UTP command timeout in slow mode
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/868ec1f0cb77ecd6cd8ab1d40feb38e238c6f1d2

-- 
Neil

