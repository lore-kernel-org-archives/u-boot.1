Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59B9C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 10:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F4FD40758;
	Tue, 18 Aug 2026 10:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bO4svdiazsOT; Tue, 18 Aug 2026 10:39:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85F0440760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787049568;
	bh=Qu6xNLlthSmM9yUV/NcF/2x3Ca5rRWDx/iwKAFYkyZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j63rnwxkimIFjVxSg2cmFgDFPVRDy8klIYNVaWH6mtF2cIcvq0RCsC7s8zcTJVyI0
	 iISuV8xd52+t8UF4PeEPPP6qfPnxnw/F/2ZHUkHBVQ23D1omtXxJys06j+Oxq6zYzz
	 /ejUVH3VZNZ/eDMTkc1whjdrEhAIjrFPRrO1LrNKRWHB4HjNVgDwn8EJgeMgnRB6vs
	 6CZGcbNF7treiSDOlummDvcKRlIBq6lSYk0I9o7fam16QW6PjzO9ErnjBsC+dhymR0
	 aYPYcH1l2aNr0PuAHGhAHPTUKrJ5KWGkmzR1RXD0jnq8MTOaJ5JssNgNsKDQ569UYe
	 SOYfIhChLOB1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85F0440760;
	Tue, 18 Aug 2026 10:39:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 430E9282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34E9C4006B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfcCEHQPEeYF for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 10:39:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0422C40057
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0422C40057
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zJg/2bqn
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0422C40057
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:39:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2725914f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787049563; x=1787654363;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qu6xNLlthSmM9yUV/NcF/2x3Ca5rRWDx/iwKAFYkyZo=;
 b=zJg/2bqn6FfpQJ+lsivxZUWaqGnbwzaq0WDBGMiwgekFYUa15v2zVEvSYQd3Y0OGsX
 VwepU9rVQcoT63GJizmemb+QgVa8hv6286x6n5iqCx7zN2s5kVx7hxj9D4mc5UyPzmhV
 RIxk/1ZHaYmNSD6OYYUmyyF4XmmzmUJCbdf/s0uSym9lQsfFDtdCaSpvCLb4ruxGBVUg
 9ad2wio30MqRjJAU3zgPTTdacomrZRsmJxHQuP+q5wtC7KFjtkjkl3IG0q7ClCY1Gp3j
 kLI6j+IzcAkXVVf0nb9yS0okB+K+rjkpO0gE9awSqV53Fy8lJyGD1YB49VIRendwsKvX
 n7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049563; x=1787654363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qu6xNLlthSmM9yUV/NcF/2x3Ca5rRWDx/iwKAFYkyZo=;
 b=kFEEtF5bfP0+wubw5n9BOU72Ap4UTbo+/hwYSxc7DpdRUD7i8vLFpHvIdj4HkCgYL4
 n8Jhy28V4ooBM9ES7U05F2r+KQo2sWICqu5mmNaPd3cTpEq0RQN/KbU7PwvLRPz7gK2T
 z2BlHZusAvGQvkhVbnQXx48IcV3tNhCdKc3zQ2o12jiNGebqhLQBmsM7ePOSkcrVmoTv
 y/EawH201GHCh3k3a56TCSZ13+lXF+Tl/+x99aXDSKkXhfOcGUlTqSXKoMYM+qOaScCW
 9wC97MWQTOT2YB0UHwiqAgfqqOrDUdMF9AGgnKUNgVJdBGCodTr05LmrFsESxdWllKOO
 8O4A==
X-Gm-Message-State: AOJu0Yzo2rKoDam2CwmWwMmPmOLycqohk1Z9qW1FezJLbgq3yNL2bJ8U
 WILTE3S7NbH0tudd3+8NhrT8m4OBRmOsz7HjA41Ods9NQHr8m5xwshunzLST4N6VqL2b+u0/7Iu
 1TeD+hvw=
