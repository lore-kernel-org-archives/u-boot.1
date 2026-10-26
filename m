Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CE606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I5vAt21o;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i1BA850r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 842BA406AF;
	Mon, 26 Oct 2026 12:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2FUcUTdjNEK; Mon, 26 Oct 2026 12:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3DBC40664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018254;
	b=qARlPYWT+2NuIKI94JxBvzUYCeyY/m3mH0KCztw+dYqTRXjeRN3MUULd4zmUZ3nSAiiv
	 +DqO7QQJUUIen5+BMQUOWDWQPtVlKOZ/6JRlawSs5Q9kfQnIYBpu+DQ1hBaENkUZnBoxq
	 GsIM+Uxnnf00SbMnH/PP2XB/oQ1BDDsvd66UTSItfag/sSBxeE6gLRbZiqnGVBOXu7CdV
	 KxToGLvjE+blq5ilSB0cj5IKyp3A8i3IxbKN25QeYeUtKP5vYCF7x3/VNt6FSBcS6/FZi
	 7J4s8Oy6Z6gQtJq+OrfAR3FnS/yYHQmVSv92Q20j98449wpDjuA9ihpkBeRBrxiR7gg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793018254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
	b=cAiisyIRD6NQFGiJFxwkIae7fDCrbIndTWdpYzfAnvV/xJwg8/ohJxvow2DXuzGGfzQ5
	 UV4U7jv/PSzz40p4AQVUjW/BgB0+plMizmJLbfw7J/NndlYy52Q/8S0myLH4iC4NCvwNb
	 /HV1i/Dmkyn+tzki/03uf/t/6CPNLs+UoL5sHnGxPdbh89JzMxdCNvF1KHnaFrnbd0a8o
	 0F952USfJBkHmzh9BxoS9E4+leWNMAHeV4xArXZ5RxdAYUfsHzPrjyCpR2vzOMspXwpp4
	 3HIzNfrh8OgUYgQVYsJv0aZkKj8VEjIzcAGu4KLNxXvB1kPMgI1p2gYrdvKUGhSnU7w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793018254;
	bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I5vAt21oWf8rLd6YzwKtojlRrRuxqg9rk+VtwnKXkxgZ7g29xjTY0l07im1EWYcs6
	 ak90EuN9dgCOtWbvi7nHw+dkpdJ6gElZkkq8loLoNOcxODVdtnQ9YPZRnzTDWqHc8Q
	 Iqj/hOEW9X8PUEIS8Gs2oIpcWq7xj6Ums3tUChNrpe0RjeQij4qbxkNSdaU2Ew8+06
	 wHcxsduIEsLLWyjlLDLFECMrgaHU3/TR0ejb9kvaStVi2uChDptozear9Y2iZFEcJE
	 uXCr4BfWwLXaGpy0X+T2zaerZMvMMQoFtgLZwPMTY6/1xwW+wX3EYXCBWnQ2r2EfmJ
	 zjSaRnsIRM1WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3DBC40664;
	Mon, 26 Oct 2026 12:37:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B437E356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A619540060
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lLn1PtNhO-e for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 08CE340062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018253;
 b=jo8UURUS4DO852i3VJvKVXOTYArHl+aDQfSddxlt/CmjMvjtJhTFlIVWR0iSbXvy3/uT
 7lr6NNlPcWNxMv8OryWJrSIadBiZ3q2+QQQlM9NIHNwKVkRsxlZlk37Jp8u5dz8mxp3aV
 ar0a/sM4Io/yL3iWGN2nkDTk44skJayM3w3nBJjWt7c4c5jYLJ+IPjKbvx3pUSWndIDux
 aWGCTScp8BnecTaj9WYO9Wm2hrSUNys5pGAlj70cqpSoEWvmOqulPKIsiKtRAejmHIvOa
 o75/f7YYmc0dXOVIrn6Yx0Ssk0xE0Th/DOp/eEki9KGB68klYUdff2fUa8vrMK6vVFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793018253;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
 b=MuGkjwu6x+5DkYALeetOMFMRoz1cuvErkBxh+fkjAOOL4mJ+mIKPLEdnhnhtANnLRiM6
 Oqo7noQW7clGtt5bG8HHTdHyooAvVJwlP+leohlt0/8C8UYcDYXdhKy+GESrkSDoeGDi0
 xyhIBJ/8ZfAqYvS4vtYk2+wh1fGaSeUpDd9yeRy0qd2mS2gUJUsygGcviTlPCVgjZnjqA
 xk6Ndv6sNqA/nCVUj0Ah9zYs4Q93t6LYF2J8vFtrhAbjVGSdU2mieCWtKXHtZFKudYD5g
 jvJFQV8XZgXtIrtgae9OTZnFQU155wymOt7ET3thJg0ePEak5yzyxhGvbhkWxnW53Ew==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i1BA850r; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i1BA850r
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08CE340062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:32 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so1503241a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018252; cv=none;
 d=google.com; s=arc-20260327;
 b=UUdimL4SM2Zk6VAcHtP+a7Hkv1FQC+vfhB7TLAzqKc6u2W77LOqInYlYZ7FEdE+kJQ
 QoOIAtdFff+dvWOkqaiU43llrt0if89szHMQisFJvMfsz8NyRnMBxUkEPKxijU6bERqh
 rHk/kgeyB37BA8h99yI8saOn4i7H9qAWOw1LgJOCabw97j84zy6QySNPH8gs6bFf9Wlm
 qILaNk81uFzkzxWP21ijnXCW6x9ys1NNmSgQw7EACww/+ZmgHOwvFPqnmGs1eDfb3Yud
 tD4bU/NfVmEvEm16Z5lB6Ile9ERMPCdFFcHVf/JWSKqPY4Ivaby0KCHzYMCEOta6uYym
 A0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
 fh=FJHtfabWMs4d8rRO/WbQ5Kz2/TtzvIGjjtKnU7zNY5E=;
 b=shGow7sre31FxfQnP0Y8GNNclny0Uhsw5ZEqCN5lriBVjYlcsJ8gVa2Q4azDsvtSbv
 LmEV8QgscZB2wONF2Z4ShnB0cdtRFZBSEn1HgHlCGiBRwKScTdhzqyTK8skBov7ain9k
 dr2tUuycmUFv2xTPZalUwNZfPx6oXf+0woSz1BBbBfUSj4zX4qp5ubiY3sm1/U2Lx7Jz
 1DpSEkVt/f+RDNl1qBNcbAHapzbqLrmPn2bZnQT+faaZ0sbHP40cmivSIp4stJuMvdrA
 3sSbhcvawHviYRHQktEyWBmP5zY5GVjkEuWjixZhzhQsKox7EcNFEQ+vxKKtBjc/+vrP
 b1Ug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793018252; x=1793623052;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
 b=i1BA850rM90nnQ1r8JA6KLHNYStfJOcFB0cDJFmSYuFSWeL5McVFmiaYw+xDSJhD+b
 OCOEA1RS23wsfqf8+TRJKtXyx2FLNqHzVvbOs49I9dOXBk84x21bGt8+0BnN3d8raFnV
 PdXKx8Xgh2DhEsMdZ+2ZLoAp2RsbvQZizLsgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793018252; x=1793623052;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jP57/hJzd8BS8QQggubYpq9jgnZQGGZEK4QS859+g2Q=;
 b=eTtKE8zS8vQe5UgUxYDYWwEG3xM1k0LypHqT8ezBwC/x/2CGMQh8A8C1svYYZ79Lm8
 uTG3pwvCne1fuLtLAQYqWU7DXErhSNBXzbI7uEtL7SN3cKdlT/r4WRj46Spj69lygFcA
 zKo7wB9AQSCh9q/thAQyzgJPhP/JWGusBpQ3QBOaFizWrjLb2CqKSTzhwSxpkyl8YrOQ
 3ljI8R0LJIVi06ujIWvsuyLZzgHepQv5GmT1cbXTSoxRwnSSVMA2ceP5Y2hqUxh1i8XM
 fNz8Oo2L/+TdMFUxE+cHdmJUmjY1eDFbHtW3n6sZdoEKMgL1ZE2tp4v01mNiT8eFYFId
 xxXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByw9RD9MmK5+icHMB721X9WSBzXELk5a0wcHVUJDRMW5jjGGDXvWUOqiSNwzkGtWGAy/IEHXvU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOtP76r0OtItXtfues4XPRpkx4uxOzOqJJEOK+jTpoaYDfQNlu
 ME9rAIm+2nFjxGNj0mXbVEfNtiPpkZFrdSILvqDmvvkcSsg+TrD78vFeS2WQSv7JIHs2Ku4AiVN
 60Yam4GuXO51bIP62U1E5qCc9Vk/RfpsEAl3cXXn3
