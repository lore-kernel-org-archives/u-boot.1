Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9B0C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 22:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A43881127;
	Thu, 17 Sep 2026 22:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UF59wJMcKQvX; Thu, 17 Sep 2026 22:39:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E57A8111A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789684776;
	b=QNEjHyquoe7K0vHQdypnadw2bVHnMkdm/7Ni48tYrSUlOeEDKyW63ba9e4fVnoQ4z9lp
	 GoRAra/ILOxd3AU0VjTqxqT8M1KlsVsjE22mUQWHA3s5B13aprutB5ztu++8Q7n3Ym/+Q
	 TomM96I3Ki4A8bUhnnXOrnauC7VazRugsPz2ypfB6EyLwbwa/chRtNe5qs4ra9nN4gsbQ
	 /ZQUBs1q4tJSWctN7MVdDFriWj6J/2uGT4T8MYjhWKUq6l4U65Nnq/teyAVK5QKHq8hML
	 OJB8d1XX/rypakTIVQiybjXlbsyhw4xXbb69uJqIGzlVMcYj1ByLLR9rYjeb95XTB9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789684776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Q21eM5yEHPk7Y8NxYsXmicwR51uP7gTExl3uM6aKWFg=;
	b=A68pq5kNFqkunUVt3ySMOyrYyp59dHzmFpP9JGYKxXDsyckkPQkmNCdQ4wnaKiIBg006
	 e1pNvneszG2zN2D1pOZWyrzKwe9g67NteHlvvXMlBp0xP7ydX6OQ44HwiKmTP7yxHL2J7
	 qyAp5aCT5nRJK77iATdYUZYkmEKbntgBYvSUfQKCHuD4TrXdz/EbQE29dWXppBJwEx3vS
	 YLc+iNihR75VGf0kwZRTEyuOocv1MBhE6whEabW9CvcBeBSILLal2cnLrKQkVhwSBwEAv
	 D2PHkzn3G0OWXMffnrmbJ7Y8r25eWxGXLE8QeDposOnhLFvWpB4NA4P6q8cnqSj/YBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789684776;
	bh=Q21eM5yEHPk7Y8NxYsXmicwR51uP7gTExl3uM6aKWFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3wbL2OhByVw4MVdm832unBs7A4tqD7tGWOcWURxc3PztVbaWZZbQpnhCAu1X32qr
	 fBSiKcfcf6xHy6lNRmCXMO6Qq5LRUTTU+hqxEEVyX9qKp5BnlElsIGUyGlyOKXx7T+
	 WPtzp2yG0psEZBAitOWmGOrwQfxo4bCh25a9a5/GqZ5Q/TSC7rdU/wuDI50bkFvfA0
	 wQND3YImmx1kVoQYqC6XFr49bpAXQrbBVd9NCaYZ+rWDkE30p1YUDYbBbETa3f9JxZ
	 DSxsdW5bE/Mthv6uUypCZA8jZWgqFv1ORekkbXaEHhH6SIBtAodjGUZcXxlZJ27Jn0
	 /fXuKpAYxK9dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E57A8111A;
	Thu, 17 Sep 2026 22:39:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBCA613D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD76040856
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihHeygUzDVHh for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 22:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 09AB840858
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789684774;
 b=FcmHzjn8fCVwsRjUHhTKWPwQoVx4D3IsHQtpZ+rQ2QLbNP73bWjcm/BgDoK5NTBDbQ5K
 GO9J387pXHrPcPpbngryXQuhMj3krmSszVZNeHgb9eQzkVW7YD8I7tomtn2O1L4B1CSyf
 7/0Gsoc5j5b1l4FDuh4dXFhKdwe299hgNobOrZoag3EwA9onhD0LBthr2bjLb0fkf1MWP
 jb4hGiJpnLZRaLn9uB/YiWjnZkYPWFAwKoGTpj6aw+tcdYs7RtFoRwFBh1JbQX1j+upO4
 FBg45Ng12ez9nox6yrFUHCDEBhw8wW5I9U97P4IpbYGoa81myluzY1C5UtDduOEN3FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789684774;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Q21eM5yEHPk7Y8NxYsXmicwR51uP7gTExl3uM6aKWFg=;
 b=NMxoYhx5BKPrZBqoZTmhzbOtdYC5rrcbMoH3Gn8dDY8Lj1f8dAWLtQhhu9XA6IS/2mZk
 0j/2NzSpM4RjEw7xZWLnUYTdHapmJx/3hiccUpijRupw4xbZufehjYeYINng8S0ozbr2c
 znoz6k4/s0f+FrS+XxKN6LYIVp4Ep2BCLg4BB6QezNbgoXRgyHC3Kc+J8ug9UKnEva+V2
 MhRauYojjPAs/+X7ERteNiaBTnhnz1HuQBn0g99iKe8T7bOPNVwx9qZWaS/+HdUfTFoii
 wekNpT9OFgRQepo0PX5317ted/8CyLTaks4WZktWzizLzZBJ6aMx3s6TeeEy0cIJrhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sw3Cc7pN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sw3Cc7pN
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09AB840858
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:39:33 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0cfb33cso61386a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789684772; x=1790289572;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q21eM5yEHPk7Y8NxYsXmicwR51uP7gTExl3uM6aKWFg=;
 b=sw3Cc7pNgW8vc9pi3Jij871WSG2xO3FWN6Z5mj2qk0TprSXtGPz3FcPkSzddUum9ES
 cpwP3bcSWhDjQp14Uo9T02mVoUY5vR19qSyfnsl5qLzHn/Uqr/PMQFo7R/EtrodlNY3G
 eRN9hwhqMhN/bJQ9On6TYwtIY2rqvMfAO+PH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789684772; x=1790289572;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q21eM5yEHPk7Y8NxYsXmicwR51uP7gTExl3uM6aKWFg=;
 b=sUxvEyk+TraEAuRMZszNG0mhdTV82LriXvkEQPOXb3sBdKDCDNmqmEpb8YmEdFS0eb
 PYDzQrNXeiZcc2aZvcyTyNeBkjHA3vk754dTGNy6LMh1n1nftYzDfR0rbbb+JOUNloHt
 A0k9C6R0jWiTkWjT4L84ZVWTC4wIbDaxnjR5+VQhobfEupEz0i6LqYAWHZhlEw+IDqMK
 h/Tz76GEvItmAM5AeWGeR8/mEI/llE08E9wJg2jMkUAS2HSFU485SK9Vnki/IsE67DXw
 cQcDYSXfjbWpDz40oxyY0rI9F5pLgYQW3lpaFF3kfBMvIXRwSSZa+mZ46ZZQWKkg8Oco
 9ftQ==
