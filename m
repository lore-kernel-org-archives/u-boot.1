Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07352C88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67A5B606DA;
	Fri, 11 Sep 2026 16:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1HIEU-ghTNio; Fri, 11 Sep 2026 16:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4429D606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145470;
	b=mPaPK0XjWb3Y2+hI9djyBIniWOxNdHWuHOyqPppmW4+M26Itdzbc4PIrmF+OqsoxPOnY
	 K2plAr8xe24TLYOmEfeBieVmryCkmSUwfZ+J8zbrsg77Wv1CJq5/0PfStfzsMrdDzkBWo
	 F024d8oWbs5eriQBdYG8qGbIrWpbSRnPkVtI34wrXAY7mwj55fn86J8EfD8Cq/LRWnS4U
	 pf+RfqustyEWkOVWsOPuVkBBk+JFEAdxHg3/w1mXvBazyY1wSTpUo3D21sKfAgp5/0xxx
	 GbISuye9f/XUl+nkXBtEcH+YnSxEHWsxlPVIqf+nBgHt78qO4miHZtxoP5hrFnEcL9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=olqZmfeuBcwvogfk4xHcrgBQ+tj4rIrJ5h4UfI0PYvQ=;
	b=pWZTXSjATvUjcfoDrDt8SxI+aBbt+lMvK0d6hN8L/fpVINw10OjfTeSUWw5EMXC2y2Z8
	 cU1DGzT4xcAFYc4/9ajRVSEgQirFZvnXIRvgiFWDL15bZRrW4wDSoe6ryUOwryDnJp3sv
	 5GuypYfVacoiYY/U41GYTK1C1+NSibwKn4GwKja9qxC/kXVg3ClDId8T2zqDCs+5OjrTe
	 ONJSlWkfs1WSssyBE7H6aakKoGOWVq9CA3/g5W9KDHeKhPrD2WrH/eOcFxk6Pf1xJ+D6j
	 qWBOlWRzrlv0HtKBGOsmgqMYx/3V1kZj0rZF0ZC2Z8og0jfak8cAe6QaHGNr/SK8rHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145470;
	bh=olqZmfeuBcwvogfk4xHcrgBQ+tj4rIrJ5h4UfI0PYvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eQh8kxXgGvuHxmnqeWIcX2kWsVFWTU08GIN2qealqKs1J6vQAHClZHRBsgkLE9rye
	 ywc/OVQecPcgMNmQd8Ma1cRWf9YJK0K+tWK51hco/M+5VO3pOdsHDLXk89FbKNDnlC
	 kUkuowDchugQIZXeXCREHz6Lk3+Yvvdqw/KLVSI+q/bN+FHqQz4YQ12/rursCuXIwB
	 9JjMuchac9Ytp26GG/MwkPUDQe7cUfqdCcoaYwGojaWv0IxTKLdGAFiv6JfTjgE5Ms
	 ZHLD+h7+UHYincLFSM6OK1GYEYbxakXW7k5k+PF2sUB98A8WNd7UzBZ82aR71bUNHW
	 HizFJwbE08QQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4429D606E1;
	Fri, 11 Sep 2026 16:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E9D713AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D050E40177
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id em7ywapWgnLC for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E3DB14006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145466;
 b=NnTOH1ESx70YGfLXBztfczHI9UzM3yA9wDJfs8mimxwJ2RlYD3/zgVuPQGB6DCQl8sAd
 nyVUqBYeNqjFie+z+vMhQdCBs1GdpftvJWS2tRKg1xTxKLoFUA1jk/LPty6Z7Afpeg46R
 cYFCd4WKv3FeocVWniGF+26wYjry/kS/Oy+kB6zjxo41MyQY3E25aILv4jEFvsOEGZT2B
 xb6BNuhjzuD5of5BvcKExe9AUDQ5Jx+mrK4Ju4zWDeMgkG8WjFM2BAIVIZb5ymnlDO9Gv
 JMGAVGXUQzaRz5yDOOjK1e+eHAgvQf7HoV46nKSbRBLdGS57tr9rGkLxmMaS7gZLNNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145466;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=olqZmfeuBcwvogfk4xHcrgBQ+tj4rIrJ5h4UfI0PYvQ=;
 b=OKK2QmuNoxylxWciyrMx4mgdd5FP3MC2hemQUAZhYxwDA/WTXOD3MNCJvHquRJojUfYo
 Z9trHqgqIihKZoRyX8Lhh6p7vEWNkSSkxwMsc3M9KQTv7SrSGgzilUG7zJ8wkuhd/vJeq
 8Q1nAmrBGnzCFuA4fCp63eATJ8JiXhuUncfUt9u0AkD0OI70pHKSlTI+UVhcWgb0LncN1
 hNeRxC5/y8ORdG80He1hTbE1keu6Eu4IQmI5dcqtKoqj9EsOpwNTjgf9BFkJohvpXdTQK
 f7h7Ild40lgHbd3l2eGMHFpD7wfA+eMmp/uuG6+lgRQI+Y8o2huX4Pkcw8vnJAMU4+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h1faVGav; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::;
 helo=mail-oa2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h1faVGav
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3DB14006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:51:05 +0000 (UTC)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-451e8472960so717585fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789145464; x=1789750264;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olqZmfeuBcwvogfk4xHcrgBQ+tj4rIrJ5h4UfI0PYvQ=;
 b=h1faVGavu7r2UdvGWWczBa1s/hQtb5Un69n96Wtprg8pjmAlLrIf5uWYttfNdkJ+DE
 1GimrLctXNg1XAa2MCvpBn7ilnUVDNfXSGc59VaccBJvQGnPilUS1T705Q+DezzQP8Br
 Ez0rAV+KxBJJdwSaFiDskJqLSwti6l2AGOaaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145464; x=1789750264;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=olqZmfeuBcwvogfk4xHcrgBQ+tj4rIrJ5h4UfI0PYvQ=;
 b=AhgHuPMwe4mlGdhIQmSEe6AT1PH/PI6Gve4jt5pPyXnxg/+5ZfQHNg/rN7a4M7v7qJ
 naJwx8roETH3nSIEcDnJSCpZSPCi9+uTpcXNfsHF1vT82GIdgsLZXltHmM4Jj0buPYGb
 Fxq5mbo46ep1AiKIclapVEOG+pLZAJkygAe3RpQ5LICr+vzKE8TO3KRSPQr6nqMHzQmP
 xnXBS4VPwgrNoPtTm4RS8HCjI65PpOr6XkXkbbDC0Frut79XErY1MWdyeTpY3xwQFBN7
 sJcSsMgTNtsHw/wzAwgYAWNtMeXbXX8qFTHgNn1RkLh/RaUYWztfly8bUWM1eHv5ebK1
 EzNg==
