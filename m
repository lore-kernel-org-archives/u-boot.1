Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA30C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC51140A35;
	Tue, 28 Jul 2026 18:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHQzYSmxzogK; Tue, 28 Jul 2026 18:53:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A2CF40A20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264795;
	bh=yDXt1aXTiPZo+EaLTW9lulv81cHeAIoz7nYOCu5AfBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSOB6eK6nmyG9i1wrRR2Vr+qmmeC/b3JOBLW8AyXfQnBZIiuNQhOygOKbGRkha0oq
	 WIgCLSpqQrc+p8W6tEQoF0yjm9W/Pd3GXA97UtFuN6BjZ5RwkBjWO3DsdVDHJ08ddW
	 0bp9raNrESIQJ0qZ73Op5y+jH4dghO+Iz+19iz8Js+21KRhiyzRb9kipvZ00az5+JI
	 naV3lDfS5GDL1Eh4CT5HYyfpHKtUNriK2qXn10lYaGYJDZ33M/MaoSE7nxnvjFgFDu
	 4yOcAEEbHDEb1rwfeNeNe7VZ0Dk3D81RtB10oKszFdAf3KQYuHor6gt87hubeCJjDZ
	 UTXDFJzAgR0Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A2CF40A20;
	Tue, 28 Jul 2026 18:53:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 289F4350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F6E6608F2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VK3-S52Pbrfj for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:53:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4038E608E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4038E608E7
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4038E608E7
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:13 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso158839a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264791; cv=none;
 d=google.com; s=arc-20260327;
 b=kT4wrnQZQJ7iPfXd0b/pN7QQNDaPVmvkjUAB0y41Rbent58R3pcR6AAcHIIEHN9XK6
 qRBE2/XQuOjoXM1TAVaDz2DhOtM+2X72bAqpmvL0AFKB6jh8DelPTfJJxDa3BFoHvkRs
 S7ObDrGX3av1lhG5hGcEj+/1Z8dlQFN2u+20ScwyySHgb3Fy9EKeQRpg2WWFFdRqcmSW
 ms2TQxQ6tjWfcd2x5TMGwxJzo9ASMXSJ249bvb+o48w3qOsawhCITxsNiNEdnCjIOniY
 IxclxmgrJ8RhvgK6xzooL145Flo2TQNJMNj02DGOCqrVpOPBcjhbe71XukGbz3obLF4H
 Gxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yDXt1aXTiPZo+EaLTW9lulv81cHeAIoz7nYOCu5AfBU=;
 fh=EDy82JKB8qni1w/4iriOly/3FEue3DvO3zKVD90AY6w=;
 b=bY6u6VEbXBaXwc9IeYoA4LaMiBzeFcOAp1Clgct667ZUIJhhvn9Ph1QVhatkzPh+ob
 7HpBNtGW4Clkz505M7WQhdjlTv+Ro6P+Km/6HvwR8hDwI6Emgnuk0CIMWnTcycNfGiLl
 273DJb7O78CT74xvg797w1LJTVFWZU06RowMMcBX1zA7Rft41/xp1HPae66gRdEZYE72
 30qYj3MCcKyUxi7pddyVq4D3iLUhfSd6jGY3hzK3zhF4pgftzc5aPigLV5COn3ZFdjKb
 Twn4fC+v6S2JTTcqE6N12u1J9I+jmuB3R1cJQgApvhW/O6whvFhCR2uwcGS345xkO8VX
 XEkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264791; x=1785869591;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yDXt1aXTiPZo+EaLTW9lulv81cHeAIoz7nYOCu5AfBU=;
 b=EMXd9LaUDvDk2MMkZXlgXEzxnKU+9UdQFVT4jXHMGGn3DCvlkYzHCIt356RDjxVsUn
 R9ErvBbmdIi8JOqm4zdfCVHjWsfvcKIN0Bnt9dFOR7kLdFNhRo7IbKvySi8VvjOJK/Sa
 ffIeCth67UofCk4KTjiYLwXmPDhgKvCtOFTovnGi0qJOtsqRrWSZODRBqffL64lPR6S5
 9U7Zyr4+FZQBEc7ruFEu8HIZLTCvvbsIC/7+fYe07X9Hym1BYiipgqMLQh+QcN7Y9JE8
 IOkRNZ9X9uXKonOXKbVCBtOfqGJX/EurrDFhU/Ssv8DHXb8FjfLWb+qisl/n0qFARXV3
 sZfw==
