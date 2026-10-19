Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE321606A31A
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pg2Ynvjl;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TjEwPEx0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85C4D80F55;
	Mon, 19 Oct 2026 17:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5m7b3TxYo3s; Mon, 19 Oct 2026 17:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C82CD80F4F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429498;
	b=i3QeN3C8eg5D8l5gXqjMQnEKvOb36ddlbGr2LoNC0GMAigworh2wvk8Qu6gEMwhmwDSe
	 +c0HclNGvBD+ayWyxFLJUcSvPni7XCqGM/C/Domug0Ju0uO7OsQyP981BVJCtfqx3Q9PG
	 7oAqXRWoz7ov+t65YsjptzmoWLilgbmBsar5y9oXxw0Jo7AeWkDA7bygMLO3hxMFRvlLm
	 kcjlshttlIjwFNl4idoygGVjhzSPb9Nf3uD6JHyR0d3pa6AR3YPlh+I/twep0FPDv0zFT
	 AznoRwd16BAJY9AXR6lqgprdESWbpo4zSGdXDsoMzZTl2f0tLOeOPANU4rMjwoA+vDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
	b=Itk/2N2S/A1TmIv6krCt6BER8n1jIOtjchP4RS7TBTyQ8eJJwDB6qLafSfIL4kwK9KkQ
	 O0nNMuv1qfHW0BIBHt8B1BOKApMrmNZKnPDX75rAlAVBGdCpsDTvEiuyM0KLINAt997Cg
	 9Yefl1ASqjc/obBKNj2CkGZmP5vWUu5FIGSNXTccrUFlvuGQWFi78jMS3nRpSMROrCWdg
	 pkuVSQagbmzhyvfiSlUkIfDf7EdmJC5pGzGF0/mfKzBybT38k9h12s6Y8wEtIYk2C6jyA
	 9dMP2fPJRShDTWrDojkcwbutxOWO4V4EPJGHV+pDxHaWuoloDZAVabsU2+TT8By4v7A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429497;
	bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pg2YnvjlVluLLDF6Nxj0LcZWeWFngs5xyNPRnmKIsL+7nyAq8V0Sj9ZD/ak5sw2cs
	 tevlcPc3Erh7dbcRdilPsWaYPu10dhkjIq5RZcW8qy7fKVj6XPQU5sDbnon+KU44se
	 8NzuY8OR37HpZJaOaNVkIcCm+1xB4NHkqsvAsw1U+uQxj7bX/BIAI7hAeyU1utnxvn
	 YTFb0lk351sEO8N/V85YQLiIKPZUuZvq1Ntw0cURI8cDeBwjQMMFh+ADYRGHsn7RAP
	 tkuKUqawsm/m3mwq93LLCg99hY8WwqgcUTRKz1sgtOPXMLRvou7XiKD0uu4VayCRdm
	 yBXdw9YExFOgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C82CD80F4F;
	Mon, 19 Oct 2026 17:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E04523F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F0E960643
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGVxiCBEDQq6 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C84876074E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429495;
 b=nn7Y1pesA4vZ6cgOhATbHXYMARCH01RVTW87RSyqh5ODzpZYwXQUnYHIlsILPUU5bNJ/
 c0YbYt/5xhI8p2dsp9o8NUCdbYgH5Bp1d5xGls74b1PTFP+VyhmEBgF3K96cIsJAoAeyB
 hnr0IpGQpaC0/pioRTMPeLvE6GqRq52bhYjdD/O4uK3iMcXKTHXZ7rmcRQkjgPixe7g1n
 WxBTYIs5L5PTkvVUDvxQkLA5Q3MInrFQVCIuf7BbmLak8fO/t0MrKDCwgb/6ycxZESuco
 7H8X9ph/K5ZkzkuS3qLGRLpuwsOIYmqBovIxXXNj98g7739kUmoM+agEb63UTssTSKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429495;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
 b=Xi3gi1xw+3SV2HwFzrDPyn+Yw0B1lRoCvuo+JF8f9TfkO69+ZVPZmrIE6fJe0Kq5pgay
 WqBeC3CXFqeqPkjENKGDZkNhrMOzQ3YQHncm7IEDhpGCRN5zwRMqevmaB47w2AFu58Jq8
 dhiiFPug9Z2KxaBI8ZTPMhixUXqZHR1+hhApIM/ACPAmhN8+tunESFqtMj6vWrimQojjC
 Kd8oG60l1J8voowA3n18AetBnXgCtQbJIowR21Y19HUAkd4aXRpPKl1Dmr/5PgM8qCktp
 3w013tFP0df851tzkq5I86HvsT24JE2a834YHuGFhpXaiZ/O0eg6IglVdoysVDrB2+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TjEwPEx0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TjEwPEx0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C84876074E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:55 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ab3260b2cdso1168701a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429494; cv=none;
 d=google.com; s=arc-20260327;
 b=e6tjBtVF/Rp1d7EutJM32SljKdWAOY3HKN+P2V7qY6AoxD/cMBVNiqSgY8f1sguCX0
 DizNLfly/f/QmNSw/Ffg4BkDLlsRcRRerWjQ0yyEW8JEH27EdHJoHSMSCLgdmCYKUv91
 qx19AB4vjwdH0L3dg+LJuqU0BR6daTrB0O70qcu1LT9shhuZrBAqTVZpTxT1rYp3iNR5
 Amej1m7Q87BUq63mjswcuNOAXHzuaw0jYMJHOMX2Y95LlDdOli2n8TdXJS/2hFt1FFEn
 tLd8mDJESqIwDNvpjyxrxz9Zb2rj9sQ7VL/e3vOLaGRRcZDS6Go6P4/G+cWBtvj3nxgq
 PZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
 fh=LpfvZuFxpgydQyf8bAyuviZCA2hhy3tuF7VuUPGa7sA=;
 b=b4rjKhvbLbLoBQ1JD61CXybymvL7/ZYFwVwCG8zoGUo+KgW/hTFlkCXPOP4vyKqo0d
 KEuH7ygQqbPTJPeZZCUxmBUsGAklBuiDbM4wrHPlugBfYBqJy+maxA0iG1/4+vX82C+4
 9rmz3PRFMGetC9qGVzsAMBUw6/LibFYcDArBNuMAHNGAWae6T1eV2VLVu9X6TyKaz91M
 X+ws2/HrBXBbvankJ/PUX4OfOwR9pIOinrS49PtkeJG4PsBpmBbEDTGMoNhxsf/FDNTQ
 +q9xy25hTKb6IjjduW/NRvcX8KDDGTqWPxnzONAzpi+2G2Cu2ecJxROoQ7uH5w+GUJ6S
 GJjw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429494; x=1793034294;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
 b=TjEwPEx0XAiv7jNid3VNKAEH8nwh+z0IqDCUKFRDuBZMD5e6scjO4HP93Oe1q4bTyM
 BAJ/R6ASpRav6Od8pBhQzn/AMjPhmLvbSWuyORZpUIAxtYF7Udbj3XM9Torlb4tC9hyc
 E/v5BiE1pzq8vH9uyuhG7FQgRLwHE1rP9hXUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429494; x=1793034294;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gfgc7+bHmUdX6/7ZZQhOPvtetxKYrTNLvj9SjykaUZU=;
 b=jkeX7LGherilqBJmjVC99DiaWzF5K9zXCcU/Si28mn1fBl9hhZExBccjwXkm5f+/VL
 Q/8iJpxnhpvR90fe2nw7EqKVVMPbj3zwZCWwxXQ2ge/nK8menOm4u2Qot41vexa2qa2g
 G6Gng874JLL8wco0OYmYOX02QMJh5Pu56M42lNSNfNm0Kqaoh6Jmoyk9hNzjQyzR2aRF
 6CttFpu1uHBCd/r2BsxwH/KDmHgiHwxrTJHZFkpCcbgNYDKTHOGzTqiaE1r40jqdXe6K
 seI3rZtIATXkKZlVHqBVgEHU733f/IX2Ku+juz1JAMAg2CD0CWadf/EncIuqeEe5dPWr
 QpQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd1uPpwgIB7WlkZsglbe+ArnetK53VPh3itOQ1gryzxh+PFuQa+nsvg0CILq0qSuAh3iYp8bA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIJzJq2mG2k46WihKSP+fsq61TLHialWagYokIoaIr1Fv/Eddd
 O0+N9JuNCWdkNoXE7jWhP8WyePZjowcmshLTlyyY58Te92jbPnIzFxh2ItGLPondBnK9m8Ru/AB
 atF/df4WKd3EaFQckPL4JAq71Cs9qeDKp+Fu75sYk
