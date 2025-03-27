Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98388C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F6F806D8;
	Thu, 27 Mar 2025 17:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="LTDMIR8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E054F806FC; Thu, 27 Mar 2025 17:32:07 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24E5805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so834664f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1743093120; x=1743697920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfdldsNIBAu4x/Nr3UmksKEeBMKX4wcjAcWVvaX7wmU=;
 b=LTDMIR8p0B1wZkTvFu0woTpNF0ZQEH5W5yMOcuuu4Pk6N3xN7z/cGJ5eElbAOD7Fnc
 52XxS337AnT9Fpg7OasmDnM8FWmay6O8srIxdtgVVk7q5JJPDLjDehwOttL2GaZwJhPP
 3mtJEf+abo+D9qAKHrH2/oE+Nx6SzsqbMa8RVp+BBZigt9wV6NG2R2v+60pM3vwX1kRh
 sA4ehdb639aTl8BlhqeSEWZ3ZQzOT5vsK8xICxjxOrXqzJZd4iq/qSZM7hjf5+Ce10mZ
 CLekb1xd2SL7fUM2TUboLRkavaWXYCUyH8uRNjRZaXdmMfd/TyBZs3nYzwC6ga2cHzSY
 hb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743093120; x=1743697920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfdldsNIBAu4x/Nr3UmksKEeBMKX4wcjAcWVvaX7wmU=;
 b=sNkANmoGMZwhnZvSPQ3ds+roM8z+mu2PnqjBN2KHGXAnwCxl0ECx6WkBMG+YiGZZAx
 mi5uzm6exXcEZg1DZmZgFUasiP58eyy1CMzMHhzeOYzDFS22EWTXkpuNC4vbOGLk4rjr
 HR3htG/XUX+sMyylACF9zezge58gMFMg8uNhVVlN2A4u9B8u3huJSe0KG2VU8UtMECgI
 aK9Xwj4HwEh+Y+Xdz2Bcw+pJy2wJYgKSy5ugBGjzLLlGX2tHbPCmD9/ulFmI3GA4NQ/4
 H5J9QQBGDOqnxgrd3ZT3m7IRRpksgWFe1KIqxiD/TTT7ZFHdI+1ThzrPX6DEgCDTL+39
 JbuQ==
X-Gm-Message-State: AOJu0Ywz2qSqUujNLmvniWsycpYaXLtycDW+yZkdWXH8aUZzYImgWY3s
 1KU3ncYDKZJwSlsxpzWPn07O4r8a1TV0Wxe0QMYwrcISL3Pwzv+jivNHVL+Q4p6zyqE4VK4JR/L
 A
X-Gm-Gg: ASbGncvLem6cdeb8IFbPIzWO5KbGTYQKVEkq7lKgC6t6MlkkUG8NNnc30CCYMyyf6z4
 NPc4UYk5L0LJUIgSQZbAlBYX0EyqQon9rIDApwqyR4YmYhh86trVk83CTsDGm3eSCqHWXxtyAWc
 s2ejefs95GiDxbqKVHFrfofskU7fkI7oB6GxzWIzaCZvcUPHcFP1rYI/EkRDFhjhl2nF5Crs78W
 thX6enIdHI6i0M3V2cPLISkJk0xVQLs6fAlTahYQBxUo9NzV/2zHlN95i3s61MDSJEoItLeU82B
 f4oo51Kv5u3E+qBsTN+jU4GxnBsA1UuHT5DmsacDTVechnc9ta3DYNxYEchsK/Kave0+ecl9jWj
 TUS8bElrUMTv0
X-Google-Smtp-Source: AGHT+IEXgev3q1oPeBBWbD/RS61kHW2Dy2f6M1Ep6Y0GOzoKCnsk6Bb1MhMABKHxCvPyBov6s9OHBQ==
X-Received: by 2002:a5d:64c7:0:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-39ad176b9e5mr4048742f8f.41.1743093120257; 
 Thu, 27 Mar 2025 09:32:00 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at.
 [84.115.238.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfd9bsm7395e9.20.2025.03.27.09.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 09:32:00 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mauro Salvini <m.salvini@koansoftware.com>
Cc: upstream+uboot@sigma-star.at, Simon Graber <simon.graber@sigma-star.at>,
 mbrugger@suse.com, pbrobinson@gmail.com
Subject: Re: Unexpected RPi5 Behavior with Saved U-Boot Environment
Date: Thu, 27 Mar 2025 17:31:59 +0100
Message-ID: <2017235.OF7RDaNIJX@anvil>
In-Reply-To: <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
References: <3097333.a1USZiQ7eK@anvil>
 <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Donnerstag, 27. M=C3=A4rz 2025 17:24 Mauro Salvini wrote:
> could be related tho this [1]?
>=20
> I sent this patch some years ago but was never accepted in u-boot tree.
> But meta-rpi uses it in u-boot recipe [2].

Uh, good point!
In our initial experiments we have used meta-raspberrypi but now we don't.
This would explain it.

IMHO this patch needs to be reconsidered.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


