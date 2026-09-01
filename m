Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD4C624CE
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 02:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1076380ADC;
	Tue,  1 Sep 2026 02:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggIry7xiOMCi; Tue,  1 Sep 2026 02:14:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788228844;
	bh=9tpbYsKp70/zvJvjt8yXpbWEfZF1VRf3XtCodnonxbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7ixabjwoSA2b7dc/dCpdZk0Oc1b2bCLsxjA/OtMSfVJg5M/HOWIr6aBwXJ4Vsmbw
	 Wt0NuX0Rb3ApBRCLJciOu9xY3S6RmavV1zKg2emqSr+Tw+saqtnUnIxJcNvDrA6Vxy
	 O5mgJR865hhC0WxpMsSegP7CUH2yQNUk84LgOjgZ9/v+QRbFrV1eVgt/Fz3t3z3j4c
	 Nou0sR976jIdvvuQZlKjYdSJ/9l6pKPKU81Q6IItATOUza6tbzld1dcCaQ2+VqrhCx
	 mqmeEe740GDqoFes+piyozkgNpTws4NOD5Vup+TCOOuuBbfKittTTwtUEiNAVejtKo
	 WqsSfvNMKNHmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 428BE80B07;
	Tue,  1 Sep 2026 02:14:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EFBCF2
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 02:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 583E580B07
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 02:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FtXzXqY1y5-p for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 02:14:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XFuyaQfz
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F3FF80ADC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 02:14:01 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 46e09a7af769-7f4e2118db8so1445681a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 19:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788228840; x=1788833640;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9tpbYsKp70/zvJvjt8yXpbWEfZF1VRf3XtCodnonxbI=;
 b=XFuyaQfzC6dYe/sckNlvZZCPDD/Q1x+0/AwO6RSHjCfwvDQBruUUMqcZgrDuHZSjMG
 eghBFv+svoPPHHNagfc6vD48Ykk2QDQoXCwdsqe76V3FmAQNlU9aDPq27ipPFi0v8+ND
 82dzCbHOJurENMWkcD9Qc3CDl268faP4QvzD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788228840; x=1788833640;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9tpbYsKp70/zvJvjt8yXpbWEfZF1VRf3XtCodnonxbI=;
 b=FsjDWDE/djBUMMepSgqoK4PWcF8oFhpiQMaX31NljOQgL5VcJWp1Y5J6SMmhjbkx9M
 +XUNqsWP72sHIKWpp7wYsCYORRGgQUDMcKXxDRz52prX4cn8B1fNHfIK0/DNa2/7RrLv
 aDoBxtPQjTg49h73c7xi+arX2rqP4of7j99CueyBJXM2WK3kPCqq3E9GhbE1HQ+M/29f
 VJf66KwjBWuXY9/0vNH552umJ/XyYJEq+/nKnCOcRQA5sfTaa8fLDS0+uFm85JADS7Az
 DwKRX3gyc7r9Awn2wizcFjP6QfVrJRqyvV3gJtj9A5eUQO0I21vCCqHK13PtN9pclLvH
 nCsA==
X-Gm-Message-State: AFuF++ncWB7UrR+aF93qHCHyaeaEjERlvVt4I7bs0jmzD/VFZMiO7gxQ
 rLG8ki3VSz46SP+EmGV7KJIUgnYlpxAiMkPtipQyuv2u6xmfJzMkhOrUnCGV6Eh8m34oX1Rjvrx
 qbtLU/Mro2GapfqI=
X-Gm-Gg: AR+sD11D1w6vb3S4H0Cwot2YNOBJhNW48R954q1n6HXkktwaNo7FDAe1sU6+6snW+7f
 JiRKLllPp6FqNGIkdSfVT6XfKkx/NXUzQ3FFTXDjlQlBW4bvEokJTaNMFzzY+uOPkxrYkbt+mFo
 5Qz7xu52GWDGNYWbKX2MY2EXmy3ViUWA5rIjPAavOvOtCy6/gGO/siKPxykPi1dwt66Oa41kz5z
 BUeyvj4XkPWXwCcqy9e723ehvK3e+wfwGQkEA324yeAGVShSaOE3TLbFvaKtCPrvgP1o5sadKno
 dPPR2v52tk7XBzYCdOss8+DD9WGlS5qXrjcPDZBZP543dFHJgxIjj2cBvOPlSrAQhgPVZLGZMfV
 JKBVS+KSSpXLnXxkGUup+p4YMY5EkVQk2A0KaFl1AFWBd6k8GoxE26Yot6C2E8UigJYp2IfVh5g
 aWHCAjHG6Ei8D7uomaC70ujdQHhhScKQCFY6X/dPiVaWJ9/OlcDV/dpd6fuPczY5mg7dxLErBSh
 HbffYOHQYDMi4Zks0DnqGSbJv6fSZUBX3LU8ahld+2y5J5GVkhzXl5PkoTyf8HmBX/oxGKpWUAN
 SXRrZj1b
