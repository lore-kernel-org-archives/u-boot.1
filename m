Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506B606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b3wEOdTS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOUaEmZq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E97C3409F7;
	Sat, 28 Nov 2026 07:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_voPuwYmo0C; Sat, 28 Nov 2026 07:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55DE6409F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795850757;
	b=FG4+QsaVTlVkn5YC0Kw3f2tJWyfcxKEqTmluTdr7hdJoCuCXtc9TxnrIoPMPVzpkFrIh
	 oNydTvLfOd3Q0v5b4W1RGIHMEWzH89S3JHSKihyQs+cwTNft4GcdkOcL8mphYRsPhyw++
	 NNix21/CZRMp7i4DgoImhNhZPKtYeBsUffbb26QEssPVjpW7/VErAzmixpJO3uPPptSvo
	 Ou1HXyshJPsdjfvwfSJvCnHEgWg2CkVnkwHllvAy5+fPjsHiVdVcEir7jkt6PSNyXzPpL
	 MHoYNMRggDf7VneI4ef0saYfO0nGpIyZmQ7yr54gW16OR9eapSk+Btb6C8e+ao4zjtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795850757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dq5CdruZzc/ZtJvJsa2oLDMP/ui4Rha17Zh6dXOpzT4=;
	b=in6LEpSkm13lCS4PJuM1sO4hZ4Qcj/J8xoGvbvV9s+lTeHJ5sDJQ7sPqeXrGeW3H7XFm
	 N52casX0FKovv8s5JelBT7rc/jPVzHaWeljDR/E4ozHWsvZ0FSlHHSxqNBFkSojB8KDRs
	 PKS8FGGLhM6xYdRZnA5tHBy2hKTKs8VqGTSy8PQA80UQqCjcgncd+32wt1F1IJe7vEjKY
	 fSnVMtqlc31+rvm9r6DeSUAmBev7IJ87xmQ/NMeiy/peYeoR3elsbzUDgYah2U4VIoBz9
	 cD8xoUkCgJREd/wFW0HyNpvO9Bg5/v3uj0wGjiWiF9Dsgb7p1+UcwUb0IXcqk1vQVVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOUaEmZq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795850757;
	bh=Dq5CdruZzc/ZtJvJsa2oLDMP/ui4Rha17Zh6dXOpzT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3wEOdTSDKT4a0IbgEDmfbwEOJdU+1l1QxAhQ/zXFQ8YBkkJioDGkD/91mcRwNkVC
	 cXzTG0E8SnNEbaSKbbaglw8mI86NK2pCqwqgWQZ5kVuZlpRRdahMjZBzzhLpO+ZBSi
	 NdfE1GAmVKkKHtcZCFfWCdEIgFlxHbYcXod8n0YgpN/wiBwa3n96wbbM1YgwWmBKEG
	 7CG2F613MTAN40hK+s2jn/a/3qFOqzYwZbDMZYLAMmu9rIOQZhRGXt/+RTZlB2kTkz
	 0b31KikKmRJTN8Y0qvYaS3CXNsBs7u27OZZeBpp56WmqXO3LRcuLlhedht9DKD5NjK
	 pLjX4FxomNVnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55DE6409F9;
	Sat, 28 Nov 2026 07:25:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 478C62BD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 391DA409F9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XiGbVljM6fjl for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56A20409F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::836"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=GOUaEmZq
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56A20409F7
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:25:54 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5361e313e63so120236331cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795850753; x=1796455553;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dq5CdruZzc/ZtJvJsa2oLDMP/ui4Rha17Zh6dXOpzT4=;
 b=GOUaEmZq9VA8xTsaLABRuLULjj13z8WMhnS9SF7YPOVjPEkvgjkEPAl+qN5T+II6bc
 68RGAg82kOt4CoAbk0SrSKeq3JwEMzKsDPjuNuxFwqDG85hflVIQvTUNdkA5Nz3EaO21
 7cc5AGU8hCu11Lgh9l8kQ5auCP/wyou6a70/2nfo17axGC+YLFA7f1/bIvHGEykDNC23
 nN9JdFvkYrMaqWTbx0vkKiU75bhcpq3if5YkJ46/xepxA1HFk+KHxQanzL0pzn0GqrYT
 23sTQTxepEGIHYi6rf8YIbkrhAM72JIICIJQvs9AQziUl6e3ZEOt18dKMv7UwR8Elj1z
 uMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795850753; x=1796455553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dq5CdruZzc/ZtJvJsa2oLDMP/ui4Rha17Zh6dXOpzT4=;
 b=dQdiJf819RvXL/F6GLKKnbbfDnv4iaA5L3qh6s/FBRWbd/6Krebx7LYb8gaRN94yGR
 UMWHcdVNx/hFgASVLweTYM+IzhI9e/fatoS503HnrfUBgoy68A9fifahWVPMmY3Lniqy
 Hzioz+JV1ULb61BZ0GmlEvPYwKaC1QnOpVc5OgMR5B++xvfNSDgPpkvbobkGEpe4lfOY
 mL/PgR/4DksnQL5X/kRcQp8QnFHhQ3oplIsi9xlnnau/v34F+b3hXj/qXPbb1ojDdNUB
 fwKV+i27bv0W+QW2KDAladZvO6Iy0mUHJfmGTOL0qf3KFDo0WYTAMM98XaPvyrz+X8CT
 8nxg==
