Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7CCA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD2B660B20;
	Wed, 30 Sep 2026 17:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLz4FqN7cIBh; Wed, 30 Sep 2026 17:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0171660B5A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788659;
	b=SeK9+r2AimOJEQKOGLl1S9xks8QbkiukEpZ6PqvEKdmzIEdnKixbbmEYvJ7f2EOGzSip
	 CfZi86pOyrq5tVvfMpgXTqWdnja2/rRuV+9GvvTr0OqJD8GfqIhRm09R0Cnc25xKpIZXH
	 gaj/S6O3LhN+2NXrI2HWkHD8UW0jve+w1Wv9ok3zw2s6MVtPlQRhe7J9OkDssx9yJjB+w
	 iI6hK1GlWlMWSK1XjYCMi+6YGzUxt00xbDJbYp+2Sx2rBsBJPavKFtj+sGaiBGSzU1Z5K
	 B36joUF/g3v7jW0oSj7WibTonSxJojy3d5bloJJL1bHJHLbbM5y2APBsFmKH6BMKgDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wB7DwzXyM9WflfQAshnma9AdO3R9cm7754iRsUNOxQo=;
	b=ocFh9Yjpe0GL/zElJzHy1d7byMWZw1maRDM3yt+3yvCMvaZ4+rnBhIaYOHyKMACPh7Gd
	 bkr94tqLSxXz8eS0ye5eQ12s0tB2h5eXw4CVgxEfSTINCcxWd09q80yVW9ADttEQ3OJ2u
	 a5IpHl6k91z8aamgFLzDJyuC7Na6mX1iBRzfMKL5wBqFT/7pIsu60RO95rm9KlqnXLPrf
	 tkP59hXDzMczf7hQhf/4J+AznDf6kuNTsP/siqWfeGP5A2sL/fJvmnlFcaey0pVwjHOEX
	 o3kTZosuvhrfz1uHQ3lIwvicapKkVmhy7hZbq5JS5IH2SmZyJ6+7/2DMQHJKu5Bp64A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788659;
	bh=wB7DwzXyM9WflfQAshnma9AdO3R9cm7754iRsUNOxQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUOvSEZEumiWz5i6XhoU9bOBJqh8Q+Yz4n/jSwEoaQ+rOVFyrNKrYkH5XKyb86anw
	 lrEBUrDkOAYPRwIu0cqcKz7nlIW8uypsyfimHkQ81ga1hgE8LuF/50mpP62GSjJ7OF
	 YZNfc3fvBdKcJiB4pFoojMSBtgOMOAx1vEH/hAP5bS816/8jNBdAGrl+EqzcIj9x+p
	 CADRbS2AMsofbVdxKbZ+oDWKW9YSoekeO5iFMmSWuL9iUyz/Kh23GIXM/akX5sY7sU
	 5xuTfIzcS6n9tNm9zH9m0FMTnbAUcpqibpVzWIO40y/svsmdP+L4x7N46Uqn/RQF88
	 2fyqBMynsP/6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0171660B5A;
	Wed, 30 Sep 2026 17:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BFC824E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4239040A22
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mv3_AoW9ka9H for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 14C944086E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788652;
 b=KkZbxM7AsZeMcrUNxAI++hSujXzbw7spcGYjfwWXcb0ZEr23wIwlz7gEpepGcyMMlbbQ
 dgF6Q6pzgn3Og4w5FSZHki7CF/bCoSTH6jYDfYeRvNNTu5tmeuWVq3MR+O30n5Tn3a6pU
 qVm/M7eMAzP4++/TvMjAldtVNA1lB0hEyAfk3MhryGP18Tsvspd5mW/ZC+5O8Z66ZXk2V
 udDQ2Nb9SAfcEz6uKj6qtBfRi5yDG/7HVX93PDMaqNDW0fWnR7Kd7wFXjo/Fvlq2mGBwi
 hiAbVUy5hD5VaJqB4SoYFt72UKyuZsyVdK6B5rxcqztsJkaVYShnN5z54P4FYZyAWBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=wB7DwzXyM9WflfQAshnma9AdO3R9cm7754iRsUNOxQo=;
 b=WwOCGlXpb7Yzb2E/ugPKz+i3g7fPipXWtZyNazmYjIW2aLTvZk4UWVVtj77EjVNax/Mo
 u1fZQQYZkODBx70ug5rp06NWxDdL8eg14qcWRgX1Zb6GfaiVWMGUeKWpAJkfMzTL4uVQi
 7+ioNrEw31xY+j9Ig5Gs9nWxcPFnDNRpbSagnWCVJPSjNUIsAQTT4P2tHr1KHoNCaHO9s
 aFr2NkoVTJK6Rbi5X61S8sYhOaQUwLNw0HQ4cyPJ9F3YHQYP76J6cgIOXIBiISakknQqj
 mNAbgnpkkTW5TY7c2JG3RxfFso1jzoamEN+iuFBrHA2nJK3ehHhvZ2aaMLvRkaQeTPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HD5N6Q8C; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HD5N6Q8C
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14C944086E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:31 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6d8d3336db0so1250186eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788650; x=1791393450;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wB7DwzXyM9WflfQAshnma9AdO3R9cm7754iRsUNOxQo=;
 b=HD5N6Q8CLaaNUqu0BlfJf2bR/yULE4mAYty2IUmC9udTN1UODrTwDnQp9y+ntXy4er
 CLSKqRqXnIN/qxWjhgJSA2gy04O9ZV6j5B/3qc6/bO05W+FOa95Q/swXjg9/6+YTo3R/
 bEJQb87R4HYoMRMSIXqk6xwQn0pns8pB3ROzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788650; x=1791393450;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wB7DwzXyM9WflfQAshnma9AdO3R9cm7754iRsUNOxQo=;
 b=PvXte/2hux9kARNiQgMoNiclIe3bkMrp94BXOfVWISRdv/sYbUVu+oCRyunIIT44Gw
 aUAhcvP/ClD3Rtfck7k4BlCejKDZ3hQk889o8xU+iSidXJhVUciVb1VjU4V0vKBP9Cux
 MDPjJNshZ3w9q+PwWQRHOYi/7GLQXEUUEzK/UBYdBQtJaw2iXmJeAvBtzmOG+d9qwJTr
 iiNKnNfXZ6QHBeRP92zBS+5QwuskFcKKeZsQs9Z+5zwpqiDj6oUB0LW7kf3l7TtAYaXo
 teb/3PvbNwQdh6oQuFqdUbqotXi3VkY2iE2cCRj5tzUC269+pw69urYoqPEy63UNP+ex
 WVEQ==
