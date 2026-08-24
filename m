Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E12C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0D2A4065B;
	Mon, 24 Aug 2026 13:25:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zddO0AAx6G4M; Mon, 24 Aug 2026 13:25:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577940;
	bh=Eu1tvkfINLDA5jUtKoyk8CJFWZ7SUE2L1X/VO1yiqdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ojZmTtHg9zhCJO6omyeMRjMv4PqR22Hx1KbX7KQFH/6xGFIrNYGK9FEsgVhcnzrby
	 trJ9SDKPrngrUZwAS+i7Jl2kCXoploYJMdzVM0TWc4sK08QAlVdFJP0eIacQTkThcK
	 J0xbqmc76bA35CTaEYq+syXZJrW24kVhjvC9cn4HQHVMfKAHJATKYt61RgRHjx0gKX
	 T4lgqxYhc2Pdx3Nk3+FG9ESDSk0QN+PrVEUUZ9E4/CcWs1TvCrvONZdjVxiYuIVpQ1
	 iS9DkqrVb+HLOFZYOxBfPavzycESZkgKGBg6dFA6zw1WCxSHlG8siCuhR/+Eil0A1e
	 UGS2os4GvH5Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF218405F6;
	Mon, 24 Aug 2026 13:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6F73AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4DFF40050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EbwU8FjqfSM0 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:25:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iYCFF/54
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A422440029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:25:35 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so5202235a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787577934; x=1788182734;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eu1tvkfINLDA5jUtKoyk8CJFWZ7SUE2L1X/VO1yiqdo=;
 b=iYCFF/54cMqEzyf/RsWalpve7O2ZmwsFqx+ZcM0uZQbnP+1nfsFo4hV6gjiPZsOpcD
 gYvYi8qbifqxOgCNKDzl/g0pzP6psC6+vk9FwL5yTecEduWYw5bmnvTWQzERyeQ0W0p6
 h4w1+a40cJaD2Iob4gLnlzb8QH/Yc/0blRi16koXfthWuxd+X5S/6Bum+xUuA02AhSTl
 l6SvMBwOsYGhEtkcVrpkpqfaA1L3KHPNaUmJNTOe3m8WQDZGkRPg7m27wEOszTaiF9QL
 RDI5eGX5QebY7wUqyoItf9eG9QSmK8lLP0VNKRB+FlwkHDowFF8gkFqMN/cNg+nOxkue
 emCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577934; x=1788182734;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eu1tvkfINLDA5jUtKoyk8CJFWZ7SUE2L1X/VO1yiqdo=;
 b=ps3VG9HQzbBIo3ACa9TaJ1Gw6EWFSKN8vnOcYly6extrxRG4yi/M/gzbkMbuDDFb2B
 N5T5A+GIAb4YRALfqcASNKPkqMI26HOEtwcjKfhOfJP/5zJsI5YCOLChtVISciXbbyl9
 wYCFfq6NbFjb1lr8Hd8fdj9/KmIp9544ZMDEMRIL66e2gwszxY2PKvvOCsPzY5anl7/2
 YkvAjUUJS7WcTsCIiCa/P8owPYF3R7YFozTCMlgreVvqx44y4Xn957c105mzy+Vb67E9
 2UUCKl5gCKLCZkMlW79ngO+0gkdYHDNgqPnc8l6Yz0zVtmimIxqgzc3ZiRTNip6Z8c2t
 ffqA==
X-Gm-Message-State: AFuF++k6phPdmPWWfieVaZvCDiyBpkHAeDcBqS55q/chhjkInYzJ+bRu
 mQfNPpWwaDr4TaDAqkPvsQOBLZlIQz0hLOaQ2CrsNDHPNkRI0A5Ff7puDBbhdoQI1DE=
X-Gm-Gg: AR+sD13QIG0VGqb14iTHlqm6IAu10valtixcmbC4r0TXz0dOO6ZgSws0KygPY7F2eTa
 ZxW2+M8WsKfqRaSzi3CrKyY7b3tbAf7hhEriHVMiPaoZ7O3oWcmuuSGQagFwDlaLBEVtxHzeCPq
 5ExSVhe+3RTAH962Apqz6wfSUs1c7eP/WYLMzr9ixLT6OH6JIbmHkeO0KW0KIim/46Vs3/kmZ28
 qm2vAGA7B00pED1cfNP29QRc/bUo3vN7Iapd8rabcgqhWKI9Tt4ryMhfxHiiq3y4Bz/FrisOZRg
 l3qWcvNCckmB2U3hVYqp6YnqhDRxHpnz/TCtJZP0u6Lzng4MtAqnatQzlQCFzAPhBjZW8jsJ3l4
 erIkwNpYuDbmZm9QNH7CvQoqdmkml2eVhV4cuqd+/GTL9Jh9Yn0BlYVDbkLTcPAfEsTNZ1tg0iL
 2M2uj7lK1wXYG5yGKzdsnAH+PefSVb5ZJsY/zkI96JLxRCjhP91tNCnR9/M1a2SHIK975mXrA=
X-Received: by 2002:a05:6402:24c8:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a42f172088mr22302955a12.5.1787577933873; 
 Mon, 24 Aug 2026 06:25:33 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199767sm8894947a12.15.2026.08.24.06.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:25:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:25:31 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 03/13] mmc: arm_pl180: Gate idle card clocks
Message-ID: <aoxGSzMOF1o75XpH@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-3-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-3-07ca794e2b94@kernel.org>
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

On Sun, Aug 23, 2026 at 10:39:22PM +0200, Linus Walleij wrote:
> The MMC core uses mmc->clk_disable to request that the card clock is
> stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
> leave inactive hosts driving their card clocks.
> 
> Honor clk_disable when programming the clock control register. Also enable
> the PL180 power-save mode so the clock stops automatically while the bus is
> idle.

I'm not so sure about enabling PWRSAV, given that even Linux keeps that
disabled. See mmci_set_clkreg():

		clk |= MCI_CLK_ENABLE;
		/* This hasn't proven to be worthwhile */
		/* clk |= MCI_CLK_PWRSAVE; */

Which is BTW your own change from 2009. :-)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=a6a6464a0ecd20c5f1594a4fe5b24af6181b7366

The clk_disable part looks fine to me.

Thanks,
Stephan
