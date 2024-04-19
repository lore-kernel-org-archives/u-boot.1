Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9C6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86763886AA;
	Fri, 19 Apr 2024 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXnfcrYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17843886B1; Fri, 19 Apr 2024 03:58:03 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079EC88208
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43692353718so9551201cf.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491879; x=1714096679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFSiTIQscVIy/Xo6kH5F5feYZZbjIP/kSXDnFx09UyE=;
 b=EXnfcrYMBAvKuplT+btKegfSkd0nwDfT2k9ZURJQFrq0BdK0moWn73uIwnjyBz0JOD
 +4alozUHmStLeWQGqFrMNpyR3wmtIH7W4lJWX3Gs5kD51IYCOHm4ZmwNTJjqdNq5OR8C
 3XdEHwbf7NPDeUFDNGUnnFjp1PLhsChjqY33M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491879; x=1714096679;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFSiTIQscVIy/Xo6kH5F5feYZZbjIP/kSXDnFx09UyE=;
 b=IKQyflE30GCsOchCiVQZYAb5bKdeNO8pL8C2lrK62E2ifh9HQNeLq6lGfzd/z35EdW
 p5/839ZH2PX8+jSk8942z0NlqdCQPbPBBm2h4jmJCxCE+1Zb9nEDsg768Xcs6J+hCSAA
 V+Ks1mjnI+msi02zDpb+vOEuEtoAScDQcfIH8cqChmtNwckXL18xA+O4TkZWCAD5Xy0F
 StXowOj6nFet959FITK8DmADX+ToVqVsOZPRPY3MvVqWHJ7CGd2GD++MFEiIf2oE/fIt
 Wv4ndTH5q5lU8IUo2bcRrWAX4hmUYl79amGCssIJWmiSkNI5IjFWrLwHPACLE20VLZUj
 Tdow==
X-Gm-Message-State: AOJu0YxDT2nxf5s3Bdu98Tjb46m4mVm4aDVrmVjmYJFWadgp00ViXqxH
 +YIUf0Cs4slIlLa7g3quJc90429hRO/kj0qQrH1EMdSN8bHs35V06S1wJnX4YaNS8ZzgM+lbWiz
 7yXLm1g==
X-Google-Smtp-Source: AGHT+IFnwGzIWTlUslHxEytXkDz1I10WNvJSuxNg5GZ9zGgR1Dm+/8hwyIcINq/FXuTHz1v8DXmjLA==
X-Received: by 2002:a0c:c252:0:b0:69b:20c6:a3f1 with SMTP id
 w18-20020a0cc252000000b0069b20c6a3f1mr684064qvh.53.1713491879582; 
 Thu, 18 Apr 2024 18:57:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:57:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jianan Huang <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
In-Reply-To: <20240414150414.231027-1-jnhuang95@gmail.com>
References: <20240414150414.231027-1-jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: add DEFLATE algorithm support
Message-Id: <171349187833.1524174.11798846969773429798.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 14 Apr 2024 23:04:14 +0800, Jianan Huang wrote:

> This patch adds DEFLATE compression algorithm support. It's a good choice
> to trade off between compression ratios and performance compared to LZ4.
> Alternatively, DEFLATE could be used for some specific files since EROFS
> supports multiple compression algorithms in one image.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


