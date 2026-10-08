Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369D4CA6014
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 20:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE8256069C;
	Thu,  8 Oct 2026 20:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywQa3255Cdt5; Thu,  8 Oct 2026 20:45:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BEFF6084F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492316;
	b=eJABuZ8l75nk4LnJvTMV67BXC1Hq+8SUX/EGJrbVNKU3fSGcK5RpPLjsyQnuh3gDi5SO
	 F6BixHp/81E5wJN6OmCqgdFIW6cQZOKO8UDa3MXApAIYFPolUAagnIxVvL0dbclGjjyh1
	 hg6CjtpDZAuTcW4zC8AOhckvpVDglGexgePcOrTKbeysuXNII+H3+YGZ9/BSA1wcCcmeI
	 mzZA33dFHt0gRTClkFdlm83WHHgX5uWkmse4Tot1dNbgHjMZLE+pWwhj63Hb5TBq52vX5
	 Ur/8/pxLu/7820G3qJ0QNvY/GwzCMLjc934rZ6d1TnjYZqX/qOVxh/M0dZmYwmVHOtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zrVt0yqIvWkyyGeDrb2vx4fgJB2XLYQB95ShfGelhYk=;
	b=OyRZ+xdGpvz6VgZ0gn7K7TiOjjZ4oC281nFtxc0EE7tX7CPht3MKqZ9Bs8YIDHuyyLNG
	 VcHKB8kFhvlPtUgNizNRoFJOZ7UiMlGhIvrjmP1/RN2ySU5jUF6HFz/H3dDEpyTtlsHE1
	 P7UL06wHNwoknWXaX2NP7IncbNnzlB3CLWF4dqZ90CtmroOfK0GsfQcW5nXZKxuQk8xbY
	 YnICf61npjkM918taySw30bTCdu8qlaHJ6t7c4PuVhCeVaF0geeFdpBs9zRWMGHkTKo5L
	 9SeJ8jU3LDbEaHRn4s/GVlcV2pfXlaP4+9SDz+bwJkki00s8K9i77BDJsO5t5gphCJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791492316;
	bh=zrVt0yqIvWkyyGeDrb2vx4fgJB2XLYQB95ShfGelhYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehhAJEF8h+JnKHpXQypy/iQCR7oOT3HTIgZgD9+lI83TH/wD9Sr30mofv3yFMY6bp
	 DC+BII4hxwS5xHVeAjJlrxMx2nKS/gDr6ijr82fp0oBZ6cZjMEwxeaNpn4l/iRfEvh
	 nAJI2I2f3zMdicXapebhcTBEXpXlK0uX9+4lHaBUbpJ5LCeEiGr8F6mq96HycV9EnJ
	 ah7vDNSASFGzGUDAbembjyG3FOPHOmsh0vsibhgw0jxPFXyigP3DT31Hfeghy3XRPZ
	 tWBN8a+7qcBn4YMerbx8D7AA2b0aBMdWCxj+jZxl4kFGUHH/e+7H1a+QPtkiyZQy9R
	 GthFXYiyseOYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BEFF6084F;
	Thu,  8 Oct 2026 20:45:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C82B2E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82B5F403D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTQmP1C7wKTZ for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6DE04032E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791492314;
 b=IvqhoHdT18UzY4CBl10xfYKMuDeyN4A4m8PWiMpiflOjyg88w7zw3p4nF4uRCwd5COE6
 0pTIbwlqpfsj/1+owry6M5xw6x/Lu6RH4EIXYDrDXOxMjHytuXasP1oUbTG5T233cZH6J
 4wqVxgEIgv1+fakwa6i/uFoYXeLX12PglAD1ebG2PViV0u3+LGK861TtrePWLuXKq2lyv
 tMdbKG7BYVhdevzGFoVRJmaxP/u1X0CjTxlxVeX/OUflvxmoHufqIf3wsoXX9OfjnXVkv
 t11gvxGR+hKeoYm9WdxcLDy41p5lygRZaWQaAbQpIQYDKPPUw+uh9nGHzmgvhOlXctQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=zrVt0yqIvWkyyGeDrb2vx4fgJB2XLYQB95ShfGelhYk=;
 b=G5VHpQLlr6l4vnkDTvBFcNijWXSi/8x+Nlk7si2k4BQBiIaGnjMPAly6xR+7uwZhscty
 Sopmdt9qpxbd0rg3CcHE+fNI+6LNvq6fNzxEfM/qt0kPysbJPKHHbtsHCTMqWasyz84ld
 oDQ2YxjustFYmONhBOwJLeeNizHxe3MDXsF2sAm7mkZH+1Jt0mwhMcyurzHXdyPYvS4Tm
 fsdGgVMlIYSUFVHSLfKLmELfhIxxS33+ULcIPniiyXTBgkjQdv0CctvHGx66zsHqnZUq5
 Hv8zTycS313bwxHY77feO4MjBVEjqwbQNYpvHldPeEkjt0H+AYAqnUmZ1vP6RYJ83pw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IE7U27gA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=IE7U27gA
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6DE04032E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:13 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-82478760557so4738500a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791492312; x=1792097112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zrVt0yqIvWkyyGeDrb2vx4fgJB2XLYQB95ShfGelhYk=;
 b=IE7U27gAfTl+IHkBsvACZ6AfNLTGwWeHXgr5SKZ4oEuLieWgH6d8yjc50GycRR9e44
 Dmhd5HyqfAJ5/npTj7yuCxLBl+lH6GWC5rJXSXDi/OsjSKB0i/imC+f6I98CYds8Jvih
 92iFfUJ3S8Y8FnyvQ3jrwV1P1K9sKSaVVve6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492312; x=1792097112;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zrVt0yqIvWkyyGeDrb2vx4fgJB2XLYQB95ShfGelhYk=;
 b=oXu0R/5KqhwJgCUC23idi4Q+9qrv4d9WbG9X5qVSdAyRe4ZA0KRY+W8R+SDPNTVh7W
 L2bFYMAxR0I1MYCfrXVwHnkCx5h0vEppST6dFE5IiBii+nlTuP8do2K6Yn5QhNsEenmU
 xsYiEQFnrWizDo6aZMMK/uM0K/zYMB5UPVtfR6o2b4aNpvb7x3mtPVfV0Y7+61qS+OxG
 BFDpH9vuRMuR+XQ2KifPDrmcoQ/AsokabSAfpeZrlzehgdZ+X2kCi3bxTEaBuPnRJA4z
 pAsVk4A5fa9fB2ZrMd4MHBwHauaNK6PCANogr83PXwlNmnCZqtSHihM+2gXF4LlHRo/K
 0Lqw==
