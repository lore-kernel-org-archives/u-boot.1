Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BD606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EnlI1W2/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sVh3CuKs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9F040846;
	Tue, 17 Nov 2026 13:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJ3f5sFfbghb; Tue, 17 Nov 2026 13:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8225040840
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794921803;
	b=T+PmEfJ8lw8WfetTBDdops/UNRJByzXaHigqjktmHyc7UuWR55eJnU6ytrp7inFDc332
	 pnBHnpkJdQVnlmIx2cgvmiAfg4ESCdQPzcabXXMEISkfAE+iXf5W0DXOFDZmBJBRybj6q
	 o60bER832Jo/rG/B8XUN6qcz2+q0zsMFPqgm13fql8OTaVUHu/LahYHLA9jSFowTgnfrr
	 bRPY6x1rLWtIfgvm7IPTswCnkpO3sy5NnUPyfynlu3FVNJBQHRg/JkpaPuWjCgKQ7r7gJ
	 vjo/YeVxTOekbu2ilI6og2Cnk3Pgq3N/NMEvP/HjEkjV/MJJ93ya1j7I8pN/gs4jdMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794921803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+UXNBTCQ+maudYCzHmre+fap1RhlPWuUt5mGTfyEHwM=;
	b=sIXIodzCgzK2UQg73109ZMN/6NLaa9WNDIgj1q2WQ1Z0tkVWzl9nOestUVznMB3aej/p
	 lUPrGAwG+R7kfWKsuvFlpawlySslYLWi8lduPH03aE3cauwG6gd1OdX9YGh/LyW0UzulD
	 AAO0KixI4WB+gD/oclM7stk3um+ixbRsSKPXiPpfoiQeueN5ETZprQbN9LJ7zxzKkPMEb
	 j2WoG58zhzlywwJad1Sp6zz6VohSSAd3/Z0ATZEA/YSBR83mjG4rDI9ybSLC8wKQJbSaK
	 c1aAMdXY2Si+9dgUiItBkXcia/fJB3cXqRyMU8IEKENFXlpOqDqsHWkFvqWh5t5JaIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sVh3CuKs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794921803;
	bh=+UXNBTCQ+maudYCzHmre+fap1RhlPWuUt5mGTfyEHwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EnlI1W2/l7OwRznYKopE6s0q3jA2ux+MyAEZxTHYuFWDldrSbkU5sxHqVCT1czBZN
	 5o/I7bP7y7hrtocVtnnuG99LRTGjSna6SITAxNJCRSnaAgxCT2go9UA8K34ltbxiEB
	 SGwGM+ydKSBsBdgyCxoqWmsthu8JOk2M5vksMnarqXz3vc4W4814swFMzUeSfcNi3w
	 jk+uVxDYbuTA42qFGGxRyrC+W4YuzWQQ2FyKzgWY7NfD+Wx8xEp9ifFqRk3/RZ7rHd
	 ZtdyoupVd+dUSS2IJkvpLm8smk2bIRxshnFtsoncv7pXgrj/JkwRpgxrHB5yCLLCj/
	 vLv3IIJrTITuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8225040840;
	Tue, 17 Nov 2026 13:23:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 977872FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88AD54083E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49u1YLyQJYsi for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:23:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5495040815
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sVh3CuKs
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5495040815
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:23:19 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso848352d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794921798; x=1795526598;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+UXNBTCQ+maudYCzHmre+fap1RhlPWuUt5mGTfyEHwM=;
 b=sVh3CuKsxq9rNzpS9AgvZSZlPMbGf/qCakskE+naZZaV1kkAvpSozWoIwMak1b17hT
 cpgIX9ok4IMavku3QBBffnxlLZUR6tPmbJO2TRgPVQJfGGa8ajMDJR/PR9cqgMEok6Cb
 l6l/dCIa5o5dzYmAWPjujxP+BhChReuARvSGqcSlfata506HNybUGxQAFzkaEF9do0ht
 S1coPGvKggLSddpjUOWYz4IjX1zI7sIut/0KmE/8BdDq6HKY1uEAyQcSMCimEVkPd1DE
 pUXH/DAiXSh2rG9AVMzqhxpXp8MaWBwbsl/0vjPDMzUxQRwSMZoPTupi9PadnBst7RSl
 CgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794921798; x=1795526598;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+UXNBTCQ+maudYCzHmre+fap1RhlPWuUt5mGTfyEHwM=;
 b=QXtFOdGWxmHOQYroofDfSZ0WEHOdplH27HJLSC8tuDKPa1SqBP/Bb4BMGsCugELJdP
 D5j+gYygiBDckgDm+6B4pPjpVbdhYqHogwzqc2pgNXgeATMbL9aDwT7uy1DDk92lJN1+
 j7oIV8ZoC4prDmjCwmegkbmlD6qbXVI+6A48xat6Mvry8pKVO0p365dmM8EKAInAZYyA
 4CMWAmsWmaf7jGe+Sohx84TvF+Ipakup2GmFtJgLMoKAIzI9zpHpiVIMJDkhwViqGOZZ
 FvphFowW3Qr/ugwkkVrxyOtlmU6txnTb6J+v7EY6P60XfcBmiDLY0ndGyEVcrvZ/nyqp
 i3Lw==
