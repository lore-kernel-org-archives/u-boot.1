Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030AC531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47ADA40604;
	Mon, 27 Jul 2026 06:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNDIU-lXzshK; Mon, 27 Jul 2026 06:37:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEBEA405CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785134269;
	bh=BuCCQKuN4WZ5P8lwFSDFLikxhEr4XAYhJNrsQ0ug8lY=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XHZWhUF4Dpy2Qt7tjJ8tc0SQjifw/c3vFbPwoB9ky8a/cjboRSOJzepKwUzvNCYDN
	 AqtQ2n6e/A1CesSVJrhP1+Gu2dOAk6MqPDrRezkTQwSKqwxqL9QS4o5DhZe5JmHM6K
	 Z7vJv/tY56dx4ULjEd/TwinN9qU1k6pfR4x3hKiQTrqWD1WeG7x5nvqbJcyOozJc6W
	 +FAuKam1J8cLJPxXTcZqxGpPIiPj4XMI6F9qN5aTQ/qvNwVZl88JlPXDpfNn8cYevh
	 wzMXlzFCc/PnXZN1/MqjMpgQifpXNJFGr9EpAmw7i/D5Xoy6AkFHiiPPrHHgTDsXAZ
	 wIl2wPR9Fu+uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEBEA405CE;
	Mon, 27 Jul 2026 06:37:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 585B34C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 370584009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wC-qzODuTogu for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:37:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E6BA640089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6BA640089
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6BA640089
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:37:45 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84e27035206so2250632b3a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785134265; x=1785739065;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BuCCQKuN4WZ5P8lwFSDFLikxhEr4XAYhJNrsQ0ug8lY=;
 b=NolKtgtPGiNOd1J6NI5/poUSPnKuj6GmjW+uyV+Rz9QCLQGlGAJQlWDIFFFdWCwqmp
 z+zBZwqHyZNT9iY5lIcUVZHAR65J7FPvPjekOTJCASXkjBqwBsX3DzwDyOVVAL+O2M9U
 QpZYM/Wjm+iJRXkSLAxmPvk2p6UznTfuL9e6w+4SXXr9xvN1sZXzPobv7Lc+h66JCXqh
 bMx2IpJ0Vn+fBUDJdPc2X0Zal7c/LRqhvWNzqteEvl5wn0PtsVOtl4iH6DIIeE++h3L0
 Ef7cwlbKCM+l6Wkh5xHWYJD8SDUB1/TpPkxcwGg797ffqrc3iXOnJhC6YZqj83EQZAIm
 WmuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPSgEblSR+fn4dKlGj4lx2jgFv/y4f/kKoci1DCW/jZLd6EzW2AThrUGX0PvLYfsFPPzaBYtY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyRoGSJoFxCktNKN2CNpjFPpdV2Vs2w+FYJrIkcjDpuSpEQH+Bb
 SOLIRAF6MDywxU9tAiXKa1EO8C1dTSasG/UftPm9LWZAiioEkRNSfMj/yGUKZEOYkvY=
X-Gm-Gg: AR+sD11KKtH2EYMPBtQtG1KSfRISg1u83vEhccIj9K6KcpvQ2c52RFEG+gsgBHXzzx7
 HL795xp+b5q0Y9HI1JipZuJFzNhZY30bKgclpGLkLkEbi9eIrU9HbiSBQw5TTr+nBMRsz1YYHWM
 UTnP24z1Nxc5qrghB0x98y3rz4q2pPUbIljhx6YnSQGcrM6Eutu8BPzn5TyLkX1SonIEO7xFc7B
 KB3XJ3+DwXcU9oQZs/Sb9fQlF3Np5geGlAjWu+qILKJ5zVqtUsptUkaeXGr4h5A5FbsPco4wml8
 u/YfimXLPnnN/8is8STcfCF9c9GbvMlJWJg2i7HejoIFiWJhY4U2sHFSV8Idm91JXvI+6Ub2gbB
 +PI1NNJE/8hym925mkrY90FCzXIEtR20OJV4I2f2N1TQnMnbNhf0WPLgOTbPc1gKHgSQs+ra6uK
 xw40zzU6PkQwrj+slCaLy+
X-Received: by 2002:a05:6a00:1410:b0:847:968c:a0f1 with SMTP id
 d2e1a72fcca58-84e5953e5b5mr5742156b3a.43.1785134265111; 
 Sun, 26 Jul 2026 23:37:45 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.184])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e532585edsm2529159b3a.4.2026.07.26.23.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:37:43 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:37:37 +0800
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/3] clk: sophgo: cv1800b: Add cv1800b clock compatible
Message-ID: <amb8sR7BcfwEp1Yr@lliang-1876.localdomain>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
 <20260706-milkv-duo-upstream-dts-v1-1-8d010ddda7ca@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-1-8d010ddda7ca@zohomail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785134265; x=1785739065;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BuCCQKuN4WZ5P8lwFSDFLikxhEr4XAYhJNrsQ0ug8lY=;
 b=WfawPsrIgjJOtMh3P1Y+SRMtaTiuWv65PcCqP5mqR7KlM6DOt66bKzYhBrqZxbELy/
 PwrgwdLOXxnurXIL3TY5xHaHlYCcVewz+WzhALq8+t6eqt+8Dxu/9yNR+wXDYeBifUSJ
 ziIbGRpoKdpCiQSbWAFUtZ5S111WI+aM5bvrVup2YYuLOnf3hhPnX/LQ8DQb2XjG5UXk
 dr9I3RlQaS1z4Hv2CMQf2ivjbfgb3KPE1slMjhhrpDzWV+l+9WO3AiDD6QXmz3g4z9MR
 RSNFczdhRtNs4dP7cBbu/DrHLC4QlR8sh5bEdNPMKNscnpwhe6izJB5i3r4e9d6yyVmb
 G2kA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=WfawPsrI
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

On Mon, Jul 06, 2026 at 09:43:41AM +0800, Zhuxu Ran wrote:
> The upstream CV1800B devicetree uses "sophgo,cv1800b-clk" for
> the clock controller. Add this compatible to the existing CV1800B
> clock driver so it can bind when the board uses CONFIG_OF_UPSTREAM.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  drivers/clk/sophgo/clk-cv1800b.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
