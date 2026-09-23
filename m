Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC0C9830D
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 22:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD73260B6D;
	Wed, 23 Sep 2026 22:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ovg039fcmOmv; Wed, 23 Sep 2026 22:54:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B4CF960B21
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790204040;
	b=tfPYRrClMx9/kLHBQ9CEIU6YPKQyeNcUXZvsihJliRM6VHP/3W554zMkm3uKOll49CYv
	 SuQ0ySdclADJCgT7L31MAOTVGRNy/u2iw9FpR9WHJ2VjHWQ6KndV3Iq6BFcSflDBq+8x4
	 Lyet1gedt3igQqEAohhb4ZhbdaU2Dy1j2zgMxx5JvGrQcAAY9vMLG4YpzmnClwYGS+O34
	 Tq1zvDz6HgoxKcxkC964SYlQB035ajtGHAs0ZmcTBu2EbogTIIFi9pZwwEtDhS01zs8Xw
	 yu72T+BeFimJpHOnk7YghVqnq39ShWVMpbmMJlyrkwU55xgF5strRwzHxNA9xmhqm9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790204040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6smoK3QmN64EA9vfcZjy7LP+znJv+LlJdeQo/Wv15YA=;
	b=j6Pg4o0vkEbr6w7O8g0yxS4byj35UnRI8WuNBADDGbINcAWrFtDaueSRFfNfS6xUmcJE
	 ar1sGb2Dp468FjiO+Uy95bv/gvp4wRB6p+c2/cVCvMik06b3RXHYhJpBbxt/Zjr6ZwpcA
	 4nMjNTw4sJCa/TX/hS+Upyl2bES+a47VGwLrwNTAaYieR+rJvPO1kb4jAhm2PWWMU6IG3
	 c9i8d8myHsYlRKWvqH/621dJfpcDmZ1Ci574h+IvEVyYFenH7cswCSIK3198zZJINdWPl
	 dd1RDygZeuCLaclbXsruqOVc/EqmEfQUWOyeG9eicHjWs52z3tzdG4fcV6OfbMeO+eA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790204040;
	bh=6smoK3QmN64EA9vfcZjy7LP+znJv+LlJdeQo/Wv15YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFnZQiQG/+nyNZjtutS3oTGeI2ri70Kr6jlio0M1Pe18Mby3Ii469dpBAsA+UqORO
	 e5yfHyvDDBE87l+7qfD5BeGXEAWTzjlrGM1N5+8+Z71LJmnUQtCfng77U76aNcR4Qd
	 2Y8f84Pog7chUglMsNEXgzQ5JKaoMZvT//1n4FdWIZZpnKDjggESdHEDWcUB+22ktU
	 6n0K4lI0NpZ43vuEyw3/kK0mlw0Vwl3SGo9rTznXVDglA0cvlj74dpeYHHTzBvwj3i
	 OULpp1A1cEBEwUKpD9gPlybE+dvNyyy8zCYuTCyjCDmbZZz8IEKrxVDhTorxrQ+hWS
	 P2EEoILs/6sTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4CF960B21;
	Wed, 23 Sep 2026 22:54:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 680E92F5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FD2C81975
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3-zHdlunqFvD for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 22:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 03A2281971
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790204038;
 b=MCjX4rgUAytgTkrG3QyRHqr3Ie7IadKcQb9IHVRbca5ci6gdpj53LO8fFnzcu5CJv+tO
 XOJjVCs4EujlEERs6LrARXu5KmjHmZsT1kUguEFHXeB8j8hNjO8uC9JfIvIJ+/aAkKJaz
 UEHcUyiIujx0aR5aeY/toHvO3qaZw7kvX0tCasCS8embQy0MEEglDXUSe180ZZtiz1QKQ
 /+BoEmadFkBSgjkQ7E7zwiznqRGZS7DrQBZKFnMiu6FaLmmdNpaMEevdpJOPFWZXI5v90
 aOfbRsflS0C5NvfyChXRpXXAXfogplNLfC3/g4BRbM2b0WhqStej3ZDNrmpKxBQbBFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790204038;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=6smoK3QmN64EA9vfcZjy7LP+znJv+LlJdeQo/Wv15YA=;
 b=cZx4tmgCPqoIbO3VcuUoBSu8ucjlsFzcTBTmZ8PXbqMTgM4P39lI4zeQ1iqbtmf++f6i
 pfAKiNJfD0D6mKwsPvHMDQSClFfnjS1PpANos73YmgASx0q5lc+f0xZ6t+6Z+zCKZYAtn
 QtAJY5qqpO74s8g2IPTrD1Hr0YOvmQnomODxN0Yj+20zEjUyBMtmFF/o0aql5t9qYiPMP
 vA1uFQAvLdlKQXjCj14+kPPdbcN/CT4F5VsIuTLAnyf/5s9nce2dR04cmMoLKA3YuT9NQ
 k5w2MAk32sffwSceze2EKLdFt57modjcfuG6qeztg8XUDxTkRyN09YSLlIqhe3FgOyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=P6gInZQs; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=P6gInZQs
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03A2281971
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:53:57 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so16171665e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1790204035; x=1790808835; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6smoK3QmN64EA9vfcZjy7LP+znJv+LlJdeQo/Wv15YA=;
 b=P6gInZQsIZMKFpuAgRirhWA0oVZuij8yVqbPe0aLQN50oqQEiYRrG7davB6cZCo0vZ
 1M36zKuA5OJLrwkw5PWIH8JwxH341tF+KpZA3CaiGELDr3ayWpmeLLOKOb+dGHhLHNqU
 is3H3b7xzBpBzwtH1NfsZewnW4FNU0Xe77Un/krFtW1gCjvMbC61VozF8yxPVRvJRRbb
 3QJi9cjInaEAblOhfNjfZKxeFrAGnGQqCNjyEfsQs8KVrz2oRQpCps9fKg4dYXEtoFfc
 2TDUF1vs78RhQmIpGiDXeprfetot+UwuId9Zmom7ZoOFRcE4t7XrlcXimLDswAb6opy3
 lKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790204035; x=1790808835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6smoK3QmN64EA9vfcZjy7LP+znJv+LlJdeQo/Wv15YA=;
 b=ZX5maFKJnqZg8l8uMNjBQmZq4iPEBDQ3MJfAw5R0Qd7/UsR6fC0WB6BGtEACNoKJQR
 R7Y/cxNZqYshsz9XkYuk2hkaJbiPl5wKw73jdqOyarvhpTtdA9IFQiJo5XM7lzXSVPKC
 uLzAUitM1A5h5iwcqScnrUFWHkWCZSPsIYMiE7EgsKiJAkPbiSi4kKHuFl53P4hzSVHN
 p+bf8RGO4hC04mmcbEDw69Ee1ZsICdoP7gNvbONXwjwUEMy3G3c1Yiz0OmZHnwLHe/Pa
 eEOhGw6hc0SjJoxVOT2MW+zdFG1ID7DKNP9+CuqK0mr1vC0zG8sp8f012/gtV5aws0NR
 ucoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWbN0n5prU5NuL64NPVvkOef01FKFQqk0Zzkk6Z47pkP1CzA53Yzs5TnNq2tW50Yss/9HhrrY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nRQd+T1Vf9K54YezJZ9k2COfkDJJyqRl5TO9QntmFL7Mj0mH4w
 XbWAWay/goDMo9Lm724g0HBIt5e3umPxHQDC9mW56Q4ztfCGzTERH7EJHKsw96En20M=