X-Gm-Message-State: AFuF++nviJO+uGHcKX/rLfWn8V8qKOma+n8lahYNOT0asBMM0oHzTaKg
 OrA//jsgblbl/knWKu7Ch7q2nE2pQotEZ4Aai4jICp8k1CvYKcc1O+Xmhgy911sIsyKezhcaq5V
 UXvx8ZhfTKBuOEh8=
X-Gm-Gg: AYBFou3wklsLBpSBP33s8bWX5bUYbauC4bJJ5Srg64fICJsBZr6HhMSp7GuTOYlotLe
 wic7XDSSN52x66AVxK95VFRRF9YAtWHzDsWLI2yXo5Ljv4tcKhCZ+w+zDG0ZVNkku7x8aHE5XjG
 OxEQJybrIi04YkXX1mIq140XxpuJtUSHqNNgiIaLwpVfQDM/wBW02EBUyaYWbNFI+Z/o+GTYAB9
 PnJWXUJekp8VUeFSz7NBVuILb6qbfGVa7ewfcHZQpiAqHWGwcHpds4wPuJoEtgFnCwPqkEwyBWL
 UQ/Fj5PNJ9BxIvwggGl6Dl+R01BJkXQ3qNNOSFIDNTZqVHkhlc3kPVDUbhOGCH1ks0KBxUoxL0t
 tJ8GSueGBVH2CraLgbIcy/YJMPFLNiR2r0G0vLxZmXuTuLkZZBpdPkOpiavgujjn9fJZod+6Jsd
 3J7nH5sAHCTq1rP4rFI775IkM0m6H5SYPlh7bDHo25tCEEAQQCKGBC2AxAS/erPkOUZwP5jePRZ
 OnJA43X9LTkgBsVuzh5QhIbrYreMOfdt4XWM1mqCvmGpkU9c8Yb617kANgykMAVG5krH7uU9XVQ
 bb8VxyL8gArFnB6piBc=
X-Received: by 2002:a05:6820:310a:b0:6be:354a:1ced with SMTP id
 006d021491bc7-6c0bde5c99bmr3230040eaf.64.1789145464530; 
 Fri, 11 Sep 2026 09:51:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a220714sm3186402eaf.10.2026.09.11.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:51:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <a0602787-993c-40e0-aa29-08d36142ea6f@monstr.eu>
References: <a0602787-993c-40e0-aa29-08d36142ea6f@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc1
Message-Id: <178914546366.3764906.11841557524839091330.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 10:51:03 -0600
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

On Fri, 11 Sep 2026 12:09:44 +0200, Michal Simek wrote:

> please pull these patches to your next branch.
> 
> I extend timeout to 4h in CI and build passed here
> https://git.u-boot-project.org/u-boot/custodians/u-boot-amd/-/pipelines/1218
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


