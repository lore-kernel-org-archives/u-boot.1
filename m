Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B666606A33D
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fFbxcRks;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZOksdCyh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 179E640856;
	Wed, 18 Nov 2026 19:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIvfmm54xK4I; Wed, 18 Nov 2026 19:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40B0140897
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028932;
	b=Bwgvzu1715dhflvy9J+83TYzJpJAT7lTQJlqiKAgMeUmeCOkB+U6zVdMoAPIfrPpR8RZ
	 YjUOtJr++POVP6fR+4BbN9DxXji7ZTBsqZPwEjPc2oJBWP6BF3UyW8OBZCSxjndtO33tz
	 6i3DbQfwm8NAOTzWbLUTvYSlyctps3rum1Ww93lT0sfBWKH7qbC+wbpOHy6eHYBVVtEdM
	 y57G7C4RZYsnfB1Lj/8aea+EBe0BUdJnRed+Rm8j8SY2Zccth/8nbdkqZ3XyNZ8EpDrs1
	 ApOn42bjpDvThdoIjfQcl94Osuox4d5wIdLmd8x3zDDFQlI9Uxz/y89+ihl8ZUGOhCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NCbaubGqrHGkRTigEfGB03N4NSAeEMvgDRtbCZ4rc6Q=;
	b=ryeY+1us0FYgV1lzUvBYyYcEhZDzs7e8wkJOol+usbSBGGkddVAfd5gqptNAiO23hJ1F
	 6mMJSA4EqwqeJjC4FdBMyEIaD84k9gMf5R6dQfRBLHvYk0JD/xiwP9OP7ZnjOOHriP95R
	 9BPpGxUCy16KT1L+DVbQ8VqGKmt1U/D2yJeGo5LZ+w7SGeO7haLvKojSskCqRbAWnR9z7
	 bxRucSIjWrb4ezGqAKDePknYcZ/FRpZ5PiawrDxIFDbtdkhcywGRvcVy8hTD1XY0jgxwJ
	 EJc9Q2N2Qk6Ne+Y6FlYKofBwollwOKcG8g5N0pr9ATQnObtbSwCy3GTVV4SpFiqvIAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795028932;
	bh=NCbaubGqrHGkRTigEfGB03N4NSAeEMvgDRtbCZ4rc6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFbxcRksg+f4IWbGe8QB+Gta1aCpC4Ghs060foPSFsKPudqcqJjbo/9kNvM/SopID
	 wYSeLkT+aZnChrNLX42bt9ERCtvHu3+QANavuXcKqxC+vZwlMuj96hH9riGzSnLeP3
	 /EuNDnvLyFa2Xw+z32TCn/i5bPkzjM/66cIEPpvkXUUsoSpKLcMYvYgig/SrJ9zl4f
	 Sbm55fR8UsRmctD0gkzvLoEE0JFmxAuDiw/Db0rliMbfRJ/lxqeJuUPfQrD5tnz6jP
	 NC8UcZ39WWXPILJz8lUAlQMJpI4OpOCpMj3lHQl1JKJRPGe2KuW3novHlfcB4q/UcW
	 UkboUclGQLXrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40B0140897;
	Wed, 18 Nov 2026 19:08:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D35DC13C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C52D281163
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_4_wCi1q7pR for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 19:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B9BE81148
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZOksdCyh
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B9BE81148
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-844a8bf7e25so869329a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795028923; x=1795633723;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NCbaubGqrHGkRTigEfGB03N4NSAeEMvgDRtbCZ4rc6Q=;
 b=ZOksdCyhIWUxSq5CH/1FoyWfkLYrrP6EuXeawLMpA0LxADhQYoElnXqoJVEmzprRjc
 EsmdSUHGm96NICgFrV6VB6CWWmqjC18XADXUcrHHYIcDSAgJw5Ut7QG1O9t33m/rEuKo
 aPoHPMsX9m9mVvqdDjLSi17sT1104AByiPeec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028923; x=1795633723;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NCbaubGqrHGkRTigEfGB03N4NSAeEMvgDRtbCZ4rc6Q=;
 b=EkZY4ZqNUCHo8qnVjBjN9OusHMrblae8D6OxQxdKdM3qtLwVmqsa3xyt6OSAiuW+oy
 +rpXjSUE37Q/aQFIqu/wOYDy6SVnLfc1pMX+FvHmBgMndPu+WriMez0Cowri1MIJsQXA
 NpCgyn+Vvx65aOMW87+4YOqSZu7QIajshcKpfU4LfoRivMYs5J8FinmzkZ4G+AdWSGMr
 kN29PHqvtrPjpFSjM/Y86GkMo9r+haDryUtLhv9QYD4Ew3GQOWAgyrtWRIwM5TXHeRhe
 znnMTXZvnBQPqPiunlp5MIowhihinVDbtL8UJdTReAhEzXGSkXr19ekG1kRe7OobEz9w
 rtpw==
