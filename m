Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF18C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 18:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E888F608A3;
	Wed,  2 Sep 2026 18:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izNharuBBGQ6; Wed,  2 Sep 2026 18:45:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2874F6079F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788374732;
	b=S8dAJrKhy3fjl9agoE09BW/gaGfY57Kbdg2IFyeYqXykRJq99EVsTEe8ow0Vc7VP06og
	 aruDob51Pc2PEpHK//PNQEs+0g8Cpttfwtwoqvr82K6GEVvC32U11gCH8S9IKOMkcJKod
	 xSSwrQvEXk9d2IdW5VDFPtV0EPVW3W4EVlz4qkEIIc2QZkpGOKtgVFikr6fSRYug+V2+O
	 RrSYVIA8wyPmwRswoNveH29S9VyUINzpYJnyXKQ1spgky4MMhHhxEnn0oeMqv05YI4PyK
	 uVN4tazygXZsRfiHcmO4XFWMZ/5O9NBEBRdnxyoGv0QWaFw6Gq+QbPP1xfdvgEiKcNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788374732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SW76G9ecbJvdBFXU1eQw9O9t4cgNY5rC4NMfb35MYZc=;
	b=pXdkMDeMMBMXX2E9o/73tguNmI6wMCSBBBT59XmZFxxR/2IxdoCoLMIwj5JktKOIT7Um
	 C1BzsQIJk3aYZGLxxcGrpH8YMHIC9A6wCeLaLuAZiofKOzr+/kezSC7rv/QtXU0nL0i2T
	 KTf+FKdsVAhpeehyTyEhQyZTBz4tr2HNoIWIiuwbB3TxYGEeM8CjyURLbZ1wmKcrLFKML
	 QyvEIvRKMmUWFazlLn5vNvtgD4NrEq1B1HK5Yz2LeAPTRoyurAJnBiC0wKQF9thJ8Tlch
	 vOUj52+UOtnfrhjDdQH4p2wjzOrpCQq3WIIn9FQDShhZxEzR9my/l1fBLcS2hpet5Fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788374732;
	bh=SW76G9ecbJvdBFXU1eQw9O9t4cgNY5rC4NMfb35MYZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IrUta6Tu4O/73He8xEkIbN2v1xzaBUiCvmiiLbBqk42fSjMCL2qEl5EBJTHU8kiTY
	 sMGNEQCKVRTT47fV2IfTRW3uKcRIqQ4zsMAYcPGY6BgsODMZowxwOFO640A5AVKsBv
	 XBkJ0jGben6CA3JsM6zGQjHN57f1Qt9PnjXK1vLOsISKPqiLl0iYSwHHnl5zn7ZeqM
	 gNF16V8nEcAgHCw7zcQ5Sd3zw7QII5R+TQoJhCgLG/8uDHDjp1RmZylT+Ln70Q5dvR
	 zhFWwndGRInhzTU1tuaXscT7m+eq7Ilv/S2mfLaSXYaM2LXcX/0a8rRNgqHYoEaDaE
	 WvtxRPFGXm5lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2874F6079F;
	Wed,  2 Sep 2026 18:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3346120E6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1676140177
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmnuWP7pxvqU for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 18:45:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 60F5A40158
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788374728;
 b=fBUDTRun02OQi6oMn6ePLeehQHV2WyfPAnk9KR3/1J/QrFRPGbeJtbpIkc+iw4Y3Fpi5
 d/qQdyRhZSHoJ8uPUEWm0kPGgsPM3YbhEeEDjYkg/I1ooc6GfPdDIBdObR8em7ez4MNx7
 hhs99tz+f18AB7fQMoJYWMtmitrHk9Qokaqu1MI18JsaFnZVHPleFkSmvtFQiTOtioKqj
 Onx/rUAERhK+a/y4jpjFLX3KEq527oF/vUOq+c8+bO8T+ppSyG+5MuDXfZsky5Bw3dysq
 z5PlO8JHOgg20DclAQ4F1aWkD8Vb6lgmuujy0ElcDq67A1LtlSIPj2K+f1phjAzigHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788374728;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=SW76G9ecbJvdBFXU1eQw9O9t4cgNY5rC4NMfb35MYZc=;
 b=inJH1SCkIwHw/sZo2NaZaHTjBhaCpN77hGTa2kp1OM+s8mftw02pAJIbWq+ePe8CK9YB
 EihVSymVQ1XwkREAoUYWjIRCRvFa8/h6BpE8mWn+IZ9bIvnx3uMLw3Rkg27SdWAyizZ8t
 9JfMyIh0X4+eojvOhNZTH5D+YmgXtLD4O40tRFm86eWu4gLPSOdvcAPk8K4Hw+EUUbIlL
 k1CB6W/3dvGUksavnHVMRjbT698zRdsME60EM/nQcV0NIUrIbuRgbLo5QOAEWXJuXqt0q
 kccqqw4C+8AIJW2OzY+iSqEseBefqb7nV6+1YUrjSRLIALmR2gXs+GlfNxP7iFwDf4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eEIT4UQ8; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eEIT4UQ8
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60F5A40158
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:27 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-46fdd5884d0so247567fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788374726; x=1788979526;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SW76G9ecbJvdBFXU1eQw9O9t4cgNY5rC4NMfb35MYZc=;
 b=eEIT4UQ882Y+Mq/9prlSN/z8912wwFiR+BQFS5uhVR57rEHSuoqqHuzCHJatZnxwV3
 Jw3/uv+azpdcIu8g3uKdjtPc1WUtdlf3lhAuwI7KG5+IfK4qvCXKkjhgFL9yqTRJCwDs
 Paxvj9SX8t0+7cLKf9f/rJkAgCJ/SGFRNmbME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788374726; x=1788979526;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SW76G9ecbJvdBFXU1eQw9O9t4cgNY5rC4NMfb35MYZc=;
 b=blBS9oPmp8kK0Yblpt09H7Tlr5dKiOyg+ymt00r1805gNU5vbVbGxY/x0cuPyfgrqP
 syhxLxGlR42qiCdq1Tzd7H14qOqzQk/D7+QHiJ2G9e77p83NEqAA5JG/Co42vl6n/D0i
 SM/UDktuiU2b2E6LRjpRKeboufoRfg7KHyGxJBh3K51sQOoIyhvDJj0CL3x92cuq8+Qg
 wyzDtuTvn/4SPO4xswK35akiSJkTxR220jLeAHCeiUhoWDSVzIIJ7Zdftpq++/kHBckY
 syajZWFv4sg4X/A7ny9gVTI6crSlF3P1ZsCnPoYs1TmhYA+M81RC3dZYU/YNzxlzOkMD
 OCPg==
