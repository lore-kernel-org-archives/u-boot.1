Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8F606A32C
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V2d89Ftl;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EL6G8o0V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A487180CA6;
	Thu, 19 Nov 2026 21:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RdTGdYN0v9Ap; Thu, 19 Nov 2026 21:39:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BF7780E46
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795124340;
	b=jiD2NdE4QURmOsjhcQPHKCCZQJ37Wa7U6SsNZaAnhJZxNRlHMyY87XGvA/qpfs3ZVZAE
	 qFsHZcpeogYDwbE4IdrJhjmysgrN6zoMLsg03FQhU63Kk7K6CC6GK5KYs8H/HuffrrD40
	 QwrwdJ1nzYaDE1GfxbeLV9tQyVRP5cnMWlE9n+0A47lm+eNvSMjm9QeXrVANN+vw4r1Z4
	 9l7PFrEwNLH5WqBIfr8FK0KvntZutx7nZZR3yFtnyuTH041B6PzanUUqlJ4GXle4gx+gZ
	 ixYWsUzv5mEuoA0UYuhP3NOKmZtM03v5T2VgJLFvt7j2N+1/W+ZGN8BhhUOKqzDeYsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cPfD6j20+VPPk88CQcgMYcB3gPAblgWlgneaHJn6Yks=;
	b=td6vltY4NGBwskd7AvyQTPJchIglL0F//8BsLLf3TLlHwNhH36IFEuO72j0TT2Z65HQf
	 xi+SgyUfJn2nEZdjaEWHJaQudJ/UDkuscPCk++ikxtixW3q6XWJWX9UBfRcEwJg75/nib
	 7yViiGYmWXWNEf/9PL4/c2/TI1+ArYi4PYWZLL74wdrh6T1O+DMAmenw6noFn1rD/HicG
	 iNWc+ZAM2514m3RKqdxDlUFX5cvskFdvaZg+WTtrQtGj308LpM6HFufvHecfi1m7swy2j
	 Et8o7wRzSb9MkCLf/inijg11RQpoIWzKWDp0m4i7FAokNF7u2rkC95KKeTW9CY5fksQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795124340;
	bh=cPfD6j20+VPPk88CQcgMYcB3gPAblgWlgneaHJn6Yks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2d89Ftl4L30lXxUHVfjiADkrbKHQ6c9YbC6t8FCuOflwJdgG9a6F8Vy0EP6ShP+Y
	 aBdl6M5tREJ98XuHYfYgMzDcZqIWhAROa1yg9Ju5yWORUjBSVW3K5oYOzwulfvX7DR
	 QgaUPp/U/f58LkQx7GAanBxB6zjUJuYOGq7dTbud4xNyKwuawpZzWuMomHHxpJ/azD
	 NSNZx8rcYNN8iPL7IJs4eIY5uX+npmutAEKsyQuFGytZo1zLpbXwVuoyTWIyE4reKq
	 L1/pdp4BulrO7wGX2wBmo0kOd4XxRRm/c/GxuValGOlDY0ihvrPSuju+IVJr9CKLNB
	 wbm41h+U8ttQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BF7780E46;
	Thu, 19 Nov 2026 21:39:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 154AA2F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE14540DDA
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmJu0Py1y6QS for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:38:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1BE6840DD7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EL6G8o0V
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BE6840DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:56 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-845788309b4so148764a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795124336; x=1795729136;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cPfD6j20+VPPk88CQcgMYcB3gPAblgWlgneaHJn6Yks=;
 b=EL6G8o0VggX0FmgVLOKI/fr18jD7l6OMw0IiBnA5VcYhRw0sKDJshJDVb7fgDhkBLe
 3RdYkSVn33xsFmAEjE/7D25Knzj4eKFf2ZaD4MPZXAmCDk4W5XuXeb6jB6crOCaf70Po
 WW0O6ud7XkQJYeirlXi4WapRk9MrcXaLOgNE4C1UtL+yF3UFUDcOtJcrXPMhGhG+sayR
 MmZWl5nRFxXTkKEyYtnlF0py7ouRjXQM8P/sxsbaNpz471BnP8dAvYF5gPCBbhp5rt7s
 ySryNIFX9iKgtZ2RnkhLBFqFKLK4jizrPd0WtojA+l9xeqOLHB07UaVV0JxEMuEcEcVK
 PI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124336; x=1795729136;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cPfD6j20+VPPk88CQcgMYcB3gPAblgWlgneaHJn6Yks=;
 b=YtjGvIjvhIrDl85OyuFysAnmTxxE/xqvVy8hl9VJvR+pWLm/dZzDZP126tYvDa3R6L
 5DA6uBJ0eTLOaWONX+0nMfHYfygDtx/5Vb6LwspDd3wpkHu2nmEM59V8Ga0mRocql3q/
 bywDYEeeqQQYQaJuEPg6nKi8LOrDFG99cDf2kc1y8iQ4R7K4jZdHUtDDCPbDJaU3hbTH
 v60owf0WL3MsYTS/6sbyxc3JA3qxQcZyVp9uIIcHNsBOO4JdMJyVfVcjoR1OGW3/CGPI
 H8bnAdTMiJMXSOKrFxNy+XyD2Rm77TLV1bk0Tvi+YYRZVv9ZhYCEPAtLJUHtE8HPBXiT
 2Bhw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwGQa2xAomm6oGCHNWiVY1Zn0WlVJdPK1VRdktbKbY/vIkUMkpSIDoyVWJDjdvPXDwTYSOQhg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9VfKmYLllDlJ1Ekf9J4uKM2nVjGu18cyDJrsJhmyiTD+/MWYe8
 jWCU069jqIbaxAV1oNGeLUHRyIebYOV1W6sdmqsk97lW8qsZ/plL7AlVy1ugXYo2zOE=
