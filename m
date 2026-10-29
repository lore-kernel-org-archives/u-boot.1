Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F078606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iUc2F+6I;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nXss9cct
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0E9F40A7D;
	Thu, 29 Oct 2026 22:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHE4iPusiYPr; Thu, 29 Oct 2026 22:18:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E007C40AB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312296;
	b=GG0cKHdHp8EGt2lpYO+JnhZqUo5Ra3m3DkBBz/F7e7NKryff44vFe+PJO1KZzSLxEtum
	 ySzB6puCSmVFcsZooYd0Ym7CaimhoWZgOkKF7pN23Nrvud2KEq2y5g/QiiWSDtfUBxqOO
	 8wb5mMVutX5Hek+LN2HRRDKd0Bg8dk2Kp30vcknwntf1iSy2ly6p6CpcfxaHCZywP/byi
	 mz7XTS4HA2GKXdXTraVbgf/yda3jZQ2jmXIAXZIQRsEWwp+F1DxTuh8nRuPajQWEUAWW7
	 IGNlw9+uvWDW1ME1rmVmnVZFLhdWYa6QnsHzikz3HQuVpklnFO7T5D3b8oelEXko8ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZwXeFnm+UzQiQvt6a81ytUSsegc3u4MHypcQ7OHTlzY=;
	b=cpW6V4BtmKEYCwFeG2NJ6D5F1c+BLC3Ep2In8gjObEyXu4X2w7iS73bXcvOFtrGfTAn+
	 LFOpn4zDzK53eNJ/Pi+mSbE0nYXOU2d+FU//d0BafBXq/8D1F9ASFRdLAM4E51KzWEvGk
	 VbW7AGgZ+6vyXavf2Q1OVsD0UzWK5YxZ3IgHMpIjI5UdAHJjvKO+QUyOAz45/quGo823d
	 m1/hvRsI6zAAT0Rxw23YF/IOU3dE3JOrRMop996O2FtL189nKN2qA91zNo0lIH8/eEQko
	 v7N9U5hdedwa7tgVpuJeAsI8K54jnfaCnnWwEUOIpVjH1MK5Lw88HBpSbtuRk2DrwkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nXss9cct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312296;
	bh=ZwXeFnm+UzQiQvt6a81ytUSsegc3u4MHypcQ7OHTlzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUc2F+6In3afGZ3HxTmaLeXxCUcN0fJdslXNCOQK96GUuI99fXLxSWm86k35xEPoA
	 /DXjY81kFy5TXLcxw9TkTR3oXt/68QvoAyI3qzwMzNN2iVQdt9my+9qqAGftdDbJU8
	 K7S+dDaY+4i5nwGfEpoXNikFAnYB+z0LiFsT9PeRtbR3oYQOu7DYkwvs6WGn+B3pug
	 AF4SCaGLssnKbNHi36lhFWMkGvpADfCFXSrCClEEaRq9bWRABL4z6KvZ0kHXMO1SAJ
	 j90doq6ZG+P/oPzHwCgFb7aZm5MAKbbFx7LfvsK1Iasi5u5x40+cxkyFdbckL9iMB6
	 D+/5W6lNUyiNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E007C40AB0;
	Thu, 29 Oct 2026 22:18:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D50F362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27EC440A8F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKtI26wdrvSw for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5392840A88
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312279;
 b=endCSC8gzRMQXnrSW+Okdseq7o9zx2vSNnl2FtH0aIKSWXShExv1lbD9tsibiCGl80FT
 Tau5crXIs66A2os9t9FZhR7sgAPxMMPua4/oldtf6NKRgyYVi+jnAleyg2fKt/OC9GHkd
 xmqT0gZzGM3aGkzoNATTJxBDq8SYXgUTh7pqv1K2kmHGKOP8xfyzL7wPSvPivtEHOQRoD
 Q3L2bJq18gqE1QxgjKe/d7gddTcWLi9aT18JzSPtFfu4ouCyQV4N0VQhKprACs4F3mMBb
 ElpjuQG5dPtsaoV6Ittp54H4gA4aiQSuIGWnc32A7g1RguVlF5LcjM9/WAPuLfndi1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312279;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZwXeFnm+UzQiQvt6a81ytUSsegc3u4MHypcQ7OHTlzY=;
 b=XNqf6cMBOOM/mLgYg42Y0NgmpTkZzA6yALiabi1zu6JbKohTGLdgshL4MT7f8W6ikSF9
 uiuaxUYSJwJCP1OOVdJ2gPkJ4NyLh0/xqrlQHQwBXpBHSKgHJhGgjLWi1LJMVTuy9O/Wu
 vKN1hd6WNt6/BBKB7PcjCADcuUluFoL6CluBlXrfFhVTOkzaPPLgiswuh6QKLwdTzPnIa
 KqFAEVxnDYGj5vSmRJ1MwuNfem/l4PKZxERg79S8VelnyUzk9OBxavsJ3IThQexT1LvZd
 aY6h0QqzfeNNEubKjqAS5omcFvcC0vq2LsesRu1OI7XRLzX3KPwjwu8g+xPYwaBIbtA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nXss9cct; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=nXss9cct
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5392840A88
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:58 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so201424a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793312277; x=1793917077;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZwXeFnm+UzQiQvt6a81ytUSsegc3u4MHypcQ7OHTlzY=;
 b=nXss9cctJ8tmNiYmVX03Bjt8SL/5EU9182H5fBq/IQ0bboMCKFFA+YEqJbQybOlN8c
 WynWIUFLl9AZpMtjYk36DOEtd8pVQC4yha5STU1gYblst37BpJh2AWXYBUx7seDNs8Ny
 smXjMGPsnKj6YPhO0+ti3K+Sp6+P94Wg1yUJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312277; x=1793917077;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZwXeFnm+UzQiQvt6a81ytUSsegc3u4MHypcQ7OHTlzY=;
 b=wC++VqaNEorV+nClkBGWxBoSH8SrjIRweMD+8DkshIYC80dNnmuP2695Rv/K37HHx4
 DiYR7EDDAFy6HvaoZn2lksBBrXsGLxhddaBZF0zFxrjnSrpxDx9cyGLcvi8HjKgDtvTF
 2DHRftm2s0IOdAL7a+nrZkKTf5CPyDUAn4cyYi1U+j0zSZ+IbNVl8C+b59vX9VS+BzR2
 jXS8OA9IQ/JVv2H0l48CakanGJZbcahGYoaJf1z4t92SZLjwAl+yMkLA7AC4U4U81ddQ
 Nm1Zc/J4VAI48xVGhdl7lbTgZZGUx6pd3zQcVq7Dl08zrCQe3uOJRXWZlgFoJxOM73+u
 bxBQ==
