Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F39AC5ACAB
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1D41607CB;
	Fri,  7 Aug 2026 21:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUdk8wn__H4E; Fri,  7 Aug 2026 21:23:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 625E6607C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786137816;
	bh=o+NnlomviGL8XYz6oQmCbnsmY0hsTpP96iQJB4J9EWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2KmgUBS4Lgpjv+x70VjHUNm/DF5eBa9dZi1HWPC6RPXSvq01xk2YXOI0B3HHax/S
	 fp88ymI3IuiIy9tAxoFZCbbAyaVkmvEzyGmKab2y69l7qDLBkwW+XeBGpgpN2Qf78i
	 N2DAZ0BoQOjBvlC/WQu8wKfhSZMyT1RDkVl29dLJcufn+E3cwTsGmgNIjGeMsLrWMe
	 A2Y6q2mnSRyhqYLtZGYGmy1sTzqbMsJAF1btrmYrlbS+J/N6BE2EmHyzNHsx+NII/5
	 0f6hePC8rTQN48n+dHKYUOCl1Qs9I1mxLn1dNWO/gV1xuac8kpUA+Bs76uCf8U+DoL
	 0OehyOEiFkbfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 625E6607C6;
	Fri,  7 Aug 2026 21:23:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE0CB296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFBA6607C6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZPpB_shjaff for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:23:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DC918607C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC918607C1
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC918607C1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:33 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso6766555a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 14:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786137812; cv=none;
 d=google.com; s=arc-20260327;
 b=srzlikcgDxFWAQipSnrqXzQY95FcmduGyG2jyiX3Gfx9dUuAGfY+BUretDOHbBSlhI
 RyGM3QoQwzZp/IK5NxIPfBRFm5PajJ827l7H16GvFRAeBKH7O9kGdvlFaJ0o1Kqwdbas
 HUEtSh5UfmFmuHB8qXSHDkWAXuTYjKnKQymb6fr9c5ttyJJeNTNMWLaU3/fvmaRzTywJ
 KqyxXD0WVeqGwE0Lej2SyJk5kqoh7/+8KUaIdzSxhXA9cfg8FBc0YKBtZZSEy6gXxVd0
 Du8f0JdOwr+iQTO+BdBTyLz/5zfQ37JelQeXbNEVGZ2MRltdcj/Uk2POBYzSup0Xkhy9
 NsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o+NnlomviGL8XYz6oQmCbnsmY0hsTpP96iQJB4J9EWI=;
 fh=mEuUZ6tsnElPxCn63zw7bo8LA8MVoEBQzi04/efIhJg=;
 b=n49gw6hHLNBi0pg5fwv6atkrf1UsPrUX6x+d1u/j3yQYbXlqLqy7GvRvxdyIuQytiC
 2XwfwyxtW/odnXYdb1w0e6j4FpXZ+O0CkA/ITQvaPAXs7KRZSpzQU08C29nBQSMNnniq
 vp0Euz5KDMfpMzd+Ka636dnovq7iE0oXWhDgHU02aVy1lGmUoA/RSq5yAlb0C30PAqu9
 Ka0U6VeEa+7L+1IwLdtJi1TThompydcLHmI54QKTDbjWKbuw80tzujg9yTXiRARS7qBW
 W6ZPgyJAzrgK/QgciRTO29rT9UYqaVqw5YWg7UrNNEK4eiSTI3eQbhsO+IJGF+hBLmhO
 1cLw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786137812; x=1786742612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o+NnlomviGL8XYz6oQmCbnsmY0hsTpP96iQJB4J9EWI=;
 b=FxO24UDRcwIQrH5ArriF438C3XUG7eiweOntYjYa2U0fw2Kr8l4W5bKmCXn/1vhcEh
 OKZ3HFD+1dloyOKjJ30rEbKJea9l+n2KsaL90upvIlw1qZZ/Zb6oky7g0+VDVxwFd8QA
 YRJhE0NJW0l2+uvsLfrv6Vk8iW6XQ2i89J+cSJY0fTP+Gm3TcP3LFh4KP51UGL7QYFqm
 g7xJpLwt88WuURW9OnIEe5XaMphb3yYO4G3obARdAn15e3VB5K62JI22dxhic3oncCu6
 ZeEBGPf7UPdmsVPif8OSxeLsVr4tSSOSMoAgru1odbOg+ZeLbnMurH7ICE/LFPUqNWdY
 cejg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvQFUbxb4CSrcWGUoHd8f/bJIQNPX2Sx5yqL/cMKCaBgwwWNV7BFuW3j4Xc3YfUYpV1mmXqbA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzXV/UzwQdnRqWSpef8JWs9KZn/gPUi+hRY8qi4ErmvU8rKgSkO
 D03qVx+OWK3IzF4/OSTeifUAv8vkL1wZMsfocszzqOqewF/jVwk3e71xuZPIayDpCF1gVp93Ncj
 xWB/h7yGAh0SxL0JYkqm6/e+K/0lq+fhmrvE+luBKpxJZyXwHuh8GlQ==
