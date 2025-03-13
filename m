Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C90C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF68819B1;
	Thu, 13 Mar 2025 23:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T1GWg0iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5586F817D8; Thu, 13 Mar 2025 23:44:30 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3756B817D8
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c55b53a459so150916285a.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905867; x=1742510667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qIC9m/1CEYgsD4SJPmG+r30Rqv5K2fJG4aSKx/miBXM=;
 b=T1GWg0iys98LZOafvigdPTycoDl+fClF7/xG+PLFMNzwvITyPt16JDtRNbb/ON2QkE
 BPyn+dFzpOELarbSYhLpZP3kZThjw2AjnNn7+wPw0Z1OEohilM2F1vrSErJVGBwbLKVB
 oWt8NwnC6xdaZ+MJ8hvBTTJDu4+jiGporUshA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905867; x=1742510667;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIC9m/1CEYgsD4SJPmG+r30Rqv5K2fJG4aSKx/miBXM=;
 b=rLF+wljjtj/WsT7vMBsj+fF8zcX4GdW3ZgmqyMS0gtI66qyZdxPLrrPFpkRXZM53d6
 Cyob4jjd+id8tIH2g42Vf5WZ3ni/skS8A3esXPSJ9HB6ndvjftQFwx6cjTAq5PFrahXJ
 8FBwT/tp+OiyyVBne7irNYJm++prQIXHfMAA0LNYT7QiT7yh07TToepp16xGcqb4QPrX
 NhCJRPpiFmchqNOWRv2jF9CRaxHRWZJWAtVrk1PqsNXSm44Ad1o0VoE1RwoqpiLDHHkD
 wYdayjLHxHRtbSZNAtL5VoWl2QI8AR+OADUsUoOPSTZV74KE0OmUhcdK3uMUym2YUvHc
 0X2A==
X-Gm-Message-State: AOJu0YwEE4bTPqYolqoAWcAwd5A9mRdcVLY0zFt76Zcney7PK/CXV5BW
 FtgMOmGIBezzsJHlLdG/NcmyzABjehBWW7aoNtbnOnckevreLUcqyvEaI+W7IOIV1rW/TyxTVDU
 A
X-Gm-Gg: ASbGncsWfmHds+g7pJrRof23RfGodSjeDxMWI8hJg10ZzcoxW0uyvxIt3CMb19nW2Xs
 PkQR4i5/+BoklNn7GWjI2BRggKTP5F4UMBgtiuiAAEq8jrI7n7npXSwP13RhqRN+SZHCOTvLRUJ
 jgpsPupAhrPCqSrFvcxzVi5vFqJjpYb9xpJ6WVltEaToXgDtS3i1A7p1FMv379NqmUdnfWYD29c
 fhUiPjPkpqN3pqWWVFBo2R5vVAP+HJTwrmOSLrx3tPrL07bYhhb9CteM955BIHX+kdWWRuegb1r
 b0kBLkbhPmf7YIhscGhmaJIF/mVWqMi8I//Pe810j/R9
X-Google-Smtp-Source: AGHT+IHUMO3RE/4p7z8WQhjmHR+vXyBRlmCXB0oxpVIfQp2++rPMdD2CZA7C1bugRNM+QjIIqsuLJg==
X-Received: by 2002:a05:620a:8004:b0:7c5:4738:8a18 with SMTP id
 af79cd13be357-7c57c830803mr18135685a.25.1741905867147; 
 Thu, 13 Mar 2025 15:44:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20250225135327.33730-1-ant.v.moryakov@gmail.com>
References: <20250225135327.33730-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] lib: rsa: add NULL check for 'algo' in
Message-Id: <174190586514.2150240.1534506734905191406.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:25 -0600
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

On Tue, 25 Feb 2025 16:53:27 +0300, Anton Moryakov wrote:

> - Check return value of fdt_getprop for NULL.
> - Return -EFAULT if 'algo' property is missing.
> - Prevent NULL pointer dereference in strcmp."
> 
> Triggers found by static analyzer Svace.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lib: rsa: add NULL check for 'algo' in
      commit: babc6eef2f48970f394816c955a4a7481ce8df80
-- 
Tom


