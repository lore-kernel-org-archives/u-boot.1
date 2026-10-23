Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF6606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ji/gKbqO;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=yQzzysGK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C8F34098E;
	Fri, 23 Oct 2026 14:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeSO-cnKUBue; Fri, 23 Oct 2026 14:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2FE7409A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767327;
	b=e08Esp8yQt/FDPBlafj+6Dhld3+3mYAShrl4eJOedtmNgHqNfEO9P6uov8aOKMfFnRHH
	 VTInHVJwX4fDsy7BQJk3YAsHP2QGOLCQJ1J1W8czTBK0UewytmSA2WRSIL22Cn2Ai/0SM
	 6EbNYGrQ/6GBD0MtQYJ6s3tmuYlS3+uE8PFpCBJ2SB/Sj4cnSZrRn22baRu8G/yZ0Ys7b
	 ijVYZcYEzN0+XVSReVI8lR7oQMKh7/1GD9yEBHr0UzzKKhWjzqXJtvdhubm0bpSUHaVfv
	 T6uQuAxwzTIVe4Ns25zLFHM4R2kWCRqqYT3mHmuzKUAyA2cmBNNQJrzWMqRl0CDtrQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AmpNbVvOiIlGqp/dXtwiVFJ25+dkLLPNX1DHAOMk5Kw=;
	b=McMqxrOBqCvnBiAMiQ1oJeHJJTrkUlm7sjiJjvbPtLKVMcTVVOK8V9+eGSkMCompNvc4
	 7+YbXVqYmTjXXXQvRElXl/XTnJTXOkRfOGArRDXVvW8iuVJTngXhwPjQaUHLSOzqANri4
	 S+bwg4cRjAnQGhT/lj6Lx+OMfdSzHKnhvll68NLo9uOZKZClBLCPAJ/G+7dU465BrOIqd
	 HJrkEOESmWzj97s1rz0nSZK4bPPx0vVJB76t3oOuca6RoGWg06k3NuxzxJEjy98PfVNTN
	 DHnOEgNLOh6VrK4GibFOSJ9Tu44L1ygjSHpkZ8CnXDIBRYGPjmBcpHWRsNzMuJ1H6DQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767327;
	bh=AmpNbVvOiIlGqp/dXtwiVFJ25+dkLLPNX1DHAOMk5Kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ji/gKbqOonGgpXztz4v0AcZqa3f1EEggQTV1gV8dO1XNDFQztFmYeubkkaBqdFORJ
	 VZSFKDrfkWEss7wWHEBpwM7c3k4BXUrtfSqAf32d8OpSOm5URvhDlLWVbWrXo01vOO
	 FYnLspWHxvoi91GqTrK81/MxFQcHhmxtlgzNE7XCHFM9WI1XM6iaKPEkq/iNpA/qqJ
	 VbotIg8AdQp2t1ydJXEaSbrGDJWi0vDrxJJqpIsrYK9pBipaPQAPbpoSXNj8XLYcZK
	 CwIdjrRpVIkyjB4cfSl5Gr9Fp+N96/a+Qu24a2/E9gszCYzTdeYJzhO5QL4YVsdoO4
	 O5fC571e9S7rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2FE7409A1;
	Fri, 23 Oct 2026 14:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41CF7371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27809401F1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpeVcvxYDAZK for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EA471401DF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792766186;
 b=NFrToCQe09XBUhdmKi8shw65zAKtJb0IvBv6UGB/CmTv+MIuTIiMHISnr70AY6orT9s+
 IJENfbTBandWlsuECDfPHBSmqP1iLseMZ9V/ifrD5Q3A2rjKTL/gL9rUmsjuDxM81+MKt
 /tDL9vqD2ibLGJBPpcD00jp1LJJLJc+xRCIjT0uKY5yTwBf3rdgBBBZtlJW/x0J7XZTOB
 XXvQlqvx9X4sLp4Y/iYqNK6YiCApByg2GzVs5JIr4h+weJ5Tt2VoZyIb+rkEnf+RBkRTG
 9czpQwC5fo8d2wbmov4uHmUtEMxYm/TR8rqhExZyTDHRSr985pKYfBpBj7CPDopCM5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792766186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=AmpNbVvOiIlGqp/dXtwiVFJ25+dkLLPNX1DHAOMk5Kw=;
 b=aoNz2IIjvecwfPbkqIEFWrFexJl3TNaX601vHi9oBV788n0Qc5quZx9mlnZv3WHzrYNj
 4rEOnrZQhHOgivS2ZOC1qrhyH620T2H4jZIiw25J1vxSYFthE0Br8Br9swC061BNLmOxw
 c1IMBxTrf1h/q7px0KNZnYiAIJo0G+PUpp1pyj+ku9M6a9oiX8qCodxY9No0vuqw7ZQYB
 sMdNHwGeHx+cbSYujS9AncBSdGYeZamJCb2OT+VGkEzQlOVtdI7IjDKAI4V4NGfF8TzUO
 GiTWDMi0PL7HdAsv6udGamtsiirN4ZK6uI395dW7mvn/If2Zlxr52FXmic5Ppc9jaXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yQzzysGK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yQzzysGK
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA471401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:36:25 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso7324495e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792766183; x=1793370983;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AmpNbVvOiIlGqp/dXtwiVFJ25+dkLLPNX1DHAOMk5Kw=;
 b=yQzzysGKCB6btwSEvJWgtk7/WWu4kxYjot/i7A71yg38gltLngmpyZWsId1AUDITIz
 IE4kjprabMKRKdrJXWsJ8vxcBjqbRqX06Qq+yIdK9RgpQdPFBkNOl6Rerv5It7soG6Ik
 qRaaojtjEgPExpOtOjfbkRtIA64Hw0ibHq1oFH1ipL2mO3/mrH4XlBKii8tiYx2y/880
 bdd3ESZnl1fwt98GKv3ha6oCAqqO2IW0jQ2ARCsFgoheUS4jQw3AHXwVOQ77jkUzSNbC
 XGYPZLlwMXgvOucT9gD+nMnPJN7LrolICRwSXHK2D8azHiSiiXVnVIgXoQNF6FBlE6sr
 +aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766183; x=1793370983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AmpNbVvOiIlGqp/dXtwiVFJ25+dkLLPNX1DHAOMk5Kw=;
 b=WKiKRcaJTaeLLY+xopkK7wJ7BtBn11v26eIx97fBS+QYiTmZKE40KYh7qQ7YqpPOto
 rM5VEuHnIhpk94EKUrCQM0ZsVZ6FfIWKAcw39OUtGRGaV0VPKfuvj4WGOhXC6l3oCC9L
 Kz0QPjeCwpPbxhTIcKKtOy6Q6X8i8ejTpNoV2pqEMPj3JJs+vXHEboBfrQYSaF4G2250
 px6VzFx5rc0Al2iU/4qPuomBDDG2sLnVgY0stTF3e041QC0gnBTQTYPb11EHSZX3x7Uw
 TsTCdyZ7838JKXsKj2JyeMe6YPEme2Dek7dXYYMb/Zmy4Lf655fsyvNOc0eTdw8GO5+9
 v0LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwo/oJuRpGZSycLkmx02qtxKAyMbKgGHfZ+9kIzFp+083TauchsJ1F+FzcAN34TQ6wwd94RZM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtXxdZTRlHTxf9DXC0e64CRnRzeG6EcQTw8HpiuK1e9pbE2+V3
 NAAYm+buEkoa1gafLu64ew6TJqVTtu0wUEZd7cJDXlAyqsQC1w7iFIa1rucIDivY+R8=
