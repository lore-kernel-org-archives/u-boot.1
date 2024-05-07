Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E2C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2267E88781;
	Tue,  7 May 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uY0dcxir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D0088742; Tue,  7 May 2024 16:02:59 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B5F88199
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43d3a33d41dso18159231cf.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715090576; x=1715695376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VaFr1OyMH5A869IRuMpXwDK33DBP+6pK+QeB3xAo92g=;
 b=uY0dcxirGDKdcrqJOLgUTryu6/7onluK3cCDL8env/u/XdA7Uy/AeuvkOvsejexG7Z
 0EeHriSuCULyytz7eucOnY9Q9Fu1hNdgAP9bYOTFBWhDZjM5Xx5aEO8FJl67e1uWNTXC
 9iysKpchpuQyneFaQXZZI6CONxTaUINKkaPKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090576; x=1715695376;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaFr1OyMH5A869IRuMpXwDK33DBP+6pK+QeB3xAo92g=;
 b=PGt+nFDG3gPW8TGR/tLUJuBU6pifW/fUd5xEwlMl2UXoxhTni6Ck1aKQrPYS6EonbA
 TqW61fSml1LT7yGEuMNV2NpUnX59HrT1qQNc+fT6TCP72xjhm+PvKcKNueuEhUB1DkKC
 gylOrb9aqztKFHGIAEa0xbdoi7iXVbITvoiRrKr0wthOXdUsGFM2ZlWwc2NakMDeu5ZZ
 9E6FdLwB+LeUHL9o0ikvn5bVgCJbjvcK/HffOJJIIWd5HdEOo+bw8fFTT4jcWWEf+cJV
 QOIvXHYRwpgd83HA/cLsgpX2prm5hPEeotrlyljJRmSQa/tzvarVAU7hQzjblPU4bSzn
 raWA==
X-Gm-Message-State: AOJu0YyjiwzLtMIMjZW0d/IcUlNUcqzxchWherWJqITy8gZtxe/7kpal
 EsXuY6US+vsF7TplQ/uI6to0Fr8xO2usl4WfZ170leUbWrGODBexyXmVwoOhw9lQ/2yupVgh9ha
 Rie8=
X-Google-Smtp-Source: AGHT+IEw6fE4GtLqqIsPBVuWd/l4NnHsvANF/2RWusjQSqB3YdCcyQXr9BhdmdOzZb4DvFpZIsJwjQ==
X-Received: by 2002:ac8:5704:0:b0:43c:7598:676 with SMTP id
 4-20020ac85704000000b0043c75980676mr14639161qtw.38.1715090576123; 
 Tue, 07 May 2024 07:02:56 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 ge16-20020a05622a5c9000b00437543e5307sm6460400qtb.40.2024.05.07.07.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:02:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
Subject: Re: [PATCH 01/33] arm: mach-versatile: Remove dead code
Message-Id: <171509057523.3014396.16890563210691699212.b4-ty@konsulko.com>
Date: Tue, 07 May 2024 08:02:55 -0600
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

On Tue, 30 Apr 2024 07:35:27 -0600, Tom Rini wrote:

> This platform is no longer supported in tree, remove.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


