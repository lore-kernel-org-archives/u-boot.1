Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBE5C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53BE660642;
	Fri, 11 Sep 2026 16:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhYieRLn4-ou; Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 999F4605F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145465;
	b=DcB8lW6vHSoF7qTfxwfa7eDoxiFTJLAVRdE8s/YKYetdiNXmI+11sXkD3zTVbRSI0O5+
	 GOVHnIAhalRiCZXTBdODUbKVp6I0cT0X/RubqF++2JUM2VXeBjUsk+iLyM4wh5WyvTBCE
	 IHtxqX8QqIbx1vl3nGMOlH0H+7MVJySueOEt9eOH53xSx8Qk0G7Bca0cED5Yr5ltOZImE
	 3QZkikKs08OHBfw5dY2iZQogltTPAlQF2eDyRfIGkOYpnfzRZJySpT2M/8epAc1U7KpqA
	 Mp6QE5cDBihhvVinC+iGajWKL8HuTGJBmZ/KXRMEJMpiFcwK3A48FJEWsDosK0P/I6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UNWCtD7IeOk8EMpAcn30/ybAlppsQsWVSLPiJ05HfGM=;
	b=XAuxdPF4A7JU5FoG5fMhO5D19alN60ouhhv+NxTrO0uuZpwyHBUj3DVK5S0IkmiwikA+
	 L90xwYuJKz7444swb/RYISdWllctFGYx4MMfETwr9QWDFAWiUssq5GAR50N5cIPB8VhHu
	 xLGzLsC7EesWFoKACZ31oO5H9PcV979zdXl6YSYabq2gwuvggh2lNsX5GbdkJJp3jA2Ng
	 6fDtT+ax5OIt/19ozF5ZDCQmZOaG4kTFghoDOoduXfxB1JI9zna5qPAYqBglC/2m4YAGR
	 0ohcBaPQVkhtZRFOuD87EWwTkQjrPrtGFvdyV2Kwlqz+h5/ECVRQCpNI046SHmdHp7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145465;
	bh=UNWCtD7IeOk8EMpAcn30/ybAlppsQsWVSLPiJ05HfGM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J29DZCuvj1RSrZX4VRlYgWD9IVnp62r3P7jZnbeU00HGy5xPhYooKPzQ8dEo/8coe
	 X/XbQW/Bk3RMer/ACq+NpIGj4B0X+bNNajzI/jtLYAeo0cOMfnrzwJXpovQTxYCBAP
	 6lTp++tQJQuPmAGMSIeuqG//H4LrAeD6PvvifZyR31+/TvDKU7LlsngVCrIt40UuwU
	 FfOoFz3XXZBEPMkyBCPqToDsnjp9I2qesM3DDSTPdFT1OXBdXSzu05TkoVZLjvmWPB
	 BBYn30OfwWLUh/E7E7BnuBwShdXJ+5nT0mqfSyiqdi7e7oBsESd5RC6OZhrOwYrpfF
	 W6q82H8UmY86w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 999F4605F8;
	Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9945701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B61140805
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qutnrYRP4g_X for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E0C21407F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::15"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145464;
 b=suU8smQKa3fgLD9ySQi9hXs3vNax6XkEyNIOpXC8KRpKOBXzFPeipb2vG0t0x6IzVGVP
 Dert16dYIvl0u5bZHAvaVIC8Si/91WzD6D3eI0S593UOvttKcM381kHrR1lcsJDd7CM5J
 vDU6k/nULFZ/zlg4C5ZZjQchft2Aza2QeB6WBoHUbQbGi19DdlpGRa4L/MftPXwQ0GHJu
 sn/gfG4V9A3swLeVDsTzvnhA+PfR653bRp14U9sCnNVNmI/2wpAqOM6ShnShGUrkT5ZDk
 5ZEu+uoKJ8lMk9JyR1esF9pwAXXkjX7T4o7mTyfbjWLSUGw54ohnIGnoH0utDNsiVfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=UNWCtD7IeOk8EMpAcn30/ybAlppsQsWVSLPiJ05HfGM=;
 b=i9hrd+oAmGDYYXCUXt9ZD1jFYjq8gz7bw1tLmESLZvAV5h0h6ij+xDBaJjOtkBEQkW2c
 1CtqkyE2hnXMrE+zicPX+h4lhq47ySPtHgJadlJsItjW1CqJhR076ZOaFMRTuINcmI5ZR
 gLBiRmL3k+vpcShrLbJi/bIJSW/3t4N0aL0F6s/xNGFi4SQNirjp8XoSQcnXwifVc9zRe
 o7g29hGtaqDyXZdIFCNT7nljtGhvy4Hk647XxJffmrDjSMnlqzxlpHa5D9LhBIttcl5mL
 RNGjyyHgbEmNtZDykyGzONFwVTIGyjwlnDz/HSdB0lPpG02ifg2C50oSO6a/v3ui+tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mQzYRFQ5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::15"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::15; helo=mail-oo2-x15.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mQzYRFQ5
