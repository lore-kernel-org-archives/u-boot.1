Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D4ECA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C0EB608BF;
	Fri,  9 Oct 2026 17:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ra41WpdN7iq; Fri,  9 Oct 2026 17:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D435B607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565633;
	b=U18CmKJnHIzeT5NS8mEDB+oZ9tfaynwPYjA1/aR4NEU9MJBqXpXovxabiS4nY3+2Wau+
	 EtrA4cT/K9uILaVajY2z/W0xkBB/+m3vPnhswiLJ/QR4hazE1S3GHnnlX5zbAKFWaVn5y
	 zDBnRKReQybrtM5/Xkswv4PKLTc9jhUkOcDTFWYlDskrGjuuMrEhyAZyOTXNJ7hVFHPUs
	 l4KOcLzTQL0Gkpg4G7lxdIOWWFBwByEDsQ6+0Ng/1e2O5YNYSjzZpWnNPLb/NXcc6IdJl
	 la19hvcqQ1lBByYgTGFlDyTkLQnbvWNbBhc9b+W6JdOOcPTXjVqcglGnUwqZTxvEJCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UR3SYB/vmpEU6yqE1PW+7D+20B3qVsuSeW+r7Zc4dDE=;
	b=eg61bCCZVSIbwfz1Ed7dwuzKqt260dXdoJQurbi5g2RvSULiycRGUaiE7QbduBSg2xXg
	 nVx2s4vsHg8FChNtZoNGzOii6znijtrQRulvrxZLtfroMCC82CoWYnToPqgc6TrgH/eXS
	 5TS5WsNa8yp0XojS7EGzJvIMJg5hVWn+3lE2z8Vk2IIU49qP63lFIwacofuLmqCeffveR
	 hd5Oecp/vHNAKP/DNLF2/plmdd0RvMtnop+02KDx/kYyTaKBiCUMQ1lLy2llgMpcMDBOy
	 vlv69XJ0evUPJjhzIqv15IeDop3IphDL8s9W4RvZxubf4eAAXZkSmu3qbqRKbOpglbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565633;
	bh=UR3SYB/vmpEU6yqE1PW+7D+20B3qVsuSeW+r7Zc4dDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0YyewPoBXNdIAhX+EaAJp1i9LchBQhT0xod6QDyutCJsX2Tl9uIbIrza/L6wQNHej
	 n7tEWJu8hpURs4YPW0Ku0WV9IfSf4ezYNFqSqhArw6xBlc3H9IcSGT3eCmxH842h4e
	 045GhUqZTYDkYA+yuN8X8jv1xYmazjrohf9grQZpgeMIsn5Yo/kdLBNMemsrmHkUlx
	 aS/ONXhImGw4b6dYIn/gCdTyjBy328IA0WzQAwJgCC6X48UqAQf/yoxK4RppMB5xDi
	 03EsJ7wPU0A8MpW3+RdXIOGpI2pBgEPgmordRQVTgxVJrmi0jrOWDgg3MEzIbGggyO
	 s6HCx8RBtdDzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D435B607B2;
	Fri,  9 Oct 2026 17:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27FFD317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A0484094C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHYXOWTC9cqA for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA0C8408C7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791565630;
 b=A//zoVsC5NSqkSxXWPNqJpwH1AKby1rYriebYW/tHHI00BVrsGHdt0GlOjuvvUY7yOcp
 mAOL29Nrgf7luGqmr8Wj4iF70GsVQQeCKgmAq/UPwja2gdVSO9DA5S2ExifRGtuVS/SMN
 PYsz/96hOsxZCYNl4M+WjIOYYfbxJWN3LNOLmrYILe8UBBOzYGk7AKpZy+ztAcIE/EOCG
 cfYVQFN5sHqjn6YvnqhUhJStdZY5fytPzrHCRkSuXtDCIzpdJE6Fv5HX+ZGKZHLOl99q2
 A9oJTgA1wgAGN4vhwVBZhwWXqm15ip3M6MdbIMCkVoocBxjXxB1vPeU733vebkPXDaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565630;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=UR3SYB/vmpEU6yqE1PW+7D+20B3qVsuSeW+r7Zc4dDE=;
 b=Xwrw/PbyfNWmjqUDztNOzJcmdcsKun15PHk07h7lfoQh5RxZ9XdmX3F1ZYtYdYqa/Rxk
 Nh6c5w++ZllwtDWCPXDvoKkWNEWTBW6teW0zuRXcJUQIBQqrTyWyOu5Z+QAriuqk1tGF0
 6j6j3uL7Z6mmsR7kcbIB3ZyQ6ucp50kaStgPfHC7Mib4JxRpi8NyXSm+M8XT7tFWWeyb/
 dzFwQ78LPqdOuPBfOlNZBXK21pouI7mjTdc353DW5ShxR8jeMEShvpXFe1FUYUr/6V82D
 W0Hsw2G+qaJV6uweKgjJL68CuJYlctlxmP7n2c5nAlHD1aBr9aBs+0kGjuyoskPCSFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CXurXfn9; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CXurXfn9
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA0C8408C7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:07:09 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-49e0ee9e7afso18986fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791565628; x=1792170428;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UR3SYB/vmpEU6yqE1PW+7D+20B3qVsuSeW+r7Zc4dDE=;
 b=CXurXfn9XLp02Mmy8tXqz/J3xXR1EyM3BgR4uY7jXpQlzkAXHgB7A6arVzvfFE5ATS
 NcQTbz0798yx/PgGI80ZiEUXrhgkDH5+Juqmi0qQHo17NuF62E53GD5HB9rVzDYycXWs
 /hUpgTH0OvkAyQFWsYPluTpy9AA2qslXAQAvockHImPRWvi0ps5BoSEH7iwePG60gReP
 S7jLLuIHKcrCCIb901XITiaqhom89RAVwmK5dBIKJxXiIvqB98m7IrXpMtoC23b6fkH3
 AcHMfigqNdwAnXF6vLXScit+Bc+sxMU+2DSDZu9ZVOK4tWG0ktt19NBYiG+wHyTOgRZV
 P9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791565628; x=1792170428;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UR3SYB/vmpEU6yqE1PW+7D+20B3qVsuSeW+r7Zc4dDE=;
 b=lO3/NjvxoYqzEsFz75/WSs7B5Io0HLrcfbAiQeJYCkpgskmxYeKpDag/xQ2MejSsxl
 xvWsRnQrK/ur+RjUjaYBNZzhbyXtRE3/yGOGapjLDHIk5O0zhUHPjOHS196fySTwH6nX
 M4iDvb2LIpXM50+YXf4hOjPm9nhjLB5kGNL/G+lHoiqCza433Lo+DcGVB9tX3/ZRWM15
 t7veJN2BeCGcvuGyhMMW/Ee7mKv+YDyqhas4ztuV3p7Wq1JwCmlIRgz3PV9+yhxfUo3F
 fQ4o42sHFXfxVxZ/o2VxJMTg8p+GXe7niiKWdGhm6ptQepRggxyL3ixaTu3kC88JlEA9
 R0Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5DEI5JKBmHb03Lul6Xe5iNgXET6WTmx6JsnVdy/+agFDjOtB15Nsyf1s+M7fDjGrMpqrw8yY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK1ibDpU0egyXBalSTbyWCZ07D+XZwQKgxkQaXg0YT1IPbpDht8
 fCastL3o/hp4FUXoCuEvQPrAvqFlZkZmDD91xnAvOnirOPMxbRPHrs0GeRNdohFYGsg=
