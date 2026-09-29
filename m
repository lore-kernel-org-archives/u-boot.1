Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CE3CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46CCD80F2F;
	Tue, 29 Sep 2026 15:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quZQ0n62kVRR; Tue, 29 Sep 2026 15:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5B84F80F1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790697579;
	b=SZc4P9bvsHR1DKHsjOGRvJlSO81qrImBohLhR57C8018+lOEymE3+CFldob/xqfzNq35
	 sIhkg14ds5DM/CZdVWZq8MNB8U/k72MBovXFd9MBSNzO4D1AGPBc065ZoR30Kds/sh6jY
	 KAIxj7dWChczZAcpf+4IlUh4zRBlUdnVmP46Fz8jcrP4eCysdb5Z5mBOOihkX4Gj/r46x
	 X12YZu56kbI5HJY7Z/5S/rj4V5PKUnhnSanz6qfpcg2o5A/5ptOtJlQsy+hdrqfbrH/Pk
	 hwmfx1HPN8WZTPfYzQgMn4W3KaD0NMb02YHFKkHsvqqlm+0rPq3iRKblW2RRBTIV3mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790697579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mlqid0zLNvlXRc/WsiSlknzhT62fNFu+bWxb2Zims9c=;
	b=IjI6Z/VCjQfj6PFAa5TGnAiOikzoH7tuDbf+ySMk0M1XEhhXmWq0nCpV9PrPv4D3DNUH
	 HwOOGDhEKYDluDur6eEUfALZ1TBQmTSIFR6HONjNU2Oo7UM64KUziiJ7QBkCqDVa+HfaC
	 MXV5sKw7B1Z0+RJ8oCcSea5mXk/4FbF0oL7YkZX3iccS+/8P+bRvsmJKuhj9dEsA5W6Db
	 fCYibLkiD7r6jKW2BqPO1IYU6shgEwN7jFRUiFOvqHCUZBzciV8QqoJ4tg1EvQRS9ENKH
	 kK0dHiFCBP0JkDho+z+izEg9KIlI+9HvObobT77D8CTPC94FrHGQBDhOD9lY7jyxv/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790697579;
	bh=mlqid0zLNvlXRc/WsiSlknzhT62fNFu+bWxb2Zims9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eg28Hhf0nO/hGWEWIil4BUNqQ9V5re3m++9STE3pJKYdXnU1kZOspvXS0bzUt00kD
	 5SeqmuHMbEzWcQdt8w2T/MEU9bHobQUSPwx7FiPXlsqICphUtvn2Dz/8Zp/VVsY0cH
	 /Sy8SoPj+NQZNeWLSJi9TGYkv26XqBaGoeJYGAnQ8Cw38ur0lEAlu3xGyLnbBlPsie
	 6nCUw8/a74Rhi0W5mhJk5EDAvJVTxzHCTyrk0CyuOkCaW/mtR6Gh01Ud+x8GLUVHAe
	 mtQhplcfNpuQ9M9cCDuEqYqsjRIxix1z+L/hzIW7+Q0xxQMy+Zr34o8rEIqLTmd80M
	 SQVkaBqcAeehw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B84F80F1B;
	Tue, 29 Sep 2026 15:59:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 928E3335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83B1640792
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-WJQOPS1saz for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A5E9540791
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790697576;
 b=Dh1K5nLlUTpvgOOa9bajaFqXs2BsaufylZ+QlmQRfmDdIF/B1VNY33qf1jUNy9G2Tsjx
 4tOCsQNI6eww5td/DvCb9ShbJkq8lnz3uXMjGjw2W9sMODxLrVcNT1oYQCuBFfP8xX/3r
 f970CrJAw/kvy47Jow780B3g7QN8QXKC2NU9C4d1mkKoxNKsfh61gWbv+v1m/+lh9UlDK
 +ZS+1h6gqqnINfg7k5lMywJJtC6YH4cgGc01e+EYlFCLBXLe6piYZIssmECi/NILXYp9V
 9bfg5o9+wIW22XvL7reRLicJs1jCumH4p/1f4A+GNFQyCvsFkY9Zg14wwwPSBBOqfBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790697576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=mlqid0zLNvlXRc/WsiSlknzhT62fNFu+bWxb2Zims9c=;
 b=F6JMYDn0lpgUncA9ubpuwuj78FN8X1RMbENF4XjtDjhA1qpObKv6tGUMQpGdOsd0n5pU
 YWTTVXvasRykIC74dEP0sLQ05YAPBPL8z7PIO9AQ+IsWYYxzSIwE3Z02H9peiPthhAHsx
 1WcjD+qBkIWQbeyuSruxVz7TKdPZbGFN0nt9EOT1dMAe2QRYh277xx4T1DLVMuNyfKMKD
 PojP7ohuBd3zFWaWsUk/CAUmHtNYmIcCGObxU1cTcHrw6FXxyHIDfHBbK4RN7DTdw85JW
 4aHrkKyeS8tXLDq+P+eu2bvjxktM1vUGU0sOB5ks132dHd/vMOe7svbqwBZ9PkovFXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=It+k7eK8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=It+k7eK8
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5E9540791
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:35 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-6d7ad305c8cso318829eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790697575; x=1791302375;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mlqid0zLNvlXRc/WsiSlknzhT62fNFu+bWxb2Zims9c=;
 b=It+k7eK8hagTyPdV2K+cvchihBcmlBa2WuVfrM4/0MLIkLzZA+S5FqogC1uhb5zYRU
 fcoh76PtLWIxW9dUvx3sGVoqV042Hq/63vnStX5kg3tl7uWaRIPkcDLJD17nkWUGK9oB
 ss/62EDNLGD5vhmjNZOKuZMdJltK+H4xbFtVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697575; x=1791302375;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mlqid0zLNvlXRc/WsiSlknzhT62fNFu+bWxb2Zims9c=;
 b=wyN56g7RcYD+NCGf3JnKrohmMB7FeZ2jb73P2q2IzBZ3G+PC+v3FdIgjc3+J1k5kUJ
 uAZlz2h65V+0BIT1LDxIAR5lOac6MF1fWZuZnB/3aMdGojBgnyRdKkfEEAsx0c4FRvGT
 1c22DToDKVD9yROQDwLyHyPxHc+3rUSfgEiWietS3XQtQ0TcVrTm3kKoQ0MJFNc0gABd
 pf+Lb7IPJ2g1AGOCAS8d7fHRdC2PVUFgeBeCLqwssrUHsOxPH7MV0MSoytKaT36v9MS5
 /87wYnmWuGkGN0Inb3wQ0ghFv22JaOOTAc1OjZ9a8VnRnwxhuDW6R8j0YKcidZ626b/I
 Bctw==
