Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F6CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 715FA404E7;
	Mon, 28 Sep 2026 22:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1kOp8UmpMNP; Mon, 28 Sep 2026 22:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B8273404E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790633467;
	b=IfmU7z10W3vcqB355Jnj9603oLvVRY2+KG5L+ZBegX4HPpBr0KtxAdHun8GieThvzglq
	 sGgEVGnI0LPxx6u31ED97fLGW771n1vyAdhUv57x7uuKCP3r+mc+j5NXBsklz2/KaI+yZ
	 jc/Sy0WlIhcBHubhzXuCINBMFe5GQCl1Y9iUkXofPTbDVByTA8C1D4XXS322mGv3W4YNQ
	 UWWevpSm/VVs81XEQDj+AsW4pscrYMk+4NCEEobs+JrELVBc7mfj7QFZXSR1OKX05XANd
	 HAHIjT8mjFa0FkwV9Gj5maGIChdQmSOzGcYouS6/jZE6cR412Egz59qZIojdj8NIk8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790633467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E11wArvxUAEGYWLyBiSRNMXnPGwuMUwfWu29k87fHCc=;
	b=QfCTuxUQZDiAO3mrhraaPq4+lux+hRFVDchL/M4TbNxJJgQgERY8xuCAZ+xQQ9oBZEhk
	 qE58CfDf3kMdtE+L5FF+F22AD66XiYimyLWCJqdgy/kdyMrz+ydRhRKYfZ3wlK1K6z9Ie
	 LtsSCDgiE5FJf/CV8qFdH8H9c/jU/eUvtUXQ0mPPY7TcvK5D/FCOIH8K6rkWi/V/Ohldf
	 xOA37TD1PVgmbj6YKAHOEXN9An8/pyosSeQaMKacawsNliPHIMmwQHeTcDRUJsfNfMyAh
	 D121z9fY1xHzZRRIqCbXWuczo+7o8qY21azdSM3ZAV8gsG/TgV/8o/sQWW/3fBUIZQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790633467;
	bh=E11wArvxUAEGYWLyBiSRNMXnPGwuMUwfWu29k87fHCc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGk/lQ44c3pcJHeIWbsZfBhyzOIQqJHtnMFDt7yX3SjE4uQPk5iGPfodL2knUhLNI
	 I0qGccMegG/UFLu+H9mMGaMJoJ1Rxnkp3W52a1jkVtJCpyEqOXnTYq+n+2/9TuVgn5
	 1BLEJFojvjmZDv/kSXBbrBOd9IDYiIlUKpa/jyjsSoqHZXxChWVjb/Qbu4Pe8FQM6I
	 /HyIox3X1aQfpslTcGG/nFSelQi+DoS0pdnOUg61mJeoeQGO/Ok1mF2QT39K4h6zPH
	 IpRL1uYQG7PVRpEiPYZ5/VvWyTbuud3dYFBlvRDQQsNZtF2J84t5SFMacFVLBB6T5x
	 x2j49Z2dETcrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8273404E8;
	Mon, 28 Sep 2026 22:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B3B61
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49EB980ADA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8QgmvVd5ee2 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 28FDB80ACC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790633465;
 b=ZvFv1noxbwJvV01BWMDC5sgsCWWSStzQjrkhy23cmz5B5e8qhW9jxVz/VCkgHUxs38fr
 VZLJRYzQKKqraTf4odkqUHl6U0xFQwUwPXeAQW9vlJz9wnrVZBhUCULk1i+9yNC8xSo2j
 zg+JtyM99qLp/E5GGHPH5MHyAi8ugPW2Qdvm57sGLaHpxksAUwik0/Ja7JyG94uhbFcpX
 MO+42eoWWmEJmKElKx1W0QtbbVyIOk8oDyBQvwsdMNk3AH8SqCJAQGLurpCR8CIA43E8F
 HKVKpSpR+/wfh9vRazg3rwQvsyBVr+zvGkHL36PS1M8QPfHnFROsBMGnlFEqFUwSNzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790633465;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=E11wArvxUAEGYWLyBiSRNMXnPGwuMUwfWu29k87fHCc=;
 b=BucRfmEwIfn1bCwTl7tMEhtqPXv3Axjwkb7ffxzBCqr6eOKe5kj4r5aBtAOXmaSH6JPE
 JfHItnTEx3VcWqaanuanC740VmIbORR8ue3IpZqOB4Tzvvj2+2DgPdQM+/OElTsTyDpBi
 g9TIS9q2KD9OryqqaI/nBysfHLRoZRZ+Wp9GrDx0k5ljl+tZ3swupxoPEKr0WVtO8e3uR
 lxt4Iuw8PnJTTzdeGXUQtlGDTAhRcVJ2AwgpQKgNKYe02mfWpkpZ+4wLKvfFtDP0FtRYB
 vnWnqu5eUjYdwXEaSHwFtDvbLSZ6uk4u3Y2V1ials2bUjmgaVKeQG3p88Z51RcWABEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=X+4JLQUR; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=X+4JLQUR
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28FDB80ACC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790633457; x=1791238257; i=xypron.glpk@gmx.de;
 bh=E11wArvxUAEGYWLyBiSRNMXnPGwuMUwfWu29k87fHCc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=X+4JLQURlJ6taFxi8gNoLjnhNpWYh6pPOmI9EY2q4eorcK1CJliSL14Alk1PAFTy
 91tGpfp4+EHukSyyNOWWFXxFSkRUypaJF2Licmlo4zZwTjLCMAY77DWiWKjW8IRxk
 nvEmsyT1sNwBRntDrFLP546PYGWUfqfChPJSgqLUeoUGs8jYhNvsrFsffCbhcCJq7
 edo+jL00XA7Jiy2wTuN3qhg+jZH+tgeVKHZwDvjJhAcM0DGnhEfzitmfASOS8vWfS
 7MWTIFmBeC8wH+zTjAOjimXGch7Sp3HF9jRC2XJscpv7cg719lgv27wKlgd0UHOnk
 tMxAyEYSu/wJ0XDcug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1xQ6ah01so-00IBA6; Tue, 29
 Sep 2026 00:10:57 +0200
