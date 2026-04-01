Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B310FCAF0
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3ED840AB;
	Thu,  2 Apr 2026 00:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gwpByh+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92017840B5; Thu,  2 Apr 2026 00:10:39 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A694280517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66a4c6bb6ecso443487a12.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081437; cv=none;
 d=google.com; s=arc-20240605;
 b=ctUAuM1EzXFQFZmC2p28v0WipcNCftyH3JRo2/oZ6KcTvntOalfh6ShIQXpcb95u5H
 1otO/Pergx3QNa3RmW6K+DeayJfAzI3cm/tHlHDMPBhWVVWISq95DemnVRgBFLsjDq6w
 8u6+Mpez1r93c+DNUz5t4YX9F1FXPP4BlgqjA5IRicP8SXBURc/5TGw6LI8vMZOA1GbI
 5r2Ce+NGbi3ISVT9tINeS9nu8DXDm3k4zmxV1QnO5PV2HAlMDVP9a8tr4p0go/+RUkFa
 tdh8esb45DcyilWE+/8pI4bEmJ0FYDcxmVbDZrcafb7GYLewZbWdOd9yt8GFaBcvOla0
 dylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lDJbPUCX82tu0mW/4jmISJwkk6+wpk9YShBkFsaGO1g=;
 fh=i+iVFi2z6TKZDZgy4yVRKPCguV0SZyMjYi92eD5G7MU=;
 b=flJHqP1qshsnLWrnS/gkvC3Qvvv8C4jdPG2UCr6auN6isRAjvjGPl/8uNFhNtw//VA
 vz9QGkwI9wpjbYQYg7DGZGmpcI5S3swyXOhbb+CIlnpRlg++eLjxpUZXwHKYd24xuqni
 Uci1UvYr9Ah5RB+JZCr5gZO65Cwu/U/x/cLYKisTmz0PNjjiHt5UE5AJYVuPXz+ZUNeT
 qLr8sg7NPOfA1jfvKRthz4K4g7nuypbB4HpUK3ZUf4N8L7Mc1R32wuw1jnFN+LF1Tyvh
 qMcSuUbELT/31+uVmXO6kheHDSvkgLcIbyVIXJ4Y/H6a5n5W+5+QbkwgR7xToEZpIEGu
 s5fg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081437; x=1775686237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDJbPUCX82tu0mW/4jmISJwkk6+wpk9YShBkFsaGO1g=;
 b=gwpByh+Hjt3OCRs7eQhW53DJ91VpgSSHSyaZEt2jgcHECJ1uLvUicF1Edai/FukRd+
 RtT2Yp/6AXUSyMu3NpWhMdAL7LPkK1yvzZscmtvV+CkrmwgkSWbTqz9FZzSCB1ss3J8j
 NcMQG4ui2YzNrl5jOVebTv24dKMTesuKJNLo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081437; x=1775686237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDJbPUCX82tu0mW/4jmISJwkk6+wpk9YShBkFsaGO1g=;
 b=IvsEHBnTukpbU68xee3E7lY68R4s16eZQUlUHg41esjhT8nI1Q4i2c4Dh8qy7xwKFY
 A2DsoQpeqXi9LWqbxs+5+RA8/WfB7utEBV8lbxikIvNvM5eimnCepKsjuEu+z88TTPDa
 y1GxMh8Js5GFX8vpfprK4QgvnEYXgBV+kJbK+w6LXiwermOXHXY2EIymwuhjkA0B3Qso
 x6M88r1QcRsGnqCbt5V9h8xVcjNXQkbAy7WlhbjKf+xuopHQ4g2MZGJ9mK0D9Qkak3L1
 E5CbtOdNhy2/NtqbZdFTSGE9nB2nj451oFx+DU8f1s5ZiynZHjJ3RIF7x9XoF5BeeP8I
 seBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIMUJXi0ng42M2uVJxwnkLOTuLtxH06S0w1njOuzPtUU05tcSct9hbfrr8I6qGEaEi8aGYZys=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzik5gbdQtv7EzfWN24NY94L6dIbC3+0jgfUtcjOyfSoo5ETmd
 2rOLmCFsiidStwqBMoMrm3uvhFLuvCTJqqyLEhbFdOV7eOtUs4X8XCMVpoF55VNqqiKhMe1Xik1
 mkRIAu/yzeocoyL+ZJJnJWZ6s7oDN52aV1msoa+96
X-Gm-Gg: ATEYQzzXpDL29mX3B58NlnehZEXxQmEAsjOreKfdNOoGPh9CbTRDRbpINSjkG4iy5xC
 ysWTuke6zjeAyWtF3v6R3tjsG2OCrIb8DG8IZLvocQIvCMJ4Wbn8/6yddCrmdBgy5YSw33Mjjti
 tiavYqPmMjS/3VDhBqYjSctB37tqwtPbMwwIQCsAOA92HsLLhc528iDMbHcli9JeBsfBHKX6Iwe
 bdVogSJP4OirZw0T00m8o8WBgHVVS6L3lnQDxqXnqqByQ5qwUDBe30Zip6//FWtQQAeZvz0Hj+Y
 KTW+UA==
X-Received: by 2002:a17:906:2658:b0:b95:6687:4d15 with SMTP id
 a640c23a62f3a-b9c13ca19bemr286442866b.42.1775081437163; Wed, 01 Apr 2026
 15:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-9-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-9-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:10:24 -0400
X-Gm-Features: AQROBzDk8SdGFl6NoKwaR0ad7RCC4THRqcL9P_yxgPBbW7NjH4csXy7RPR8vay8
Message-ID: <CAFLszTjJTGTAMwT2Dvb=HX=dG_7JuvUwv7kyv+_F3_tWZYje2Q@mail.gmail.com>
Subject: Re: [v3,08/15] test: vboot: add test for ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: vboot: add test for ecdsa
>
> This commit adds test case for ecdsa on fit, but not (yet) for
> the global image signature (preload).
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/py/tests/test_vboot.py                        | 29 ++++++++++++++
>  .../tests/vboot/sign-configs-sha256-ecdsa256.its   | 45 ++++++++++++++++++++++
>  .../tests/vboot/sign-configs-sha256-ecdsa384.its   | 45 ++++++++++++++++++++++
>  .../tests/vboot/sign-configs-sha256-ecdsa521.its   | 45 ++++++++++++++++++++++
>  .../py/tests/vboot/sign-images-sha256-ecdsa256.its | 42 ++++++++++++++++++++
>  .../py/tests/vboot/sign-images-sha256-ecdsa384.its | 42 ++++++++++++++++++++
>  .../py/tests/vboot/sign-images-sha256-ecdsa521.its | 42 ++++++++++++++++++++
>  7 files changed, 290 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
