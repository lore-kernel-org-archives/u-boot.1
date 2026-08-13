Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F508C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40D1780A65;
	Thu, 13 Aug 2026 17:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ii-eHU4_748L; Thu, 13 Aug 2026 17:28:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7286C812EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786642130;
	bh=CSydjkAJEGfeSOBC8jpWokvFop8ElgM1ZQbeJeJoBiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buhK3jzrylenn7odDCGYI6xooJfKoIDIo5yTuruLF9zviZGmF4U1dJXIrMkV9JYQB
	 7NaL/cpHZkL5Z61BmdSB5bOSmURU4JRHQxrd1i4O0ValaQimOv88d/XN9vLTvy7Onq
	 k/tNLkuEoLTNRRrgJJpHGig1q7KAkOYlHQ1Q2KQ1WQM/+YURp4EMKjn+HVxacbpTvt
	 2kF6fzrwf0d89Km9AB8rjtDYaXagbTofDs/u6q7IEx6A8JwQoHTXgNqZd2uWJIA+xY
	 S8NrDRY+wXp8u8T/Wb068uqTZuCVf+yHEhO3cAq21NfbobbaYTgr7LaXvYw+pWsIyB
	 4+WZZy7tjWQBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7286C812EF;
	Thu, 13 Aug 2026 17:28:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D34312B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9F2A4080A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOxUTykF3pZn for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0352340807
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0352340807
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0352340807
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:44 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ee4399c3abso117959a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642124; x=1787246924;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CSydjkAJEGfeSOBC8jpWokvFop8ElgM1ZQbeJeJoBiI=;
 b=fcnMX2ipiX4D3jx+WB9LNo/39FjCRGXoxtLts61C128X9X4cVHs9R6My/VrWLhyuZH
 H2vftVZ37dwOxA5cGgFDFYXX4irt5Fd4P9XbkJaZU+pJ94zU/NllBaRQkVgvVO+7wwLq
 ApQ9ws+wVVUzb5wYcKpb2pkVarL/XBEXz4spW1sb8IW9uCZIs235Hc66N76z0gH82pq0
 3rCGHkWCdNqMW7eqw9QpkBPrZgHkitzrs1xD+mJT/PplSHrIem/wg6WMrTvQoK8+vD2+
 /ofATg4hCBpWhCf7kUNzmbUWdLINtITv2l10TnQNjQQAvP7tFjjyUv2qj+hvEmQzUS+3
 IyOw==
X-Gm-Message-State: AOJu0Yzn43pgLkVTJYK4GxWeRBF+dFXwUBczrptXcGI3mXXb9lFQBLOx
 tpGV37164LReYu7x08BxxPBKRcQ5ZrZTadlLgcclOnduoBxXvkH2xupmev65ybsr4/4=
X-Gm-Gg: AR+sD12YhZBWMp9kPvKswGiaqdN/XBzEBh4UP5slYGsttiE+iLnXiZBVFZWoz54dh7G
 a6pqQaP0uhBo60Sulqi0zXLlTQXXJT2y7/IwhStKvdqfKpEgU8JAsQj2bba7yFQLRGkDuW+Pkwj
 0FIW6hNJ4xUN/dogJxJk5eH5lOa2hjnbAjrIvqcV6AYyqSTQLQ8Qhz6sGoNzAYAoaXIMBPZ1BSd
 OIQTl7r7evlrRQK5jk1fWGUn3hJfq4zIY47WAAjqewk52+vGBaLRoLMZHYhFl4Ki+BfyysHsy2l
 oYPEb2UY9vix5OfFXenlyi3jhMDuwObj2etewrCKZb6JAH8n2IXPOIQURLKWJ8LsISRWij1pdfy
 07UbtDetWWxlXQxMEHxIjRKn6UKxtM14t/zMM8vueTKfOA6efB+DF1loFbg1m4zTtzqnutjXLUu
 82VnY5LlKseH3BQsbjbTJgEWioMWX3+FKFo2F/VF+2xgw0QHIT9lKMDmBrQTyLlF0Dsdrsx6prD
 wACZWpmTYu01+uzGm+8sgvrUlXk9fn8CNgQqQMdVgICHAkrSoCVEsy5BjBeyfbdl0ar+zcfip/i
 yb+5nn39
X-Received: by 2002:a05:6820:61d:b0:6b0:4170:59ae with SMTP id
 006d021491bc7-6b0d68cc9c6mr45673eaf.27.1786642123862; 
 Thu, 13 Aug 2026 10:28:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c97sm2962754eaf.5.2026.08.13.10.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:28:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Anshul Dalal <anshuld@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260813-beagleplay_boot_failure_fix-v1-1-01d73d735cbb@ti.com>
References: <20260813-beagleplay_boot_failure_fix-v1-1-01d73d735cbb@ti.com>
Subject: Re: [PATCH main] arm: dts: k3-am625-beagleplay: add bootph tags to
 pmic regulators
Message-Id: <178664212301.3617045.15974183807335998958.b4-ty@konsulko.com>
Date: Thu, 13 Aug 2026 11:28:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786642124; x=1787246924;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CSydjkAJEGfeSOBC8jpWokvFop8ElgM1ZQbeJeJoBiI=;
 b=jM7t/NDeJ/K+c1YRzuD664Wu+99G1k0gZJ57y64rK2d0QZloDrleg61lM3HC2y8n97
 iCJ9Gt+YBXxChzttuIwr5UVH5tmE//lKtD/3yFdufjzC8J8b7UN/oj+9U5GJivrJ7KvO
 dxNFe+viYPP/zc0kiRzZ3CWtobyyoobkhUHMU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jM7t/NDe
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

On Thu, 13 Aug 2026 14:16:48 +0530, Anshul Dalal wrote:

> With commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators
> node is missing"), the driver requires the PMIC node to have regulator
> nodes.
> 
> Since we don't have bootph tags in the regulator child nodes, the
> resulting DTB doesn't have any regulator child nodes for the SPL phase
> leading to boot failures. Therefore this patch explicitly adds the
> bootph-all tag to all regulator nodes for the beagleplay.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: dts: k3-am625-beagleplay: add bootph tags to pmic regulators
      commit: 1262e50a34a0e01f974e8d909c5b255f8fa7199e
-- 
Tom