Date: Tue, 29 Sep 2026 00:10:51 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Carlo Caione <ccaione@baylibre.com>
CC: Ahmad Fatoum <a.fatoum@barebox.org>, David Lechner <dlechner@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
User-Agent: Thunderbird for Android
In-Reply-To: <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
 <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
 <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
Message-ID: <8BF3B9C2-8291-4A8D-AF0F-1DA263340790@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7tM7brXiaH6LSBIHhPcqPFQqEjxww24NJDyo0aykQtivPQ97UwX
 4g2Zln2yV46sH9SLZCRbmF74bQ320z9+h0DdJp+SCjGnNSO8/AoQaY6hxrKAsjVvcLFUx+/
 A5dlUH+wDVqA5xMO39ORNrpUBxOXsbbxJj3w4rpt3FnflN5vMzqoLoT7CrWXmVIhbrC5QOl
 92Qw9rOQO3z5dS9dYrrMg==
UI-OutboundReport: notjunk:1;M01:P0:NSkVnueyMaI=;k3i+v9pJ42iqVzn4a8UVY+WsLgt
 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
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

Am 28=2E September 2026 22:33:06 MESZ schrieb Carlo Caione <ccaione@baylibr=
e=2Ecom>:
>On Mon, Sep 28, 2026 at 20:45:37 +0100, Heinrich Schuchardt wrote:
>> On 9/3/26 15:09, Carlo Caione wrote:
>> > An FDT explicitly passed to efi_bootmgr_run() is currently replaced b=
y
>> > the FDT referenced by the selected Boot#### load option=2E This makes=
 an
>> > operator-supplied devicetree ineffective whenever the boot option car=
ries
>> > one=2E
>>=20
>> Hello Carlo,
>
>Hi Heinrich,
>=20
>> I do not understand what you mean by the term "operator"=2E
>> Do you mean the end user owning the device?
>
>Yeah, not a very good choice of words, sorry about that=2E
>
>By "operator" I mean the user explicitly supplying a DT for that
>invocation, for example with `bootefi bootmgr <fdt_addr>`

With the bootefi command mentioned the intent would have been clearer=2E I=
 agree that an explicitly passed device-tree should take precedence=2E

>
>> What makes you think a device-tree entry in Boot#### set by the user ow=
ning
>> the device should not take precedence?
>>=20
>> I cannot see any justification for the change in the commit message=2E
>
>The use case is a one-off override: load an alternative DT, for example
>for debugging, while using the existing Boot#### entry to select the
>EFI application, without modifying its persistent DT setting=2E Currently=
,
>the explicitly passed DT is silently replaced by the Boot#### DT=2E
>
>My intention was to make the explicit argument override the stored
>setting for that (manual) invocation=2E
>
>With this patch and patch 4 the full order is:
>
>1=2E Explicitly passed DT (this fix)
>2=2E Configured firmware-owned DT
>3=2E Boot#### DT
>4=2E Distro/ESP DT
>5=2E Existing `fdt_addr` / control-DT fallback

efi_binary_run() called in do_bootm_efi() is another source of device-tree=
s=2E

Best regards

Heinrich

>
>> The series lacks documentation which describes how device-trees are
>> selected=2E
>
>Yes indeed, I'll document this better in the next revision=2E
>
>Thanks,
>
>--
>Carlo Caione=20