X-Gm-Message-State: AOJu0YxDx0VPS/DcpMched34oaB7HiO6lQk11EUCPOWNXa/+DPaMptkK
 OIXbObSxpMHkfvR7oSoenDUIv7V3ueNBiaaSQkaeao8VSDoo/3sVdqdq2JeY2wnd08c1E6xG22I
 fe4P8Lapn2TC5KVKFJEfEQEILqjK7dm4AXZyMGKp0Nai7F2sSM5s=
X-Gm-Gg: AR+sD11qkATguehbqdiaysPyme2zMt4JXQD+LO4F+6luj3nlBLeRRc8yGdHGInYvT+H
 TJZVrQcOcEUGh7r4V0ZbxEFnnWZTjZuIAO7LvvM99mV3H9t75xmmABJmGceRfc2L+w2nR8Wqxc1
 lmnPeocycukEF57t+qIa2CbkhP2M/3x+Vty+IXF+5YV8/KHNITN+sDI0H2VmZaZZpNbe4AKaoDJ
 uPjSia5X563QzWRGUpoFSFLMvEFFOW4hR+YWI1Df//AxA/x2rw99/10CsfA
X-Received: by 2002:a05:6402:11cc:b0:698:870b:ac8c with SMTP id
 4fb4d7f45d1cf-6a034a79aa1mr1962490a12.36.1785264791292; Tue, 28 Jul 2026
 11:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:52:57 -0600
X-Gm-Features: AUfX_mzrvQwQMlQNkYtWGzSYhRC572gdcgAGWtFvYklrsHvFDaHEJ04M35X4UfE
Message-ID: <CAFLszTgw5qa7iE+5o5w2iRxV=38G3csTrj+_oF8cTiFzOh8W2Q@mail.gmail.com>
Subject: Re: [RFC,0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
To: bhargavdas100@gmail.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264791; x=1785869591;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDXt1aXTiPZo+EaLTW9lulv81cHeAIoz7nYOCu5AfBU=;
 b=UKm2DW3FY3P89sqlO4qSSPeDgH5kmCyKpIkIPaapeDEVq26U2PvkwXCkKUgTOowbnQ
 Nj9IztFmX6KtsCxqgfRv8kOHukygPwI7ceiKrDGpEe0bDEqAzKz2rNOX8nPW6QvVuwCw
 WUUtbJgiT4oQmh8YLhjKw4VEYeL+8qNtbmhfw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UKm2DW3F
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

Hi Bhargav,

On 2026-07-26T11:56:45, Bhargav Das <bhargavdas100@gmail.com> wrote:

> Sent as an RFC to get feedback on the overall approach before polishing
> further.

Could you also add some docs under doc/board/raspberrypi/ describing
the SoC, what works, and the flashing/boot procedure. You already have
most of that material in this cover letter (the picotool steps and the
bootlog), so it should be easy to turn into a doc patch. It is also
the natural place to explain the 'why' that Peter asked about.

> This series selects CPU_V7M for RP2350. RP2350's Cortex-M33 core is
> Armv8-M since there is no CPU_V8M support in U-Boot yet. Is CPU_V7M
> acceptable as a starting point with CPU_V8M as a later follow-up?

Reusing CPU_V7M as a starting point seems reasonable - but a proper
CPU_V8M variant may be better down the road (you could mention that in
your docs).

Regards,
Simon
