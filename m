Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA877F3ED59
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 17:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD2B841C2;
	Sat, 11 Apr 2026 19:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SF1nV5XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C957384207; Sat, 11 Apr 2026 19:19:25 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3890A841C2
 for <u-boot+nodisclaimer@lists.denx.de>; Sat, 11 Apr 2026 19:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b980b35534eso425594766b.1
 for <u-boot+nodisclaimer@lists.denx.de>; Sat, 11 Apr 2026 10:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775927961; cv=none;
 d=google.com; s=arc-20240605;
 b=D6EhOeSIzU8zJ3ybu+y4A6Vv9J0Tqu9GLma15xbqhq3sdZ3D+FWzZxbUTC0eXleTKM
 9TEI9AXkvzw4aaVtBMHgVBI25w3kT9Tkda+gsPmNBjJZuNkX7QlmVCvipOkF7b/RiyxM
 ZYKrvLXFaFZUnw3Ux/2FWKy4KWHGBMfsk3CAU6cTPSr1HVWmmmZ7IaqiiT9qKB+yGJKk
 p4i52oUUeq86k/wq+BKLJ8ifWzkp555Q5/xujAWXnEjCMH+TQ8yVotQLg02pMoZ11pZH
 M9OLm+l2ExsP6Orr3Sj3nl27pE+NH+pSbmr6qc3qJzcBZK1H9d/94SR/WiWOK6EdurWa
 pqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zj94dTR2bGRumVHA1JuQFgdispP2wey8OR58JADO7PQ=;
 fh=2Ai/DF/OygrgX5KD/xptwaXayaptkAAlqyY5KCXDcm8=;
 b=Rn89Ra3BL1d7pj8rBj1sJjj0KaOVhJ19j6wxvSY8R52sj+jAp+B/xOi+cjEl3RVSZo
 nHdEKrepeWU5NWjUG9cswa0FwXEO20IBR1xbLBcwDgwN2w7MaxNtrrwdbgVEXmhEsb+U
 gFH1JLioiS48pPSYHOH0elKRqEbV+/QP+KwV/fRyucQ45e3OWb1tdXRx6yhyYNyR9zsZ
 QNe7K9UrOBxjb1HnOesd++GCf5HbKikUoT4TV7/CzaXtMzhj6g9MNSbIo7bojuvQw3mL
 8tmrLpl/pgtxY9ZmOjY88CEx8rFBaPCGkyV/zMdmUHpv1CbAnaNiXn5g28Q68T/Xs8LQ
 OmHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775927961; x=1776532761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zj94dTR2bGRumVHA1JuQFgdispP2wey8OR58JADO7PQ=;
 b=SF1nV5XG/+5XJ1jC6LBmn6mV5qq8z6PgjPrX0RL3s42tM7SkaU9zRifBUFHPY0iFLV
 RB9qOmAeF96TaAvDzqtaQA/gsC7cIlMAkdVXi13lPg6648stMCXPhAxS+tOoxGeihN4n
 gFT+bkxER3xWJtHvZ8eVnw4u/mxff8wKZP2DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775927961; x=1776532761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj94dTR2bGRumVHA1JuQFgdispP2wey8OR58JADO7PQ=;
 b=WvOKyqrFRPbN9PT10go3loxZ0QvjV36Puorm9PlFtxf92maVDdoc5+aLlceRQFYK/P
 zvvbmBWOsWFzcDaX2HWxHYRXlch52xiKmRn2i96wtbyxfbf0vb6i7vwtymyagyodNYWp
 OgGPzdqu/T9N92X2PNwh8jXGJ/Y0Pntu8//xt2lHATuU33eXrrRC12slQLdUt+EE8s9q
 cVlcXttbe8RuX/TJnGsgqwkGNbGYwLP/KBqWAIo4CpxBkzaSWzWe1IzxQ/wwNTigeP/e
 zndLsa+zBmMRS2Z2v/IGLspBE4LbiY040uCUSzpCV9oX2za3UzXRqP3ujkmGwopDiHCh
 zxHA==
X-Gm-Message-State: AOJu0Yx6OLGjGpM9tknWLGutV/a+MxH7rwoEtICss1H7CiwaMS/f9jcq
 130505s6Nbr2wsshp3eyVT9jXUm3c43O3dBq6iwQAS8szhSp8j+rDZkIqLMHk6s8wzh99q/Zxhi
 wV0XU46+iBblQZ6CN7uTnovlRaYzA5HHgrZCd3eSi
X-Gm-Gg: AeBDiesQkwzfPrJ/G9pT54YAwkWXRN4DB886jpcPp0srqwJiwPKG0WcUpdJRMr1Sknf
 DAp5sx8EDQLGLabiKSpRIRzZdeZy03jNGGcfH8oeK5ZGxhp9jjaiyIq7S7jw3rS3nY5i9Hw4dPF
 k7hYL2NnUyansZMY+QDI+iqRMufWoH+JP0uorF3AH+dR+tS87RgHm81KvaYZJ7v9xvZ4ecKfINS
 G6GI/YAs/RlcOqsLMGwbGQuuK9s7Ntm2ucEwQOF6S/KP03dB9nzM2Tpo9OP4ObKhMGjfBZzCo08
 08oPfw==
X-Received: by 2002:a17:907:c03:b0:b97:b149:4e72 with SMTP id
 a640c23a62f3a-b9d46267142mr594874566b.28.1775927961453; Sat, 11 Apr 2026
 10:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
 <20260408150201.217942-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20260408150201.217942-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 11:19:04 -0600
X-Gm-Features: AQROBzDMlTB0BFND_GluYw6rAS3KgMdi7iu5T-5sMrC6eqFhj6lYPzvWsL3xnHc
Message-ID: <CAFLszTg5buJdV3Ddj059z79qvWMh5uMU2mjvkjKWA+WnpB256Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] binman: Generate preload header and sign data only
 once
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-08T15:02:01, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> binman: Generate preload header and sign data only once
>
> To optimize preload generation, generate the header and signatures only
> after all data has been collected in ProcessContentsUpdate(). This
> avoids signing the data multiple times.
>
> Since header_size is known upfront (from __init__), create a placeholder
> in ObtainContents() to avoid an extra packing pass when
> ProcessContentsUpdate() detects a size change.
>
> This reduces unnecessary repacking and signing operations.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/etype/pre_load.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
