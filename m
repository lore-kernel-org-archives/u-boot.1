Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CE8CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 01:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A9E2408A5;
	Sun, 18 Oct 2026 01:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppvyPEWr-hsH; Sun, 18 Oct 2026 01:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F1154092A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792285534;
	b=EbelKyRBOwPPvz2ayIx8j9m3zDcaYZLWyUPmkkvm2jS0pQadsnbA0gFGGNzY2rHbljG5
	 8ZlwliKhBMjcABScw/f0z9IkwkmPffI9exCSX/jzru0dehmQl2t4ysnxjgBPATGNqj9Pe
	 CHdPTDCN+5CR0NFg0PK8ywQS0dYS2jT4v+U5HztMFCL8WeSjFghcSIztl781FA4SfyITJ
	 Gy8IcBFZcmi54MkENBf5P2ofMVIhD3X1ZzorKKgjvosRdgyHJyt2IbsMSeTHNOFRCkvBp
	 Dg0BDZvRcqlq0QOx9rUkjhOfQbRY141a55ocvHTcwo+fvxFg75Fa6rI+kdSb8/il/IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792285534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/UFotpQ74fAFxA7qc6BfbathGhP5A/7aI/mjnWmtpu8=;
	b=SNIewvUuRWZ8XsfQl65NOH9yxpw6sP234fxCgb7D6/8uNZFzxTUte7U2PIN+S0K036bD
	 DzYQ/ZOFWPkK+8CD5aVGQswicQI5fg3/UiBWS2Vt+BmT7ncmb4vElvzL60lwSMs9GrmpC
	 FHyMx5ouE1MSPrRMe5lBH6baOBtdSvyiIzSPRk2NktrQPOogKld6LPfE32fxh0MB7HYZ8
	 wzH0OEJJ0KxPbb4ZCodC2GDeDxLns8Up1itQUB+y6kBuwKRnmSllPnmsi0yHUIGuaz8Ns
	 j5sZL8NkCZUyWkG1dmEIrxdoU5NbMcqOJVep+vrcaI/4VSVdLZ9fcOHYgcbyDKzBgVg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792285534;
	bh=/UFotpQ74fAFxA7qc6BfbathGhP5A/7aI/mjnWmtpu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZYIHql5ygbiqbbbryJjPWSfp9QZvwOvvORtjYg7KM7WAKQU5rwGp8gNmiZAdIyazW
	 nlvel04Q8Gtv7T5Gus0C/TVKFbnnjAhrMUS/vx8GXM7NhPt46BvCSY/yGr0eMEENoY
	 +OK1TiG6VKlOq/vPr2hklvRizIW5b6ezvcsHrFPgAMpBDey5zfYh81oYfubhsl+2Ij
	 8fMtkpphf/AK6QkPY1L3Q1fHqWlHNC0kOCNBIXF4zRtsVZDuA/6BtkuCNO6vNtkW/E
	 IVDbqypIIPqxKW0e2zaD7fH7o04HtelsrqHv/EN86ZbARAYJT3qb0/AmcyQGsc81XW
	 5TO3uRLUMJkuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F1154092A;
	Sun, 18 Oct 2026 01:05:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D1A5977
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4210D60672
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCyRWThVai2x for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 01:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71F0660641
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792285532;
 b=b9mifPMlsBU0rnyIfWcbtLNHWXu7v667MOFJAl0cYJCkcRHrdcfqzDSL+Igkn+taoa+R
 9QA7IgluNwoNYXH8BVDoKBzHQOBs0YXoWPJdk/yqHnfXmAdCTaSH6oxSt1CDEdw9J8JE3
 pvCLRQFBt+rRTHSVtI7yBOR6hRxGHVHoPfTKHErxJfvncDs+MJvnhvU1ge9xT8+vFN/B1
 QKBaxkijQImKqzuM0dyjSBwiUA7ZJSxAxFQv6eNA7JwCAgkHig+bvPlcIHiP2o8powGaw
 nxRJGpFImGuo0/gz+uhH/bG46HHX0nJ8curviU1UTJhZDbWPkBHq+4neoCmcAkb2ZTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792285532;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/UFotpQ74fAFxA7qc6BfbathGhP5A/7aI/mjnWmtpu8=;
 b=LOMLwyJEW708LMXNogO0/GHgkYdFo6R81p4HAFk1wCedZhlEz81jjHDES31QxbKQYTqK
 1O5RsQVnzm1qhuxi/IZ7/eXD9n8D6yIwefhKdy8qpL3KbMkfc/RyvhdZlO3f4Mk3Fakme
 hqgwYtaCrU2tEz5gc04UXaPVWbejBIHFTAHbPKCvFi+frA+UAMyd+jR+zZO1pVPVQytjx
 eun10sm+6aUPv8uMsRtKqrJQ+Od4Pk/oQV10Y4J5Mo/s2GDm+pIW6JMaEGG2KTeRzAOzv
 bIXn7ENXDhqGljs9GfQvwMnFgFGbzaUYVZpH/nwUN44Uvul2Ah9S2AXTVbixEC0sGFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dEtpd1PM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dEtpd1PM
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71F0660641
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:32 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so949942a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792285532; x=1792890332;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UFotpQ74fAFxA7qc6BfbathGhP5A/7aI/mjnWmtpu8=;
 b=dEtpd1PM3xZTNsj5sfPvu/Od+CdldjSadLK0uGfNsvFGw2UzTzHldxiX9mrbYtD9i7
 7JED/JoeAIfr3bZZcXGgtBY+bo496ugczPVfS6Ci0RTSsc87Mbu3Ukg12GZLTwy2T8zi
 zRUEdGOFngAGrBZonCTn4DXplD7bJPBt0lIaBem0AZLl8PSIn8YQGy6NT5TgB5r7FNSP
 AJ91j+S096PE/xZpNE2roOwPjppixJ7o5Z3ZBaRHQTkoCdrd5aORkK9LBndQpuQOGZ+4
 Yyl4AA29begMto/Vcju0DRC0HmQOiXV0seXrKvy5u/FxXVkNqemwtICl2DGf421jSJxm
 zmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792285532; x=1792890332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/UFotpQ74fAFxA7qc6BfbathGhP5A/7aI/mjnWmtpu8=;
 b=tJk1+0tZSbLuFPs1SQ8fMepbaQ3P4cqkKbiJXOnBqdWbipab32GpdkT1I3x/ZyUmni
 ikA47evWVwlJ1HF74gRmzetWuAlbzjPAJk+W8u4RKMbHRqyR91/ipW8KDWrvE3Ek6vg8
 nVyLJn0w4P9D234Ek4PLd/awUZZzsSiEQHHJkX13OAVdmZdkStGZmpEbNGLr/RckhZSs
 ngLebVenDcdKWzh9pECr/dyhptybyn71tk7hOyxFHwqHaiG6wS9m76ypXoojynEyZtji
 vDzlIaXpk496UkErSYBWzKyflef2WLg9owSx2rGuR2UAfttl+9kX4tThMxgdMFnwhuHO
 QtlA==
