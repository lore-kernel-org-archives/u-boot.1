Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF75606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f62VbEdz;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=isstzpMI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDA7E606EC;
	Mon, 19 Oct 2026 17:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWUsVNGfx_BT; Mon, 19 Oct 2026 17:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F68360623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429492;
	b=NTdK2XBgFEISmUA8OXo4GNjKQZiv2Sg+OL1z5GGPDOf4e81bI0Ct5AkQWdvADxWIEWJv
	 czNrZv9b9KJKQyRULG5TEYZjLfMQtdU8nm4sTZPMx+SeoBmJnWJenaMTR9qDn/4xVKT3s
	 WFRdkLUeMNpu0NAaGR2GpggMIijlzRjhiN/z+bRiF4tIBfa2FWXinEm50E0nijLLESXg9
	 lWhC3uwGefnxbB+z+x45nm1wfV9DtsytVH8jo3ifx7rcF05zKp1X4ZOT51R7ZOo3DoqRx
	 G8cPgCp4FCCOW1WDqv2zdbyGHJAUQC4mgBYEmFQB59dZtn7jX87HLCDmTDUakKMRbsg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
	b=sdU/Bhv1S/2YNvbJswJnPW/4g3H32kh5A0RBX5tuRY5HgZGmbfRYWrKqfV8o8kJhq31F
	 RiY4p/jI7i0U5cQIqyeolir5inI90UuMBXg43Hg+CWn8K+qpSmPgvSj51pNTGE5vDAtur
	 SkmoWjjN3MPxne+zSV7e+viZ1dcKNwUCHTvteQJRPbJdJqZseDf1tK2CHSoKLQQJ1jSyH
	 wXHuEcgF5KXIGc30gQ+6bvOTFvopsHdEwBFkv9gRMu8SwccTM8ZFZJDSNaFiB0QU7IVjb
	 y3XtySb6cOolOsxasQEr+6PNjWMVYxjym0I7tO8Z7nupbh153S5CDKSZ52jQGehgL+w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429492;
	bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f62VbEdzxjL93EKSMcI0bOV6Cw4D1zG0/8Ko3dEPJEC1Wc7uvVPNX/Q1T8HtDco/a
	 7UfvIMHsWH8M98hiOr68XMOhzOFxWZmtUsEmJSXiGr/Id/griHYnqXwaeMGdqwaP/N
	 pgupJbN8xRXMzSJlWiTzQLIebn+U08Ql1vA66B/lAJZkhLgUkRUtgeo7Opm/ngViBh
	 9NvrsZsWut51KH0OaYb9Wtl1eg8s3dz+25f5RwS/o9qZ0baa1AAbA1FeqpvfU1sfWf
	 nGl/S504Wgmw8w43uL5eL0GNoMgUY+CU3ezumebXoQMl3K6c4a2Z69OMm+SVyR/GKM
	 1pgvzJpgUClGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F68360623;
	Mon, 19 Oct 2026 17:04:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C54151E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6D4640669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zPVQKJcfy3Ja for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D8194066A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429490;
 b=KZyXVOf3mOrNVUO/hdYrbfVYR2GTyO19rN8rZWYhdZZeRgaBUOlVDWvIY3PqtY5EYy4H
 nK/qlJPrjVrG59Zvhtqb/nIMsow0AxR/mJVpqfpdfUdJgj2y9q86p2pd662K+XMFEpPLM
 5E8Ce9kBbEKS1iI3Bq5LPMbG2P+/bSp9gnWlHoL4mwSDFBC7I6dCo5BdHB8LoF7mvdwLD
 5GJCE3ZmmMIZ/ccIGMp4WzuVivRiA1XbZGISPw62vo9rwaRzSBeae/hE3j34PLVbUp7yr
 d1AasOpltnGwL46guE3bnbG5/Mf0jEsMYu6vpE4Mq2m2vv7k2v419jA0HOMJsUiKJMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429490;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
 b=N5JGC+pjEnYQ6ulfLFQeTL0jFLmCnjJhY/35QRnAqzFFRk8u/DsJzVM1GAB5KmjGO7TK
 ijrwo7gOcMxPXuLVGQBzRalfYLNroO49PIkyPyHgEUMn9u22hObzrWpCvVKVT2WBD8nXd
 Y9DghnedL8P5K9myGcb92NtkaCy+GnG3+gkpaKbmTZhSfTX/iYS17t2ApuVTjhIdLzqGE
 nkO+wpjgMeoMaMjaXmHE81jYruI0IkKFiJ+AocPd/HWrWMEK6COxvrngECBk3kJwCiP8k
 4zMdjZvLLtW/b98CCKh8InY0Hl0JOvyIv0bfx/9QYx+GZmQXYc6/B1ykVlMuNczCvnw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=isstzpMI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=isstzpMI
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D8194066A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:48 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso1427902a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429488; cv=none;
 d=google.com; s=arc-20260327;
 b=NZ6PUwqNOlc79RXHguCTwCnNXBoXdVv0DHkEwbpGNrqL41gtnUMu6OJn1OHcRu4eWM
 ya32X7F71qNcIPS7XBNoy9od7CYelkLFgktEa2LSzi8W0W+h1j7JGfRaSQdlnK4zigC+
 nYQct7w94V5pcMU2qbzIlo79NZefu5ZFmhGsuc+1Ax+2UkPmoxzOX5x215e+BUQhhC5H
 jQgyxzAdXOIEWk+6XJZNgKXYY3GyXZbRAeB5MXf9y2wFr2/AaN9GvuuKdLQk0jUOT663
 ak5nBBELjVdr80rDapNF1FHfQ2UuQu2EAnQQ5AS8Z5Ubt7ERTmcQC2H0eIpQlimA5Xi9
 6pMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
 fh=rulgzZcemWT1Rw+MQl+PT0+PDGVf3qFKSMd1jMYMLwE=;
 b=eDdzv4owRtAZLFi9m4bCX2GMXkMcNLsEVt5kAGcPBwgu8mv1Ly4t5bQ94BWqlOUXoT
 3QhPEMPBrlvYGu9mj6HnIOPCP8SyD//xas5HIqrZS9oIY/3I/24wTTjrs/0c7gyS21eg
 AXK0OAbD8SiuHjXTeABVC4agsrue14earCgK8G2ZmpDZ+1e4UQJuM62+FUxzUqaEtmWw
 4zwyTFQx/fxVFo4yGDXXigxBf0Ddn0DItOR/foxsibzk48GWDmuPyf6N1evbMMZ3nYhY
 SlC1WNqttAzRo7my/t+aG+Q+yKQMLb6n5yIxmtXORyHpTnEbygcaquQwbpjN7qbK1PIo
 Yr4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429488; x=1793034288;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
 b=isstzpMI5yJ9Zy5AdgnvyytX3J1Bm9X73ThbgJoUofEWNqu49Z9lhqT6ONE0TI9N7x
 BlvDB1ac1/BlX5MD0pTghyNTeQ40pl43vAr/ZfWv6XAE5P07kRhfO4bFVodU+KkmbfQT
 /5EAnuHCCJAPUSBFTDXjEQIoir/K+iZyZ5ZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429488; x=1793034288;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S9tt7CGRqfRK/r9CbEX8bxMSyUfoOEeuFzYS+g5/fcA=;
 b=OUxCmcwJK73f7SB7WmrPZZAgpzEZPl+ErbSvD5WNzDicI1CWa2Yb5h+nzGvZ74SQcA
 2dSepMHD67pi8LZpYe+Y3DfdqnYF4aMl3tFgnuyOqJfh9MeX/t0mt0GUTmsFsl3jNhKU
 YbE+t88CEOiR9FPRZydk43+Aro3K8s5tk1IFS9aEf8fxygt6KQcphD1nE5rs07aNS8B+
 3kZsF//Y6kGciUaiTfrb98cJJ0LyaUNIhUu6TXumdW3SmmZQff36uadO30eqM1hbuG6U
 kIty4MjpQVGqbzj2J2AzJ9bXfCQpoxp27bTNgmFVQ2l/0yPHjHOYwCjquwCmmA0Z/3sF
 Vqxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxO6WE3TIwzmkp7tTiaa3UVf65p5KzYu+5RQCG4yObKLdNxGM7yKPEEXh3FQW2zNOVVX2cNlLw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIumqfX9M9+mn+cmfvQcQ69TPf7bMxVPQFGxLmYWPsFoYYpeXk
 d25RfI9uA8QjiyuFD3TVyiovJlMVpyGlF/V2n+ygC4QPII/9Mu56LslBE4A/OWzs1Xlq62HiL7j
 RJDkDqTcf6X6rgTmIdPCeqt8jDqOqJj/53m/3AWZS
