Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FFAC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 20:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B1C76082B;
	Mon, 17 Aug 2026 20:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cdha_QB33YYX; Mon, 17 Aug 2026 20:36:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44F80607C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786999015;
	bh=3bYT3hm4RT0IC5PTmjPckUiqGfq23ClBuACYdAvWWf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efmtDDmpRXGi21nKox6EY4+CGQAQsR/zGow3RqkUkhydKX+MqRDvj0FnQUEz7ZVNy
	 kL0SUE8+/nM3MLfcv8T6R0jxG0oYhB5C9R8+8LQlMR0+qufWjNe/xDYbGFW59RDwvn
	 bT3iIkVFaFpufKU4pWgIzyooZVmUim0auHQo8ZKr6PSZhHjWvcSoLloMbhYJn4IjT4
	 ajmmLKVXmCB+9JIq/LgXBo4SrXxYAsNjfI5SNVaN/jHeuV7BRoeNRJZToDW4iIo8KF
	 msKZ2lTAMvefDQpI+vKrdGPplccmwdX6xY/TBzpn6Rbc8TDMc5wKtEJ8uBcqvGyBwa
	 AhDhDLA0vunzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44F80607C9;
	Mon, 17 Aug 2026 20:36:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14DC1334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEB084058C
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxY3kok-NzNW for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 20:36:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E67340586
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E67340586
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ih/7yltv
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E67340586
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:36:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA347601FB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476A1F00A3E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 20:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786999010;
 bh=3bYT3hm4RT0IC5PTmjPckUiqGfq23ClBuACYdAvWWf4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Ih/7yltvRGAKMuj1ghjusgmJHkwQMK96WuUv4QbRY6CXg1F9rzNyubYWUfB4K790B
 s6iA6VRkQTCEgracz038aAqRxKHkLbKkNMAJBLowde4jXL9jk7R0eTyLGdL7NQ8M4/
 E/6bY/jWnjRWfTMGbyK7DmByLGFGt5XyURLY0jDMvRTrApTcGhaN7BqxOiGu6DBtrq
 7Zf+cxMzUKfEkOoQvKV6k+FV/qD04SWJrFQdQfPo90AUkAhgGF7dl/HHiAFpEVG+M2
 ysLgBUXrfIuA99ZCYvarZxl1y4PeborCTHs3XZAiAQEZdTxaIE60vHZaMLJQkVVY5Y
 Q0+qVb6cpRZ7A==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aec201b582so3443442e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 13:36:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcsUvwwWe1BP7Nz7cF3HiMLVHHndgsyUWHzen7bzWEJXinfIEp
 bSt7opqdpKnBZLAQ/juy1R+nAey2iDCzVTLyXfOsz4U56A8MQrEYvgbzJILkKpdmnwS15Djvkbu
 B9lT4XdEQDHQc8ctjZ4EMGsb02+bSYOA=
X-Received: by 2002:a05:6512:3409:b0:5ae:b136:acdc with SMTP id
 2adb3069b0e04-5b45917eafamr3726673e87.35.1786999009130; Mon, 17 Aug 2026
 13:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org>
 <aoM7BEBLYau0Y_ux@linaro.org>
In-Reply-To: <aoM7BEBLYau0Y_ux@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 22:36:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-9_Dm9es2kn2zfKtByXc_fY=sxWM+_c3Xu3So-cA5iw@mail.gmail.com>
X-Gm-Features: AcwNN1W6oNFMnKED8IQTefHXeaXrnbRwqeUJQnU3L7Q4tNt58r4t-lkBHDcMxgo
Message-ID: <CAD++jLm-9_Dm9es2kn2zfKtByXc_fY=sxWM+_c3Xu3So-cA5iw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arm: u8500: Give Golden panel regulators unique
 names
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 17, 2026 at 6:47=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> I think it's a bit awkward to have multiple regulators with the same
> name, even on Linux when looking at debugfs for example.
>
> Can you make this change on the Linux side and backport it here?

You're right of course:
https://lore.kernel.org/linux-arm-kernel/20260817-ux500-dts-fixes-v1-1-2437=
9c6c2495@kernel.org/T/#u

I don't know if U-Boot backport device tree changes? Isn't it like
a scripted upstream sync?

> Or maybe we can use the regulator names from the schematics if we have
> that (I don't remember :') ).

No we don't have them...

Yours,
Linus Walleij
