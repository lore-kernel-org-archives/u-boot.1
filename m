Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A9606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v8M4MznL;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aFQVXjbs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5FD340D0A;
	Thu, 19 Nov 2026 15:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZkW1_ugHTx-r; Thu, 19 Nov 2026 15:22:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3284340C66
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101745;
	b=deeyNa7xxEXl0yGMQDoCUiYSl+0TN4EnnRYMjkWd2b/tXE5tD+TUlMNHL4CmEAYqHIDS
	 LF1NsIe8rykhOFoJFGKnrSvtBaf13R1bpVe4NYOYdR782Mdv7olI4nkvvTNcy/HOqVd73
	 huWlC1TKn6Gj7bvBae3YnZFvcPGCe1Mo1zj2WuRdECN4I7vgjyAkyjFcAH3A/2FtlOV7r
	 G2TXWqr5Q18/ElceeMsUMImIlyl0ANziffS/1fspdMEEuALb508D3n4Rk4sQF1dp4KWHA
	 hVYccozsDs8xqa6JlCiM00hQYJOfdoOV/0lOISkxcY7d46WOSIIUscf+ikvOYx84+xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PrK8cfJU7y2naXr+N+UmoQDa2+DwygpTkPDWpBJa4/A=;
	b=lOgReO2wQj7TzwRwiDdTyVZD1tfNrlOEzO0XDWNexY6gMLik3wjpVKNDAINqgxQ7vBoK
	 NdlyZLGTMxn1sScf26r2LZ2942vOx8eNntFVsGqelC8aqSOUZdWBwqwzC+AoyUPslN9Ca
	 LYQm6MofnaOS7d1oYTheDyPQevWpirsr+BbQIjAQ9fYuKgPYeyH9+AbUCfXC1UqyAUHG+
	 kYl9/38XAdcfhiRhPyBRiM9XoJwYDiX4DbKWMmsv3bkgk59xu/ylF6rJMD+/z1Z5gpwVS
	 aL1oJlnFq0z2jz40SSqUE9JYIKXtK7bQp55/2p4y47leqF1HKT1kDmH91UsVdtFjw2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101745;
	bh=PrK8cfJU7y2naXr+N+UmoQDa2+DwygpTkPDWpBJa4/A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v8M4MznLCXYivnCAH07z5QUl9j1aTkAgjsenGDeZBvlX6SDYgMYM4i5Yay+ZPLIe5
	 9g0wMx/sMxXGVprd6D9DqJ+ikFQ5INWNrcsFv1IM4hIDUfUFGVo37j/vn2R7BXRcp9
	 ZFRps8v7QyiUS4F/B3C2+7cymZZvZVnD/htFOEezmGjrbcs0RQcTmf85isdo7yz6k6
	 HOyvGN4raSj1alTKSVh2Zd9MTwACxPGG5YxcsWmmAARVssAfZgQVuMj3nm6L2q7TEx
	 wulGs2NDxfxn5exna2cb0H/O/3hI4tcA6n8PkewEgJxWVlzc4gsfNlwrxaoCtKa/w0
	 quK1O39iFIHqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3284340C66;
	Thu, 19 Nov 2026 15:22:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A59B2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4063740571
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKhbuS_xJJKo for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 624A340556
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aFQVXjbs
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 624A340556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:21 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-862bb0a189aso966803a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795101741; x=1795706541;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PrK8cfJU7y2naXr+N+UmoQDa2+DwygpTkPDWpBJa4/A=;
 b=aFQVXjbsvNCggcXqIKgJoIl6aHF5Ym+RajWWVBtPvbYEwyIbAjgMZUA2mGnCLc+Nb6
 K1hJX2gqE/jVQWAtm7pjEtdbnjbrTtATk8AP+JQUs8hzvnrM33DnNRugPIU8L6ayF2r8
 XU7vSEq3vynIzP7e3uibqntI6dQeXOouMff5b2jonT9NC62O0Fcgw24C3DtxGvJWUMVo
 X0icMepsmAa2yVWWL0lgnb2bEUtHibLbXa2+O7Cp8C8n1IvODP0+vhKHtZLurRShKWhw
 6LCkP9e+cqyyl/0GimZ6MkvTnLIgw++jCg+/GYg52HtZqe5xm8eZ1MroMU2U5uNhhgd2
 MPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795101741; x=1795706541;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PrK8cfJU7y2naXr+N+UmoQDa2+DwygpTkPDWpBJa4/A=;
 b=jIfuDE8w5TF+ly2q9n+5DzHy0v+PeGaSvQaHAvu2iXShaY5dUWX6sNA8qK7fsT68sM
 kr2WQVQVbKsisOgu0H+v3bKyWOpNZDGHOGkNxfEFirZ7eGLh/LZMoz7bmpNMQqedXpMi
 JLNgGKgBM/rJIn1Qcnsk4eKWq3UibrWbakZEOheglGC4SqTkrI2sw2a5AfMqPDBdgS2N
 kbmc10lIsnyVP0Gr/nknpJAfdiUwTQsR1gsiUuUBFLuJOZ0tsEHcRo5/u8+GVQQZSDs7
 xAE2jAJ+g/84Mw2azpqzfyBRodwB6/D28bJ/2ss4Vw22UByfPM55UCYF1huLM/vAf17e
 pi3Q==
