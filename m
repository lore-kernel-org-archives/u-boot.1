Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0F6CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E588C83EF9;
	Fri, 15 May 2026 14:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="olLcyrJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C8684683; Fri, 15 May 2026 04:55:51 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AC18464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 04:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xiaaltabano@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-439bdbc86b1so409975fac.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778813748; cv=none;
 d=google.com; s=arc-20240605;
 b=apX6XEHFdtTTciVshkae9RcIc3U8sIDu+/xUy6cqBt5ilYWpx19jtMvo4EHnKfH21u
 oXEuru/wyyCq4L7bE+pM5a6sk0ftEj7U3NLJ0d9YEHnbvS/ObV/PCiF1eSkftTVEQjVL
 W4N8ej63ksaNgHkiIiU3ra4ilBO86DMm3ujOhh66J+OsKc9tA95VHtIvGSuC4jOIR9LH
 aY5ysvKcPoxVIrozv0PhW4PwymD7za1baaD9PGqY6MRzjcSxIDhL/U0FxN+hfwZRYnqy
 SrTPNBsPda+RgpmKLfqsTEmCSKP3c5R8HpCRBKOWQQBTt0/xLk9s7X06LBF4ZSGhkmA4
 OR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Sddkb9mpe4Qk3p848eYeVXjW0ek17rT6a8Vf401BMHQ=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=llzjHEaGyaKrPQLMfhnatjZInGCWazHSVOIFIEuOU3qUhcJu5fSryNNu6rO5KokjXI
 /2cS1beceE5BIQp+JhI8ce9uI2xxPOvv7uTBdVH6geLiVQ1UCV9/YdV8wFtIh9DtzGkh
 M3e+zn2ffMkTI8vT1GC5LKYp2nmv1ACRdgpeUadu7HRX7IVspAv7GCIHn8XieoA7kWCV
 KyK03gOlITX2rQ16z0h/obRSHTUhWZyvgEYe9o+uN3iDPq3h1+0GGa4D1PmHeFlWsiBb
 9T2jqsNHY/iK82iyETrT476L1EgNwuYClscse0ewvH0C7nBKzJmi0KLf70bePYX31hBr
 qEww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778813748; x=1779418548; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sddkb9mpe4Qk3p848eYeVXjW0ek17rT6a8Vf401BMHQ=;
 b=olLcyrJG9jTJlkPCQa1yHPPUp4xSeT3RJiCMbc9oNUPYuL2H8y/KDSbvkLs6hWl1+M
 EuGPhbWcL7LtwS0Qrsdbz6qoAC02nPge2S4SVimFCgQ4B8dOol8c+aeNx7GHTd5xo76J
 sgL5XpTuRBlK8DPwMl8iItmvT7PJg1qqTeCE0Y6R1qvCQ9KCwRfRYuseLsfKrK8L5akc
 T1+dZTaTLaMvFbsnMbZT11oMgacQvbkcweGQn31VeTM8kivoGxeyVOK+iyozMraEOqq3
 LlvVIEfb34j9WOfKXMq0hRzCj6auGFp7qJKG7GvrSwvf5ZaF6iiV0KJVl5/N2AyK9h3p
 7NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778813748; x=1779418548;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sddkb9mpe4Qk3p848eYeVXjW0ek17rT6a8Vf401BMHQ=;
 b=P3xCvlSaeRZhf98zE+MF1/q8S7KoK+H0tOgiOeKlSol2zTmD1M88TbnQ1IdPD9EFBh
 9IxrRr8EMSmmjzfSxfb8xiGRoJhx/XGvfyarAuuyrLp+ETsu10IsmyM124tPHOKVy4FR
 ghm7iQWqC7Qzypeetnm1uFAIw2XYnprbko/3uKZbP4gw+uDUHw0DjXZOZqE/WPh9Y0Ri
 knY2YifyDYub8oOBpnxcP2FwZ6CE9ywP9r5BaGTxo2rPiKmV8v++lL6OUHD80DMcoqDh
 w4qgDHybUfLcJG0YoFubQUfQQ1ja3xbZJfn/ycEXzs/LFaBTfqMKKhqXOYN0ep1dk1bJ
 908w==
X-Gm-Message-State: AOJu0Yzz5ce4biM/H5WT34EsnQU+G1ytIeRlW4evLBvA+/FhDpoJo+SS
 a/iaYrqUvg4ICDGHyD58sTFfAv9TvSaI1+OR/kJmw3lwO8D9WDxK5GXGxhqifuCYw/21PJ1+H/i
 QsJ+AX/biix/+hAl3OQT4z/uI3W6jLKIl6g==
X-Gm-Gg: Acq92OEVjgsNnhSlwhDg7IA0PcWZmcFQjNadCU4DWwooykRFwLP6HyJQeLexYlt++MP
 1LZTcgH8xqjY79pJ/hTKG+MQgHsAeW7KJbvXrrbaMP7+/mfyWdX4nRBOvGkW9saVzQ5uCpRFyJg
 OWVLNld3weg/8c8dZvdxB3WHxjeytf6hNBhIMqnoRTZr6Opo8eD5sxLXGaJMok24THdoG5LV85W
 B0BGwDNH7LtoUsbFzGFUFdCKFvAqN2kUccb5DvOAgPQV8sV1jAxntd8FbDwaPb0Vo7CbWstDdn4
 MDiUMwz9dQs901svX2NAcPK/
X-Received: by 2002:a05:6870:6107:b0:439:d375:618c with SMTP id
 586e51a60fabf-439f91f105emr3100997fac.10.1778813748210; Thu, 14 May 2026
 19:55:48 -0700 (PDT)
MIME-Version: 1.0
From: Xia altabano <xiaaltabano@gmail.com>
Date: Thu, 14 May 2026 13:17:05 +0800
X-Gm-Features: AVHnY4JOs7WN0ZEMzlavWbA6xVLbeteu0OWOLZxoo6NTZo-61nxC14xM8UnQ9OI
Message-ID: <CABKpJy38t91qLUJn2sQpRucPdYq-tft5pfFcU0autA+Z9mpB6Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] upl: Update documentation
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 15 May 2026 14:27:41 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


