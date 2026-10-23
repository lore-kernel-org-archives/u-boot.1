Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o8z+mCBu;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IMrHBvIV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CB6C40722;
	Fri, 23 Oct 2026 13:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3XL98PebXIn; Fri, 23 Oct 2026 13:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFDD1406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760739;
	b=qqcjypZAwalWSo1YEwWrkVGiNI4Ut3IfrS8YNoRTw+CgNdjn8cYijL/ZIROqnJNJYDYq
	 DCZlu778Q57AS0Gw5sGHge5X53pfXervjsMhq1QVuPvCPFsUUxE8rC0HI1o5dq9lz3S8w
	 j2HcW0I0+bT4jJYiB0FRObNbVLDLgmL/mLNgcV97HiKYlJ0tzO3QXLK3bfAw0fXNbnaXg
	 cf9ScUUnr79RbMAr6/98+V4kPImCf2X+/nDqamrgtVFXMjZ/kJVvIAyI89RCnCKXOXoWK
	 MBDfDNBHnhbHZuS+lx1clP4oUEHPkcQBifN/qdwOHIB46PMPMEw010A2N2wJ/ErXrzg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792760739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
	b=FrGmSeTgP10+F4idKts/oblXukIO0VtOdthKh4qqqJAtXsD+xhpMfY/+w38BJXe5NDU4
	 mIHtJMod7EYCCmRDywxay+ekGjKhO7I902Tehtr3mKhdd6MJVggX/m4rouxulmx7RCFY7
	 wlD0lyvGsFDwgB1MJm3NIyzoBY6/WDhU+LPPMh4cbK+7x+hCceTn9nRqTW/vJ5cMtLpYd
	 RuRtheZ/EEaKOGf6puteJ+ICqfb5Nnm0eVF4shIi6I2Qd7R6UhbXaDOQVFQ2YAWhyf4bz
	 /noc2bzsRAfSTNZP5LPV+eva1a5yP5vjRKjZZAHqPxyf1dI6cKX89Vml/t+nXkptNBw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792760739;
	bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8z+mCBu8WGgbSVO2Y1r93Mt3/gpQL7UX365lv0bHIJ4/6qOd0wO4M4pvDlWWBpOH
	 5WxmcpAggijTq9aGlIOpp/coRXRd/cN0yPnNHE2vYNJvHHhWDRhw+yA8bNbcMn+2C5
	 KKctGvdmzfIZCnHqqCJYIda94bnMGNT4Y73SVzZX7OHB9xXvUNyDY6VQNebMGBdAtm
	 QnUKLiGlwVf5uF54xtJFG00usTl6XpF6m8x1MJg2OHOzEVGLq62lkbGCv1STHVrk5p
	 H16PLsgEo5Gz4dMJf1S4ZEv50HLTqB1g4Y8gEzA+/hMtPStmxJe6prr9ojYjxbrOlf
	 hyoJKv/yEE5zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFDD1406E6;
	Fri, 23 Oct 2026 13:05:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B25F9356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B008681092
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktml3Gb9dQdA for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBADA81027
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760738;
 b=DcieScLfwCo6+fjYgTZHaLw0r8RaIsbpESm7pfB2hmVNCmbScyw+Ifs+gOa8e3QzwdkH
 NSgczzZxg4Px0hAtrIGsJzJzF8fdZm8RD90xS+Ke+XEcfhv2/MUJMTsiYn+H5As0D8iQg
 6vO2ZTDCgcyd/knNXc9rql5nCdj9fvpynvN9zDuN4DQiTEgsdjAAJnqJBAOxRrvzOueQE
 X8uiFwgK+EINvRYGWT2QWv2TeJaGESxADFv7D/S5jXGLmQGCv//cdoeu8yfzP/eotWr3I
 FyPT1iIfhDNsECHrdAqvXbLe3v/Tx/z2sOaVvKf9DwQAAPYyAELvkXrl0zgKjKSALtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792760738;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
 b=SL1PgfVmPCP5qWW1tbZgT5sSZNT4OOQthgRd4epcOoyXbA5Lv+Nxg+eAkEKk5tI1/Km7
 cLVEVq42cokcJhc7jcWjm63tVuz4wIVKpRcnwAwjzOFSlRuZEgPvPe6faN2OSvp0JLu/v
 y3+Gdro1NQVLbL6CDvc6gB3qBIlaGt6x37/sszTHw+j/qyzykFUgV5+5rFI1YjXb+d3Pt
 IJBazC98hDkpUwrq/YRofBD4yyPwoiODPXA4Q0qZIHZLKwG1RswAH6+fTYt8+ZaKT865W
 YzBHN8kfV9bSBFsfNaN66lIYcdyHEV7B35nSDaxtYtgBbH5rtvgW1A1PHBuwiLTg5pA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IMrHBvIV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IMrHBvIV
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBADA81027
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:05:37 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1559713a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792760735; cv=none;
 d=google.com; s=arc-20260327;
 b=pzbbbyDHu57AwcGsI6kR1WYrn2ceI681MX9EFIpw/4COj/uO4iIEQ9eI18rBGF1CN5
 cuIrEmDtQKsmS+uD9vIWv1GitrlAtSc6qpiinceMvw8JEfZDmdZp8INPtGGHfXTbfmEV
 1H8p7is2CleQXPpEPEelR+r/tRyZYrzZx+QFn6LAlqSfcoWMcWT6I95fmf7EPA+JE0ij
 BPAN27DEkTlr2DFg5eGtZgbSMMwaehkzHZmnoWIAslrvov858Rkxxq22TeDBUZex5CLW
 wyS7nDoDGXOz6dzUnWWPEVfY+2NWGRrB12GvGNHonOcxMVYrFNiZ1vXp35HZm8Aaaz8b
 ZFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
 fh=vBw/8YJyCJewUJPrq3k97i4fyhxTPAHCrJ1eSb6J05k=;
 b=jgvaUjPRXwvrqxyfFDxt+vAH0NKcQuERyp0SGFIRpH90D/A6Bujw+jd1750wq3PyVR
 CAJeQjY+/tVXi4vfrgTIx0nqXb1hFHiRNGoiQV/CHBjdDeUkHFM0z2WySj7XO5NXb9Wt
 q5r4nPw2pgzujMp9vQJC69Cbh/OfOLD4DJku0jTrbFqb9IFaOnUR5YgZP/fHZb5OvIKT
 +iAx+Fk7peouCfXSMRMCVw2OzZ+XaPXaFealASYJDmy5ehwSjdG1x7Tz8vlTuRhOBVi+
 MT+7p+apzL7ZiimBQgjQ9ZR9r0Uwej4Yw3aLVlZrhe4Ifh0bRla6AFvbt8QfG1Wl4bmU
 4Q7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792760735; x=1793365535;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
 b=IMrHBvIVs1SQdrKrZuvYByj//aL2762tMmHmLT+SqXc535dToVt9nV6sEtpcb4P7Xo
 t+/5f3qL6YBNqoVXpv8vph9KgHK8p9nOYuPF0021omJPuKFLE2LCUXRbh3hQ+rb+3h0C
 ge9JM/jM4F96pITavH11Xh/tWJXZ00ScZCwD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792760735; x=1793365535;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8w3j0B0br784qiQ4g0omZ9EUdQ+L7QjJ0mxLjNbF1R8=;
 b=unJrqiLZ362AjVxO0U3r+jOp//EMDPYyoNH1rvHLBvdkWdq3+q3E7pr1iGD1Xbyoet
 XUNOXX3cE5HP3HluNlI9hOmnGT/X7v8D0wNSVuc4Vq0GQAJObMMHcKRFDzzTqllQuxmr
 nrQUcCU0xJBwzCMmDkD0uaNCvSU1gtZ5Wb0dIryeFB7d9+PQpwRSwnO57q/WV7pISTn4
 HoBGBnd5KLG1fNOsAbTMHOAyGyxdDsCtMN6v0XsnjprAHLfpHhRwboMQK/2f27T96xTZ
 bb/vslZPK2TVV6Xy9SQStIRBwVBdF+x8Vt6RfHBVuITMQuxAhy95kZSY2xxHBPEwwsXr
 IsWA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBvHEzCuF046kDo1wjJsbj1mXr/TpGpGv4Jo8lPFhr/wSRSwoC0jaw5cwQhgoxjNa0atzjsKo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLovOumfvnHsoeThE3XnagELFpatAUggVL/OqIQV5ObtdcbTVMv
 KdT96kgaFS98qihiMVgNB5IPwQGQJOGAaO4r/2OkE/7Gk1/Y9/VkmtPa/sLpCt6w6Qz6VsCW1iq
 yfNu0NWCMttPkspZnnukR6A4ism4cWrF0Tu2GFIXA
