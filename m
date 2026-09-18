Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C1C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDD8981338;
	Fri, 18 Sep 2026 20:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJNyH8El3mWO; Fri, 18 Sep 2026 20:14:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B01B81339
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762472;
	b=kq2WkF4DoZM5HM3p6RxnV6wNWQ1ydHC9Ty5wbN28KcVUPcmXKsIQBFm7V595OfiCf8Fu
	 tMaIHhfuwh6VHAqHLX/Jv+fo9jFDJKPKH3S0gyjuhFq18dXSZr7cR0/5KyGtWjAo5EWuY
	 xbth3WjzQso5zDL6Ds5wHSitlTyPsiHbHBf15ccVZbfAYQUWSq8UB2tZQd3dsMHqkt2ym
	 /GtmH30QWkqmpW6giF6KVA+d/8xLsVxTIKiHq72/YJjTjKG052MExhdmEl/3gN0alO+AY
	 yKMOp3bW7E9WC3pkQoLpR2uJHuwiRpeFhyPFTuVW526QClyv+r8+npy3lMxO8nxPFSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wyJbvvrVDkeAmZGWmrCYTf8gowePZfoclSGXiqKRl30=;
	b=GEzO/JRugAm4tP/XIFO+Id0vnAYO/P9L/AkRD1x6IR2Uu/QpPsYUPACh2QLDdMMlGmSu
	 6yEivbFLGguQjtEl6PlfBzdPgK/hc5LE72ShzqHAwnT8ULCAqJEN0ZVIRKhiXBGxeTyRA
	 ZI/AFfsGzgVtmmWa5O38m/fU5XCyAr2R0qrRLJlMLQc2pwx52hoTDVip47kqrOcs4QYL5
	 KnBVC70WHKgNOH2xf38X+5NXwTdTGRBe3ssKHtBJrtglfWwg+ete3Ze9T8akINMYh+rDH
	 SbR7Xeh7F9AgpB3uLpHNsxGYnJLNC9it0nPism4ZyJD16qkXmKNIi0ptz5ClFJphahA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762472;
	bh=wyJbvvrVDkeAmZGWmrCYTf8gowePZfoclSGXiqKRl30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIEXZ0Ki4MWawSWYLhgfLggJTpTtcOT+W59vOi657/SMt2hAGvW6PmvuipGo5ND/N
	 1DTQ+uyErKstZsTnKRszUqrwInQuLDGvyOFurfJ4uVfpCqXjsQX4KlNES3+88AB75v
	 evtRhApugDTnBka6paNvfKq6S6/Rty7iF6tE9CyJU1gfkPK5y3aRRf8YEK1cyW+4TW
	 Tu4Y6LYTsxuYm8SKHjGg5aRm9/8PKoXzob75g7HoovOnZ6Cd91kc8wZ+4vId3qBBXr
	 zPNL6IaQLHfpoVhPDPbP5z0oIzvYPiuycejASdg+jtwWdwF8YOZIsvtFdkvGZuHV8+
	 CTcGa0p05cxzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B01B81339;
	Fri, 18 Sep 2026 20:14:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EEB213D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C88960C0A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-u3JCV3pdkG for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:14:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6320860BF7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762469;
 b=FIA7F4iv+B2yp4qggoiNLlZz7ujiBoAQVnpqaiABbPnohKQgTXNryAkpgHpRYid0PWmp
 uNSn3IGgR575o0ihokz7ipxTxbtaeOfRW7l2fr6yYaiV1Ubs20Ba1xKrBfe4o91lwAa6P
 6ZsM9j3bZpWSNTpYPxT3W8Z1zskyljPY+QuCZxSoe7oDtaY+AwhmE87Sm4+F4s/m6sYyr
 hjEmxVtLQIKvaNFoS3eQoBlZHKADhb/nn4UMo2YC1bq/8FgS6GkIwrntdIX8Dfe4B/Ii0
 SP1VHLK+aq/+K+8sNQm/J1jTFIRR6LhM5X7W6dG08AuXj6y4CrJOtXs0AVzgzHo+ieQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762469;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=wyJbvvrVDkeAmZGWmrCYTf8gowePZfoclSGXiqKRl30=;
 b=BvdWt+/M8/H/DVg3w9cu5qRVxTcPVicB+sySrb+MEi6i8adjqirMe3m5xZjsS3cLPR04
 tMfnUrtZiLXlJBgg/qmWlCnWOM1jGxz074CXv/EpllfIaD17QKXrsBbf5OpC/Vw7mA1vn
 0MWMpgx3I/SLkiUctRRuOxgm8utWSbm6oPZPzcvrt+gHIA103gnl1Pv86ebli3GLSOpx7
 /J1zJnobYXQTxYlJCRMtXkfURkt5Et0fk4S/27mqK+Ik9WogVWv9l09xm1Rr5wRz4c0AP
 bApcGoeeokK1QYcOpvIUN4XRIHNfjNwdy0e4B0KGJJYx21Y+8v8B88Ueo0p4p7XAodA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fk6JgqGw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fk6JgqGw
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6320860BF7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:14:28 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0dd550aso345672a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789762468; x=1790367268;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyJbvvrVDkeAmZGWmrCYTf8gowePZfoclSGXiqKRl30=;
 b=Fk6JgqGw9JdwFh5fsQvKL0XW95jcOuLBUb8zILdmvg+/7DJp/9u5M4y1cME3n0wZse
 M+p1MGcPxOh5rucScKF5j82UzbXpAOm+WdehZShCy6F4MygeJWzIJ8ny5zp252wfae59
 QSPu0UFX0gHt6VxnyhO+FQrg4ZS8nWVbH2BpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762468; x=1790367268;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyJbvvrVDkeAmZGWmrCYTf8gowePZfoclSGXiqKRl30=;
 b=AaVM+gT4O7enBN2Q9Obshn04sA5rp2dlCeHdyxZz3+5+il2NsDZ13Bc4/Vnp8Brz8m
 400xHtQTiSYWwsA+66bFSyI/OsScTpCM06VEKavB1bT61jbmMmLdRDow/dVj06WQcQiT
 qkUaKapXoZNfjtrpqel2pKa199I+ua0xz+A8WT57LLb1OyP6yXQ/T8OocRdzqRL+2+h7
 bQxjonBAy7xvqb0B2tDnTE7xcuRZ9AhfgnWZZqTJEhkYISTh47KG9hcu3OphAVL9cu5r
 qcWzf7LLl/VNfUihb0FYIPBZfG7fqQcs3RyW3B+l5Eucd2ky20c79mbwo6k2PixeAhkL
 h0GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVHp6Rk6Z7t8tzAi0teP4aMJkyG0lC7MIgIRVi+JwWBuBoydEiWJ48rJ+U/jmE+8c2J1M0G8Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nI4MdcMUyStmOiGGsQ+jA5ymTeBvkEDK/4hZsAe7QsM74m/JkF
 wh1628UKDVl21ofSiwdwaucS8fXtkNlrmJIuZFXsgWSbzSJi5eXZ2+anNupz6CPZK7w=