X-Gm-Gg: AYBFou0L8xG1kQim6hZttY+8BrdWmSuJrwzKUUTQNG6KdtWzdH+NL9+G7kUPg61azeS
 Y4dVUtmw7i29yaSqkJOMbrnU42OK22zjL5qyabcJloCzp+sAQtJ0EVNs1Ha1A2pBIXctvldBhTD
 DUaylf/SKpepzObHSLkV956BmEC8Ux6B+QHhwBzoHJ6ejDSuc/cf0HK0Oi28uvS5MtAngHq/PgB
 EOZGGQW2Syo0hQTmv1oL+/gBLJQuxolO87bkVwBencWZ8ygYptAZhVJkCY9l1CpZwXE10h7bS95
 yPk2EqSj+fuDHT8bkOM068Didv0M1Upgz2LjCwcNMQXmyOneiiA3t+y3cqQIAFUCvftt+os2hZX
 ++NaMrKnZHXE75hLwdpTkQ4db48GMWJJDAArS89RR1+pbpdBt27uHg6yjZAbYZ1sw+qHMjp3ft1
 30XEJ3NJiGRtbLMJApKA7xMZTteobTmQrWlFvnyTyCkuzKW6GGN0RZ3HRzUMQZt2p2+ize5OiQS
 L8=
