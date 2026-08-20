Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DCDC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72A26605D0;
	Thu, 20 Aug 2026 12:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCaRPFRx_Zhy; Thu, 20 Aug 2026 12:32:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229133;
	bh=la/UGOQpg83Q/E0BpEFaKf8BUcpzlELCoRjfVn1ZiiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xfx4k4P6X0Vj2LLVw531MQVcrM2mPPGSZ8T8tZiNDrco8PUGNJtDAznuArBHsp7O0
	 umAXoI8rUhlpiBHCSXsfBsMRzPH6NbC5uukGjNvKxrhXJUiPseIaYIeZOS3S5R1l+x
	 59MXJudK780xfjsYJsTIB0kbbl/Ea3Yy/3KuU+H4iazkmsZLs0J8OUddI0MZDbLfAs
	 mx/Sqb+0UI5i3Q9tW9mlnWNndSG5R37Wv8Mm8D4RAe2nDuZpWwpSIB9ZvCrGZzkGQn
	 WuQEKKcT+t6eaS/Gzzw8YguStdfFi+89w69gn9xluzk5Aw/LczT0wXsWEubhbyXwv4
	 wpvFT+72umeEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9792605D7;
	Thu, 20 Aug 2026 12:32:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78317323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E0BF40558
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqZYVxtgasBN for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:32:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DNPWXoam
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 950604034F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:32:10 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8efec2c28f8so14425516d6.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229129; cv=none;
 d=google.com; s=arc-20260327;
 b=kZX2nGSijVzuOzmmSgwKCsbSTafRfJFR7+U/4SioQopFmQ0oDVuio6DmMPXhnb3tie
 RTywNvHbxlTYUQVxNLbSCeMGiZbOBjCc/k4KuXrU4k9GYpTt0DBkF/pjd6Q2DgkIG7BJ
 92X5A+ddvkSLydj5kS8uqoq3z8efPO4guJn1+aPp51jnyGNLhxeDX6uuROzlUlr1IqU6
 loqdn3DheIHCWuwUY7C1ReL2m5IWDSJFTPpSJ/xMDBnIy42cSau78hC6WLa9C+XUE40H
 dE9up4xq1iUP5PW34XZ4iYQKO7vA3aPKl3qx2/7yR54xduirjoFzwKGBgQzr4TP0xo1H
 DKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=la/UGOQpg83Q/E0BpEFaKf8BUcpzlELCoRjfVn1ZiiM=;
 fh=ZH96+9FRasJsrSwHKYDS3zxlHoqnQ5TqtFaceBic990=;
 b=Uz7W/yzrqh/oRXsP4AWANOr/FUIVqGTRD9hVmjFFdRQ8pVfVmUyAiI9Pl9979Bw3SX
 QT4BAMyXDibJfyLlm18R81Dmy34Ne7DCdXKvQPDBjE7t2GJXiEH4JRnkkobF9jcjLsin
 eez8rWX5VM0fGYPfLZW7woXQVeCe6cpmUiVDEMFVK7LbopVV2Qea2KIEO/qUpemevlAa
 CbnvgxA55DMtcBPs6yjrGmPTokeo/QrWUQ40tsrD8yCRJmVfL1bNC9YVaahH9mRo/+FQ
 pFzWg6dU17/LQvLLvPMEtsBrmmcYbtG8Vrgix8loD/kNQFocz2faY4V+4MVjrWUOcACB
 gXaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787229129; x=1787833929;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=la/UGOQpg83Q/E0BpEFaKf8BUcpzlELCoRjfVn1ZiiM=;
 b=DNPWXoamcaPPsmm/y0MsVtc4NCARE3HpR6+SauPaQ8DAqY0w7kZPUwVQ1LGiTrW6tA
 eQFdnjImxvKTraXerBK8N9EsqLBeFtH4CAISt9HHTeWeTGW1B4+2vhR+A0PeLQV2E63a
 XWRQNtwF/1m4/g7Jwpw8U2vAjkH3gqthzI4eoSCcG+vUGStqQYsu4hXHMVptPdUc3aFn
 eQzTxpFDamPhlTIb1q1jejvSN3tkQnwwKx1tYhk0D08k1A4WItahIowzXDsffQKPDYhb
 aEZdPYDnHr62fN4bTphBnoWljOuRBh/ccFX+3rcZZk4yuZlCuqjDxUmhn1KCEIbMcPVo
 weaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229129; x=1787833929;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=la/UGOQpg83Q/E0BpEFaKf8BUcpzlELCoRjfVn1ZiiM=;
 b=tXK+7iN6EaR9NutfDtBu1TpunB63iq0iAUwf6glI0BaXeh8URYcEmjB1+r1XKF0t2Y
 lvOuLdDjYnb4w7njoGIyhc9lAXCpDKHSu6QXxvsCjT3Z0P/FtmMxAuVHRftGyjh2COjz
 aJUXiWJe0AUuqljzdgA6C9gcRWQmOnXS3N2L9o8SM2tHmRf++/xlrGLpBGMyEgd5N7HQ
 tm5E31Hr+y1miEGfquTr+f0zZtwgIl8CVhu7Rgv3MTPkMFy6jGA/j2J+uRaqsH+QOB0C
 H3YLKYgU5sGst1miIzvgC5m7t8HHme2vBWoTTp9i2gnyPDPklG+fH3Slsb/e2EWXQMNA
 9naA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIEPN2I0NGmg2J1QhdswBAbKMcJion3BXxrjvKHrYUdtJgtCQdMTdrN97l6xGvSWeOayemLSU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mGUbiYDUZRsHFl01nPPLRcFDbenANJ5VEYKBX9+zrl9r5KxXuu
 zJHOfj0WomTYFxvnf9ef7dlKsp3LN7IXY7d+r4MtVwuFbnNya++0fNx34917hEBvqXkouB4Yoju
 vrudfEyXorxX7ECzBdC7bMmGbwStQ91c=
