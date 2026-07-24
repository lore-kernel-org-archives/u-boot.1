Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A99C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 15:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F29004097C;
	Fri, 24 Jul 2026 15:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTh__uIQZZy5; Fri, 24 Jul 2026 15:30:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12BDB40992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784907025;
	bh=0SaVsSN8ZVrzJFuUoc7NFcQgS6g4G+hzTa61D3y5oUc=;
	h=Date:To:From:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajynhV8GcDx16RYoCMXIIm4+FRn1LsKe2IS+uwiQ6lDO8c7Yncp2d8aii8k0OHDvH
	 feGeh2l1wJnKUaFrnMeFGsxGrzY5N6jIpqf9BSm/9kAUmMStp33mDRK3I2RPSVk81G
	 6rPgn+rpgxO2xxRdqNWni8vIFxrste6fUjqgqw4yuyRDi8MzskZ6tAvp2xdY9ZL+Wi
	 5x4DfoUPWb08DlXPs290M0vMxR+jfEEa2flcw0IIzSv2CD3nqHA/+LLTNqHF0+PvRY
	 1n8RGfEj96uMsPvqLZetd5H7s9uMJrJWLuV3okEGoCrxBpoWg2cg+e1FpCmGkS4+RP
	 /m9rEOxRkVpkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12BDB40992;
	Fri, 24 Jul 2026 15:30:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 559913B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B4E4400F8
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yly9mMaEGlRS for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 15:30:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E14AA400BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E14AA400BD
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E14AA400BD
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 15:30:21 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso5597865e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907019; x=1785511819;
 h=in-reply-to:references:subject:from:to:message-id:date:content-type
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0SaVsSN8ZVrzJFuUoc7NFcQgS6g4G+hzTa61D3y5oUc=;
 b=J7H8/8i03X4T2hIUKC0XkkcIyNHYtFKrF2l5+p28Dqqz9PWRlgj8sjDt9IZI4QWdsZ
 kQAVzhHl17aK/7QASDDgjsP7ICAQ1DtyWDDyqSJk9LAf4mdW+Uc2dkbEL7/jYkoK9wBl
 XN3L+cPhYyMV+eVrO9hmk+rpkQFhWKHXBj4ZPq8EejsDtFJ7x8qNCANWDY1NZ7JYC3Ci
 yCwdE7vm1n4sKmakSwJAfhSRbVkHkmz6KfjpvqkiLn8gJDxm9iTGyeMH/Y2Vl9bWtLzz
 QbTxrqdLNqP0qyRbqZ9r2vakdMHFOlEOodYknCXeHPy4VgoMQihEWyei+qgw6pSjQfeC
 XQuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOecIQaAx3NMgVmHexuU8Xn6fURa9zXjBzdgcgYwW7nwnF5q4dpbfGN26E8rBemsDm4hmxYlU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzMEy2nBZ4g/IeWjHL7H4F1JykKE5U7hNF+4l3Ju6gtBu12XBGY
 Jj8GqVLIHGawQNFf5yp8pehEyWlw7xsr27cfC1qfm7PqtCSZMdXX2Lrg4b6YtYR8ZgE=
X-Gm-Gg: AR+sD11XIZPnjU0qeZYGArN/szRAoTmN0Qil965yDER9+UxRyJ2+2/ONTfMviZNFo0G
 exp9toanBcFvl5IYmq2/h2oUIJqg1ubquvZ1O1SVL1K77zNA0cKr/OOMrypc2w16fvJLDRsgrr0
 hFVc6HPHNkjFtvg36+L7WQNbn7aa9D8HhcyeADy1WaOBXp6ibD9BVCEEtteJfz4ij4xCklFwopf
 mGRJdHd68A+CH97aTKVG5rzaZPK0tNK7rbuN+FX+s9hF3dMKiU0zF/GWJqgzZe43TngQbHYuWIn
 Sv9PsyS2FAlAC2FZwFz2R4xYHPKI9iiT33dE+EnstUXSdz3NyolETlAJ5Yzni71hRrmEcvzdcyn
 TG3j1Praks/jI/gyeQPpywHKNdGDXvb2Aq+nPF7d3/eHKH211TDQanN0Q0YJM8Vl3d3dWKvChRn
 Vc2+v5p4x0cgFrBwSry3YA03djiqtnkX/r7yDZ2FWsImK1iLS3Z5KDolWJ
X-Received: by 2002:a05:600c:5718:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-49573cd069bmr67245255e9.15.1784907019313; 
 Fri, 24 Jul 2026 08:30:19 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b429389dsm858265e9.9.2026.07.24.08.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:30:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 17:30:17 +0200
Message-Id: <DK6WQC5RS7VS.7LJNJHF6LZ2I@baylibre.com>
To: "Carlo Caione" <ccaione@baylibre.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <quentin.schulz@cherry.de>,
 <u-boot@lists.u-boot-project.org>, <dlechner@baylibre.com>,
 <jstephan@baylibre.com>, <GSS_MTK_Uboot_upstream@mediatek.com>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v2] fit: prefer the default configuration on best-match
 ties
X-Mailer: aerc 0.21.0
References: <20260709104940.75514-1-ccaione@baylibre.com>
In-Reply-To: <20260709104940.75514-1-ccaione@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784907019; x=1785511819;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:from:to:message-id:date:content-type
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0SaVsSN8ZVrzJFuUoc7NFcQgS6g4G+hzTa61D3y5oUc=;
 b=WCgezkXEMB88eEwXpzkU9Xm8DOwkzzFsTuirACch4VJj6R4v+AffptPJdAkKITf2Nz
 eMGFyU7taZdth0gvnTXePTU/BRB6RgWDQFhKOBYPw+J1yGrbUA6AzfMHbsDMpCMH2Rjf
 pU8U4opRmJr0cGeTlGd3/6AY3L2x+Nh+QajrybGdXWyKMqdTlZABx3TI7W/HuMgmcmhM
 gas4bTlMy/49QWL4tP1BbB+Bhzceh23HdBlybywPaa7vu6jChinpjNOGoJLS6FyX+zu8
 OXVO7ohCGjPlnJzYmbRFWnUFdCynY2jeostWaz6ROpg0r7JTm1PC2cUycM2CfTlOUY9C
 ejfQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WCgezkXE
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

On Thu Jul 9, 2026 at 12:48 PM CEST, Carlo Caione wrote:
> With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> configuration matching the most specific U-Boot compatible string; on
> equal matches the first listed configuration wins and the configurations
> node 'default' property is never consulted.
>
> A FIT whose configurations all share the same base devicetree compatible
> (e.g. one manifest carrying a base tree plus overlay combinations for a
> single board) therefore always boots the first configuration, silently
> ignoring the default chosen by the manifest author.
>
> Break score ties in favour of the default configuration. A strictly
> better compatible match still wins over it, and FITs without a default
> keep the current first-listed behaviour.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Hi Simon and Tom,
any chance you can pick this up for the next release?

Thanks,

--
Carlo Caione