X-Gm-Message-State: AFuF++m9bBHgN8eC+zVnCvdWdKKF301moTjpWSrn/IW2wKH/Wmlemr84
 CKK3NE9g9QpTYJ4lmZBFk4oJbNZ2TORvi03O0p3kkxm3mNajtUKPwkgddYuiv6P+08U=
X-Gm-Gg: AR+sD10eWFxAUbzUZeG2rrDkdrbFFKVFfTFj/fv112o6JGlFuxtpX66jDAACgI+ojPN
 LM+e+jmwqErrlnWkBC+6ereoOKhhSVlft3CGISGTbZmnjnIna8klbSOKGS49ipGKkW0CnD+RHwY
 4GyyuTDqdP8vQWXjk/EB6I7F6nEcvc8oLtXp2aCg/FMyzipnBwi+Ln89uHLx5aEL8UevF3ZQdVJ
 eXn4MZvPb1WyTChd8t9jn8bYOwbwhgWaIDEdN3ptE78iOY2U/+72s6EAxjxKLmtgQVMNjPel6Oh
 fHIRVJQs8dAR5wSu8sG5LqTR7/sHbABJRKbJBk1PqAIJT8PUp6f5ULq9O8ZXKnALr/yfpkpHcgu
 yDCDvb1jLBfky9FpriuEKGvk9kpdZ1U+GaWsu7f3dRmYFIIdEbwc/NHYz3Wv8hpPNARmfvX7Grw
 WKcNjc6xXoOO09DSHDon+N154Ro+Bap2Zd78bGbdP8EcqvFqJyXVP5uGR8FzPFLuk14Tj/i6s/1
 eAVakMYA9XAwQ9nVik67F1SK/AlYI4dXvsHadDFyBLbRm9/K0ioa6TRd4duheEec3G2n9L3qqSq
 2og/jfSk
X-Received: by 2002:a05:6871:708:b0:46a:c217:c56d with SMTP id
 586e51a60fabf-46f883fe9c3mr6279633fac.2.1788374726551; 
 Wed, 02 Sep 2026 11:45:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f30baa0d4sm4794536fac.6.2026.09.02.11.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:45:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, ozndrgt@gmail.com
Cc: Ozan Durgut <ozan.durgut@analog.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Caleb Ethridge <caleb.ethridge@analog.com>, linux@analog.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260820125705.51692-1-ozndrgt@gmail.com>
References: <20260820125705.51692-1-ozndrgt@gmail.com>
Subject: Re: [PATCH] configs: sc5xx: set default FDT file
Message-Id: <178837472567.1800948.9270990903712592095.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 12:45:25 -0600
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

On Thu, 20 Aug 2026 14:56:55 +0200, ozndrgt@gmail.com wrote:

> Set CONFIG_DEFAULT_FDT_FILE in all SC5xx defconfigs to the
> corresponding board DTB filename, and set fdtfile from it in the
> common ADI boot environment. This provides a default device tree
> file for booting the OS.
> 
> 

Applied to u-boot/main, thanks!

[1/1] configs: sc5xx: set default FDT file
      commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
-- 
Tom