X-Gm-Gg: AR+sD126DcpJSS4QlCnMzacovmdIWMaBx5RuBhUthtBg8kldJA04u+bH9NWflpV+dRu
 ClrpBpw3f+qvEm359Zcwpak/O4iExpSYnCbGLxdSHQXXTvw2x3ukkIssr3XVu66qUldJvcCBsEU
 uRsZws1SwpsdTDChj+iZz1ZL0gWFWXEAfrc4DO6qWKP8M4ro9MMl9p7twCAumFhvRDeNZ3XQvJQ
 RL9jZusdKjC6hjIGZ7rWbB0S72YlCPxbX+sNSTzwqBwCT5dl9P/0nazvH4zamIqWg7q3un/Y9QM
 7BPCAebJRPBb1yqJm9EYpZyixmg6RpAKwxGpBEsXbYt12pHsUxLz23m3gAtlUXwIFKq7DhaWfMk
 O2cvdtlY6nZCjOVi5EgdAQM70ttmjwzak7I3TZeqB0pf7M0Egb8Y0n7E+yPdezs2Cm04NUNygjT
 6znNgRb89PhErLIkn6da+nxGc5pkSi1agWvmDSNKY=
X-Received: by 2002:a05:6214:4014:b0:90a:804c:325a with SMTP id
 6a1803df08f44-90c5e984419mr118989086d6.13.1787229128845; Thu, 20 Aug 2026
 05:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260817153144.1951036-1-vjardin@free.fr>
 <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
 <aoM6i7TKGcfAydpp@L30177.local>
 <CALeDE9OSFs=3WkKFh6tBa0VHdVAvKSL=-XktBQHwbTd-vefwiw@mail.gmail.com>
 <CAFLszTjTHnG09rT146KbQq46z2u_nHy6GSwDoS_jcDNyUKO8pQ@mail.gmail.com>
In-Reply-To: <CAFLszTjTHnG09rT146KbQq46z2u_nHy6GSwDoS_jcDNyUKO8pQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Aug 2026 13:31:55 +0100
X-Gm-Features: AcwNN1UsyE7nCTQj04YsCY0TGc4KrMqdJ4DrIcL6IUYj9CfWmWV2dCIxMaVretg
Message-ID: <CALeDE9NRcNJzGUg=mCA3Hpd=uo7FSF4oWjQCFw5gXXVEa5wC5Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
To: Simon Glass <sjg@chromium.org>
Cc: Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org, 
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
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

On Thu, 20 Aug 2026 at 13:27, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Thu, 20 Aug 2026 at 05:52, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Vincent,
> >
> > > > > This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
> > > > > LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
> > > > > payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
> > > > > boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
> > > > > FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
> > > > > NBV32, etc.) that share one kernel image but differ in their device
> > > > > tree and DPAA2 data path.
> > > >
> > > > Why just FIT and not UEFI?
> > >
> > > Because this layerscape platform shall not support UEFI by design.
> >
> > Really? I have a clearfog LX2 platform that boots and runs with UEFI
> > just fine. Generally this is where the Linux ecosystem is going so for
> > a new board going upstream I would expect it to at least be an option.
>
> Generally this is where certain people are pushing Embedded Linux to
> go, but that doesn't mean it makes any sense to do so. UEFI requires a
> lot of extra code and complexity, 100K+ in U-Boot alone, not to
> mention GRUB, etc. It doesn't support embedded things like FPGA
> images. FIT is a good solution and as an industry we should be
> innovating on that, not forcing UEFI everywhere. If you need OS
> selection, Boot Loader Specification (with FIT) is a good option.

Simon, I am well aware of all of that, I have been involved in the arm
ecosystem for well over 15 years.

> Note that I write this not as someone opposed to EFI protocols (which
> I have expended a lot of effort implementing and reviewing). Horses
> for courses.
>
> [..]
>
> Regards,
> Simon
