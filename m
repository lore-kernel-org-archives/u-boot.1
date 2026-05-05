Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003EFCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B595184954;
	Tue,  5 May 2026 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJjxumla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1409E8495E; Tue,  5 May 2026 16:14:32 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27D3848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ad135063so50550325e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990469; x=1778595269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KRRHj2ziTk3pBFo0IBBbLtwcMaJtURlE9Evd42Lva54=;
 b=eJjxumla16gg14a84cIVReZcuJ8uahrjxJKfBEWbABG+Fw1vXEzDmnNOqXcuiJ+PTc
 LzcANp6BOPDFCfT+jeM/NKzkYoUI5O4a5x9kjCNY/+hMiBZWsvcsuY64+2Ti2Cxe4Y0h
 zSD8ggIc5RC2pU/ZPE0DkRzYqgY4b/dkfOqTD9p+JiPiGp6phh5Lb7ikYC25m/b9M/ij
 91jnaLUX4+17iUpCtMDwoLZMWeUwf2LFMhjXXInCoTeaNqifD2MlIZ0vI2N0Hr9Baoln
 Hr/8LVTjUXuBa2SkZmhiVvQhJS1ht+t3R8rfKUSO+Fhgpbna1QpOYRXUiqOrIL/kYzM0
 cQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990469; x=1778595269;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KRRHj2ziTk3pBFo0IBBbLtwcMaJtURlE9Evd42Lva54=;
 b=QRKdkQhYJsVKTaK00Kr1cu9o9HaKXPJ1OzQxtAaPvxC78JtRc6oHCjYlsJcRfVFgLM
 9+FW0nYHCxOQe2nC6OHb9Wj4ua1gOx6dgWVjkDgJ8RDM3lXXIUtiJ67qrNR9b1w2FpMo
 4mNtBzmeOdBfERvbd3cLLDYVCTm9U1J09hEsCfy3aO2sqq1jLrYKqh+d84zXwg249LuC
 DOIjHjCEi7KtHvoht5uGemQULdO1DgfH01cMGUHZkcoc+2xVvB0D9tORXPGhJOPerfGS
 bE6cF2AvTyWsVoFSQ5p5tSQwGpzbr9tQ0/T8nUmhk8qHa92gilIc/QbyTPVKXIQ7UrnY
 L5pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y3MBqn7fuCeGLTigM+Pi0+6VFle+6rxCO0LCScLeyTpbibWV/cThnGx31RqbJ8qrcYjOC/fA=@lists.denx.de
X-Gm-Message-State: AOJu0YzuJ9c2zsqBgPbu8RMrYlhNdx+JwwGj2loqR5WsQyb6hLpotdwd
 hDHvgwSiQW0qtNFgV5Dr+OLkt2g3HwuuuIZpX60WLtDqrCM+CIUXGvPWnD9fB5psKwk=
X-Gm-Gg: AeBDietn9dk1COXvOQo5Y3n8dz1As0aoidJDjGhUr6V6XqEuQIZuRMWAxTFtDsrpf3W
 n7SLvK5n9JhYyexYcWXPO9P9GCt/Rulz78TsAuKbNR9OdWnIKey0sGzRCHVFnReABCB0nEH48mo
 IYqlTVgfh2GSPC+tkcmK0/6yCTFjKkpcCSHZ9tNPci6RYKy1etxUFkE71iQgmV9Y2jFatsJJpsc
 9MGLyci1HT9x7P0HM0EqSgSyXgy8crzgBfWfFgaYPnQDuN5kxyyDgV399dLvBWBV/gHbrXfDURG
 VTYTgEmqWdbUC+RYV8TR5np68Zrdlrubj0YUyr3SW6N+kXA9cSmoctY2Mx6z33nlJXJWlJttMA0
 skuOfZb7CL+JsvwDEB3VjfnYg2jRhd0FBUpywpA90X36jTy868vfOffLr6ID2cnn86w+Z8KUZxb
 w6Qv0Q//sx6iRqx5VlH4n+vI8/iGVKIT+EDZg6+PIw36OoL8S+6zkks3eQO8HJA+00tNe0DpiG8
 2khxgs=
X-Received: by 2002:a05:600c:16c9:b0:48d:35e:84a0 with SMTP id
 5b1f17b1804b1-48d035e84damr120522515e9.28.1777990469209; 
 Tue, 05 May 2026 07:14:29 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm581408135e9.0.2026.05.05.07.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:14:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 andrew.goodbody@linaro.org, quic_timple@quicinc.com, swboyd@chromium.org, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: Re: [PATCH v1] serial: msm-geni: configure RX watermark register
Message-Id: <177799046819.839461.5836925011780468566.b4-ty@b4>
Date: Tue, 05 May 2026 16:14:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Tue, 21 Apr 2026 10:15:55 +0530, Gurumoorthy Santhakumar wrote:
> The SE_GENI_RX_WATERMARK_REG was not being programmed in the RX
> setup paths. Set it to DEF_RX_WM (2) in qcom_geni_serial_start_rx(),
> msm_geni_serial_setup_rx() and _debug_uart_init() to align with the
> Linux kernel driver behaviour.
> 
> Without this, the RX FIFO watermark interrupt threshold is left at
> its hardware reset value, which may differ from the expected value
> and can cause RX data loss or missed watermark interrupts.
> 
> [...]

Applied, thanks!

[1/1] serial: msm-geni: configure RX watermark register
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5f171c622479

Best regards,
-- 
// Casey (she/they)


