Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79537C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2847D810A4;
	Tue, 18 Aug 2026 13:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jd_vpKRTCEDB; Tue, 18 Aug 2026 13:31:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64EA780F6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787059891;
	bh=S3zF0ODRXHvankAx4LD+qZeG9Zr+cyAcHuCzwEN0rr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oem2gtCcBEOi/oW9Z3y0hUysYr2u/nvwQDgJ32Rvl5AI/VLsW8clIxGFnKlcisP4U
	 DZ6xvMDEBiWsJi/SqfZRUi8HRzBwhJy8v0hAmpnBegAFcuhlC7CNlwdQxd4hYUNEdk
	 F8k+STKZ++C0NPw6MM4A88nra00WOOC0pzG0ZB+drXhmhLl86JMfWJHzau1CampSYv
	 e/MHCjRfRAtI0lOIGKF+8iqnt+vJpM1pU13uh8r3BYQgsFwuc/4zDJQaCKAx8wA6vP
	 6A6CnhTzP4tEYXiMVyTJcDqrbAxvyByp7ZUka0CBfANiyoNNWV8BybWbtuhkpOJjyL
	 lldb0Ql17xLDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64EA780F6B;
	Tue, 18 Aug 2026 13:31:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42FEC322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E5081062
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbAMsflTt3V0 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:31:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8D04E80F79
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D04E80F79
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=n0BR0ToA
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D04E80F79
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:31:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FCB7601FB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC2C1F00A3F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787059887;
 bh=S3zF0ODRXHvankAx4LD+qZeG9Zr+cyAcHuCzwEN0rr8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=n0BR0ToAHbpRbsAVDAcJNrRBGl/fqZ0lr/YOfsGQgjFAkj9+Kv/tOKCRQ/WvWXPFj
 5QVKJ5pV7XfFxALZ6VqpKzqwZhhktzRFQWarv+VanICJz4WLytj8PbPdUHtKT7ycK3
 Ss2AWuk9fdw2zi7VNTO3MdUz+IepustuHPO5fWCudGd6orDppY4W1IPlp8FP/UTKOS
 ALc81IccepBFqbQWzJrHj/LGlBRXA3UbfPB/mjJfdzv0XocGqiy54AezV6r89hUKXF
 v5FvTQMSN5KNvW7FuXTj6bkJsLkVRLRcNo30QrLe1HArYxsQJMObqPOb31rc45pAUe
 5veaZ0yEE5ZfQ==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so5946983e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:31:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCmcC3Uwzl+jqOD5qp9XWG7oDZFx1QqZpwfnRV3NxMNGqh42ju
 lY143MSWXFqbg1ZROX6cYEICPzyx+83iz5F3dBL0tilhJPpJHSW/BE3FdC2jI0U40XHBuSjwF2V
 vtKNSJDh5YF3K3HCMhyR82twD2VjDu0U=
X-Received: by 2002:a05:6512:838e:b0:5b1:5379:8b6d with SMTP id
 2adb3069b0e04-5b459117895mr4201239e87.23.1787059886428; Tue, 18 Aug 2026
 06:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
 <aoM6qJ32H35aumPL@linaro.org>
 <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
 <aoQ2VMH_unoQaQxO@linaro.org>
In-Reply-To: <aoQ2VMH_unoQaQxO@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 15:31:14 +0200
X-Gmail-Original-Message-ID: <CAD++jL=OtNJZrx20c_siaRBAJdnp=v5aPv8Vr1S++HC3ay7M3g@mail.gmail.com>
X-Gm-Features: AcwNN1W77imiR2221teV3jLUSqSzK0iDzfFDXPi19dZ3dTCuk5Y7zucckn8Y7BM
Message-ID: <CAD++jL=OtNJZrx20c_siaRBAJdnp=v5aPv8Vr1S++HC3ay7M3g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice
 device tree
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

On Tue, Aug 18, 2026 at 12:39=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> I wasn't suggesting to use the same DT for all devices. What I suggested
> is to bundle all the upstream DTBs for the individual devices into a
> single U-Boot binary (CONFIG_MULTI_DTB_FIT) and pick the correct one at
> runtime. :)
>
> That should be equivalent to your setup, just more convenient for the
> user.
>
> The only open question for me is if we can reliably detect codina-tmo
> based on the mach-type ID, I can't find that in the kernel sources I
> have.

Aha I get it...

I can check the codina TMO, I think it could be an improvement on top
of this series though, if I leave the stemmy device tree in place.

It all becomes a bit tautological and hence confusing, because yes
we can perhaps embed all the device trees into an FIT and pick the
right one depending on magic from the first stage (odin) boot loader,
then we overlay that with the U-Boot restrictions, then we come to
the EFI boot partition, where again we have all the device trees,
again pick the right one, now for Linux, then augment it again, but
only partly, without U-Boot overlays, then we boot the kernel with
that second augmented device tree.

This is... the way it is I guess. I'll look into the stemmy-FIT-with-many
device trees approach.

Yours,
Linus Walleij