X-Gm-Gg: AYBFou25E6ErH5OLzPgRFWDqrdhFE4WUf5Gu1R0oUDVPKLMTt95qUXJ5xdCgz4n3pMA
 pQKJiltEm+7WsvjUpGf9i92xODRSqISbloO9ygYidHgbFI2z7mV2V65oPSjm/xU1IeGOen2Owxq
 rK5FKJj6UWTOVRx1u18jBTYdb4Uusy5Grs73/jrgGRG0+FLelDdNpb/Y22hMYcGtlf1rRM0JnT6
 OGx+3R565/vRQgJSNCZ5YVIu4RDUFySrAQ3AY44NFi2kPyZH5y5DnJLLAXD8yFOYnc+UrXx/1lT
 vhBdyRxNQQvLTt9/B73CiuubkDuBkyqwwXicerAXVcBqDW3/TqfT3R6AwNuu5Ue1qelJHlTGTgZ
 /HP6v/3PABd3K5nlZEfaHW2RLpNEpHl4eLwc=
X-Received: by 2002:a17:90a:d010:b0:3ab:189b:6980 with SMTP id
 98e67ed59e1d1-3adeae6caf4mr5720449a91.39.1793018252161; Mon, 26 Oct 2026
 05:37:32 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:37:27 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:11:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-7-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 05:37:27 -0700
X-Gm-Features: AclHuK8RkGAtKF7STw5XW51N-HkjDvpBL2FOBFk-8dKl3vDvkMac7JfTcSGIaRs
Message-ID: <CAFLszTjZhHHCBzr4adkd6b15QXEh564UPUMcBRE+DWs=fXQ4dQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] doc: dtbinding: Update documentation for Generic
 Firmware loader
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
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
>  doc/device-tree-bindings/misc/fs_loader.txt  |  48 ------------
>  doc/device-tree-bindings/misc/fw_loader.yaml | 112 +++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 48 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
