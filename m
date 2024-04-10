Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E1ECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1311A881C4;
	Wed, 10 Apr 2024 19:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LOGsR+Q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDD8881B9; Wed, 10 Apr 2024 19:43:22 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F9588191
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78d777d7d1fso76098685a.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712770999; x=1713375799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iyU56o9RrDdvak7ql1B4RTxc2LmD0EKNnZXFjIVvLgc=;
 b=LOGsR+Q0cHeSZrIh51fv5b5efIQHteJUswM6dRYlzaNq9SbxPs3zf0OK1YRP8c66xR
 ZAKlD9srhlbm1hm29d6PpdK1cbhuuMZQ/Z9zaYFfeJjGMsbM3sQQbAnZsb90lhVwTIeX
 UpnWMZoGVHmpxQ/9K8CakNhP6gzw8KebKAH9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712770999; x=1713375799;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyU56o9RrDdvak7ql1B4RTxc2LmD0EKNnZXFjIVvLgc=;
 b=Hi+qL34cv+r7A1Ihtfd7cIHACwefr03T+FBKYoGdACwow/m5dAh6vOensgxjmoLWmG
 YAau4se091/yLEFBfNvU2o8bsjih3eVobL6ESUoZzUETsoedLMJQPmuNi0uP5Edc4nMK
 IK0i602ZfayG1o9LNFM2ACEwsLfsf0wRKqn9PGiZ7Ah9OFVK+IzAyZ0EXQaw7swS6bAa
 iU//QHwbApsj/avmAsn3OB6pk3d/sMsZeB8ge7TSpEvnWy3NBj70Otk+01jSPYd+fWGi
 RjCQ/4Y5B5ihxCZRBHY0cLBDvqbFDbFBVNkbvQEovwb9JBxhn6AmndRtmr5bA/PfT7YG
 A7TA==
X-Gm-Message-State: AOJu0YxjTuUrVj5eK4/997B06WWrmCvUOc6fpZV8YNx23HSy3j3rdHWK
 r2Zuzen4FcwH2yw9dYaq5dBl1Ndef1058sBT91QXOkGnV1PsvZSjk3uAaaLjYspn2NXjvAFhVqR
 90xFDGQ==
X-Google-Smtp-Source: AGHT+IHQEuG9P+zLKiOv7KBe0nuCVBj02W+d8SfA+611MFngXE7KZL3TRrXyCZRlan0mEpmQIcbe/Q==
X-Received: by 2002:a05:620a:137a:b0:78d:455d:db17 with SMTP id
 d26-20020a05620a137a00b0078d455ddb17mr3335413qkl.4.1712770999120; 
 Wed, 10 Apr 2024 10:43:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240319165131.1651802-1-trini@konsulko.com>
References: <20240319165131.1651802-1-trini@konsulko.com>
Subject: Re: [PATCH] scripts/Makefile.spl: Use 'sort' in SHRUNK_ARCH_DTB rule
Message-Id: <171277099833.98421.17898494166119349881.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:18 -0600
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

On Tue, 19 Mar 2024 12:51:31 -0400, Tom Rini wrote:

> With configs such as "am64x_evm_a53" or "imx8mp_venice" which list
> multiple device trees to build we get a warning such as:
> scripts/Makefile.spl:578: target 'spl/dts/freescale/' given more than once in the same rule
> 
> If we sort this list first the warning goes away.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


