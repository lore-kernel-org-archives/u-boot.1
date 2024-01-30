Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B164C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC7987D8B;
	Tue, 30 Jan 2024 05:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDhMrj2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962B787BDB; Tue, 30 Jan 2024 05:37:43 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D36987C68
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78406c22dc7so72399785a.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 20:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706589459; x=1707194259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEeUyMVrlevQ98VXMbIstz6LmE9GzR9Rh8AhyfSfpkA=;
 b=HDhMrj2Haf7DRNsaZXds7Pm6oJZLLy5/P5fRGHhPYe3mWozRRywLdDU5mBteGY+qXG
 AKZqrqCRrZkVCt4rkrA/Eaun2qQACxCuKJ2bKyv16HAw9Tw781OO5gKpeMMVrDwWeYRy
 6E3MAR/RRn16n+2ZgvcHDCsMRj40Ij1AHXNfTA6GNlORr4BFHUNdc4+NknjmRjSqAW4S
 uBCUtrTRSOriwj65q9NpnzoJGyii+x5Jw7tjpC60Rdq66ade64aqsT8jjeKW144iF/KD
 XHtFYHiydWoK4iJ5gDPaHH0MaXY3a9PC4wAM0YP5Z1R0mdEy4lEwpXv0EkTXqXb4OJ2b
 xa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589459; x=1707194259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEeUyMVrlevQ98VXMbIstz6LmE9GzR9Rh8AhyfSfpkA=;
 b=Bp1m6mONo45MMWx5eqZjClebZR43xLlgiAUlJZvR4vfpF9XGlSj/b50yJhu4EqCLwh
 VuoB1nxibIpCjWU00cFtK/S8TTrh26xpJkC+Az6xB8Vvajt3fsVorPMllDqlYSzZGP40
 kmYgKyZX6zwLzQ/su8XPLMmT5u/r/TGlHfdvnsy8KHxeyDKGDmhkwdr3pFkqmez73tXe
 VF+Nrqpkav+jcwZzRxXgjh9R9/eZW1abKxGgCl0I4f7GjY10r14+iYKIXx+lK3RCzLIV
 r0xr0pY+NEa1AC7Chfd4KoNfSDTYqFXWZ+yQw3JbKfh8lPv3x+yAEUMQ2vEGH4KpKUO/
 +v/w==
X-Gm-Message-State: AOJu0YxLw4M+L1LDOkRWxiPz6VIhfA82SgeORBFbsUdvIcRCxLU/lj0I
 YUwTr4YAHBSrjpA0ZomqgVyrw2185YnUS0cZeHi2zuvmUtJDa/mtNH26pBUQb7g=
X-Google-Smtp-Source: AGHT+IFV/zUeG89gxbZYVXErvdy+uX8syTc/5GWMwbGJ777ssN7bK34+AP2Khr0q9Aajj+qw63fe9A==
X-Received: by 2002:ad4:5aeb:0:b0:685:e93a:41bb with SMTP id
 c11-20020ad45aeb000000b00685e93a41bbmr8151286qvh.9.1706589459378; 
 Mon, 29 Jan 2024 20:37:39 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 l16-20020ad44bd0000000b0068c48273045sm2206808qvw.17.2024.01.29.20.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 20:37:38 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	seanga2@gmail.com
Cc: Lukasz Majewski <lukma@denx.de>,
	trini@konsulko.com,
	sjg@chromium.org
Subject: Re: [PATCH 0/3] clk: Remove clk_free and better document clk_ops
Date: Mon, 29 Jan 2024 23:37:33 -0500
Message-Id: <170658777077.694990.5522074746205194883.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231216193843.2463779-1-seanga2@gmail.com>
References: <20231216193843.2463779-1-seanga2@gmail.com>
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

On Sat, 16 Dec 2023 14:38:40 -0500, Sean Anderson wrote:
> This series contains two unrelated changes. They are included together because
> they touch the same files and would otherwise conflict. The first change is to
> completely remove clk_free. This is because the op it calls (rfree) is
> completely unused. I believe the original intent of this op was to allow clock
> drivers to free resources allocated in request. However, no clock drivers do
> this, so we can remove the function and all its callers.
> 
> [...]

Applied, thanks!

[1/3] clk: Remove rfree
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/82719d3f409f
[2/3] treewide: Remove clk_free
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/c9309f40a683
[3/3] clk: Document clk_ops return codes and behavior
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/0bfbb830554f

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