X-Gm-Gg: AYBFou3PVtjcGroL/hP6Fn9P5Kvnt/V4ch8wOTP9gdu02tr1u7NgdqMc0VEjMgGhGKZ
 tGAwUwq9d19i12RljHOiHeLLlkunhrpBQ0dNcIF0YU6w2bWKPLHztsInu5oiaykc+Vm/EnfB/yp
 C9Bm5fgeI2SQCVVGXhUqega7MSeebcNhncWwra5+5Rc2g1kW0AKa7E+VgkxsDOduW49HWokEiJ7
 x8okH/wKjqIK+JctC8XT/IofWZx2ww7YxTtglrb1oa77m/09UwZ3+SmjH8XqV8ogILr0/S0ViI5
 qs/SZ76hssMSqjmCnOgyqkTZqyNePbDtYlgVUprgJ1wEkN27s8jbMM1WDJycKdBXWbb66j2vFD0
 0LzXh5F+rVdYp2E/jvhOCSZqnpc77XCT8W0sHySRm14/z6TXwKM563g7hOQjVhFkIcGGW8msRWg
 cQWCN6BJdnBYzwi/b7TxRrDUKg2piHvzdaBRlcSwdMbQYIRqWYRyPZrQ71xoOiaWkSsUJy5TX3B
 OOcUJS7Ra4WThtQ/OH//Rkf8HSgBUtLOltPdU87BwWXn5hf2DalU22iq2dP2+OIpDXBstt0dawK
 K5b0P55P3sGPFuvpy+HjGFJggsu+f+IAxFvz
