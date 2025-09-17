Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3374CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21B78362C;
	Wed, 17 Sep 2025 15:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vy4ziCe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09EE3835CB; Wed, 17 Sep 2025 15:47:44 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE831833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-74526ca79beso5623407a34.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758116860; x=1758721660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyTSmO1vRDK0Hnly1o29q1qziRUl7kIIm12I6gwit1o=;
 b=Vy4ziCe3DLxboQd1p9nJr7Bw0wRpZ54s++Xqp3W7YElBgjGNJmev11hkAYalOJF2kR
 yFYhRkLGipVY5jln4bHnRBksWvlJw0H9NIeEH/aSNso3Cr5wgbG+6pAzCafglyPm+Ss/
 B6JUBAscfF33JLeQpVEZLTuwbJT0ZjZLSQCNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116860; x=1758721660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyTSmO1vRDK0Hnly1o29q1qziRUl7kIIm12I6gwit1o=;
 b=J1MLAdo2UypCY4lpHJGfN6z33LL5htmQ34Revi+2yWjJfiwaCls1geu+OEuUkuBOqv
 YWHxcr1+Vuscng4YBJqYvjbYx1a72ek+40NlKMaYjaxUWOOY9Ds3D51Y98FZl3iymf7n
 xlCMqACULXSNFYynsW50d1NfiiX+O7kCayhBImLjCbFcVydgt3Tzrz37bAq/rwjN60/o
 H9Cu7g8eofLnI00wd8Nj+JsWzhVNR29l/Bmssm8403INytEReosGZaytd3MNlFm+wBn4
 lE7hvWT55cDOyf1Da7j92dGW7amRdg3RHSixwXv2ttjf4BfS4OtjnebldAnHpTAWLXgd
 ZZlA==
X-Gm-Message-State: AOJu0Yzp+hWhQbTco44QPpD0l5SAzp57ieeSaPnAzmc/uConFmkUU2jC
 f+SqZsj/K9TNV75R5z+zNcEL+or/0gSXsDp5B2HCvvKVlLwFRc4qbb6pwNNYzZGgU8Q=
X-Gm-Gg: ASbGnctS9qaLpOhXUQOC12+YjZcGk67H6hMy0yK5xxurdQowe790bVzcGzTQzcvqLhq
 z8vHIhTNAlETqczDrGAYWFTsXNG7jVT5awx3dSwsB2UEDCUsvSssmJprX90Z5eQHd+U+5BSlEPM
 IzG/OLAq7XG/nB1qL3YO5JluC8oLN+Hzclyc2Y33OfcjbCnE0UBfLm/vIEIFSw0IOCcDeWYsZey
 ezgTMbTlWMBlY83lvgnNZc5SQos5cEZPDLRqVSbHriTm0Qflvc/ZQyC6wt4UrRMkW32tn38xP9/
 TDJigoGHupG9sVZsqR4PykXZVa72Yjza440W13WaRI471TQdsvDg6eX85KiWN5FbWs86+RQdGEf
 Y2ZQLZ2iXCmKlqc4uT68v4RjWcYFjJrSE22ukMVR21kvxafH7wlQWLd6xm4LXpM+xLA==
X-Google-Smtp-Source: AGHT+IF7i3rTS0SvggZ7qpM6N9ivsskPHrgRxPQsIBfrwvychPC0ahRvJyRn/Yn0f565glgNXP9mHQ==
X-Received: by 2002:a05:6830:2a0d:b0:741:a668:2cec with SMTP id
 46e09a7af769-7630f4dbaf2mr1226929a34.3.1758116860616; 
 Wed, 17 Sep 2025 06:47:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7538127f35dsm4799937a34.35.2025.09.17.06.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 06:47:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250907010103.667681-1-marek.vasut@mailbox.org>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH 1/2] board: dhelectronics: Check pointer before access
 in dh_get_value_from_eeprom_buffer()
Message-Id: <175811685980.752169.702390256025070470.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 07:47:39 -0600
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

On Sun, 07 Sep 2025 03:00:46 +0200, Marek Vasut wrote:

> The eip pointer in dh_get_value_from_eeprom_buffer() might be NULL.
> The current NULL pointer check happens too late, after the eip was
> accessed in variable assignment. Reorder the two, so the NULL pointer
> check happens first, and any access second, otherwise the access may
> trigger a hang or other undefined behavior.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()
      commit: 1c735620e19e2ae07705cc38da1552ee6a696ff0
[2/2] board: dhelectronics: Use isascii() before isprint() in dh_read_eeprom_id_page()
      commit: fd396316432ad4a0f2998ea9eee9720be0e5d5f8
-- 
Tom


