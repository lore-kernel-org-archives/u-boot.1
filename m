Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B70F1061B15
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C67C83E7A;
	Mon, 30 Mar 2026 19:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b+C1gX2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7999583EB3; Mon, 30 Mar 2026 19:07:29 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE4983DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so619066166b.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774890445; cv=none;
 d=google.com; s=arc-20240605;
 b=bCkPnsZU2ykxkFXsS1nnTrhpnDvWtIRRJhuhuZlxg48+G06YPsKpY9tNTISm3CRRjW
 MC1H516XDxpUGDqvTuqvsimiTb6bn/rZNzQ/vN+wNXBuHArw6w0l0dG23fA0E8UiSQfi
 BzQ781tBGzL0suQSYg0BQzWBHrpJUOeWOBNJjbrSNkYjw+E2KzVtPZRkOEULHmM3jIy8
 NUKI5kZ1M3H3ZROQxasvrntyvWhJDtdI4vakFvz1XzdYEbLI/9ptp81l4JPhvUB4z0v2
 NpCy+1MkKoVqgKQ7EbT8kF+7AS1sH4Tvl8GWgimjuUsDeWGISWieJKIUoJbYAqwhRQJU
 l4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iKvROnt+ZE/pgwMbrkoZOTg5tHtBamwuKmLJ0hqr3r0=;
 fh=hLgiYueNGpzd2f4NDp+NzI61q13xsfS5U/qYGS83eTM=;
 b=h0dOdeEegbUYoASnRnjM/+bBcl4EL9z8ZNd7+jPPr1giuHaYwWMFf4QFqOsyLh8pM1
 ScJ+dsxBzDyjoF0+sWAWhLehO0sVcuHeQUun9H85gQvDeNy18drV1P2PZYJvs2w9Jwvg
 NPqgSmc4mN3vUU5HsCnMJ7G3ccPUzYxuUOsWNVAg6i3BaioNXYXWTYWjGeVWWd43Jwt3
 cK6jgAHwOlN573KnFN6dIDRhImuLS8oJBs6EjF6MwjHiJxYBiGb1erGpXa7okkiOL9M7
 rJ/ET/AryLy0r19w7WthJ6GT9NDaEXePMwMdJiKSP8CdtVmHK1Wduqqwdv/IAClDVtaB
 cNdg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774890445; x=1775495245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKvROnt+ZE/pgwMbrkoZOTg5tHtBamwuKmLJ0hqr3r0=;
 b=b+C1gX2stk8k6X/W+KwwPDTQaqSuFT2EdFLqmcsEKaazuFpsDptelKqlnz0XrjtNLg
 5AlWdr7lShUwrRQMcK8Y/9C2k4Ly1hJO7NlImDsLKyNRZqj1Zhwer7yt/6WdCWoOgn7V
 L9ISsrcH0ZmPe5h5owTiCY7DoalpCpT5VB1KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890445; x=1775495245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iKvROnt+ZE/pgwMbrkoZOTg5tHtBamwuKmLJ0hqr3r0=;
 b=m0qnvjWPK2KE2Lt5aG4R6F/GJxt9oLVGKn9ZM0QSDnK6TImDkUniP4rFDODPmsenwu
 pvVqa26n05WPYYfE1Zh7kmf0HMZjyljIp0oOBGeUfbdXFfyOcJPgFbpkzS0zzQePyvHn
 vBk0H9I5U0hpOtvOnp947WqbrY6PnKkrZNdXvgbOLMUEfSuaCEJgnsQZ5Hb/RSlYafeQ
 x1PZkRQr58tQhyzQmJGHFCKN8HTiorGerI9+mrpBF7ppOZX7Gx2a77GEGACPmslmBDWw
 slbvFuJa5qozNOvsZQgL/zlzot9qK7eiX7o/WYoH0q7TdH5Zhmw7dWLW47fXYuu5Keyq
 R1PQ==
X-Gm-Message-State: AOJu0Yx1/HyE43pKVT0Phljj5Y5Z0ihQfIUvRAsCaJU/K4xskPRXMutf
 a1CwCAwl6SmY/ruRUBM8XECoGgy77mLS/JnQUGGKoVPW/iVeV73oxOOiwsWBrebB5kh+qkpRgk9
 f4UYsQfRf1RMtMmW2alccra5DnT/05mQxseY4IKsC
X-Gm-Gg: ATEYQzyNn+AVOUoTAPZc9lMrl2nSvLhpt8DVUpR+AMOjwAPb6kMfLsxzvfzET2pxDCF
 cSwvTiTg5WfOA/8eTWsKQ4eyYqUe8KFsdfM0TSoe0F3Zx8yZPqRuwaUFz57D9qiDLv06SSPMu10
 IOR2cOghNtrrhS6+cQj0dR4eNKQFOi6n6BWbnGItPMHBkhecP1Vyav4Yb4RA1tAKtSwoV4Q8NKg
 MoMimtxEj0p/KNl+k7XCY/CmFdDsuOG4zpEdMyr7I7xbHtRUfVxHKUtRSKbBu5TZbsP0UhuIi0s
 WLL9lA==
X-Received: by 2002:a17:906:f5aa:b0:b96:edcd:cd04 with SMTP id
 a640c23a62f3a-b9b5094f8bcmr825193866b.49.1774890445477; Mon, 30 Mar 2026
 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260329-bootm-wdt-v1-1-f46b3bc6d50e@posteo.net>
In-Reply-To: <20260329-bootm-wdt-v1-1-f46b3bc6d50e@posteo.net>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Mar 2026 11:07:13 -0600
X-Gm-Features: AQROBzCUij-EgXtu_BLxYukB6EtbBFyv0E5Zhx8pKNDeRn-G1YqeFGunmrzo0qo
Message-ID: <CAFLszTh084ZKCEFFF-ROJZrCegbJLkQPk82vFxfiSjKSTfO2zw@mail.gmail.com>
Subject: Re: boot/bootm: Disable interrupts after loading the image
To: j.ne@posteo.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J,

On 2026-03-29T15:17:33, J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1044,6 +1043,8 @@ int bootm_run_states(struct bootm_info *bmi, int st=
ates)
> +     iflag =3D bootm_disable_interrupts();
> +
> +     /* From now on, we need the OS boot function */
> +     if (ret)
> +             return ret;

If `ret` is non-zero from the RAMDISK or FDT processing stages, this
returns immediately with interrupts left disabled. I thinik it should
'goto err'

Also, the original code only disabled interrupts when
`BOOTM_STATE_LOADOS` was set. With this change, interrupts are now
disabled unconditionally for all callers of `bootm_run_states()`. Is
that the intended behaviour? I suggest associating it with
BOOTM_STATE_OS_GO instead.

Regards,
Simon
