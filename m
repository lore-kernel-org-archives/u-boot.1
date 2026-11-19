Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463B606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zT3y8wU1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aE3z3HOi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63EA7813CF;
	Thu, 19 Nov 2026 15:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_ALgARIvj5Y; Thu, 19 Nov 2026 15:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA11681372
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101737;
	b=sQI63A7YxOzyv7WvwmU3Qkers/MfBQPSM9muVKAA0m5e+R/WkPp/yIARAgR10Jr1oTqu
	 GxWfHXJJSRWwaFCUYR9xV0wgsOvN0fbFYSyk/0qV9ZvZVfI1toq0E8M8cqO3Sjzw8H+c3
	 UVGJxgi7461Hqy1FtzHby2UZmenrzYhPl2Z6H82KkrVV2O45XeHkb+BMx4ueSNJTL3lVw
	 8tb8sQBu3baHmBTb2G0Fe3+P/aY5p82nQsRZAs+o6GS83+4PWQFVwsGieYpGnSSbLfmWY
	 FvIh8crSic2mh4di7HK+ySzSN1r4An6KpCe6Ff1QOo/fmzQENBx1PPt1HuqO65z7O+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oXGYWKFYClGp6LlmMvKOxT+CghacHftZsu8ZMdUCOzM=;
	b=RepxuALWbFfg5N5ISW/gYaSiGk6QEA1z+L1fAjiLU+xg9ZQdAlRUlqbVe6GprQ8nwnOJ
	 mteEZxQ0lI06BuM9u0yBVSlWyiOuRId2ovUcLvh8TFfT0nlST4CrjvkiuU8bKHdUTJC8W
	 oX6YeMSJbyw7tn7974riQwYPLKmCzwRuLiXjOieCAeYTlb4//zUKnG4kjt0rNXqy2H8HY
	 vLSlFlQecw4utQrUPmQuvzUy0O8d0wpo4hqLIdSjIoVP8mB3VKAEgrZv1mjeDLqsVVB15
	 6aASf5j6YskW3B3+KxYenk1UC4sG4juQXz/Myn+BKeHMa11vLiYHFw0p/+c3L+hM4Ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101737;
	bh=oXGYWKFYClGp6LlmMvKOxT+CghacHftZsu8ZMdUCOzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zT3y8wU1UuHSEAVvjMsAXPjLAhhi0E73aowhtZEAesGf0sFXpz5dtDib6hGMcuzXg
	 kxHLmdMhce1mubny6Dtf4MGpKN6yulV8ivMtNt29OI8J5g6FjiGT95HeRVqtlfM84w
	 2OSFjtEz+WGbh/hDfmBCLAbz5hSu4Yz1RQLk9V+d6JwiyuXzag8LqqvmHYdcWhhLN1
	 lp4vtQUnPosUDLNSbb7iCh79KlK/eeTPsPr5zywdMWgjYFroW1gbosT5aSGUEsUZ0C
	 NVaVTTVaoE6ZfTd7tPdZlyj+QlSYDu7U2YNytTWqSuZIsHXxzZ7uDnTH86KTl+y2gB
	 CNEaCqcIT0zoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA11681372;
	Thu, 19 Nov 2026 15:22:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B17FE1E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A334A40562
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hSSUGtCbJhx for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:22:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE61A40556
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=aE3z3HOi
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE61A40556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:22:14 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8b5a6f2f27fso1196540b3a.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795101734; x=1795706534;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXGYWKFYClGp6LlmMvKOxT+CghacHftZsu8ZMdUCOzM=;
 b=aE3z3HOio1lzCeUF+0a8aQ2/7GiNxcZAvNvRoIx3OxWMVFUU0NuTJJYVlknVF3T5xm
 +rfNgFQ0uhAvzwjx+WQMXkU0rHKer2YaC5c8DC+h1D4bLPoa4NrbYMKKAW86AT+Q4oi6
 Jg1jwSG0i2VKISW7eMKkAlfrq1RqOfgj8CXzs/zdL9NvmOEQxvZs6mUBVkk9dqm6g6Ae
 Kt7y73g0dma1CZIPNEhhzSBcCyZHjh6BajXXA8uZxsTXhgEy+/TdgfxtZyu9h6RdcFUz
 FM5RQaWO85LWvDsQ3M9Zng/krQ/ZxQauhtfPee6FqylrCkBBcnr5hgHVvJ8OWejuPzmj
 zJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795101734; x=1795706534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXGYWKFYClGp6LlmMvKOxT+CghacHftZsu8ZMdUCOzM=;
 b=qIoiYHTVFZj8jRg6QHCR1VWOykPDFpkh/OT99PZHxp/L+EYXoJ1cBSeZBffV6ZVV7C
 kLKi4lhNkcWKIOkzLUxY4pM42CN7zvIfBka+YhZLhpHO1MVlGUiiUlqHmSR+oVYeeFcY
 uMhd5CsGSkHj3aK2OYcKx3yU7tsz+dc2JNlOxSX9UJ2pi4ygEaZOmVawnk+Miz5dtT+5
 p1M32rB1o/f1tPTFXilO9OE0v6RhPk+qa+f2H6yP328KEeYi4je+z+uN/QxGF78RzwCg
 V0P6rQVdvDFfyZHacO+Qe6mTdgUPtc+5YmhnusYupHBcbYU/2s9xZ3d4XKE/4Zil775H
 cYhw==