X-Forwarded-Encrypted: i=1;
 AL+hErHLTj4rOY7guP5UIcaofCKyRPX+dq0xXjAxNxqK7++/fgGrqfEPG1PgNA99cIdVEK5aV3/PkwE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9JngcEqgBTtp8lBJDUd1UKRrkk5qeV9ufQXcrfgYsa1h9UKcm6
 9OvlhlsRCmBT5mn8mqnA2uRl3Na69vfIHs8k2h9c0/6qY26Yo8MSoUAbt7cQ9JeuGBk+yebNLQ0
 a6vTbAgGWLBdeRa/Di8A3PJiDZ9Ydzddupj+jaZFvU1wl0zN0LtOnHLZ2Zw==
X-Gm-Gg: AZFdTZeUBN8YHhCaeoNPwKLBMK1HYMSlQ7HbuAbHvlMoYPWle83efrbmwCA35JVYL20
 OwRwCgPgclmQlJUW9NpeH0/tGcq9Eb/IkibEmsrGF6oq3BTfnTHPxplRTTxQhNwm4g45VKTLT9k
 20+R8YlkO5lMTZKuPNehZ8R7Z9SMZy0MqiuR4a9WmtAb6O4YxP8OdRPvTupUBRqg8L1MpuYEZqV
 2q117JVE5sO0zRzkBXLqEyM+Q+aQDc5V8sHBxE9IqL3iKJCJkebkv3VR1bKrFW89/lL93U6Et8v
 sXPwaxysPPQQ1z51oCxGuzE6DjcVuGcO+vU9Q46+LssinKwOjmYy5vyuqMCe46ekph9oPPWcdUk
 po4mYPzZtmi9wISYt6ZuHKUpONoki55mI6QjYL4WE/mgAAVo+pTPDihC0V9EwFXutvzZ21IAj4N
 wKcaPkYdBm6IF0nZkD265NUWka71tbpj6MyIvy4pLHASll7ur4PM+MgYSLtuAG3g3Ueu5kOP5Rj
 1cnf9Q/WBTjZHbwXexIfYbJ5JeztrvEEeIglMUa9Ev2fTM+ohXiwuiHQoxINiSYeKmmdvT3ZEds
 BnpxydLgcn6CkoSpALK5KGk2jyAEF7MrCC3jHR3OU6sbjf2Ds5R32lIWuMlrKB208Yx4dg68pcY
 HY1Oy29PENvUVdV26AeIbz4gA42kMv1N9sZQedfL5yga2HWLQqG1fsQM2rOO3artpQ08Tv/SDgK
 CGQy9Rm5MQxjW/ePdQuUHYVqE3TzKsJuIrw48Uqhq+ahb6N6clEiCwnqVLFcsJt+Xs5sat
X-Received: by 2002:a05:690e:128f:b0:66c:e21d:9ab7 with SMTP id
 956f58d0204a3-67dc7868d60mr1655221d50.12.1794921798257; Tue, 17 Nov 2026
 05:23:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
 <20261116-mtk-mt8189-tfa-fdt-v3-1-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-1-ca423d2d8038@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Nov 2026 15:22:41 +0200
X-Gm-Features: AclHuK_tmVUCMPAiip32Qjpe9zgOKYqKo15U1ggEFV5YJlCuWE155POYHm-suyI
Message-ID: <CAC_iWj+nK-sJ_PGkQC=YAHDJuUaTOEP98383Vd8aBzd=M7m_Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] bloblist: limit BLOBLIST_PASSAGE_MANDATORY to
 U-Boot proper
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 00:33, David Lechner <dlechner@baylibre.com> wrote:
>
> Check BLOBLIST_PASSAGE_MANDATORY with CONFIG_IS_ENABLED() so that it only
> applies to U-Boot proper. It is part of the bloblist location choice for
> U-Boot proper, which has no SPL counterpart, but IS_ENABLED() made SPL
> require a devicetree in the incoming bloblist too. SPL uses its own
> devicetree when the bloblist has none, even when U-Boot proper must get
> its devicetree from the bloblist.
>
> Without an incoming bloblist, SPL now tries to set up its own one, as it
> does without BLOBLIST_PASSAGE_MANDATORY. This still fails unless
> BLOBLIST_SIZE is set, which defaults to 0 with
> BLOBLIST_PASSAGE_MANDATORY.
>
> Fixes: 03a76b1a737f ("bloblist: kconfig for mandatory incoming standard passage")
> Fixes: 179010694b30 ("lib/fdtdec.c: Disallow overriding BLOBLIST_PASSAGE_MANDATORY")
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  common/bloblist.c | 4 ++--
>  lib/fdtdec.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 3804f061f87..85138fe83f3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -613,7 +613,7 @@ bool bloblist_exists(void)
>          * If Firmware Handoff is mandatory but no transfer list is
>          * observed, report it as an error.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return false;
>
>         /*
> @@ -659,7 +659,7 @@ int bloblist_init(void)
>          * If Firmware Handoff is mandatory but no transfer list has been
>          * observed by fdtdec_setup, report it as an error.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return -ENOENT;
>
>         /*
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index d25535bf36c..e0b0d4e927d 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1849,7 +1849,7 @@ int fdtdec_setup(void)
>          * If we have bloblist being required to pass the FDT and we reach this
>          * point, we have a problem and must exit.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return ret;
>
>         /* Otherwise, the devicetree is typically appended to U-Boot */
>
> --
> 2.53.0
>
