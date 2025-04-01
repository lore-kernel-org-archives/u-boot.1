Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D41C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 02:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A0481F44;
	Tue,  1 Apr 2025 04:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k/o0d2OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4E081F44; Tue,  1 Apr 2025 04:16:42 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CCC80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 04:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c1818c394so3002376a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743473799; x=1744078599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+3tqpOpC7K7xNuNwiv6iOd4GBp7fwCiOXUig38lNKo=;
 b=k/o0d2OLjynFDJAwuJG9DjekQdvAmu3+F9dkZtqahUrOA9NQqZsiuXNO2M7K1mA1+D
 lbu/MkuPDoHz/8ZUUZik/QAM6MyYI1h2HmYa21wwdgqQJYl8d9A7/UQfHVT/zfb3UMfc
 4q0ffPsUUeMCHrj2q/y5mMJfS4NB2ymQozMCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743473799; x=1744078599;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+3tqpOpC7K7xNuNwiv6iOd4GBp7fwCiOXUig38lNKo=;
 b=POjtZN41tqOXgOs6eN9wnU9iFHKdWw7g7lbnuhTjXfMnqTC7YwLw3U3GGgUr3/bayz
 SnNzeIN5AOL8iiFV+3fmVYtYyryxbZM8MYl8iHOEbdrYcb1fzZ39i4MWr85fOEzumGxl
 9/jk5xj6aKZhRFvYqyXglIwZLsdp8tfonnF+SN9WUstxObKLB65UsVPaiKYNpJ74jCfc
 GSB5AgGgFtjUGFHRuVhOE7zy6BZkKc4pGiZI9beKUmddYWVKqziJd+s/RQsZIPtaa+48
 BDm206GXVBy/lbnv/NZSP7hY4TJjkLEXVp2CM0Bk7Cr6skWsFOVhKA2QZ97GAwQbCiIk
 cftQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKfJIQaFMWzI+FVR3mmDCfcqNajuXXlCmLy4XJSOBi4r18Yj8BCzYeNosrcS+asAIFCFeZmdo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb2KHZYtIlfJ/3WCU3ZFkhF/nrMTw5K1RULDocmQBLa6d5FT1e
 9h8ZpALCswT3kydvxEaVwnOgKiwYKS5McfttbG8CcUJIJiQN14ihZJhYeWIM0s4=
X-Gm-Gg: ASbGncuINSikwy7ZJN6GN+tqIRXMtsh7a59eEQPz/kjZfmV0YHrP8RBmhgaHR8Y1mRG
 0OlC2HrSSw26iVbJs7HGf52isueZqUr2opU9YabawoFwcQUXg3WBHGLWwNh8hGBfywn59x52S9P
 iKthghBIsA9AnT/f9hxqXx2IjvXwTQFPeiepxt/tBD35OilXPdExxNXBghyS0twMESVIKAO1DAw
 ZqubE7IT0znjnm+yV2iLCzrXkx5AV+X/+j+xzA8uWrlG2SmZWOfh+yzk4O+zG+IfWoMkV+e6eVk
 15iTgskqnVdZLfmtX5GQ6y+oEHRDmT3dzkDqnPbHiYRlLiP5OuXigvI6Aj/mV/aRW5fK03f9x+4
 xrKnr
X-Google-Smtp-Source: AGHT+IGCS9rOulTjmDg/K+fc5cUOI7r0Sox+juXso0ojQM5yJGIxeMgFhsYM0c6qbh2ceCXHz4/e6w==
X-Received: by 2002:a05:6830:f87:b0:72b:8ec6:e533 with SMTP id
 46e09a7af769-72c63793972mr6706118a34.7.1743473798967; 
 Mon, 31 Mar 2025 19:16:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1704892a34.18.2025.03.31.19.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 19:16:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: n-francis@ti.com, afd@ti.com, nm@ti.com, a-limaye@ti.com
In-Reply-To: <20250314110411.2781732-1-u-kumar1@ti.com>
References: <20250314110411.2781732-1-u-kumar1@ti.com>
Subject: Re: [PATCH 0/2] Add WDT support for J7200 SOC
Message-Id: <174347379788.47384.10318161994846491636.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 20:16:37 -0600
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

On Fri, 14 Mar 2025 16:34:09 +0530, Udit Kumar wrote:

> This enables the ESMs and the associated PMIC.
> Programming these bits is a requirement to make the watchdog actually reset the board.
> 
> After DT sync nodes bucka1 and main_esm has bootph property added in
> pmic nodes.
> 
> RFC was sent
> https://lore.kernel.org/all/20241126063543.2678052-1-u-kumar1@ti.com/
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: dts: k3-j7200: Add ESM PMIC support for tps659413
      commit: 940f2a04f335e17919112402f748d06f2303ad09
[2/2] configs: j7200_evm_r5: Add ESM related configs for J7200
      commit: dbe3ea4274b005e05cf1ddaf1d6406e0e452720f
-- 
Tom


