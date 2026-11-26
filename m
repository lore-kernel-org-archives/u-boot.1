Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA069606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q1UA2kSr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dL4n4b1P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4E2F40863;
	Thu, 26 Nov 2026 09:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1S_oL0orWJxx; Thu, 26 Nov 2026 09:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09F5D40855
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795685163;
	b=kuiBXYNbGbWe/60t8Dwaq/cXXzuJYOzNg66xocL5ImCGzIjc2z4oDeiQC8YnXP6CVwZk
	 nOHAjR1+uv1WxV+hbbmBgLBK5GsSGi4ybmF7U9dOGOshg6JE+qnzUelPKVbZGDZp4eLri
	 /bHOaEk/qUvDQX1Yu7/PqQ5GMwLEfLsSaNeUJLBBJxGh7HUKtxvKmUfXoZLv57Gg8cCxx
	 FwckLphAg/VuKrX5uaor6QRwXVfoMtQXlUS0uZ7a+4RsB5M1GSY9nfoeuBWipMQ19s0zc
	 wXob+KnRzC3J85O8WBpXTUoiPRzPbqZIdpJsj2PqFiZ0dUnozRyoXfrW5DgUqkSuoMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795685163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0CPaaG+Nhi9nI6zOtSASyNLQUYAu2BbBT8IomY3TMWQ=;
	b=KpNZfnp3VTBb3SStL5mt32GWM+dGOt0bKrsSl69TKTiRHYPMxCuhKx3aKrtTF7mx08/g
	 tEij0fQiDt7Po0tg/YEXqoHZadjHCX3mJ02E/k28ArlJG4ci7qTgSdwYLaF/sB9si7qjd
	 T6IqeKaPT/glR3++ZCUy2g17b8e6VfAFZHLSWk1cbGDDSVG1PMAMmi7Q83w1xyU4VSm3H
	 xMf0RBAhglk27UBFMx0vZ35olloQcfaApwq66R+GBZPOHW2ciRgtepMfgPFRJ3x2PFwRp
	 yswanhuI0om/fNMr+fVgWMQBjiBCuqcHF9veqRFPhl6PwznYod+sSDwe0osUcO9SkKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795685163;
	bh=0CPaaG+Nhi9nI6zOtSASyNLQUYAu2BbBT8IomY3TMWQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1UA2kSrpGy+G4YIE7mREiYXqeDGZ/l2QF4Q3k8q/fK5rj67OM1x45pQjFAldC2CS
	 ONDAyKqXOgKRy5i1oqyMao5LHKlzFZ0oDliY2SurI2VJ5QwnHJUvAxjTtG04TbMPe+
	 9Y5/Xurrk5gg1NtHe5SiVCbpLs8apfuIAPf/K5UTFRf1rIqGeTXj/PAVlDb8JOPIuD
	 bIglwivL+PBhIkBxPZ1tRisEX76g5VkdZvqghAPszbBHn+u0a+cSNigh9vGiwn+U2y
	 daDpi5OvfEaykBqEVmYXy9/1uQEhNFWQKuZzvwimqk4WypUToTtl79y+DLp6amhX5d
	 yn86fBVyGoGcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09F5D40855;
	Thu, 26 Nov 2026 09:26:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 998DE32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F3F3608B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2Xt5IXb00ZS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B79C605E4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dL4n4b1P
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B79C605E4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:25:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567D847DF; Thu, 26 Nov 2026 10:25:54 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6097E83108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 10:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so47857025e9.2
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795685147; x=1796289947; darn=lists.denx.de;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0CPaaG+Nhi9nI6zOtSASyNLQUYAu2BbBT8IomY3TMWQ=;
 b=dL4n4b1PY32Whw53sljVOPYc678Q2Hxfag38gE8uS+NZl/BfEq7Rup0aonMdwUCxF8
 fKi/s2jIW/3bQc6gFicd8kcB6t6RkFAgpIoP9nCIE8Is7jOn1S1TrDx/qOY/lNmBLtag
 4OJG8guysOII1Czj7ZKH3MSwNPc6ZcYSEluUsEhw/Z7Ek6RM/cS+3o+PXobZeLIO3NMa
 b4lfNhatLWXN6PP9nAArXrByhrIFvO9CALszztZRFAFkhacL940lCiPrSHeSLH4sXL/3
 DWjJ3b3zBtpUcu5jr8ldgECLHtIlm/Gpw5MJx0JIUvSV0ezomchGmJG2MtF5YdRY+i5p
 6efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795685147; x=1796289947;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0CPaaG+Nhi9nI6zOtSASyNLQUYAu2BbBT8IomY3TMWQ=;
 b=J/xKEGqJLaGeWxF5vLOn/pZtoQDFiz3uxwOxL7eRjl1zv1t2z/5HA2P3ZIz2tjawea
 Sc4qSHB309V2BCf9HnaSvqFISs3Z1jspul7eS8IyEV8sR7g5X6m/mqWBcrmzWcbwVkMu
 hjVI6t50y/MncA/RMvFchrEoYauV1oj4QWjs4b5CIbV7n+vYc7yuNYZ8k/JuHI9qHcQZ
 bF8v4FWYHU6bNctmwKYzTRR3DR3W7TtQ3xzeS0ea5kCmVoE8Go9W0RM5IIw7mcZ9R2/n
 +P/kaSzRWO5b5P0PpKRW8snpIUFUa4xXjx2KT8LfIjEVIbXdveALprfwaVMklE6/GM4x
 f77Q==
