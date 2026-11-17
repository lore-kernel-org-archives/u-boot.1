Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C3606A336
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YvaGNd+T;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYYQctdM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C92D4405F6;
	Tue, 17 Nov 2026 15:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mo-SZ6lihiz9; Tue, 17 Nov 2026 15:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2F5240538
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794930310;
	b=WkgJGTnT34r2inR099FqFrCCil2Dfix4ipdbVtyCDgNTDZoPNK9WhyahH+YKlXhYWD8v
	 O38DwqTLHQca8hAXVFBJNrwUPRpCYIU5rhwHUn8fQvrNRAiy8AYt+tkEHcZbFSu+mso/+
	 uLh+heQ3KyHS7zAstd3I0VkkLjztNVOL1TDiih7WihbFsDgRJn/HApOCSjmfFQtOgesID
	 b6vNBWEm76v/CGoo+w+Shh1qFh20Dlx9L1Y426frq1ZDRhTXZtbN/95kdeQ02vyBKBkyL
	 Fcfwsy/wclW7eDGNbGRiA7J7FEvoRQXEQVNIQ8FEKWea/VZgABDAVIAMe+5SenF+Dlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794930310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2K58g87QrVlgCSvNvhHRLfPSjv4OEaTbEnh9I5mdt/w=;
	b=T1dhJTWZ4uBM51BPuqk3onH63jcXEznNdX3CQspSor0Vh3aRExvvJyQeLz5wwBD1D5N8
	 VLQl1GUK0Ax+4WB5QGuVZtVJ9XT7Mchb/gw4/8EfXqPIq/lF3q8Q4xsRzuPmvqTF7x+7g
	 yQeT6qe+mW1sdewp5GZ35FPAdiwoMkFMUt+CdPOmN3Aaw0wqImGAaw2pBDpHuou8WYb8l
	 z0wBV5C82LU8JKGCzcJ9dGENn4CuFJH+44dzonNeel1Wf+vGnDlvtkxLDHC5pr3qiur4w
	 fr3QOOWw3zAJW77Sis1MUCqA2Z+2izlrEb7Y96aBhiJrUq+Slzify2Nn5Wt9iMafkJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794930310;
	bh=2K58g87QrVlgCSvNvhHRLfPSjv4OEaTbEnh9I5mdt/w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvaGNd+TxtsUiYi34hKD1s9nB7xsACDwQjw9hpqTKHOHv5d6dJo4fzR2An4gVzUUU
	 kc2dJRFWZ3cr4C5Ta6fi+YyKCPotSTSp64cCGbZOPDtll13J+0lSSMc0mvchuJyp7n
	 6lnpYygIbjvioA+tj9N7jZZwkXgio5MP8IB13Uf99lHL59HGY6gITF2av8+41+dvKd
	 0WIbWpnU8ORICl3QvAY06FaGWkKLPUGtS1waFWbqO2C6nbMy/3l9IzC5fusu8awwNq
	 nglPQ7F8twQDDhmBB9w0XJrNubU7CmZmMdWfubFCWeQKWoxEyI9BObXYyVetNj2Jqp
	 d2QlvXUzRDFVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F5240538;
	Tue, 17 Nov 2026 15:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2153C105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06BB7606EB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVPIQSyLkjJM for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:45:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6065608D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DYYQctdM
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6065608D0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:45:05 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so208464666b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794930304; x=1795535104;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2K58g87QrVlgCSvNvhHRLfPSjv4OEaTbEnh9I5mdt/w=;
 b=DYYQctdMksr7Wiy/hRUjsNCdhEr1JRXDgTChSwV309C+9UGEcUYs6s+8dAbp5OnKtC
 YI+d1EmxVakbBsaRceo4z6/CEovGBqnLBU038hAnnU8wwL/z8FmmjOahvc83joiTj8i4
 6OnBTNuEyVIMSO+tucuX+ayInmB7ytwzsevjl7Yi9MNckIGjg+zgesKydGw+BNEjBydI
 dlH26s9SGVgREyo4Kkz821ORmTkKphg6IQign4ca5a/JmazS1Jzjf49BT1tzzTPtdmQD
 rlMfoGVZZ8+oLoiZQvsXyA0VZJGPPBFX1Wa2EpFio09Bao4WcPoJH1ajRFbSw64UJUbQ
 ebig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930304; x=1795535104;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2K58g87QrVlgCSvNvhHRLfPSjv4OEaTbEnh9I5mdt/w=;
 b=cBw0iD28U2z18jRljxfNC5Uxb93MzpfK9ycBRqtH0Knqj0QnnsOr75WB9NZuCvQNQi
 lQivN13NrPWJk0yaVcY9HziYExclUs9EwdjyLSu4EWmhVMSM8bdE+5PQFMI9OvcrntMv
 tkn8Gz8kH6GkusI+S6QbvXYCo0pG7SRx+dL8QAlDS9M8qOgdfBQJ2JaaIS1tKR1B82Eu
 THV7bhVDAyxuY2LNcIq6bI6Erl/TlDxfJBvVGCSJXMYIoPUhp5vLI3s/XDtTHQbvGQlO
 CHdGBwtnDNcnPrtVB4nuMfwvb70wuu8RUAb/IzW2eC3aZUwqSZoXM/mQsuAsuuR7n9mI
 ma5Q==
