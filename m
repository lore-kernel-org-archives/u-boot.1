Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F49606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CYdOmTrN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gcn9M1t8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A092740967;
	Fri, 23 Oct 2026 00:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U7XjAl86H-kJ; Fri, 23 Oct 2026 00:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA11040931
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714383;
	b=HmydTWLgskAHVtYdiUbB+uP8u/gi6dCtQE/TPvHZ6nPneAys0/EkyWrMYAh05RAM7xUY
	 Mpv+WQ//2UFkj6SnJ6Qm2Lees5MXt40cBtlt2MYruVmAxJu1RUNalUF4ZXEQMFjHmuMfr
	 RsNyLIRZEqd4PHKC/yCcoJhaaw3mmS8ZJjd/rrGnZR8IZbKhN6YKgbpVCdOy6oTC/7XNf
	 SH1VGPxtixKQ+w2kg6jiRfS68WQvuaVsl3F4BbdimgRXpF5ol3Dqk18tOY/RVeGJyiGFB
	 zo3Hk+bnjumF9kJxX/uQNjEJ9s9/mXGd/puh/YUV2DqD5E7wzzkjaHkQPm1qNihvRJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2YSu9V4CtsWrnQ4uJfnct7TH0hJ8ku1oc5EFIFVDfa4=;
	b=Mb22lYwdj4tu8Ozn65A3ohfW/fzZ6ik/lNiPdzQsPpqB2Br3hF0/TiYPtzHMZ9vVj/2x
	 YKts1keMidNbKf6kBJspAglhpDRhl+3TYW0QWIEWFa7DaPLVCjtUjfi+4uMOY9tEhT4sJ
	 7m5Q6sA+YVgAsokUb6/cMFXepuCtucLESjSa7zlHUQBINoPtn+c/er3A7AW087I94M0ph
	 WRT7R8AkEC9eq5Tmio+okpAhLzQe72i9Q/wWJ0fSu24AxYiAmFmqiVAOiDcoNtYV3et2b
	 X/z5LyL1WkenWI0Ihf13pfYS+Ey7tm5IBt/TwjERB6OhKqx8XB3wLn5uF8XjKm+Zgwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714383;
	bh=2YSu9V4CtsWrnQ4uJfnct7TH0hJ8ku1oc5EFIFVDfa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYdOmTrNOGcPX4DhjTAUOGiX6UhXH7vyir6hE8P37IEEPDtRB9AXelciBpOT6vQFZ
	 K0PLU8xtpnVd5F1uELO4dFt1+cPYAA0yGHZpqA/HKzfsy/BpcSe3oqvpoYq23yqVw6
	 oQ+vUw/Z6IhzR3Br0ojTJ2NB+q8Zs72RimPvSSrQR+ZoAWuJ155qhN8TL0o4GfiB6G
	 iDidVctbyt8I5mdomZR/rwpAcpLKaaM9TlYRQNtO8r4njTO7RP+151mRxvIww3VP2N
	 NPlYY10xM0beW8B4EVDYxsFMjpD5muVnzJRrdXw37IIBNyM7dZP+FYyBoNzlVEPdab
	 vAdbnUijusJCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA11040931;
	Fri, 23 Oct 2026 00:13:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD4744BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2FF06080C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62reLKuygO7e for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBA4B607E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792703905;
 b=Qq3hAhtVHulFv0lPxHb4O5cnWKkYMcd2xjfx+nh5JRbkqMO4yJHgbzUtxJebIw+DfD1u
 cSluK6w4M3xplsW3gF87TP8QVPQmrnH6g008uHYI4AL5jpKLzfy6XJ5auAjWirEhwVgm7
 NZtkU4UldY+tTOz0pEsNhciEqmVB5Fotq8m8oXq6K8PMgE/JYQOqQGCwpc+Wn5E9ccNpZ
 +l+WMNv/lrQYauOSuZGK0PcgGonCggm8vMthZIfkdS4UGvdi1hJLtDzdJoq/52XGTuY5R
 kUIZKEcik+0JH8J49m5//GryeO0LT5bwZxc6iwwnQQ/k3CC90NBpAipJ9zYe8KgBc5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792703905;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2YSu9V4CtsWrnQ4uJfnct7TH0hJ8ku1oc5EFIFVDfa4=;
 b=QpwhQMHmtu58qdEpdmQmL6UA68sejniCB3Q1rPJ3zEGA77gnyrxnadX0Qf5jaK65mJFz
 JBejscbac3AGsayzJ8sAi7Et6IJr5W8q9IaTRVkkdupF+SigMs8oDJx9lQzSFneYD9O6N
 gBhuO7pOuA5mWXxy1h6xu92rEX/e/808I5kwJGrv2SfaFZdgfWNDiZZpfMnt2GALgcpjY
 X0mviks+yeADDiBvsXFj+CxuG5wtAVCCuihyWi44CriyWnoqDmn8E5m+Wv3JYj9Vet6vd
 /bRR5ozFu1vJ/4Q5wmIrx9h62LkRSXK5CQAX44WNA/DZGSDd8YK0aVBQKmCPPbztYug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gcn9M1t8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gcn9M1t8
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBA4B607E7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:18:23 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f84a55e31aso122892a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792703902; x=1793308702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2YSu9V4CtsWrnQ4uJfnct7TH0hJ8ku1oc5EFIFVDfa4=;
 b=Gcn9M1t8SYFp+efoYDcOzKeCNTzBXFMSG3vPXDxIMZDxYYFgpMx0xOeGp1T266nJfh
 PGeZqJ1bcQXWH9xFG/DIF3C+BhGakiOmZmNmtBen8L5949yVqsfzyRkRERrzsc9Px7dN
 mcd39TojhzsCwaowOqY/ELxAj1mTz6D3X0uJdxXbKimB9ImkxYvvjDOONEKQ4cn3Zavg
 lwa6f3d3LYUAO0JPRy8exnPLEINNpkZGHbCQS/BP0fkD8/tn1sZ7+kbL9FgdjVbU4Rjp
 pKP0MI6MQdpjCX1jmsjg1PtFsctC6F1baNvoSZdRFyrT3Y70XfunS+KGCgSMzCUUqrhR
 qgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792703902; x=1793308702;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2YSu9V4CtsWrnQ4uJfnct7TH0hJ8ku1oc5EFIFVDfa4=;
 b=N58dl/4IWIqRnKTxRtev4V5IwC6R+SdHnhxyKWlYd57lTGlU6dsZn5HG55t3Z7QbHZ
 7Iq7uOfMMjAPI7TshoE4IgMUfEOUg6wYwXKfNBZYag0TxCXDxfuYEe4fVYI39jopflp0
 meGrpPdvV7dBv56FWME/ESB5EYz6xN8SW9hRA0IBbcU1TBWkf/R+1p7YxV6x1biarAvA
 InI2i20CKSfTEDtQ2/Nd4SiswX29dht2EA78p6EKEtsR+/9jH4F04VmY6N78tb3O6868
 eE27sOP0+Z0V4rM+1+cM2GNHcmD481SE8CQBVoWpL4RT95BN5M5PdNJUp0eEqGw/Y9rT
 Bzng==
