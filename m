Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E428FC41513
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6548855F;
	Thu, 20 Jun 2024 16:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X2yZY5YB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85362884DC; Thu, 20 Jun 2024 16:35:33 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6672788535
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25cb994dbfeso412601fac.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718894130; x=1719498930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0p+AASaCOYNDlpgRD7Vd0jYYGMQD5Klhf8pimkZzLWg=;
 b=X2yZY5YB/N05ZoGyr7J1qYH4AlFFmAWpGVAXgwudf7on4H42HwKNPREcuBuHpCxuXy
 6IlMS4FI0ZTphaMlDSC5Q3fmmZAYKBP6XKhBzBDgtlxpiFs3NDoImjDGwN/pzEErRtmx
 zJsv1VSlqMSPMEUGZhGOARovgXNYBAjLohH7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894130; x=1719498930;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0p+AASaCOYNDlpgRD7Vd0jYYGMQD5Klhf8pimkZzLWg=;
 b=hwKsr3sObaBzYTh8Ywu14nvS26kHrdXySOifqnoJr3q8DW5fXinoQVcBYdcpwCjXeg
 m5js55zVhonoK+kdgodhaUQdqp+SM2N0weKdg2emO1ffB9+uk8UiSOo5CETPsI3ac/5k
 +rhj7G2GTtf5TtkO6ILFc5igvZC7Od1OhtXa5UmN2JnmukiFV7OLaws4GbgsOHySFSOa
 49EwcRb66Dg7WVNAfFdD8TQ8wLdEy6mmh/Hx6VChOErOtZ0ArC8iR5cZmtMvH1XvsXJb
 nt0qGzD9UQp4heTrdMe2pUB3hVg2v9u/Bom2Go8VCodgnKFCS20r2t5WOWmgh7ovBMe8
 vgrA==
X-Gm-Message-State: AOJu0YyYMLvrGVy/d47hSvE2L4L+UycLTf7oyHDOnqAcB9bCp/JaVo+b
 1rgNtwqiPF+tHTgqa508y1pWkQNEU8riIX16eUk/LlUhaZFk2S96AkKX3yT8qkMw+5XBj83/Gyt
 cjRk=
X-Google-Smtp-Source: AGHT+IHaWbGfUW6W8nIqVNu0aAVwO1T7KdokiiL3u8WYXKatCKxL4/5/5SES8+SeH0neqxcX1BaE1Q==
X-Received: by 2002:a05:6871:10b:b0:259:89fc:db65 with SMTP id
 586e51a60fabf-25c94d70a63mr5658924fac.50.1718894130152; 
 Thu, 20 Jun 2024 07:35:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cc7165817sm176573fac.14.2024.06.20.07.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:35:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, harsimransingh.tungal@arm.com
Cc: rui.silva@linaro.org
In-Reply-To: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
References: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
Subject: Re: [PATCH] arm: dts: corstone1000: enable secondary cores for FVP
Message-Id: <171889412934.3544072.14789652742091813667.b4-ty@konsulko.com>
Date: Thu, 20 Jun 2024 08:35:29 -0600
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

On Wed, 12 Jun 2024 11:04:21 +0100, harsimransingh.tungal@arm.com wrote:

> Add the secondary cores nodes in the dts file
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


