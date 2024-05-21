Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500B0C25B7A
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 13:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E9B8877E;
	Tue, 21 May 2024 15:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XE/Nqsem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D458874D; Tue, 21 May 2024 14:25:22 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926C28873A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.martin@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34dc129accaso2980549f8f.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716294320; x=1716899120; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AY5tChqkoSDDy3oSrFTkgqJPBWK7iMyvpc0IuQVNOkg=;
 b=XE/NqsemQIwFY3DqSmGJasiZAsnEZFSZj6BgO/DlX+c/34SZmWTDi4bBeT7IQYfgjQ
 uGOpJAHddSaR/o/65JdzxgGlV+PJZVrpHzLvr0cyTVe1TwqKvuzjF4BuYOi4dKrhXisb
 LK+3BbtP02/Lr+5LQ2gtxW56eA5MMGDsLBlbBQbnGOx80bjXuSAdRD4AmeTwnAchbpNY
 sVAQNI/MYtO2K3hqGHw3uP34y0yD2uC6lf/mDjYNaQBNVCNN03kLYBggBhXnQx0x2SO3
 c10yULbtp6GgCYVwjNN/NAJoDnWOke6s2YnUhQ8C/oqAwrKGb2aoguTDth69kz94DyUL
 STVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294320; x=1716899120;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AY5tChqkoSDDy3oSrFTkgqJPBWK7iMyvpc0IuQVNOkg=;
 b=YKHr41/r8pd36jHMj6/T6AMoBxV5dz7khvI7hoLwGwTNpwBCntUMlANc0JYNSi9oPN
 sxFxBa08hawawW4TWFA/MVj2pj6kKIcMhB5wQXaLhM82l7KuG+fpwY3D8Or14KbXT6QX
 p62+XQilzK8Mt/3PqbhTw/BGA2wmk7QUlSKms2rO15J3CKpMg4yJuuTpKEnLUNCwcNxN
 SKGcOe2xOvl9qUf13oa3u2Q/Ew/r1QKtuzvO2stl+/Ik25AKf1UGyNYyAxO3KHO+usNg
 4g67/qtJaJ8PLrwMI8Qhsm6yw+4hFcbwa97mzoQIc/MHibRJI5CBjKeQE64gcbBp4BGp
 9Efg==
X-Gm-Message-State: AOJu0YykT0DSP7BH5tRz8E9BEwscimvWCBXvRu5/KNS5J2lLZkRYkYpK
 hIb9OeLwNpfH5RtZNt0cbRfI/jtbCbRwstkoaIvLp+YkWlAfcjkh0KJb3+PhnTeV3PDKvoLewP6
 Tnui1VZ2CUehMKAffBaqfwpXz8u9LN7hf2TQDcw==
X-Google-Smtp-Source: AGHT+IHfCAzsmL9Vq4roqUnkzhF6sq+2Qoq4xORiolL236LKcSJNoB2G5oj33dtcIRfHH57tiOTBgHRfoTbYzR36rCQ=
X-Received: by 2002:a05:6000:c91:b0:34d:e262:8b54 with SMTP id
 ffacd0b85a97d-3504a632fe9mr25364148f8f.7.1716294319782; Tue, 21 May 2024
 05:25:19 -0700 (PDT)
MIME-Version: 1.0
From: Hal Martin <hal.martin@gmail.com>
Date: Tue, 21 May 2024 14:24:42 +0200
Message-ID: <CAHkvJJKjj00KW0CGR8u5EjnN_ZhZXn8Oc0hgxw=ZE+RC+HCZxA@mail.gmail.com>
Subject: u-boot and vendor GPL non-compliance
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 21 May 2024 15:05:46 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

I have looked at the mailing list archives and saw that the topic of GPL
compliance has been raised before. [1]

From my searching it doesn't seem like any of the previous threads on GPL
compliance resulted in the vendor providing the source code or any
conclusive enforcement action happening.

I own several devices from various manufacturers (Cisco, Gigabyte, Siglent)
which use u-boot and for which there was no included written offer for
source code provided with the product. I am reasonably confident the vendor
has not made the u-boot source code publicly available.

For the above vendors, the u-boot GPL source code was requested via various
channels and the request has been either ignored for an extended period of
time (12+ months) after acknowledgement of receipt, or actively declined.

I know that other open-source projects such as busybox are members of the
Software Freedom Conservancy, who represent their copyright holders when
vendors refuse to provide GPL source code. [2]

Does anything similar exist for u-boot/denx?

Kind regards,
Hal Martin

[1] https://lists.denx.de/pipermail/u-boot/2013-February/147191.html

[2] https://sfconservancy.org/projects/current/
