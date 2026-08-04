Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B2FC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3358B406E0;
	Tue,  4 Aug 2026 14:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hk4g3VAtanOT; Tue,  4 Aug 2026 14:47:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A97E40680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785854849;
	bh=IA99tyjJeHGKHovb12ur1c8cpH52k+bBWtZebGUO5QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPm1+fKhOyo/fWQe6sAsf7WrKfdgc6GvzxxBQ8sNj5Jv92x7d68w0uMHQVzBcTX9M
	 jFgYwv/velsOY+gojMgiLRrFGVimAtag0ARSNZSLaDSg0NI3JgKMVOjL4oVZmePpgA
	 PMMBWmrllN9H8EvI1rIbVmiWfCubzD0xG1V+zHMrvsAJ5+V9cM8H55+HWqsu4BHAWd
	 mhihxUwCzrdlbLQGOcWB9hYmraGUQsSDItuIgFf5an9TDhZZca2R3Pi/S74+xhZq6n
	 ny1avIIGaL+YMCH8+m7Kj/L6dZUbCesW5ko79SKcnUeOahBIPcWyzudizE011sjpQk
	 J6V8wh8FLDgxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A97E40680;
	Tue,  4 Aug 2026 14:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C050023F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A67806065E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0iKy7xPFw84 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:47:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0E9FA60633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E9FA60633
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E9FA60633
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:47:26 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cab973140bso59204635ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854846; cv=none;
 d=google.com; s=arc-20260327;
 b=b8MlIM+DyECyyYI3tBuiq/pK95whtne36wLprdg4jrGcgbV+G+VI9/pDckgV6H41Ef
 z+CL4XQYzpTmPM7N7LQz627F8xJIPuo3z2c6r0N56+T0yWGMEp907/HPRxWIZVDcE4CV
 XINSpReJphj+NBigT6icohIPC3p8xDnLq7vQIB6+ytxKDEAaGYMfkxsyzFqqHQubCOXg
 rY+6AUJi3yD/yw8avrR8JWUtrqsxeBjaRDeZUSKoUpUVzXR2d3r5X27ZO/afVaPlFOEw
 vpyjY0LeZFhxPPQUjyvI/Uoz1WtYjdeaZ9yMT2vWQ5Xbk8U4ME2NjQijOiaFFRz8+cHh
 Kmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IA99tyjJeHGKHovb12ur1c8cpH52k+bBWtZebGUO5QM=;
 fh=qgasSHWK9ABu1C4X6rYrv/IN0O2UMctworj4pvZ1u7s=;
 b=SUoPZBuEjFyW+nf/xUi24dpwpujqlTJjGqiDczSw8wfO++FY4rfJcBXLHFl7hQPG4d
 TkWM/O4t6vvuxcN9BeBzYTMkZ+6tOBve+sZcBVVt7PPnXJpOiBbUDiy+k3yIKUPB3isf
 5qoyHN3sRtua8nKz1aUc/yIqWQpB4d1K5jLB1mIE3PA+C/J+u0dC/TPuhvx7EniohLig
 DyJzkiz0gcvP26cAYROn2faG38LwsStR4cw4Oi0StZQCKxIRX1H3Nle6YJln9GBD4dk5
 qWrOhaJ+bWS3wK/dLcPh1nwokhP3+wqiYPRBzYn73kxcqpbKKNWnJlEJIeJFZOPCn3yz
 WPCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785854846; x=1786459646;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IA99tyjJeHGKHovb12ur1c8cpH52k+bBWtZebGUO5QM=;
 b=dVPeebqSGOpoVLOgtJqdyvqF8I/beCbc2+nwrQ3SSIGp8JK7YXdlPwn+UFH5/QZWmE
 0a0ZQ76pfZgl5C+KkQPfLOPFYkKbw0xRSeQ4hZHEB7UqOleJXIXNusgaBah80HBtQtfS
 q7Pqnw/uJ+ZD7Y0KQWxZY9ROolGMhQDHbvRyv2DBilz2E/yhp59qfU+NU46QzewVhXjr
 TtfQZTnMbZHxjuSa3DOCu3oX2CuuIjlpmTc9jQOK/BflJdRdItwu4yB060R1RHZ+4X/R
 9XSqZvhx6sezwBJsbNczilW2RNjtfm3rahGLRrFqfVCL68gjgMwjkrHQzo/om4lGu8Ff
 YVpQ==
