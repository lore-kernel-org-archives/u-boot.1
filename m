Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE257CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DF2881109;
	Tue, 29 Sep 2026 22:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XofGLZvhjBTQ; Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46C12810FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721937;
	b=N8K7B2WcT0zKJ7HLvHx4E7E2At8/UyMIa88B6RlVC5PfwHo6zN5aDuj6dKoDYMueusrq
	 +dePk7SKQ4o/z6AWfDomaUoZ612LJmjGl4AKmioCaUsR5oFhCdlT5MnFGU1RF35HkpNRj
	 cA8SO9eWHCn+ZrM0Oq0+D1P6QVF7gDzZmoZPMGfuGSa0bz1pc8Ock1DPL2pS2aemsDTl1
	 z9y0YxSKzUPDW7Sqole4+bnAULgh3C4f0/GdROoDJMaRPwPlTvGwKFI4Se9/KPUd42wsa
	 /BKxGYLgzCjsojnk+QA9gk6a2co8G5HAVb/y2TyHclTs+zGxQGvfxS7TL9KOlVmnnQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WfrwTiRvWWwuIcxLnCgu7fk/+rsDnlI45vtUGeWtXDE=;
	b=PeMsTgFGZIVizd2U0eLWPTBkKEgjRcLvVSnKgDwOao2Jod2Bkyp8ln88hT+xeCxJ1Bot
	 Fx8A9JqhalEJZEw4ZO+iI2NPm2fdJy/QzOu8xQJviB/Ei3Yvw6lY7mJlJSVAsPZy7xEow
	 tAife2CyMiiFhZqNtBeCaH0V4pp5Mtq42NVoxXH2IwJo86TIutGf/KZOuNJMa+6DctTLO
	 yHkmEP2lA/yhBoVYw7MTf4gMFtgutzK16Py1Gzody5LoG7pgqqv5o1RZ72lfTsbk9Q9a+
	 vPRzDSwsemXHikNTe03D3z0zf5xSb8PLdHK4d/vwphBXSIuxPopjlySK0ysS5xLqS1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721937;
	bh=WfrwTiRvWWwuIcxLnCgu7fk/+rsDnlI45vtUGeWtXDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y03ZVepWAEnxrr1HpaojoJOb5BodKT/x+r7fkRKCzE34sA9uVKogEa/9x/TvRj6sr
	 Ozx1wdnaKWaivTTjGytJZFKR3fVWXr1KRvSTZ6L31QoIFRSU5rec79/9E0zWhi/mku
	 Clijy6iwecV0dD4fVxedRBUQyutbVQI/eb5dG1gWcspayjPqmmMZzXwlXHqHyIAOeu
	 vSjtiFdtE01hU/0D21UCQbEuCcwlJ+ZRfNc1CBrKLjHeeHfZhYUtSVT64InRRT0XUW
	 1plDzEl5Q/KNPhkJzABYIUJ5257PDdrgNc0Ym6toAuYVblc9GbVFxH60y+zP37Pa/X
	 g5/sAje+epcng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46C12810FB;
	Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDFD524E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFB3D4034D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qgnoImNu_Uyr for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D2DCD4034A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721935;
 b=IcZE67ehZ3oIqUeUapgJR4hGMhzxGckn9O6LLsXNx9LxnRRwsXOlrfAzM/1DuBNEKBED
 wEMVeutMMZx5XaXa6r4sUQxZGXsiSf0+iXf1/fJIE/wdPkvgzi67BDNitvJ3yVvMQXCFh
 jAsVAhbLrzwdPsDL6zcueCGgaGWqip+FsgmomkemrSGxlKjsv8LhQjDeG4E5AjQSSNiI3
 3Twauau5VCufptW8BCYKXLCeaVudWQC4XqBaHEq9nkihqplWm5wiYeamAFJrqtiIo2vb+
 Upe6HH+Xwb5Siu8yxaTX+lKQ3JFNR0RmnN1rch22cPtr7s2/oQbmaeacnDkDConKTtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721935;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=WfrwTiRvWWwuIcxLnCgu7fk/+rsDnlI45vtUGeWtXDE=;
 b=F7bRaXkCUolZhdGvTZQWPltArHm0jjHaOUwdg+4xBpoDwFRQjWa1S47kfGgzifM/Hzf6
 ejYMnSGVSsRiaPXP0oWLW5PAdVeGEQ6jlK15WgljBTb+02bSm82lgBsRTtBaOu7p8Nclz
 JmuLDKwGS059gj3Aqo/meHQ9iKE7zzkqBCxobB4YSFYqeujnQxtu1P6RvG1pJQVwwh5Az
 eS3UbJtbRCjKKjKd1fkjkAL1KPH8jDsrSNEPEMatrYX/Rjc6q3E5KgNIfYFqk0zgvDKXm
 fIW54NIpE1EfsvWOUjRXVrl4Ihz8aYMw9B9EKPj0aHSNn7pVl38KCOXQVZiWTUrfVaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BBbbpjoB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BBbbpjoB
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2DCD4034A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:34 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-4b94bb43008so868647b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790721933; x=1791326733;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfrwTiRvWWwuIcxLnCgu7fk/+rsDnlI45vtUGeWtXDE=;
 b=BBbbpjoByy5gtVFIEaoNw3zir0ryntUtHSrPluE0BZ/7TIn/8mT7Kjr1PQ5z29dMk3
 jsKYqeTIhSt/BgqFP+Im8mWMZgVkWLt5TX/UL9EUptbV8ox3LboQ66wpRxIihJs0JZ2Z
 GMWJyv0Bss/YyxdDsCsQAdFfVh+LUXpgU+iG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721933; x=1791326733;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WfrwTiRvWWwuIcxLnCgu7fk/+rsDnlI45vtUGeWtXDE=;
 b=gQsyp8oEuwWNkHp4R13QG4VK5iXJkOdCy/4/loejrljO2Z9eLpv9QJUQF+gXEBF38v
 Jz2HQV9nNvHqP6OkcT0e4/fij4CSg1T2Rg3XhwcXfOD10r1UkO/pUCK3bq/q+DK4CxlF
 J5nwRuS6WQ2J3zSRyJW5P+0w/r6h4+vuLjtGiiIp8NBoPcJKxUO3kvBW8VjuFl32jO+E
 I1Ri5d/m+JK7wVZyRv6HCeafZcFu9YmmjleYWSWFAO3AUE5eelHrcQtgp8VpXEtvtY29
 JXwJV8ZHzxB90C96fb+0TjibZmxvj8u6L6DACsTAYibe514KZL8sQ2mmSpZgseEiR78V
 FyAQ==
