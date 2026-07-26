Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87492C531C9
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 18:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15F2F80CBC;
	Sun, 26 Jul 2026 18:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25DbQNtxm1W3; Sun, 26 Jul 2026 18:57:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82EB580CBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785092264;
	bh=qOyC0s7dHM/Eta2ZnRerp6NwAAOcFPjOEEmo0z8bZ0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F6jiQMkP0KJes4uL/qxFRFvAAXEpK2PW5IwXrqEyKuNk4r4d/MJGUw1fXUjeGBfdN
	 EZ5ohFXsu2YA7wZRJTmZKKfu/Io5zpjY45HmVPNpVyqvsp1/BqEFOxEgPrvn67pRpu
	 ACTxvOTwiKjahAV9n37YdT1aLqpECuFMJDcRA3AVujqsIoks1l5/KWd5bfi2Vc/adp
	 TAyhmwuxQwkuHJfQxEDdIVYKr+5lDe6YRffWamwhUte2J0W5cWVpFRuNse6hWNXijF
	 2ZXP7ZGaBuX08j/lmBhoPPh1YNHzclnKXwO9+uPGajf56gnyj5qva8IS/OdJaJCo0p
	 YTZmyXrW5SdJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82EB580CBD;
	Sun, 26 Jul 2026 18:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8F9D69
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EC8560651
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yahsDhN2lrgv for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 18:57:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D390160601
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D390160601
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D390160601
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:41 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-446f87b6de1so1007643fac.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785092260; x=1785697060;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qOyC0s7dHM/Eta2ZnRerp6NwAAOcFPjOEEmo0z8bZ0g=;
 b=s+4h0Gii/kyGjDDtxMTxTE5fkHGUfSOMZjBgE/WigYTzp7oEaRTHzrQbv67ZnO1c6k
 1nMYbwSnZH4EeOjaGI2NxPYdQ5N8g+G4QHmFewtS3PLdbQx61+gSlkYSPnpK1xFOSqKQ
 NTych2M1SPBAYc6f4gTi4BhUmlgnZR4mqrLUtbUrKE6D1unhpKkiz5stqly8aJh7+GbV
 RnjxAk85kTsqBspWzncyDltJcFbhw7xTcX0W869R96eqpF0a4e9aHBsX+qOgJbnqBCUD
 jRlZMpTIFzBDuxRs6lecwFTtNZOa3eog70GqFEB9s5PMxA0aFYearvbe5QeciZA9K+m/
 rv+Q==
X-Gm-Message-State: AOJu0Yz6faXPSrYVIbSddi8bHfP1h5uzFQ4DB2K4puuIu9RUp6WGFRTo
 J4qoKYKHJTbt57mQrb1QpsNTUFD0HCp7gb+afxEaYkBfaqu46GfrSUoTT4pdeMkyhs0=
X-Gm-Gg: AR+sD13BR52wllQViyDJZ3pPrG/qKIBs8WpP0lOGan0gcGvrnrBaFiFNFgvXxtIZLvH
 0OlliESeiSTJXbf55iCBY/38XMKLQ3NXKAt2T0aWB7OfwFbhE5dE5mOs7hPk5Xu1vjMtclohOUc
 ZihBwQsIaV2neeDv17r0MOEPl93Iv9DtCCFp/TQVpwcDHoURtC7Cs08tHiA5VkkG3oClfjOIIAT
 IqPlCojvgoinbflU7nk6UHniqqLxSd15vVzdd5rOOxntrczo0InZsBSEZWgaSnAXU4fOsF1Ka5y
 Q8iIVDfrabtGei5R0cc9s+UV5RH1hOwfQ/A3JAM1jSHehBH8e73YiQGtj188qiBuNTLBpvErEGl
 yB1UynjZU00Tptn+/0gd/lxd9aeM8nhInRzanc6awGeiUD141yyygcDQxkWVvWek2Pwcuky598Q
 HYcYVtlb6Xr+rDdN7DFIVsko4XMgeWb5JDHA3MbWOciLxOQV8TQr1Z7lPXsMqcoJFrshglyaSVG
 p7IIsfkOWHxWMJtWvUYTN6fzQ==
X-Received: by 2002:a05:6871:3323:b0:448:558c:d8b5 with SMTP id
 586e51a60fabf-457f28188damr4778465fac.43.1785092260578; 
 Sun, 26 Jul 2026 11:57:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4579d805c95sm10603029fac.0.2026.07.26.11.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 11:57:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>
In-Reply-To: <20260515145942.133279-1-trini@konsulko.com>
References: <20260515145942.133279-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure CI: Drop Windows host tools builds
Message-Id: <178509225918.3930745.12606454329456177669.b4-ty@konsulko.com>
Date: Sun, 26 Jul 2026 12:57:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785092260; x=1785697060;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qOyC0s7dHM/Eta2ZnRerp6NwAAOcFPjOEEmo0z8bZ0g=;
 b=c1uQczT8KfnGsz5SX0Elm6/pTgQmkObD9Si5bOfjTRAqe5zTNwNvOq4Em7Jb/xuvS4
 FVgfKZgexqS6kZFz07E/xO+svT/w0DDEXRqkT9r5zaJvGpLllCxIviUbq317XQx/5AhY
 1+FKJ5reAIAF84SyKhH8vT9C6VVk3SyHcHxNo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c1uQczT8
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

On Fri, 15 May 2026 08:59:40 -0600, Tom Rini wrote:

> In preparation for being able to support more recent OpenSSL versions,
> we need to add support for the OpenSSL Provider API. This in turn isn't
> something that MSYS has all of the required packages to support. Given a
> lack of user feedback that these tools are still used in this manner,
> remove Windows host tool builds from CI.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Azure CI: Drop Windows host tools builds
      commit: d99ad807509dcb7197a33261a269b5144e5e4acc
-- 
Tom