X-Gm-Message-State: AOJu0YzylgRWuX0Uws3/8/iZoyv4QFb0sNcht3xKE2YZGjh/YHIcQ7dx
 QOch6REZLTZFzFhU0r9APNr4U/O+7HoS6JiAELpJhddbtuMrBNP4gdWxDuKgoVio7PteTKofe5o
 W9RChqPLrikW1n1q//cPz2tb/3eHFCbi1BIGHR20vgw==
X-Gm-Gg: AR+sD12EODfBgAI2WyfXj1oPe4zvttoLtIXEFbWwlPlennFejacKR2qoRzh2li+DnDT
 hxBm8AppYfxpSzGCgmjSRFsQgCh8GvHX46ckAcVdTqa3eyd7Rutr3VZevJQUEtgOZINxR0AY88M
 LwTcI6nxmxvM7PJ5RjrjZNTmZVsna8j0oNQQN3TLS4OweTro51ccm7bkVGpJhiMNPFGdSlypIiR
 6nt85rF6sHDlm09UE4CNtSoDRXM26EtWtZNCE3M8xtW9qskFOnZy0D5U19CfuxkIiLDpKnZBRhP
 b1+VgeKjCsr0mna3hbVauT5u6PNJ+NlmxMQipd3YrEFNQRd26tvKwnv1MPQ0VG39lZvFdq/bdwW
 J
X-Received: by 2002:a17:903:3890:b0:2c9:97a7:3276 with SMTP id
 d9443c01a7336-2d0523e1967mr152943705ad.39.1785854846175; Tue, 04 Aug 2026
 07:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <CAFLszThEcG5J7vzmAe2hFXEu7vbCzhTiT5QB9v0ib6c6C8pWWw@mail.gmail.com>
In-Reply-To: <CAFLszThEcG5J7vzmAe2hFXEu7vbCzhTiT5QB9v0ib6c6C8pWWw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:47:13 +0400
X-Gm-Features: AUfX_mwZX78w86RgYW-cqeZEK6Byk9yZFIExm-VT-1x4ONVo_DOLzraxJpIInH8
Message-ID: <CAKTNdwH2EHkj1-zcniKCB5NGU8w8oBfVzfeLsVuYZFX61eG6fQ@mail.gmail.com>
Subject: Re: [v2,
 00/10] spl: Add support for Falcon mode with ARM Trusted Firmware
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785854846; x=1786459646;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IA99tyjJeHGKHovb12ur1c8cpH52k+bBWtZebGUO5QM=;
 b=VgAZs2dz5RpCGomN1ivepBeSmNVxz1OAyxEBUsno5QDIemVKsaKyc8eeB9yvZyy6Yt
 cV3xvmsQwimFAF+zfeggBqx9K1XGiRRYR5Gk+xB+uySOP53zeOH1vBcywwRtXdpoXHt+
 GFEmsBlsG6WKqFHxTHw45ge2VrSzV4VD5Vu7jXrW0IkYMrraXRvw1ul7KuMME9vpL+Kh
 Q7ewbMgG64d1qLWRqWhTfuMUHfUBSxi1+RCwClC1wBxWxKEenMCtliZa4edFkZFUOkSb
 DXcQ1BjPJ8VOSSl5caVOWm5IwgkxI4AQw8tsaqP/nEvCoIk80wLTiHI+eFUeLAQOqQSN
 sq8w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=VgAZs2dz
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:05=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > binman: tests: Add test coverage for a FIT with embedded Linux+initrd a=
nd /chosen
> ...
>
> > This has been tested with an uncompressed ARM64 Image as the payload, a=
s
> > well as with a GZip-compressed one (using existing SPL_GZIP functionali=
ty)
>
> Just to check - is there any test coverage for the SPL side (the
> atf/UFS/Falcon-decision changes in patches 1-3), or is that all
> board-level? A sandbox_spl test for the caching behaviour in patch 1
> would be nice if feasible, since that is generic code.

Oof. I'll need to check what the sandbox SPL implementation can do.
The whole Falcon thing is quite SoC specific. Let me give it a try.

Best regards,
Alexey
