Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403C1CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12F8A60763;
	Mon, 19 Oct 2026 09:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6Kmo9zESE2c; Mon, 19 Oct 2026 09:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 424B5605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401857;
	b=dWdWVEdQlsz/mTg+8YRobFtYEV9yuJWS5FHiPaw8zyYPrcvjbVEfauWGhUSSHLTPRCD2
	 zAQAHWU39UfwwWwF5xe8uWQ25DG7GOxxa1lqTKgEdv1bu+C/Im3W9t9fSaanWqV1jt9A3
	 L+h+hLUFlyXh6Akl8bVmalFkTopPPAoKkKA7KEdG7B4Pvytty2srnimpLsgMQH2H/bKlD
	 sjmdBxUR1VpnIgbNbCroMf0HPsWn97v1+5DrHUm5eIWFtmKm1dODc7giLMhLm0VVuJ1iu
	 Y3gPyp6igxuZcm1813Vkim6OB/tonOApfbOocup86FEg5BuybW8BEGeo/7RWprnfODA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
	b=Z7AnpuYc9eOpiGJbhGOwWOIWyxKiJnQSyXk6+sBk6vjpYEcwuvNDmQkzsXKCPzA02cpN
	 6iF+GDZYVBsx8RoTrPVx1jKHEOCnUVm1J4I/DoOR2BojR/nVHN/h1EJbr9WdUJlkIro/f
	 R2RT1zKFkD0nXkTW1BEeTFpnHJeM7hmmhGSiCzOJ86o80fbbO87PKx673zjqWxHe6Nfl9
	 39/FA8tHVRYN0v3VuE3Jrp2xcbrazr15omUFs9zg+CKNf8AMb4PZyiP1S8hHjJufGLPfM
	 JyeHra3MLmMcKZ77eZ0gIbCQKyHsgc47L+v87EXBIkkTWmx9Z5cNzYfQq+P9FWK+rCw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401857;
	bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIPvN6IV0n+dvSM0qbhBh/ci6CCJMDie/oYHxKhPHFa+JxIlHA65o2pSmCX5voDUC
	 y3U7Kt0mSZcqDDbEBSNMOzXGfsp/cqoUIVzzuAcY3PpWQX4j51I6FmzIGevIXZj2Q5
	 RrxUARCJcZ9GzJ5OtfotL7hVNRZ/sKAvrr5F4UMz0OgPNbDDxL7BVlL/Amha/jMzyG
	 L98HmJ4F2s0ogIE1tpt+VKfJHyfDCqc1jcndxVkdA40+qsIvJ7VtbBDp6ZGPvwBK9k
	 tOW0Hi5roQRj1/acPyY9k3WXOYOtd0Wz6e9tOFuFqKCUXmEOpkve88WVeb944qmaCc
	 nj3y8nL4O8FZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 424B5605F1;
	Mon, 19 Oct 2026 09:24:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61142D7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EBD180DFF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q3X4w0DNPc8j for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:24:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE8CE80DCA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401854;
 b=QQ8IWLrjdOSj9DxYuSk2jc/nWls+gk4maCBkA2hxOXcN18HfGQdFXVIpjjY5nXU2o5IW
 p/KHROqM5zeunY3Ronp6zYXpP58nfZTSkRnGbSqSPR6EstsfIemcpgMhYeSUfDkbFghXu
 dwrzggsRgLMJsDo+0OZJ6zo1mtIL9exzzQdvJuxLDDw8iTS5JCgFSb/hLHWKYtO9Qkxuw
 aAb3tCqhh4n80flZvDEXQYaMD7+xQq2y+NzoEujp4SH+uojpKIwfqX/l+UUx0pSTwzuPO
 WC5u84xnGjRe8gSu2e8RTl5B9shVfYIiUWrGH+b45UbM02bDjDMUzOq5GITt8inwdAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401854;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
 b=aamv8VLSV8MBFsa7F1Ew3xpNkIz9lI0Bj6gyMvWxh8wBrwuaCU66mtLbu0Zk0sDiVm52
 z+2C9bIod5k59lTYFspfd1M1nvFIZqJhHQmXYMQ5PYhrv/m2Y9HEITIXPmJIZigCV/FBp
 r/RoVlN1fmPXzUPIrll9os/lU2sALeo5K5IhWNZ4GjEp9E4wzqnedwM1jyHo3XkOiokvN
 roYA96lECZUP1mofBn+2kpf6KM4TqmBipUVz9qh4P26c2kVRr57lBA0EVnOtI2SNIPBKx
 AM8Q5/nr+iv1EsDakUsfZylgXpBVfwIriw/C1pLi9hEVEFo2yjomWYEDGyhBq2N/i2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U0aDZk06; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U0aDZk06
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE8CE80DCA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:13 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1083977a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401853; cv=none;
 d=google.com; s=arc-20260327;
 b=GxBmCBlAz+DWv045kfZa2toA3iKP1xTfaOU9vYfW0I4Y41kxaQl90oicgxu9+aSCDo
 ZuJgc5yZJevEsUpq7cS9jr17eh6G98dN0rQO7+5ZtjjL5eOs1z6yFMBcW1HHINeYT7qP
 oA04iDnF+jqdDsAyOZ7bei5sASZDgK0dKZv7WDzMEpGZlkd9q6bp9ywzHRFNj5tGORdy
 YwNuptoQpk6ViOUFuOQSXIr2coXmhBDpchdBqKPuwgZHNaHmYD38gENdWJeGdH7ivtlK
 LEH8fcbhTJu7J/jyrwKqxpCJg4ll3KuuDtexktNDT3AZqO0WaIu2SVZoRs9ZFuFPUhfj
 LMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=FNgSwexFYqXMPHTcBHAIvYAFQ45gs+yo/bzaNjISCyf4ju9XRuaakTTlNwOsDf4JDq
 JnYjwPYMSgGWtwhQgBu0s5hW+cdbGbmb9gNldAkFjv2WupyY1ei7SGFMQPMFRxFCmT7b
 4LGmqV7KKfbkT+uvvBIKFBNalY3howYTZHAH5A4heS/w6kNH/Ti2M0x9JkNWJgDXVFge
 wh7+8FCcEyW2Sq/zXHTs+IywLXQCOPdzTdmFILW10gCydkLNjF8XwhjZtmwoCWXxxU/t
 MBrMakOslYX7I1QSFcVbsRnCg5BYFBwzjA9q2EplEF1nD2apqspEmxMyZeDgO2fbU5kj
 01yQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401853; x=1793006653;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
 b=U0aDZk06MKqtf6RaF2kNhzzsy7w7xtlcryG7N3Vi9TIdXyl5lrtQ5FQc9ITRXV0I/W
 s9SSBZyD/r980PYJj7u65uGQ3TlSApEZBjd0B3DmN37mEYcvUvf4bANuRkL3IiJXkEo1
 tfTFfz89NuVeV4MOpQhai5GRYWvfLuh7Hzp3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401853; x=1793006653;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K71ohl9KJHuMk0i95XufBVrWpc35UrhvjEOnH5kvZhQ=;
 b=Uc+3rBQc4/EQ0EJsGhO657cc/0yr/5fMb5TfjBXU9bnT26dtpuDybo0CnSm7fJ0c6j
 hik7kdm88jXrVobZVQkMVJjbStxBIyfBXR3P1HmmJFHtYLcAtfcusOXxiKa6M98wfvyU
 HXADjWOAYE4/0Mfe2SQDCGQnDjc71n05bX4p5y3hkthWoa+lop5pWZDYzkSao8HsTg3d
 4aQKOm9HGkDniLvhi2+AKGbHufOWCA4IdlivbUXfG0lhPHWsreEv010uRHPQlYDlgkzR
 C1zMnBS15CLyY0eFTf8gxG8G++NnP4mDSD3q1CR4mSFgYxmBGyYoeeTzrdv+6q/Tck6y
 E3/w==
