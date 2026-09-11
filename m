Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033ABC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D19E4080A;
	Fri, 11 Sep 2026 13:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWUFMD9LUEUD; Fri, 11 Sep 2026 13:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B3E2D407DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133426;
	b=CfW1tGIe/QaiZ17+YszQJvH1r+3t9Ay/7ZogO2ZC8eIYiRo88Spb031OH4a/NWF93Df6
	 sa9thrQx1H1+npi4zKseAs9WRTI6cpbj0/FgikDtZAikRz1jJ1yIcXM4uOaoAKF+vMAu2
	 tVML+NW2PAkmYmaRPFN4Yef7FSBpIzN6lJbAoEJ6sonxHvfIKsfxb7l4Ea5/erqbZLWPq
	 aAH5fk/TW5pD8LjArtB9S7QdUzn456ZgFjkoI7cgXrU/0K6Taz/Twh583+oMCDwY9ykAZ
	 j1Sd+phzdgtG7i/I6nXZ5VyNVTz+oAqapmjb0T+ef6rhThLkTqMxsnp8V/o2Eak0/5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zmMibPkwcmNxht8JP8I4pMMx3/kPk8HHKmo5Ks8uCyk=;
	b=Uz9qCaV64djre/Qnag4V2tFzbKww4D09TVaGLBkM4EUc6H8ovl1zDxpsh53Uer8j0vMM
	 24Dah5m6V+q1dQpKKIok/3pSEuEACs4Ic/o2wIfkvARx7AtF2kXOyPI1bEsIMql/8qySt
	 LB20TqXrqU4QXiW23gVOmP8NteHdCP58O/lKPeEe4u6N0RjWB/PBL8/EtEAOJF1chJ5AU
	 3ojIW8T4/TdaeTVmAapmDt+gAxWy1FL1S3PD6uuogKFuh+eq0+bLPuWD/MkhBmCd++Y8x
	 7zY8Fz6W/P3UqxiYT53miM066E9w7r1pysuzToBSuZ9QI890+uOzgbEIYitAnY7+Ehg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a+F061+/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133426;
	bh=zmMibPkwcmNxht8JP8I4pMMx3/kPk8HHKmo5Ks8uCyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9RFtP6PKjHhmlME/NMrbbcg/XWb7wjCetX9W7op10Mx4h53H8j5Ach97IUYbocmn
	 GJyrox3okMAizr/u7DOryxZ2rfoUNKx8hDGLMqjm4r13b7UhKRfXKrm2Sqq2TOMxJ+
	 4pbQpbZRURIwCGbaX7t6qqIP3k0oTnxYoWMe397XUXFFgfHIQqjWs532qUcY9869KH
	 qzPMN4ah4hqpXBd3KeQjXDm9J2f9AaWXfr/zwiA2TKlHdRU5aT66CevO2Q8CxJW013
	 iuWkwjPZkb6FXasBLFjmSHsjMUjkEPhjU3QIu6Ae0ieWPudYUt1qaHVVuHLjXbJqy5
	 gIuaq8RS24jog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3E2D407DA;
	Fri, 11 Sep 2026 13:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2121D32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0770D407DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZFcAzsLK5DN for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 23CEF40607
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133424;
 b=nxCxRwP9Dr1HwfjGDlQNPfIMHXdr5h/K0Vsj+8vjoAywOBPulaiescndoWBrKJY/pozI
 sRhOQwEesMJWP7e/oD4rLrATGjfO+FY9IBtnitQbQF9heTR+g9ZEg6e14t0/ZPCSRnoQV
 WPxxkAtKNmGDL+OPMioIXwcclcNQf9Doog/+USm1nhVDVFchQ7ltYKPGlJenIvhrJ7+W8
 g5gAjMNYBC1flws/+a5TrgWx6pz8k4DDr05JGg8rg5jnlnDCTEm3Jf9N3QRKE9bxq9GFn
 2KsNql3Py2L6jaJiIUeo459e2SAibSdxLaqBcq6ScPZRwVBdy19OqCJp4hHbnktJzJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133424;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=zmMibPkwcmNxht8JP8I4pMMx3/kPk8HHKmo5Ks8uCyk=;
 b=PdEyY0qB9Ycq/oIRkFxI2dNDyeBhmo7MS5imtE+dEcf60OAW1IDAiamKRSrd0sqWW4tV
 JXs5bjhio2kZtG22q8l8KGFLWb0RwSk+AxOVj8F3emrmEJfLJSvbEEKK+IyNqYluhVYFh
 oLd78erh0OVqG+0nokBuSyIpnwJBHBXjNl79zsaDqQHlzwtzLndb/qIl8hJ0xA3SLe7fY
 b/LMGkBghC+yh/vOIDlmC7MNnI8IAFO9iCCgEPy7oWSGNlR4wqa4kXjkSyXBf4uMplK/p
 tkOKImR5JyyKSYfi0rxeWfnrmTVSLZ09ug9L3db+fljJcd0icxlxEN5FhcS9RKMsVUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="a+F061+/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a+F061+/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23CEF40607
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 373186020C;
 Fri, 11 Sep 2026 13:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9041F000FF;
 Fri, 11 Sep 2026 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789133421;
 bh=zmMibPkwcmNxht8JP8I4pMMx3/kPk8HHKmo5Ks8uCyk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=a+F061+/0QUeRjS8Sz/6ZQirbyARqiDnkECh2unrnV2IfE5giGABh9yDiEONrD5Q0
 gHO+tDdFKOIcQlFRdU14FpF0zwBTaslrNlMgLjTKelkaRC677aF+IudCx2kPnoE529
 BlsbqJrZzHBL0ddnemhM4ZkmRf1WprPvVQnfgptNqgVlblZjnz8XUMn/oEayfdqJK0
 zZHw30mF6VqVOW3B1AWUtL5C8febkf4iaq0yzFdyNJ382stMmuAFaqV6ODxXKLq1bI
 Ah2/0AYWR9zeeVdbpkWtxzl6cuIvou3DGIkgm+jEU1oQVUQ6F3FA9v5XtJ2U0Ik9KP
 xGk2tzrF3jTjg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Julien Masson <jmasson@baylibre.com>, Alexey
 Charkov <alchark@gmail.com>, Adrian Freihofer
 <adrian.freihofer@siemens.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>, Peter
 Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 5/5] fastboot: add SPL support
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
Date: Fri, 11 Sep 2026 15:30:19 +0200
Message-ID: <xhkdba4pn5310.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Carlo,

