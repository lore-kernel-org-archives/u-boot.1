Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570CC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34510407C1;
	Wed,  5 Aug 2026 21:25:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NwcRS848WMb; Wed,  5 Aug 2026 21:25:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95BDD407BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965139;
	bh=EpL9N0VP3WXQh5cYLeeHHuWpnLNrCPGh/10j9XZTKrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BE95nWd+U/4PON/sZcwEvOntKP0fat841xZ7vGm3kwugWDtbJ4US9n78i4WjCO1/N
	 sjnorJLZejlXD6KGPibAwL4Wk3POZYP68rnZAJIZ0Ca2eTLqnIKgi6n33RERGSQxdv
	 hXDg4T6j76indBHrvqjNYyR0VGErRwJnC06dkSTFuLgjoKoTC7GlRwJqIIBxxWskpX
	 bE70nlJUGNdHK2qsDTHIa2BbBya/6sS/T8GVa715sOXvNzUd2ghgVGGyATbHiYqAiX
	 XJ4Phmp9ZhmdVuPq8aP86b4Dnoe/CiiA14KGs5pvtrhBullDJtZJ0OWZq0bbttCeKv
	 Nn00667GTOpUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95BDD407BC;
	Wed,  5 Aug 2026 21:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DF5529C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FD4040244
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7u4250aGSvpj for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:25:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6D63D40243
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D63D40243
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D63D40243
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so2285089a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965135; cv=none;
 d=google.com; s=arc-20260327;
 b=n6GAYXUXf7EjDladdbiAFgvd6wbdt/wCaOKF1HPJ4v7jDZjqPwAX33WjIahuU6BlkG
 DYiryKx2lnH63uQ2fl4+DVnbqfBPAEYJHG7JmJDDs99/6Uta9EjqtLmPDM+bUqVTE/Yy
 iWZfO/JHpeLjcTtX4xOQPsevyYmoW265ZgFlyHkSTzvKdalNazT96wN+KGqw8/wMeqWy
 ywnt2a0ibqt0O3kbJ1R6Q5jlhfCA8UPsXyjGg+gE4dbxbZsv+RiNNdZhsr39JmOYx+P0
 COPLF1KgqzYsrDKrWYCPUX7o+3a8K3buNvIarTnhtaZ/AkyDO4Jw9alkpmFOrOwUiwSU
 tsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EpL9N0VP3WXQh5cYLeeHHuWpnLNrCPGh/10j9XZTKrg=;
 fh=JXrGXibZSSmYfVjv+TIq6uQdi4psc+yCstXCj2CuIhY=;
 b=ZXMznkiaAx8V62NoqApw3LTLMts8QQ37CcteGwEkXwKkzmLzMRwz74V1WQyQAiS3xH
 devACn8YPYo3EgSa6QclQXTQoDP0JPgVim1TuLqk7UWC9dzylhKqsn1lFScq0EFBcjxi
 NnI46iJrrjDQ5MtvVCBXsSGpnobkSRwlyQDbJZzDXQSR4gMo/YLXyjZOFo6AAJUShE0r
 4ISSlSPf1/1jfXV86lY4GNqrAdS4x91QV520FED5uERuksgKow33urGVzXjpoGkx6JOX
 YpuxQfr8qE7icBDs/rrTBnWRRY1UgOtYlv/1eT/WSA3X0t8ASnQSoxktkS3fu2B8PmYP
 HMNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965135; x=1786569935;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EpL9N0VP3WXQh5cYLeeHHuWpnLNrCPGh/10j9XZTKrg=;
 b=Ryd6mM+d+5rJYP9YAkEGb0xG/5/afDin+eB722CpU316nYbQ44QTBx8LPkA3EvgyP7
 SuDLV/UMTJ8HMXgODE0OlbuIip4zYl+NIaYzg2ayocoltKr84QEL7nKIFR5D3oPb6DCO
 hYL1KIkeRIV2LlW73yw2CFBbtkDAz41J3zacIFSoJicozfDuBFPUKw0nFJva9DOwbogv
 fkzQEHGCdb76g+5oIL97//NSkMIteCYXc4AY+2XMv8Ujt9w4kiL2sNbL7WoeTbJiW23x
 s3Bjz0IlSI4gBZf66D/yW8Fzw/zqeJc6vH3HVhbTFunLQFCIdkVuTaMvTlkLjpJFsLsk
 +Q2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvV8pxxfl/ZA3A4mFTmVbCcEmHT9ufaKRo51jR8pZF5F1d7LQt7YNc54xJXt4PSjydBNbNqEo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywj8rdmS3ZxNcQX2QLA/tp4Dspc5gXAujPdVBwe5SH9YO7idDh/
 HEPFVNQkK88xk2NACDb60hXIT2uxISPXASMYiYr6SpTkQ6bvTf9jC4KW/Z83T1dwWWUbf3Il1QE
 C0D6aBm0ACeW/J9XRnmL+Z+mrOJza48QdFMdS9ln6O9PZSNKMrQw=
X-Gm-Gg: AR+sD10N3ojAIPqK6VDXngQzrOerbui+CFMMEKjOP/SmSqvhnVvKKbsxWLYIyFzIiAW
 tSD9cugqTfLJ6YL9DDXyG+4JwC1sP3rVdjPNsQzaECIqowSzjvcGUZ0C1eFQO7ibuvY6PnPD3xG
 cEDn8z3opYlJtcHsJtD0ehuG8somK/rXIQT/OM1loNB3oPqjnOOkLyu9Rw425g/MlNUezDEvus1
 GsauaWuuz+IMTDq94U0x7dEr8vuj3Cyx3joj8MZj9o/nX3A9qSPM5OWmFTOY38B35YY25DJRfDG
 LgWAadc5BdO20JHy74ipd3YwtQH679ZUZ3Akmv20MIM=
X-Received: by 2002:a05:6402:5023:b0:699:12e8:1c54 with SMTP id
 4fb4d7f45d1cf-6a14f103f88mr5756045a12.5.1785965135376; Wed, 05 Aug 2026
 14:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <4cd5a494-93b1-4cfa-90d4-7965be37ecc9@gmail.com>
In-Reply-To: <4cd5a494-93b1-4cfa-90d4-7965be37ecc9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:19 -0600
X-Gm-Features: AUfX_mxrPyFjHLRSIQl3JJT_PISrp6UEe1be5ScEZkhIgT4MSG4cBX9Th4d0MaE
Message-ID: <CAFLszTgU+0Q198taE7Js=MxoX8WS0LTnhT1ihSSLbYLMtmMg_A@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] rockchip: tools: rksd: remove reference to
 README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965135; x=1786569935;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpL9N0VP3WXQh5cYLeeHHuWpnLNrCPGh/10j9XZTKrg=;
 b=Yvq4ILcJmvMUXaIEDuQxx+rA4n0QHzp0pf4CQ/mbe8Tp4AHUeoYuL0MdPvKKY49QIO
 Y7NsaGSpbKYkJd2+CDkBmsuE6yAcJUfn3HghqY73GXKFzI0FKQimwo/2raW0JsE0BE6Z
 LojTnB+MIlgf2Q/SBL4RpFyig9OnU2XnB4vg4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Yvq4ILcJ
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

On 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: tools: rksd: remove reference to README.rockchip
>
> README.rockchip must be removed.
> Remove the reference to README.rockchip in rksd.c
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> tools/rksd.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