X-Gm-Message-State: AFq9FYJGjofX24kkKHr3fEq/tzjzK8oLa+X5LEQ7vDmhDbc7hhZFtRTv
 pSKnZOycZ01T3Cka+cy33lhRSAc9SYzlSxpSoFF2qRhHPwRQZvsdHc0VMByjKx0miHGzNnjViH1
 jkZVAM15I+qz5Hx1DXn3greoMSOztYpy0DA8PXdcW
X-Gm-Gg: AYBFou0YTpMNdA1czpmypKX96cZ1PFKv1pwSljSmNs4cI9vZZ5e/c5CixeuheijY248
 nbu4qOn+uMXTc0xPHlXKJgAi2TEW2WkedWQRelLdfhP1xiCT9KSBSfyJ3YKR1AQDiJkw0M4xHtK
 K/Qljuy8TfbU2B3KC2D5oc71730ZO9bnv2/BnuK2uTJAQ8MIQE8ThJfoRqnTQMsCgl3X8Ps75ds
 4edDo1Z0HUO73HXdRnHuYUA4mId7ksbtDiv3uVzGVOC+IuwMcHjmKSf8FA6493l3lXoZYdXQARv
 SUhURcvP2OSqXg3PnL3Hd9lvohQvPogDITNHeDB9A54fJSpNECauFQ==
X-Received: by 2002:a17:90b:1805:b0:3ab:c6d:2bf9 with SMTP id
 98e67ed59e1d1-3acef5b0dd5mr6042712a91.57.1792401852925; Mon, 19 Oct 2026
 02:24:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:24:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 06:36:35 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-6-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-6-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:24:07 -0700
X-Gm-Features: AclHuK-dCDwS7LwXIdXWt9_aJBcqHG2ouYKSwNd9C3G_DWHEa5sbZljBrfqN_cc
Message-ID: <CAFLszTje25SBmhVoKhQ7=Vpv4nSGe-6-r4KHaq7APR584X5NPw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] rockchip: Allow compression of the FDT in the FIT
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> rockchip: Allow compression of the FDT in the FIT
>
> Compressing the FDT shrinks the FIT at the cost of decompression time
> in SPL.
>
> Define FIT_FDT_COMP from the SPL_FIT_FDT_COMP choice and use it in the
> @fdt-SEQ template via 'fit,compress'.
>
> This has no effect on any current board as no in-tree Rockchip defconfig
> selects a compression.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> arch/arm/dts/rockchip-u-boot.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
