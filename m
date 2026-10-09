Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD9CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CC47608C0;
	Fri,  9 Oct 2026 17:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CW9qBStOq4S7; Fri,  9 Oct 2026 17:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B48B9607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565931;
	b=pyJngo9HNFOG4OiGwTsBYs9b0BFVSBgEQhIEi2CB7zHQuPPnLAQ12ercpoxTSaOwnUvL
	 JXsh66WZami6i7Pd87kK6qWYDBlUPWV6NtFkV48BdjKcuYvexYwfMw5kjP70LCBxzwRua
	 IX7L6fZ2ewk3myxyzJi31ile8JVRI6nO2hAT55ISUm+3r34VtU+XPjDXIuLqHeyxH1iaY
	 C1Vtxdps4t0BnjERECDXp3YxKJ0jpeu5NZ+wskNDee4ocnPtoTvICD6AZcuPkzmM4NH0i
	 mXKGFn35Z2b7wJlV5Qg6ylMCYxg5LV3WuFhcLBxd3Jg6APcSGv9jZhEKC28Mpe/ugvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jdBZqE7SSsTQ8fFEiPe1m+DA4FmLhY8zIhk0QkSxDtw=;
	b=XxUCful/Yky8lHXxl6BhEAU//AZz6oyTxE0aEhdxX4g0SwK7DCTvMM8GbQAk23R78nl+
	 +35+SSKvrYA2iGmcYTqvgtbUZwGHkZV1O3nUkX/grkcHuL0pYxnb9EyOp/f8RDXTg83U8
	 9Q2f2OTrwn8dGF8PqgvrALrICl3hhjoT9G3xELV0qOxx4GDMiAFYmdFQFrwAfzE1iuzhC
	 cQEjWquLR48Af0cFu5FPyHlai7FQu0rWvN9dIY1JsO9tsv1mjIc49gh/qya+VMDs2ncQL
	 r4PFmiagswL1O9TWOiTd+SMC1cSQ2YcI2GtSjfZ1GtRUGTZIwcEZwxhLyxZbYG7uGvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JUn0qaBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565931;
	bh=jdBZqE7SSsTQ8fFEiPe1m+DA4FmLhY8zIhk0QkSxDtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hVqizWFGTVxRHP0jnKScsOThW1egNd9MWtrxF8hy4dWa6dosdX7kuyLeffq/NrHlF
	 DK6PTPLTw+a74MU+kp/ZGCmBJYBYGmTR9sF4BcJSsbWgspc0h32DmuogNY9a/g6/p3
	 9aTnOYxZVz0XJaMwI01H3EyLuyelCsTOlj0i4EFP3sm9u26iGZbB/ZhmWuhYXCWguR
	 4XAo2G0+u0i+R4ZmmM5v5L06Q7hI5WS03+VWx3zNMSbaqEr92FQy7UOfP16ech/qcM
	 CpJOcldRDKTxya7AoNUoI7DmDTo1TEY51k1S6v/YeTgHjuVB83Oi7cRGmotknZ02Du
	 wKRXnEFs7Sy3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48B9607B2;
	Fri,  9 Oct 2026 17:12:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74C6BA14
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 693EE607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAiXtk-3b7uU for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5CAC60727
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791565930;
 b=DbZvvXqnZ225VjzTPXZAzaVuFJqOuG6+bG68+vdjSdag4vqm3ixwaW1Dui+G/VmKUaFm
 7X30PijkyBlN0sY4XYtSgnnTQzNrdUUozNxTkXwkNf4T1ZcCDNNg0t+/id+08160Nwcki
 DsyM2wc5UPdJomlE4BHzxBdO0uukJ8nGs2mb1RpuoAs+iM53iJTBfvP6dA4qHa/AKJtUM
 rg4obwl4UWHY6KeoZeXAoZ6WkLcb9uC59xaPZBKe8eX37m84kYcf4idlbWmtm//yJ5NgD
 DT8uUHL884Lyh7KPyaqxGR5/fl/9lu2x0+Z1sMrz2ngbUt+4UAAMmbIXtsyNQC3XC5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=jdBZqE7SSsTQ8fFEiPe1m+DA4FmLhY8zIhk0QkSxDtw=;
 b=BLWOXzmhRRGrt8Dn1tRY+iIf/Hz5I5/oH7JgDB7c2odFI/BLFjDMZS2rnioc7/aU2LeU
 oz9FC1HTiL9GRK2ZGWX18rUq6RAZ5a4fB+kkDda7PF/hqoBAhfXYBFVKBsW4M47LwdarS
 BT8nh2LdpweYdw+bEZ0mFFDhC7NWgvQFhp4tVIZ9Ipmf3xZ0sfLMth9wZFwKiWTo05rjr
 Mukahw9iufDjqvidWQmW8jOlTdx5DiwI6+UBkUsQYGe12mo0E07N41Zx9/8LR4T0ieiRr
 3bHB6U6Icq9Y8Zl3iW8An7voVmnVVVRZJRykR/zujTxw9MUgfxM5KWJZjHy3WV5EEIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JUn0qaBY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JUn0qaBY
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5CAC60727
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:12:07 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-824329dc1ecso26853a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791565926; x=1792170726;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jdBZqE7SSsTQ8fFEiPe1m+DA4FmLhY8zIhk0QkSxDtw=;
 b=JUn0qaBYiW5SKHJ1Wwl8B4Kr40JDeFpB9B0p6e8ABP0w5qy3b0Xmto9lr4UgLkjVUS
 fDIQRiT65OCutAXRpXDYbMUAHU6y2Qn0+wPuH/hmQElsfCnDZCdF6xeO+ofZyDb3rLSG
 FKXOdwpkO9yLJ30IfS51zcMvCy0IH4s11vycDeA4lgoRqpc9LTKnH7C8XTvurCUtGlG+
 VdtwBmIQI1yLwc5A7zq0ElQU0JP/30g5xWVZ+ke2ceU/rDUa9DuQHo9pJ7ruppV4Dh8e
 LAD2Fp6MK3vMBkDnGerdmneAUNKj0a1jtMel+T5cN5BQfJX1Q+7WRvAe09+oweeo0H9N
 wxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791565926; x=1792170726;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdBZqE7SSsTQ8fFEiPe1m+DA4FmLhY8zIhk0QkSxDtw=;
 b=Te5p6gE5a1o7iccfosHkQOMan4UhOhXlf/h+Ic+Lx8U/DGt/BOVQ4olvn/vUtC1gDu
 zQC4xurl2Vtu2BkGzhYdeQlTigqlUEfwBfoER/rkGK5B4Ic2rV1Q2u4itcGqLwCofC+d
 Xu7HA3y0gOXkAmfCFZlB/sMhZUsx6Dhco7wBHjHizvJBh7f5+JmbxvKgTI67fs7R5yDv
 pQ7cC8lVePZcViebeFKpk0S8HjltPKxvuI9yMSNV+hy9d3FfzN3Kyy76zmxGHzg5l2ZL
 Xu8hVU7rFPc97T+0Ol5kPWnKuoNtLIwShDTp1wSg60NrzUt3wTcIvFwtnx7jrZxhqsoT
 +OXg==
