Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01536EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B059783F61;
	Tue,  3 Mar 2026 19:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HKIFlbrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C235E83F9B; Tue,  3 Mar 2026 19:51:00 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC4DE83F7D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45effa36208so4163865b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772563857; x=1773168657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGZ0GLIhxZ8pcc0EOu3OxJZueQ8oFAb5hdgSvhMJtgc=;
 b=HKIFlbrwxqbj7qCIhO8m8O1dOPgfcz5teovyhjBVtzfa8PxN/6/fBNySvipp+ilfLm
 zW3+peMumvbaa5PR0aNV27hqXJdHVzxZdyZZbH5c8c9I9B75N5EXoW6VZYvdyyxMuheb
 2Ec/IYvE5vLHVLOYIo51yWC4aK5lWMlzEXOlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563857; x=1773168657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGZ0GLIhxZ8pcc0EOu3OxJZueQ8oFAb5hdgSvhMJtgc=;
 b=PnzPxhp+znWztHnTgN83/5Kq8PMj/UeRcgZhy8bdlfON9oev7hguL5DtHw1fT12crz
 NXCWtGKsUyj09xtimdAuNIqKV2dJCtSZQc60YpKUPg6CRi2HIkp8RPd4YbZABwHaahGi
 Tp3Had0qznNuFcXz95gibpzVh2xa1StpM7WOrpYb6ycUoRysf3qrxa9Gxg2WPBMiBj6e
 AfVddIxNGjPc9G61ynW3VVnl6n5N7RcFlB+M+NLzBLldYP9U0HWl6WnQw3Zy6YeDy9co
 fPHgETnZkEs25L/YkrGmAb3LztrXz3gRrd+UaLXeQ/OqHJXeORvuGF9K3LDg/i1O7P4S
 fFpw==
X-Gm-Message-State: AOJu0YzHTqPhbCgwwm/d5Z8lTNjDev690wGaSlyzdwCPcFSWPXcVUpUX
 po9E3Ry8dB1N8K1Io9arLfaFzx+iwXDsSjlCQd3VNDVjQlV38ttJW4lYcud/jXp0IK5hpGo92WM
 uXww1X58=
X-Gm-Gg: ATEYQzwYldRvbqCPl8Y3urdkqei1hz8hNdlaFAsS/2DJJo28W/NGZjiWJgkzdWC0GWh
 pnRno9UWCOjMYTyGt8KMDVyEG6rpg1HPhoGbh3dsqeNVAnE7jZ5yL+WbqyUA4BBMp7Ggb3IjPGa
 zIaP7F2NzzBqb2SPcu3P/QghUNpskp7Hjztyv1khemrW1htsC8QsU6H/LKNhqs1Tot4FHVFVavm
 Cx45TVInYdpWQWNJorMe5NeUN9pNpUIZTjsIZinrkCAEHHHJ4NdoeKrbnM3j7ZGSO34TpNUcZM2
 ReYRp8UsVEmc3tdaEwTMLJoH6EeboEmATxZx5iCdrJHqENISXKf332VySpe4GImZyNGQIHWpbJK
 CgMtgjV1b1vB1abfzfc+wrRvsJL8QgRWRwvYUH6Y8negqJV7ra7QyrjwVeX07i411t0dy0RfSyt
 jfCPfddROi0tjCo/P/1Gks/QLINyddeh+DDYw6nCldF85dNrnK6fH6x7OXclmP1/blyX1VZVs9q
 1TJTDGJJHSld10G+KA8q1jKBRFfBFFGuFGAXyzyDUW9nqj6HQ==
X-Received: by 2002:a05:6808:6d8e:b0:459:98aa:6720 with SMTP id
 5614622812f47-464bed04e84mr8343360b6e.52.1772563857451; 
 Tue, 03 Mar 2026 10:50:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb605f15sm10180475b6e.20.2026.03.03.10.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:50:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260215140535.691319-1-marek.vasut+renesas@mailbox.org>
References: <20260215140535.691319-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] kbuild: Drop phandle from diff between base DT and
 U-Boot augmented DT if DEVICE_TREE_DEBUG=1
Message-Id: <177256385639.3975993.4378895884250038423.b4-ty@konsulko.com>
Date: Tue, 03 Mar 2026 12:50:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 15 Feb 2026 15:04:55 +0100, Marek Vasut wrote:

> Remove the "phandle = <0x..>;" properties from the DT diff between
> unpatched base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1.
> The phandle numbers are only generated by DTC, but not referenced
> anywhere in the DT, because the original references are specifically
> not replaced by phandle numbers when recent DTC is invoked with the
> -I dts -O dts flags . The phandle number are therefore only a noise
> in the diff, filter them out.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] kbuild: Drop phandle from diff between base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1
      commit: f473a453b0c03d0042b4422de1d822274d2e2d4e
-- 
Tom