X-Received: by 2002:a05:6830:2107:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-7f687969d39mr6783599a34.1.1788228840556; 
 Mon, 31 Aug 2026 19:14:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa7e940csm9400591a34.7.2026.08.31.19.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 19:14:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Brandon Maier <brandon.maier@collins.com>, Thomas Huth <thuth@redhat.com>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
Subject: Re: [PATCH 00/17] pylibfdt: Update the U-Boot version with changes
 from upstream dtc
Message-Id: <178822883935.1272935.12455995228407286697.b4-ty@konsulko.com>
Date: Mon, 31 Aug 2026 20:13:59 -0600
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

On Mon, 24 Aug 2026 17:12:57 +0400, Alexey Charkov wrote:

> U-Boot's copy of the libfdt Python bindings in
> scripts/dtc/pylibfdt/libfdt.i_shipped was last synced wholesale in 2019,
> by commit 903fe17aa8c8 ("pylibfdt: Sync up with upstream"), against dtc
> commit 430419c28100. Since then it has only picked up individual fixes,
> so it has drifted a long way behind dtc, which is now at v1.8.1-19.
> 
> Tom asked for an audit of the divergence when reviewing the FdtSw growth
> patch [1]; this is the result. Bring in every missing change from upstream
> as an individual commit, referencing its upstream sibling.
> 
> [...]

Applied to u-boot/next, thanks!

[01/17] pylibfdt: Cast property length to Py_ssize_t
        commit: 9f6d57eaef77a17fafe0d28e4a103786ae2de55f
[02/17] pylibfdt: Restore the upstream bytearray() in getprop()
        commit: b737e5cf2bc8d9bd545451a3a2876465bbafb8fa
[03/17] pylibfdt: Fix Python crash on getprop deallocation
        commit: 04e670ea3630efadd654a940d893137a3c6c2c9e
[04/17] pylibfdt: Add Property.as_stringlist()
        commit: d0c7b9e65bfd30b93aadbd5d0143b2911f8278c1
[05/17] pylibfdt: Add Property.as_*int*_array()
        commit: f41cecc1fe9442939f1a81684db1f467f3bd4aba
[06/17] pylibfdt: Add FdtRo.get_path()
        commit: 66ccb13a8180bf7d09d79ca136b18301e020ae5e
[07/17] pylibfdt: Work-around SWIG limitations with flexible arrays
        commit: ba6d20256305ecff8c879e2acb169aa5b0fba933
[08/17] pylibfdt: Add size_hint parameter for get_path
        commit: 69c95e9e4f576b811e640d1bf0ee95cf070dd542
[09/17] pylibfdt: Support boolean properties
        commit: 3bf9e7e72ab545d08d9ae30bcb45027ad24609bb
[10/17] pylibfdt: Fix get_mem_rsv for newer Python versions
        commit: 5b7d682e1d28383318c6d649d11aef45ed604ce8
[11/17] pylibfdt: Fix backwards compatibility of return values
        commit: 0e9f9fda2e4568aae651147c1e59a0b4c394df55
[12/17] pylibfdt: Fix a typo in the next_node() docstring
        commit: dfba3eff563cc0bb779791b10e8f78a124f4182e
[13/17] pylibfdt: Grow the FdtSw buffer geometrically
        commit: f3e00d4b7f365929e18395194049d569d2288f31
[14/17] pylibfdt: Add address_cells() and size_cells()
        commit: 34fddfa16d47bd97f5b11d6b36dcbda91037e02f
[15/17] pylibfdt: Add add_mem_rsv() and del_mem_rsv()
        commit: 388137abfd0442c1bbe3df92277823d9070a2747
[16/17] pylibfdt: Document that FdtSw.property() takes bytes
        commit: 44a2a718fbe62d703a8ce2ff576d2252c7444087
[17/17] dtoc: Add tests for the pylibfdt bindings dtoc does not use
        commit: 01fb2b4d7368483f95b6018b2c069de0b8ebadeb
-- 
Tom