X-Gm-Gg: AYBFou1DDEEb0mdsXDbIs2nF8QrFHFNJZJc0tfgMn8uU7pSIZQs7WnsZpMzoIh6M0I4
 Wj/h+bpNE/XU9VP4ae5vddhSPN0dKOpOykZNZKTPy9iQqAbsnHH0C0tsF8Ng2cVaPQHQSn8UjJ4
 xcaRunJoDuiZLCYN/gcoVfDMcSu99BZ18miBVvUlmBUyej7DEI05WSZj/rYuPTogDPvlaBa46EM
 dE/dpAZanqFy1a+u+njLZsRSJQmeVrWc5gvXoinqHNM9ch1+306Zuj5tFiTcw2R2jUDWue0mLeP
 C9iQPj40ZEjXQBGKjF0l2H63BoYwRCeNBqp1ZPemznNotKc5aQAhTCxu91ddtlRZsnc8dW62Hxg
 Z0mrsC5TGRkFxdP2tRUQp3ZnsdiVcrt0Y5l6SxyGdVfJiWz7w+taofn/5C4AwLe/MzAXgUSbqoX
 3Dx/ptnKXnHOwUrvvWAOpp8HO2Zc0ElzM0VzLFgKI99t6uHzmXVA==
X-Received: by 2002:a05:600c:1d28:b0:49c:fc6e:8cbd with SMTP id
 5b1f17b1804b1-49fe66fc677mr11231985e9.33.1790204035263; 
 Wed, 23 Sep 2026 15:53:55 -0700 (PDT)
