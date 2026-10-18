Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D82CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 19:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E775605FD;
	Sun, 18 Oct 2026 19:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rSpn6mBkHuN; Sun, 18 Oct 2026 19:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6541760600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792352188;
	b=s+Ip3qYDvWcxny9YzcYVo8W009ODtiKjaDPtWnO9EvJgFaNEg9OKtpRM/IcmFyDwt6Rq
	 +K29YDzCdFvL4to38a+nk+NkB3W1Y5CFjZCR4Omeq4d288dIsPE4Oet54aOxpei63fgq0
	 jwLSfrP/OZ7NT65rbCk4wXCmikJ6bd4k+me7fOTAs3GEwwpfd3u3XFQG6aPlvH/6oLY2e
	 PmaODCgsmJm1qh/wo7yvZ+3Y8YxtGWlUyMJDbAuh/CCcWHxY7rqgHINA3AJ9tVpxGf9w/
	 vm1LjTKpJ2d9BgmX84eEhF3U629ZeHRJbJkhFPwdULbZlA9YW1Vo8sT0ziYnxRRFxuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792352188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cIgBwqExpc3oAQTcUubSHDmFl0djHdXdHgRCQMSq6gU=;
	b=ZVkzG8mKkb2Bm43zt7XKiSkwEsvwnv/Wp/f19BiKZJBLA7y54ibenFcD1KiqekhfGAhv
	 2+RuNEFEvdgdgQzOo1RPzCUOzwFdkhMAd5yC6Hutx17ybx5o030bjwzurwTql6gQ/MjlX
	 oMGkmNWR+qdPiQTXWChCpLtdOaLA2HbGLnZeva/RO7zXKVuAw4MEZNwVyd1Fx2Sgg4WqT
	 bEMJSagYnGUofLPGUBlw/rJLcK1Z7S1688gLuFvWCLxJZBm0FHEwHIdYpU+D3ElP5dFp7
	 da9xKqRh8kbLuEdIyNPraf+sI+YuQXsjmt6YYbR4kwEyx5lSNWQ8E6/CGuS39iWHBcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792352188;
	bh=cIgBwqExpc3oAQTcUubSHDmFl0djHdXdHgRCQMSq6gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G/6FsNyUJR8UX7O2vMNLg6tN7Id+XSwOT2N/6gsMTXcJOX10hoo2eSG+TYorlkz2o
	 rlXrENhfTmBBztaKI/ekvg+8wFKSWAckM5upjEoWgl2P+9eQIki0UVbipEdyEXzBBG
	 N8ERbsOGR6b5U6OAPiZbZboX1QNY3iv6fApXH4AyL9F3RkRF1CZoY5JV1Tduwuj6/k
	 nGnRTnk58Ec5xb4v3zr4hAlzu6Rd8ZS7qxlWk1gHs24ynpjkxZ/Afmyi7glJYMijIX
	 pIrd6CkwjCUbVtWeGzzIrBExoz0WpUwy67mI48ZuR4G1R3aMrl7yIKs9Q+18HLhvdA
	 nt8QUK3mojMyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6541760600;
	Sun, 18 Oct 2026 19:36:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D25A6769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B94B980F51
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uD4f6YSZ-R2E for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 19:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D00EB80E47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792352186;
 b=dsUPMzMti8xevF0aJdSagnEF/Tye20MKi371KzIx5YzyAZSjnn/7fpVsN/ZKScNWcrxQ
 aXaAmCPw1TDEqSvzVy7JW4wdfMWRUxBfvFf46T25+adLJmyVOLYoZ8yfUiKF6SCBt2/MD
 98h3WgAIRSrc4MeODDESzwI0b0Gmc4tSjn6vh/favfz4zCQeSo58jpguxehWl86cAPIMQ
 JsgFSn/Cblo+EvHPSMq38JxQpFh1SxgxtR3oNIlLy/7XtiZ3YzJfGZEN+X2hcR86IL81e
 aXSTEFOXCCsy9PssVVEh2ve4fW+UiYH0xTzcVFBjgs+m68AuVd0YYM/6H1kJIqzk7Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792352186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=cIgBwqExpc3oAQTcUubSHDmFl0djHdXdHgRCQMSq6gU=;
 b=We24JyRA93p67XRj5tJvSrvzduqoOgBtKRnkxH/ti0kMsFTVWjnzqhkR+W2SRQY18IWA
 25hnDLlt/upXy1IKeSYUXb5dce1vt4vgABCsecmbFxD0jm6dFv4AzHaHlrHrDJ6KFAMbP
 SV4NcSQYf5uONqIxQPHuCRs6HfGQ4C5ma/k8psTR7sqGkqG3Tvo62nin3uH1LP7LPohT6
 9CV4FtYHxCVwrxHhBwme/TATqTnD/A1my82ePfzxI9JjGnr7fSO/K6Amu6o3XLFzNVdcs
 EFORYCs+2Pzd4TY9i/EZkfjgt4BpDiKn/LRJDI07iK4ihnjwRlqi9Xs8cigS0p4ZCyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XxnbIxiV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XxnbIxiV
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D00EB80E47
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:24 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so15685255e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792352182; x=1792956982;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cIgBwqExpc3oAQTcUubSHDmFl0djHdXdHgRCQMSq6gU=;
 b=XxnbIxiVqSv29+c7D1pKWrrfE21DpAgYyRZwhs9lMyVIUg7WcCyD3zdXJFWQz8eud3
 czE8KHzIfDtzLDF6F+83IHsBJuDepAeYUqYGzB9z0+VFJAnqm48FcChKPkILUxAmG1k/
 PeTVYNbPzO9jnlP7Zc/z1hgNJb7gQutTalTjAmRiTm46vRDVUjQb0yYRnFpaEk6Dyl4/
 m0se7SXNo6YsRGxJ7oM7mUuJDcQcYdwjLq0w7Cp/wTicuxeEthnov8gxZFNeCOsCVrwS
 2Vq5dUiLucG6zratHIPy1HDoY66mroyN8o0A5SlUU6XOgWPXD3/8tSl2JTs4Z07Xe3oV
 XZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792352182; x=1792956982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cIgBwqExpc3oAQTcUubSHDmFl0djHdXdHgRCQMSq6gU=;
 b=IpT4cgZrCVtnJn/T2mZf0+xFpzM1ggSJOWOQ1A9oJx9po8enIb/DqhNXcG5bX/5fG/
 0WowTYRlOyS6bwS+GmZnfmKEko7Blwhs4aIlh2rdwb/DIwWCRohp1XZvB77wGY177UNh
 2V08bgnKhYpLgBT+H4H7yvGwQWg5kYMxsfNIlCzi2Hb8LDqZNqCED+eMy7VnZ6Suizgb
 oXpWkbuQQPdwFOADNk5WqbbjzWeHt1L0KCva3zWufrmOZU8SAAO2P/6q2OQuv4K8nlsO
 b30Z2Sm9s6huZ3lmrqNMX7b73ZJYr9iKJqb0Lmd5wR5wv/8nuTFFpFopR1t6qZ+UScES
 Clew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQzzDK5tru348Kzr3RVRILelifSfDHGYInmRfNhRl65MDXvk2UJfvaRKOcSciriEb2ZfiOasI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL2zzaN9cgpqwxbhpLKwZcB4eEc1SsvwD1Zo9a5nV3WU2tfx3tX
 ZYKr8I710fgrvDI1e0SClr2SYC+F85rqCXRMQS5Q8yzUjtcPLkhnVz9P
