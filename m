Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF643C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD94060A4C;
	Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBYX2v2aNN1E; Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4083C60A56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275811;
	bh=TcqWjs+hAtWG4kmHXN10aHSNgcxqKlok4f2Ur13tAto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVC3S3i8KyzzVqLnqGqmoXbJTb4DiiEWKhwDBr+Wu/cw75MqDmhKyb5vp53mylBr6
	 mIQGdDNXFeyPEpoxkxEJJ73eYhC2LyOvSJAuV4QToXWbbhyPjaN1VmT+iZQexemkeq
	 rm4ZDk0f6MUsiSSUnpmbkAtfprDXzlJiWg+OTrdMi+4ZPIwX2jOpkLCtI6/hUFe0Sn
	 UktrKeEpUMokVAyfEHW7+7IoCZ2WtiD51PAFixOcIWBY531fbUTIWitiES7GVvd1ux
	 qUu/5WmFjV8ktVp85E4FmITV3iIuM880Hni45LX3ME2XMyLsQ9l3FC97i0ntIWKXXT
	 NkKGmpNcE3txQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4083C60A56;
	Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18952788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2E8F40057
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8n_U_hwfhfyu for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C7E6540051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7E6540051
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7E6540051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:45 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so194345a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275805; x=1785880605;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TcqWjs+hAtWG4kmHXN10aHSNgcxqKlok4f2Ur13tAto=;
 b=Qp39X7dYEKUvM+7NaSnSJGLoWYkK5FT77l9Ks8F3JLl+sZGyuCU24a+GKPkSlZiSqD
 wq+X1l8pcLwzofjUorPKFn3mAOYcZIBeIjpMkKSO1kAGLDbk6tZR7VMIpS69nrchjReI
 TaWVtMcQ5GbKPIiSltiT6Ll15mhFoHFIDPM+eN8CxcNbHkiS0HseQgFnRWVCzV6AnW0X
 f+4EkXe+r8BS/HS9tivrJDmsiHHNeB8xWXLML3Y2zhkrIv/CrNWW41LK64TudQxL2T/w
 MQvCoo7mMjUNVd91iETK7xQQIm7R2FLKp/feCISx0PV/c8m6rSNmt92gcMzWbpg/EoON
 kpig==
X-Gm-Message-State: AOJu0YyMUgY0RQ3FHOo9oCbcpf+Anr8Liby23J+0XIgMDlsJO1pZzCW2
 OamDSpqtHCbu5H+fF6I/QpCaSCpBi6BtJ0g8+W7KWkyj1qXnIaPWYmGK6UZ/iS1z4ho=
X-Gm-Gg: AR+sD10onbugCmOVgIiagOzoIc08WUK3LvBwXzjoLmOd9XEBjKNhwEk6CMZpZNyoixp
 bGtVNzLPoWNMK2AZ3h8eTdyvWyS/zSzFABMopPS9Hr2oy4JSTrV55jxdMIaKeqyJP2siyDKmPB/
 1G0lmvM0JOuMcMJHcDjKuxFrBg5DfP6cNVE2r2P5d4gdobzujCxpnczc3p5Hw6am44Ea8jLsMv6
 WhWjIfbe08Pkm8oUoI5eAGAxgjTofVCfXZBLIvnnT4jGU0UGdB84fkdxb5sBW33hXWil7YjO9Fk
 k7yETdj0jiWvE/gvbm8fgB4RE+SAo+KkVW2YXuVa8bj3qiY7bDspbSFnPvRWAxxhjf7MO/i02qT
 rOjn/U6KoIOz8upyB/eESC7DWVtuo5/GthLzolF6tt1x6uMFyGLz80OvYQqXtjNE++qRgzECO9A
 ClXZNq4UdoroVstfQXQFsL5iiReBS9Hh/Luewng/kudG/1b20Qx1wYBPA4MZGL5dhwyuY91qo59
 3zjowceO5bau2O8Uk0wstc6ThMxTV/+BR5xmJ8dBdaUKlgRUIwnbNfp/yG5ws8+GdTzS0k37AV9
 i+MIEFbA
X-Received: by 2002:a05:6830:6688:b0:7e7:7fbc:8e51 with SMTP id
 46e09a7af769-7efff2d6d46mr2510608a34.24.1785275804810; 
 Tue, 28 Jul 2026 14:56:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aristo Chen <jj251510319013@gmail.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
In-Reply-To: <20260709022904.3226038-1-james.hilliard1@gmail.com>
References: <20260709022904.3226038-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH v2] tools: binman: pass KEYDIR to FIT entries
Message-Id: <178527580361.1742553.11015605574666512265.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275805; x=1785880605;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TcqWjs+hAtWG4kmHXN10aHSNgcxqKlok4f2Ur13tAto=;
 b=g85cw5yBv3GYOXgQXFtMCxTcaSVHDf5sqWW50TdRwLveHctFagcpyaG4CF9Nw+t6ev
 gZvsDGYWv+gSR/IxoSXhTYLrVE8JUb6RD9KlC64lOagqa4ivjjut951cTg/QxMQFPR2W
 STjPPomutefLCvCyWhkrp43hRFLWC2xNL9xo8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=g85cw5yB
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 08 Jul 2026 20:29:00 -0600, James Hilliard wrote:

> U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
> internal binman FIT builds only receive the generic BINMAN_INDIRS search
> path. Adding KEYDIR to BINMAN_INDIRS treats it as one more input-file
> search path: FIT entries still auto-detect a key directory from all
> include directories, so an explicit KEYDIR may not be the directory that
> gets passed to mkimage. It also makes a key-only directory part of the
> generic blob lookup path.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] tools: binman: pass KEYDIR to FIT entries
      commit: 18cab277be9cddd9e70f50b1ab77c849a6254d90
-- 
Tom


