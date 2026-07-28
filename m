Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE84C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3331E409D9;
	Tue, 28 Jul 2026 14:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxTi5wU5ULod; Tue, 28 Jul 2026 14:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C74C409CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785247958;
	bh=fpQZ3sKj5Dg0zshiLeR8snvCCoA7S4UpzfZ4GUqad+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/7LWlA/Qq7ZdY7kpc509cNSnc3rBbUzT9hKClKbXyAXdgizTuOnM7XWywHWt2yfF
	 e5+dqo/92JTRXA8cL7ccmoG7d3OH4ApWxy1F5c/DkL1lvQAnH/OHxX/zOihMCyxye9
	 6eyK5mCg4pIOrx2yRpjyWfTR5rsPVVt/Hf55L8Hf6BMb8rRArDGAL25iswDIOSi+qz
	 Ru2tzUyi4lSBmjQdKXV+uLMaL33HxjizaHIWemG1k8oqWQY9FXxJwdsYtFTrBIQBNX
	 ekN7Ds2o2Jg4rxb0Y6Dk/1YmfEwCtLodKXXTsD0nb9vgfXImh5dT2E7poUrdqGYMO7
	 G7V+LNB/lWqoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C74C409CE;
	Tue, 28 Jul 2026 14:12:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1B96350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7722409CE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gG8ntCdiiM4U for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 14:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 72648409A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72648409A7
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72648409A7
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:12:34 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7eb64085c45so1926936a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247954; x=1785852754;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpQZ3sKj5Dg0zshiLeR8snvCCoA7S4UpzfZ4GUqad+c=;
 b=bcacJnRY9vX++CVcHtbcW1dalxzQE4oaOg312pdrxqs9fedtjhX/Cd57s/lAUJfTpD
 2aMXLLtixJOnL1MpMbHw1GTmwPR7zMPunryHzDnM+Xj7BZ2IvVmcVxocdxvnX0djT0Bm
 mLy3l4HOBIsW4w4FSC1FaxoT+83Pm6pOpGUVxY2jJIubch8bORGeGwH2JrAhxS71JWdz
 U1Hx4+xar5ujdncoelGO8LcPkiTrVSWX4mmZaDT9hkwb9QmgWYjDDOvsf8RWMf7DxPks
 ndZKGIK0n1ADmiQAXXpnEzSMGoQJnjtPwLB5TbAxdKke/J8IRIO0xJtDIv6JMJ6ld7Pp
 vaDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4p4f9a8nnlSwAMB8/ahAJj1PNVaauN4s7F6KwiYqLDmcwyS8d+BfwvvdzSXvBtNj4Koyn2PY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyJGT6eE2baYv2pLtHPb2iLbbTMIr7WQ5QfQ2BIqZkTI1ua4j6J
 CrkEMDezfIuL1WKbnYCMqztFK1vz8NcGCN8s7ebNFifLpz/EkXuTRUdjI0mrchPXnfs=
X-Gm-Gg: AR+sD12vubQHpo0ciLA2MHeLf+VI5ZT5AO0zj6daL6V8eQ8ZK9s8MeWJ38rmTbrP8d3
 oBzzrmsC4qzSX6SEhrkubM8hdeKOMhLrF5trMy+Xi0mPKzhiBBu1n1VN497UL7RvE2ht1i80g4U
 XlXtn9g5ctD8caWPav5yAV6JRjJC8jaOprk4SEYeuKQfD4ccQJ6XhNNecvkbOPPwAU1SWyWXIur
 drj6R/rXp+R8hPFJ/gDaH2JFV1AFZ4HTZYPjeKpjNHuWdip99HRAjfbbKBdKCE+SFUL3MwRieBa
 ZMrVPI/wGKtSVImxI2fehQMv7J1aCfLDN2WhmimY8CSXia1AJvGRZH/fgPDhdSrAD9XbnezgHoR
 QI8fFeK/e6DtoaeL3nhxKO6DUG9JF8ga4CuOBtSxToSlK0hSSAVlxTdAR7aRRzDB43QPVnzQoDw
 e8+BAziZuYT4EVHtABuZBtBUdUlUYgf4HR/xeDA/uXd16VbHHfsluNxmq6ddUS6kE=
X-Received: by 2002:a05:6830:81c9:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7efff247cd9mr1522286a34.18.1785247953963; 
 Tue, 28 Jul 2026 07:12:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3026:75d1:db9d:8984?
 ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a0b0fbfsm14838793a34.23.2026.07.28.07.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 07:12:33 -0700 (PDT)
Message-ID: <b567151a-edea-450d-8807-8be93bca20c2@baylibre.com>
Date: Tue, 28 Jul 2026 09:12:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8188: fix top0 gate polarity
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>
References: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785247954; x=1785852754;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fpQZ3sKj5Dg0zshiLeR8snvCCoA7S4UpzfZ4GUqad+c=;
 b=PbgtSprLtn7iZ670OTaDeIKI/39trDHyWfkP0FDU72AhDr0o301Hhre9S6dDoUMp7X
 P3a4KhHLdQnwfwmOoBtuv3bhEocRD2Fx/2u1d1h+XK44yc0a5azupR7cE6GOTakGOyUU
 JyD2TkFyM7v4jKU3YvmyzjKdhuqNT117DT4bYgsACarQW2B/nnuX3R27RmmaDcmJfRtA
 Aef5fwTMLcRwlbkBTUaDVykau4Uw7H/Gl1+unLvLWCTmbYEVJo02u9Op2CgT+Sxk10TV
 yuMLsxeMiZaTzvDMrDFBFYsMNIISqJ0dbtxvRdX3WP5W9fZSaT6gYnEw6elFA9qX2es9
 Ys+Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PbgtSprL
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

On 7/28/26 7:28 AM, Julien Stephan wrote:
> Gates in top0_cg_regs are active-high. The GATE_TOP0/GATE_TOP0E macros
> set CLK_GATE_NO_SETCLR flags, which treat them as active-low. Enabling
> the clock is currently disabling them.
> 
> Switch both macros to CLK_GATE_NO_SETCLR_INV to use the correct
> active-high semantics.
> 

Can you reply with a Fixes: tag since this is fixing a bug? (No need
to resend.)

> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