X-Gm-Gg: AYBFou1ODvq2HDy5Mq0GGH4trmgEWlkufIeTDLOPd1qKcJuuBr+b4D79YFvDi+afgPM
 OxEDQX1O/uJsNgLpHUXDqnR1XlR6L5WRalfik8EsGh75IsahAmWdP3JBXL0XT5lbFzl5c1GDwPl
 Jm3c3rFw15QnLWomaiVKahBMfGTDfA/aWDkkMny6xf6unzX1BfWCRkq8Pfy5kaWZm5LA19eXwli
 Tp9u7Hmo1rC+DJAw8Zxo5Ilp1gSpv073q0KEhAlyu9/WZojF5CzlUa/4yHqyfbIiZKpawOxaipj
 BroYFo3OxsMuW7JHX0SlcnzR7QFTRLZZi09DJ2+naiGi6sBXIaDU4yg+Gg9qcOEhP9KRLwKH9oD
 Mz+8hKRMANQzEA32IEnIZf4yaxm/hDZaZPkRti5F9Rb2K67esKDCXy4ayMoN60+k5T24xOV+SY3
 zbIWP1jfiTJZk9ePmX7q6RD6RY8vsoEbMcexcX2a41JK5Lx1Aeuw5CFBtDyCJNSm8OPFeAdA4xt
 EGK0ayZNrzVp6s=
X-Received: by 2002:a05:600c:6218:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a1ddaa5803mr99559045e9.15.1792352182023; 
 Sun, 18 Oct 2026 12:36:22 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e2def9ecsm45289795e9.1.2026.10.18.12.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:36:21 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v6 7/8] usb: ehci-vf: take the register bases from the
 device tree
Date: Sun, 18 Oct 2026 21:36:20 +0200
Message-ID: <20261018193620.2896624-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <29edef7b-856d-41fe-b57c-a9b0c2361505@mailbox.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 2026-10-16, Marek Vasut wrote:
> Why did the portnr data type change here ?
>
> Can portnr be negative ?

ofnode_get_alias_seq() writes an int, the same contract as
dev_read_alias_seq(), so the field takes its type. The value is the
usbphy alias number, 0 or 1, never negative: when the lookup fails the
function returns the error before the field is read. I will say so in
the commit message of v7.

Thanks,
Mehmet
