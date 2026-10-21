Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D06606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vYc2Blv6;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Cgc4t3H1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD20E60DD2;
	Wed, 21 Oct 2026 22:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RDs8Fg5dXvS; Wed, 21 Oct 2026 22:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C7E360B6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792620912;
	b=i60ovYfg6pueGeVYuZEi+At9/q2Weo3axbFQnuNju1WfbkRjk93R7XRNcC0d4wjVX6J1
	 W5AfEjoAAWe2wceIUq2/qCVU0NzrFXSA6e64QBZYPtAiH3J451LxEamL1zhYADTCHLX9Y
	 k2RLf6dAK9eM8Xwj5UhnUwt63RBbGg4sTdIxj6WrIUwRmH7fWjfLeJqtJEQa4oGT+hbFQ
	 +ouin1TIhX2mtoxQZA7b5z2L3kIr8x85fluxspRKykXOlXcdp9Tk9KMKxHCF0qpVtntrA
	 k++tXf3++juXpNNfaXGaCnTzj82B0ei/zpcFmStuyVku0djCpgsdrrWJCtr/kvDMY1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792620912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BgmXdV7ETtGQ6mzqB4/G4P/2167nhL/8lZap1+X5wz4=;
	b=QQFRKI5eY6K5IV4rZ1+Aju3Wegn7ckLO/P31tP3HlSl5NXLPZnTxNb/8Oa22hTdqcW7g
	 m115umPy6MqqEE6HJSrOT6PA7CXu6zVjXnZ1Q6XTHLQHThRkVVdj2HmtjadOp2xnV3Cg5
	 0QuDKrxG0Tr+H5Y4fF6wF6Ktc4jeKtR+o91tTmSbrDX3dMUGxCrCJDQOlFpFK099yO9W1
	 I7chuE1VZe8Z0prD8tSXxtMymsnqz1MHw/ymMCAmRD/pCeOD3PlU6+P/4qFDHQ0FqwbQk
	 BQFoTnPSCOv2aSfZHpeEcV4bazjTROk2CLN90hdz+ID1pNnjmA0pwwMFbDJIR7KfvDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792620912;
	bh=BgmXdV7ETtGQ6mzqB4/G4P/2167nhL/8lZap1+X5wz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYc2Blv694/7RrXwe76HqM5HRzJow/FRVU4V00vM4K1aUV2V7Wty8J3z1LV0cKLVT
	 +R1jTF+eY2Or89QL/wryyp7zxbC47Ac4FytbIm5RLVKXfpnkz9WoZYVsPytDabLgtQ
	 nhih4rn6FNBsVlneHs76jyjkyk/F4uYROWmh1RY+ElQkz6wjhDxfMRw9ECA8RrS0nJ
	 0fDMxP0xvTC0KqyarcJHCHVaXroEqi3gkPdkMCijdxyD255SCOucApWD6wZrmPPKM7
	 sH79M+EQFRnMDDrnVEWogd3B20fq/sdcbp4KVSS+9LdzZeDS0j+g/Hzl8GEUkbKkjb
	 TjPvECi+gxy1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C7E360B6F;
	Wed, 21 Oct 2026 22:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D02C41AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1E9440050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVQ_qabIL0xu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1384540042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620905;
 b=IsoC/hPb6wrkmCcqKy4n+p5V8eJgCqfNcUEfrhbcY4/o3DCDH02NNO+Sx0HommKb+/4S
 vxzNA8h/ZFhpU2OkYxb9rDLcYjTg/fiz0XEuJiR1IzyrWfqYjQ0XcuHXE/IFVRllCfBaL
 +FhMJO+/TcxCuWEsP9EODm07A8COqrKyjcCmWRNRKENn6ze++Jt3ECXM6LCH7mBpEbVdP
 QE3X/XHGaDP+LF192nZ+tcf3Bt5w20uv7mA+/k7X+SjlCtqQ46LRxG+x3dQsq9hB+egFM
 3py4BV2w7Qq9QVpKEDS+ZFBSXPbwsR2AjsQhyOeygtzSY8xmxhabCVe6wevKx+lgjzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620905;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=BgmXdV7ETtGQ6mzqB4/G4P/2167nhL/8lZap1+X5wz4=;
 b=scvsI0UWPx2e8+VjP58mLLbCmf372U+SuNeuoa6v20oetQaY+8iiulu9Hcb6KuvGfhlQ
 1ED3q9evMbNgerjOP8NRjISneoUuZtKyrSZEfWTqggSB4zO9az658OfcnDnfObVxSqtcq
 UEpSD4wxBAdWWsPwGDHxaUGTIiGTBpR73LaUOuenwWtX0lPSXfMSHUDkcPM1ipxZgmwZk
 EBXq/RtwuRu3C0iKNZJh/xFPLgh7GvtbCeMDPR185MkHTwqn4IDvhY+kp1D0h02BiF90m
 YFSqV5GS3KnYLD50ieH0V21hMqGk/isUhu8Ipoh4rbDygcPwl0wKc5Ua1D7TFj/B75Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Cgc4t3H1; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Cgc4t3H1
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1384540042
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:04 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-48ed0b68895so785929fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620904; x=1793225704;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BgmXdV7ETtGQ6mzqB4/G4P/2167nhL/8lZap1+X5wz4=;
 b=Cgc4t3H1RxJbZ17jEOrRA+HiL5qtDstaSV23uuSoFQTnBMhgZHlZIHvh+/HhZhch+o
 Lbo5bLFzboarkvNOv79fAmmNYnL4fNL2zR4IJ0AQsb6YKHbesXtbO5puYws2YpAXV5xt
 V5lJ2d/m+kL4RIEuHOioMw1eI2kUlsuKdpoBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620904; x=1793225704;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BgmXdV7ETtGQ6mzqB4/G4P/2167nhL/8lZap1+X5wz4=;
 b=rVPozlQqwTKRUoOKc6xNqxqrFnIxv5b+hbxrIS9kDsu7YlRCwscMbba68nqjDz2yZB
 rY2rLuX7iRsRdD72kzX2cxxs5WA4/bsBEKyvFXxG2r80W7a86OBz9bWlktklGgdXXoef
 BBesYksOd3K4P48FY//tjsPbuGZf7wYp4dTkJjdE81k/FG1BKta+4g4GZKXDp7zQkamx
 HQXtJi+mIIE5m+wP4eu5Ob6/7KECwYXny8P0WJ2VgNAIZMmhBYSnLmFuAOQFdTbeAQGJ
 1wkewS5rVcoluhUTn3X0738y/JtDClFhvbusC8Urx8gQ345wMzAzSWeyR6a7y28tYPVW
 yMGA==