X-Received: by 2002:a05:600c:e54a:20b0:4a1:fc0a:8b75 with SMTP id
 5b1f17b1804b1-4a211ee36bamr27279625e9.24.1792766183394; 
 Fri, 23 Oct 2026 07:36:23 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d0aasm9906875e9.3.2026.10.23.07.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:36:23 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 23 Oct 2026 18:35:55 +0400
Subject: [PATCH v2 2/3] rockchip: Define the env memory layout before
 rockchip-common.h
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-rk3576-load-addr-v2-2-d2a42a1e90df@flipper.net>
References: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
In-Reply-To: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Coia Prant <coiaprant@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Chukun Pan <amadeus@jmu.edu.cn>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Nick Xie <nick@khadas.com>, 
 Jiehui He <jiehui.he@foxmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>, 
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, 
 David Bauer <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>, 
 Sebastian Kropatsch <seb-dev@mail.de>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Loic Devulder <ldevulder@suse.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Levin Du <djw@t-chip.com.cn>, 
 Fabio Estevam <festevam@nabladev.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Banglang Huang <banglang.huang@foxmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, Lin Huang <hl@rock-chips.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Johan Jonker <jbx6244@gmail.com>, Torsten Duwe <duwe@lst.de>, 
 Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9831; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Cj0/jx+kowvD/MipZnut4oboOBgdW0WEoOTlowho6CM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdLjjLJNf7K8wkiuHEx/wKlXsHXlvabuf8Mu/1PWl7U
 b1fgrIeHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1ZwaG/1XeWS+lJ9640vtDsn0RwwTLG+di7rPqzi+WUpiv1CO67A7D/6TOHHl
 TAanolT3btK+4hb23TDowX1y/2yTFUXhn02c3ZgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:23 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move each SoC's ENV_MEM_LAYOUT_SETTINGS above its inclusion of
rockchip-common.h, so that the common header can see whether a SoC
header provides its own layout, and supply or demand one otherwise.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/configs/rk3036_common.h | 14 +++++++-------
 include/configs/rk3066_common.h | 14 +++++++-------
 include/configs/rk3128_common.h | 14 +++++++-------
 include/configs/rk3188_common.h | 14 +++++++-------
 include/configs/rk322x_common.h | 14 +++++++-------
 include/configs/rk3288_common.h | 16 ++++++++--------
 include/configs/rk3368_common.h | 14 +++++++-------
 include/configs/rv1108_common.h | 12 ++++++------
 include/configs/rv1126_common.h | 18 +++++++++---------
 9 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_common.h
index 0bf9e8b9a2e6..e3016f430f2b 100644
--- a/include/configs/rk3036_common.h
+++ b/include/configs/rk3036_common.h
@@ -5,6 +5,13 @@
 #ifndef __CONFIG_RK3036_COMMON_H
 #define __CONFIG_RK3036_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x60000000\0" \
+	"pxefile_addr_r=0x60100000\0" \
+	"fdt_addr_r=0x61f00000\0" \
+	"kernel_addr_r=0x62000000\0" \
+	"ramdisk_addr_r=0x64000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
@@ -13,13 +20,6 @@
 #define SDRAM_BANK_SIZE			(512UL << 20UL)
 #define SDRAM_MAX_SIZE                  (CONFIG_NR_DRAM_BANKS * SDRAM_BANK_SIZE)
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x60000000\0" \
-	"pxefile_addr_r=0x60100000\0" \
-	"fdt_addr_r=0x61f00000\0" \
-	"kernel_addr_r=0x62000000\0" \
-	"ramdisk_addr_r=0x64000000\0"
-
 /* Linux fails to load the fdt if it's loaded above 512M on a evb-rk3036 board,
  * so limit the fdt reallocation to that */
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/rk3066_common.h b/include/configs/rk3066_common.h
index 6a3b6900463a..31258f46c42b 100644
--- a/include/configs/rk3066_common.h
+++ b/include/configs/rk3066_common.h
@@ -6,6 +6,13 @@
 #ifndef __CONFIG_RK3066_COMMON_H
 #define __CONFIG_RK3066_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x60000000\0" \
