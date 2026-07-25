Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81927C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 09:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2535860681;
	Sat, 25 Jul 2026 09:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTfpXpDSCABm; Sat, 25 Jul 2026 09:10:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DAB960684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784970651;
	bh=+CxTdQiiskpmfV7KdjVuWAzkpeyqfGyO0dyQSc7kmaQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V9CMbOH3hbW+nPJxZ/VLk7e6/KI2+l6pwpZfZx7wZ8j4y+UtxoZiT2oO0yo4Vbgyd
	 zvBbE66zxFWG5G4lXiHPiCRRsBspGx0DpX20BCfiqbt1Oc5t0XKfVrzYRNNpbG7p+5
	 OUJg9wz8bqK/qAejpoJogcnGBIJyzom1Z4ya4r3XVlHCT+D/ycdf2ytbqJRrtHcVgH
	 auvPST6wZgKOFDMGwTi87UULL3x8vxQNsP7EG6bstwXhQA3KapOd+RwgetS+jCS9Ya
	 8YxNdrH9RdbRc2So8BANFmZSrPq7Q5WaXGLOvc1ozgEnCh2x8GCtxB6Xmc/bdO7oIg
	 NTdKpm0iFAmuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DAB960684;
	Sat, 25 Jul 2026 09:10:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7AC4977
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD56A60684
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdwTtftt9vGR for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 09:10:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B19260681
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B19260681
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B19260681
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:10:48 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so748505a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 02:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784970648; x=1785575448;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+CxTdQiiskpmfV7KdjVuWAzkpeyqfGyO0dyQSc7kmaQ=;
 b=rq/iDid3J1wyD/ClrnLhZq4yx3ohOt9SvRUqW8t9EGlBSW5uwhAEO+xGK2TG1/WWs6
 0w5ygl+OxEEn+yFBwj77B9DUcWMPZhbJeKbx7fiRJoqdiVuTkrW8CROQ4clS99eUZkHd
 kGHrZgvrVrJ/Hk3lalq/fE3Vndsj0bCCc6XIWTwa6y0wSHqdUUowYCyVcE6GB1y+v/yW
 jrkk/AmB81s18IZhjsDBlg3nC0XGhwJXm/kSDZgui6vnDXbafWudx4L3cqbuDWcQnqxm
 4iwC6Jmh39onnK0z/zQH4jZkaZuXpUxrzng97MhicyyyxrhM9CY8Phtf7mYh1btUYn13
 HtjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSl/zGBLUDDOSTMADfQw4eZPxm4nr283zP1I8+e8dKkxfQsmGKikGaDL4RNyt0LrTRmbl1wJE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy1pOELX9utadHOQmlinaUqLjMGdll7nBpWk0Mmdeyd+AZPzJo8
 5vCuLIUysekW8wMFnkd5/NRkJCzdvjxe4UMnfh37NpTikWudoCKqT2tRrUgMN6CkWhk=
X-Gm-Gg: AR+sD12gMxCGMQ3sozHIx0EGDv0tIHtZlEWpa+F1SLxRQ9Bb3bb38kuHp/y0GnK19hd
 dh9X6xM9jka4iII+9OI613f9OCHXYO9LHq3TItpaHJ+NLrsZRqIY2KeX7JJG1tzbsDFgz8VpKjj
 FDCp3he6ypI+1fIyyEt5MAZQwF5uo2VEX3//T20kHnW9S8ZSYW1FLUoCZ56L8UsyKJsYSD7ug9s
 tIaQ9saN7UfC8PohPeK89jU9uWqBlkji6UeAGijnLqoYb/uvYqnF0LrWLczGsrH85Hz7OKbue/y
 NrXuIAE1wJE/jeZCw0AaiOW54VM5ETL3oQpydpUBq//5O4oe5pQH4YB3rLp3QR0feAvYfVZCurM
 FkFLEEjWy0oLhTakj3q7x/8jrGsEJLxBB58x27cNXutpv8amogrHJBZpjq+OmPHBNhNUBYARAsZ
 TaGiUiXC9e/RahAdXtMMY=
X-Received: by 2002:a05:6a21:a8e:b0:3c0:9c19:b275 with SMTP id
 adf61e73a8af0-3c67e027041mr1700141637.67.1784970648272; 
 Sat, 25 Jul 2026 02:10:48 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbbb663452asm1015101a12.14.2026.07.25.02.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 02:10:47 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:10:42 +0800
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] rng: jh7110: Fix invalid usage of dev_read_addr
Message-ID: <amR9kknwoqJgNSsU@lliang-1876.localdomain>
References: <FRWP194MB27908D1150FB7424A8C57402DA0B2@FRWP194MB2790.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FRWP194MB27908D1150FB7424A8C57402DA0B2@FRWP194MB2790.EURP194.PROD.OUTLOOK.COM>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784970648; x=1785575448;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+CxTdQiiskpmfV7KdjVuWAzkpeyqfGyO0dyQSc7kmaQ=;
 b=LWxGJarxAtuc22eM7kjpuW6PfA/g4U4KSpF7OR4AU9312l1x2ZIEWlbLlewWnVPDJz
 tcyZj/PFnI0FD/W77ZKbdSxojt/zCeiKcl8P/Ljz+09hyncoQGygfP7TREr7Xa8dSfUn
 So8mVQ3euzNru5oTFYdSC1QxjME6rt4bWXtpXa2LjmPTBD/jLCkI3OlwWANU/ZjZwTfJ
 dSiizy8gZFAYqG/dY1b4EnunjY+Ow3M1MempVavHEDxSilj+ng8TYDEktl9RZEG2vYXc
 s0n9SLv2rVYFyKlFtfyLc9dgszU+B7IoOiVCTpaOCydAKUQuBp6iJwOgRfatTvK3ic1b
 8vBw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=LWxGJarx
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

On Tue, May 26, 2026 at 10:58:13AM +0200, Francois Berder wrote:
> dev_read_addr returns FDT_ADDR_T_NONE (-1), not NULL,
> in case of errors.
> Replace dev_read_addr by dev_read_addr_ptr.
> Replace error to EINVAL.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/rng/jh7110_rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-riscv/main, thanks.

Best regards,
Leo