X-Gm-Message-State: AFq9FYIgWhltgb779DfQFlPjx5IBKyEbkBG9iNPpuvKJju/2tOP/Rm/j
 5+O9vTPqtSS+VJbNXxJBpAT/wEiVu5UZ6oD1+5Uq1YZuuTP7yYfK/EDSwqo9QW8TZJU=
X-Gm-Gg: AYBFou0Uj0geyKmUlcxZdV0wY3pzcDgnWFqF1EBwbkDrUGOXDe/rf6sI42T3oBfgpBN
 nM3Q40CKF1ZwEz+T3gMQK3VwtHNd4rCel4pDi2ehpQZ8uTp12Yz3xFFQwXKPunkYvRUjxJRxz1/
 O995gH0c+bMDKyVjRif37UC2x3j2O6Rv0pXhjHckKFXkU251AArvg2DpwVv8DlGBJ9Pi1n0de35
 lgYyXrAhyJYBxPEvm1OxNCLcmhkmy+XuDQhza1zYAwCJS87l16UfHiNdRHy4V/jWIpgx9IEH14s
 dtDr6HTaxFriboIc83czH2d3T4wEhCLcSy/Ccbmm77jS45Q88Q0ngdrFiSCesQUbfG4Xv1IOsdo
 CkARnCoVEprPwFSkSIeMZK9wiA69yghPTgzs8yPn3fITDBe8OT/AWE/x2YbhGERATr9dCgMDBPL
 z4MfwJM5cvDWdRek2BBL1ztE3C/69DEhM2ppBWE+XosgQldrwD8wh14DY1pb8vrHAjl4v7bbZSr
 wY97rywroero9DNo/Qi22+0gKwfBSxU4Bs0aGIcX3cNw4uqjBfwdG30C9jxt5QIzGU5nDWqXxH4
 U5OpmA==
