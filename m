Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72390C3600C
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 02:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C558B80FDA;
	Tue,  1 Apr 2025 04:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BRQpXXyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147E981F59; Tue,  1 Apr 2025 04:16:44 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECC9817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 04:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so1425400fac.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743473800; x=1744078600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6kwZjQoApzqgSwhP/yWYArSA70s9UcuUIWnkerIneM=;
 b=BRQpXXyvXIYGrlSLVP5ySTQZHndSrE40Dh2TYcvxcoxzHwZHCAhVaSyk1Wd7pqPrSJ
 X1U+vlAnQiD6ayZE6wtqtHSceMOTxh8qfLCSQGCoZHeLjC0heHOTB2bs/ziWuyjyF9xz
 9MT6m9Jx4It3wCeqdbKNoufEzRPNH06K8+GZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743473800; x=1744078600;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6kwZjQoApzqgSwhP/yWYArSA70s9UcuUIWnkerIneM=;
 b=a7BEJIwqLf36LdwtpIJSjDNDtis86+0Mj8WcKfqDcn9OctCvpimFw8VFqxHTcq75kL
 uLyG3qYpAuhI9rICxm49gDwuzcH31UxB0DKJrczy8opQCFpYHXkMl5oqSfwO2elFs0VN
 7jdTdjyG02B4EJaIOZNG7EUwxvKf6JBgP6vVFSkdf5YSTKkXS95uXd14RddexLVitcGB
 d3DDh7mePufWeJrT5iHkSAXUV82TuKzbOUQIscsW7sa2mHPm6WqZ6Y2pDqqWdDpc0JFB
 cyj0mCEslepC82JQORkJp66Qm/k7H9Hq7KhWwAVDwkka/52a0ZcYY8jdqhRSWBzPRYLu
 uQtg==
X-Gm-Message-State: AOJu0Yyx56ZgETJWfmmcBG5rm+oqiQHrvB/cDs8dRxrHegZln+5B8J4N
 6XCYOLmWLNMtQWMNxkLqExEzzUtTJLN8zgVFqZ+oIcbsT3X2Ip425DZqMyZaYi8=
X-Gm-Gg: ASbGncsukhieCWNQOP8QOTPu0ZYkIaPFc4y9fkwu/0RFYUeR4TkzdD+nvKvOD8I0Hxl
 1Cu+44Pojakw6mpodAdrxkKUoKEuNiwOPgs3EdGqV1zZk4DAQy9aAvO+yim9G7/vsLA5Fcz3Uki
 E3XksJOoF750nXAxsL7d8ITbzaxj804OVmfmBkaRLr+CFDBhRwVsjw7Subhr0V3d2/Uo4h3IhuL
 rwgrskNczkgrWGv55j8bhW+mxcvRXGTPLlQEBFv0S4UtPugDz0vcNp060NUc9ujPkSU56+W3Otp
 yVN2/vywu6xjXaKXwviuuyLlom5rO/6ZW08lzQRg4BlbMbhQf2tU/m4BCyFpExygsh/SLyp+Gfb
 GRmbc61/oKccXMhA=
X-Google-Smtp-Source: AGHT+IF+nyvx2h4k/YgVR1RQl6oTqWndZSPCuB8nIVbVnxOjdpCunoVva9k8hN1DrCezb+NQT/LvlA==
X-Received: by 2002:a05:6871:58d:b0:29f:b09d:d93a with SMTP id
 586e51a60fabf-2cbcf504c75mr6592340fac.16.1743473800637; 
 Mon, 31 Mar 2025 19:16:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1704892a34.18.2025.03.31.19.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 19:16:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: jm@ti.com, afd@ti.com, a-shenai@ti.com, kamlesh@ti.com, 
 n-francis@ti.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, danishanwar@ti.com, srk@ti.com, s-vadapalli@ti.com
In-Reply-To: <20250314063113.1095793-1-h-salunke@ti.com>
References: <20250314063113.1095793-1-h-salunke@ti.com>
Subject: Re: [PATCH v3] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU
 boot
Message-Id: <174347379910.47384.18347840311328934673.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 20:16:39 -0600
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

On Fri, 14 Mar 2025 12:01:13 +0530, Hrushikesh Salunke wrote:

> Increase the size of malloc region allocated before relocation, as
> current size is insufficient for DFU boot causing it to overflow and
> corrupt the stack.
> 
> Fixed regulator configs are required by vtt_supply which is used by
> "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
> is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
> are missing from "am65x_evm_r5_usbdfu_defconfig". Fix that by updating
> "am65x_evm_r5_usbdfu_defconfig" to include "am65x_evm_r5_defconfig".
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
      commit: e2d9b3aa2ea664083bdebfd838cd83f42caa5c09
-- 
Tom


