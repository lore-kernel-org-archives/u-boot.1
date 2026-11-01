Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7580606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PxeM3Nm+;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MaZZktV9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81BF2405D9;
	Sun,  1 Nov 2026 21:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jRlT8EUk6IF; Sun,  1 Nov 2026 21:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2F1F40629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568398;
	b=bu/zMy112tA1+tfCugLAfSbIU3tTynisot8zbovsryhF4Cqwzwg/I/hvtUJpEvt7Otxr
	 FOUe52juBB/2gvtgKNct6c/r2RApM+1W1gvMaJUFPyyalEPOobyMBNCVWw4X/pkVPdI68
	 KMDDQlLQ5pC0k42fLUJnZoDyvI5WwPvbrSxZxE6NhkC2cL04q3CbB7kZRaJpLanueIZbg
	 /KEx8Lds3W/U9q8jPBhV5DpDf3TOwPkcRKLDlOGBeH0q1RmZaGI4ZR/d0I+f+J8Kb3qP6
	 xKJWFmXEY1Xf8zCdY6Sm/sAvM2xuQmeRj/OrztE2MZTLtfW5hW74VlwBPGw47qIbipA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Lf/LBIF13kqsrRpJPhQUCZuv0lwvw6PMSJLwI0V80J0=;
	b=VQHRGpasl7kE7VrZKLBbkD3EwKt9/iLHdPiBr6WHFtFi98t+wYaKM9rGz6lsfuTkm5Qf
	 bGg1xIA2M83AMxQhnaa3/iLwwgU9PR5VwmPboga23xRATzY06IMDrV7rs8NZujiXR19Ac
	 rBiPpdBB6hST/8qyZdveqlnMdaRa1Sw27alaqrGSw18i+gwbuuphsF0TjFeeFxtseAFTG
	 CTzhwxc9ZJ+82NP0xi4qqtYeXk+GElYJ0qnmX7GJC8fGD+yxTqCURmlj+4pgqqDd7Rbxo
	 5iU1mVFOg19oCVGv1n5DEGNzB/EN+332VLy5rediK1at7vyJtrrT+k8fLhz6xEHPwHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568398;
	bh=Lf/LBIF13kqsrRpJPhQUCZuv0lwvw6PMSJLwI0V80J0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PxeM3Nm+N/mUdlut8M+SXd+vOxQpzvkkxDzSEXHHg/pbKpE/3zzzMwAOGEuCIagGf
	 bfWBEuyqgyNF1ToCqENlJpAZ2MY//dIvlq0+BgHBfA8kK3H7AydsL3Vx1qcxqRFOjw
	 lalQKJLz0n2U/g67j8cp2wPyWeTW29TZXPpzuF20hOSxLAcreui+4pJYnJcUiVaCjd
	 I0AeV/MMcjdK/YccE4XJXHCBrjRp9bqHxxylOEFDN0rx9pCtBxLZzsTm2yJLwD6jOi
	 46+ykZ5kwRum+l0PypXdCBK0+/7kX6Ci965oMEzLxYIenGISSGu+XaPx7gSXlZ3mE1
	 ZjQ9ZBgsNe/mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2F1F40629;
	Sun,  1 Nov 2026 21:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F31BC34D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F055F80D9F
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlP4E6F3pMkx for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38EBF80D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568393;
 b=PtBsfZrLuvFyFePkRlsG9dWjykstmi7RRz6PUIx696XB+hvOSt1LClyb2E6yIW/ueNIt
 tHqt3KaetRpT0P5dkupTJpWqYB5SY5v17Oh1k16/Dy35GxJyDvFcdAsk2Pz+W001eMzIH
 i/hdVQ715btPGH+XAcJD0QCBjipqUivvxDeAwAw78X1xy+mZff6zfC82Teh6mHGNmfrhp
 x8IQTnf5O3M4yau40NtXH8mfCz+9Eh/uHI3f7Yi2J1QEwCjWeJlGQKkxlSaThCqzNKs22
 8dnBtjwhya3tXmNNWHe+s9ctg3n44IOLKnbjr7+6/SeUh5fmga+FAi1M+lrksDk96FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568393;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Lf/LBIF13kqsrRpJPhQUCZuv0lwvw6PMSJLwI0V80J0=;
 b=haPfjLy0m6k7CngHZUMYBQpJtjdYa22d94N4/4tPFaPTdvEskege+FtgC5pzscTCm7Jb
 OcOlw1sI8MY7hrjH4eP4DREMGcBFQQ4vXsh/xOUmZPWzxzqK3ZnUgZ2oowWb03Txna4j4
 pyTNoz6uBC0Dok7bJQnefUCwF/xl0RNHO7AioUmC7Hq6WZPlqlGVi2BFp8uXpm/jy61yJ
 E0DOKZ2bVAcEgWH1Zns0qjmf2s1axLQ6myOWFWwtGeSVWYKKPyzpQaCcVySCjGIbCRsJ9
 3mkaUCke2rYvg4Kwy2Cy6UmHyGnyX+ExlbLyhWS6RoNcGRPkxh/i+oErp22qOuat6GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MaZZktV9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MaZZktV9
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38EBF80D96
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:31 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-85c1135c286so1527189a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568391; x=1794173191;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lf/LBIF13kqsrRpJPhQUCZuv0lwvw6PMSJLwI0V80J0=;
 b=MaZZktV9voAbQDypFJElWrTxAeFGBlZCHXg+aCeUIgiPMTMfZLOAwRT5WWpyPROXe1
 fHycKbFgE7g2kq5rKFH1ZhJ73kx4iSXQdH9D3+ccRNaNNbMHt67aXFs5P3/Xm0e0ccXJ
 W+Ov822S3FITp0HTqB2dYo/5jLvg9seOyAWE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568391; x=1794173191;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lf/LBIF13kqsrRpJPhQUCZuv0lwvw6PMSJLwI0V80J0=;
 b=vTg56t+93b6kAcI4VnvHSDGhOxlaa+0qt8Scq1nU91x6taYKqTHA5GSsAGqbCO+bp6
 pO3/pKKa4GNSSWeQakxdWfAtfsckFNIsJe3AkNOJU+3jRJ5Kk1Fm1foR+x2dc5D33QP7
 8eCIneA7TlwyH4ttbljw6uLIJt96Qrk49yGSM8aVJntTSjmuw6z8DRkkCd6kvVzf5LcY
 1CZmIghHM7Dq553dDreMIEXOKWo/VBeWitxKcPJBrInNWzbF9TTiEFTzfZkrsdVXwk/J
 hNpOYD8YDBRsKWA9W/70WVgC/czziV3aV9wg4KfjeN/xWG6G/TjShSED+WIcpQdyI9w3
 c1iw==
