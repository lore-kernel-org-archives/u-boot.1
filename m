Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF00FC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54AF81FE6;
	Fri, 14 Mar 2025 21:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KNLWDmjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9333A81E8C; Fri, 14 Mar 2025 21:39:42 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D443681E8C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c55500cf80so197331385a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741984779; x=1742589579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gk3mAz2qUd9aecayEZaGE9MOabpjDoam5lzqg5t5Wlc=;
 b=KNLWDmjzRiusY1l73pxbgUbNGAOjR93gEsa9L71I8Y64ndJ0aWxiJ5Opv/rLBREwND
 pJNpbizQ1m0kknuMHw2pjqckSgtEjN5Lq3MooHQnpBmyCTj2TEEZK/9VEZMIU9177BGv
 yU8j32Ub24O9VY8bWROHok5YBwT8qrKq4YCm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741984779; x=1742589579;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gk3mAz2qUd9aecayEZaGE9MOabpjDoam5lzqg5t5Wlc=;
 b=tKeCwf9CFLp7r7+7ekiAWad++EWIfaBWk4ZMS4AXYoU/90uuM/5MLXlicah5HKXtmf
 XjDojTEtYTgFgOD4Vj0sGSro+bAqtd1ZhBsj8qSNernq+oRPywAOJTsCOsXtPBjcrX36
 dXD85TXugoc+0Ia4ihFIeBmdTm4RQQUP4vT8LRryUboIPCg9Qr8ROFXMUcF2z1mHdosn
 B7F5+1qzSTtzdyTeM7aLLnxERWjNz+YS+3yf6pEjK7PkCxAL6ewFDpENjtciuDeRvBiH
 gF+BHKy3gvgVWcR8fq2FSJaw107NsLEfJEPHI/wVQKsRZz0eSEAne07L+SC38G0FOClp
 8r5g==
X-Gm-Message-State: AOJu0YwD6E5qzbOIUdDZNjBzB9PWu5RB0D6SgYu07W0YJslcqSqQ4lEX
 GonYP0VwpqGWI85pKdiQynwj5wlbKy81jT/oknHFEXDLGF1cmx+e59go6prh31I=
X-Gm-Gg: ASbGncurIPGEYe58mEYfsOV+0eEW2RcytsO8CCdrto3AnWfKukh0sM/I500MMYyS18U
 Fp5hs9c+aePDb+GVT6w5ARiHLskJgUBhvL0zgYvAPIif0w0W8lxklNtWWF4MYtUVI+7E2d4+CUf
 fUA0ssAkJlZNviMB2to4nkc/IMJyLJgX7nXgOGmTLWr1Tyj+fyjYvnfGprPRdnLaqcgGZ6C1OEl
 6aZ1ymqyrWbxy1wHhjQM9uKDZ8Qp15HLB+XZHBZ2MsZzfXCy2MoMbhQ8LLS/zRmdsiCneQCzpU/
 wESPFAUhfhjjIKsnKtNK0pKNY0JftfRWajCoaxyXWbiC
X-Google-Smtp-Source: AGHT+IHctdMvLIxEmVThYhQwStensdDeTk5bh7xS1s5jlAf1jS9rbQ3+oC3RhDgKsql/afaulUqI1Q==
X-Received: by 2002:a05:620a:2406:b0:7c5:5801:ea9a with SMTP id
 af79cd13be357-7c57c7b9a13mr459736485a.11.1741984778814; 
 Fri, 14 Mar 2025 13:39:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d72b94sm298787485a.77.2025.03.14.13.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 13:39:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: j-humphreys@ti.com, javier.tia@linaro.org, ilias.apalodimas@linaro.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250301080049.965438-1-s-vadapalli@ti.com>
References: <20250301080049.965438-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2 0/2] Enable USB MSC Boot for AM62, AM62A and AM62P
Message-Id: <174198477654.2277875.1584947982375094939.b4-ty@konsulko.com>
Date: Fri, 14 Mar 2025 14:39:36 -0600
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

On Sat, 01 Mar 2025 13:30:47 +0530, Siddharth Vadapalli wrote:

> This series adds config fragment for enabling USB MSC boot and USB
> Storage devices which are applicable to AM62, AM62A and AM62P SoCs.
> 
> Series is based on commit
> 962217d218c Merge patch series "boards: siemens: iot2050: SM variant, sysinfo support, fixes & cleanups"
> of the next branch of U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] configs: am62x_r5: introduce fragment for USB MSC boot
      commit: 460581fa7895c253cb401e2bbd1f6a7e43b41f82
[2/2] configs: am62x_a53: introduce fragment for USB MSC boot
      commit: 45306e894bc376908e8e0955ff43d68131739ba6
-- 
Tom


