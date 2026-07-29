Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2533AC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF63480EE2;
	Wed, 29 Jul 2026 20:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0RtFjeVEJ-k; Wed, 29 Jul 2026 20:33:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6B4280E7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785357191;
	bh=C7oaBhUbfbdjjV5nszhtEPb1wM/2jqDKZWtzlQ6wmo0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDIQeGabZHQMaXHEAJ0asI9DjWm+cMKwd+ZBbEtoxsk1ayvqrjv/MqrcSPhP9aeAV
	 r41zSeQWhLjFmKv7AstVDZJs56ncAm8VYZ/cbg2wXUDs2iEWM4WB7Z6+ekQURWGLyE
	 vnMqKZwV764XInLnSu9I3BVk2pC/xVQvyM4+xJqZpJXsy7cWYJmaI/N51AkmeoqGKQ
	 7hgEuXY05Zo0jyP/Es8GAN9zMgqUEFEv6PSiF4vplp/DgCuZ85g47Dm5Y7treLZcM/
	 NXSj36cjbYHN2QHhw2BtyBWbql5/ZJFFuSL1sdZlkvZ6IB02BaR3cwKwbYa9wVu6rF
	 tsF3C7ZeSV8rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B4280E7A;
	Wed, 29 Jul 2026 20:33:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7A1427B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5AA64009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKF2qKIT97jq for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:33:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 01C30400C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01C30400C0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01C30400C0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:09 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso801659a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357189; x=1785961989;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7oaBhUbfbdjjV5nszhtEPb1wM/2jqDKZWtzlQ6wmo0=;
 b=POZQarmK7I9QeKcWsWKsS8HW2Hk9wmXrjlTLArSLnpNJi/sqWP/9ardeyFMFsPtjbW
 SOtLhHAvUnTsSdD39zhfL/3NiY5rRZQ1iO3Qicgw9f3BeNIP+Uk9g08yYCmIcFEzvG98
 MUgYwuHp+Or8pbRR8zKoVog1PsXGxTTQN6icUgq4BGsJbISdZ8EEhL4dF1Y9wDN4OceW
 MAKfPMesgIxmM8S2Tvg1egYFxvXqZwb5CTH1hk0ncrSc+IySOQYNKtGP52R6qUQoAAeD
 QhGfJ3gPbJ2zzgNjTrThwVG+bp0tF/FIgqe3/OiVWmfd6egMbt5z7hHlbhqM6QvXbTPj
 Jixw==
X-Gm-Message-State: AOJu0YyktDt0Y3m+w4uYOibnlqfFGxPhuUtsS5kyHZ4+rVvvN86Av4y7
 Gw2MhzsD8vIXkX3DD1Uv0zQju54Zd5L3kAU+rDIG/uB+c7FdaVQmqbL/LlYQLHohn/I=
X-Gm-Gg: AR+sD10KQ044du98VK6tTkerR1L2XlYyB0T6ccCoj6q19KABS5p4oUaueltGoX5VAe0
 DoQ1CKfWPZsFUJvPJyxmoLWmSdbqoEFIInbFvjY76JMVqqeKgW2X85soszZM8iC02AE+RhNUzvo
 7A/mFA05HVmZYoErTNgqLBTLAfzn7XJnpfCMacz78ier9utSjRDLDQtH8/CTyZf45P6DCGvGQ1Q
 rKNCBYDXyRwI4IbNqlfYmButkKKdNKpNjGLzKd011KOD8Qp6HWzJnMHL5sNFBVwzP7tUoeruzko
 Q7IjNVAWizRt783x3oZ+l+hN1J6VZi7Bbs3R0Hbmw42fdh/3vkj6tgveHtdxfjYWfR6HUAf0t6h
 gilheY448WVJ99PRzXTfsQGStz4zqAvlYePR++cZG0OWPyCfh8kD6Nrt5ei0ZJaaH7yl23M+cfO
 EppAOG4DAVn3i+SDfvvrKEIQq3PAdMMKjOTN2AoEJvIwPtMOBRyd9LBqI16dVDRmjZZ7MS295Jd
 srpwbZT4s853lKYLz8v8npBKATB1LOqyzRBMCTQIADxCuZxn0ExREBgLn6MIuanxAjRQKA7fS+e
 gZXgDFVT
X-Received: by 2002:a05:6820:290f:b0:6a1:5347:2af9 with SMTP id
 006d021491bc7-6acbb75d70dmr34781eaf.36.1785357188919; 
 Wed, 29 Jul 2026 13:33:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4588688e692sm3420221fac.14.2026.07.29.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:33:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
In-Reply-To: <20260707220301.252935-1-trini@konsulko.com>
References: <20260707220301.252935-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: imx943: Update dts files to build with v7.1-dts tag
Message-Id: <178535718781.1975967.15955646078275876678.b4-ty@konsulko.com>
Date: Wed, 29 Jul 2026 14:33:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785357189; x=1785961989;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7oaBhUbfbdjjV5nszhtEPb1wM/2jqDKZWtzlQ6wmo0=;
 b=Lxg2LS3m/DAh0tZLM/XCWOkRjeyM00jlc27cE0DzT4nZ4+1n54eNKsov57tcRx7gid
 eVob653XAbAfqVldJ9YazozMlxlR/RWqril5bfXwFit7aNApcUXpoodszuxtXHDx34H9
 OSUBEITEIP+TCQPEPbvUZA6ItAq76ydz9/yB4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Lxg2LS3m
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 07 Jul 2026 16:03:01 -0600, Tom Rini wrote:

> When moving to the v7,1-dts tag, we see a few problems trying to build
> this platform. In turn, when looking at the upstream changes we can see
> that USB3 support has been included now, but isn't exactly the same as
> in our tree either. Modify things such that we build again.
> 
> 

Applied to u-boot/main, thanks!

[1/1] arm: imx943: Update dts files to build with v7.1-dts tag
      commit: 4a237aa35f8ad473000aa174d319749de452a136
-- 
Tom


