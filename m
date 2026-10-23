Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E2606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rCPkdxu8;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fS/Jh2vJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 840F081467;
	Fri, 23 Oct 2026 13:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XHAFc2VVvWI; Fri, 23 Oct 2026 13:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF325814C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761164;
	b=p2zPkfJZBij+nXNX7eVkB0qHFuXrLWoP41MLARYM4zbHGJQoJm21Fg0dcfGbqlU6ge5B
	 nU3seyup/GbW5WMqP4bPV8fQZF61OWmCzqieGehXwXD2qKMvd6Om73RQPzF93EdrMDwgQ
	 9NVIGWnuWdFvF4xOGHwAf4zVwYglt9L3BbRu30WMQeT/jLMe+kZr02+UZs3YIGsbbczu3
	 8NERApvq9oGoVNBoH4NjOfvuaD+3v//lNxZRzU74VB6Nitlxl621M23VrFzCH8u4Rac3k
	 vlVJVfO5W7H9Zb4Bi4bdkrIyhjE94UnLGn074t2OjdP3E1q/UkrCfCOP/FLzDGf0YwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792761164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
	b=nEAK0PIRhqaPlvAga6/zA/tFO1Ex2ZSCIR5ttQX0qvMnu3hBwy3PvS1ETbxWj84uSIxZ
	 SwcL1nmj/Os0njYRUMKMvEmpznxNeJpA6xjkecyw9H2Xofy7OEqBWtt6KeJ4JxcqqHG2l
	 jGv0atb/lf1INBbvteonKz+d/YOGqkbkZ/0Ml+yllHe1UQfJv6N+LjooitT5dPn13Q19v
	 zrdGn46FauWsdjTbwYhiwuDC1dL9H9Av0ZHKG3Fl0HAGpBAMVzbwhBOX7bWWgCvP9If7k
	 Mhcp56jmog6xUXXzGCap4jyF+CpBqT65Eu7K+sVQlNHdYo0Lxg+JbHzxlhGxaqcqMsA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792761164;
	bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCPkdxu8OG1AZqMZb9Sn7w0spf4uqpASnpabaa/hjhW8D74IBsjsFCoHCMjxAGluj
	 c2/1EtXrEF9Cd5R+Okv1dUZBpr1Nccyv7ZCakUCO6nwovgcza3NNF03Wt/jVwNxeio
	 HEK6b7EKxumC4T5rE2a/aGkkiXbWpcHNSfA4BU45uWpxFRHj1hIJGdXvC3G5RTfu1t
	 mpWlPut/14WY12WiUMZylWFwoJ8BgJknq3sCHDkYKWfkKnsMu+ZQPnvY+gWPUaL1jp
	 gUxPzUJs1Q3h9prXbL2z9WbDFoXU8gvUfPsT5mOvR5ykCiDQc/RXH/ZBAhWWSQZ/YF
	 wB7Rx+c9pDE3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF325814C6;
	Fri, 23 Oct 2026 13:12:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64C24356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 474DE4099B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGpQs1_3muxP for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E92740928
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761161;
 b=B8/B1WcpS7Og3UVJSYJIkJeGY+DArUjejw6nhGMNbt4n5ozTnW5x2STtdtPKJLpr0Knm
 bO/n38dfPUPb6iZnxrPIGu0c18siTrpgI3PxAiv/l0g67KCWgtsxFwLhKM5rqud5l+jIw
 TJkvDenG7ImknRlPHnHUia5PmCd4rQ5fgQp39Xg9hdVQoEeP6+sme1PYK13upXibJdl3L
 2q+HLEmU5dh4RoHybjHr5m4JSJ/H0YZfB14ZSzPTodbNmw3gs9WW+s5vhacPlbtZYRjFn
 TJ/Czxj20oMHaPHcPykflOM76SX5Q03mdP3HHjrafIYGB6B9rM8LBvNQOUP5DqOtxkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761161;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
 b=M1zMqh8MXacSPEP8B4GryUm7fP/+9O1hw47xlllW2TMhZclrdOJmT7l8yKJlXUN/yqYb
 b6wXt9jkA6u2OVZv5QTUzer7s0NblFZtcCTQoVdd4DBoofAK5kUE998JTr51Txeo6xSnx
 4X8+rM5wqAnCfyeyrBIZVJ/I3mgRRpgwunlVGJWPsOZOW3ruzMqnkYDNEPxCvCZba60GU
 ZxnmHga3or24BMlRc5CCF69CJKX3+mYJgvme9I0CNYz58BdF57UcpJbQMaLDKPPoE9H7C
 nDBQsZRISRILu9WryXWZjkgGrLcDJHFozroiCREoPiFEhh7yXp6AIkgJk8twPCBHiPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="fS/Jh2vJ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fS/Jh2vJ
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E92740928
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:40 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so1333479a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761159; cv=none;
 d=google.com; s=arc-20260327;
 b=k2FytNxSdU2ZwlEXGCsJHC+wegQxpoxwPajvMcxQjFyj1lR+W7Vi16g8cAgWH0GyX1
 lfV5PMHtz3ZTYq2ExKlM9jE8Obu6tMPbolRs4pzCet8J8GWSSPah1BGuFDuAxxfL3Kds
 vR+nHj2nvcQ5aBd1IwgBExQVCBjyntXCLbEPz6c7V0/gyDrBaS9ZeUv75spsR6tzGN2M
 0R7CsO04uchVE778sorx51L9CfoaKHcu7skOROd37U6z3VViUVhB3fqfu+xual7Zdrya
 hL1KOj+SHDbW/qWHKxrG4YvBsS3CMplLzsNpYknpvHKtcDg4cIALeG5Re8al/hqWBrAJ
 RW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
 fh=1He7s4iVqtsmjXxhO4K3VWaYkG/rEZ77f1iESK+5+WE=;
 b=MDg2h9l6qH5HSA/SH9/96Bt2iVUHHN9qM4wWZVZpIVt0SVM5LLi3/1nMJm4hu3IVpB
 MREuvTs+g5I7tAt2K6+R0WJNPiPTks4DvUK2PAqIhu4oGbjQwfEhzVNaXxBPa98qkdHv
 0VbVm7GNlfXWmqkiFEEV/h0TZnSWPNuYrl5xhvD88QgcG9/dI1udTiV4b8tmYpY6x6KO
 m6gg366LLe9Ki+cyNEpVq91e/+/uu5cueZbt5yYa9g+dxtYg72KOvz4oemHuwn0TvgLk
 FvrhdIHc78gphLu8nregaFCutULNhKEYKJj5X+tAiDUXyZdbxMQylWnTQFrPCU8A9dvk
 enMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792761159; x=1793365959;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
 b=fS/Jh2vJlThsbhBQhNZlAlC2+kLeWdB28W46ieVSM7F3g7n3tDAR/Nj3mJ5g8gX6sE
 Kpua8odRqCiXLOJLUU31xur7uABMj176xwLizLI5DCcWHycSoSj5fpEblwBNX7Y4x396
 1iiACueS8pWLtmR4oEqwXlWlur6qHk+JAHQDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761159; x=1793365959;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dZnJDFNF9JQyGCbjq7IRbQNd97UXtzjMIg8Tsni8wtE=;
 b=a02gc0HGkH1J9WImL961b88HRztEadcsQ3SYltqcbzdNV0Coh13Rpw0NeEf23r++mD
 9oVZKZ3dS/CuJ558SEZg93OYbEKoYNcN0RR9TSXLT2Q1ChltgiLCMcR8h6jZ52PBtdUE
 pMhl/gc5cYmGaRnuwddx0lxWWBpWAXIQTT5XsJX6YksavlmQqvzQSe+2AKPCNtqT7oWB
 3oSQYIb5nAbxiZJF3Q3mJWE5VFEwoBHM1zUxLGPKYunHqyc5IZtRAez3FlNitCzkmdQE
 qnnHH9fd1J8of/du1b19HU3DoXsJ/O+YFz51I47MNkKe9UFU7SdQni+JBWNrTmEIkF6q
 e+HA==