X-Gm-Gg: AYBFou2XPLWca8SZkzw/d8tuaqo3Qzk2WjN9Rn8WX0fRUSo1VKOYoxX6KZQzVOlt4gZ
 KHXCiMUX8hRwHc7rm1glqUyiBTXaEcsZLPre4rLv933GpSKFmLiuKt4K4H5RS2jBgoEVsEI7Ay0
 xra2p14BRL77bjuD0ingxV0bVpREGPHnqXlYtiadrxb7F+cbINJIE0RUKGLhhjLNlKk84I4Evrp
 pXCU84ORYYIlED64GxTri5i9Ah6bjBDPNW83O9/t2L2M1GzNEaFHL0CpOmGciXSymH/JKg9cgJy
 73ggY1V9NzRsHIeA6JUJjqx2Nt1yFOuMpKy6NcMpSqnxj1YskzjTlPK6qfQYhjQh/83Okt4ahr8
 oCrYj+taGNAa7vhT08ePDvDdV1t6tl2Oc8jQ=
X-Received: by 2002:aa7:da0a:0:b0:6a9:9a0e:e05f with SMTP id
 4fb4d7f45d1cf-6b41d55805fmr5579774a12.2.1792760734993; Fri, 23 Oct 2026
 06:05:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:05:33 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 09:04:51 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022101558.2474326-2-msp@baylibre.com>
