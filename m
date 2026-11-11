Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rHojTDle;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=emg+hC33
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D81D813EE;
	Wed, 11 Nov 2026 01:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tz44_VEDuKBA; Wed, 11 Nov 2026 01:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FFF4813BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794360227;
	b=IIz8uwAtetapb8xvjw1RYje33zkVJ3MotrCk2eN9uAC3/88Aq6itDI/PZldEyDvgDK/r
	 /OnvmR2Uw2JcAZa1euOvelaX85nLS1Kra9X9HI8/sWwYtIbFrGzOtc9yJT77E4MCV1B/2
	 m0p1mMoWP0nZ2NuEiN0HiZCGscxYneTooAk8aByOidsW+EGIqDrL/vQIZADCJ15dFaJgQ
	 KgX31YTlYhV0tITQCQbtkWFiN1brHkxTdC7Den+7zlv+6QveeiW/EbQ8QApWDDXY5nbOj
	 884CHDf56uyp72DgHrYu9UzWyG8kokdqtwEmhzOgWTL0owfSMUX67MX8lklm+FF4EOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794360227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=REVw7fXAKsUfWkRSwVe3BLim5paZxQLwlkZo1sCyoLk=;
	b=inD5N3vo46wslgVUeSjnHXt8xdjTN5s3xW1nlz9DF51fXmSOTFfBIan2k7Wk/3reyrBb
	 bQsAFtVpFui/DlGyNdj8TJdo35MWqL+xjfpF3if296kSyY1WgYMVg8vppVfRGc+5rs11T
	 nzbj8kBFELpDRzPfwEOh6KHWOfMuP0hsKt3jcL2rjD8dxQpoiz/AHEFPXZcRuerlIqQuj
	 yld7gz7L+PvkBpg4QsRQrgUq0Uo/FFNCpJ/7u131it5JUQM0tXoNAre/qgks1JjCjA7oE
	 /UpLgDdSSW7cb1GtoQt3mctEk7B2X8VFE5hfgPW+E382ZneJWvo1lEVaUzZmYI9kgHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794360227;
	bh=REVw7fXAKsUfWkRSwVe3BLim5paZxQLwlkZo1sCyoLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rHojTDleI1YX7J04AhGrCVNWktq9TI4LZHZBjyFWbdOKP+0JM4PjrGH9/pKSwETYi
	 jF3FdBMNegJZPRXnKvOwOTZ1JHuth8hLwjs9jF1ClsXQn8ZEloB0xbY4s/DV5Eroo2
	 ohQsM8KCxfn1Ymiw79FiaWSDVdFI2SHQ7o3VPt34pXGka/S6aPJgPfFN9qXakLfabx
	 7ag9z6xJBD9h1yydz2j8ggaqACm0/ZYowaXx9w9P2IS6wFbJ0I0vtOoSvo0DOx7lOp
	 4anFvgxbDuPeAm7pdvwkeZlijAfeRYCeBtcnCEUdyX6duqgLUyJemgur7G/A9bTOBi
	 3vsfveevN5zsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FFF4813BA;
	Wed, 11 Nov 2026 01:23:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD43D9D1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB09D402DA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYywl-5VegTY for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 218F1401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=emg+hC33
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 218F1401E2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:44 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f48c750afcso1746877a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794360223; x=1794965023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REVw7fXAKsUfWkRSwVe3BLim5paZxQLwlkZo1sCyoLk=;
 b=emg+hC33Il3hJTfvpLwl64MsP96cx1zMRgOM2V1xUjpmmkeetYO4dfzoQsgPQQfY42
 tuclpQfnrqirgEe3Wtxl12PxI7XVHFwB+I88HaHEd7dO58t4U4XSbv1QO0/2j/kD3eAa
 mnLDj5n5u7YzprSoxf0P81rIVo6AbZ6m/zG8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794360223; x=1794965023;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=REVw7fXAKsUfWkRSwVe3BLim5paZxQLwlkZo1sCyoLk=;
 b=M2kGKdtBmG3Q7Ud4m/J3ZlINn4nL801M/l4EjqrQChdJmmjtWQOVQIpVzvt5s3v0AQ
 MLl2sjZe/v51bgVG7W48d9d6Bz6CYEhHhRFWAqtWBXXJR5GmAFpzZKBtcGHHLKdq83ed
 8n3tcpLraJE7dL66K1NJ1FpA5XHc2+3eVyVfUzpCfhsDYv+H2UGzWbz82/SAK42mcBYL
 +Lymu/tDSkXwv7nyj6KJ+amZfhEVaQCJceaucGVuC4/jxICysce8soh6L9+vOX3lvo8h
 myc+cik549nW8wRbPYVpKZzOdv8ljJ8qBSKo/ZcJBbE3YluIv+Bm53M2bW/72U74Tr4S
 +rPQ==
