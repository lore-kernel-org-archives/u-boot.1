Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D8CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E35360B55;
	Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8q3-9qsJNpV; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 276E2608CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463579;
	b=I9ZrllcZhPCGdpoz47W4s9K0CYIbF6s01hJR/NWctZMcfNb02Gamp8k0eOwKCTa1p7b6
	 MQullyc+NuSLTOirYEjhmJ4vVZ8vXZHaWQFJI5SBwombpKy6BUjzjcsBY+jpTb5/FGp4Z
	 qinOqZ2jvxtNtXLF7dAlLD+NfvGa/xyK7iuSRwIGi5SgEZraMsJgu5uXKh/JaQHAqc+o6
	 5oauV1EY6gMSlkhycWbg/i6GLaIR6oC5lfek+88G9ATWeUMwdJVldH5YcygW4uo7KBLaB
	 c1p4UW5+7xOpFitGWvqsi1gHPVj3JjuH530T8jt+kYcceztfPUwM6mTyPss1Z6krfvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
	b=HkeT6X87mYOWROmiGDlO9QoaoeSgfnVyNEh/lUNSUOyZM3Tdc8+5hGs6zo0AcRlqSyhr
	 N5V6WjSVv30iXqxb3CZ6+BSfEMIW5pTctxuYkltu/KFFbOvpL5SvT4qfMVM9GEcks5re8
	 aUKGoLswNvpGYzAlQjdzpz4w2SYTDgtVx95Mb6RilGBbp4LE7fZmcql4mFTNnIFrlTlpZ
	 Hc0GbwOj6CZVLV/accTN9c8cJjTkaSBkZLARVfONL0lHTz/4LSEpLDlkTlarYpIUH2PAS
	 UG1UDZdEDbhjRJLwWSIRcemz5EjSJR+shbrAlzIGvSC1RJmRfn5tMvdniHclozunnhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fRmsjc+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463579;
	bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3/CSsmuWr2dJFW7u4ydJV1wyESnRgRBm36/w9wlRM+lcnFmdxggelvAQVvAIwYZk
	 Q1Laclgdc6DY9BuLBkHI+yPFA6dSxHPQj5F1+RZoYgS/hQC8ltd5es6Q8Q8CsMFryl
	 KVwaDnn3v/9b9ObgoL5ddE6WijEJcZ9uTgnTn8S8vA4ijsSTi4oE+Agmv2nW72ZQKt
	 IbF7VbPmnm9nSyIGH4gJtXvjs13Bx4UKivUI8bsohQc7R4HtxmGzjMd/x5OcAoETb/
	 tgj0+c4WIu5D8pWOZni0E30t8BfN3Bg/TmOzWvb9u6WsKQTA5rTSKiW3b+AKg4ylNI
	 QaSQ0mtjPegjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 276E2608CA;
	Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2EE62E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7517608CA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YMn2TnkjjXF for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7501D6076D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463575;
 b=rVbxJPsoKKN4/+d7It0KaksIe9KmNExKDk+rhjZUepQKy4qrW8kF63Gku54shHvwh8aK
 wODDnXQ2wcmKmec2nj0vkMpQeIpBSviAhypLzAuEYnntiBMlM05OAjkNys6EJtFcN2PxR
 LFz8Qt+KkuloBJfZCZVBXSOzSS8ZAVdqGwJyfuQYgGdBOc6zqBQGGv6pAwWw5EvGc5h9j
 dCAm3uEz3dv6MGqAZCKYEQ/ODCb5VJY4O3vZBJb48xUC01Zej2clZ+b+xQ+XmEWEcdB9V
 69IjUygLeBcFyEWUIxhMIFjzAmHizkjp9XA8MRv8BczkYVCb7+EGVtdobJLggKeaiHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
 b=i7izZxHg5fJhFu7iqjaMcwPass7LqBE1F0h/ZJyYfhxLgtNH/Ks/rankkbPe5ABlJFLZ
 2uAG5BNW8K+8MmVvFKzt0jGsNW9SfI9ABgGc60PELXiTdy/aorVKCcdBcVwy9xixPq7O1
 tuhyxiLsn0NWHoskiIYG7JEQB/Dg/kH9v5gs1dtoVxqbVi73Mg4HVFDk3eqrJGBDdSUJQ
 An0hOKZupHgidbbb9leWzJlKp6yEruZ815DIbclytyhv5vVIFqp8fliVuO+1ZytIV3kKb
 1ZQPr50Tsp6x7fhvFaQgYX0Cnn2ZaWlXItX3bgC5jMqXbiDWSGj0KoITkYNwW3yuylA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fRmsjc+v; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fRmsjc+v
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7501D6076D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:14 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso1982042f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463573; x=1792068373;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
 b=fRmsjc+vW+KiVaysp0CeidYGiZ1IU28ltS4LoEiFA26pmmmBWEA3rjygOtO7fSIhDP
 n372u0bnLABkePkCFKZ1fXAKH+svlFqvTFzOdKWjyF8H3euL67DiC/6dHI/WM5op1/L1
 pD8qHIMMGHKKxSAwGEh/17SHVzgBH6sQQ6prMohFzWUcwNwSOfcWg8PgSrw+mvlF5XaS
 p+fklwjvyhKerGMGQjMWfGtqnXTzAfRd/HSaG/67vpqOozB+R/BvTEAMyjunLDU807bo
 QuVb1JKwBljJ6EYhbpe138LNMja2RFfSPBnyK0bQlmnQXtPGocWQRNhMGe7mfDHCkcvG
 WlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463573; x=1792068373;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
 b=sVdXi6MqIk6V0Z4HGaeYcnMkZrUFqvFXgCPzD/QNPiR9eWD8R2Mo5BVtZgm5UeRoRt
 XKmKv/yCFXX62GnG9Bc925TpZE8VJmIMJ3Gf9rKCA4EBFF1ZclckfRTzrzZ8Rpuchmlr
 VY69vEPdQZ/9bDp+525C19yID0g8dZFNW3eC0O02irqwAOR3vyB6+mKRksUiTL8dhVW6
 p3+qVCX6TjOwKYuVdwqk4ZGIIpougyI6s2P3Nf2zaY3nNw9l5yag7TGzjwA2t+cg0zZV
 vvG0LGJrUvCInIueBcUsK6IXl2arADjR9h1+DLSgYLiVSLpUdOrD4CF7N2/sZ2fdx4TO
 ltqA==
