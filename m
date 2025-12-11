Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47976D41D68
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0C5835C6;
	Thu, 11 Dec 2025 17:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SQFufxqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F84F83045; Thu, 11 Dec 2025 17:53:55 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1023A83045
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c7aee74dceso127454a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765472032; x=1766076832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXDmB0VlO2g5Qklv/lPlFqXnUARSKhNXZrtfj3JNzsU=;
 b=SQFufxqC9R1hOG5R4V3RsX/yRqWV3pXMQ/KUGvN7BLWhxNK5c1B9RDkEmoeY3qEEUz
 i5MTVQpNkkdFTugYCbSqHEJgtJ3rYAvy6EUvhmOAWvxmfEdRkFKNqEPoG8VsDCAQFPb+
 /hEvd57PsE6GPKb2uz+mnXaChlDSDu5+CSONc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765472032; x=1766076832;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXDmB0VlO2g5Qklv/lPlFqXnUARSKhNXZrtfj3JNzsU=;
 b=M5kTbQK/BgTPWaGkCELqQbh/W9w6Os31kfHhvNQyMZUD87By5TC73lLE+obU9fbVMm
 8yo9Gn0AC7Bn+kycB85cV1n1zJ9hWk8EOBgk7sg1fYeuM6QR6Ih81yhhIOEhEBjB44Gm
 uNZrLJmmDXc+SVhd01DYL1EN7rNqOsgvAQMLHjA0h7E05Sa7hUvzoTDHfUHuDgbqIafd
 bEAB/FaaeyX/mxQUXHk7oX6meklJX7UY8q50NUzVTK8aA01sMURc3+M49hl/sKhc58yC
 grf2/vQkpRPJyvDW9KFiloptrXTSimvEgQRJ1hNLGVZR3mLMPGgH8XZWX9tQdLd7G8d2
 jAPA==
X-Gm-Message-State: AOJu0Yys2HeMjA4jmkF9SGISsaBjA1GojUsUyYsHGmMNrOtlhLp2zHzK
 My4M8KXSBm6NSUAmS31Hn1V3njXnRYvY94FBh642TTubigXddhlvVvRPCZdNoBI0U8xrgJgetrN
 m42P8zls=
X-Gm-Gg: AY/fxX7uCaL9oDIN8P139e9J+fKl9uSHxVQiq4bsJ9srCnIEruBI2Ke84btiMBI73AK
 3U5FlHkPmiMNmBLvZcDfpg71IipDo0ZSqawpn/4Q0iMHvYt63G760rNua3YQkIRECkEVRg340X8
 qMRGGfQ7hZ+ljjulT799f9m3rzeT6LwZwVm77kakJBk5N7fChZzlJy1fAgt/IU44TMrO/yHbkVx
 gsVGzZPJo8kISjicFhLEVkB/xw0INK9c7CYrcl/yG+5scUHxqmupzL+cFwclTeS+Wpe/QPNWVpb
 08QJZkhf94B9AjYHomSLsZi9uhtdFUx6tsPwGiSS7UG93hsRF+QCtLv2b9oMAxSTxU8vt5X7DPM
 76lCrHTYo6CR0pmDVD+TE3q5yH1wRDjXNol4SIDYPihiCSSeZTuo13ubjEUAhH7uWhPBJVMYMcu
 +y09vAuiuLCQD8O7Thh3R+tjTlBbPV9XN1O9wFNT9etkgPNqvjHutUmFHwbPw=
X-Google-Smtp-Source: AGHT+IHXTtd2xJwQqpP9VUBxVSKbBPVjIUnfo0ivrO3k54Il5YbGFKGlbmEz6YcjzebhhLhoh9EqhA==
X-Received: by 2002:a05:6830:f85:b0:7c7:638a:8100 with SMTP id
 46e09a7af769-7cacec56e3cmr4166540a34.32.1765472031733; 
 Thu, 11 Dec 2025 08:53:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb34577dsm1739686a34.30.2025.12.11.08.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:53:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <875xad5n5f.fsf@kernel.org>
References: <875xad5n5f.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20251211 into next
Message-Id: <176547203073.772226.9263652011294601756.b4-ty@konsulko.com>
Date: Thu, 11 Dec 2025 10:53:50 -0600
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

On Thu, 11 Dec 2025 11:27:24 +0100, Mattijs Korpershoek wrote:

> Here is a PR for next
> 
> Android:
> * Fix 8-byte alignment for newer versions of libfdt
> 
> CI:
> * https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/28724
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