X-Gm-Message-State: APuU4Z+JKU0gQTn9IAUZKfaQpuDOCwAtxXpNiDmHHOsi6tmO623yYRCP
 2lh4gme9HegYtbcFJfvlRWsaZ+syFRSPriLZWXoUk90vY9SYcmeYOfYvvPJlJHPk/FlJ/qErK5I
 +ytuEV+5baLpw
X-Gm-Gg: AYBFou225ZZ/AWcANVQg2SqXeTJF2NBm1xNVVd9SoCrsnlwbqxSGbgnTq523V8NkG2J
 AyyJgmm0TIykUaiiosCj7MDYMWOv5kT/uyNK3ZgtEUlQBMId7PN0AEV9y3I2N+UQMwjCqBY8sWV
 kkfYdKOMtMeqi+R79uGmRCXNpS81PTfu2UyKW1H7WxIP6OwTWV0xOjd46U21vzjC772/DvcoJvQ
 fWvFmcpTT8VhemKIxe53sPdKTSpgrgL1M3sURXd6WoxBUMLVcQPmRF2Tf55EFUQ3YI7HLE9TX/G
 TY5Zm2XiHXAankj2O1RtnVTMOVjvL45orcbNGZF71eQGpxNvnLvrIVqkxH+TUl9sbxZFaFFtJ2b
 OTq7g9diVYOQVwKG9JksKQAJ74tiIj8N8fBJ9j9OTJEZRQlxJUubmiXtj572iw6BJg0Uj6kmAL2
 Ji1DeB3kSyjiuwrXwnwcTrdiyJHvjCZKeHJgdgsKISKHCLOTl6l41BMd8ibntBxecESRPY+Dh5T
 ziTdtkMn5dAqIYLGdLJ7zRlQhgP8EaSTjvwYmTXMAKYXRIv+pZCvuUIwbX8GCXVxdxzUniJJl6O
 BbV0Rzxd4AEtvHf98ophwSuRgQ9ssq+a7fCa9wQJj/8hSMljrmGukJIzSQhmgP9xup0gNMCS+3N
 Gk06AkLcWj8M7zYEHtWuRus/swBVbbOnWviV4LVkbI501wBKL/YtljONn7+iAWtvpKmMyBzt00X
 /umaD9iQ2/wF7Cww4g9//bSkwxbSeYYg==
X-Received: by 2002:a05:6830:2690:b0:846:5d82:8bc8 with SMTP id
 46e09a7af769-860f23443cfmr840344a34.0.1794360223294; 
 Tue, 10 Nov 2026 17:23:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcc005f2sm3128606a34.22.2026.11.10.17.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:23:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <foss+uboot@0leil.net>
Cc: Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, chenjh@rock-chips.com
In-Reply-To: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
References: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
Subject: Re: [PATCH 0/2] MAINTAINERS: update entry for Rockchip
Message-Id: <179436022217.336966.4586252139902704003.b4-ty@konsulko.com>
Date: Tue, 10 Nov 2026 19:23:42 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 15:22:26 +0100, Quentin Schulz wrote:

> Kever has new duties at Rockchip and doesn't have the time to work on
> U-Boot anymore, as confirmed in private. He's suggested someone else at
> Rockchip could help reviewing but it is ultimately that person's choice
> to do so, so I did not include a patch to add him as reviewer.
> 
> Simon is not part of the community anymore, so update the Rockchip
> MAINTAINERS entry to reflect that.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] MAINTAINERS: remove Kever from Rockchip custodians
      commit: 07fac80ab48d5c6aaf212d92ceb413dda8b61a09
[2/2] MAINTAINERS: remove Simon from reviewers for Rockchip
      commit: 7828b5938c6af8de70f8a3399db886fd65a62fb0
-- 
Tom


