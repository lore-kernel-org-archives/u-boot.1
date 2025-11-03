Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4324CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 21:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177678144A;
	Mon,  3 Nov 2025 22:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SOyqN2Ic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7369C838CE; Mon,  3 Nov 2025 22:03:21 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C39B8004F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 22:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c281c649ccso3371608a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 13:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762203798; x=1762808598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6cJCkwI0QtYP2CNMfZtCbyHwiX3anYBiNlD4oh4unU=;
 b=SOyqN2IcvTXuJWoyh12CPbWsd4CDr9oqr8y9gri+nkpANl1IW8UCJtQRO3PsfGwoN4
 3J2MiF6C47DX2TiqIpeQXpQ9jyGKN/bhUx2kHBgUOgiuLxabnZ8CqVph35dSrxTfyEx0
 b0HaQrGgurS4in43KYu2tWmRGAOO49QFpWSKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203798; x=1762808598;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6cJCkwI0QtYP2CNMfZtCbyHwiX3anYBiNlD4oh4unU=;
 b=MHV8I+jV48gAUV5V7u0lc+yFWLBtFJKrT0DZlNaOUQFeC3zUyQx/gR02ymAANo01Ss
 4ZCp2QX6Ya8d6FfD8vpJaYRRmqvDjxoUhKBEebK5NitHY+0TeY/4BAXs0+3w5aFaZBUg
 kqKHMcniTZ1hyXnqS6qCJJrgrvow5woIygmuNc5sYESVoxflxJF300VvTiyxEVxIe6uS
 y/g+ywhLcThoxDOyql7+BHogRJIAZwFhZ5JQPd5xqHNgcUIkD3RGeocRkE1Ejj1tLYH3
 +aS96TnR05R+lQePNqPGpNOUqZzN076YPaTT3usmPQBsx3ePQi80XtBjUA8TQApFW4uH
 WssQ==
X-Gm-Message-State: AOJu0YyKNmlUkacWKpJ3Mc754g0L9gs/qoKPl0Loc4NkDJlMOWxQRXme
 x7s2xB7G3ehj3XmUQgPn5e8RgN18O+zZDXiHqNVpsuqizEPYk4Ml5k7pzAxAbOJNEgk=
X-Gm-Gg: ASbGncsGk4J/5v8OXQb8KPAEjjEj6A8HIBUCVd9MeevXr4SkXgr6qmgMxb9mS1deRum
 r1ooOZZhrWDu+og6TPh9hKw63q8hcXFWEjZdUdIRolu//jxIga9wg95KSVgYAQVWo4QJze3AUpg
 uj61cmgqOEhWh/ZBXz/kL5aKw/tyJA0e2WeWRzZOfAa92t2scHleIu1PHIzHTk6SOb18EfpVElU
 f4EVZrNISt3MqbpxrTpZlm2S0Rvqk4n+S5W1/2FwFpPMjsUGYXxgRP6tGzYw93WmKbJJgyQglgy
 thBJMtiaAiorCthC/VeQ1xjbiaphiPUS/LjMKBspKHwSppFQr7FO4M71lwbBsnwEKnqCQA13ieI
 MpRQjA8C+LaWEewMWnEBVOFIgTouKjn0qCpksv18B9wb0Ua5VMtm8lmqrzFXeq0Xi7qi3jA+IdM
 jBwq+rOrjVaU9WjJgPKmNeC7sVEaLEijxt/c8DysgxBRg8pCqt
X-Google-Smtp-Source: AGHT+IEDEsWyR6Y59IozNurCbpLkjldBM7F4XnE7oQ6TPH99fSan+WTBnpmI3oWDrR3GH67swy+9zw==
X-Received: by 2002:a05:6830:6d2c:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7c6966f1646mr7335593a34.2.1762203797750; 
 Mon, 03 Nov 2025 13:03:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c246f342sm455378a34.9.2025.11.03.13.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:03:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
References: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
Subject: Re: [PATCH v10 0/2] Remove usage of CMD_BOOTx from SPL code
Message-Id: <176220379674.3382007.8679959848971433829.b4-ty@konsulko.com>
Date: Mon, 03 Nov 2025 15:03:16 -0600
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

On Mon, 27 Oct 2025 19:47:01 +0530, Anshul Dalal wrote:

> We currently make use of CMD_BOOTI and CMD_BOOTZ in the SPL boot flow in
> falcon mode, this isn't correct since all CMD_* configs are only meant
> for U-Boot proper and not the SPL.
> 
> Therefore this patch set adds new LIB_BOOT[IMZ] configs that allow for
> more granular selection of their respective compilation targets.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] spl: remove usage of CMD_BOOTx from image parsing
      commit: 823e453987a6590af67e2226ad3e73fb399c205d
[2/2] configs: disable SPL_BOOTZ to preserve spl size
      commit: 1dde581e1affbbfad285a75b892cbebaa3f0bf19
-- 
Tom


