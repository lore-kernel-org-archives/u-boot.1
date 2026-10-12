Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA589CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76CEF80ADC;
	Tue, 13 Oct 2026 01:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JnAEl1sFWPgY; Tue, 13 Oct 2026 01:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C20EF80B97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791853547;
	b=gRhxXr49wVrCbSZP28Z8WsIZ9KgENU3dXwUMy0ZFXFYxjszqLJD6sCCTYKR9MtbpkTui
	 2UGCsD5n3UzfrIdvvJs9YST7YDVLrUfahP8Vtwqz7zYpTnKNuEGPEHhTBA9xqMR4llCJ6
	 x/IsHlp0BZ3Y1Hp6taazzjElsmIlyMk+VnN3Xo1BCt0ys2HGUOIt9HdLMOf/Z+LkZKxhJ
	 83XiqNW98Ws6RVWvnA2QBeUsayb9z07rFcGxt19WdNqyvpkUPgzN2eflnjnDFPsYoEmJT
	 LmTMUuU82PhbEN9h/0gJes6QQ5ZaFguou26I6+Z5PeM/XY4smX/cjAM6r2OsGC/1gww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791853547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=giTw56f1ENYO3apMfHjHODTcAEVofVpBUy5+EspUoYs=;
	b=hZJDMGRrCrqDiK9tVij70f1n+tXJxvW0pKr0NlLUfFj3Gtbuv7X4ojJnyhBiGIoB35rn
	 pk8pc6UyRYwOc8y4ryb2icavQsp+mdT9CSiF8LdnHTj0fCP8FLMzTnJhoYgvCibynY3ZJ
	 mWm7P8M36nMjzUmF3IaeuWZTipcmMgymqTuvWHzyTQ127dcXCSlAgyN6CCdNhi4J+pmZm
	 mkjiH1r93ys079LDXeYXJWxwnYbJ4QC2Nhus+ISTFDSbykmKl4E8q4j1W59MUvqDG0XHW
	 H2Skityqrg/C68A6nFxJDA4NTfuo7dCdh0SnL4ylkUSiD1ZUbxzBvKSHzQezl+7mP4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791853547;
	bh=giTw56f1ENYO3apMfHjHODTcAEVofVpBUy5+EspUoYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSCfFFSPSlLQIT4W8OYe7knSc/FP3avtP2QEwnoUgaNmOCNfuWeztAmO40zUaIeBU
	 rCtvl0IubejvIAm74pRnJX5bTBgvRTVmw+edlzyRothlzvLuWrttZkhNeFB+D+DQwS
	 qadBaAy0lPJwYeGAhL026cTsSalbfnohcVGCF3WBGPsiVtLcvJsC36pFXuLIHIoN3h
	 dahbo8yCprhbRmjvqqC1t8B2ir1bQwIxGwr88rkqS4OJAB5wqAOwAvse4HuasVr+3P
	 uhocmSVG6mvlmv7406hW/bAjK7dfwOwmryhqLkiXGUpWKm/wEr2nt/XlR3rY0Uljtu
	 XTxj4W7M+vaVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C20EF80B97;
	Tue, 13 Oct 2026 01:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEE1F105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0A9840212
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1Xp3UmYmD5o for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 23:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2FE154010F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791847022;
 b=er6BlsFdAsrFkO/VZwRhykgXLgExGSTQPzJu5AEj3NGSlvE+7eqjcG2GLHdHLAnyR1jq
 bL1zQYugLMEC1g0axHBJbwQI7s6LkzI2pLVgZUAcIoQGGY3JoHcTxthK/gXNHbiIcw8R0
 hD0mw+oy1AakTwy+jlz5EO8eG5DASSRLgPimW73v3wBcbJX3ktKOYFkZdum71kH150wHV
 1GTidG0kXdqAxlacOAlOJpXjzLMobtDatuuJ7r12uvNV8NHfgs9WsxFFVNwJM7ndOvakD
 AnOKdOyuQERl0OPvar/MaXe8reTeYmviprAgHcOXuX16b7OY45b4LCOgBgYYg2eTCMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791847022;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=giTw56f1ENYO3apMfHjHODTcAEVofVpBUy5+EspUoYs=;
 b=eT4R+k0rGr91pZyEScmz0SSfmIGqHdDFvfNf4cmfs8VrCmRraGT8GHUU3eQ2vgKR1YtA
 vbR6k6bVPwrMgwZr5zdKfpiB3GLXOuKaJGDUzN7Nn5GoShYTDnGMWAN806B4f64yZAQng
 YoJ2IikpZtA8z1LBobhoDu91JZBQUbeG+6AmRahWN1cQVH95HrdOgv2bVLlVFvJYuiPQC
 mGiDMgQUoR/s7XfZQdK36cND51EajDXPZVYZrIaF+Kwt8NfDNIcst9xEaowZX2NNDjSSN
 njRYFbdNDuH298842df1PXLSmvZMi1TXGrf9F/KlZtpf2ST/bRRvNvzq1TJzlwIchmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NeujmQKV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NeujmQKV
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FE154010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:17:01 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-35aa0cf7c40so1623793eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791847021; x=1792451821;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=giTw56f1ENYO3apMfHjHODTcAEVofVpBUy5+EspUoYs=;
 b=NeujmQKVnFmheFmb2XS6rKNxgSf1MzEE6A1Dy+6BgnDuAmel8bJzGyMyYmAGdj5u8b
 Qo5wph1d7FtYdOW3jfwbSFu9hVTTgjatCiI3QRogxQQ42KcyjlIrOC2cTMmJYFnL9AFa
 gaTfV1PXUNZ6OZdnPE/BsBJdKf5eOmilKorMa6lqVVcDQhiqJyMzI4b8woPGM74EJrsi
 pjSS1NqqmdNDIbM+lJQJXjoCRw1pbzfOySKx1vV9E3nOjquSbZFeYCGbVtkkAUHM0UE9
 XrWh+nXxDd93oUNLB78D6gUmd+gH3rPtBCy5jsc3tzAKQ457Ar0BQyAF+pOpXl4Hvsbs
 RoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791847021; x=1792451821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=giTw56f1ENYO3apMfHjHODTcAEVofVpBUy5+EspUoYs=;
 b=mL3OMyJzEQzWFZGdpqcjheJZbRMqF1B0Mmx/IA8MkZMi3E1rwn5+etLmAOpLw8j9T5
 djvKtVYM1JXxi6tf/LNUldNTY85d842793U3x0TMBt2vy1iuXMw2ZWZbwvvCnDXwN2Ow
 k1Ycc8gRQGuoy+NWXA0S6NNpJ6dRCK0TgPAphV5JV17WIhXuPs/bEQVG7F31CEDyQzWo
 NRQvGMpRmkbpvJQZ4o5JH1ldmpuRs5mJH3SDwGJywmgq3bXYN0OlkqQybYxVOUAoCINO
 q18UDbRs0iR6A2l5ewcQunaI+oe2FIii39rbfBumrT+eR4Y9G09+ApAVuoiJ3hQRbEcS
 qUtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhTSR8DbBt/fYUYMQ/zoi+XpblC+348s8uqh174oR+nG5alcqOeC09jngTgSFA5kYiby/hb6o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJlCSQFbL3J+W8plLPeEb2nfnVXHvX1KhUc7pW7tJHKmHwwvsXC
 u/KMhdjnsmOw6tQ5LyNQuO+BT2ZGd6qFJyerQM5Pwb6oChrMX5iRnPU7