Received: from mail-oo2-x15.google.com (mail-oo2-x15.google.com
 [IPv6:2607:f8b0:4864:31::15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0C21407F4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:03 +0000 (UTC)
Received: by mail-oo2-x15.google.com with SMTP id
 006d021491bc7-6b1ae739df3so15463eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789145463; x=1789750263;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNWCtD7IeOk8EMpAcn30/ybAlppsQsWVSLPiJ05HfGM=;
 b=mQzYRFQ5rofa78z/8fyNja0k/OMfEek/YDMCRZ2RjfHzmP7vxlNd6a50iRHiwVR73B
 0kkStq2hiUYn8BYMO7rCQkvB1H0SC5/AAp7E5GbbK7FCiyiiTxtUTdkk3WgPm5krBwgK
 /P4dlabs9VJCOXFgBzEnHDYaYmY+sAta4DxSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145463; x=1789750263;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNWCtD7IeOk8EMpAcn30/ybAlppsQsWVSLPiJ05HfGM=;
 b=qUDowBvdQQDXFOqeKFHkHnMDihLHxAKa0Kqkt/vNoJhNpeHeaHytA3+R2ETMQqA0I7
 uqUzsKBbyUXOVH4+0a9nnIww2jVNYWFK+lrEaznlHs3TQMX6CmmgfJrAiI+7vjk4/dhu
 cxfMT7y8DX0D/ETQ9JGGkNCTzBq/qr743Ov2cE1/CYj69XdPmtR7qf7RK+B5ZNca19n5
 jXumcvK2mRu7IFzxjZvSaQ2RuDb7uyFR1YE3Iwt0MVqUc4r/Q+Q8O75ZHO/s1aPisFOf
 cAVjTG4upk/9XnvdJ9ahUvgLjCOc2D1A+pd4bDWIcyK0yVsLQXH2KMmR58cf+eMqw4tF
 Bhrg==
X-Gm-Message-State: AFuF++mVWRKJTfwSrS2Y4aPasvb/HtT0Qp858smG1Vr6KlcJaj0iVI6L
 865titKDtRhrhBC0hBJSw8iKHyXW65MuT/qZj51e+yPcmFIYBIuhJdMgkRdS+8TwCgE=
X-Gm-Gg: AYBFou15cr5XyWUwRUeLW4y07mqydWxjHjcoGlUMIa1KZycarMJsNLSd4CHw6cUVdym
 /oHGowrvz8ZUbLiDyBUaw3hWcpMauqUPRN8TNe6tINytHyYnIGl6mDw5hHADv5d92f8ZSx+MetO
 YhXN2/X7cotrZR28UZj+9L+UXIJ1FMQnnsYhVyban3FV2eiv/BMxgBpsG3jTdfLjbUc7nOj/jdY
 ychA0gc3+Y7TcKdR18OBE4TvcJ+WjG6uzFw4EAcDMfQOdvkacEwfXDYyP9Tc1rRuLhvBOWZLrHu
 hFUzjsZJ1FSu4pmv/oGUNIA+sdKRKA4x3SmiFzXVyH8+bf5+ZGQ6Hhh7qrcBvnHQzbDGESyOJuk
 NPLVncr6ASDI2bAll7SoS3W2D5we6v7gqbkloAYGBiIGCKY8PFkq5oO0loktvAO0MtLBY2WxB5x
 4LtYAxK6P43mjzDgLXM8guy8++4EMVrhFfDwCES7Kg6v6GU7Y08G/0wfRcriq3stRkQDPC43yKK
 /8WwD/c2a6abvKb2U4+pEjnYB07KT48vUmTJv3iDqRbfu/uP8OOe8Clgbp+6TvOAZFoEaZLc0M5
 eb2gZ8slmQ5aMCSH9Vk=
X-Received: by 2002:a05:6820:5710:10b0:6b4:5460:63fe with SMTP id
 006d021491bc7-6c0a7065fccmr1896008eaf.15.1789145462601; 
 Fri, 11 Sep 2026 09:51:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a220714sm3186402eaf.10.2026.09.11.09.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:51:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Wagner Popov dos Santos <wpopov@gmail.com>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com
In-Reply-To: <dd41a5d2c229c146d42cae76cd1ff903d7be7a73.1787320113.git.wpopov@gmail.com>
References: <cover.1787320113.git.wpopov@gmail.com>
 <dd41a5d2c229c146d42cae76cd1ff903d7be7a73.1787320113.git.wpopov@gmail.com>
Subject: Re: [PATCH 1/3] mtd: nand: omap_gpmc: report available OOB bytes
Message-Id: <178914546127.3764906.15516628220547810398.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 10:51:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 21 Aug 2026 10:49:13 -0300, Wagner Popov dos Santos wrote:

> The OMAP GPMC driver does not set oobavail for hardware ECC layouts.
> As a result, the NAND core does not report any OOB space available for
> automatic OOB operations such as JFFS2 cleanmarkers.
> 
> Set oobavail for all hardware ECC schemes after reserving ECC bytes and
> the bad-block marker.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] mtd: nand: omap_gpmc: report available OOB bytes
      commit: 8abf3d9e1bcd245be51c52482238c98d4f9e6efa
[2/3] mtd: nand: omap_gpmc: fix BCH16 OOB free length
      commit: f9b7c7ad77707d7e01f9cdaf61603c0e3acf4c42
[3/3] mtd: nand: omap_gpmc: preserve OOB data during BCH reads
      commit: d1f43e5ede79d8045749b1d5b98f8ab6d034ecd3
-- 
Tom