X-Gm-Gg: AYBFou0inCLKm9l8pbawrqT4MWb2H0vxb3LVY8Ed5c1y9jBvvfLPO0h3UH0od8Kg8Yt
 qbgu+ZoZhU0CUVqAfqR4KFvkfQBRfqt073zGz9Jo/Dxclkhk8I9VsduZbm7yp09eeYD77IBeqt5
 s2frAyCan80uR+J8ucxPHvEpdlrdjlZJ4enyMuTvd2DN/WomsuGzvTlbbqfBBglpTZTcf2tNV7m
 k9XmmDTWqb9xXoMLTG8Zl+GFu8z/a+e3n0spuqpTAo7sQwleUs4hcMfcYzTbRf67LlVx+poyojs
 2N0MfrXN4ZTTwLjWRK7mxpGMmF711wMssEkAdxfd0p1dDa6HsHyFsFLExvBytSFt6fzrob+CQQm
 3YuToPDNNgarSa8fvIpdkpMkAEHmjSmRe2xXIU3+jFao6wAu8XRQJG8+Iet5txSo6fERfSQZk93
 jWD80Mo1E7nml3ac8NAMVFxMkZ3Dsltq0V3/CqZlO8k35cljv/CWHJLRXHQY9Q7YBNtlVw1HC/d
 xCDfGlE7AqHtg0rmSJ3xgCd0qMVGxMdIEJa0Ut6dRF83o0rM5IyBsNTGgeMQIZ05v3Z5Zt8O050
 sMbtegmOGnSD8AO+hmri49n1c/EQlyEh+McYUAo/obpWyJSQbSMUQ/+bS0qlrNylZjcPRwweELY
 Jn2o=
X-Received: by 2002:a05:6830:4ac3:b0:862:bb04:b557 with SMTP id
 46e09a7af769-863158f0eb3mr2089924a34.8.1795124335745; 
 Thu, 19 Nov 2026 13:38:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690f53dsm648168a34.19.2026.11.19.13.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:38:55 -0800 (PST)
Message-ID: <242d888a-c7a8-4f2d-b03d-87c3c74b6759@baylibre.com>
Date: Thu, 19 Nov 2026 15:38:54 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] i2c: mediatek: support the MT8188 controller
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-2-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-2-916dd6cc8d1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> The Genio 720 uses the MT8188 I2C controller. Add support for its
> register layout, bus timing and DMA handshake. Restore the bus timing
> registers after a controller reset.
> 
Compared with Linux i2c-mt65xx.c for mt8188_compat:

* The divider loop goes up to 256, but Linux limits it to 32 (MAX_CLOCK_DIV_5BITS)
  when both timing_adjust and ltiming_adjust are set.
* The step count is missing the mtk_i2c_get_clk_div_restri() correction, so
  the timing can be off by one step depending on sample_cnt and inter_clk_div.
* For apdma_sync, Linux resets the I2C/DMA handshake before each message of
  a multi-message non-WRRD transfer (e3e4949e637d "i2c: mediatek: Reset the
  handshake signal between i2c and dma"). This patch only does it in
  mtk_i2c_init_hw(). Was a transfer with more than two messages, or two
  writes, tested?