X-Gm-Message-State: AFuF++m+/QT3IiEXB2UNTBOxYqL26lYi+7afOGrhEJZSvA1sZ9MF9gXi
 bC7PFEzMZkuEYkKXmeHk+WSZONVbVSKA7a0eRFoqxv7G5rdRSI58JPXqSxgQpJXe2mmA9MGq8kB
 E/qqNitnKsIZS
X-Gm-Gg: AYBFou3dIQ6b8KygCb8IMAopFB4kzppf+igEK1C64p5WXq6emOcVVBNPRQWC2w+HvuR
 YagXxMKtoI4iGn2n1iV22kt3K9NgCZ8JJn90bl8uHKqPTYLt90zAHNKNGRH0rK2l6vaMS+9gyXE
 P6bAbqieWlfhsAHt63TQSDCwO29fn0ELyhTfHMXEZ6VS2TLwWoCw/IWFWMUq/Efit4dBFLia1+t
 xLAmpw9zwsfALVnT/KtYCc07VUCrMtoZqOp3yK4WWC3qZLm3zucu1lYDFtxNaOdb4N0PsjRIuon
 38Hyi6oN2YgNBItMujxiPXjT0Z4DAC1R7EpVxaanZ3SbIfyo2cDMLFyat9mmqgXDztGdPN7t97H
 jj2p16qzX0wOV9fZnAvjF7tS8gRmBKygy6J8czmu395NmewULlR0jvV0qHJo+gOXVaws5MTWCy3
 ez28c15Qax6/IkM8gonIsuvw1fs1IwByh47Zu8uyGRZm14Dy7NllOgtWT4cnaiCW/eBgMZxN3Vf
 BvOljpXNBj9MuHQYBwiCzCStnifHD5oe/U5ha5opx7aLrbRvEApEURbvGHkvoBK/bWr/6xtHlCf
 TvHpAXr4N+S1W0PmdqQ=
X-Received: by 2002:a05:6830:4905:b0:7e6:d384:459e with SMTP id
 46e09a7af769-80ddff5b5f6mr752256a34.3.1789684772645; 
 Thu, 17 Sep 2026 15:39:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c4669b120sm4393123a34.10.2026.09.17.15.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:39:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20260917223315.1569767-1-trini@konsulko.com>
References: <20260917223315.1569767-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "Clean up emails from non-existing domains"
Message-Id: <178968477170.1571038.13184433242593799211.b4-ty@konsulko.com>
Date: Thu, 17 Sep 2026 16:39:31 -0600
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

On Thu, 17 Sep 2026 16:33:14 -0600, Tom Rini wrote:

> Marking boards as Orphaned and not having a listed maintainer causes CI
> to fail on the check for defconfigs without a maintainer. So these need
> to be removed, first.
> 
> This reverts commit 7dd0d23b9c27605198ac9aaac5b62a3a352bf5eb.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Revert "Clean up emails from non-existing domains"
      commit: 211de43d0f954a00a490220c1aac9db298287c40
-- 
Tom