X-Gm-Gg: AYBFou19HtBQUJKduhkmFETTfG+sQUHKHWMgznoPnPcSX8ADlWfRrQ0ONkq7arzKVt2
 Zqi91Vs7wBDsFqXVZuQUFMb7F5nT3cpnR1brdCxn/25THyyIPOXpiZIYvXyj+q303s3V72PoE92
 N4JgUmFvv02mr1VQzlH0NnJ7DUxSSRLYhhR6fwwTX3hfYXqwFMfLvzPxVPizg5zZp95ZbPve90h
 Z9D/kwx0ifzkHKxKqvjO2fXRq8Vj4b+iq43RaASuFGQ1dkFw1u3IzQErt9HEcBNKOcn2BMmgWtW
 zPRckSy0ds4UlUikChFacvgtG14n0xuaeDnfyCsXR8bdsmu9DVjR/Q==
X-Received: by 2002:a17:90b:47:b0:3ac:8897:7b9f with SMTP id
 98e67ed59e1d1-3acef0f4821mr6530273a91.43.1792429494474; Mon, 19 Oct 2026
 10:04:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:04:48 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:20:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-8-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-8-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 10:04:48 -0700
X-Gm-Features: AclHuK9ZfSaEtG-Q0rawJVzCNsNZAyBZoJqnlq8MNTqWseH-6ZgQa7XXJYtpEOU
Message-ID: <CAFLszTix8iMV8iR3MiacA+BW5upLoLCXXZ5eA4=NJJ53Bwo1KA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] usb: ehci-vf: take the register bases from the
 device tree
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
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

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> usb: ehci-vf: take the register bases from the device tree
>
> The driver keeps its own tables of PHY and controller base addresses
> and reaches the anatop block through a hardcoded address, although the
> device tree describes all three: the controller points at its PHY and
> usbmisc nodes, and the PHY at its anatop.
>
> Read them from there and drop the tables: the two phandles of the
> controller node through dev_read_phandle_with_args(), the anatop one
> from the PHY node. The helpers take the private data instead of single
> addresses. The port number stays only for the choice between PLL3 and
> PLL7, which the device tree does not express, and now comes from the
> usbphy alias of the PHY node.
>
> The usbmisc node already starts at the non-core registers, so the
> driver no longer adds an offset to reach them.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
>  drivers/usb/host/ehci-vf.c | 132 ++++++++++++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 60 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