X-Gm-Message-State: AFq9FYJjHIbED0xkWnmfjqujXkJXy5y5TR53/D8tZzPizzpTGL3l285K
 CBD9ijjIZpxkrVrWNJnbuaEtRBk/m+rOSZX5EkQcujeSULXb96GuLXWuTc7Advi1FZ4=
X-Gm-Gg: AYBFou31g7fwHN359L918e9Mupclbyq5fEj700MKsQj40lzxT33tBwFtUJdj9fBbOsq
 pzTa6bq0kQIOgzbXmlVfKrb22RyXaggu6qhIyGxMHfrYd4KBZp201F6TkaR1DNcWghfst9J8xjj
 05mR1EFatIaoeOe2yLq1j65H584A2TkvJNai847PZZ5Fz04sbJMUdFr1jrtYG6mO1xPYT9+wxOo
 /gL/Tssp+ZP/P8LVnPZZjlL0B6d7c3X3uUhj6vS6oXk+HTR3a34LM0n8jVX7G+bVaHoTMwEj/tY
 Vph5thlQLqbG87xUSeSURrVVdSVc/XSXZsJUiAIm77vmpzJSQmGfkOD7v1LH4ExWsN0w4yjTgUL
 r+kiofguHwuO6GdTynA7OQe15F3BHvPgfj69aLzhvn8wtTMQyzTCgt79BBLW/I5aIR1c2s/gjvs
 HfVB8j/idRc7wNqCtEwB3TvujbVi+FvP/OJ0I3Uti5qG/i9No4CxWgU5G+15d+ZHrG3zGhBvNst
 Ui2DEiTkA644IYqjhenBWPNgzVK2XRj3r5Q7LeZF4Ka19/zYTl/VAmndswGedt2Ba0Cxvo+wVdi
 C3Y/E+AbOjDl2NE5IoA+p3VYJ+HwckXYMcdGsXRggY/UEfUfCIiqh4u3F/eBkp3+rjVDEbtdn6Z
 S3MtAMP2FyPNZhqIlBmjy
X-Received: by 2002:a05:6870:2e08:b0:494:8220:8349 with SMTP id
 586e51a60fabf-4a7dc1d4cdcmr2610129fac.26.1792620903616; 
 Wed, 21 Oct 2026 15:15:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5ebc240sm2956084fac.2.2026.10.21.15.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:15:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Thomas Perrot <thomas.perrot@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20261014-tprrt-mtest-empty-range-v1-1-c694d73e0556@bootlin.com>
References: <20261014-tprrt-mtest-empty-range-v1-1-c694d73e0556@bootlin.com>
Subject: Re: [PATCH] cmd: mem: refuse mtest when end equals start
Message-Id: <179262090241.3382776.14602208953291651621.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 16:15:02 -0600
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

On Wed, 14 Oct 2026 09:54:17 +0200, Thomas Perrot wrote:

> do_mem_mtest() rejects a range where end is before start, but not one
> where they are equal. An equal start and end passes through to
> mem_test_alt(), where num_words = (end - start) / sizeof(ulong)
> comes out to 0, leaving the function to operate on a range it was
> never meant to handle rather than on the empty one actually
> requested.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: mem: refuse mtest when end equals start
      commit: 56b222b13af16d0a92463b6695f3b833b5299453
-- 
Tom


