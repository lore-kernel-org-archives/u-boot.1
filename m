Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12097C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541E7837FC;
	Fri, 11 Jul 2025 00:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lpc1iY6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458C0836CE; Fri, 11 Jul 2025 00:42:06 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E300583744
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-407a6c6a6d4so452490b6e.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187321; x=1752792121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzrGqgB+NLpprRY0RGM8xuDcBQyoRXF8olss9QbLiFE=;
 b=lpc1iY6VHxMIu6+fgZl7nT+l2h55LOmCq7T/J3nlyM3uK/Z1WtqWpTXlbD1cDP3wHu
 y/WI8P6kqr6WzHn+ChRCFbahc9OOzGap/70cOrd6dm5nAidSTRdiwJNns+kOB+jbuZLv
 XCmHUh/+l2c46L124tfX4U7w5Byu4/x48Cbxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187321; x=1752792121;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzrGqgB+NLpprRY0RGM8xuDcBQyoRXF8olss9QbLiFE=;
 b=EJUBj9jeyOyI0FqXJrSaoCxntYwbWUVvyYfqwGiJo1dF6lEHmvg2pbk/doEIb3lW+t
 HNoj2ZRXhqWKVhhGRTkhczG07HhM7VjJ/jRy8aBygWh1xYs9JtWz13GmiTUbGks+x9bq
 zHGAUEEvyDOOmOOAWUWExp/A0DTa1Jgwm+ysFti4zHeFLFxqC+SdC520tWtXWxtE4Lr5
 fMNUNTUZO9+cTfKa+LS/5dmDMtcsZt4uRvVkbFM1DdEsee6R3K46FzCkIRLbsHlcumY7
 AwaytAQft9heukJr+Ir8pLh1XnEm+dMkO4GPtoFadsILxWIxSWjIbRWm50kbZC5C1Tsd
 dC4w==
X-Gm-Message-State: AOJu0YwbSuaXTKAoDX/VLsT8LLFoN1Gbv40B4LJRqYgFrcAR+ikB1Ghk
 TE/0WYNCLs3dXr7NmxM5bFh89iYY8LJtY7oSPV2VtUCU9KBFGuw7rBdhYO1O4dYJb/o=
X-Gm-Gg: ASbGnctOyAUyLnJIrPp5HsgRCn8ijjpM1sdOaS7rgixgvSGPCEEM0EKwFEkPfMvmMZp
 KDfpRJvMQNWw5BrzFBZ/DPApB/Xbow0Ge5TzJ2Zo+DEkfGP0/MzWJCbO2iPr/OoxRCl29X/c8l+
 276WW+wyxsM1F4R+/HzFxAMLcsPZi6niUIRjFvwSD9MsgqPeK1fwYPLdG3JvIERVWkjcX//cOWO
 hDvuDOvQm4rURsjhHQUhv69TftXNqYGkV+BuI4yehMJNj4wY/IN7h0ZPSv1zwcFiVq1GFgevaUl
 9+Tj1zcZ9B/W8wLy+ML5Ac7JXlG5gEauHhm+UzK8xy/+vBqMerjWy7JB8qCMVCXX0N2vDLw1Dag
 aQ27u1oJxPEzCAE/vnjuwQdRFzXbvzCblAMcpi/7si936LGj0J7yVUVU=
X-Google-Smtp-Source: AGHT+IE+bU9i4MIM3aQbVqnoNxAX1tdk10z0IRySz9Lczr2hh1knwyIx6sHP38XfGn+a92Fj75XuVw==
X-Received: by 2002:a05:6808:23cd:b0:406:1e0c:319d with SMTP id
 5614622812f47-4150f5b9a4fmr1102109b6e.19.1752187321112; 
 Thu, 10 Jul 2025 15:42:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20250702010419.18890-1-trini@konsulko.com>
References: <20250702010419.18890-1-trini@konsulko.com>
Subject: Re: [PATCH] crypto: fsl: Only allow these to be chosen on ARM/PowerPC
Message-Id: <175218732019.2073260.12124026316116862246.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:00 -0600
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

On Tue, 01 Jul 2025 19:04:19 -0600, Tom Rini wrote:

> These drivers require various headers which only exist on the ARM /
> PowerPC platforms which implement the hardware. Express that requirement
> in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] crypto: fsl: Only allow these to be chosen on ARM/PowerPC
      commit: 60b2eb40d1eacc3b12edab78fdc0c2e33bb2d181
-- 
Tom