X-Gm-Message-State: APuU4Z/CBqcyMTZgRE57mlbpNyb8D0Pm61laOr/F8QvQzhsqUZahZ22X
 BkSB5akolZjHAnBYRVeBwnnFxc8ohEvaARL8H3J4bb+OIxBy0PUcvfvA7rOt0z12oq2EVzbcE0c
 xC0+c
X-Gm-Gg: AYBFou2Ng69U22KR+iBhyAUE+p0BJdjoAhkgh5bt+9XDlH3W9G0WZ/im2IAsu/bgEpD
 r+tY+NhVS6Gud3Hba17eFkGcIZX1DeWCUQkxk3j/dhMFyxZli+2Z84CYkmiyvcCXSq9v2yjSn2k
 maGhsagX7gsAmSbLiLdn6KVVmzcpewj4W4iopMj96ykBcOJ98+EP9rdgPlqJ8I2H0eCqW6+FXRD
 n5+9ZGJwJ/maLdniNQIJo2MKNYpHSwEHqfmpDjPIhUt/TbtGzFNvu41Jqs8JKE2ltcKmc0Q/ghy
 sDWMq9JdXnEKlymICi0UAQfsrVgB58zPNw1nshEIcVVYBlEf5tqTIqa813xaaT1JZf4H1drWCKA
 KSbqces6QbY47JQuY48h/aOaID/RCdJAX5hFk7/VQtOZj8pBMS5zE3oQwvNRp2cpUCxTeEgfaF8
 /ovkDfErC9NnBSLB2oNOvL4du2ZoghwyXaGwA1QZguEOBTfPpN/hHe7lazqUiBmTvHUbirCa1WS
 bvwluWDp21z/08k1OhkwKewyKpUDi+tDsenXqE4GUY/QeHrfessYLF8cWhDp4ZqWRHfTm+kbNuV
 d7JojBPpkH4e6nTNkgjf8GZp3eqBevying==
X-Received: by 2002:a05:6808:1387:b0:567:b397:a952 with SMTP id
 5614622812f47-57a0a109668mr222888b6e.15.1795101740565; 
 Thu, 19 Nov 2026 07:22:20 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc55895b9csm88071fac.0.2026.11.19.07.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:22:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/4] spl: ufs: Add support for loading U-Boot from
 the active boot LU
From: David Lechner <dlechner@baylibre.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
Date: Thu, 19 Nov 2026 09:22:04 -0600
Message-Id: <179510172437.2216103.13402202921917577438.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=587; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=csHxr2TADxjDHg5mm5A2iLqJJyUPvCtqpguIYI+dyBQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/xQjgxz21tUxfcdqyEoQz0/DU4AA47bWuMCdk
 yg+cZYxduSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav8UIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2H0H/0N4wEH3/uEqH1KFzahoxLhAx/ByQAYrdInJm62
 qZtNMChUp2GinWhJ9S2EodPzm+W+xOnbUNLuZM997qYvU/qx9grLCR/ECHzo91uGc6OiXj7wISp
 oDtbn7eRrxJjDV8v4CBJ0tOqnQQShded7vHp9P2iOY0E93EjAm9BFOY+CaIPYVE4mr2dcustwpW
 EDcv6A43nwzrPTEqWs8UPKnJoOA3iQEhhr+QMZkRAOpukVMhF4UL0B7wxjGfs4RcsPV590MWXuz
 vw5M4IO75On+pxR6HeD/QlEhBWK5idMAvlHqBnhZ6FWDKeN99jt6aZAYk3ouQK3DPa6p6wrR2jQ
 1KNQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> UFS devices have a built-in A/B boot mechanism. Two of the provisioned
> logical units are marked as boot LU A and boot LU B through bBootLunID
> in their unit configuration descriptors, and the device attribute
> bBootLunEn selects which of them is active. The device then presents the
> active one through the boot well known logical unit (0xb0).
> 

I am interested in using the scsi_get_blk_by_lun() function from this series
for some work I am doing, so thanks for this.

Reviewed-by: David Lechner <dlechner@baylibre.com>

-- 
David Lechner <dlechner@baylibre.com>
