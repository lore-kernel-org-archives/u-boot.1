Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A6C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C042860619;
	Mon, 27 Jul 2026 06:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTU47G8_YsqG; Mon, 27 Jul 2026 06:45:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 325E060602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785134701;
	bh=fbo/4wm/wBXpGAK49WeQgMnPUrl729VaISZEk9WyUM0=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UtuCYXPmtc55k0utYqopj09JSF0CgZfrz4aOcqSCTOp98wPF6+01D3J+K3FUCn073
	 Z3Q3OtLmtWXrLcrtXgX23jh72ycvpWTbyUHNE2rNhuQsqNX7tDfZrdAzu25Sd7GHEw
	 m0MOo3Z3BJJ7EJUooegkgbixR9/FMP2usQygGNskOYTFWW1y2tnQeCty1yvQHeQrHv
	 1OjODvJlhacFr9p+LnUN71HpC6oU7WohJBP+Z8luglbMYUv6kHaaKw3ky+gwnNXOtA
	 rRRgkoivi/wUd1Fb1b6SEPcXaYVgYAGi5o0coOp937PBvFFsQ95OVKhKEVwVbB938t
	 BfGpsOkgAh82A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 325E060602;
	Mon, 27 Jul 2026 06:45:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E8522E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDC44400FD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBdFhkBHtQ83 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:44:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3F2014009A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F2014009A
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F2014009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:44:59 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84e584c7a5bso850387b3a.2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785134698; x=1785739498;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbo/4wm/wBXpGAK49WeQgMnPUrl729VaISZEk9WyUM0=;
 b=U2YmHnqkYhxma4on9WhLnxwb9BywT+Tz9eMjdFzPoRAH2daN2NE0SLW6jm11I0VdEC
 a7PYD1cA5eLqRFoiuqi90xsQ63rIoNva3KA6l83VemLc1qetRrEj4d4LJgQldC6a0230
 GiEcUrVAUMBPAz0hfpZFgQZnuN+KbTzOT1j34eeuTd6Yo4tMDS8cCAg6KoYvfhOVMkUH
 qXx7txtDdSZaT+1G3ecD7oV3guDG6OIS4UmdOMF8P6bIuMyVbWluSD1LOf1m0xvcsskj
 nswLKxC8FstTkhY6ZWrSdAR8ks5/Yn5X3aerFJTDxiZj3W5bX9dJocDqcPFIGT5ZGu6M
 Wa6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiCQ4H8ekVgMzVEpgZTj88CslQ41yjBupbkzpqQwS8wIj9LnJUgUfQKY6dgOj/7UoW7MawwN0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz/vhZuEf6ltjftR4WHWjcG1iGLcHJizHAxK/hflUs9knb0TOTt
 ZLTll/mpacoerIKgYcIfm7+9Ba1Z29doJj/R5v7Nizz+HqzDYTuP1/cN610fnK+kd5xwcJIVrmH
 ew7ZVNMI=
X-Gm-Gg: AR+sD107eIsZBhIwZXGnoMdw2xVuc7wkYVtK/k90OQ/9UPVg+/w6o0bGMK0GTfCVK3X
 RksTXYYaRaRTPZH0PHX202rZjZHW70az6lc4xK/dmkIMjWppwY3pCsQTbWtlOsp2UIeNEpSGAHP
 5o+TToHc+NdWytd/H/fRWTVcadwOWAE1bvb1F5g6bEmiDLRmBt9RmsDKSM9HBDcG5QAhdwk8zCH
 4xZA5WMFtsh4frGY8/iP6MpAL7YIW5kXHyTvmpcPmYXrTWlDp0uw75HU+H0ez3hQtYuC8KjkTun
 BShbaHc8OovbsjjIyWl+n0pQ7OXXH7cPxr5mSj403FmIidRAFtVTFgv6oTuAqShDpQzXKo+ENFU
 tFhL3U00MMqnesnjw1tL/aOodcL42I+o1p1qAWrKy2CrMn0Kk2FQB52HtjXiM+hWeJuXynwEKko
 QGqrIvaGP24VCZyBCPpD7z
X-Received: by 2002:a05:6a00:cd4:b0:847:8650:69c7 with SMTP id
 d2e1a72fcca58-84e5943750emr5762172b3a.21.1785134698317; 
 Sun, 26 Jul 2026 23:44:58 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.184])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e533ce1f7sm2550591b3a.34.2026.07.26.23.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:44:57 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:44:50 +0800
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 3/3] riscv: dts: milkv_duo: Drop local devicetree files
Message-ID: <amb88JNJi1OXhNYC@lliang-1876.localdomain>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
 <20260706-milkv-duo-upstream-dts-v1-3-8d010ddda7ca@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-3-8d010ddda7ca@zohomail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785134698; x=1785739498;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fbo/4wm/wBXpGAK49WeQgMnPUrl729VaISZEk9WyUM0=;
 b=WLVmrHyqPv68gJ6Wc9GaUHCAGiWFg+wICaADlTk695OHixAY8eJPkjVm8qxUr81Op1
 Pi2f069mRk7R85gPg0WR0g6P/Pg8WvOgRzBl63O1Nqz6dNRa93BFw9PxcvqZG9zXtVDt
 69DDcQEX6V4pCSiCX1Z3FwAYUsHsnz9xPk0kHsnnBUePgKtu6XRRrH6luOlfhPhtyUJ2
 FIaR6xkF4DONAyGU1qhpbrMyZXITetnsQPWJgcmti9JfTA1j6ek6aoa1yc/6x1l6SHrp
 4VOW04jL28snjlaxh3SlPG8qSO5nn2a9Oq7JqmP3Uygo6IhKfgWOuVLcEgRBhJhnTi+z
 JCTA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=WLVmrHyq
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 06, 2026 at 09:43:43AM +0800, Zhuxu Ran wrote:
> Milk-V Duo now uses the upstream devicetree, so the local board
> dts and CV1800B dtsi are no longer used. Remove them and drop
> the local dtb target from arch/riscv/dts/Makefile.
> 
> Keep cv18xx.dtsi since it is still used by the SG2002 local
> devicetree.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  arch/riscv/dts/Makefile              |  1 -
>  arch/riscv/dts/cv1800b-milkv-duo.dts | 64 ------------------------------------
>  arch/riscv/dts/cv1800b.dtsi          | 22 -------------
>  3 files changed, 87 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