+	"pxefile_addr_r=0x60100000\0" \
+	"fdt_addr_r=0x61f00000\0" \
+	"kernel_addr_r=0x62000000\0" \
+	"ramdisk_addr_r=0x64000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE		0x10080000
@@ -14,13 +21,6 @@
 #define SDRAM_BANK_SIZE			(1024UL << 20UL)
 #define SDRAM_MAX_SIZE			CONFIG_NR_DRAM_BANKS * SDRAM_BANK_SIZE
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x60000000\0" \
-	"pxefile_addr_r=0x60100000\0" \
-	"fdt_addr_r=0x61f00000\0" \
-	"kernel_addr_r=0x62000000\0" \
-	"ramdisk_addr_r=0x64000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdt_high=0x6fffffff\0" \
 	"initrd_high=0x6fffffff\0" \
diff --git a/include/configs/rk3128_common.h b/include/configs/rk3128_common.h
index d8269b0ec96f..176bd52c3e84 100644
--- a/include/configs/rk3128_common.h
+++ b/include/configs/rk3128_common.h
@@ -6,6 +6,13 @@
 #ifndef __CONFIG_RK3128_COMMON_H
 #define __CONFIG_RK3128_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x60500000\0" \
+	"pxefile_addr_r=0x60600000\0" \
+	"fdt_addr_r=0x61f00000\0" \
+	"kernel_addr_r=0x62000000\0" \
+	"ramdisk_addr_r=0x64000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
@@ -15,13 +22,6 @@
 #define CFG_SYS_SDRAM_BASE		0x60000000
 #define SDRAM_MAX_SIZE			0x80000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x60500000\0" \
-	"pxefile_addr_r=0x60600000\0" \
-	"fdt_addr_r=0x61f00000\0" \
-	"kernel_addr_r=0x62000000\0" \
-	"ramdisk_addr_r=0x64000000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_MEM_LAYOUT_SETTINGS \
 	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
diff --git a/include/configs/rk3188_common.h b/include/configs/rk3188_common.h
index 98f2c25f3cf9..5f737f232c6b 100644
--- a/include/configs/rk3188_common.h
+++ b/include/configs/rk3188_common.h
@@ -6,13 +6,6 @@
 #ifndef __CONFIG_RK3188_COMMON_H
 #define __CONFIG_RK3188_COMMON_H
 
-#include "rockchip-common.h"
-
-#define CFG_IRAM_BASE	0x10080000
-
-#define CFG_SYS_SDRAM_BASE		0x60000000
-#define SDRAM_MAX_SIZE			0x80000000
-
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"scriptaddr=0x60000000\0" \
 	"pxefile_addr_r=0x60100000\0" \
@@ -20,6 +13,13 @@
 	"kernel_addr_r=0x62000000\0" \
 	"ramdisk_addr_r=0x64000000\0"
 
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE	0x10080000
+
+#define CFG_SYS_SDRAM_BASE		0x60000000
+#define SDRAM_MAX_SIZE			0x80000000
+
 /* Linux fails to load the fdt if it's loaded above 256M on a Rock board,
  * so limit the fdt reallocation to that */
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/rk322x_common.h b/include/configs/rk322x_common.h
index bab4ca015f74..dabbc5cf8abe 100644
--- a/include/configs/rk322x_common.h
+++ b/include/configs/rk322x_common.h
@@ -5,6 +5,13 @@
 #ifndef __CONFIG_RK322X_COMMON_H
 #define __CONFIG_RK322X_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x60000000\0" \
+	"pxefile_addr_r=0x60100000\0" \
+	"fdt_addr_r=0x61f00000\0" \
+	"kernel_addr_r=0x62000000\0" \
+	"ramdisk_addr_r=0x64000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
@@ -14,13 +21,6 @@
 #define CFG_SYS_SDRAM_BASE		0x60000000
 #define SDRAM_MAX_SIZE			0x80000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x60000000\0" \
-	"pxefile_addr_r=0x60100000\0" \
-	"fdt_addr_r=0x61f00000\0" \
-	"kernel_addr_r=0x62000000\0" \
-	"ramdisk_addr_r=0x64000000\0"
-
 /* Linux fails to load the fdt if it's loaded above 512M on a evb-rk3036 board,
  * so limit the fdt reallocation to that */
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
index 52c3695ff8ed..327e32b66566 100644
--- a/include/configs/rk3288_common.h
+++ b/include/configs/rk3288_common.h
@@ -6,6 +6,14 @@
 #ifndef __CONFIG_RK3288_COMMON_H
 #define __CONFIG_RK3288_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x00000000\0" \