X-Gm-Message-State: AFuF++nYlxiFPMT2unzrByBf+wV2wgQnAtkwTA4YURhbdNkm3U4cqMEC
 27PRln85+NJteWgMyW0BpblbRMERkqZgi+EQS0Knl6TM9Q7pkMaBTcxEK5+FwxerzhA=
X-Gm-Gg: AYBFou0vLZpLgj7pfqK+DisOlKcnffwxJwsdJI60kU9Z1b+hbNwzV/MRdqy7xuNK/sR
 15UWGoDVlmzVBh0oiu0p3akiMU7mWjN7blxHhRpdRGYPPRcWn+QpGqfVjJNX25j42uNz42UkrUd
 6/9vFCZocZxF/WP6GbefbKQmOTYm/kVkGsMrrDzPyUg9BCEqc7mb6E09ku1Jcvltw/NZThpHvQu
 sH8rgMuAwVqbuJoi+en6RupiSYZCIYPY7C4I7arrabN7uq+CH0ll9ESxx+zxtr+hjmgMxXS2XLi
 nfY4o3A93m4cTWrh+HHbGwuEGJtEVxc+bO9ol0gfSyn3awQIxy+zuf7CYtaeVcXJS0H9/3zxDGN
 M1B7MP1iwdFZH7QizOFd7o0uLtvYf4BuwEsYStzYp2gQFGFf2IcPvytu+HmDbsu9rBfyNsivuWz
 DEKTCCWCPiLDPZPBxT5snSBHNd5q8YDG04XpiCnZ0UO3oea4GY0Vk3E/deRGFQGub7lbTwbz0KM
 xctXUET7W7dQx9TjM931dBJSvkUhT/IexwUbPduMg+idUWi2kOdyDblHOdz7V7a4t33i44/RDNn
 i4RAVp5anX/nhf26bA==
X-Received: by 2002:a05:6820:2215:b0:6cd:3fdc:a932 with SMTP id
 006d021491bc7-6dc79632d39mr558825eaf.79.1790721933524; 
 Tue, 29 Sep 2026 15:45:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf7eea80sm1159921a34.16.2026.09.29.15.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:45:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Eric Chung <eric.chung@riscstar.com>
In-Reply-To: <20260929132702-GKA27540@kernel.org>
References: <20260929132702-GKA27540@kernel.org>
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-next-20260929
Message-Id: <179072193245.236406.14126636659306184701.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 16:45:32 -0600
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

On Tue, 29 Sep 2026 13:27:02 +0000, Yixun Lan wrote:

> Please pull from u-boot-spacemit/next, thanks.
> 
> The following changes since commit 2b8902913c19eb581fb0d567201c09b8fa46ac74:
> 
>   Merge tag 'u-boot-imx-next-20260926' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx into next (2026-09-27 09:11:10 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