X-Gm-Gg: AR+sD10afWz5EDknaX3DLAN85Y/iUw6mVi35EGYXhZbNnZgjTK4dPHSIy+Wu7+o64dX
 4v4WTFYGjWJpy0FDQ1mnfkLeAEvy3dCPKSOJpyRDq/lXMdX+nA1DPxpQWKiiGaF2fVVN14pAZ1Q
 fRWxCAm/mSysgRu0M8Ym6fWQYu4GAnECExd/s25OZ2cgRG+Fm0LtPTH78u7/deLwgEwj+KJB8Ku
 ACVAfJuib+kjuFId3aIqkgBKn5XP7seR2wxv68X/TRnFU48UMz1f9W60WQE/rjbGbQmfHj0lZs4
 xjr+YlwGXsD+xgEWvwmDoVPViS2xFVw0sQVYTExSlOIhnjLT2zSgcynIwZGFP87e2OWfO8ZmRev
 R99wMKOLwQILwYCtmUJo7UGFGEms0Ay7cHjJ3LpJU837IENrBuscPUS7AeGwjDpXengwaROqMxb
 w0kMf4y6eYAHxnnwtonpAketmFu4reh1nKGGhD7qvuvZMgQai7SA7gqawxuHFOcgrfn7mVfGLd
X-Received: by 2002:a05:600c:4e04:b0:499:9069:c2c9 with SMTP id
 5b1f17b1804b1-4999069cf2bmr484580695e9.11.1787049562641; 
 Tue, 18 Aug 2026 03:39:22 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7241:d70b:9010:cd0e:3bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm126388205e9.3.2026.08.18.03.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 03:39:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 12:39:16 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice
 device tree
Message-ID: <aoQ2VMH_unoQaQxO@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
 <aoM6qJ32H35aumPL@linaro.org>
 <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
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

On Mon, Aug 17, 2026 at 10:54:51PM +0200, Linus Walleij wrote:
> On Mon, Aug 17, 2026 at 6:45 PM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> 
> > Hm okay so you're basically dropping support for the internal eMMC in
> > this patch? Can we support both? BOOTSTD should be able to scan multiple
> > storages for boot targets.
> 
> Yeah just laziness on my part, I'll fix it up.
> 
> > I'm also not really sure about selecting Janice as "default" device tree
> > here. Do you expect users to change this setting when they want to build
> > stemmy for another board?
> 
> I have a script that loops over the Samsung device trees,
> and recompiles U-Boot for each of them.
> https://dflund.se/~triad/krad/makefiles/ux500-uboot.mak
> 
> > I wonder if we could continue using a single generic binary for all
> > boards using CONFIG_MULTI_DTB_FIT. We should have "fw_mach" in
> > board/ste/stemmy/stemmy.c that should tell us which device we are
> > running on, which seems to be mostly(?) unique:
> >
> > https://github.com/stericsson-mainline/android_kernel/blob/9508895090960012f916561b2ede5eaf8124fabd/arch/arm/tools/mach-types#L3956-L3965
> >
> > I'm not sure about codina-tmo, you would need to check which number the
> > bootloader passes.
> >
> > If these numbers are unique, it should be easy to implement
> > board_fit_config_name_match().
> 
> I see the appeal of the ambition to have a "one size fits (pun!) all"
> U-Boot.
> 
> But as it is, some of the DTS attributes on the external SD card are
> different between the platforms, so we would need to modify the
> U-Boot internal Stemmy device tree for those, copying over yet
> properties from the device trees and into the boardfile.
> 
> For example Janice and Codina uses a regulator for
> vqmmc-supply, and those using the "sd_level_translator"
> for vqmmc-supply actually use different GPIO pins on say
> Gavini compared to Codina or Golden.
> 
> The pin direction settings on the MMC host vary. (Some of
> these were really tricky to get right.)
> 
> So I think no, if we want external SD card boot we need
> per-device compiled U-Boot binaries with the unique device
> trees.
> 

I wasn't suggesting to use the same DT for all devices. What I suggested
is to bundle all the upstream DTBs for the individual devices into a
single U-Boot binary (CONFIG_MULTI_DTB_FIT) and pick the correct one at
runtime. :)

That should be equivalent to your setup, just more convenient for the
user.

The only open question for me is if we can reliably detect codina-tmo
based on the mach-type ID, I can't find that in the kernel sources I
have.

Thanks,
Stephan
