Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54926606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iFPFx56X;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jVZaNp5/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F110810A0;
	Wed, 21 Oct 2026 11:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bo4VP91YY6XE; Wed, 21 Oct 2026 11:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BF2D81053
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792583982;
	b=NFaFqPKHwjToWSUapjBKFPxIxdyGtcMJOvzOH6dGieawBmSDR7WcfjmZUiflUwbEjWkI
	 IoBG4JYPgw7hEZa2h6t0fwPoUSeTvv4C6AdBMJEjdHIFGHaHdI1Y57Wh3LqD3az2J6OC+
	 RonQxrkHGwDEgl25al0wgeEbuwN5LoJ+iWmqLEuj4j8qpDh6lIX8ih+aTBFJ5X/BIocDJ
	 k/U16Y0cbI6hnbvSi1TS+dpJGQ+6Ja68H79jHUcGVq6drGmu5H0hnUeEUKlLV1/A/xfgw
	 xNcgTxgppzdi6Yuc5DafSCTIESrkLP/wyfX4ZVFyIjeosDB30UjFzRtkGUiOO1ad3xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CCH5n67k+SwCNhNEboRZYmqlJpoJFRDLMJmgyB+kihM=;
	b=EoEy1Xswp+qprjnZw+q/fThGLcXkdxoosi8pzYw+lo3C3lKClO4c2veCzNbFkbaoKoqd
	 iRzcdeDkJCd6NCLbqJzHmY2rzqYMzvxSgOusjj4NImpTDA2RJ4wwbkDnJobrdI92rJgdy
	 BvZADaIMEhFqX9YVGfqJKvjSXa+63ANRxjqfepUimN3cnJWiriL1V/XEF1ENYemAK+Eoj
	 HWKkol6umR6bTR/tbOlSYNN4eDTYh98ONih3Q7RxFfu/QgKfEH4DOISgewbAJIB8TeRoM
	 VPUSois0QwpIYKX7EBKGyzPNpwhhtC7hsUMgrH86FM/1DXX+dMKlOVUZqRaFAheW6gA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jVZaNp5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792583982;
	bh=CCH5n67k+SwCNhNEboRZYmqlJpoJFRDLMJmgyB+kihM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iFPFx56XoMksVPZW2ekladYnPykC7ouCo1Uty/lgAUBS+quuA9EyLJzuH2ZEV1Nuk
	 bdi72SyrhfSfYsvbJRaxGJ5NfM0eMTxHOxRvF5VlNQfBmV0K7B1vuXjuaqLB+uEZgz
	 GUG2SC3jN6aYjB7HU3ToO3IAi900sKF0FaavwArIdGt/OrhzpgGC8NJW8NZJS7saNc
	 06FgiwgZt2P3LxGE6rTuzAgx+ZKWoL8FLKIkfwDr4iyvZ8OXpMqnWuJIEVtcgH4L76
	 aNUNW0qcM/dP9UEK4deI4oBmn/sVvjWL1eruLsZDDG02S5Gc1WvH9lgDQOPhNcEbEn
	 I+DQeAUfpAC4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BF2D81053;
	Wed, 21 Oct 2026 11:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE4F380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1B7280F88
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3JHNB3tjLnY4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A34F881080
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792583980;
 b=hG0PZccgRIFP20VGYEdE7Msb0vXpvdGIxCWXxQSIJWXNemWS01OLPpZ7zHNZOZUiKVGK
 FweVJFLzEBjcaVI5TuuOfrPtuFm6auOYnm2sUnQyVOmOrFG6PPzWosmn6KCePiMBNzpKU
 Jxrmb6a+Njnhe1swBOHpBmZ3FV8ZzFPpNFhq5AVxPqjWvPiwXK1yr9dg/rkUbimVsh+E5
 /HToYN2lIq1OsaS6Zyf34NtLZOEh0H0knSzruUq1sCnNY45hw0dBKR4tIiU0hNTNs1wyK
 SiByL/2DerKjAs79GHA/SCJx9aW1fp3i0xTm4VQBvPmoR8DMCAfKVh6olipQMMtHP+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792583980;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=CCH5n67k+SwCNhNEboRZYmqlJpoJFRDLMJmgyB+kihM=;
 b=mB8a1snP+AGo5IEfG1Z6y0zP633ZsCizPfJcbvmp5eKXwhLMvwK6fTh81XA8WRmljebt
 prEHQvcoJj6ExfAH89tBpdvjD9MqZwFDHmdC1rP20TmMrICrnhxoxjbHFM1/gwDdjt2I2
 cxME+rrVnKRkxiwX8Fe7CFhwBDQ5fc3b3uNXdjupJLhjSrGGenYonnrOL34Aq+kKoB5GI
 ZkdyKCYaiSO2fIfSKAgNG3Bfc3D+zR/dGNC2zRaWZ0f3prExmZhl3ps8+wEjKo3fBhj0o
 jRwOcMeAtFwBnQkT/AegGppbHeVkCKuW2wMrH2ACk2r7qs3SpiCXl6hDrqS9mb3bvUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="jVZaNp5/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jVZaNp5/
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A34F881080
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:59:39 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1199191f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792583977; x=1793188777;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCH5n67k+SwCNhNEboRZYmqlJpoJFRDLMJmgyB+kihM=;
 b=jVZaNp5/L74I5FkexLMfU7YxOHaMavY6r/gRT1yZ5pSu0xhnDcIYCaV43KxX5HSR5E
 OBXkhpLk43cd7+I2is3ox7HPMHqgwecytjdn5s/wyEdK3BhqBbBQiW3INTr4IU1Fv9La
 rSM/nA3Pj6N88HnSGWv+ozKNIqGMrcULXiKHXD/+iGdsnP4JtN0+ycrIKaZEFimpaYwo
 fncP+bRedffeddP9Ypdlqpvu1vv+tExMNS7BRmbS5d6cBQ0kHqAP7jgFHreZ0fCbYoxA
 9s0qlO1te9sGM8gCyyRsMNYLxT6DBgPx0kXDu0St5tLt2UUM5xaNoRWOgkXi5tcFsGUl
 +T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792583977; x=1793188777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCH5n67k+SwCNhNEboRZYmqlJpoJFRDLMJmgyB+kihM=;
 b=DakbbZPT8IUghTMFQ2GfC3IUBOK3dcJZgghxu6sdyWLUJc/62vvQablnBZ3DHLesmc
 bHiZidZVfN26CFius3mFzd8UZY3Oszkx7Kx4cKJ3OlBwPU3R2geUrJ4LXtGiMd6vpIKn
 fElfZU6udevvHTjOqRKlzgyI/DN2eaWHhtOfayn4nyhXbBmrVb6nkwREd3Y/dkgRFANL
 ufbMARH3IJGytP/KG43jkf5Cgz0i5LpcybhqoxWhcllbcurWRvn+MStLsjwLdREhEueH
 nohPpbRv59URFwd6UFN5QvLr7aaVz6eoSGrIARjEycDhFw0lbdOKSyCdioIG4wWIPcN+
 qOUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrTfJ3c42WavB67X4NbrMhDfeeEDdonqE8yiLf2rzSj77/LHipWL6qg1O5rE7o4WGJpKRcf6Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlYbtljWJV6gZ+2wdbjWOHM0AIZ2AxsjivPCbdAG2EQyVAMUVZ
 Co5IItl80LMxcb6v8DHT+ugnfBv13SG/dIM58ehxfqdhbLqd5b8FUjuM