X-Forwarded-Encrypted: i=1;
 AKwUvByVXk0FMSlr6lkPv7eTgDy9lmYAMKfMHKCTPDJ+qCl5+2J/TaCVrfRraaukcC5swLWIHSM7I5M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfraNUt2TOExu6rffjCxy5H3kRCJDJODbl97JoEXWmCYX02oYj
 KEFn2WJCp029emvkFfN8BX28/cegEd89421XDV3jJyPdesakGusTQd2crkmgGcU1kNw1UR5f0bW
 9bsSsDgdegW70G0W3X7429jLJMDF6wFjNpXaF2l8n
X-Gm-Gg: AYBFou0HPIoBFXtfBP8E4ltpOB+13s7WMH/+txEyPdfQqlyk/sy4L0XQrzVkFYBUBqj
 lD+NVaPyGtIMJ3AhYIKJLKnyPrQTPxToA/NZtCEHPg1Yg0R19ZY7HyB5DxshL3oxxC0k0tDxBLG
 o/PSVZw2KS4KOAnd1ljSBYFQvMI5jBohiQbNFV4iW2+8b+X4t7Fc2vtxEf79j3N7n6acdkSOjpF
 9cZM47ZssizAUM9eY9pjbQWfQZqqCzGzD5uimV2BNWEy6SnlIdSPWZrlBjYKteGXkcqfNPyMYdH
 FAi2Sli3r8JYGHdw4gsVSxdj1asQV+sIZQEczcJJU6+ukssIA5tYmeHReczi18N0k4KAwp5o7jF
 7xFWIl13qyTx9jfw43frvY1wlyyW28wv0k1Y=