X-Received: by 2002:a05:687c:4597:10b0:4a2:c429:3b62 with SMTP id
 586e51a60fabf-4a2c4293eb3mr227335fac.58.1791565628615; 
 Fri, 09 Oct 2026 10:07:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a85132bcsm2446255fac.10.2026.10.09.10.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:07:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
Subject: Re: [PATCH v2 00/11] clk: mediatek: code cleanup
Message-Id: <179156561726.1248553.5392025655416395530.b4-ty@b4>
Date: Fri, 09 Oct 2026 12:06:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=W/WoxDUDE/U2qNQOXlDBoyvxVDLJzn76PGak3TeIQU8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyR8zNZuBZlVlbSbw8BQSnMDNdWflixilsrbIf
 KCEtEhpDKiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskfMxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArzEH/3w7J2ZdDZZRpyTW4+M0NKJaezJF4erPUx672ft
 WfJH0nLvl/k/JeSFHliwMag1SVWfS2e4YVlEIssv0SQIlEPg1WNdjJUwteOeLzicf+FemSnYCN8
 4cqr9/RXUAEmDUi6lHRbnq8Q4VSu3Xpt6qkf5Im9/sv9aF3SDk2kQ4JlWEGy9f77t9cDCiRXvHC
 Z07cGkFiAZJoRSJd37Ybs2+SIuzCB3wi1nU8q+4YdjbUWa2UmaZnxhJwGkKJ5dK/wx2kMuWxzzT
 2iJfCwkIBagiBCdkSAQV98UnK1ZLItJJ8ynkEarEK0LZn3po4v24Q4/5h6cKaC6ERBEgQDKkFlJ
 gAW0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Tue, 29 Sep 2026 14:38:38 +0200, Julien Stephan wrote:
> clk: mediatek: code cleanup
> 
> This series adds more code cleanup in the MediaTek clocks drivers.
> 
> - add missing static identifier to MT8188 clock tree before refactoring
>   them using GATE_CLK_TREE (see below)
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/11] clk: mediatek: mt8188: make the clock trees static
        commit: 8f7bc58060ea05c4be47219e523c7398f8253557
[02/11] clk: mediatek: add a helper to declare gate-only clock trees
        commit: 18e150656ef1ddfe2269de00bb91a2e13fb8816d
[03/11] clk: mediatek: use MTK_GATE_CLK_TREE() for the gate-only clock trees
        commit: 27a72726804ca0b366ed0ffbe5f95ee8562cd95c
[04/11] clk: mediatek: mt8183: merge the clock drivers into a single driver
        commit: 7bb80f591c046b98406c70967c2c6322fc9685f1
[05/11] clk: mediatek: mt8188: merge the clock drivers into a single driver
        commit: 3cec8ee10ff2e0bed988c89795a3f77590c7e98c
[06/11] clk: mediatek: mt8189: merge the clock drivers into a single driver
        commit: 9550e1d0d31338bd9d8b46f65a6bc8160e47d6f9
[07/11] clk: mediatek: mt8195: merge the clock drivers into a single driver
        commit: d7234a59ee7a49d07c407d43baf46702e95ebaee
[08/11] clk: mediatek: mt8365: merge the clock drivers into a single driver
        commit: ee6b1eed1a7e0ad4f871a850c7c0c19b6eaea066
[09/11] clk: mediatek: mt8512: merge the clock drivers into a single driver
        commit: 57b83a33ad08406c3cb5cc0ac857a717862a01d4
[10/11] clk: mediatek: mt8516: merge the clock drivers into a single driver
        commit: 381ef1fdc245cf20ea330b2457bb95fe3bd08bbb
[11/11] clk: mediatek: mt8518: merge the clock drivers into a single driver
        commit: 80b893fbe1735e328dcd7e7b337981e86209cd11

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

