Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C345C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 16:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBA284A49;
	Tue, 30 Jun 2026 18:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrjQLKQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4E984AC8; Tue, 30 Jun 2026 17:06:30 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020C284A51
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aebae2f310so1663496e87.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782831988; x=1783436788; darn=lists.denx.de;
 h=subject:cc:to:from:content-transfer-encoding:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RG5mKfmJE4Fp6eUzA6iRlxVG+npefU4j9FqoOL0xlX0=;
 b=LrjQLKQkD16NrnutgrYRqr3erDBzCrc6XTPiqMXXyZXI8N/KGo9XV1YigxasAq8c4D
 22NpDARhMKTLKpPJ25tudCk7KwUohReWVU1OJP4oa0hg0kTIy3rOmQXOX/KM9x/SDXBR
 ruEjjRhOoiz8pUe7KMyluGP4FJhZ0GJK1NcO1f+T96RGk/UvYXrpoRXRveVr77PElSdG
 kx5FJtMMq2q7Fuzy3M9H03NYlLsLNtY1wox5fG3+6MbHn51rCMLStdH/Cu/3MLnfL0kR
 UUzaP8z8QB0rEjuo+WxlQ0A9rTv5yn0gWJLcGtvzJFJ5GkL6U+wjXXtR2drbOzJc3EJP
 ZCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782831988; x=1783436788;
 h=subject:cc:to:from:content-transfer-encoding:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG5mKfmJE4Fp6eUzA6iRlxVG+npefU4j9FqoOL0xlX0=;
 b=DpLZ5X/Ll4gsSbq/5ElY3SLPakYcSY59v5OiutbxpS8X+nsvSCc6hfUrZgyvroueOx
 D2HQCqtp7WrVjPTVk6/UISiqLK4LdxujYINtThE7+QLnXsFzZ2vbzrXFAmcb4VqsVz33
 7qvlqNa0rlQmwXhmAB5LcpBQskJBOQzW4hWerTdIF9TkIAuOXE0adu6RUE2gDS6lyPyP
 sTIKDdPeQIgoAhBiiHGNjKWfcQsf8MLDNazQcnj3pc9j7grdzVSGNzxTKR1iJFLEqKNK
 KCknsL0PzvVje6xhPuh0MeiJb75oQQmbZ3E9eXZgKVJAUZS8PoOLo33A6ob+SQ6t3+EQ
 yebg==
X-Gm-Message-State: AOJu0YytkJ82+8IyQM7X+Cmj3VKcUeWRg9Yzr3AAdBgGNQfTaHSczo78
 FTiF96oskMB7VqBU503FHAvR1Ua8eiLE362QZ2J0fJuQ6tQO0LMs0r1cpmwhhnd5aVEnZw==
X-Gm-Gg: AfdE7clWIlT/xPQkg0Nipc4HOTFnW40ZW2ReBlveV8IS7tsTI+QaiL0xcp3XqpxPB+k
 0YK80fFZ6jYx2AO99HraAI1pogdR1Co+HwR5SAnGt4A0BgYLyQWlY/8Htl0g38WENJmDfsL2lmH
 j62qDMB1vJbmCbpt8YK48z8J45z6sGSCM9tMvRy+li684u8TENp3n5CMCID0CoqF2zameI4DkgN
 RlOL7Cqx++ep5/acvOgDYtWHHF4umJf2aDxn7lWMAPU7eUH4Rxn0b44Lnpv2yhatg9QIbGACGEQ
 ikSoZ+EfZCTDMp0jKlx8s3CNq2pjUbYQSqvn8lboPX74SW8EaJVDm4ruGQtTToyj3H2WBl1N/qV
 CZ48fgVgQ6lBcVDLp0LEfjwBjXftKCZjGD+G1nFxhA9T2KZEKdOJmybhHUhEbp/v4OvQqNzmxzk
 uVaouq3iqBsf+c9dZ9xGMbDEXsmqVAt79tLTMEp8IB2XG2uVvN/4Omv5k=
X-Received: by 2002:a05:6512:3993:b0:5ae:bc40:46de with SMTP id
 2adb3069b0e04-5aebdbdea39mr1005318e87.54.1782831987784; 
 Tue, 30 Jun 2026 08:06:27 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-251-137.rev.dnainternet.fi.
 [87.92.251.137]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b1da1d16csm6208841fa.20.2026.06.30.08.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:06:26 -0700 (PDT)
Message-ID: <6a43db72.4d98510a.3486f1.4fbb@mx.google.com>
Date: Tue, 30 Jun 2026 08:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: ian.ray@gehealthcare.com
Cc: u-boot@lists.denx.de, HuanWang@gehealthcare.com
Subject: Re: [PATCH] ge: common: vpd_reader: fix errloc array size in
 verify_bch()
X-Mailman-Approved-At: Tue, 30 Jun 2026 18:43:43 +0200
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

T24gTW9uLCBKdW4gMzAsIDIwMjYsIElhbiBSYXkgd3JvdGU6Cj4gR29vZCBjYXRjaCwgdGhhbmtz
IGZvciBmaXhpbmcgdGhpcy4KPiBSZXZpZXdlZC1ieTogSWFuIFJheSA8aWFuLnJheUBnZWhlYWx0
aGNhcmUuY29tPgoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LCBJYW4uCgpSZWdhcmRzLApNZCBT
aG9maXF1bCBJc2xhbQ==