X-Gm-Message-State: APuU4Z/2GfKtEZYa6K4kM/6dDmcvI61f07AVG5eM1RHblGhXODPq5/y6
 gFAdXqPMx3aCVTXzSsl0bnQ4WJRibsqB52n7HYykCxNoSp8UbS5fQ2jNKWTG1DSBiUk=
X-Gm-Gg: AZFdTZdp8XE7Fk9w+LBeR3R6GeKSioIcKtZ/9FTJ31S0IihTmBb313nDp75bWkfrW17
 44bnbx121XkcBIQdjkRc4weFHo5OZ3vzct63uibP/Aoafh0XNhvkD3v5eDdzjmJBnVrGSP26ZNZ
 bHh4TjKoIpVf7Wni2jkDIm284HifeJWFFQ6UtH3TPG7c784tmdne/UDwrbCs6jNzlUczYLXKwaV
 yoRGgdCAIlAVlu45vK2CSnpNdJqrnRwkRjHHEhaNmeAxEWKwUB/O9QiXSGrOocNLRysk8cz1YKq
 caSuKu/bxPfJl8JSN8jMlfXFRsSp1bhJlg4sjO2Z1LPMj2TOZZnhldC5Kv6RCl27Uupq2RNSGas
 Dy7EPjHK2yFbDqx34vKI8N1XSkCLZRdoLcBYQn8k0vna5aHhlxq63QKSeVRQE2TBcpMJGF026KH
 T353ddIDCpO7Fc46gPaZFa02SGDKloxxcWiNFKiE56BP6pkchFHEfJtlkH9FTAAfsrR1WuLwzQD
 cbZiDUiHYXhxVgQbVrtku8pzb98cq0U1G/uYchEdQlAcaCqo8MNcrThxfnlJK9BO3OCPFr4SIDz
 V13tnV/Q00CXMYoJVWcTPqnZky616t7BKKZwZ6wbHVhZy18V7vy0
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb9de0d5ffmr170854825e9.25.1795685146784; 
 Thu, 26 Nov 2026 01:25:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb4341sm39523564f8f.4.2026.11.26.01.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:25:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] lib: sparse: Reject sparse images that are shorter
 than they claim
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Yao Zi <me@ziyao.cc>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261124-sparse-bounds-check-v1-1-2382566b6a0b@oss.qualcomm.com>
References: <20261124-sparse-bounds-check-v1-1-2382566b6a0b@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:25:42 +0100
Message-Id: <179568514284.1731127.8762725063172477235.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685145; l=677;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=XbEZcUqcIVsoszX/inDgbq9kdw2ORmyzrcGql9WXUrA=;
 b=k3ZjwqrPf+LaqG5i3i+3H+iVDVOLLY6e23UZZ9a7r8xLTXKJR4skORhS/IZ1FFLvugs9TopJn
 s3iHLW7CXh8CP809jkLKJ6O3pZdrt3h+Le7qMqNCZOvevR+JC0Av8jY
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 22:32:59 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> write_sparse_image() walks the sparse header's total_chunks without
> knowing how many bytes were actually downloaded. If the image data ends
> early, it keeps reading chunk headers from whatever is left in the
> download buffer and treats that stale data as a chunk, so the user only
> sees a misleading "Unknown chunk type: 0x14" error. A stale RAW or FILL
> header could also make it read and write data from past the end of the
> download.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