X-Gm-Gg: AYBFou3oafRKc3e1+vtkQcE0wlAmmS6plkaA5rKZM9aF/iksHMzYytc/GLdz5pff+Px
 f11LvtJFBppuoBc3j4eIipEKVyHoDm8YTEwLE3nzV/pIzLrDPvbb5O+FIZO6St+kfB6iWN4+2bf
 fUWY9L5HYesvQ8AOKO56N9QUegkQaCwKKUxcp4aQ6Il/SPrN1cQuibM3nNrPDCZB/bcGbp8J/u+
 yILICcbrRpr9pFRqfqriMMZgkNYcg2VE/UAfOqRdm1ROFG3sBV0V1JMDWEYIEleXj4kfLz9C89p
 WSP7TMlNCXzfxpOAmzgREYto6WwL1TEnJLcQFKP4IC5IBBexs45j7BX0qiE7StZuWX/oMA5D9F6
 e1HzU9e1EyVrGPTvACkIfllitpaHN0O1VVR4cfUQC+fa2yqkJgnljSL8vLEUgEQH/3n7L05X/gt
 5NljVsyGzp8od/A3snEoFF+ainZyXW1uh95ojEiFW4KLZBGjDnsT9j8iNKPXQPNbIq58DbYNb5l
 E24f29+EnSr9yVYN6llddn0xKW7EgaPoRO9AO8rEapy+X2E22urC9lDIdlp6IOBT+v+5va72VSj
 MU2KKJ9KS05+jCeciw==
X-Received: by 2002:a05:6830:6410:b0:7fa:ab72:9dfa with SMTP id
 46e09a7af769-80de33e9937mr5110384a34.18.1789762467743; 
 Fri, 18 Sep 2026 13:14:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8bd19sm556996a34.8.2026.09.18.13.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:14:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
Subject: Re: [PATCH v2 0/5] spi: Convert drivers to dev_read_* APIs
Message-Id: <178976246528.1973088.16242477273383880410.b4-ty@konsulko.com>
Date: Fri, 18 Sep 2026 14:14:25 -0600
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

On Tue, 02 Jun 2026 19:20:14 +0800, Peng Fan (OSS) wrote:

> This series converts several SPI controller drivers to use the
> dev_read_* APIs instead of legacy devfdt_* and raw FDT helpers.
> The dev_read_* APIs provide a unified interface that works with both
> live device tree and flat device tree backends, avoiding direct
> dependencies on devfdt_* helpers
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
      commit: 0cfbd5e28625f2a7fe57ed13368015e7b780a7f1
[2/5] spi: cadence_qspi: Use dev_read_addr_index_ptr()
      commit: f2d8cf8fd54dd245ce9de2637753345ceb75d382
[3/5] spi: mtk_snor: Use dev_read_addr_ptr()
      commit: b6bd9bd4822407d9aa668f88c4c39313e1ba7fe5
[4/5] spi: nxp: Use dev_read_addr_size_name()
      commit: 4299c00b6de080beef48e6c1575f7e1d2d82e16c
[5/5] spi: ti_qspi: Use device APIs
      commit: 73bc5e1695abb595e65198123df402faa64619ce
-- 
Tom