X-Received: by 2002:a05:6830:b13:b0:845:7cb:69f7 with SMTP id
 46e09a7af769-84faed98f59mr322458a34.3.1792703902242; 
 Thu, 22 Oct 2026 14:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbb382b95sm222919a34.2.2026.10.22.14.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:18:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Chris Chen <chris-qj.chen@mediatek.com>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Stephane Le Provost <stephane.leprovost@mediatek.com>, 
 Felix Freimann <felix.freimann@mediatek.com>, 
 Pedro Tsai <pedro.tsai@mediatek.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
In-Reply-To: <20261005-ccaione-upstream-mt8390-ab-v2-1-c6032b5d46a1@baylibre.com>
References: <20261005-ccaione-upstream-mt8390-ab-v2-1-c6032b5d46a1@baylibre.com>
Subject: Re: [PATCH v2] arm: mediatek: support firmware A/B selection in
 SPL
Message-Id: <179270385407.3711947.12255387081395508594.b4-ty@b4>
Date: Thu, 22 Oct 2026 16:17:34 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=414; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=b92CGLz0CmNTYaendGwDuXdmhnpcx+YLn6jOPyCZY/c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2n2UySzU7hq60y1qbvOSXrsMOZWGVGC5cocxQ
 AitJOR5mB2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatp9lBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aw+wH/jpUCJcPiSA2ZqiFjqkIGAuDkjlfVeCR0GLoIKS
 FsvSyr59bmMuDUqGh24YIIZPlfk2Fozgjfc5q5H7C/k1q69gdDjVFmgEPxxdNT9R5JeX9b5dLO/
 FMWQjLnuFOOqB4WSfe6//KxspgUwLp9FbGZLKGgcVZT5CwBC09ZMYEmUGuZsRHE/lY20a5XFE6u
 yncimFFns4vqGJwNPcSIZ6/7X9t+RTxkRy0EdLQKc2CmTUYt2LTcfNXgmJ09+552anqsgfKHCbN
 HCsO3fOwXfaNOi/GPftDooLmb2POaH3Qh9AwP9VSE/LAw1ZyEzhh2wVq17TYco4MQwxuGyVNNoG
 1nRI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
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

On Mon, 05 Oct 2026 12:13:08 +0200, Carlo Caione wrote:
> arm: mediatek: support firmware A/B selection in SPL

Applied to mediatek-for-main, thanks!

Fixed a few typos and removed redundant blkcache_invalidate() while applying.

[1/1] arm: mediatek: support firmware A/B selection in SPL
      commit: 63cfd3f50e27de2d264da7be9c746465e3fb71e8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