X-Gm-Message-State: AFq9FYKcqQGL4v3PPdWp5x/4LBx40Fa3S42T635TAK56bEET9595d0BI
 8XJVLrcV8L8OfaFvSL2CB66UHkip7ll3SfJ8iPD1q8yBDFZPwdu8p5Xh
X-Gm-Gg: AYBFou3GohhV4cuY5mBmPkH+1um0Z9+8gszukUsOF1emW8i+Wkn1PQnyjEM/RsFdS7v
 9QLZC2oncbywkr/mI67l4JQ4oaC5ZJ7N6Pnpw6zaqB3guLeHAU0M58g7cMq7UqJ0L5Pl2O2VJDs
 jRx1fppgOBrAW8coQut3lUyKPpwxhE+jlBF1P51LrWWCm9QvyqA6Zwj9V3Vaah1i86oL4dBAotD
 VWPGc14X77To4ziDuUY3EHJfe/R0zs+gfw7EEzRdkWYy6jW8GeqKu2Uw21D+8aS+tWPfu+qx8d/
 z0I2yo1bClWgmMuNiMgP6UiLJEcmGlR/9VN9rbk5TLImyeyTXLLx2uomK9gy4KTxs85pMbuk3xx
 ldQK4vXuouccfC7WUpS0xUuryNJqi+ihM1gawju2NaMrFNJLhBQFcMD9Utl/DZzSq94wmqkbpcD
 Ki1CFUUhKos4tylBhOK3Isdi7GrScEma6ItuI9jpYqOjAcMFLpzMHPdhl4WkAkoYD/gmHtyOKwm
 v2YXX+YCAeUSESMUhud+WsqzUZ2tLF9pxaU53WX5FgDK85h1jTwnRCNvMg8s6+mObkvinYpBTBt
 Iq3b0YkeL6zO5ibf9IZOICxJAUfC+DZERq6v/3aFD0vJoB3x6xKO2w==
X-Received: by 2002:a17:90b:510a:b0:3ab:1b19:78f4 with SMTP id
 98e67ed59e1d1-3acee279708mr3963039a91.6.1792285531722; 
 Sat, 17 Oct 2026 18:05:31 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc49c263asm9567288a91.17.2026.10.17.18.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 18:05:31 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Date: Sun, 18 Oct 2026 09:05:22 +0800
Message-ID: <20261018010522.1324982-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atPNaYnkwQ_aSEWK@google.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
 <atPI5SKH7ZaiytQ3@google.com> <atPNaYnkwQ_aSEWK@google.com>
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

On Sun, Oct 18, 2026 at 03:32:57AM +0800, Kuan-Wei Chiu wrote:
> On Sun, Oct 18, 2026 at 03:13:46AM +0800, Kuan-Wei Chiu wrote:
> > > +		/*
> > > +		 * Give up on any error: after a timeout the request is still
> > > +		 * on the virtqueue, so a later response could be mismatched.
> > > +		 */
>
> I guess your LLM added this comment while fixing my review comment?
> I don't really see why we need a comment here. Even if we ignore the
> virtqueue timeout mismatch issue, we already abort immediately on any
> other error anyway. It looks like a standard and normal error handling
> to me, so why is it special to need a comment here?

Yes. I used AI tools to assist with this work. I reviewed every line and
tested it on QEMU and sandbox. You're right that this is just normal
error handling, so I'll drop the comment in v4. I'll remove overly long
comments and descriptions in the future.

Thanks for the careful review.