X-Gm-Message-State: AFq9FYJLj10EwqTxmT3yNbJ98682oCIrfFa1DFQOAr/MKVhOHJTgArPR
 oztGsh9QruykfSLJHtkMRT7OFCCHYCsjGMz/pfEDFhehawrFJjW4kTp6rRMKYfFyu1FzSsgZvCx
 WAOVZV22raZJr
X-Gm-Gg: AYBFou1EXmZVQ/3raudzW6Sb4/2VjCAbo+SYfjmoGEFAcLlNwddacQiQpMaT5Yp5qU2
 mw1YfIAs4txt4P/6/ECjr6ZQ8u74hwpW6Q39WREd3fX3PIhBuWMqZMjthnm1TkPFxaG+RMR+r2N
 hkOsN5UPZy6DRPe+OxNYuLFF9ewWsaVnuPJ9HGBceuMRDEdA5hyr3Mct0PduerdIYg3pUhH+Lig
 PkBfIUa2wfB1lpAGSyzzy8B35WaSVkpdXuezv3R9GJcTxO4dj9qzQMM0m692Q+UCIh831QLJLIY
 JHAWPm/YQW1G9bPmLURBei7+NYN8Zo9U7Rh11YzT0uEgTFJMXNuxy6gcIXNEP4cagWEtz8SSBf6
 ONOTy53euyStyCGQUgz5QvOfEc0vNFWdezzLAT7N9/uf0EE+aVmSRlp5Z4Uzr4Mrx2wna5Rf/Ni
 3nt12feO85doRP5V0MRE0paNEqjnpzOuHWj/07dR4pDWHeDQJVmErmLemQrib1y5KVYW1EcqQjo
 8iXc8zZqtAYcw7SFAb/e3W20ntJmCKYF6amFwIuK17zVHUacTKqoiwPQIcubHanR/4vS5cEE2IJ
 ZIfBqYIZGwm3s02bsiAYYbxHOqJVSuxAvnXPqYenGCmmPm7u1lowi3thrYD4gjI0l24Z9/fdoqM
 vc9P5kFttezbGGf74wuMEuCDnQAIa+BHP3+CxWscq8UShHrMaWokdNDTS/4hcJAHipjxVaCXxnT
 LgP9Z/25VjDhSm+w66rXNACFvScelm/CtiEGHdnwz/xAsgSw2KNvg=
X-Received: by 2002:a05:6871:7392:b0:475:e2e9:4f4f with SMTP id
 586e51a60fabf-4a9076f9973mr358953fac.29.1793312277661; 
 Thu, 29 Oct 2026 15:17:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4ea68sm119005fac.6.2026.10.29.15.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:17:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tan Siewert <tan.siewert@9elements.com>
Cc: Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Michal Gorlas <michal.gorlas@9elements.com>
In-Reply-To: <20261015-gxp-pca-id-v1-1-11857901aad9@9elements.com>
References: <20261015-gxp-pca-id-v1-1-11857901aad9@9elements.com>
Subject: Re: [PATCH] board: hpe: gxp: expose server id via device tree
Message-Id: <179331227667.3078583.13642160704010625141.b4-ty@konsulko.com>
Date: Thu, 29 Oct 2026 16:17:56 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 21:57:42 +0200, Tan Siewert wrote:

> Some HPE-specific applications require the server id which is only
> available via a register read.
> Although it is a u16, the device tree spec only allows either u32 or
> u64, thus expose it as u32.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: hpe: gxp: expose server id via device tree
      commit: cc5a61cacf15b700bae0d61985ecc8d5b25788f7
-- 
Tom