X-Gm-Message-State: AFuF++mXI+b64iTvpf/EmTdwK1RM6I0zYV5fPj8NqwMv3BB2zXW+NnNt
 bNAL1ebxI39/jpHsj3bj7UWrRb4hDbuiPRy96ZhJ4xv+ED/KuZaFtB+hDZQ/locmOPfI2AyGfqG
 B8Wt99QLS2jz3SYM=
X-Gm-Gg: AYBFou1rnlw15BXa1RYKtzC64PHw9oJLxxJTxUOc6ZGJ+bdtJnaLGp219WvL3KqbxTT
 GoiA5Vp/bQ+eu0mTAnlUKqawJmwl2sGpXOwnXK/IpEyGXZeICAJYgmM7WRTkYIc13k5A+chS6x2
 A9Ulk0LEjUlfcYj2xTc6KbJGrAzXhKJqTftKKmZiErKbsY4GF37VtOgk0YqXssiIIUpeBN0Kq1a
 3BpPRwqgboA+Dh0wU0Dlkh7jYytIDV9DD4sNJ7PtUTA83jjhwns8ZixvbDJ31hklyLT+hBh/8/S
 Ya8Qi3owJhedKnFRxra9a2qnZ6aeDYQshbKni5PBmLupSj3N7uDlo3r7ahAuc7SIxgXu3xHHHLq
 0BCxq9o4W6vfmWHoqPAYCAhZdCEVVRO3mj4MOL11bbd4LBLfViW8Bb7vJAulncsAHpdY2mzFw0s
 xu4ifKShe2rhhIGv6N9ONgq2uMf6YDpEfNXzXIXB86imKpEFsdYWIeQGzJ7uqhzt/ru8lStLIyo
 siEK1lmWygJtYo56xnhNhtO4K1OWlHtNbeg+eNFLa+dkCQ3xnhEmYG7LkMwC17xXHC2CCXyHcyc
 AGx0CSMGzuEr6gUQ+/ybJFd58oQX
X-Received: by 2002:a05:6820:1787:b0:6d8:c658:5f66 with SMTP id
 006d021491bc7-6d8c658611bmr6088003eaf.27.1790697574740; 
 Tue, 29 Sep 2026 08:59:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dc4483b07asm225971eaf.3.2026.09.29.08.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:59:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>
In-Reply-To: <xhkdbqzicqhrj.fsf@mkorpers-koolstof.csb>
References: <xhkdbqzicqhrj.fsf@mkorpers-koolstof.csb>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260929 into main
Message-Id: <179069757383.148043.17278768672501836541.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 09:59:33 -0600
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

On Tue, 29 Sep 2026 16:00:48 +0200, Mattijs Korpershoek wrote:

> Here is a PR for main with 2 very small fixes:
> 
> Usb Gadget:
> * usb: gadget: f_mass_storage: Synchronously tear interface down
> * usb: gadget: rockusb: terminate full-speed descriptors
> 
> CI:
> * https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1398
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


