Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911FC5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 12:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 742FE80DC9;
	Sat, 15 Aug 2026 12:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0uyz-H0v9yi; Sat, 15 Aug 2026 12:32:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3BF080DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786797140;
	bh=VXCCRcJ/3b75voGRhOtE00TNgvJVJ/eDZO/K86yi9j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jU8OSMyJDwwgZLVV5WWrZyB246sEe4pfs6z+xLwk925KSVL7mWXhKt5uTijNDFkgF
	 ycZ0KdGvhAAWTaWtrQsCT89QlrnaiyM44eGi6u3jo8JXrdWNjc9XQn+dS4ezGmXerj
	 etomyNI1h/eGXXPxRScFiTUSAcUiSCu8q9UZNKPFMeVviT5TaVts8O08ZtVGTYEIOX
	 d0JKzemaiblo+FG2tGmiuu5tOcOgsLk1HD2Rshn4omslI7UyO1SdHKUjSxJWwrTb2w
	 VCm1PkshCm82pgSVcj8lTSubm42cHmZxjqd7WIgTaf+muXVEfh47CjLtnqOqbvDMcG
	 DPFLD19N1DvxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3BF080DBA;
	Sat, 15 Aug 2026 12:32:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 629CA361
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 491D3407B8
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zbzgg0Fi0Q_z for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 12:32:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 20FF9407AD
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20FF9407AD
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zTCs2AUQ
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20FF9407AD
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:32:17 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8efcef23d21so10771596d6.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786797137; x=1787401937;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VXCCRcJ/3b75voGRhOtE00TNgvJVJ/eDZO/K86yi9j0=;
 b=zTCs2AUQGW+GNPIHb+l/M5xfRXpCnR9kBXjZEp843Ek3ST3Wp9K1qj2Wtlse4rsyfT
 fdRmahzmwG1vnUtf/5cr7n4xY7sP6ix0DoKNHCYTHePY5z3b9hbuf14OVfqGhD7K1Q1Y
 IYYCLWD08XniDJRCKkAetR4ee+felNER4Xuz7rKRIaFeRCzWjhJCAqG96PVU5I1BO4G5
 6d9YLstdFOayi86po8iVmlZIVc92ClnkvfMxaMiKs4IcKaLOK5M9m6pXQrIRyWFCZVho
 vE1BQiMHwU4DhxL5eNST9gSWTFDbUwOya2qyx1sx8uyyrp8wxo72ydlYUwwBLLkhCifN
 vQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786797137; x=1787401937;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VXCCRcJ/3b75voGRhOtE00TNgvJVJ/eDZO/K86yi9j0=;
 b=d/viOAvucW13+5i2pizbKc9x6R8KZPGkIQOkMIkUs66uLmtUbcANH0dtJkWZdTSAZv
 L71dXjM+VJhsb70UmTw3EAn8wYOvBKmoWMk9E7SnVX7Z1BHTfaJc2wvHQr9Anz5i9Q7l
 PBzGPjKE/iXXO0MykpDNeZIO+iI3gPArJZQSIbgVaDB0sMO3+Ua9lqziJwT7bXytuvzA
 TNgrnKgVrDHtxjpY84zFaXsl8PNEzPEG1Xzc71hlAtKcQXBc7W04HSZZkd749fqDwv+p
 9y9lhOoHq8axsNTUH9YUWq91LLtwFx2C3DNMtmJfPm9bidB5+Sz/PC9xhbvXg9gKV6i/
 D5JQ==
X-Gm-Message-State: AOJu0YwgiuLkn7Dm5AtOzQfVAvmzmftsJ5l81KAkLESrhrWxK7QCkpc0
 QSgr6SYD7pv//hQA2DCG++rR3ZfG9o4I2zM3eP5Ph6VueLdsRmq4sKNcZ4WbSjNrF0o=
X-Gm-Gg: AR+sD10MBNsZQpiYNsJad9j2X9KZytoGcD67g0YMYi3dJ5tJJHb4JhIke2nsNXg1HCi
 1UFhsLtKCV9gdXX1RATt4643qK26q7KFRYlvyV/f+FoumHBkTXw3rDKSItQBjDuofW/h78KGk10
 1fyN6Xz8yIwUz9mMxf+TkgIDqPYXDBHvlgvZSC9MKpSGgPa7nvCDqvkuWTeu94vszB/ymhNqW+m
 WfBWCopP5qiVYHMmWNRIsJbAmTFYqUq6bkBnd6Mm9uEW/CrqVFNywlC6SQzw4Li8TlUhoNZq4kE
 Y0p184gZM+QkYF9vwp2dl7DptdDDT+IGvilJbROhxcqyRDE+Pl6ADalyEGdZlQuRiicBqk5AfDd
 voGuqFbY2t7fO1/16geq83Xp50XpUUsb1TQsAyERXyh61YnEMveMQ/rwzsrYpejx8Kx6rMTNImK
 rsxkTvR5J+NCa65+NgMEmLBnzl5pLmmQO2d72YuFf2BQgKfjzjIorwsmxiYqvhBnIqqi+4TCS/1
 n0G8p7CtVZctqXqtkUCbJaNXZcwpedZVc1FKICXkhRwctyjFZYsHg==
X-Received: by 2002:a05:6214:4808:b0:907:c6bb:5ce4 with SMTP id
 6a1803df08f44-90a91ea5d42mr159668226d6.32.1786797136581; 
 Sat, 15 Aug 2026 05:32:16 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a921e59ecsm41985756d6.5.2026.08.15.05.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 05:32:15 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:32:14 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v2] mtd: nand: add Cadence/Evatronix NAND flash driver
Message-ID: <aoBcTpC7KNDuqSpV@maple.netwinder.org>
References: <20260814-rzn1-2026-10-nand-v2-1-7aadfa5ca3d4@linaro.org>
 <3ed59460-f04e-4eff-8839-bc766fe52292@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3ed59460-f04e-4eff-8839-bc766fe52292@mailbox.org>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 15, 2026 at 12:28:01AM +0200, Marek Vasut wrote:
>On 8/14/26 8:31 PM, Ralph Siemsen wrote:
>>Taken from
>>https://github.com/renesas-rz/rzn1_u-boot/commit/76c8d3bf19dc64697dd964d7f69ccb3f4fae0094
>Would it be possible to port the mainline Linux driver instead , 
>rather than some downstream one ?
>
>drivers/mtd/nand/raw/renesas-nand-controller.c

I did try to get that one working first. After a week I managed to get 
it to detect the flash chip. However I couldn't work out how to hook up 
the exec_op() correctly, meanwhile cmdfunc() was growing larger.

So I decided to try the "old" driver which worked right away.

Ralph