X-Received: by 2002:a05:6402:14cc:b0:6b3:e0f8:4016 with SMTP id
 4fb4d7f45d1cf-6b432b2290fmr2553040a12.6.1792761158727; Fri, 23 Oct 2026
 06:12:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 06:12:35 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:55:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022194049.670889-7-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 06:12:35 -0700
X-Gm-Features: AclHuK_KkO6ZbMKZ2d3R42i8kCbaLO5u8_8s4Oz-CtEjfLULxVH_QQaweyqDjBs
Message-ID: <CAFLszTipBYUZf9+24a6wXY0WCs_pmLO-MfX2ozbvgp8EYwX8nQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] doc: dtbinding: Update documentation for Generic
 Firmware loader
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> doc: dtbinding: Update documentation for Generic Firmware loader
>
> Update documentation for Generic Firmware loader to YAML schema,
> generalize it from FS specific and add new property and example
> for FIP loader.
>
> Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
> property.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  doc/device-tree-bindings/misc/fs_loader.txt  |  48 ----------
>  doc/device-tree-bindings/misc/fw_loader.yaml | 126 +++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+), 48 deletions(-)

> diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
> @@ -0,0 +1,126 @@
> +  mtdpart:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Specifies the MTD partition from which the image is loaded.
> +      Required for MTD and UBI devices.

Both loaders only look at mtdpart when ubivol is also set
(plat->mtdpart && plat->ubivol in fs_loader.c and fip_loader.c), so
there is no MTD-only path. Please can you say 'Required for UBI
devices' here, and make ubivol required alongside mtdpart in the
schema? The 'MTD/UBI storage' wording in the top-level description has
the same problem.

> diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
> @@ -0,0 +1,126 @@
> +oneOf:
> +  - required:
> +      - phandlepart
> +
> +    properties:
> +      mtdpart: false
> +
> +  - required:
> +      - mtdpart
> +
> +    properties:
> +      phandlepart: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: u-boot,fs-loader
> +    then:
> +      properties:
> +        partoffset: false
> +
> +  - if:
> +      required:
> +        - phandlepart
> +    then:
> +      properties:
> +        mtdpart: false
> +
> +        ubivol: false
> +
> +  - if:
> +      required:
> +        - mtdpart
> +    then:
> +      properties:
> +        phandlepart: false

The second and third allOf entries repeat the oneOf. The third adds
nothing and the second only adds 'ubivol: false'. I suggest putting it
all in the oneOf, along these lines:

    oneOf:
      - required:
          - phandlepart
        properties:
          mtdpart: false
          ubivol: false
      - required:
          - mtdpart
          - ubivol
        properties:
          phandlepart: false

and keeping only the partoffset rule in the allOf list. What do you think?

Regards,
Simon