X-Gm-Gg: AYBFou1TZFTwesMuoYsLTN8I0NWxINdwjK7Hurye+rcPL6cUx2Y5MIicIKV8zeqeyuC
 QYdXHZYd3WfSMqZydf/DeDJpBPgnefjblB6V97vbVXWtv5u1OrzWw/nUV8TFrubEW1U6H7b5Pp4
 6+JA3zCb9d5wXtzPj2uzyHGKg7XPFrR7q58g7so8eNob/bPjRgZnqbf+Upf5ZmJYldLWPnSh3Eb
 9U3wsu6sqj4FphrzOr7GpiFrpvAtDH6SteVsQdYf44k4g+SsmHSlTPw2sCSKlVAkVngMqIKgx+L
 ssviEK9ksX7/xdmqiW9HLeBrmKxLZG2WfgwCyJxGXbZk5JmEdwR8mnsqy89/1ZJ17Ej73AeaV8x
 A6Q3sHX7hSmuMad9C5eXc6nBm/WibAHjthfTL1MU6AHvi58I8oxqxyBt/seBsKHVXTEWcsu9jNK
 oZiYg1uL4RsQ6c51GAbDuxHGN2AW69j3n61HtKLZRsgCIpeiMVvr2g2g77bu2eIE34yPEZLY8n/
 drCwvNI+hDgfkpLIH9GrPmuTNRGKd5l8mgqrpEeTQyg00i1ozTmMxNSIAuhdUre9AHEI5xLuIZ4
 RSTX2p1YH7/B6eNkG6VU0k61ZHrMzOfyhCQkwZgMAJvxBYmQW4KCP2YZQY3Xd7/r/A==
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr15664104eec.18.1791847020684; 
 Mon, 12 Oct 2026 16:17:00 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm42127701eec.18.2026.10.12.16.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:17:00 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] spacemit: k1: add Milk-V Jupiter
Date: Tue, 13 Oct 2026 07:16:56 +0800
Message-ID: <20261012231656.1769480-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5d323a11-da4e-4071-bdeb-ab5c03e8f85e@freeshell.de>
References: <20261012151530.1564771-1-alan.tseng.cs@gmail.com>
 <5d323a11-da4e-4071-bdeb-ab5c03e8f85e@freeshell.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 01:05:47 +0000
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

Hi E,

On 10/12/26 15:59, E Shattow wrote:
> Please firstly send a series upstream that adds such trivial nodes as
> appropriate to all supported upstream spacemit/k1-*.dts boards.

Thanks for the review and the pointer. Understood: I'll send the
bootph-pre-ram nodes to Linux first, as a series covering the K1 SoC
nodes in k1.dtsi/k1-pinctrl.dtsi and the board-specific peripherals
(EEPROM, PMIC, SPI NOR) in each spacemit/k1-*.dts, justified by the K1
BootROM boot flow rather than U-Boot. I'll drop this patch for now and
come back with a v2 that references the accepted Linux changes.

Thanks,
Hung-Chun