X-Gm-Message-State: APuU4Z/s4WwBPsQ5SPM5POrOvp6YSJZ33XZYYFO5/ub4Dl3teshj5iK+
 GNRLZ1gL8SGhbq5s5QX27zJObQkusNO9gH5LbHymcBH8uLMzxob91ZmTQZkktOoGKnAQxmOZM5n
 oVFvvWZbPEbnQw+msJz/+PJXkBa8Pj1c=
X-Gm-Gg: AYBFou2rl2yZ5zKZq6kM5rjfK3cZEMwKQlH2Okw31f/K6qZdSSnRdsWSYZ81sArnn9P
 mdwgyWn5UoC0UcOSI2a69O4gvQZVwH/w1pykhqPMzLidLphhIUeez/mx56tWUfsbg+CVu2MJHxX
 nhpC7jVEiTqK84UaZ0M2WnbcLn4OE+WgQPlmiTP1vb3tcHORD0VrWDNJyi8tAqp5CvN0AGTH7Yr
 C+pVSDzUYBwqf51sdLtsHbC5nKRVeEfzTwrloI00u0S+Mc5U9SyKGZ7YlfDzoKLFn1RIHsPI7tz
 zTM6pdm/WKs0vRXJatoKSojLeC6dC5lofNgo3VdYRXcyZwnE6o9qcd4F/McuEOTG/70/pF525jI
 JUDiMcG5FiZpy53Eu1H3SvkErm3cZXzNho1I+P1s=
X-Received: by 2002:a17:906:c10e:b0:c46:d493:47be with SMTP id
 a640c23a62f3a-c50f33bd066mr305559966b.19.1794930304042; Tue, 17 Nov 2026
 07:45:04 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Nov 2026 10:45:02 -0500
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <179492784365.252888.8046542995168458123.b4-review@b4>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3f4477b0-1aa7-47f8-97e6-3391dce81d94@gmail.com>
 <179492784365.252888.8046542995168458123.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Nov 2026 10:45:02 -0500
X-Gm-Features: AclHuK_5a_CWY3eyePiMVGgAZ7R1CudxCFS7pxjr300g8h0-X7e_giPEuAgHjVk
Message-ID: <CAJnxHsigzKsFzHFwcfQej2rWLZaQBmiJv2HYgjC7rVBUxS-4Ng@mail.gmail.com>
Subject: Re: [PATCH 1/6] usb: gadget: composite: bound ep0 requests to the
 request buffer
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On Tue, 17 Nov 2026 at 16:04, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
> Looking a bit more, I've found the mentioned one but it has a different
> sha:
>
> commit 153a2d7e3350 ("USB: gadget: detect too-big endpoint 0 requests")
>
> Can we please update the commit message?

You're right, sorry: 36dfdf11af49 is a stable backport of it, and
153a2d7e3350 is the mainline commit. The paragraph should read:

  Linux closed this for all of its composite functions in one place,
  commit 153a2d7e3350 ("USB: gadget: detect too-big endpoint 0
  requests"), and barebox carries the same check: stall an OUT request

As I wrote to Tom on 10 November [1], I am not sending new revisions of
my series, so if you apply this one, could you make that change while
applying, as with the Fixes tags on 6/6?

Thank you for the review.

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/639858.html

Ana
