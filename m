Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A89C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF60D60DCB;
	Fri, 18 Sep 2026 18:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTjCkaakL-zy; Fri, 18 Sep 2026 18:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D618560B75
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789756990;
	b=N6rRWnmqJwP/irIC9Bm6venXCT3kJVrz3h4Q0VfjyG/6Qd+OIihx95gak5RzwqyXVpZJ
	 MH+I7/Ytc3d6us+Jx0G7D3LC6nCq6XO7Oy9mDEprAgH3BJRWi3NhWpjm5dxJ7oWqFPMfx
	 Unb31uxz/qveAymmdbEtAb7xAHvk+vucyGQLe8o/g7pa6tYOtKT5BR/baKUHNf/3Pvp9y
	 Iho6hd6dQ+FcFw07WFOHAszuDKjAPhdL+ePIdax/ZvoXhiNRxppRDITKY8TgmVr0UCvOl
	 PPDWZZnQECJEmv6FQ4XcuC6M1DjvHVOmwrOSQoEAbIyTbgZo6DnvdGXt+rRkrQvdXeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789756990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZZCv2zJBC5gIZu3UZqTmKa3VOhOlmlKzr8ZLdLMoncA=;
	b=G+49rHMH/SUKE2z/GJIAMTL7gmXUW1qUFv6VZw2GjHqzrrUaeaFHqSdNfUdGzuIQEhYt
	 V0J8g3sCYTIm6NTRA94YR5HZDc/n0WjBuoXHJ41YhgBsHTM2vA2gvRyLu/aRUijMWxyLU
	 N+LrLI2WZ3lLJetwlJZtmZAJtdMGK2OHrT8wksnfvtlCeDf8eYyv1jgzz2ccxOAE9PUUs
	 5kC8E2KHwyJyRs5Q0rD9d9B2yUEBLMVGNvcM5wui3k4kY7c51dLWjLvQKRrI68htXJq70
	 ONI+rNH07iFbI0ih9MQC10UbiFiOuIeQOEoIQrkSvS3ke458Spr85GJPJEdPTVPUJyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=T4cmW84p;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=7nTwZNha;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789756990;
	bh=ZZCv2zJBC5gIZu3UZqTmKa3VOhOlmlKzr8ZLdLMoncA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MnopB/TemVjx32yTZU6bkJf2+0hLxnz6o692eX1K+TXjpphRU2sb0KxExisABOQ7e
	 4BS79lr9tF7uTRgWO3MH/0snISxixlbDgnQCibJITq6GfvLKW5PuwY+rBfC3zQ0CXb
	 qmipMAWPQdIXDvUzby2xK+J7w8byTKmnpZj8LmxcXTH1OjzoyTc5tjGW4EQVWC8b6Q
	 9LSjcJTeffsWcyGXn9wcGqlxIV6Y292CLiD4w6eOKayUJqj0kcHB+MrBNYANBFaSgr
	 pSW5nNlDDBmfZoIRgRO7OAFKECIJnx0MqE5WSMNJJO97hbJlLWiQOanMRiQCfBCdKr
	 QSXWq8EgL8goQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D618560B75;
	Fri, 18 Sep 2026 18:43:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 212C3237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 077F160D6E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysX0UicY3yXv for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE84E60617
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789756987;
 b=X3MyQPVu+EFADOBwNzYzKhF+XjTSni86MrM+KOS8BOOgGiwuJvuaJqL7SqDD55DO4M7+
 3i3DUYEsbIYPwyLwrjQy1WkztO3uf1+ImnJhrIhou2JfldVpsNYBwdQ3auQSdIuic0rdT
 WnSw+U4Gk9v+sSPtyvwzs175ZPbtvVA3Dg2MPVPwfhEfyrzooBiOeDJ4JVkpcIrlZupuh
 QDhZHYm1rMhC2EwdbNZXNS0nGFJMxmzoagokOiVoUPKNcouMPxIYuDyCeUjIoHmTPKKVQ
 ODj/hGz6DBIQxushVu3VigY7MQTGDhZbZaC/3VIJykeYi+aMQdG4yqCDKsvFxBiBNiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789756987;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ZZCv2zJBC5gIZu3UZqTmKa3VOhOlmlKzr8ZLdLMoncA=;
 b=b7trQtTX7O7cruuOf2YJNgJiPOrLw2irPrPeSevIcNu2USvsHJKju6h7zEiLiylVT5/r
 xFIAnqkhUgjmnRUaFzXki1blVmpCpb5hhXFyeGXiLWwj+CD/SgMZzWt+gbLgbx8PQ3wkW
 sDk0RhQTuik/dxof2nGs3ECgLmwiJzjGL+VaOjYYLRGRQCJD9a1zsMb+fM3YIZAREKe6n
 gi5VoXMYiJ+NcwLAQsqryiN0GQMgBU6H2xtCqO7EfcE/A089ybtnyHXJlYnFSbrDff1Jl
 3qiZXkII7uxMSL3pR2KP6UhEvaD1T3tvnxLQGBaKme3nyKuNzPQKW90KMAQPAUxQQaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=T4cmW84p; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=7nTwZNha; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=T4cmW84p; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=7nTwZNha
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE84E60617
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789756978;
 x=1790361778; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=ZZCv2zJBC5gIZu3UZqTmKa3VOhOlmlKzr8ZLdLMoncA=;
 b=T4cmW84p8k4lH59HEJOQCbaAhaFudXBVewn2oWVzxL3VKK2ZOZg08yBNBntQq9lLY+/ecTHVNdlBk
 mO0jCpZ3HMgYW2HIS55Las3gQESOyIRzN8ZHaUAc2Iuivv0LWRjyR3A4HnMrK+Cu1AQ5y9Exn380DX
 XbwgKE1m1wwqtSoRwcXS90xlftGR6T2KMfTS8gYgHe5cKIfxTUdXV77OEWjWX6agGAKKMbFTYUsXDi
 9XUTOtggOoT2py+JtMSWpxOhJUoseztuhYweavzoAf9KKAbcOML/TLuDj+xDkJcrL5xcTbsP+yWYb4
 bSELejUl65cqVS0iATnFp9dDvJpQSaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789756978;
 x=1790361778; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=ZZCv2zJBC5gIZu3UZqTmKa3VOhOlmlKzr8ZLdLMoncA=;
 b=7nTwZNha+HHhxyakN58icpRI5d7UgpnCad36X6qgFvwEXGgywqnKdEy7yjdOwdZvbFtZ/howVKsUM
 DSVvnPdAg==
