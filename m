Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97572C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02D882F83;
	Tue,  1 Jul 2025 17:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QoGSwkZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB6782FAB; Tue,  1 Jul 2025 17:38:19 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A095682F71
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 17:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a8d0e3822so2977951a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751384296; x=1751989096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfX7Toui3mQRvQ6JzOCcO9pTTHLtd9rbGM+r2ZjGagc=;
 b=QoGSwkZ8SOh8nrMPSpmRXoq+uXN/bbLCgczipwp/R1A4nQujbQena2TYiZWvEuPt8s
 ojz2Jd78UPC6QxO86S/0SMBREzS7IlvkgkkDFjKVqNjk13qKGsLQsAe2UmpA/vEGQOHI
 oSiO2fka30K5nay2L57j01qQ4/u8owi0yB/wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384296; x=1751989096;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfX7Toui3mQRvQ6JzOCcO9pTTHLtd9rbGM+r2ZjGagc=;
 b=ZNKBL2rxL4lRNJgShg22moxtKOv7f/HGg1Qfd5t9S8a7ayNl83XoB22CwcfZPdyD0U
 vettylHMfp2e8whvroNGhAunr7HW6TlpV1XJKGL7spVS/uFqP27byC+++ezvc1qGK8t7
 7wdqniPt68O4c3A0MVB1f9cdUCD74g0ZImTYpyxSlivKC+xnRbOIkR6AYXXNgq/8qYZP
 8CKaelRdBux6e4lBFQ/2I7h5w99AKj4kkI9nurEl+y5AlBvor4J31w8JdUHo86W7mvKv
 ceFa1zYOaZNQ6A4bpI913LqnYhuPc9WcJpUbTKzeg+t1Kb0ClRx72wn9p1lBUwsYn7QL
 /16g==
X-Gm-Message-State: AOJu0YwUzP+aFR/G8d+LWBv9/ZYlkVSBIIIEOugYQIzs2pjnjUD/BKRZ
 npeB9QYPo+hO2Mu/m7Hg31u/XohOyz13NZnKWM7KR9F1+tpqA9SFJYNzUmEoJf7LLbE=
X-Gm-Gg: ASbGncvSL7TKQ7MEBXXENC8Wudq9J7Cn36xwdaCKpKh6WWIebD0ZwOn2aLLBi9HvdTF
 IWtwR8QSYQx/HfOgCv0y+0moEZHzAdK+HXR2WEjOvlbCgy9mTs3Z9SIyYVjzPfUyORAKASO2xnE
 YOPfLJK8nJDt49C32tdUb087Wm94PcM+rk8qwxzjSF5z5/9wasRbUzwA0sLVnW5ddKgHYM+K5wF
 27HB77UeZZ3O8O2QPs1Lq/tVkb70TLUGjpMvuh584tdH+3hp0ouXCBH3XJXWZaPALU/M0QoiW1f
 T+TR4AK8Jn+0/UaobsiyQCoeRe8IA96Hsn638Rq2fk3/xM/Ds4SN17tZRNRySwHw1XCIxGC3Oay
 8XfqVzS10gzrgkl1nqcWGXg==
X-Google-Smtp-Source: AGHT+IE64mKncE7dxT62RztokT4rknNMcHL+40MnTUmMhXt8hedU6cL7EjWqAL3I6Q7fYZJYonxpuA==
X-Received: by 2002:a05:6830:490c:b0:72b:94d8:9466 with SMTP id
 46e09a7af769-73afc6d3c9cmr12239283a34.28.1751384296231; 
 Tue, 01 Jul 2025 08:38:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e2f7bsm2127857a34.41.2025.07.01.08.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:38:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250701014215.2011927-1-festevam@gmail.com>
References: <20250701014215.2011927-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250630
Message-Id: <175138429522.3146160.10038438399271456677.b4-ty@konsulko.com>
Date: Tue, 01 Jul 2025 09:38:15 -0600
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

On Mon, 30 Jun 2025 22:42:15 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 490ae8ceae2d5999c9de863e014e463f5c1495a6:
> 
>   Revert the last two mach-k3 changes (2025-06-27 13:07:43 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