X-Gm-Gg: AR+sD13XUSwvAiFp3eXZOgQPWSBtFe/0X/BzaxswS0Q7lCp714h5MHSZaK/mnsa8t9r
 WWpqqWRMVsl0PBubkAWaKu++IDe/UFrJlm84RzuW0rJgXFvZwBAz4gBApLR1Zc8sD+y3EHZ82eb
 8olgGvUpxhoxVmPfXFhkRKfcxnOFWszU5B0Bp5/DRkGpMLPKQ4k6CrZwo6/v7opgfWF8qSivszH
 oorpplziTn+74uXb1ltc0MBhpsg5X35E0aQxgixyrWQPf8l2RmZLkbTJ+nkxk5BghEe2wRCnYtT
 +xN2Z7We43nmQziaCdU3tmA5mvfNqwGsDPglBXxqEjU=
X-Received: by 2002:a05:6402:21d8:b0:6a1:e59c:62bd with SMTP id
 4fb4d7f45d1cf-6a1e59c6678mr3352935a12.3.1786137811832; Fri, 07 Aug 2026
 14:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-qemu-x86-pflash-v2-0-f3896316eb66@elliotjb.com>
 <20260807-qemu-x86-pflash-v2-1-f3896316eb66@elliotjb.com>
In-Reply-To: <20260807-qemu-x86-pflash-v2-1-f3896316eb66@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 15:23:20 -0600
X-Gm-Features: AUfX_mzD3rUxUikKwQILDP0-7eD93DtofwCeUifLjKKYSe8oTERjcZnYdaQmkLE
Message-ID: <CAFLszTjbhm6x_6WnuA4=8Mpx97Abz6Ru7qkjqqah2PeHQa-otA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86: qemu: Describe pflash
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786137812; x=1786742612;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o+NnlomviGL8XYz6oQmCbnsmY0hsTpP96iQJB4J9EWI=;
 b=fDVKpAlO4JNzlU0B/zsFRDFhFuAQE94l/cNE1m8aavLLlyiJBxKZq+tidAkSr51SpB
 5AFi/ydo8yZxh9LOuXFTrd08GEhFGzGGDB05Vgt1tOcv89dikAuTAhU7aMxA64YY/B3S
 0Qz8+TLc+319OH4k2AbO2LNYHyqb2u5Po4bRc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fDVKpAlO
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

Hi Elliot,

On 2026-08-07T18:07:09, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: qemu: Describe pflash
>
> QEMU pflash is mapped just below 4GiB. Describe it as a cfi-flash
> node so the MTD subsystem can probe it. When a flash device is not
> exposed to the guest by QEMU, the address is still backed by ROM, so
> we'll just see no flash found rather than faulting.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> arch/x86/dts/pflash.dtsi         | 18 ++++++++++++++++++
>  arch/x86/dts/qemu-x86_i440fx.dts |  1 +
>  arch/x86/dts/qemu-x86_q35.dts    |  1 +
>  3 files changed, 20 insertions(+)

> diff --git a/arch/x86/dts/pflash.dtsi b/arch/x86/dts/pflash.dtsi
> @@ -0,0 +1,18 @@
> + * The actual pflash start is driven by QEMU using, based on the size of U-Boot ROM size.
> + * We assume u-boot is loaded as the -pflash/-bios option

This sentence does not parse. Please can you reword it, e.g. 'QEMU
derives the pflash start from the size of the image passed with
-pflash, so this matches only when U-Boot itself is the pflash/bios
image'? Also 'u-boot' should be 'U-Boot' in prose.

With those fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
