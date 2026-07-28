Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E3C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10C66606D3;
	Tue, 28 Jul 2026 18:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT5pk98fK1O8; Tue, 28 Jul 2026 18:07:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26655608A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785262070;
	bh=2NOvKDqZqpw2qhE/dirzeabgVjyYven2rMlMPB/zmcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x54175+Il1FsgfSAyv+yK/Y74nMDNnFlWMdSHFGDUoQKUQDvNWCokYmoiFlUcD57Z
	 6PC3AfKahtxI0y9XTKgTO7JF9Uo0GTZJB59dk/iWx9A5rW4NNSATJ/GdEnUVJmoeth
	 L50XAoKebUUOz/X02Sh5DdKi5OXTp1tJCecvj0Kf7imQmiDob3qpiFE831Tuh0nIDk
	 y12gva1ZW48qX521Nsk9Y6NebvmFW39vA749H2ad9/l0JqAbHCYBFZPxOqYCGC4oHm
	 kvr+IaAmOGj3pwNzF1l+rDzq44btK56c+C9gu/s77Tjzy44+Z76q1wYOjP+lGDJwMG
	 kAVBOTAlLmAzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26655608A9;
	Tue, 28 Jul 2026 18:07:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55BC826C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BEF98116B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOh1UvS3VXxk for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:07:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A1BA81115
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A1BA81115
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A1BA81115
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:07:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA078494B; Tue, 28 Jul 2026 20:07:44 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF22F8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 20:07:42 +0200 (CEST)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aeb8c19017so82903e87.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785262062; cv=none;
 d=google.com; s=arc-20260327;
 b=cXG7BpFL0Iy+c+wHXuPpoo15PaGfOV54vDUR0kjH8MKyUBMPNd5vyh+CenbX2K67p0
 JfyE5NFMwtigM+Il6GX1WFe/wUfE5Gi+OlIUkxxSFwYd0BtG9bp1wvb4MWaTuEiJTQU5
 z3CkG+5oAuyp7T+vjNUtcXzDbJ1TE8Tvs4WxhutydvpbAaSkg1p+xUOXLLTO849MQtUq
 f1bqS50f2BZOZhgW5q/o1s/uDfHSj26uDvaEmQRZlmesBDoWjeGd4Jv7FPE0qqcAOITS
 YEOp9Zx0+yCMNFM5N8/6AcaTvk0m6xquwZwIqHEQhoOM424EZjgFGaf+rLCq1vDshLOC
 4uHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2NOvKDqZqpw2qhE/dirzeabgVjyYven2rMlMPB/zmcw=;
 fh=bV14b0+pGWbPZ8g597H/PE8P9l7clrtqIVCLolPdark=;
 b=XBzLCYWgruO1k3vS/sLkPTzmvequEUnfgouAIg3YBKCezP/bvvgdM0nh++M3hAnm9b
 8zoikpbrL9uIXJlrH57Higa2Tj95GnMtWG9+FNEGftuT1m6dxL541p1jG2qbOj+Qa2Gs
 mbrWoz5rwRcq+BbmaLU9Yt9HKdOL50sfhMqYdauxOJKkxBmteX8dTXlq7rr3hbaqVygV
 kSJUo8FTF1Xd8cYQKvEDnRjiYareCWlXD7kQgwyBBaTuxwNQdp+vL/TkOtAj4ivFE3Rj
 NO59gg6lUw+ad5PrDaBzaEN23Tb7zLYrY301hfqqrD0ojUY6dGAd6yi/etoMorpGaFO9
 pBzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785262062; x=1785866862;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2NOvKDqZqpw2qhE/dirzeabgVjyYven2rMlMPB/zmcw=;
 b=AnPBOfvptmFiR3IoZfhj4zDCeZwrf/rpHjoIl+uwvGR8Wq7uy4DNWsgO4r4gefo+Ta
 yWSvnjMyFbCfTQg/kpahwjnWu+bAQE9qIQ5c+hMzp7dHTaEPmSH4x0nxZZgyyqr6GNWW
 KHJqCfQ5NMKmbchdLVqwHAWIbWl89gVlJIkp8SKdyvGgQOSp6R+hoUIOF/e1J5bePCp0
 OfwL0Jkd0kxYFLxct3S7DvX8LV/dpsTq+LF2l5FbY/H47K1AuqKAYmIJEwHCdTrkmwwT
 ckIiAxtDZmza9OdxNY92tvAKJ8ZMmigj9nlydg80SJ8GTnzmPf+EUyZdFym9ZuMbSJqT
 H8ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMskeexPnh8TkY6IlrGIEOmEx6Rx9D4TLE8L8zW83xHGCQhqlSG2TQ0yJEnEZ029a/3tapqlw=@lists.denx.de