Received: from remote-01 ([84.17.55.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c446e1sm74317905e9.2.2026.09.23.15.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:53:54 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: David Lechner <dlechner@baylibre.com>, Weijie Gao <weijie.gao@mediatek.com>
Cc: Aleksei Sviridkin <f@lex.la>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
Date: Thu, 24 Sep 2026 01:53:50 +0300
Message-ID: <20260923225350.1645617-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ee2dbb58-bad7-4bbc-a86f-5a93193df3f5@baylibre.com>
References: <20260922193031.785941-1-f@lex.la>
 <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
 <20260923072204.1248855-1-f@lex.la>
 <ee2dbb58-bad7-4bbc-a86f-5a93193df3f5@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On 9/23/26 9:50 AM, David Lechner wrote:
> It would help to know more what your overall plan/goal is. What do you hope
> to accomplish by using U-Boot rather than the stock bootloader?
>
> If this board simply isn't going to work without a NMBM layer, then we
> should probably wait and see what kind of response we get to a patch series
> that proposes adding it. I found something similar [1] where it was
> suggested that such things should be linux-first.
>
> [1]: https://lore.kernel.org/u-boot/0db3e5e9-d54f-4571-99a1-9e5f34bde685@kontron.de/

The goal is the shared port on the Keenetic KN-1012 (MT7981B). Port 5
of its MT7531 switch has one SerDes, and a mux on GPIO 27 routes it
either to an SFP cage or to an Airoha EN8811H copper PHY. Which one to
use is only known at boot, from the SFP presence pin on GPIO 23. Linux
cannot switch this port's media at runtime today, and the stock loader
always boots the default configuration of the FIT image. My U-Boot reads
GPIO 23 on each boot, sets the mux, picks the copper or the SFP device
tree, and falls back to TFTP if booting from flash fails.

NMBM comes with the stock loader, and I keep that loader on purpose. Its
TFTP recovery works whatever happens to the rest of the flash. Most
OpenWrt users could not unbrick the router if a replaced loader went
wrong, since that takes a serial console and the BootROM. The stock
loader writes the firmware through NMBM, so anything reading it back has
to use NMBM too.

So I am dropping v2, and the board stays in OpenWrt for now. I will not
propose NMBM myself: a layer that remaps bad blocks behind MTD's back is
what the thread you linked turns away, and it is not my code to push.

Weijie, the NMBM patches OpenWrt carries are yours. Is taking NMBM
upstream something MediaTek plans? If it lands, I will come back with
the board.
