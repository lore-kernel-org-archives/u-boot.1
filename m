Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D4BC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 19:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A8482161;
	Mon,  5 May 2025 21:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QNDjzC+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F26382928; Mon,  5 May 2025 21:40:43 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4288215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 21:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40331f302f1so2944548b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746474039; x=1747078839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XO5MfRC0BWgYW5tIHuOYqM2OkptGjiGvuURtpwDeW4Y=;
 b=QNDjzC+GK5o1ZP1cxfs8q0bTGi5i8FSLqgQgv8NQH+I96C+kaE4TPFIzsdjxXJi5rD
 klPWzGa6lBKtmDZs0+8T8o/ZXxBeh+OIPACxV3VCkDorgQCQsNx2iX7BQfnKb/eT+0CR
 WxA4B8MNMRiNEyyAcOv3dYmo+i3BA98tQDTnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746474039; x=1747078839;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XO5MfRC0BWgYW5tIHuOYqM2OkptGjiGvuURtpwDeW4Y=;
 b=D0DlVvgDx1qW6i1Ov+Gw4nRpCd8zfXOmPbi46+UI82GG6zd9PomsWbpt6YUx8yMbGl
 iPeFiKIWCLA8mVQaiEHV/cjvDrrsbNzJ+ckU04t92ofSMWMj8K5dZaaH/aXYNJE1GtD4
 /4EJBL4AS94ZOCKFYxak/HqmF3j6cM4JdyIRXlU+XtEi4ldClsHVvwJAoVk+vgbAIfV2
 Ysjc5M0yiDfXxpcuKk10jBzsrI7FfhRw+B5sC2jYB6CjvrH50G/GxETpx0cOVgnrqKiO
 OoruJk7Fc8cnLi1TEzJi4rrKO2ep2ABcb0/svS0aa+/FTnf3it2+H8GNdSTQWGtppYpr
 8PpQ==
X-Gm-Message-State: AOJu0YyFJb1w6J5J8kWDgG2Tq9KpBRkc5FIkHrW0iIKbVyau3MEzpFBW
 zJ//wfsjkwt5wXrcy1re3Q0iX6VHhYZ+wiyfxWc3EDXECKn8cJVAVOkluVoD810=
X-Gm-Gg: ASbGnctaR3idENAilAm49GRPXx0nq3z/okgb6fcqGZdkHr4oxRtvnJHisfN5+I8r4Tm
 GUDMtbY6yjOu1ycmrPg+vz0zTsGCCHF7TLiAoU15rOQGfrYkE1hkNimNpV657agasKG56kGJM41
 ISf05G5nW3nufjSmTDOuulm/PpJx5DLReODQyj23be7WeNRmbWsa4jqV1hQsa5XUIs218QeJk1K
 xfw+1cJB6O1rtMGudNhqDUSAFw12EygxtAkl8e84aKaMVR130h0eUikBbto5STxoNs3WCHBTGSA
 otTUzO3XeW4DmK+Jz0Ng4BTD0doSGULZAd4ROQYBlOMyqSvb0jGEXPPxFSoiy0GBCdDnrGe+waP
 3
X-Google-Smtp-Source: AGHT+IFLhG80btrQooGzxDQT3XpZn2zr6tLOnHrln617seorNhugMQYf0kO32jWw0TpwixG3jEcwyQ==
X-Received: by 2002:a05:6808:1693:b0:401:e5d6:31cd with SMTP id
 5614622812f47-4036978b420mr96473b6e.3.1746474039239; 
 Mon, 05 May 2025 12:40:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9a519fsm2058128b6e.9.2025.05.05.12.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 12:40:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Alexander Vickberg <wickbergster@gmail.com>
In-Reply-To: <c7632b5b-7fe5-3ded-e42d-5554edc533e9@denx.de>
References: <c7632b5b-7fe5-3ded-e42d-5554edc533e9@denx.de>
Subject: Re: Please pull u-boot-ubi master
Message-Id: <174647403823.47668.15751126583158782812.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 13:40:38 -0600
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

On Mon, 05 May 2025 15:27:13 +0200, Heiko Schocher wrote:

> please pull from u-boot-ubi master
> 
> The following changes since commit 9dbe8d889546efd6c1a3470092588b9b6820158f:
> 
>    Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-05-04 13:44:01
> -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


