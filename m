Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF404CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDA583A7A;
	Thu,  4 Sep 2025 11:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ft7n2Z2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE22583B0E; Thu,  4 Sep 2025 11:57:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A08C83804
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so5550715e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756979853; x=1757584653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qriw3O9jv6SzmswlG3TH2WS4BvvX0d0naBUrpjbGrRs=;
 b=Ft7n2Z2ciB5N6NUDVqSC7lV/+ccOmVwnqwOPI7i/OHLTkz+KGFW03pm6m0AviUb/6X
 vps/8Jkx5a6aYj2c9JiccyjbI9YK4ydwBrn4jaCvLB7r8Jxe1XR+ifQ3j46cVRqe8+bx
 1LXelGYy8H2J5oWHJ1tWWi1PFs2VBnTpZsL9O5rA+8EI8dDka6t27+XYiJ0aMzGI3Hy+
 bbMZ2nzWbbURtVPUaLtG0auacX+8z7AUsv5bn+8gxZvd9p6rk8kUmMfk8TtGUjCW+VEq
 T5KpGUeN0xbrMDACkiroV98ZAC0DWxqVdRmqIyISV2bisGxF0/pxixnHBXmQ/gwceV4q
 nH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756979853; x=1757584653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qriw3O9jv6SzmswlG3TH2WS4BvvX0d0naBUrpjbGrRs=;
 b=GorzO7GUR5How8S+AZ5//roo5ReW+EwtBoqUcD9Mf4Imoxa0oEBb7daZqWMEhWo/rY
 P97W9Q/JpbL+dRpGbvhKevJC+anZ3GMMuBS6ULXYPFzSJTgDhZ19/HZMlQr4mv8G7IvF
 2MT+3Ssp7eLo2GlLmYl8VC9BNFswkz97eCIDE8UOdFvl/jPTtx+xlllztCXtiKqwDC38
 Dnh+pp/DatSWgGZ/mmtkLXh4jaPyomdNnd3UGEuewcOkmRgn63ET9TFh6FtfJgnAZ9Q1
 +eglT7DT/F1Jgq3TopyvqXutwvysY7RmI2EPYqyzSkOKmC8StNc8pTlQINBJ1ZQxY6mk
 6a8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEqzFSvbmsh58jMWi3MQEjn7zkqz/mTDLQpxHR5CJ4UwfqpYA4RPSnEZNCqeQdS4ARCv2dm2o=@lists.denx.de
X-Gm-Message-State: AOJu0YzTC2GF/Akb3HByy5jSoe7v/yrDavP11l1znx/3pkoVfgcHwefh
 qkc2iAlFcB2hrRVDdzHEwX2W5H9HE7UtEnmCq2AdJ5NdnIy1Mgo/rMn3P/A5m6VNWro=
X-Gm-Gg: ASbGncuBrVlKscfDgKg3pYf7Gs/FhEnMokZizpoBQkq4Ph44jj/fwDLfmcMWB4uNO28
 AtZthibcjn/TBCjdNjvx6t5xuqLMshUI0W3Io7sr23Ing/pcjXc1zSxvc972EhWIldf5OIMdfTP
 tNZLNm/tszT3dSYNtyt2acC0cRmWQIp8GxqToPDRSoNszFuu3w5ehsQeqEHb2kMbc6yu12TtBEh
 QJVBMSP7ihkdNnncZYOD3GbNiQUhlmY8zRyW+dsFleTj1D4Ypvh+vpzxMOktIaubI2BGxGrXDX4
 IkMgtMVMVPd1HBXWfUAIYYP4awY4MwlbBoY/5tvs38QcQ9qw0lgmeHkIqHNJ9BRWOoFUZVYceN7
 4u2z88eQHxvh2helKIFmmtUmPG4oR6gkWLWmaj5wio6wziSQrgkjfrw==
X-Google-Smtp-Source: AGHT+IF2oG0zSMsVL4egB1hpvh/hVmUPz+hah20E9sacYPeBHTU0yUS2aXu6TWdj2kNJcl/z04xqDw==
X-Received: by 2002:a05:600c:4f08:b0:45b:8866:510e with SMTP id
 5b1f17b1804b1-45b886652abmr131776455e9.25.1756979852730; 
 Thu, 04 Sep 2025 02:57:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 02:57:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Da Xue <da@libre.computer>
In-Reply-To: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
References: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
Subject: Re: [PATCH] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
Message-Id: <175697985196.2904655.5277786859587885672.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:31 +0200
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

Hi,

On Fri, 02 May 2025 08:51:45 +0200, Neil Armstrong wrote:
> This bit is necessary to receive packets from the internal PHY.
> Without this bit set, no activity occurs on the interface.
> 
> Normally u-boot sets this bit, but if u-boot is compiled without
> net support, the interface will be up but without any activity.
> 
> The vendor SDK sets this bit along with the PHY_ID bits.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] net: mdio: mux-meson-gxl: set reversed bit when using internal phy
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/92a2699789a8a9e093e2b10db0476d202c1bcad2

-- 
Neil