X-Forwarded-Encrypted: i=1;
 AL+hErFDKnrmAYg0+2Ez9Gy8rUECUr27ZSH8iD/YLtfy8damZ8H3Ni3H5d0/Cw8+/RCYcSHIFcfM6Jo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Ys893GCkUdXhlnb4foniudNtX+x5y7MY4CrF4g/+Ge2YO1PDM
 IJ4QdzsMYQH6WesojUlSvlyYJ1GPFE9OpBUj9tu8fMUlK2qiZNBmoBBo
X-Gm-Gg: AYBFou3x65ltVqLQuI3+/7li9jOiB3J+/p2Cdy2DMXUOhvwgR6nLuaQ2OKgU4SJehSG
 K12Ny/U3Yx79jl8kKt34Iigao5mlpDDlTCGdR2kgrRpca+akCT8n3hrsyXKgszJOKDJbS80klZN
 SshrnWYhXHvJsKgoRU88iaKkKNjz45mIQyhlkIjWrxcmQu2v7tWEBh1OK3WvJ07ZGSJa9ktry8G
 VmgpbMucw+cjC/5FHKYnpdGLA3MhmsaRhMPwrB8RbkoxbrBpO/4sHhELVSqNUjRC22j5DhL8b/Q
 tUDkgehbEpF49VxfiB9Aw9mRCTdjro1EuOOf0UE4C0wD2cI5UCcklUD9U+LhWocmdrfsEpjHmFi
 XwPBGOo2hUkBNQuhNvAP7ruKkYlnAxMCPU0FYmyfiG0mY6iiSclYSX0GYz5ln/TJYBrZfnhvT5K
 2ZXSsket7P6C1KMF/N7Rt5/eFsRPNijLrsNxHWPHhx2XwmPo6CNESmaydot8nOAKzSw+Zzr8iso
 AATiTktwDt31F/whexx7Vnw7q5xJqrxeghB0e2hM6pdQDeoHgJYw1q+N2E1tzJDEa9qOjuCZ4jt
 eNmF79Bp0Aw9Idn8+w41
X-Received: by 2002:a05:6a00:a02:b0:89f:e1e7:e7e8 with SMTP id
 d2e1a72fcca58-8c5d314db20mr5571640b3a.18.1795101733699; 
 Thu, 19 Nov 2026 07:22:13 -0800 (PST)
Received: from Arch ([103.94.107.232]) by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8c87285c89dsm64910b3a.13.2026.11.19.07.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:22:13 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/4] qcom: RPM power domains over GLINK
Date: Thu, 19 Nov 2026 15:21:48 +0000
Message-ID: <20261119152151.109782-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 12:51:17 +0100 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> RPM-based Qualcomm SoCs (QCM2290, SM6115, SM6125, SDM630, MSM8998)
> vote for their rails through the RPM, which U-Boot only stubs today.
> On QCM2290 the eMMC therefore probes with "power-domain driver not
> found".
> 
> This series adds the APCS IPC mailbox, RPM requests over the GLINK RPM
> transport and the rpmpd power domain driver, and enables them in
> qcom_defconfig. The link is brought up only when a consumer needs it
> and is handed back to the RPM before the OS boots.
> 
> Testing, on the Arduino UNO Q (QRB2210) with Linux next-20261112:
> - the RPM acknowledges the requests and the eMMC no longer reports
>   "power-domain driver not found";
> - Linux then binds rpm_requests, rpmpd and the RPM regulators, 10/10
>   power-cycle boots without "Invalid open ack packet";
> - with the link forced unusable at probe, the eMMC probes with the old
>   warning and Linux boots as before.
> 
> Not tested: the other glink-rpm SoCs (SM6115, SM6125, SDM630, MSM8998),
> which also use the qcom,msm8994-apcs-kpss-global mailbox fallback, and
> Shikra. A test on an RB2 (SM6115) or another glink-rpm board, to
> confirm nothing changes there, would be welcome.
> 

I have tested these patches with Xiaomi Redmi Note 8 (SM6125) phone.
u-boot is working fine with these changes. Also, I have written a
regulator driver to test the GLINK RPM transport and it can enable
regulators for SD card.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>

Thanks <3
