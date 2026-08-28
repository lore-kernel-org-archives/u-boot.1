Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C945C61DD7
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 20:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 049F660838;
	Fri, 28 Aug 2026 20:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4GbVtWyKR7Gk; Fri, 28 Aug 2026 20:29:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787948966;
	bh=Erdo5OWyQEsvk2A24Efd7zpE+agf/wqaOY2Xug85k1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l8V/ovqZkK2gtnQdeOcrVR7x/FeyTbTz+Kvf0ybQGReHRc3vhiA2KCCjwZfS6JE4D
	 fYOh2oxQw/3HuHMmtty5DeF/LEvfzR1kGQcvwujPdTp9MAtxm//KG7xVPQOpGAmR3U
	 oxJxqg8k4kbvFGAR/q0KrL8fAvFcH1R8vVoj44E29cx30Z8n3ZtXM9gRFBU5IXJ+BH
	 GkdJ6CmpthRx1hih4uEMh5VORuNbXlYJi9qZvny8X1g9sKDIVL8n6HuScjJLIoYlz1
	 ZDK/gKDcajo9Pb/k18Q+WLLiXpj+e/LFubxPDJrC3fqhoDoLr2Rssle/9+W1JBEPSU
	 Q1jJw15FwR6Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CD496082E;
	Fri, 28 Aug 2026 20:29:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C29882FD
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4CB240A21
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YayPO4EuboUb for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=URAOa40I
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16A0240867
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:19 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4a483a552efso686112b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787948958; x=1788553758;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Erdo5OWyQEsvk2A24Efd7zpE+agf/wqaOY2Xug85k1M=;
 b=URAOa40I1jqeSvuGMlfg/qMqaOI9FcuQlCHQf/qMzb0EJr0tXb+OcJDRUdsMbYqDES
 uUSu5+6RuqKZ/T8EuHFwVieJ0GaXY15Rhpe8aeTb5g9VZUbV3x+JZgfKGqdOPIdDODMJ
 E6PfQEF3oFcSUR9ZFVvNRT94OmPML1K38X5Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787948958; x=1788553758;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Erdo5OWyQEsvk2A24Efd7zpE+agf/wqaOY2Xug85k1M=;
 b=UzsvFW9A4dtf/uG1jwHYrsXx+VYKDTZoADEWpNubKzloGkQkLPMB6Vtkgewl88GtUi
 KQTkaIX0WqSBS8RViHlyT3OcGVcSrQWoKZyhokcpBQNWIiDag0Z+47Fv6OMvdz2CVXIU
 CvZdkA6oy2htkbUrEODUMlb9QkK9T5KkLtKWfR0ojM7nzlUDrGRP/4Y7Iv9w0Goxi4jF
 0HKgaoLIoSIDONoSwIDJRdM79fx1Mz18ft4tL5+pob4r+ElrUwvW1SCWP53VCr+U6ITq
 u/Hgbac8f0n2uNNJc4njHbYWo8kXujUZPP22Uoqt3iaAbtySvlJekHxA5i4GEy6eS8fF
 RoaA==
X-Gm-Message-State: AFuF++nu2tSRZd/256zw/aLKNjaOwDWg0IPVQNCIDXXXveFzPQZnV60+
 470TN7YW+c5Tci+tXZV85ZdVgoQWdZD6zPlZPXT/W5rTlUMJParhW8YbLyZj1f6FoL4E8GJUCJq
 Pbk/q0cUcjaFl
X-Gm-Gg: AR+sD10gFi6FlswM8HoDANGDNXLVvKM1ja9gzE5NVNEGpzdjKR0wGaEgq8XMPkAmFmP
 mMygqApzGJCmf9gpEzrNz1Xk/R3KwNIXhyRHSd8aUph/mzEbECqXA4YCCL700pwUYvtfV8VrkwO
 icWc2KUs0UXzUstWT1f80p5HUsOIbtnV9sQNCT68+gUA8HfInYJAUYBQzbWG7/864dTBXKyasja
 AqezPtJCGz4mzNjlixnurApaWmwoycfrDESdaEg93ND8AlglaoO8ewS/qhnZ2BXXHzQNxeS8HmP
 CVUZOg3BsHwen9xJd+OAZMFWKAWxX2oHRf6/K2gVvuRTqw/doofq1mnb9kzRIf2JlN1cEADQRz5
 jnPFla1EKzPMtN98IEJMY1rB08AhaqNtWhdcP1hazaVMzejE2sO3Ndw4TF6xyhyJVTrgeA0RISy
 p424BYJwuRsno6rcR2LPPbh3Z8lWUmLgUS303A1Y5wuAUA2y3xbpXmV+Pe/er9ZvOlx+7bWnw4v
 xaxSf8noJThRtUv5BrY7o9rbp5j0uxw2NHxUU495hkIiuM9mwJ0hpmjtPnsMjgHgtsd7274Qd51
 tnJ0uYCX
X-Received: by 2002:a05:6808:199c:b0:4b3:8bd6:7e61 with SMTP id
 5614622812f47-4b39809983cmr11425220b6e.8.1787948958417; 
 Fri, 28 Aug 2026 13:29:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995b83sm2100578b6e.12.2026.08.28.13.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:29:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>
Cc: Marek Vasut <marex@nabladev.com>
In-Reply-To: <ef549c4de7c2fb98e1e8554b5c7af761cdd15031.1787238864.git.joerg@jo-so.de>
References: <ef549c4de7c2fb98e1e8554b5c7af761cdd15031.1787238864.git.joerg@jo-so.de>
Subject: Re: [PATCH] rng: Fix build with SPL/TPL
Message-Id: <178794895697.264202.14509506244721131398.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 14:29:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 20 Aug 2026 17:14:24 +0200, Jörg Sommer wrote:

> The inclusion of the drivers was wrapped by an “if not SPL/TPL”, which
> always excluded them from SPL/TPL build.
> 
> 

Applied to u-boot/main, thanks!

[1/1] rng: Fix build with SPL/TPL
      commit: 67a095a6896828056e4a1a0ba0e9bb20f5595c59
-- 
Tom