X-Gm-Message-State: APuU4Z85d4UhfjSCbBFgEysySNylR8HlN3VYi7lfdC0ID4ASdq+S3ZnK
 ZVtwsUSlnDWao3KxPwg624RlFKG44+cA35ad3GitjBUtImFkbGAVrAaWgI8+2exEVgyawZUXylZ
 oeG9r
X-Gm-Gg: AYBFou2kyLz2fa7SDPrL1GErovEV/V3qCcmpU9g9JQEz/mrvBj1vigZ+Cr79h/13kdW
 3EIKL4fraNYHtSXIFNRLdAeWbsmYanKVTr9byiu9HEOIDncYCsGocM6QN4GHXfzMnhNROEFlBom
 6LFMrbArc0UiZCe85GGGJQxOxskNeKurKriTacnj2Oil/bkL0xMeiSV+b6soh2KcQpyUmV+/DWL
 Sw1haj2rTontnlO1aOzZJS8srCfbT4Ov4CfKaixeCBLzqHeQC7L1/XKmr9lFwmID1Yw8LUoG8pl
 Gt3YzV4GGhsvHgzMMuUkYwl4+hk1SUjsbj9nANsqtj6anbbrcmlSs3vnZkhNkhZdh7Zbo9lRieS
 0PAJMZ/XERLSqvClMC7PRrFgOCub3iqG1hth3qq7rZuUUSI3qvRQLgLriNuQd74BuCF6RGP7zcN
 iPFOHWWyjTEY4pBOCdOz7derYx++hwmzHNojDO5poYu6tiHAtsIsRd3H8YrzXpt00wY0E+1yTCV
 4V0chIj9wfKClncDbaepZ26AQ/YgrQ7uRjuoVyrHcrXs/Ukn7xjz1pplL8vG2NjOe8yeDQnDR+O
 gckJN5FCjY6KeVC3hj+DBVwjsongJYrgqNuEzWmXt6PY5PCLfFp0LKvBmpYcEH30FcVuq9BjRff
 Tm/cfTGl2wV8dB3zuvKZrAMjBtWl55BpeCBctKUhGsluzSA9DxwTwnJJSi6gB/QtuO7Cyvr9v8D
 QgBLyT5Ur6rOvVON77zXTXwlKZgCppdWA=
X-Received: by 2002:a05:6808:5093:b0:573:1dfa:f0c2 with SMTP id
 5614622812f47-5774181c13emr4054014b6e.29.1795028922726; 
 Wed, 18 Nov 2026 11:08:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777b39306asm2052999b6e.15.2026.11.18.11.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 11:08:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Shubham Antil <shubham@octane.security>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, maxin.john@gmail.com
In-Reply-To: <20261105061133.88030-1-shubham@octane.security>
References: <20261105061133.88030-1-shubham@octane.security>
Subject: Re: [PATCH] fs: fat: bound getsize in the FAT write-path cache fills
Message-Id: <179502892188.3148473.12674338243431600402.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:08:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Thu, 05 Nov 2026 11:41:33 +0530, Shubham Antil wrote:

> set_fatent_value() and flush_dirty_fat_buffer() in fs/fat/fat_write.c
> fill the FAT cache (mydata->fatbuf, FATBUFSIZE bytes) using a sector
> count, getsize, derived from the on-disk fatlength:
> 
> 	if (startblock + getsize > fatlength)
> 		getsize = fatlength - startblock;
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fs: fat: bound getsize in the FAT write-path cache fills
      commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
-- 
Tom


