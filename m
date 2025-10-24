Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A64ACCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585B383869;
	Fri, 24 Oct 2025 21:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SCknjzI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B69F83677; Fri, 24 Oct 2025 21:55:12 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13032836A3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4433456f043so1335064b6e.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335709; x=1761940509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xOQzECb7DKGRujC183aZIPAr6Y1Rq3veGwXsPSz7R0M=;
 b=SCknjzI69aeQryusAopnRFqcuGbDHPm6fKCUXJCSoe6SYVkP0TeLirAmXQvARMZ45S
 PUUcMTh59CKtCJp7d8ArQJhm9KaDGU4YraAW0PO0f4strQlRZF9RdHkt5KZdzwUiY721
 vfycb3RJQtg2RbXYo+X5RVXFuVC/Kq2MSlZ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335709; x=1761940509;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOQzECb7DKGRujC183aZIPAr6Y1Rq3veGwXsPSz7R0M=;
 b=ECIJqzl6aWrvfI1rar3kH4+PWTMu7Mf4NVwhNzVzy3yeJ6rgjjprHwnzjee49ODM8I
 UJF2vocyQtsziCCYbEesoouwvOlVnEJft2iz5ujmtDdo65GjAtKFJYd4hYcJ/IgFN8XG
 bajNC6Eahet8i1GZrzVgd6GBTDbO7E2mxMov9Ow7BKOnPMs1hd3GG1zPB1yURDNpHi4M
 klhlPa02iyZ1aBxQc29/PCIiSkdCZpVe8KzAZ2ch8Ibl3L5lGXUwV3ajlQUxlhQ+A4vU
 QJoIdExJk+29jBXtD3/l6oT6Bn4WaEvqZnhrpll1cyOkhfeZe1azYgSWNgQ7p3FeLl2q
 nphw==
X-Gm-Message-State: AOJu0YwoL2zB/JJ30m1Xuizdww+22WhWCxCUqnpQ/ezz5B0XElg5ydlF
 wxNVnmy4i9M1Y2t9qPzYNymcL8u7JzVup2Eq3qVLzlQxlNThBAvxydMILNVHSgZriZUZth7EJHx
 HnROGf4FzCQ==
X-Gm-Gg: ASbGncu1OIS2MN0xTthCkefovdNhqZn8rWG6KW9b4uSuGv58VTlvx1SFR9MP+0chs85
 6Ithh6je+6wIcrC3dgzaZt1DyslgxOWfVpNkPNsYZmLtecj53y0mUARaq0lyFwmojLFHAnkklLs
 xRDFNCxwuV0Ij0916nRkdCYTohF14yN0ud/mcPiP/XQRaWxl7ddQ/CgxLAJmEagkj0onMCdorrq
 UAW2MhCa2QXmge7PD4IMau+M8+rNcjjXIxQJSvK613iGfVcTYlgw5EHXslMRDABxT8taoMF/oF2
 8DJX++z/rndTCKX9+qEUAaTnZV77fAkcZpEbouvhQD+0UnyiLfvgc2OPd+/6OkCZAca8QZMdiug
 k96iXl2Muhb2B33nMOqSUFJR3ua8yy1PuhxeaM9RInM3TkX/URxw13qJJh/sKNNMnwKUWyOr2O4
 SHg13jDOv3XsiEi7TJzAH48imy28mWrPze4u0oTw==
X-Google-Smtp-Source: AGHT+IGu/lGuVYUV3v4JREousNJx3RtYAOVQzBRpajBxqMAuDDq4dkGOt0Vc1IzCgPBLmP2e7uJCxw==
X-Received: by 2002:a05:6808:1889:b0:43f:1684:8308 with SMTP id
 5614622812f47-443a30afe98mr12399769b6e.40.1761335708791; 
 Fri, 24 Oct 2025 12:55:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251021203701.1274692-1-trini@konsulko.com>
References: <20251021203701.1274692-1-trini@konsulko.com>
Subject: Re: [PATCH] env: fat, ubi: Fix gd->env_valid for the first write
Message-Id: <176133570817.2586772.1076272310435107556.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:08 -0600
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

On Tue, 21 Oct 2025 14:37:01 -0600, Tom Rini wrote:

> As resolved and explained in detail in commit e589d5822cac ("env: spi:
> Fix gd->env_valid for the first write") and archived discussion there is
> a corner case where we don't do the right thing with redundant
> environments. This same exact check was present in the mmc code and
> resolved with commit 813a0df27a8a ("env: Invert gd->env_valid for
> env_mmc_save") and in the discussion of that patch, I noted that both
> fat and ubi (and at the time, sf) were doing the same thing. Take the
> time now to correct fat and ubi environment.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] env: fat, ubi: Fix gd->env_valid for the first write
      commit: cf262e16080abcd587f47d0bbc8fa84558abcf89
-- 
Tom