X-Gm-Message-State: AOJu0YyqTpk/v4o2hJY7TzmIjs/EtjDfZN3x3askZsj/rJMmLX6OTdve
 JyldL/pwqIEXJ+2s0Wlx1yZFlYNV+0DIaHTnks2Xpachdewov0SFP597sqO0ccscx8wjP2FPibh
 ERspR3qi2HBdJdlKwe5/SmD0n4NouAcY=
X-Gm-Gg: AR+sD10804icz2OKD1YU2ibfXHC7rM6I7nSWdZBnAz0g8cBpuma6Nh9VG0/DkiZWgrq
 BmPCdPlPBPcLgvc2GvSOsKfuDRmARQQ8gZcb4urkmW4E7sbQqOKufWUZZ+QFJW42CwRJ1bicjF8
 sQy980fe6wIKyIbw2pLOmWFja1aWMzcQL0x+5lIXGksTYATNhjjbuhvW201aMIuiWpFTp2x6Zqu
 JuXlAt5MTHpVVBVdrBxTnWDZVMZuXE2rbT9S45w2ouAV2EryIfC+CBjlfTKsvExVtRME9cuGgsh
 PbCvuzp/by2Ksj1N1sEB0ZDE3a/Q6r4qecW4KjJGMHN8aPv0cXE=
X-Received: by 2002:a05:6512:6181:b0:5ad:55f6:1ec3 with SMTP id
 2adb3069b0e04-5b2d0213884mr618357e87.5.1785262061709; Tue, 28 Jul 2026
 11:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260728060314.3560643-1-qijian.guo@nxp.com>
 <CAOMZO5ATbaYCmgh_tCSV53dtZux+yqPJ_eOzgdk8KbzxSMb0Ow@mail.gmail.com>
In-Reply-To: <CAOMZO5ATbaYCmgh_tCSV53dtZux+yqPJ_eOzgdk8KbzxSMb0Ow@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Jul 2026 15:07:30 -0300
X-Gm-Features: AUfX_my3j22ypFwDAnbuC1v4ixDjNDdgnOYw5_jkxbE8NJwzJQDey5Jak7cPWSo
Message-ID: <CAOMZO5DLRuqPhzXF0Swm9enkugf7GNNbZjN0=rwTLePJCSD16g@mail.gmail.com>
Subject: Re: [PATCH] imx: scmi: suppress invalid origin/errid in reset reason
 print
To: Joseph Guo <qijian.guo@nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@nabladev.com>, 
 Fedor Ross <fedor.ross@ifm.com>, open list <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785262062; x=1785866862; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2NOvKDqZqpw2qhE/dirzeabgVjyYven2rMlMPB/zmcw=;
 b=aM7a3qq7laqCRMkpN0cGTJjoVEqw56Pgxd+jL8TAm6EwdVBYDs3LgvVYOtfTcjQiSh
 7ZbLGFTbxgfU0fCayLCz+vYaaGtGpxWcZRwUvPFhgBSJcIQI9nwvwPoG1oTmFWXsMMhm
 RvdjPMG68YHQ2Hnr8m/mCy/BTgYF+IGx6tc9ECSTJsIUQ5VbtzU/03PGiH92em07gq+g
 esJSih+Aw3TzYgANN1gHsiJLUkIsb/DcGW6Ch4496e1mBbE3J/pvO+BADmpPUVUCaQZD
 hpaLIuKVhU24k7jqe1b5L34cYQzsoaowstzzG8ai6zFMbVZV4hNckbX+K9O5QBedKaXR
 ayVA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aM7a3qq7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aM7a3qq7"; 
 dkim-atps=neutral
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

On Tue, Jul 28, 2026 at 11:06=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> I don't see this patch in patchwork.
>
> Please resend it to the new U-Boot mailing address:
> u-boot@lists.u-boot-project.org

Nevermind. I do see it in patchwork now.