X-Forwarded-Encrypted: i=1;
 AL+hErGIkCUZ+kpuy06ZES2L33yJcm3JIHkxy7CGm/xBqX0zJc2MMw3COYY3mh0gnfSci5AmaQOsIjk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8+OM+Wf5fAzA3rF59qavACG+gixrXj+OgnscsGjPxkHyvJF50m
 NfX+J46uWBmPBtToqVEjW5Wbrg8SVLq+ZTeVfDYO6copvDjvGC1sbbB0dsLicRSS
X-Gm-Gg: AZFdTZcpn52sN3W0h1Bfn+EWG3F8/1X5BlnwoTzN5kB4e20mpvPrrXPYM2SAAZmu+oU
 dPl4l1pN8LqRFFJ2gWfdjyCWUQNYCSA/Scjm5DPT/xaFhCzbaqurXCwn6DMtjic4bgsEfRHe//7
 2EWusmCvJv5cwEl0whRAB5ABZUfjsA4INzrPKT7uEPL/aDwf8eKU9/TSE0fg9dlZixvQtH07P9b
 zIZJPSk46x2LXZa9a1xgO44mrnEd1xTMgEyQHEuCaAY+y1CHxQJweazsM/hPFWlz9pMSO4mIAWW
 GyIQfco89SDJhyChDh6h3IMsjCrNd6QEOX38hClmH4GkQ1rR7HSxFUWz4V7fOIcSVZfU9UTl0hq
 kqBRHPtYtwC4RDBKwMJZePJvRlxPKDv16I2Sr+ZUoXCDZLfC38YaBHBPE3v+4nR0yUoccsuPpRL
 YbVrTeT/cda47wvVAyswiI/G3RyzM7Ca8i6vavxZanRFtht8ZX25bO4Am19bY0po0YSMaw2dHiI
 um8eCRURFpnnXnylcsaSKjUV/9No8hbkSJClSpG4ifOmmgZ6tz9f1a6f180402C2TwDLehVwQNh
 AccdOrm52/gdlQTbqsHuHpWuF7/dPXX11PE=
X-Received: by 2002:a05:622a:4889:b0:535:1683:5a71 with SMTP id
 d75a77b69052e-55d76a185a8mr495344301cf.38.1795850753594; 
 Fri, 27 Nov 2026 23:25:53 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7884d01csm226763451cf.21.2026.11.27.23.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:25:53 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH 5/8] usb: ehci-vf: enable the PHY clock through the clock
 driver
Date: Sat, 28 Nov 2026 08:25:49 +0100
Message-ID: <20261128072549.44595-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <5bfa7417-ead1-4d3c-a0ec-0e5126b9f1f4@mailbox.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

> > +	ret = clk_get_by_index_nodev(phy.node, 0, &priv->phy_clk);
> Can we avoid the _nodev function here ?

Only by giving the PHY a driver of its own. The clock is in the PHY
node (clocks = <&clks VF610_CLK_USBPHY0>), and no U-Boot driver binds
to fsl,vf610-usbphy, so there is no device to take it from. ehci-vf
already reads the PHY registers from that node directly, and
sun8i_emac takes the clock of its PHY the same way.

The alternative is a UCLASS_PHY driver for fsl,vf610-usbphy that owns
the PHY registers and clock, which ehci-vf would get through the
fsl,usbphy phandle. I can add that in v2 if you prefer it; otherwise I
would keep _nodev here.

Mehmet
