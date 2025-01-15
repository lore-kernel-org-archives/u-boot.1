Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896A2E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1042D80714;
	Wed, 15 Jan 2025 02:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lBSYoGi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0E5806FE; Wed, 15 Jan 2025 02:13:17 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D47C806DD
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d896be3992so40574276d6.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903593; x=1737508393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NaWc4wbPM1JUJcQwT0TJDz8+WALXSGgQ3S8mYf937A=;
 b=lBSYoGi+hKPe2zO37a1ijeRg8BZ+ITQ6i2VjZUwhQ8PhC/CmM0/AmaOUPT3+c+BPBN
 ZK7p4EiYC5yzB8WXbKbyY32OFBPUy6DyNee2jd26+7tazNwf8IKGnykOhx2vJ/B92cKc
 W5vEUpdjdot0rUnpGjIRc3W8lyMgFjLPRr3Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903593; x=1737508393;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NaWc4wbPM1JUJcQwT0TJDz8+WALXSGgQ3S8mYf937A=;
 b=S/AJwbj/K8BzUejunnDu0yJfELS93Z4iN8DtgnJAwEtLzBUUf4iAtaLIVNanbAHSmr
 DkTvT1KeB1odwqV9kqwDuoGQEJ7x3HG90uMxxcFnkZgIlSIovreEnRMvlMyeFuW8STK/
 rRqgFDtGoDSfCApRbuep4cJAzoy5DJRoXkn5OmDTcMUW4IHalAK+rL/I9NN11Y8TcsHb
 Q6IQ4hxhkfx1WWYB5YG1KMu/TwCGf7n8yCcoxKcfk3ahezAhj75HE3wTjMFIsoBOt8ax
 R/YVNyiecJ08YcrnfSV3iDbff1sKbl++qOmRKfhI0QWQtmMjz+5p4F8fdxLzTyEh5Mf0
 Ah9A==
X-Gm-Message-State: AOJu0YwfGrS5iGCyeEzm5hDoxOeGVBds9EZo6Kmp5gNtYsb1TPzHVpqF
 1ACl8RQBcl+Bh1drrARiSZHRq0vakc4tLOXAxtqaAxSi1Ji8wUr2FaGQ9P1mp+9jhvk43qgPqMd
 D
X-Gm-Gg: ASbGnctnjt/R2tuu/LCwJJY2yeRihWtH0m8D4pXf73Dl3cWm6wjDSLrt3mQUCjBWe+i
 LMIROu9cuGgo2dKkAUYyBBWuWq14P82mH2qU/UhPSCyBt1/2u4nR3vQIK+oj9YyM8zvFF6XYkQj
 +6ZffPh9/iloYl3f4wUyYZksYXJAp+jCL+XTtO5lHjpWUyZHuZaqArt7jgdXTzg8JWHQLFtGhei
 5q/wW5YQGBV+q7ZF7UYytf7n8AJwEP171DG7O9qTjne+IAhuN9C
X-Google-Smtp-Source: AGHT+IHItYPhFhZHM5+xCTuVDC3W4fyuO/hVFGBYAdLvp5AQ/Yu6M/OL6Wt+eSTLyyuQ9pJLrVxLdw==
X-Received: by 2002:a05:6214:1bc7:b0:6cb:d1ae:27a6 with SMTP id
 6a1803df08f44-6df9b227ea3mr328440016d6.24.1736903593456; 
 Tue, 14 Jan 2025 17:13:13 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade89283sm58989756d6.105.2025.01.14.17.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, bb@ti.com, Aparna Patra <a-patra@ti.com>
Cc: d-gole@ti.com, vigneshr@ti.com, n-francis@ti.com, nm@ti.com
In-Reply-To: <20250108044939.392785-1-a-patra@ti.com>
References: <20250108044939.392785-1-a-patra@ti.com>
Subject: Re: [PATCH v2 0/4] Add fdt-fixups for AM62P variants
Message-Id: <173690359202.213810.7970895049738014059.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 19:13:12 -0600
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

On Wed, 08 Jan 2025 10:19:35 +0530, Aparna Patra wrote:

> This series implements fdt fixups, by reading hardware
> information from registers and accordingly delete/modify
> the DT nodes, at run-time.
> 
> Logs for AM62P boot:
> https://gist.github.com/itsme-aparna/b889fe59882c1acf0ef25a644bd325c4
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


