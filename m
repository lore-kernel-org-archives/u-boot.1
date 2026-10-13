Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B16CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AE354062B;
	Tue, 13 Oct 2026 05:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktVf3uwZTzkU; Tue, 13 Oct 2026 05:47:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 48F9D40483
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791870468;
	b=Pe8BQ+ssLWLqK8PHFjEP+7TZ7ab+PmIrguNlImmQ+umZ9GcOr30+s6MSxC1mVmiMEwJu
	 S1NJUtx6dgONfZ56VDYbMBbVPdpC8yHzDnyxN170CddkrbN/orHji9ZfVeb9ENAxM/M0L
	 1uynA2AW8/cqpSwI2V+zygYg8aNVfEosNs2fF++88neTyFqwg3T8bdFE1taeKhXXpgn8x
	 7uqjOjsr6PrdNSroyEMJ+pVltaIcqZwgHvOeccMhhmFJDJYxAijbEaAJh7Cu2A3PFXnVf
	 FwbUgzJQfS+FxCqx11GtySFBJ+uL3utk2WP8RMeuAHF/sYv7Bji6awIkBLMCZL5FsNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791870468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NZxzs8k7UAtOYSUlBD00SZ72HzMBJte846AUCe/SPQs=;
	b=XHADColVWl7cbCaJPTuBTCcAVonLooaVWJXqRM1nSipA1l2+UVdvdZIE801IM+MSlMci
	 naDcFN1OtHSFrD1ylfgm2+obrL/4cZQNuVgO4TetT2kQpu0+AXtKbVo47YAbxWWXQ7faz
	 SfnHFhB5wj/IYUxr1M5qcLTa2ICwigEGXE+XFrFBYdR3M4961juOhX14FuED5p4/EhHJw
	 3NRfE2V605gHKwQB9SPEXD8L8anerJmiqpJKr3n5yVy1JHxN7yBAO6w0060o2T9qqVUfr
	 9/jljxxN2mIU9RsMbitP9fgQcMVaIYurvVpnL5BcXcL5PGS/JloSE5sl9i8lkSPLekg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791870468;
	bh=NZxzs8k7UAtOYSUlBD00SZ72HzMBJte846AUCe/SPQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gD6nU6ykSKwukYHlOwyNFJHwp1hT3ZEWoQlZTiJqUSNqI76yZM1k5/ChZQfU/tue+
	 GpZScQUdPiCScTeXx7zAEuph9vc7a0LjMUS95zcbWZbzJxoNNGcJf5DZFFo+NQL2ta
	 yJT/BbmD01gqB/f3us0f8vc8B9q3knh+a6YZFqQqpkWpJrQkPQ8n+MoV1upHmlYllL
	 3b5rGh2qGDdxGI3LizBJg2UOXOFysPmHlLFqnUtbzvr67N4u45vx9thZhGsTkrFeXG
	 kBKaCzQPgkm84pRSLEvILROiOFy2NlCk3cDiknVW/Hs8Ys09owf8X+suYZOcFLS7dj
	 I8dHqtCdK/ONQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48F9D40483;
	Tue, 13 Oct 2026 05:47:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3888105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 957E740187
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfkQEXehIcKo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 04:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 629014008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791865886;
 b=OyKbioeUDCKAsrltWNFOUzDINK9ofJ3ZespjbVRvuoT7y9YNGWPsBxBCxvUSnbYY/IIF
 LzGG2MYtr9lqH/AaTzMAzPbuFn1MGr1hpOGQooq+UvgsLtyFO66d1F2rzNj98nwQ4uTeZ
 rpgqgxvFoVEknErq8JsUtk1RQsTrrFRgciGTS3OQihm+M6lJyT2GuG2c5UEjc30B8ByI8
 nhencixypnpdXJRJJJziGtNipf5+SmUygna3oBvE++It6aZwUEbzlS9VsvZ1kEwg7Dv5y
 74Ee2NL0Cq+JOpXTNWiOfWYU/vfVgkOsIaaaTZPe/SjjbYl647Z4lSaUFCUaOtRUH8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791865886;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=NZxzs8k7UAtOYSUlBD00SZ72HzMBJte846AUCe/SPQs=;
 b=cTXZIOB1vaHgS8BA7cnEOipNDB6ye8cbDOgjThqgGCcfPV4u/P8zE484Q7olM9lUeLlF
 Y4JUAP8VwE89ToxtgSJ4xEZXYYRlIh3o1rmQo4RZu5nAlPsSWmPZGYTmkUh23iXbhmEKt
 YpHGtYyEMM5kG21TSdBg8huIkdFxFLTsBwBLlkjhIO8QagPtV4qbn2hTRz6d0Nlc0A9+/
 fK+OuDI+WFRpTH5CSuTUwA6Bmva1s/kvI6cYlqx+4Xsqi1XnB9/fD93rUskyt1qtFrJSF
 vPDyiIt+SCdiee8Qa+8T1DXdOwvj1d1x6si/eLB4gtUn39E4bzPnHXM0OQHbMTJQ5Sg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=b9BUERMP; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=b9BUERMP
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 629014008C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:25 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB71A3F294
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791865882;
 bh=NZxzs8k7UAtOYSUlBD00SZ72HzMBJte846AUCe/SPQs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=b9BUERMPZBI4pW0iEN89Exkw5JFSk2WfKLyeMTYHrpn1eW9Zj1Zw5v9us0YpmLpNc
 MJubiVG9sv7Ri/wiD4Ny7/9wZIL6OZxPfa/qClsfuJaRRxAOToDt+lmf1pmiNAzBHA
 tIrEjmn7pFtxp8Xxmzcu8SnZxMbwB9WByS+JukDb3KQxsGSdHFY6VdSUSQZh1YBpe3
 ZizCw3dyAitvIzsD3PTL8HEJYbEXXwvCaDXTFVBlTOCb6f/zZdSVytAnoMlge/lzf6
 4p9IwcZ2HQGgvmp96Ta1cpO6/Ypej3ybaWGLc/FXGwBy/ml1ZhumL6A3Pj3HffsJaG
 0krItgbbWDkMrCxFP6XTzzm6ek0humREjjDCAuWmaQWMVukzJhiV+m3tGZElc2Z1Ck
 lVco0nFWymLEupEvzqx3//ufRVcL48KaoNM1CQmAt1laHcYpeeXiREHGo49TVFJE0x
 qNcaXlgJi4mMIxj7m/EGpRoikXOAbDCOM43MFd0DjxcA//FMaznbQ/txs7G7V+8NqZ
 CnIQel0rHwSxxmC6tHzwOT0RydK60SQklhs/BNMF98rwAEeENAIqVrsbVp5SatBSi0
 lwAfVLdPJXRizzKBWCq+GbqkdbTWCQ2Tdl4AZfOgTG1Elv+sloeX7dFrbenLjbkRLq
 uQiLq+C9Z5wLRu5IFFPQktwA=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-88c768886a6so1595260b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791865881; x=1792470681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NZxzs8k7UAtOYSUlBD00SZ72HzMBJte846AUCe/SPQs=;
 b=Pis+8JDDn9I4e0ZtZvzgIRHFu1XXtbRkvgwxnPLyjvmjiNUQ+psJpzKnwOd6h9q914
 UhfA/BzsWVj1vaH6YuxZd7JaNMcuK1t1VMaIbfIp4JHEI++exDeetpNSGILLlnlTPBMT
 5ld9zvAX7KEk4+S2pevr3nB8mWA+woPPSvE/u22EeUegzN3Ymsv0Iv8+LFD7LGyzAiNX
 X4UyEVOlO0g3hltl5nt4kok/uXwrSvZ2ZneXEUylcMhQ2CvhD6MBZO5jHqqcOoe3JKTA
 bSMf+3Sq/zaYfPMki0NKNzMsUT/p4uviBiVZNAGDxjmgWVIYt1Ds0cSHgsEvM8D0Fyys
 Wwjg==
