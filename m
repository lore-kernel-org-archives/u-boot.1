Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1AAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 08:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A83882E7;
	Tue, 16 Apr 2024 10:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GK5DkJYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01294881F3; Tue, 16 Apr 2024 10:05:49 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB8B882E7
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 10:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so2939820f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713254742; x=1713859542;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FayAewG6VWMFDGBHf2CJ43Kuz+zRpsgrL74aH/mej2E=;
 b=GK5DkJYNIobkOIyetD63x7MrjrJ++bo9SrshVeyjTE420B/CxzYr2nz9hoedlruLjd
 Jwtjafp67sfm65GSZkxYPIIdQuM7IAh2XSrDKgjzmH/5YFgctqRLcb0MAj82o+7c5T7i
 xB3R1QXBvjyW/LXBmAA0/QCAwAExOC1xTJKSHJRnZwG1Glg3kzYvb03axdwoqoPETrkQ
 MXbRQIBwsUaQLxFuOC/lmcy4miOUS5cluH3z6WKb41Fb2xCaRaZbXfE0o0GiMZNdylYq
 bRKRHklLVOhFUjb2fjNYpRZTYWaA8jhrAwf0d4go39qZirlZleN2qfvlPD9Wi56UST50
 6j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713254742; x=1713859542;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FayAewG6VWMFDGBHf2CJ43Kuz+zRpsgrL74aH/mej2E=;
 b=T32YcGkqj1CNX5zpqXkU3WfK7Q/Miogs6ZoZvo0oHwi1iU0I6UC7SEwfRSg+76okoi
 Z9OGQF0uTw8e9qd+NtA4yjl/AquyzSV3hu71uJgcvwyPLvMo0NmVp6QgkmAXLvDzuvM2
 ArTgZN53ube0i7BmOfjF+X3dbzDKBWusiDwhoD/CoPROspQS3OZvIMJAwxVwPzF5bijF
 SKcsO5tmGwkB9rbTQS0AnFZayfMSG/9WfjAw0pKtStIWlE9BQ6UKAdOmAuhgpxDyQzUO
 6w/rMZusWTojubSiW5Zv1gUJWd8WM7jocJlMrgcr3GjZgYdQjt9JE46Tx2HtTWOWMnUS
 hKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5kp8W0nu6dSNOBsM/n1AqqP+z2kZ40WlVxy3SLu+ip4fjcdS4YvJGODWtTV1NMKYzGKp7z+KxkH71RJu4lK739HXKnQ==
X-Gm-Message-State: AOJu0YzhhWMurc9ro+y9t8TOmzUGmVYd0z9ToStajISfOBVO6RINSUz2
 d+HGJ9zuxmLXoOdSJICGuhQLx7IHDaaIvL3XLaMGNW7DUpTXxO8fdgAT8gDKkTs=
X-Google-Smtp-Source: AGHT+IHff0nFP1izdgt/gNbghINZF9RJn0UkqPMu887DkpqzbnsDwHDqvM5SMfmjE1l57ZVwL0vd/w==
X-Received: by 2002:a5d:6886:0:b0:345:bcb4:eadc with SMTP id
 h6-20020a5d6886000000b00345bcb4eadcmr7295621wru.37.1713254742309; 
 Tue, 16 Apr 2024 01:05:42 -0700 (PDT)
Received: from [192.168.2.59] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 q3-20020adff943000000b00346cc85c821sm13400976wrr.89.2024.04.16.01.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 01:05:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: sjg@chromium.org, hs@denx.de, sean.anderson@seco.com, 
 dimorinny@google.com, patrick.delaunay@foss.st.com, 
 Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
In-Reply-To: <20240408101552.539037-1-avromanov@salutedevices.com>
References: <20240408101552.539037-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v3 0/1] Introduce fastboot oem board command
Message-Id: <171325474099.17290.17482323567013970435.b4-ty@baylibre.com>
Date: Tue, 16 Apr 2024 10:05:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Mon, 08 Apr 2024 13:15:51 +0300, Alexey Romanov wrote:
> Changes V1 -> V2 [1]:
>   - Added an example of using the command as requested
>     by Sean Anderson [2].
> 
> Changes V2 -> V3 [3]:
>   - Rebase over uboot/master.
>   - Add documentation.
>   - Remove example added in V2 [1].
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] fastboot: introduce 'oem board' subcommand
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/78ae23de701bd65501079b4c39158f152bfbafa9

--
Mattijs