X-Gm-Message-State: AFq9FYIlXU+kL167/K0B/qOc0LkVt1JDgAc0JnuHYhZjYHlXHVQFinnp
 FYbQOlGfEuO3ns5wOxOezi9ZmK2nZkiKeS8baOiBPVZs7KXjTZGgYnjae1E3xn2cD3g=
X-Gm-Gg: AYBFou2qYDGjDTftE7nht+0pjSYRl/4bKsRq3WO2K7xRLwXVgEoZCF05PiB6BT0Sa2Y
 Ej+osw4c9fvUEislqOZ2b2G26GPvDLzhMNIXg9kjvCBRaUYxsg/KOZJrU5xEvwHFzkC44z166u8
 FhxNVEr/ycI38271F3nWZhemmvd6qT5cMkX5O0t/SVa3A3jSeWb4vAIJWukDLxhTugm8TbHrEb/
 wPVGHAgqceQFfCDw+ul/WZCeznwHPalPgB3b6zJsl2wQs2RdWaf1GFbWw3Fgp0vKVc4lnmXfhRF
 bkTda4gzNoltwmJW+5fiRDnvF+6LVaGTxsNdKYOVdb9jtP206i3a6G3IXeYfrmVXEP4IKClxorh
 5Di/TTcK97s8x7L/tqIf4FwFrzOW9SvyLMAMvX6Afo1wytGtTgDE96JE9c6Q5IWQrAnAu4dMnaf
 lbDR7HHxbR8OzKhmswHyo5GSA4bIrfCLTYJjm4hUmhYHkQhIAJdQhlBG2OF4eNgLYByi3HaM07Y
 UBfukdWroARKDD9Tm3Q
X-Received: by 2002:a5d:6092:0:b0:487:91e:d8ed with SMTP id
 ffacd0b85a97d-48c72707e41mr7981719f8f.2.1791463571972; 
 Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260817163438.1893025-1-sanderson@brivo.com>
References: <20260817163438.1893025-1-sanderson@brivo.com>
Subject: Re: [PATCH] serial: meson: Add s4 support
Message-Id: <179146357137.183177.8701598122673179908.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Mon, 17 Aug 2026 12:34:36 -0400, Sean Anderson wrote:
> No new features, just a different compatible.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] serial: meson: Add s4 support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5bbec48b820f79c79c82fcaf1d7c3a25f080abb2

-- 
Neil