X-Gm-Message-State: AFq9FYIOX4fvGD4HR2X4h6rK3lwuCUCF3uq5A+QzjDJ7XX0IX0Isiy0/
 XgZGr76FjEs3yupA4Q1NtVRAuVjBF9+gI1pbpDOA17xLS7zKEQ3YNFHGM5x4u2bhxV0M7xVZI8y
 qsLh0ic82U6cLgc6ug3CZ/G2dACyexwFF21hP2MbJD+iLrYkekUYeWy+h0zryhoSVSiRwzxCgGW
 dYmmw8I5lQWQpTc6gWcQ==
X-Gm-Gg: AYBFou2BEVu4J03Ys7FG2WZUpBoBN4w8e6df7gRU7ThEx+j5G0Fsv4OqtBnOt15ozIE
 hTYlunoTWK/THE5w2D3E4TBeIIQhMbyRHHV8CdVDd7YTfRLmh8YXgnyYTLLNc9/KFwdLXpV4Lfq
 tP9/jOIWnoPYfn6VGWKzLPANBgKCBOdkGpnIl3j8JUmxygSCwtT57/aupRLuBuIhB0wzTi6JKMv
 JZyqplrunm3YT//PApt6M4t2jY6UIbbV87u+9YSe3XYDVhEANDIktsigXGiz+7QdXOEpsd3vrP/
 RVZiLLMk0LcWONAMfgbjvNBqqZhxI5EqBPeRBGTAo6kHEUr1P/qIC0L/up2u9lUg3L0Vu2yiK6A
 Ua61m2uSAXtlNruAsMdXwDNSJfjKYAMf0YW4zKoQSRzy0Ht4=
X-Received: by 2002:a05:6a00:139a:b0:88b:9eca:951a with SMTP id
 d2e1a72fcca58-897c3ef8f40mr8915894b3a.1.1791865881214; 
 Mon, 12 Oct 2026 21:31:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:139a:b0:88b:9eca:951a with SMTP id
 d2e1a72fcca58-897c3ef8f40mr8915813b3a.1.1791865877949; 
 Mon, 12 Oct 2026 21:31:17 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-899b738d03bsm2419931b3a.41.2026.10.12.21.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:31:16 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/2] imx8mn_evk: Drop duplicate prepare_mcore
Date: Tue, 13 Oct 2026 04:29:42 +0000
Message-ID: <20261013043050.386025-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013043050.386025-1-aristo.chen@canonical.com>
References: <20261013043050.386025-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 05:47:40 +0000
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

imx8mn_evk.env defines prepare_mcore twice. Both definitions set
mcore_clk to clk-imx8mn.mcore_booted and only differ in a trailing ';',
which makes no difference to the command. Drop the second one.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/imx8mn_evk/imx8mn_evk.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/nxp/imx8mn_evk/imx8mn_evk.env b/board/nxp/imx8mn_evk/imx8mn_evk.env
index fbdf202c573..3f5517a0943 100644
--- a/board/nxp/imx8mn_evk/imx8mn_evk.env
+++ b/board/nxp/imx8mn_evk/imx8mn_evk.env
@@ -25,7 +25,6 @@ ramdisk_addr_r=0x48080000
 scriptaddr=0x40000000
 
 mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
-prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=echo Booting from mmc ...;
-- 
2.43.0

