Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1BFB5173
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 00:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0DC8352B;
	Tue,  7 Apr 2026 02:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="jwBxbagm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A3283936; Tue,  7 Apr 2026 02:58:34 +0200 (CEST)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14AA8341A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 02:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12c080efc1eso1318514c88.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 17:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775523509; cv=none;
 d=google.com; s=arc-20240605;
 b=YC1LD9/+UgUuIMvciGgOZnd/XZBRLCYE4wFAnKCOofZV/+6r2rZCQWRoYSe16/kI7G
 C1NPdiEA/BsDoGQNUjCvulpofPaHfSPeQSGpJWBwwk6/xsM8Br5ayKu/Ssf+IbtKF45Q
 fnhUtm3gv4OXsLUBLHl2PvGrKdtAJnyToMYbN1YfhUyPAL3Q9vi/95AcHnr9h8l9dDuY
 0fh0CPD+iWeQK9aQYnM2+uChPAn51b52kwC2YJm4z+5KdJrJ5t9lGzdMy3D7HxbO0Tt2
 p1rtEwKAXqXRaR0fNIqIK3Lazsj2dziMoX0KAngA2cLp0SMeSgftDNSMw8lE2K1Ou6Si
 OkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TfynBJ7e3A0B5aQKTQM7zix8Z7bf9oSAxCEuui8Y/+U=;
 fh=/fNb4t7ehstWiWWMZLJt9bn3tobqKymLl1vg2gmPNuM=;
 b=dvN9hvnits6cUOtFtQakglUULuDkHrZJfDSkwAuQXaM8mMOs+pskl41bNTFjQT2b1t
 KoDw9xm+hcgCp59FfOH6SIWvUCyUD0jMS39cbtV3tXirRcVapmpZbaJHMGKWHfY+t92G
 B8lSJsEKvALNsBCxgnf7f0SrUKzkj6PLMOuPng6alJBE05pv7zLh7QmCm1DgMI/8xnfE
 VZ0MQxPFPnELrv27Uz6gGgPVVsa8ZQotCu/37WqEpSf5kg288Qvj/n6Zvj5pYrqruUNy
 7bcdBvE2zJx7o9Lr6mehyHOGt3YGbcDO2rj4mOrNFJ2DPA/JWfy6amTWIBKnjQ3kIayh
 EQyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775523509; x=1776128309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfynBJ7e3A0B5aQKTQM7zix8Z7bf9oSAxCEuui8Y/+U=;
 b=jwBxbagmA5uhJMjcOMnQyQGPfjNsb5QRRt/jo4QtlTMoYPN8RbAqa5yV2/r4haaxfQ
 ZE1xpZlfiKYestaqhk0RqfrZB+DH4rqpRLKEb8gybITK0ARAwjU/DIseqNuAzsGrnKtZ
 P3L4P2FFc6aP2dvhuDaSmg7zUaglQgv5iM9h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775523509; x=1776128309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfynBJ7e3A0B5aQKTQM7zix8Z7bf9oSAxCEuui8Y/+U=;
 b=HFEbk142WyzI2dx3+IYmnLyNwFdnFVt1aMVYr84Qvb8A1lVYrkG0/gNXWrSD2h/VdL
 7mAlvnZ/MV3ycswqwu871OzNntAWUlpyvhIXQ+t6J2ZMQCMu/YRjoRoZd8bLSdYgU0BF
 3sKc65qqxfUBBIcyZsvVylTnHCWw9MnoOMbkBu9tw6HFkzs9gtomNI0sPIBQTMPfDn3F
 Vd2bNIaKBiAUSNwSx1ZYHRzHZ5JGMmX0Ywh6tENleyRWzYCgkApoSS736m6EgKJR6ala
 AW7jxZSy7qaXUqC6YpPsL1TgqHMqFa2/mdYSJ2rEJ6b6yZB+4tisTcv7Tv0HWr73O9G5
 V7sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8nGcJ4k5/0DWoY5dilFBcDbMeySJggB558CsKbQBt5h1El6f/o8+At+wgo5FpeYvIFFrM2qo=@lists.denx.de
X-Gm-Message-State: AOJu0YykXGOgaQBy4f2any1eXp3T9tIt1GZcvB0upBXPK77bKhr8Uvdr
 lV+5/Tqn26oa8UdcYLOC2SYpVE2oa2H/NWGYMUMnBU18qZ4Wn3gLMwdzZ5bek2Y0bxQE2xwsIR8
 NN+foL/SpSZLPj1WrIbb3dZXqQeZHeky5t5H1y+jyBr3FGsC9aMh+
X-Gm-Gg: AeBDiesjq51E4p5D56tWO/qaMAxjUcwrF14An0I0dpPe4UniyXCfjQjFyJzDQ3hVbZX
 2I2zC2zYbkcZkIqPZo+t4sSAv8rLYZV17WCOCQS+d6oSEPJNulMvUCo4528W6R6KbaIO3zcWX1z
 lFVNHecIs8jzfaABQ92jXPffBnM3PU62KM9rQiSS9CiGnV/V5eSzdZEGXOyYkw6afeQui+hRBlP
 eUxkImI+aGp3ckkPuInMFl9h0xSOsTH5yB65J5kLGk1v13Zo/whq4PNi7M0hm42uiNL9+aw1HJ2
 Eh95
X-Received: by 2002:a05:7022:b93:b0:12c:11d4:61dd with SMTP id
 a92af1059eb24-12c11d465a9mr1691299c88.18.1775523508904; Mon, 06 Apr 2026
 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
 <adPqGChmW8FV--tN@google.com>
In-Reply-To: <adPqGChmW8FV--tN@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 7 Apr 2026 09:58:16 +0900
X-Gm-Features: AQROBzB58OFQ3V6DQQsfJf5D-x738VA4BBr6tRi9lyHoX7kW_LO_Xpga5q4rZfk
Message-ID: <CAFr9PXnQYjcvHMQQbFGS7_7Rb86Y9cO4oPSfVHiz7t7q7D8ZGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(),
 readl() endianness
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Tue, 7 Apr 2026 at 02:15, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Just wondering could this global change break some drivers on coldfire?

It might. Really I'd like Angelo to see if it still works. Hopefully
it doesn't break anything or it's just one or two things that need to
be fixed to make it work again.
In Linux the range for the in-chip registers uses the current
behaviour and everything else uses the "correct" behaviour. I think we
want to avoid having that hack if possible.

> I originally thought you were planning to split these IO macros between
> coldfire and classic m68k.

Yeah, but then we have to fix it again if a coldfire virt machine
happens. If it breaks coldfire so badly it's difficult to fix I'll
split them.

> Of course, if you've found that this doesn't actually break coldfire,
> then this global approach is definitely ideal.

Yep. I forgot that there is actually a coldfire machine in qemu so I
will build and test this on that a bit later.

Cheers,

Daniel
