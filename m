Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4212DC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 18:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9452060626;
	Fri, 11 Sep 2026 18:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2EhNw0LivT2u; Fri, 11 Sep 2026 18:30:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B1B060616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789151421;
	b=UPf89BHNhnz/vIq+yE5pEQbEv6jtzRe/fe7j/fuD+WdsErJRtzhpSRR3XuDvN2FF3hi+
	 kjPY8OE1q9vadukzNiCWrby/B20hXGKL59DBMVSUx4c+L8kdQQHUhZHi1yC1ZWSItllgi
	 jkdMO1aNktsaeICqUc5AcwODYVkNYqYQo6XQ8pGCev4M4j1wakVlSYGQwZSD7mVlKyz6D
	 9Nx1Nd6kZVe0+wU+xlRUFw7IrDawuQbEiY3no9Sry51KZirt6Xp2RRfwX09eiE0vGPAet
	 4pfrYKOkgeraReTm3bej3mtMIw9LekeIdIqHA1LJjdEnBekf1Qt96BlWbvdh6rkYLFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789151421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dOr1eCzeHMvcLEw9JWwfWXIdCG2ZsFX0mAfbROOeW6s=;
	b=f7vPZOz2CykOeCEoPZ31AWYrGdxhoYszTr6QyfBUbdAYz/CYuyR6n0eWdIV4FQr23JCz
	 EJYx3qJvzNiYhTfvl36IRizWM7ohy3ZXuwFkoRfvVi7n+LqmvEUssKtzOMYJkDFcBy4Mt
	 WljpZOROatERoUzBO1dpLC3ynm0TNHsMRlCYBk/bEi46C0T2hEdG89vJDb4ME4hq4vrlL
	 yxN43m1vdiJJvSAIif50BNiCNtVc5NXn6tOm90iB/bB/SurQbbBr2ELwI3m4hhCdJsnQf
	 JkueSdUSSR6U6Ku07rrNVixUvIWKzw/XAF3fXTCVIlun0IuoVSNeT3a8kWAMcIPVpwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789151421;
	bh=dOr1eCzeHMvcLEw9JWwfWXIdCG2ZsFX0mAfbROOeW6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xl68OgoQofHcQPg7I8VQ3dHt75O6kBgX2DorHj30f2W4pL7rRZf3tcZ9fzrO3Xx8Q
	 EG0S9zhwSVKwnwV7vyHy8UIM8vPUcODReULTLrgrdZuWOhkf8gcXv1loghD2z+58AB
	 gLj2+Tu7pv2F8bjyJOQVrrLwKHX75MtvHGMz/4JN6Qe+1PL+MNTX42k2PX1xitw21u
	 NJ3fklvtdHSuGtOALvpisZsL01upW9uD/J+Nu7KzYX+V8dJc9s0R28VoBRxCeFZBaQ
	 dLX5MDZBVvRLDvT/kvd7KDVZ9pQMrKzR/wHz7lQcq4jLYb6q0W0QGxh0tL+lvY+fE8
	 PCgIZjKHXpbDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B1B060616;
	Fri, 11 Sep 2026 18:30:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DA1D72E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EFD240756
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ2EKWGNs_f2 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E494A40752
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789151419;
 b=eIbeT5AoIqYUbw6eU0ZlfBbN9TkM27DHk4bd8VREJsdzWShdza2B9CqfJMWEeBmtY8lj
 buz8/j4fYgUv7HSopbudNAouETrZKEuykHhXDd2CRbR1o8CKveMBCi8xhLWBvOkq9YU5t
 4WVW6kpq/9UrX+cndrVWNRdbW7m2+M/jP0zm2B6Z6FdGx+KZF7Pfo4UXapLcmJie4ujSJ
 SVEOideg6xHll+YyFgxlQwM6cDioa/DumXYuUTLAlfybRjir4wfJGA1ItxX8Q99b5ODKO
 H+mNVGT6/GyM4ebnUB/PcT/HDA6m74hibc2I4g6JfFYXpNVammL3VJorvDqWPT6nDzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789151419;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=dOr1eCzeHMvcLEw9JWwfWXIdCG2ZsFX0mAfbROOeW6s=;
 b=mydGB1M91LmQmaFod58PsYfO1F5hjQrpeTnvR4/p0mQGlDjYd1RHo8ugho/RW00gyzek
 liedvmyNs2ehVepkdzFotVIXMw/+SHXHoMwEeKlgyzKkPg/VXBimcuQ9ad4GhU/mdP/pv
 gTCk3H3X551XxpiHddLYAo8oTtD18+UM1RvemIwCQyPzCpqlmEuNcYlJ1C92WpLGEqVZH
 8gVXQBpfyNAQZLkQX5J+URAAIeiQBXSI7UzJajWLWn4sCltZhxnu0ZDvGwLEcuETBOcdG
 XcFl9L5fsyqD6zzLH8m39clh8Js5CUw5QR4rCxT8HZhAh53zoZZLEMfa4wOQNgLEGNA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cMOlLCff; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ltcJ8UW9; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=cMOlLCff; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ltcJ8UW9
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E494A40752
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:30:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hhNPz4YsKzMlCB;
 Fri, 11 Sep 2026 20:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789151415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOr1eCzeHMvcLEw9JWwfWXIdCG2ZsFX0mAfbROOeW6s=;
 b=cMOlLCffIlOycpWWmbMd7cJro4hxxNFe4piltXvi6qseuJPW14W4gAEbxGHngGpFcW2Lqf
 RJX4a7539PFQmDOpo/ujE5C8MwnvVx/1ugThUs7P/1sBs2VU9C0Lm0oUDM0vm8vsGjKFJk
 qNekb2TuwptYF1fubPN09WEgURwRMqwqYVcxIip0Ss2j4tdPcZ6IkzqLXvAMVxtECXyTyu
 pTSU7iJnrO5l29M6r9KtAAUdX96/PHV26t6vasf3WtONCag5WNq749X/Zjgv+zcaQWWD06
 DCAtl5KTsPOYmTKb1EyYnp8CQHoUpAipfMsE8iy/28Vh5Tm3iAvt2X2esFkQrg==
Message-ID: <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789151414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOr1eCzeHMvcLEw9JWwfWXIdCG2ZsFX0mAfbROOeW6s=;
 b=ltcJ8UW99iLIq+XAWst3fWNnIlOvjp3mikmC3OPcGY+6iM0cTPm3duybsNtpGTt8wCAS+o
 j1JP2hZJTdJw5rkveAh3336THonkMObGuNYpZwMBP/VGV5+HrzCnnteuYRJ7w51P1F2pwh
 4AbZDGLJG5ed3SZyVsMNRcoaEpXb9usP+IQZ4nfEgxyskpfrO5ro1rqkq72PFOf97ariVP
 D3SSxBX/lTTlPiKjQWV4HDL1FP1tiJf6oF7azgjIkCHx+fsDNppx+xV6JsfxQEBO/iD7hp
 WYmEL3mFy0ruSsJGv/IWm921c7tBgEbJCOBKhjGbXJ7dZLY6eV0Ff/Lj/A8neg==
Date: Fri, 11 Sep 2026 20:30:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oycba5q6pu45btp8pjs53pjf3w463nj9
X-MBO-RS-ID: 2785f846e864eb11695
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

On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Add a new utility library for parsing command line parameters in
> key=value format.
Is this reinventing environment or UPL ?