X-Gm-Gg: AYBFou30Cfwobl0xWcsiBYCUW6CX8JCN/qS64HcuoMpQMyMYphlvjvQ83NQoJ2OCbNz
 nS3452Kx/kXra78SlwpoUtM1S1R1AV7nq1DJ0ScxY07a/pXrYgeLkG4a1zE7IA9Vv6T9dBdkVZT
 5gRR0qIsAaYhYFEGIpHfn7H/oS3TX0UXL77gh3KSc0orqxCveMc0sC+lxAJXdNLOvD8WeowXCLb
 Pqsrf6aSSSMHsE6/Wg5P48ghBu3NlehwIURMO+srUHOtlAHotwfshSTtaLKUh1dLDuJWS+mxPfM
 u97adUHY9Y8jOJuBBzsuNu8tjG5+m/1T3mlb1P6paRbQ2dKtDevAP4uod8OrNmdbjWMvxOmLuIJ
 4nmPRFdCgNUDDpHTSVFW0GExcYaR4U311aMiqf08If+XcCwRBMtVN+FmJ
X-Received: by 2002:a17:90b:2ccb:b0:3ab:e789:ce88 with SMTP id
 98e67ed59e1d1-3acef640bc8mr6396516a91.65.1792429488064; Mon, 19 Oct 2026
 10:04:48 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 19:04:45 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:20:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-7-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-7-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 19:04:45 +0200
X-Gm-Features: AclHuK9GQNOKnwwHiIaZUfzq-VSwJAzaSFZH76tN0FZXnOCrtUrx_QBWLGy5LTs
Message-ID: <CAFLszTjQ994vBH-N5UPo_oLvznvUn=X98yw=uD4fU4Zo-FV6cQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] usb: ehci-vf: use usb_get_dr_mode()
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
> usb: ehci-vf: use usb_get_dr_mode()
>
> The driver parses the dr_mode property itself, through the flat tree,
> into an enum of its own that mirrors enum usb_dr_mode. Use
> usb_get_dr_mode() and USB_DR_MODE_* instead, as ehci-mx6 does, and take
> the ID detect GPIO through the device rather than its flat node. A
> dr_mode value the driver does not know now means host, as a missing
> property already did.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
>  drivers/usb/host/ehci-vf.c | 65 ++++++++++------------------------------------
>  1 file changed, 14 insertions(+), 51 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