References: <20261022101558.2474326-2-msp@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 13:05:33 +0000
X-Gm-Features: AclHuK8UL_KEpN6dyTTQnTvxVpcLdHzaFQe51mg6Pxx2cJUJddsG53_2ONVbamk
Message-ID: <CAFLszTgk_Eoozf327QTbYV_jvj9dRyghLbnYsegB_Mq5b1JhsA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dm: core: Add SPL_DM_EVENT
To: msp@baylibre.com
Cc: "Kumar, Udit" <u-kumar1@ti.com>,
 Richard GENOUD <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Markus,

On 2026-10-22T10:15:56, Markus Schneider-Pargmann <msp@baylibre.com> wrote:
> dm: core: Add SPL_DM_EVENT
>
> Add an option to allow DM_EVENT in SPL.

Please can you give the reason here: K3 needs to run code from
EVT_DM_POST_INIT_F in SPL, before anything is probed. It would also be
worth noting that this makes device_notify() send probe/remove events
for every device in SPL, not just the post-init event.

> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> @@ -117,6 +117,16 @@ config DM_EVENT
> +config SPL_DM_EVENT
> +	bool
> +	depends on SPL_DM
> +	select SPL_EVENT

SPL_EVENT is inside the 'if EVENT' block in common/Kconfig, so a board
selecting SPL_DM_EVENT without EVENT gets an unmet-dependency warning
and SPL_EVENT is forced on anyway. This is fine for j722s, which
already enables EVENT, but please can you add 'depends on SPL_DM &&
EVENT' so it works for other boards too?

Regards,
Simon