X-Gm-Message-State: AFq9FYLlMEC7De39OR1QJ+Ot71SRtlv7Z7lJ3IF/TVrkADZRsaQg5xzV
 /jon66xnBygtK7JFNcEhFgED543Ge0mqPRGFjJdgMrErJSh6JUGk/w+dhHQ2yKz0952/Du7yTwM
 lq+FcLJbrfqNH
X-Gm-Gg: AYBFou2yH3kqkOvE/JGkP1O4iTJlD4r020K171BiotKEkCRyKpPuhisZ2IYohscKFT8
 4MfvJReDAE5SvflO3CKvPJxYutph/VOLqLec5N8DFqFu4/bNwnY0TC8nU2NdnBmd5RSag+a8KW+
 DFyuVgd8gxGna/YJlterP+1nih5a+o2UFE6TLH6uZsU28L5AOLPEASluctqdDvbtWiYk0PrniAM
 Xtfz9bF500H9xnbuGNqSEBNJKsxrTWmZ5D00beKnA9tuUPZpYhwE1DIP2QTK84aq3hWtZsF8NKp
 381Erd5Yh5PQbJdx02/LtXacm9WLsYtxXmCwAO3LbcFOtwGKTqdVpdzi/FwVcEkaVNq24r21wEP
 ihRM+Tv63iOyr7hu7XKknmQE/EpbOFdTgJNsSVljS0APmLq9oB5vPh3cT2EBvojt2XUSqdgK5AX
 h7UPLobIWlHUMXQqdNTzmftLN84oQtqEQFcDIbG7ZkWWsawK9U7KmjCRozh8cDb2hh1vzcReDKV
 xv52hhgKEIVpTcSuhyiOQ6GmtfDl50oaRg1rkP2y/PSkL/nYgrDe2P+lGJJoBs7js3i/2ZiOCbB
 XXeYc1HDIvJb8CwF/7e+PVmBUVQL0ofZgX4dzehtfb3UjGvkt2xeergC/8HZQXiQDfVPvwuSZhY
 r6aGngTwZ4Vyf9/No5NNS7bcqfzDD0tjEQ1UntlnwP7Incx22zw4mtKRihBwgv5yIgPdMfHZxF6
 5ZGOzhGjaCv2eslc5003CFd0LSiKjycqLD4lwkAY/XYcBZ6IGXk6E=
X-Received: by 2002:a05:6830:2e01:b0:80c:d30f:97e with SMTP id
 46e09a7af769-85d3665eb4bmr6095224a34.31.1793568390887; 
 Sun, 01 Nov 2026 13:26:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, "Maxin B. John" <maxin.john@gmail.com>
In-Reply-To: <20261023220133.1396280-1-maxin.john@gmail.com>
References: <20261023220133.1396280-1-maxin.john@gmail.com>
Subject: Re: [PATCH] cmd: mdio: check argc for extended mode
Message-Id: <179356838990.224230.15399174035987180152.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:29 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 01:01:33 +0300, Maxin B. John wrote:

> Check argc before accessing argv[2] in extended MDIO operations
> (rx/wx).
> 
> Return CMD_RET_USAGE if the PHY device name is missing.
> 
> 

Applied to u-boot/main, thanks!

[1/1] cmd: mdio: check argc for extended mode
      commit: ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b
-- 
Tom