+	"pxefile_addr_r=0x00100000\0" \
+	"fdt_addr_r=0x01e00000\0" \
+	"fdtoverlay_addr_r=0x01f00000\0" \
+	"kernel_addr_r=0x02000000\0" \
+	"ramdisk_addr_r=0x04000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
@@ -15,14 +23,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xfe000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00000000\0" \
-	"pxefile_addr_r=0x00100000\0" \
-	"fdt_addr_r=0x01e00000\0" \
-	"fdtoverlay_addr_r=0x01f00000\0" \
-	"kernel_addr_r=0x02000000\0" \
-	"ramdisk_addr_r=0x04000000\0"
-
 /* Linux fails to load the fdt if it's loaded above 256M on a Rock 2 board, so
  * limit the fdt reallocation to that */
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/rk3368_common.h b/include/configs/rk3368_common.h
index d488f8d477a3..d5d15cb3caaa 100644
--- a/include/configs/rk3368_common.h
+++ b/include/configs/rk3368_common.h
@@ -6,6 +6,13 @@
 #ifndef __CONFIG_RK3368_COMMON_H
 #define __CONFIG_RK3368_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x00500000\0" \
+	"pxefile_addr_r=0x00600000\0" \
+	"fdt_addr_r=0x5600000\0" \
+	"kernel_addr_r=0x280000\0" \
+	"ramdisk_addr_r=0x5bf0000\0"
+
 #include "rockchip-common.h"
 
 #include <linux/sizes.h>
@@ -15,13 +22,6 @@
 
 #define CFG_IRAM_BASE		0xff8c0000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00500000\0" \
-	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x5600000\0" \
-	"kernel_addr_r=0x280000\0" \
-	"ramdisk_addr_r=0x5bf0000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	ENV_MEM_LAYOUT_SETTINGS \
diff --git a/include/configs/rv1108_common.h b/include/configs/rv1108_common.h
index ff28236a21d6..aa214255721c 100644
--- a/include/configs/rv1108_common.h
+++ b/include/configs/rv1108_common.h
@@ -5,6 +5,12 @@
 #ifndef __CONFIG_RV1108_COMMON_H
 #define __CONFIG_RV1108_COMMON_H
 
+#define ENV_MEM_LAYOUT_SETTINGS \
+	"scriptaddr=0x60000000\0" \
+	"fdt_addr_r=0x61f00000\0" \
+	"kernel_addr_r=0x62000000\0" \
+	"ramdisk_addr_r=0x64000000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE		0x10080000
@@ -16,12 +22,6 @@
 
 #define CFG_SYS_SDRAM_BASE		0x60000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x60000000\0" \
-	"fdt_addr_r=0x61f00000\0" \
-	"kernel_addr_r=0x62000000\0" \
-	"ramdisk_addr_r=0x64000000\0"
-
 #include <config_distro_bootcmd.h>
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_MEM_LAYOUT_SETTINGS \
diff --git a/include/configs/rv1126_common.h b/include/configs/rv1126_common.h
index ea290f763c01..6e3fdf1cdff2 100644
--- a/include/configs/rv1126_common.h
+++ b/include/configs/rv1126_common.h
@@ -7,6 +7,15 @@
 #ifndef __CONFIG_RV1126_COMMON_H
 #define __CONFIG_RV1126_COMMON_H
 
+/* memory size > 128MB */
+#define ENV_MEM_LAYOUT_SETTINGS	 \
+	"scriptaddr=0x00000000\0" \
+	"pxefile_addr_r=0x00100000\0" \
+	"fdt_addr_r=0x08300000\0" \
+	"fdtoverlay_addr_r=0x02000000\0" \
+	"kernel_addr_r=0x02008000\0" \
+	"ramdisk_addr_r=0x0a400000\0"
+
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
@@ -19,15 +28,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xfd000000
 
-/* memory size > 128MB */
-#define ENV_MEM_LAYOUT_SETTINGS	 \
-	"scriptaddr=0x00000000\0" \
-	"pxefile_addr_r=0x00100000\0" \
-	"fdt_addr_r=0x08300000\0" \
-	"fdtoverlay_addr_r=0x02000000\0" \
-	"kernel_addr_r=0x02008000\0" \
-	"ramdisk_addr_r=0x0a400000\0"
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdt_high=0x0fffffff\0" \
 	"initrd_high=0x0fffffff\0" \

-- 
2.55.0

