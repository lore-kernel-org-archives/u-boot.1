Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DBDC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6620405CC;
	Tue, 25 Aug 2026 19:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfI9kHWNyjJn; Tue, 25 Aug 2026 19:15:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685319;
	bh=0CJml4u73me4uqkLTX5zoSfdQfL5GpUveXTvuzhFYLA=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CN+0vliS9bVoP0yobNqOPHnpL+bsjE97dX8zv9H3m13+cFKo7r4KJRdBzqRKFywen
	 cNGuVz6Gc2KvIWliCZqBilON55dX5khItdHmbPhiNaFqgenkHzKBChYNyiFhOoaxLW
	 fyic01iQcbM39jwvUvpvnXHzHBA7Za449BHt5NfHUQkvajgzW94W2qZXZCTpUAYLwo
	 vPJoS2mCR0NVNfhlQ5aWk7IXJObDej12bv9kav1aZjS7Q3Uc2BODDThjleH9zR9Tbw
	 Gn8qtpLMXBGbQKK0sWboC+WmS2M32a+kdhpCbaYa5nLn4g/RUMVqMDQsnkXPn7BBx3
	 uEcQyfnbXu+tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD27C40576;
	Tue, 25 Aug 2026 19:15:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ADFC2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 986E540055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZTsSzK9UY2h for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:15:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=m9UpFxs/
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90D324004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:15:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F684601E9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472831F00A3E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685315;
 bh=0CJml4u73me4uqkLTX5zoSfdQfL5GpUveXTvuzhFYLA=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=m9UpFxs/iE/3aQEU5Vrc+9+Bd3jU8HNMWrbb8jHXpe1omi02b2X8v6awYOdbn3Zxe
 fFf8RV+TPKo8+ck9EVk5Z/r4VCw4PTrb0Tw/yp5IEv4f/PT0FZaNPPtYOj2949Lw5L
 RoUHCXGYHPDO9EW2qoAFRlZNFMwK8UORM8hoWFfBw4VRdtb+v0owMsCFEDMQXrXNdQ
 J8Y26LSM+OcL7JSKi78U6vhRR4WEapLK0UFKEVfmUWTepj5ZEjG9/NhJumOs8CZWQY
 yqqE56WETZDqUBydQMb6/Do9SYwfnsK8c+t+Sho+p/VPkWuh/lRQGQ1/3Bi2jBt9Dy
 UHNergA3jurew==
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b2a22c52c1so79955e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:15:15 -0700 (PDT)
X-Gm-Message-State: AFuF++nOhFott4pNzcPQ+TlGzyhluRVv6lFtFKrJHWhwW82LCH/tsTcl
 R7I6mLWzvqrf42zt9+/6bEBGwAF6xkGCcxMj/gJznUl4dX2g9u73Mw+NFZO2iYLX54xBG/0k6Us
 sAU+itJoydxw/Hm7phbn3Z4NWbtzZhqI=
X-Received: by 2002:a05:6512:6089:b0:5ae:aeeb:e902 with SMTP id
 2adb3069b0e04-5b4a90437b7mr143117e87.13.1787685314056; Tue, 25 Aug 2026
 12:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-2-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-2-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:15:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLnRuADWqvnUWhNhrEjuN7sctkmBuFmwJSzEmzSZ5cDmWg@mail.gmail.com>
X-Gm-Features: AcwNN1V5N6YRpkU3yP3XpSBJrYXk931mrkG0MEuDDUa7Vnnthtg-wWvkof1M4bI
Message-ID: <CAD++jLnRuADWqvnUWhNhrEjuN7sctkmBuFmwJSzEmzSZ5cDmWg@mail.gmail.com>
Subject: Re: [PATCH v6 02/13] mmc: arm_pl180: Configure Ux500 signal direction
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

On Tue, Aug 25, 2026 at 9:04=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> The Ux500 MMCI variant can control external level-shifter signal
> directions through the power register. Parse the standard ST MMCI
> device tree properties and set the corresponding direction and
> feedback-clock bits.
>
> This is required by the external SD card slot on Samsung Janice, where
> commands cannot reach the card unless the direction controls are set.
>
> Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

CC the MMC maintainers too. Will fix for next iteration, sorry :(

Yours,
Linus Walleij