X-HalOne-ID: c2d1c4c1-b390-11f1-a458-adacc84a9bfa
Received: from [192.168.0.195] (unknown [41.251.77.168])
 by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id c2d1c4c1-b390-11f1-a458-adacc84a9bfa;
 Fri, 18 Sep 2026 18:42:58 +0000 (UTC)
Message-ID: <f550f27d-55ba-4d10-9b1f-d3712b6967ab@embetrix.com>
Date: Fri, 18 Sep 2026 19:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com,
 dlechner@baylibre.com, hs@nabladev.com, xypron.glpk@gmx.de, heiko@sntech.de,
 raymondmaoca@gmail.com
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918175345.GT858934@bill-the-cat>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <20260918175345.GT858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/18/26 18:53, Tom Rini wrote:
> This is interesting and something that does have to be on our radar. My
> first question is, should we not just update to a newer mbedtls release
> and enable their SHA3-{256,384,512} supports, and anything else we need?
> Then we tell people that need this that they need to move from legacy
> crypto support to mbedtls (where we get to leverage a wider community
> for security audit and response and so on). Thanks!

Hi Tom,
Thanks. I agree with the long-term maintenance benefits. ML-DSA
requires SHAKE128 and SHAKE256 rather than just fixed-output SHA3.
The TF-PSA-Crypto ML-DSA integration is marked experimental in the
Mbed TLS 4.2 documentation.
For this series I would prefer to retain the Linux kernel-based
implementation with limited U-Boot adaptations. A migration to
Mbed TLS could follow as its ML-DSA support matures.
Would that be acceptable?


Ayoub

Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg
Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com
VAT No.  : DE313902634