X-Gm-Message-State: AFuF++n1wyAAAmkuVzL00sVRvD6wQP0q4USkfNFlK9FpUjF8n8NKZfkG
 LanbebkzYQzm6GuZ+crnE4hMmoE/6KAUoVe24srPe/zzPrwaLgodGptVLk/yMfXrwnnt3vp+9zY
 nCKh4
X-Gm-Gg: AYBFou3c29tWChBp9zDYFMWj3F5MHKNZ7fwVKJlKIayzjXaAop2JmrkKO4E5Il2lti/
 rUhBcZsED+NIqhl5D7jSyHfy8RgDNZyU9jPaA+zZO7NvXw9Lc+rRDQPX99b27FsmwrpG9G+GHLT
 6FPHdfnx4visUS6HtIntxwIO22GjR6qF7x9DoLIbPO9qmZ3+2cFE/gm+H8JZ4lUphzU2P3cQULD
 m1adsmckCNaxEUcj5eQuQ6TbGTaJzMsmwWxJXsJikL/+xOThBPjNUkIe0nu2vnl+dKh0h/5guUQ
 T47+7ZZ/4I5RekLM2qwpoUUhSGbEgkTLsHB5J5LAjb2akJiOXV2ksL7ojZzMmzybDpnQrp/WKIA
 wJ1Da/OVVptCeGD7+WNclGypPjWDXZyUG6aKQk7yTlwKL+CtGZKLIIn0GQolqTVCZ1JpAQdeQOP
 oiEzE6pa+JdGML1JMfpfLT2yizyIu385q3LEGHNTgWNLpZohzdbAVJIAu6F+iD/jZRPEgDTSu4f
 PY=
X-Received: by 2002:a05:6830:700f:b0:812:b45f:6547 with SMTP id
 46e09a7af769-830968d71f0mr2168940a34.19.1791565909198; 
 Fri, 09 Oct 2026 10:11:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303a328ee6sm2371959a34.23.2026.10.09.10.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:11:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@nabladev.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
References: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8189: match the mmsys compatible
Message-Id: <179156589636.1248553.16710183259750578960.b4-ty@b4>
Date: Fri, 09 Oct 2026 12:11:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=328; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Pums+Kb3WpgBqSAPRyIyuifxwU0slPhoSmCSB1AJq+8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqySBKaRvT7+hsciihi0pUTXcIwNcSjEsaqSLfl
 fb1Q8Kmf0yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskgShYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJu0IAIwGmuS9TcTiqAkOgVPMHOypI8Wz1PLfsD7XWZy
 Vqw0g8YRy/vc9HTixXpz4GOwCJjDg6vmx70ACgA1dvvpVe5WwMF5BjIvuYvGBZkQ/A65PAPVvFu
 2jvN96SXtNE9lYuHjjqpz4R5QZrr2NForSgMCusoDAufHb7FWQDdyUVv7PkDMrxO9mLol1HlTMz
 YPhiKEkEcYIy19lvxe7xMAXuLf+XB9p3+2IPJJwWUPzJcLxRZ/xdZvPGv+M32hz2CgcLOVB09Wb
 lP5z0qDsnfJsjou06EO3hY2LXwc+hTfEpFVeCxnOP3NlU7oOTEVZThvr9f4x2Fhu1ap+RAu5QCt
 rGbs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 24 Sep 2026 07:54:12 -0500, David Lechner wrote:
> clk: mediatek: mt8189: match the mmsys compatible

Applied to mediatek-for-main, thanks!

[1/1] clk: mediatek: mt8189: match the mmsys compatible
      commit: a560a142c0759959518532d41106e4f3f1ea3c8f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

