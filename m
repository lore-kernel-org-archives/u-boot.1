Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72D9C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42B714078F;
	Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWU-dTABtICV; Tue, 11 Aug 2026 22:50:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 860174077B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488614;
	bh=WcTjt4R0QG9bxS7jkk02V3UDeRZV55ANdODaOH7+6GY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKT1+82uN4T9tEBhL54yozLkyZ0yApS3JetM7KsxSEYlys238BzAeh+Qrz6E4f72Y
	 xq22YiuKJ8d5nfhN4rR3ngM0PDE9LTzmn090uHVHcCt2c/Ety4LU7jjElHLJ/eUZaq
	 +cHIezp5Qux93cPbsVYoD12HvIcRkhsAAHN7lGpVmw0YhiVkr04gSyoqPxi5Hwf2qO
	 G49E62/eHepv/IsKbPhkaWiO28I58DERN176KYfFx/WpUhgJFeOIhmHqRcWxxty8O+
	 fp+kZBCS2bxxhWabcun+FpsSunnO+xiJLJWQQ9+FsN8oDOlrHeqgnL6tcn/lcVNsjB
	 J4V+27PIxlRFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 860174077B;
	Tue, 11 Aug 2026 22:50:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 372061B8
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28F86402C3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3khvXJUffKF for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 78E9340026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78E9340026
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78E9340026
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:11 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso261348eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488610; x=1787093410;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcTjt4R0QG9bxS7jkk02V3UDeRZV55ANdODaOH7+6GY=;
 b=l8DZUC+FweJWdTe6Anx0ZQeSv8LRKAEsLdaiTwVBgOTA8I8u/RVfxqxUCuFhGvxY0p
 putFhm84lia/2Zuu307IjSFiNYqy23vJxiU0h8KNsCncCYAjAnwg9iAQ3y5PotCai3Jj
 qDbBw4KQENHgHkGLPPu1q3apf7btxxkZpATnu22ztpOo0+NMURbgBRjnSK30Jy9+6GsH
 8zdwR5GoKFAQdFHNhCdLVH8U9CMZBS3XM0TZuLaCemzmpDAJuN0qS81jIPg3w9dA0hAo
 l4R7hUkGxqsc67Wv1gVoKXz9zATDA5A0ovML2slBB4+GjjlJxE87q55XKXxVvJV0gUmk
 9plA==
X-Gm-Message-State: AOJu0YwaqjSLoUXU1sIjSUcpd2O7Ok0qgt8l2L7P2QbTUMhL1gaWzGjC
 5CKE+aYlsCNz93kRw31TmGhfx4VHHVmVh+STI67hx5Vlo+Lt5KQdXjgwlOijmhb7xcWwydU2q/V
 GNDmjh/I=
X-Gm-Gg: AR+sD10S6QGJwy627qd2Wop3YBs8v8dtQXfbfivM4spN/mCF6a+7M7iNxn7nKk1YLrw
 ysXtomRRXf+b89j1of8fLLUwS3bT2s/OXrq4AZhq7zM5bdw3eFJ+ZALPIgZbiZ/QSVM1fXyR638
 mJecfcUFwmqRyRf18d7oek5ShEJ6iWq8GF2INqgFz/Kcty4WWwYuha05aoPOa1mCr1JU4bnN4Dz
 mDC/azg5Se3UaN8S65GBd5O36alb3EcrsOALgNHDpA6K6K04SLBRcmtVyYaVDlJzuohanRBAw//
 FMCP8pM4nbM5CBtrvNEhAvdw08X1pNOl9DSR6mFuLxuz4c8JMkByI2XynIwI/ciNFiFuW3XlJ3N
 TGrtgc0plfBdeNLXqEHKKEew05r7bPGgOLtQSMRvAdxf7czR3YiUJKoa9RZwLjeTidHem+DFFuE
 syC8GTOhnTugNFK06UgW4Dyy6M8r7ktOOVm55J/0fbOot/yPGCsdkPcSBY9AUDbtkRM+EC4STYl
 A3O8ZlHzhZdNeW6CyhrUNfxueIwrDRCQ8WHbobeG7BXT58DvZAoFYW4BcdEg2onAGrc6O3hcBnX
 f49y0eUT
X-Received: by 2002:a05:6820:4b95:b0:6b0:1b82:89a3 with SMTP id
 006d021491bc7-6b0b254659amr421322eaf.9.1786488610349; 
 Tue, 11 Aug 2026 15:50:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Anshul Dalal <anshuld@ti.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20260728-negation_fix-v1-0-c8021b2b74c0@ti.com>
References: <20260728-negation_fix-v1-0-c8021b2b74c0@ti.com>
Subject: Re: [PATCH 0/2] Fix negation on modern hush shell
Message-Id: <178648860930.3127030.13400849449043554741.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488610; x=1787093410;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WcTjt4R0QG9bxS7jkk02V3UDeRZV55ANdODaOH7+6GY=;
 b=lpOIfq4M7ToXraz1sDrxGa43OvnVN/Q9PJLBpz/7XRilyVR/IurIxMNrARb4IN6zMp
 c3AuMiMaBphU5d3j/RWA8Vr1XeJ+1AzXCfxJyDzQpp/wHzHHZXTV/G9MsnmC+tOvXzLg
 /Lb2BFWf3CCI1t3Krg78s/F530jTmqGXmeUUw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lpOIfq4M
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

On Tue, 28 Jul 2026 10:47:17 +0530, Anshul Dalal wrote:

> This patch series fixes the negation on modern hush shell and adds a
> sandbox test for the same.
> 
> 

Applied to u-boot/next, thanks!

[1/2] cli: hush_modern: fix negation during run_pipe
      commit: 222563887217c9465edab460f9c52011566d959e
-- 
Tom