X-Gm-Gg: AYBFou0L7aBKZqDknNEhxe1mOtGKhqie0u7in8RkLzy6/rpaGglsH/b0xm7IVs+QZxd
 DpKMx6IrHNS4Ap7r583kZ9YXbcN2YAFV5oeT+cunZ4x35NlcUtxvMVN/lrSnqI4aWbWp4iFkDV3
 ew4fYAbKyR5c1lbWrzXj6FuMfxeifJJgxpOmPuV8lB1G+5ayzn4YGQLMUwQ5IZXzOM/T1GFvdoX
 1xgRzArxBO7kNb+0BzwzFMzE+97pTrP0kEE2DaW+GZu0cKBMfUtBEsm+p9ffcDICL0I5fLHRMDv
 jkIxBQRbBeBEpo31hXkjl4tz5GbabjEqKwyv09BueCWFJpwq71j/5L9JXxuxjXZ4cP7RTd3qECT
 vMnkIPGOnK6zipXnP0BZtSCr2xbP4dkSt64IbOXCYZl6bGj66pI6y70+nIS5DdubfGChgkt3Zf8
 Abu6IKy7TnvdiJ94MGcalAv4Jk3o5rgIUPU0afHOM65yBZWrG/kUHZBuS9C9nF02C/wedsTmS0/
 HrDlkgaM4tm4zWV8f1WUVq4ybQGKyMYntNFR4/WumiZ6DtHSHGCrODKhaNEQQ==
X-Received: by 2002:a05:600c:1d0f:b0:4a1:de8a:6046 with SMTP id
 5b1f17b1804b1-4a1fdb167f8mr37669955e9.3.1792583977089; 
 Wed, 21 Oct 2026 04:59:37 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a20049941dsm25832845e9.11.2026.10.21.04.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:59:36 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
Date: Wed, 21 Oct 2026 13:59:34 +0200
Message-ID: <20261021115934.4136992-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e26932ad-c808-44ee-b5d3-c3f159acffe6@mailbox.org>
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

On 2026-10-21, Marek Vasut wrote:
>> +	if (ofnode_read_string(dev_ofnode(dev), "dr_mode")) {
>> +		priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
>
> usb_get_dr_mode(dev_ofnode(dev))

I am not sure what you mean here. Could you say a bit more?

Thanks,
Mehmet
