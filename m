Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50EFC982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 10:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C2F80994;
	Tue, 22 Sep 2026 10:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOLxWnC6Q58l; Tue, 22 Sep 2026 10:28:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A127480C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790072903;
	b=J1to1a69eqzhk2nY6cqNaZGzYzkneof0eqKVzyHQso++X6GEPbpqpUtf3Yxl4Qenu5S2
	 luKQTr68gsLxfIaP5KWCTDk8VA5eGTwh9EnIsjqXWdSUXID7l2ApiUQOGygM7d3SKe52d
	 gQsrx3gAgYQF4xw9AgJ9ms3df8Er3tP0Ru6mJjtfI0DTBqczQpOKJwNOES7WkTll7EKtp
	 UVMYLVIacaM7xi5s6Kf5Z0cLf3Gk5+YHns3jxeuM1Ybm13/TGAA12O23Lyd4BsmZiFA2U
	 emBAx5WYtNHzHVXw0DmwsrXdHOQRkBHwSUAtTyZXyX024kQRsjWnjkX4wb7bfNdwLBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790072903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hZlxi44XXmKu97wPPxgP01LdL8DbRrX4kX5k57scnYI=;
	b=smaSaIXfY0o+dsOzvSfVwbTdKcXZSz9D6/JGLUuJky5Nm0SLMP4wrH4rYJkKcZGhbhqU
	 bB0Y/cUoPEiSU/0yeCZ4IVlcRKQwUTMblqiJS0l6O54q739PyfFUV3ZczWT0p4laPLW2K
	 EhGI+gU7xiFGainzVP4bn3dW/X8L++4mOkiidAxAUesU6GFnauGunUfds5u+EjW12xi8D
	 h1RkdpCabanukYXb5/oosKNpCJefARHpsQG+oq+o2VcUeqhydftBdHQhz7m5KXMy4qLDV
	 pEDtEN0iZ6g44JYjeywGSFNa5bdNfA7zMawoRzqxlKCYl0vst+LEdlyy0jncK8lqfhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790072903;
	bh=hZlxi44XXmKu97wPPxgP01LdL8DbRrX4kX5k57scnYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFELcY4WgxWsVbuiKFd5C5XTWCx7Kaa19tk/x1+LUJf6NPuf5/a+rCuUyiX3V7cPX
	 qWazE19skHtDGg6mWG0SA9CfIEYafZi+o+oK7YB3egEg+s/tQWUtc3LSZSAtotEmLP
	 bz7klQmEh7qWlNyZf6EbxmTe1j6607PF0CVjlazsRpONyu2S+l0TV2NpwgmifIP6Fo
	 9Sq/90Z3ow/huvKa6dfY3Md66ny1DrRvznHr8acAyF1yiSvGO8rg6ofZWAFO+qu6HE
	 AOHB0tdgisExucV+QMMezRYDh8q6167nSHODil5FNwJN9rfI4+wL+U4ThtsZO4FFHt
	 BEWwZi/gEEreg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A127480C68;
	Tue, 22 Sep 2026 10:28:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5E74352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 10:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5454606ED
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 10:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRTset9E6ZYk for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 10:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2AB6605FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790072901;
 b=gz5w+meD1lKkSLlId+7Z+SubG+df9Y1iPAYywHyqFcVjgZH/91gw2MfsAzao/qfltu26
 lXywRt8ZhUbgD23yK4+UtoBp5HqLWj4/KcSPobLgd1gSGAPXcceIpt2eQUap8bAgBom0V
 KhN8lqcC8Y9fKRoZa6LXRF7jNU+EYmHysuvDFhU8cMI4JiS+cPdA2AJSOvd1XMpQy/TWL
 gXys4eZ1hhPTT6MRAnooNHjSBsXHL3Kritfthf0TPCFvBtVP5aCR+sDSxgB2Z2K8JylzU
 V7WY6TY+bxxUvMz4jp4BUHnjxNag0WdHscLeFQ1EQ19OJYi5cUf58NC0Yqf7XU3dLYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790072901;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hZlxi44XXmKu97wPPxgP01LdL8DbRrX4kX5k57scnYI=;
 b=NUR2n/JYUnOFyzIiLSbZb0SQEs2LVc+ARxHeTtI+olJ8ewFlNA7+6G5gUESFVSHpkdxn
 WeERcmTkTmUQYDW/NZOBgVzSp1dAcDDCJA0pbrxLyBh4RcibYD8TlJhI/Z33vsNawD8td
 FusQANeirYHwRtnLnYNtaeTtKP0z2/ixaRYqUxFScCfs2vcy98C/Y3w1ofahf7iEa2wKu
 QE5yNMN+5L4T38//z3pzmLfa/qME8ziBrjhS6WZWQDYTO3AF1N61Uz0dYkG4E+Rm6wCZ/
 +d6EfxN8/x4WMggSpH3WaI/0K5F6tkrSXtvucOJt0Jtu6pRdVwKMSW5KQuF1WlK+bgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=B+WJEvw7; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=B+WJEvw7
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2AB6605FA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 10:28:19 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so29676805e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1790072898; x=1790677698; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZlxi44XXmKu97wPPxgP01LdL8DbRrX4kX5k57scnYI=;
 b=B+WJEvw7M8Xk9dFf57e/IAMMs/4MbAW9+W6OA/pWeJUtfmfkTQOQZQKkrT3wkRntuo
 zwHGX4EwqNZBZ9NXSofsyKjUpHndVum2eQi2pIPY7SOJN34ChPTIL8d9wPABicNC6eOt
 8v2qufdaU9GX23Zm/AcAwZq7h0dETJ9XJAgggj0U9+taU6zHtNq2yCpAzxhJYgLr0t+q
 yoVLaH0ROHhpOWWjeel5HGUo9LwDQxSKonkq7OS3W796moujyetFK3fvwQGMumpm7byf
 BR+gtpT7WMSZWA/IboCUFFizaZ4aDiqR6N8YIFacIUV/urQUTqMmUDkslaOU5RDmvsyC
 e9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790072898; x=1790677698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZlxi44XXmKu97wPPxgP01LdL8DbRrX4kX5k57scnYI=;
 b=RuU52j6eSpGReT+tL81JqV/KDh7roXklWpFuStWz9ZJUH940XcvtUAo7nmxMuIwPL9
 MxC9TjnDILmSplGPR4RtX/af5i7ohK1HyJOPufAZ3DYVMuJ/e7eOI9ahgPiMYH0g6j+H
 AubtEHyhepzi01oPKnkXl/aDnz7I6k4wYiQlunkqVczDRHwLbVz9MNmBSt7bnWHeOLAb
 E4c8JIkALlQVs5J0OrLLnHWCzD9nUuofM+EtaK6QkXaEBL20ME8CMrRul+g+qFlf2LJX
 J7KITkH8tFzG8lWMkmvtHM0qTJljJ+q15kx4Y2EPhRahrmlq58d7UwzhieLh2DVCjDOe
 5Eow==