X-Gm-Message-State: AFuF++ltweQTJk7jug2xeOOGamPcYI0R5iet+CLQKrjxBWqS61VlsoQN
 Zz6YNVo+3tEXv+U7qQ7w0JHBp3RLIs5nSbXPqxhfKnCi0n87f01LpTs+7j3WqkUgxM4=
X-Gm-Gg: AYBFou0h2Fq86U3nMVN0TpUYcqrylcrDnmGh1N2gn4MRl7Pu685vN+yfM+eHh+eRt/K
 KMS1Q+KiIlEMOvlFFqbI7mPbDiFazsQuMtXW01N4T+6J1lHkZTBU1aStgbABC6lrBO7OJ8IAtTq
 AChOWf1239G8FYPJ8WTRm6yy9V+J2SRxCmDNVBV7sFAPqf+9npj4pBDNFHkihRj8xVu8qDlMMvF
 gvYjVSu3DN4W5oPOaqUCN5ZTabYP9La6UgrnJSKfiABCCSsjJRwQ67YV3JQYisyovotMJqhCgvA
 TFLSc6BJUeSUmCAXDMBZzPlX6sXBcr1FN9SrOsXosEuWhMTFWohBIm/Atmeh0SntHVIjsxKNuNJ
 p/bUuo2H6wqWmo+5uYA152hZZcR+uKIl+yHL7BTw4ZgQWm6S36BvqCGz0OPYCv9wrRfofrhk6hf
 d9ndN0Zqfvs7l2oGscgikV8LzVV8DnvUnD9xL05qOh1/b2BjXJSkRz9vqQWOHtLYzjhrsCNjXLk
 WImXewQ6Tbcp5yJAHos/t7hbyERO/tq+aH94/fPfb3buAVEnSL8LsF83xSyk2OHrcJOo7w2fEIw
 oQvhZqv2APpicQgnNw==
X-Received: by 2002:a05:6830:6b0b:b0:81f:b957:abae with SMTP id
 46e09a7af769-82acc65fb18mr7500942a34.1.1791492312350; 
 Thu, 08 Oct 2026 13:45:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3e024sm46892a34.16.2026.10.08.13.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 13:45:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, 
 sughosh.ganu@arm.com, xypron.glpk@gmx.de
In-Reply-To: <20260929155215.35169-1-sochnev.v.74@gmail.com>
References: <20260928224338.505923-1-sochnev.v.74@gmail.com>
 <20260929155215.35169-1-sochnev.v.74@gmail.com>
Subject: Re: [PATCH v2 1/2] rng: airoha: add support for the Airoha TRNG
Message-Id: <179149231123.1113733.9527170462722230535.b4-ty@konsulko.com>
Date: Thu, 08 Oct 2026 14:45:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 29 Sep 2026 18:52:14 +0300, Vitaliy Sochnev wrote:

> Port the Linux driver for the True Random Number Generator found on
> Airoha EN7581/AN7581 SoCs to the U-Boot driver model.
> 
> The Linux driver waits for an interrupt to learn that the startup
> health test finished. U-Boot has no interrupts, so the TRNG interrupt
> is kept masked and RST_STARTUP_TEST_DONE is polled instead.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] rng: airoha: add support for the Airoha TRNG
      commit: ce82cd191de2bd7d76213c70b339394cc0c156a1
[2/2] configs: an7581_evb: enable the Airoha TRNG
      commit: 2b8358483c3ed62da6a705d8469de6b1c8d01679
-- 
Tom


