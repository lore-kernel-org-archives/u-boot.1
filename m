Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C78D4660E
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 18:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481E980325;
	Thu, 15 Jan 2026 19:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2cMwUnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7373182BF2; Thu, 15 Jan 2026 19:32:29 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D0880077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 19:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-5eef115c781so535499137.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768501946; x=1769106746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2UltuTJzK8ufCMiHnH6p1Mn3zr49iNN8pvCPHHqpu+M=;
 b=k2cMwUnPJv2JKlIti55EUnqYYcqHX2HBSgOkxZBbIMObgD/xV2z1ySxUrEo7S6Wuey
 U6Cf7/ySsSVRDfIsR8zUInq+FsG/gikUh1854aQF70FUfUCSZoG4vjwPtvIQyul4gyM6
 Q1RwHXKXz2ZRjzhHU/Z7lyL02ihHfa3QqIEs6zzmHj1xzYrffSo1Lpn8/0AOJkFwBLQE
 6qcW5OYpGKipdInbGjd822ThazRbhBj6Tcw8s/r0gymXCMyKBcVNDMP0Gk+bB/uFWw/W
 cUzNNS6W8tdRmhpYuTTe4sVzCHI+RhQPmwcgSQnohR4J8syCa/23nK3h+uzJFuZAHIKN
 DxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768501946; x=1769106746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UltuTJzK8ufCMiHnH6p1Mn3zr49iNN8pvCPHHqpu+M=;
 b=L7ReYmWqTbhpOouw/JqexFb3e2+Dodd+lFl+RDmlNz6Jlykwsss2bQ0Uxn/42ktCdU
 +4lWX3LDkzkwjyC3+kuNqn3FULAgOtytUD51LdKOKT452we0yL/Gpd6qTY+3ctYZgmax
 bYjCzrqb3wxYiGY91Kgj5i6aiAP2P2Uu/IO9noS5a3EcqilNjtxAMtyhJ1Kh3BgyjXnU
 DJLRLL1LCFK7Qxj/xke8KpyhGYSF3CiPINVoo4NzIRV9MpbDnkRMNRiCp1Zm7a2GiG9O
 xx19PKWxkywPnkH0vO/w5Ye5TQiTm8ddqdG0ge3HtfdK8Agjhk/+5sTtpA8QKl9zOTAm
 4qMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU97gtilvKL3wTc1GI6HjpHSYwXoqwQXkmlKGtIw+q3HzAO12Kh/e+BWpO+6UmfNytJ8F/MgZc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4XTa+FFEWjV0Fcc2tfW7s4FjDws5SaeMKpMm/iCQWbI6f0G6b
 MJoYPTZuquRz+3QQRBnbitazVu2NhtdxdhWYQ0glWJB44nCBw7CevUtFIE7Xnpf0t+6PQlgticV
 +R5LJBd4x82G7dH9EN/q800X+xnohrAU=
X-Gm-Gg: AY/fxX6sBcqEBvoAAo0lvi06UwfcQ8L+lx6FqzjKPspG0JpzOWCXjyIlyxXEJDMMGr1
 AQGRHbhxEFGg8bLedqCbhngKpiAz7IZKk3J1LO/ziXnLparmTqfbHxdqWQanfG+VAKyBXRw0g4W
 YvGphLTJW4Q2vtVhNdNnGe+FEuAOF0eX1+tp3PB+TXx1MdZehZXOu4BRkBXoFsKDiMCHUjsjQfI
 3dIkypyfC3Z140c0bZfeBwiMvzYl/h0LhxRHBZJc6VTxnR5WdccYytBOfBgSJirvCWs+wav5g==
X-Received: by 2002:a05:6102:441e:b0:5ef:ba3:25b6 with SMTP id
 ada2fe7eead31-5f1a4d72cd9mr266025137.3.1768501945679; Thu, 15 Jan 2026
 10:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-4-24cdb50e860f@gmail.com>
 <51543ec0-ee56-49cc-9434-f5f85adcab72@linaro.org>
In-Reply-To: <51543ec0-ee56-49cc-9434-f5f85adcab72@linaro.org>
From: george chan <gchan9527@gmail.com>
Date: Fri, 16 Jan 2026 02:32:12 +0800
X-Gm-Features: AZwV_QjZv8WZkklLewy2KB92z-o7khYAUdBSpg_q2DHb8ZlJ4pa9G4j8Ik6GM3I
Message-ID: <CADgMGSs7QVF5cFKu7PivpKqEoxz+j_0J5jvQffCpME4cW65qGg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] boot: bootmeth_android: Conditionally dependent on
 abootimg
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Thu, 15 Jan 2026 19:42:50 +0100
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

Hi Casey,

Thx for report. I am busy with other stuff recently. Sorry for that. Would
you or somebody willing to follow that?

The first failing report is at:

https://lists.denx.de/pipermail/u-boot/2025-November/602397.html

Thanks,
George