X-Forwarded-Encrypted: i=1;
 AKwUvBza3bKIE+y8ebhqgVdy48M9w0QiDmCW5rWP4yTZ3bPV66EuIwVfWRlAVYWaP+cyIf6rUuZvT00=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kDkjZJX/nEBnr9SElNhCmfmB2ZuRvoVfCAiutF73i94206e/G1
 vfBOYq65dyeWJZx3BYBIqA0b5pBu5GAnntbTfilIeTvvaEu0/K3fLSWiSxa9I5CmDpE=
X-Gm-Gg: AYBFou3A6f8xXBF5PzlOfwbTj3CifKIJIIioBEu2jvmqWH72TlNN1ngnLpq/mEaf5KP
 qT2NmN3qC+8xRlFirHCGH/vr6C8S1TE+4Aal5hz9QCPz2koQYJx49pm887H6QBBFfPJC6lwRDkg
 5426+Fk9NO/QpL0Ht6iLJZ0puwPzZA6mbA0YHeUwG+z4bIwoAZC8nmIKNvPXhGlSTlNAJ20PMV0
 +fp8bPyp7bHThcqBjkng5Xb7+gv9RndpaddYoR/V1SXTwJrV5+uy7vPgIZfgt4U1JBPZ9Y0gxcn
 ZGuGgWVAdiWBSyYDy0zCbf3619swaziaJWvkxtLGXwED7EQZETU/FBNV4cE+s+gwiZPmDJ5lM6u
 Br3mqTa18Y/7QLWv4Mr9+iYRV0n+UK4EiFEn5NFLbxoUQXCxNgtQjMXm9Kh9UdTOyYI/jONZEWi
 KBuAU54g7ZhZReaRdAXSDpV4nsN6AwfXRdwXaVh5snICTg1YdTnw==
X-Received: by 2002:a05:600d:6409:20b0:49f:cbad:eef7 with SMTP id
 5b1f17b1804b1-49fcbadef22mr113510705e9.33.1790072897815; 
 Tue, 22 Sep 2026 03:28:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad53b53sm38526235e9.14.2026.09.22.03.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 03:28:17 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Tom Rini <trini@konsulko.com>
Cc: Aleksei Sviridkin <f@lex.la>, u-boot@lists.u-boot-project.org,
 Weijie Gao <weijie.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image
 header
Date: Tue, 22 Sep 2026 13:28:12 +0300
Message-ID: <20260922102812.3981001-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921202152.GB858934@bill-the-cat>
References: <20260920151512.401899-1-f@lex.la>
 <20260921155055.GZ858934@bill-the-cat> <20260921191406.3028860-1-f@lex.la>
 <20260921202152.GB858934@bill-the-cat>
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

On Mon, Sep 21, 2026 at 02:21:52PM -0600, Tom Rini wrote:
> It's unclear to me, so it might be unclear to others, what the use case
> you're trying to solve here. These symbols are used for (typically) when
> we have some prior stage loader that assumes it's booting the linux
> kernel and we need to fake this enough to get loaded ourselves, instead.

That is the case, yes. The board is a consumer router whose stock
bootloader only ever starts an arm64 kernel image, so U-Boot carries the
header and gets chainloaded as that image.

The offset is not zero here. TEXT_BASE is 0x41e00000 and the offset base
is 0x41d80000, so text_offset comes out 0x80000, which is where the stock
loader expects the image.

2/2 only adds the default the other machs already have. In arch/arm/Kconfig
the symbol is a hex with no default, so a MediaTek board that selects the
header does not build until it supplies a value. mmp, rockchip and apple
each carry default TEXT_BASE.
