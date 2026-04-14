Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B42F531E3
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 02:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B20F83936;
	Tue, 14 Apr 2026 04:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXp/3wn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386AD839D5; Tue, 14 Apr 2026 04:09:30 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C376838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 04:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbcd92eda5so3711665a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776132567; x=1776737367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7Pj5B77/jeYPpo37WmQsxAsuL+dh9nFlAQFxtMpks0=;
 b=MXp/3wn9UuGZM5xwNrcAf/83aLnqA+/PcKwzszFXCdt+9QzdiFP2muWPX03Ki6HoS9
 eXEXXPy+kAf3Z1o6Nw37CTX1HVmwsAVx2xokQm6Trx71sx5fpFIg7L2u0DgmD7cEzysG
 xG2xfV6CKSWh3G4DDILTMtq3Gw3V/JGOMvHqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776132567; x=1776737367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K7Pj5B77/jeYPpo37WmQsxAsuL+dh9nFlAQFxtMpks0=;
 b=FeKN1CqmzNWOrU3+N4mT6L0YJIa+w19huPLAGoYGL5zTL1Rob9ZTIUxmmOyIg6QzKD
 H8dALkuIhLz/H5AjPcaOo1oRjFVixsiWWLfcYUisWvoz590yPXMsKRGSpZysK9peoVu3
 iq6nGcbc0mmaYJnFeiJXoVpi81f3JfKs/TyYNpPId1YfPkcOl/8VjAbkHMlKC08eunoi
 +KWT7TFEDZ8vl9TNfCYfiANnVDO6R8vFwGZUgW/rU/CxrzEBL1i1KOKAANc4EI9GnZRT
 PSAJlQxuu84ZALPQVlSjnznOSxOpnd6p6VL46ZLsTxA7fteJNWOi7TosDWuoJzcg/7x0
 m3xw==
X-Gm-Message-State: AOJu0Yy5dwT4ESaR2e2/Hz+iTswMeK9EOO+/Zb1dD8kvaYOR11+moQqI
 M2+AHTnxP/fhg3xqhSn7kid2vs19s0mRbiB3I8GBWq27avT4aoOzsO1iqxxPxEoRKZ9yfoR/F6m
 DGnUxTIY=
X-Gm-Gg: AeBDieuj4UNQzbYfO2LrxMwkdp+grt4PhCdcPVLYZmYkIxhUeYi/SGwHQHq0X5wm6jz
 Aeuch85+94hqhvhINRuV/Zrm0RdcSvpu6GnM0qt1576lDIseiPIeszZJumo3rG8N70ZgFH9pQTz
 r50r1EM6yeIjYyAoTHb/iSaUd1bH7KcDIjmX4NOXF+eaEV8U24tgxCQ2BgPWbQMbNgsN+D2xsfw
 +ZVWnH40XWLt2Zp9uvu/Ep/8tbxupEpIjQL2N9Rx0zqYtlaLvcI5+bUWrXzjpBVxqq9HM1DMJSA
 m+QV+RQR47+ucV2tH6Onmk1qv4O4F9JuIk3R4J/sQoUM8jPcuMiJKF7oOq8j2vu1XLRt8VQo9QH
 uLUQ4IjNCHkOqJBmECz+CJJ37+QsrSDU16+EPK57LD8heE6GXADUlRie+zXlZdYxGB42QRWnodd
 moVblMkRLtSy7j6zmj3S4LVE80kqzSuVbbMexrvNDUffT6Kdwe0cM1e18Qay4QtuHfqwXoK6Ie1
 4O5eQdlCbgX3Gm5yvk7wz9K/LARTTUCiNnvRFV8jx4AmflgD/Il/Q==
X-Received: by 2002:a05:6830:b83:b0:7d7:d1f0:7493 with SMTP id
 46e09a7af769-7dc27db08c1mr10801312a34.18.1776132566792; 
 Mon, 13 Apr 2026 19:09:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc269d5cfcsm9757487a34.24.2026.04.13.19.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 19:09:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Przemyslaw Marczak <p.marczak@samsung.com>
Subject: Re: (subset) [PATCH 1/3] board: samsung: fix set_board_info()
 board_name buffer overflow
Date: Mon, 13 Apr 2026 20:09:24 -0600
Message-ID: <177613250313.2527409.8920405328334768256.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
References: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 28 Mar 2026 13:01:31 +0700, Ngo Luong Thanh Tra wrote:

> Replace unbounded sprintf() with snprintf() using sizeof(info) as
> the bound when constructing the board_name string from bdname and
> bdtype. The previous call had no size limit and could overflow the
> 64-byte stack buffer if the concatenated string exceeded 63 bytes.
> 
> 

Applied to u-boot/master, thanks!

[1/3] board: samsung: fix set_board_info() board_name buffer overflow
      commit: e228b6a50418e261ee09fa326464935acdabe610
[2/3] board: toradex: fix tdx-cfg-block prompt buffer overflow
      commit: 564e180d701f3946e6adc7895f2524728b985f03
-- 
Tom

