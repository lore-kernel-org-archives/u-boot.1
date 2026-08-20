Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41979C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 22:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C656040812;
	Thu, 20 Aug 2026 22:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9wdbmy8C-fM; Thu, 20 Aug 2026 22:27:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787264851;
	bh=7a+JFgnp6O6nBFQvT7XJ4dim1SeSYa//got8EcRbwW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vyvyzaGZCvhJ8w9LCIYRVCdO6uWyqgx9cuLLXkEs/AvLZuTdzBnbwojoIONkCgIce
	 UK0wetVebw0js3+O/mADqEP4+V57Beqjau1QA6BBTIonLOnivTqvMiRgsdKK+tkUW+
	 NqdH8ziCBRCehgqntq+icZPbPXJJpT2JSp1Uz18JwgMgQg1qDJ6QZtjeKjV9GLRi2z
	 ZAi/FJM+QLlazYtqGBeM+bdm6XK3+KerxPBbSOAtaguHgzseVEnujtQyoZJ+KQim/D
	 raYWDBUjfHqUuRjUpPzFErnmJ3JBzL5X6ezPYBeWPNLEnRuzsmE3zov5CfyxoGEXEM
	 lfUDTb2+Pzmjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07A794081E;
	Thu, 20 Aug 2026 22:27:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1489336
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 22:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E07E4081E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 22:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUoo-FMS3q55 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 22:27:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PMFMHY7w
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6B0640812
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 22:27:28 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-45837e52d8aso311877fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787264847; x=1787869647;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7a+JFgnp6O6nBFQvT7XJ4dim1SeSYa//got8EcRbwW0=;
 b=PMFMHY7wOpNJBWpGvQ+9T2pFZVtyTjYJ+xw4Heexq1l8Qx4ikcgkvovTCuApD7bmG1
 4Sf07yvnJS/lEE2nF9vNv9ei9Gk8PfMcoCgwJ/OONXS/tVrdnuLSzfL0mh3vkg2rQKcW
 G4qDL8OIrKYDrSkBHoSO26E+TKZhrZ8RFrShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264847; x=1787869647;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7a+JFgnp6O6nBFQvT7XJ4dim1SeSYa//got8EcRbwW0=;
 b=WDmDyutaYZ9aNGPJ01SZ9TgLctFUQmxKXA8Inc2aJf5VYOQ+bCwmhbB0DJ9QdI4MBI
 lSlfhxqHqkgZnx+L085+fLdWP7ifmdrzxxBbtkxcGWU1X414V/VsWHNpPgj1gegIH88V
 VEdqP+Jo0cF4FptQZfHJhl/gnoEOrx9NliRjBi7RjK2bik5Pc7MZkh4Sm+p6TQRSN815
 5YhlkB855FCJ+53fJcyIVbeQ0NOGTLmnD8SRzMzG6HhHkd3FmDXz7XU03lR9Zw4rReSf
 qF21y6/oWGe+SgKF5ULy6Ha70WBzGNdP7chW2DGsY7fNKSS1eAcdNNyOA3G8zWEFvjWt
 h7hw==
X-Gm-Message-State: AOJu0Ywl6JdD821RgHL/ThXVZsiqmxvGGetyb9qFUqhAguCcGXTGImi7
 TN3jhg2xTrKKNN2jtfnO7Poy13tci3kGr3hZa8soe6mF/mjwEUFfj4U3MPeMOADo0mVkLJXQ3No
 CjX6+NWGq/JRa
X-Gm-Gg: AR+sD13dR2+WJybxNrqvPjzkWxpnmZkSzGmn0S12I6cydYHD7N49k9hP7aMdP1kudVW
 BJfMFtphSU5+hSui3W4UXHXMp1gIAuunQS8WRQZnfSjZThCQcwiiZu57dVW2XhYIGavebSliwLH
 LcomqlB255eElUWI7wWolSEIyGauaqonhsI9kW+1mqGl3nud0NLvSeKHFviFAQnQqUu5QVxCkLf
 rAEomT2A8RmQeJsaEgiLsCp+VXRNa7HsB6ipJD2LmlI0t4MrdcS8juwVJrz+hgBuReGRwgd0Jsr
 aUqGpIdq6ncH33MO4weZDa3FPH6BJIG+cFcMYVUlOLXMDCB5JMj/S0zRKDagdNzxdQNZ5fZevCZ
 mASoecivtoUQgLydZ4B/HE4V0wo+H35U0PEbg9NQOsMdW/aapDzOI4i9wg/cSvBw8kPV6q1Hgki
 kBBEFti6GAk2zAV0KRXgV0ex4qyDLEU/3kge41X7eV1nlmejRJeC2azEi7iEdEBu/jvaFoQl2ix
 2VsIEEyzcbejvSEswnDNJMg0L9y7A7enbF4+tUgwzSzzumE/Ga7Als4BE+gxKdPlitPxelobv+c
 vtJVnL8S
X-Received: by 2002:a05:6820:c0d4:20b0:6b0:ac70:f741 with SMTP id
 006d021491bc7-6b1593b6cc4mr1650467eaf.28.1787264847346; 
 Thu, 20 Aug 2026 15:27:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4632a9aad6fsm2537945fac.9.2026.08.20.15.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 15:27:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
In-Reply-To: <87jyplgrxi.fsf@kernel.org>
References: <87jyplgrxi.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20260819 into next
Message-Id: <178726484633.2281898.5393183074558369196.b4-ty@konsulko.com>
Date: Thu, 20 Aug 2026 16:27:26 -0600
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

On Thu, 20 Aug 2026 09:41:13 +0200, Mattijs Korpershoek wrote:

> Here is a PR for next with the following:
> 
> Android:
> * avb: Make the AVB root key source pluggable
> * avb: Add OP-TEE root key digest provider
> * avb: Add board-specific root key provider
> * avb: Update docs for root key source
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


