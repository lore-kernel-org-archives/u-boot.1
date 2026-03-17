Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC0FF6E93
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28740840CF;
	Tue, 17 Mar 2026 23:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zvTXRN1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FA18414B; Tue, 17 Mar 2026 23:39:49 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1329D83E36
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d744d9acbeso2409925a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773787186; x=1774391986;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFzrCMC+9fUxZT8ITl0u4HsmglHzRwRSWJCHLF32Rms=;
 b=zvTXRN1xooiBrA9KB6FUwrcocB0jf9nNtUOWvFumWSD7EaaaIcdVPZQyBQ8f2R9LEB
 nLTt3uut79QU5rYKDuffCHmnxVJsN2Q57rDyCfB0MMBGdg5Uf1Xbg/OnJfFEotQVh1m2
 nJcVTFbqe1UjmRfd9YBi6FgPv56rITeQmjMu/l5969Oq3HpoElDz46/yAeTKaa1geIdD
 u6z2f26L1o0aONhy8eI4VtjUQqY397KFxzaqzrfr6sKe5TjO4703h6OD04Mt/5fNTAv9
 HQqk6YnbDRUxoNnK+Nmi1MreA/lts+UMbCp749W38lQZDsJsF4WS6fumK4LiZBD/fxNe
 cGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773787186; x=1774391986;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FFzrCMC+9fUxZT8ITl0u4HsmglHzRwRSWJCHLF32Rms=;
 b=ULJe7WcShCJR+hwXNM3V1ohJEghuJHo97u4zzahUUiaiHkh63c7VxFPFuq9LuKpPAh
 lvFGY93qZ1PzSwd0WhUPJ5G0CMiXscpr9tLjbx+jq7+n67J9f9ZJ95FDZXMbLxMCMJMj
 SufgwkNczLjFoOzLUIiiWOpAcb+ud/5hxr71w40TBhYpYTgj7dts3LfwAVW05Q168RZY
 MFBu0D+/zPCnYH1euURP3CaGWpbo7ri/bVxlIfUuz99ad1J8/hdxT5Mb1K20QfJU/f0T
 I8mohgwlYn5WX9vjbLh8iBqsiqffyBT11n5rHL6yML3tvBSWKWHOQgDYmiMK/PD0Mm23
 8KMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+t1T0ph6HsovGvb/6p0oQlHx8dqCRfhaH6rZrWYzwetDKjUdn9wI0VIW/aQMEYYQSAD3WWcc=@lists.denx.de
X-Gm-Message-State: AOJu0YxAUCFZg3LPBxQxAuhIZmCXfhHuR1P8nEd7SGY9j7OJBpgDU+W8
 Pz9XNhuOgaJeQMkJ7JcocIRDY0qUmj5SgeRlxT3sfQHsCtz9YFWKOwWVIqkcD1YUP9I=
X-Gm-Gg: ATEYQzzhSo0QkVuGRk9tWiLgEHIBAl971KH6d+sTz1WNgouHXOyaLtcJTj9tS+1oPF5
 8N1uIyq4H1R2etUDd0vPCkN/VxRT1Sz6+ErlE/iaqVEkaeQ5kQpsWify0vXL9qUjZVeZudzhkvS
 NT7ve17bwvkbzxvGXUW/d0vAERNfHm45+P923XiG4bMPyjCL1h+an9st3kNlRo9A5pehPBBG4Br
 eJ8hcVvv6AqOsd4msQVggqnJLcdQczfD/5c6uQjlSVlJjgR3naDjY7A74Tf2ueEfpEX1VprsYTi
 FDQNXnv+5nivczwh/MF++si1Dksgj8oG44u9hlrWYegs/CbJ3Gsc0d4GUC0HLUhFFIOU2z9tP1u
 98eTtWSGw56jbz2hWL4j8hd5Ss4xm+PtXy8GLlBIKyFV9ZF1BHFS+sNRphs9k7WwdafIplkrH10
 2EHFWJVBLzRGc7K8IO5xZlbsHWWA27eUf8alfl
X-Received: by 2002:a05:6830:6f83:b0:7d7:5405:193d with SMTP id
 46e09a7af769-7d7ca6e76d6mr879309a34.24.1773787185707; 
 Tue, 17 Mar 2026 15:39:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c97ef88fsm912544a34.0.2026.03.17.15.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 15:39:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/9] clk: mediatek: clean up flags
Message-Id: <177378708602.670517.13688265575638221774.b4-ty@b4>
Date: Tue, 17 Mar 2026 17:38:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NwLVEE0UMu3UFizt+l4a9Dw5lwe7UduJN3cBjF/TrXY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpudgotFhbcIEs2HYEzrj7FFTzR0LPIrLShRw8Y
 g6z0YP+i/CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnYKBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzpMH/ROEP+k5LxQevkfFjXhzYCBGBhBkUqgBwUTVqac
 b+/nXKa45YYpuZ/O11tlT0KKQ+5ryfDdEzLNCqLzkQH7u/P6BliibtGdEIDjKPjTKFuYbxmM+Wk
 MTHyizh9kg4DGPlb7IEhiJro2xOMF/Bg3r+PVlzyQQ5LtSHniCuHJ+yeTHxIH/iIdVgImv5Us4m
 lG3229Uwo8xcjL0rk1j3EKSLTDS8OPI0DECIvt+ameLgHhffjtnEiP+klzjvZv7ile/RO1DlqVX
 98+T1YoqxLZelT50UkWIe1gN32fLDp6Mupe8jpZrjP03YN8LEJ19aHGbcqlIrQmxmZGfSTB5OnZ
 woDE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 06 Mar 2026 16:05:47 -0600, David Lechner wrote:
> clk: mediatek: clean up flags
> 
> The main point of this series it to get rid of the CLK_BYPASS_XTAL flag.
> It was a bit of a hack to allow mux clock parent arrays to contain both
> CLK_XTAL and CLK_TOP_* clocks. It's usage doesn't work in all cases and
> is easy to get wrong.
> 
> [...]

Applied to mediatek-for-next, thanks!

The rest will get combined with "clk: mediatek: unify mux clocks" series.

[1/9] clk: mediatek: rename HAVE_RST_BAR
      commit: f922929828bc54cc015a4a5d0b2a28dfdf476f27
[2/9] clk: mediatek: rename CLK_DOMAIN_SCPSYS
      commit: e40978fff3d337e8d1535545455a7387d0e6dd02
[3/9] clk: mediatek: add MUX_GATE_MIXED macros
      commit: 4e184ff5a0e3d6c569e5a5f5a1ad8e3c495ddff9
[4/9] clk: mediatek: move common PARENT macros to header
      commit: 7595833599e9f73e58403bc55f475d62537ba068
[8/9] clk: mediatek: set CLK_PARENT_XTAL on fixed factor clocks
      commit: 142c805d470cd02470146d6d70aa9c522d4da16c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

