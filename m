Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E504CC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 18:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058D880A45;
	Fri, 24 Jan 2025 19:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OeGgUiNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5B480ADB; Fri, 24 Jan 2025 19:02:03 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B5480A3E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 19:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dccccd429eso24333556d6.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737741716; x=1738346516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAeRTxXYobM3CTEwk1bCCecNg1CsG9zjr4xN/hAjgUc=;
 b=OeGgUiNentk0YXra2T/R9/YRTqskKGY8Kqo6x4fPOLf3F8cLkPyQd8XQd9vRAbZudl
 xUBLKuBwTzS6GhUjcj+RclTBeRWQRpvs6hzHoMNwoZUn1UniKKYNaz1WjGNHtelRhZU9
 aS6q7pckFwNaL38Bh6TkGfrJarfcga8+8OK4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741716; x=1738346516;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAeRTxXYobM3CTEwk1bCCecNg1CsG9zjr4xN/hAjgUc=;
 b=ZECTsItrlLsSnMc1RvpM5lqwAKAE3hgg4D2n2KJE0dnFA9Yj4AnA1S5s0KZ5TcJdx9
 MsWhLozyGEvZ8bbCZMG2zbx7IpsGrld8aQ4Re/1KEa8YbSMe+F9XWSc/OaHy/24Gky+l
 NKbLpAGZFPCks1zQaMZYffXFhhRiZv/+MblGE4EFKgeDpi7PyGFs74Y1uPvQApC3ztpS
 bsGaVFydEK9Zr4fTQJ59fNTXa2M92tnkTUpudx3HxXCfWuXPknrEou8apEVuu27xvudA
 Ih/81kp8UozQmhoiwwK1JT3y/aKkqlN0AhTVPE6jlM3EgKUulJZkAi6EPMU4/oL4FgjA
 YG/Q==
X-Gm-Message-State: AOJu0YzZFemYgSHceLL77vZevIGxIICAlhokoeZP1No1CJukjeTCICSh
 W2mGC2vUmqiQaJKQj5PfBsigAqplEXl9txMzXsm3PSgn6VZpN/pLON74zFeh8D0=
X-Gm-Gg: ASbGncvYEMotu0yab6KWQke38rIS5j75J7ZPBlU/vUHAjboFecbwPo7n+T9wRgJdQsR
 RUQ1x1N3E2zFowhSApGcS8CilRZwmobGZgvk55yCGKWEActFFQ19gwMBHMB3DtdKq2mENfy0ekf
 uZ+q7DYGXEhtt8WmvsF1Z4E2Nhw0+ar2sg8xZ0eh8LVL+fXo4Chit0TdcZtp3dVGoPNlgt5ykw9
 i6MUJwsVeN1AT0b85pARM5m6SaZBTM7jesC6yZnqmUc2H3qyrEYl74VFnk7pnrINirTMyfxryQ+
 w+i/uaJ00xQLfA==
X-Google-Smtp-Source: AGHT+IFgzs1O5cVoPaowRrDKqvKhe2YWxNd+dTA2bY6Jqib6SQ8rzoD83qy1/LKmFl1JFELENp5aEw==
X-Received: by 2002:ad4:4ee8:0:b0:6df:97ea:95dd with SMTP id
 6a1803df08f44-6e1b21b8f4bmr463721676d6.17.1737741716236; 
 Fri, 24 Jan 2025 10:01:56 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e208f826a9sm7574616d6.100.2025.01.24.10.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 10:01:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Aaron Kling <webgeek1234@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
In-Reply-To: <87jzaks6db.fsf@baylibre.com>
References: <87jzaks6db.fsf@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250124
Message-Id: <173774171484.3114666.1213297392160659137.b4-ty@konsulko.com>
Date: Fri, 24 Jan 2025 12:01:54 -0600
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

On Fri, 24 Jan 2025 14:12:32 +0100, Mattijs Korpershoek wrote:

> Please find some fixes for master:
> 
> Android:
> - Fix kcmdline null pointer dereference (reported by coverity and
>   multiple users)
> - Move Igor to reviewers instead of maintainers for avb/ab
> - Fix booting Android with AVB built-in, but disabled via
>   fastboot flash --disable-verity vbmeta vbmeta.img
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


