Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA8C7EE30
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 01:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F6880C83;
	Fri, 27 Jun 2025 03:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jD75ROYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221B882C65; Fri, 27 Jun 2025 03:10:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136E981F66
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 03:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-739f2508ffaso1224790a34.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750986623; x=1751591423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jn5N3/4v4++9Hw9RiAns1m+qlx3EJuzXKnFFoMeaffM=;
 b=jD75ROYOkC2No+0RtgfgZo4h4kyZzrWICyq0/K+MO0nj5PPOhz5Tvsqkg7DMHU4J2N
 IfrpncRG0WIASyDmDtWiPR8Jv2WUOO2cV10nt4A/q/OwuRekqf6e5wh4hM75LtBujyip
 t8QrSuMezVOjBGE7jfoBdsNkvXjTfRPnNfde0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750986623; x=1751591423;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jn5N3/4v4++9Hw9RiAns1m+qlx3EJuzXKnFFoMeaffM=;
 b=pLkPXACUW7TWeieI2JLxTOs4U1N9lJSceLrpXkmhmnX2A+CYoYNn6+eaLQwuousPp9
 4FNwMDN3yEL8/ul7ro4ruy9H3y5P7l92ioozRAmabTPsKTeAT1qSbLVi6uFcfmgrSnIk
 GCztFs3/WCIdPH0JyNkSAvaGwHPLNPp36h2/ZTEzJOaThw8qu5M4u8OHOxxfNAC4Cf/d
 b9XoHGHMzHSLBl03P16l0dPn1yzW/DFjm9UflkLgo9n6hz45sdjAJYCp+93W0nob2Hwo
 QJedt7InFAKwwBK8yR8ukcIvUY05lJgIQ/ZZc5J7q2ix6NsVctZVpiNxCRpGtZnvEZys
 xf1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURiZb8WL0XY9xR+rGYC6gbNjC1BWy7ksTP//JN45q8XglK/UGbO5qCyhmcAhm02bpUAH/63IQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzfEn8VDgCE4nGEnfUKOrbZ0VCq0A2/iS84us8TLsLlDREXGaPB
 3WXeG7Po7N6MkqWexQdJSuDthPzPKTtzH5M1ggbemhHzR2uyTap2XF46elz0+ZB2BhE=
X-Gm-Gg: ASbGncudS3n7JaRAts17NERwVUfzQUlD4q3YdxmTki9Q3sEITOkBGtMRgt/8Q8PE3+d
 gh8vCp3nxaawUuuWKBcIrNy8uEUQ8LBbGj5kIPbQs9Orp/hBhKfWu7tBm89xaKCVilSOG/JNfW3
 tu8c/qRQ5fdoVk1NCQvVkL+OnZkbMwg7X2HmXM9aRr1Iz+YeevuGJvWMV2X0nKORsyBTE2bi1ks
 clP7u/H8Couzid+1LYzlPgEyh1gTnRm+EYZ+Sm0D2FovvM0BPK7bsnOG8qzvIEdSIh59qp6ydro
 1nYDxfHvkPm3ICxGaq03Moh1XCB9JekHY2gq7uFcHOI2IvWtF7gMM950L2dFA6HlgjJ5qH15T0i
 YlayzpeVNZFPaludu+5MzFQ==
X-Google-Smtp-Source: AGHT+IFp03oJZFckuZL4S8arIA+otrniBGFVmOxnGAT3a80NDdE4Fp8wUmROyWdhEHi8pZ/P3Dx85g==
X-Received: by 2002:a05:6830:4995:b0:727:2f79:ce33 with SMTP id
 46e09a7af769-73afc63fe58mr870279a34.28.1750986622791; 
 Thu, 26 Jun 2025 18:10:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb122973sm185860a34.63.2025.06.26.18.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 18:10:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de
In-Reply-To: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
References: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 0/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by
 default
Message-Id: <175098662171.1928306.6951920675686110579.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 19:10:21 -0600
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

On Tue, 17 Jun 2025 08:19:43 +0200, Heinrich Schuchardt wrote:

> The sandbox is used for a lot of generic development, we should run the
> UEFI tests there, too.
> 
> The TPM emulation on the sandbox is incomplete. Disable the TCG test on
> sandbox.
> 
> v2:
> 	describe TCG test failure in more detail
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] test: disable TCG test on sandbox
      commit: 615620479e31a319b94c1cb6a57d8781ec6593ba
[2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
      commit: d7aee0c5ce199190c37f422a82d1cd6095c928eb
-- 
Tom