Thank you for the patch.

On Sun, Sep 06, 2026 at 22:02, Carlo Caione <ccaione@baylibre.com> wrote:

> Some recovery and initial-provisioning flows run before usable firmware
> is available in persistent storage. In these flows the SoC ROM loads a
> small first stage, but that stage must still provide a standard protocol
> with which the host can provision the device.
>
> U-Boot already provides fastboot for this purpose, but its implementation
> is currently restricted to U-Boot proper and coupled to command-line
> support. This forces platforms that need provisioning from SPL to maintain
> a separate downloader or an out-of-tree fastboot implementation.
>
> Allow boards to run USB fastboot as a service directly from SPL. Include
> MMC partition flashing and Android sparse-image handling so that the SPL
> service can provision the same storage images accepted by fastboot in
> U-Boot proper.
>
> Keep the SPL interface deliberately narrower. The fastboot boot command
> is not supported because SPL is being used for provisioning rather than
> OS boot orchestration. Filesystem probing is also omitted, so partition
> types are reported as raw. Reboot support remains optional since reset
> and persistent reboot-reason handling are platform-specific.
>
> Environment-backed USB serial numbers, getvars, MMC aliases and raw
> partition descriptors are available when SPL_ENV_SUPPORT is enabled, but
> the core service no longer requires the environment. Document the full
> printf, allocator, reset, command and shared-buffer requirements.
>
> SPL size remains an important constraint. Make the support entirely
> opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
> fastboot code or supporting library is added to SPL. Enable the core
> service in sandbox_spl so this build path receives CI compile coverage.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
