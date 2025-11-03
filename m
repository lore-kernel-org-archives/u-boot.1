Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F36CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8AD82A9E;
	Mon,  3 Nov 2025 23:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqHvwoep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FA382A9E; Mon,  3 Nov 2025 23:58:16 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144B48144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3c9975a3d6eso1811659fac.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762210693; x=1762815493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BTcc/gUifuZTrXRpfA1c4tYE8F6PWpgo9pIWsrXLpYk=;
 b=GqHvwoeppuFkq6Rba1D6Kres6LYuS7WLSjZyo+iF30g1A9CRVNFvwXOyIimIqY4LQL
 akYE4dB8aijz6XL+IfvhIQYUqr+A9sJ8mPQ5aP8VoTpQnQVMusjIbAhoz9YZVGB8DPlt
 aCKfGNTeWKT3HDgUssm2wlDzHUed+myIe5a343F6qD59rWuT2wnjYc7iGFqz3nLHx8YP
 49AoN6awrUbMLGQ4NETxQDgjsGCog3sNRf7O8BEs+r22GoNyq20ND9ja52V7xUN9zT2k
 B6mGkSjE1YqnIt09ycJmwvj1cUEqKsAOwZovk/p75tsO/fhPFsjc9Z/ysH/NC4FEJxsw
 qZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762210693; x=1762815493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BTcc/gUifuZTrXRpfA1c4tYE8F6PWpgo9pIWsrXLpYk=;
 b=qHBsjL9qfY/nGWHyZtYiGnChMqlhNVutrpRJV1kPciNbDWVuvwCQzFj1H7yH0qM1+B
 j3gDPExmOiTViVKMl6Mbk1qnudRsn9yAOwPZqVCVZf+xpTkjdeb9swPu8Aw3JYtS17Q+
 8ZD9lwM4H58phYcpv1dqv9W7n6WcSjD6/d18YQB+FxXv5k9+B+hHW5fHuGNiS2KS5jbf
 uUh+ic+ft5cxQu4GcLDVhSwFq+9h9v+4GDz2+TiRspVVl/h2oPQTMRs27pbhkGdUIvOC
 RMbAIJ9B9Kl/30zxZsECpS6yBjhyu1FhXbepfFe5rPhFsqaG/xbkMBnT6tYrOfUMuEbH
 V6TQ==
X-Gm-Message-State: AOJu0Yy+YTuEquwvbTk6XR4VykZv7R02tBq0C/OcqedB0H9coXQavQtI
 tEqUPAWFD+fkJ2TDqrqjkFQl7XGXxqIkcMntVSp3S7bJioWLFzUpS/UcP5qAA3JI+W+qNchIXTR
 X3ZjAw1Pdt8IKcg6YrWvwCWGvEN7ZAX1EdVt6
X-Gm-Gg: ASbGncsfNSfXat4u71D7YMiOvDJB3dcqG/ef7QjQc1rI4+n5B4uaB1UuYumALIIXUau
 qVbEUZztZveYeuP18SNxvvCoB78X4wUNdq074sbkJJSwZbngn8xvLpsp03/rXBQarxPKHqOumAq
 sCFvvI+1KvZliW2octqBxwj95RazAaaTgHUDiFKh5GavPtvDh9DtSX3lHp3olu/k76YA5TXBlxd
 0W2eHMVG5vUP37GU0tHFLG//WP4x4aKRFxT75SLUVMRno1wf3jZRdx9YfUtgA==
X-Google-Smtp-Source: AGHT+IFhEc8Bjzoei7+3AH/CvapubVCt89kpcfkDEyW7sZDJxx7e6UbB96grYtd3WbOZP+3xIM6Q9aRpDwUXRig2c8k=
X-Received: by 2002:a05:6871:e708:b0:3b1:8e5d:d450 with SMTP id
 586e51a60fabf-3dacee01a8dmr6461093fac.46.1762210692638; Mon, 03 Nov 2025
 14:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
In-Reply-To: <20251103223346.GU6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 06:58:01 +0800
X-Gm-Features: AWmQ_bkE2_F2NhZ3eLse1-kpES95qDfEbhVa_9_w7gN6XNopxAEUE1o4etF-grE
Message-ID: <CAN7C2SCgE_awHK_bQ8QfLbwnB2ZPrAkxPjE_VEPjo0p1OOx6dQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> This won't work with separate object directories. Please give things a
> spin with "make O=/tmp/somedir". It also looks like it's going to impact

Okay you got a point here, but before repatch add an additional
USER_HANDOFF_DIR=xxxx parameter to override the auto
qts+handoff folder build.

I don't understand what is the issue you mentioned.

Brian