X-Gm-Message-State: AFuF++keGmEgmBZqqgYoO+LP930nOxTVxyiNXzJWmnfD/k6peH8FZqMN
 LAs/XfuLECc+JPOtMytAUWMs7bb+1s6hxPk0IYWnhtqJoBPgcbELgWNLv4AeI2aDrSM=
X-Gm-Gg: AYBFou0WCM0WudcOmrcpEy5RD1MpFrdRC5Yw2J8ZR8boaEgm2EoMYXIHmuAgDnVHk1L
 2bPm0kRr01sMCFo9krKiv7a6/LtG3ZUn78pxZFiM/Y0aE67/I23KTaczUre6PrU32eitPynsjJI
 /u1kzrEKXQiyf0nsDsnC2pQTtzqfVNqmObZMN2buhzsGoQ8XA0h9vrRw6/EFp7Vwo+L9jaEtqcz
 7wrE9LuUzTHq1c/yxK7hUSVSF8DnBBM49Vdrs7YDtNlzOCjAjiqFK+pE5Y6EiZTS1b7zB3Uo1DX
 shARpm47RFq207lr24sY1Vo/dhz2I9i3hxBw6F1c3AWUA2mU9wEGfuNGjYjVdvdvIerpZAJBGBr
 DOPXpgkMsYslN3yLUDWrNLgFJY8BFJxxAo3Lxh7kcwBJuvEcJgW4doYbPjhkKd3IeqHLcc9CbQJ
 v47C++FfUZ+Z0jtRgnATeqP14yb/s/ZVOfSA6sUB+Nc1SBU23VhytQBff0m303/WG2NdWTclOSs
 AQ+/+zv+jeWA3RqnogAY38ZFcFxuNtNUU2StFSlmr7rIHQjOMWrEEv3q+eOE0m9buuDj/GxPQaY
 WJvgrytMFEOBYToEsw==
X-Received: by 2002:a4a:ee10:0:b0:6d8:ac5f:88af with SMTP id
 006d021491bc7-6dcf5152c6dmr1915057eaf.33.1790788650538; 
 Wed, 30 Sep 2026 10:17:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20260913155205.84071-1-aford173@gmail.com>
References: <20260913155205.84071-1-aford173@gmail.com>
Subject: Re: [PATCH] board: logicpd: Remove OMAP3 SOM support
Message-Id: <179078864980.467656.5213439130634112850.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:29 -0600
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

On Sun, 13 Sep 2026 10:52:05 -0500, Adam Ford wrote:

> Remove the Logic PD OMAP35xx/DM37xx SOM-LV and Torpedo board support
> along with its defconfigs, config header, U-Boot device tree overlays,
> Kconfig target and the board specific MMC PBIAS quirk.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: logicpd: Remove OMAP3 SOM support
      commit: 036a1201cf5580ed8a42ba26884cf432bf92e3e3
-- 
Tom


