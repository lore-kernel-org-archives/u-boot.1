Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A689C982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 08:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFACA60752;
	Wed, 23 Sep 2026 08:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mqd8KwZlClRq; Wed, 23 Sep 2026 08:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 17DFD606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790150482;
	b=BDwCZoAtzSe50yZEoN2/TyEUKTSo6Mw/CxwQsmScTgR406QCaHG1/ucjT8ejmV+CelZo
	 QVXGPpvpFyNn3p9WvZ1AFNdVJEfAlNNG/uLguUApzWokui75BT6ZIk3/o8vro6WW8Z5qA
	 /LGNZ4P6pRLwKOeOqPsMAfRffBdhhkViGxxi9nvmUM9Ot4Omgmk2HCyv2JX559XYfXRpz
	 XPd7ZaGfLbg2WR+YSD8zk/PHroqjY87E6ZvJYVtjCJ8FByQtUZwhraGtgjm7ZW7bdesPo
	 mZfRwotVH0EaugZxHdIlCB3iClyiw9g1/DmlPbZ0GH7gmBZ6WwerSMeI6y+s2RuTo8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790150482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eZGRPg6yv1R1m2Fpbn35tNZi8wx9u16H26MSy73z4K0=;
	b=gK+4Zi5VCz4dl+IHhoPyRK6GyEz/5hLcfj/CubroNO784tP4aDIrtLc4IVGejEySaFpO
	 ySonIAOPj4UImNzJdAvguD0JG+3dlVW/lJQunbP8dg9kTp3vFHeswT/VMxuuZNYYEpbvA
	 iWcGf9GPZNgVQzCS9aUYieOx4+eSDm1UiAp0qJUUcKqugJs+wiBcw9DbUPKcTXxrBfasn
	 7A1hIzxNjQgNqUVdF/t+6SHNZ+nPYR7/BwO/qJJZXXkqYS1mao4LxgEylAtBlW38X/Eow
	 SPcrvhSja6wMTT/qO3mwU1G60qwtgiZJH3O6EqQmIIZpin8tCpfj2hK0O+3x6FL7XHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790150482;
	bh=eZGRPg6yv1R1m2Fpbn35tNZi8wx9u16H26MSy73z4K0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hSeR8zQcERukpZelx84AbDTeL69xge4B+rn2FyTTFeORNd11heuQR1Tz0MjKz8Xcv
	 OF17m1daI0Lo6uP6VNjy6Og7UuPkY4Nyfn++6OEzgOtxv4BH0QMf7zXhbZAo4bOovr
	 QDAI9iZM6jt/uZk26gI/WZQX/CsfY9EYpHdSsQw96lLiX9rjZJg47pZ7AYFCEtR3Ve
	 0C/zPEkjAkpW4i8A0/fAJ9/I5UyEsY2XTSG6RunR3PHpdpQz17+9Nwsf2gR+r1+J/h
	 54SCdxgt/lvdnfUC8IdlJSTWhMj17nPulWqVaXgYuSbB/8gOxi3kjeu0j221CiCDHa
	 VVxWxNQ/U5xZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17DFD606A2;
	Wed, 23 Sep 2026 08:01:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE818334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A01B480CB1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bsqNtDJMS5K2 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 08:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3C0D80A84
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790150479;
 b=oyvkEcy3efrfSF6pDXVTln7sOIhnuZDCS8bqudOVWq9TEFaZEmLD7lO9HiYTaOpYtcfJ
 5wHFjl5WtSTSEISU15sn51+st/rcN+g8+6pH08vfoJkP6PvaQOZYvMveMcj3WvGUr1cWK
 LEBHVNTOxnGEYeLY+y894ynrD/Yfe8+5Y0QQFoiK16KhX4k4VOKSIhiq3/3btkslTND8b
 xw8Y7EvS7y2wtnFqzOw5CZlI6Zei43Q3caOab0GZ9H3bF55YzEg4+ycsi2lrs1iOkLdwr
 4iZ1Tmbf4QvZFI7L7Kix3MtBQWd5poPWPsSXbR2AiMeTn2DdI+l/AoSAsoLQpOJBeEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790150479;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=eZGRPg6yv1R1m2Fpbn35tNZi8wx9u16H26MSy73z4K0=;
 b=NDBCpdWwHi2LNfFRAy+vBE84CMkr19kV2qu66CofEGzcSrSQJBTH4lrCHT5KysF4NezA
 MK8lvNQx7sAexNBSPEGJD9+CiU5OvgNW8hwxOxNUk4qp9PGJ0Wa/aXSjsWa4ROLYU02N3
 RIPV3rCF/cgL2/6eWvNAMHjYvuaRy2Ulb1biMc/tF4kTa0ndIKFqYbH5P6CtVJFCrfx9p
 MKT4APnCExpaH6gMzjjKHnltLsLrbk64DH3KeVPUuMpZlsg8QwT4ghlpOjFke+9ck/Cz4
 9GzLbCXKSANGJ0gyfvPXc1DoGqCyN7BQTTuv4UpmG1QnoEuNs74UUsEyzd1i9pBFuaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EhKwwMHN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EhKwwMHN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3C0D80A84
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEC99600AA;
 Wed, 23 Sep 2026 08:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A871F000FF;
 Wed, 23 Sep 2026 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790150476;
 bh=eZGRPg6yv1R1m2Fpbn35tNZi8wx9u16H26MSy73z4K0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=EhKwwMHNhB/vr8cMBMbLGJTkAM8Ug5+8e7i4CLbqyz4Y3g5NdKArrTKfR1IAsCtx5
 sLmhBSJ2v3vWXv6j/qHH6y2FO333hgk0Qgmn1nfYUCpEa36ZncIafWHmvcNOj90VfV
 bvFQJvvKaeix/DgmxW4HNys+uJWKeDgxdYNKv+ZyVaDzruRwrBJFrZXRhfOi1/ccQ1
 gZmX/wGLHbl0gpZXl9s3xjIFAos4irRxwI5UsXMaoYpJd6z43/mphFyRVP/Wb4WgHC
 pmL/sDzwBAX4x41LDMOtLqLEsoJKgv64jgYNTgh2RQN0lTRkwKYOtB9oH4S6lAuq7l
 NISJ5Dk7/qKQw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
Message-Id: <179015047421.246261.8241758059641679018.b4-ty@kernel.org>
Date: Wed, 23 Sep 2026 10:01:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Sun, 13 Sep 2026 09:28:42 +0200, Carlo Caione wrote:
> Some recovery and initial-provisioning flows need a standard host protocol
> before usable firmware is available in persistent storage. U-Boot already
> provides fastboot, but the implementation can currently be started only
> from the U-Boot-proper command line.
> 
> This series makes USB fastboot available as an opt-in SPL service,
> including MMC partition flashing and Android sparse images. The interface
> is kept deliberately narrower in SPL: it does not support the boot command
> or filesystem probing, and reboot support remains platform-dependent.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] fastboot: factor out the USB session runner
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/0c74f398fbec8e7bf0930ab45fe7ea1f43f1a2e9
[2/5] fastboot: use the common handler for USB reboot
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/75282c31d6c65e29789276bc218885ddf246aa9b
[3/5] fastboot: make shared configuration checks phase-aware
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6dedd6b257bed238ca5b0746b7835e2a737a1c0a
[4/5] image: sparse: add phase-aware SPL support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/72e8bade12ccbf9382b5158d5a37c257e3d7ad12
[5/5] fastboot: add SPL support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/25a459fd4d2eeef909dd4ea8a577ba82b1fc5e43

--
Mattijs
