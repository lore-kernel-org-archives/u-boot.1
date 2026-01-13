Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E13CD29DEE
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82076835FD;
	Tue, 13 Jan 2026 09:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SskwEExE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8FD83642; Tue, 13 Jan 2026 09:52:49 +0100 (CET)
Received: from mx-relay89-hz1.antispameurope.com
 (mx-relay89-hz1.antispameurope.com [94.100.132.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B2580077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0466863190=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate89-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=BFki2m4DL4L1GcQtZsdTACjLLF+B4uXrSs6gmaMKBvY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768294367;
 b=O531gO7lvHdpuOAinDDOv/5B0kmL1ckqcRKrDoHk71qO8qU1w0W9O1NsLxcY0Cr4q31rRAiU
 T4ClIjQIVU+/gt0zj/pfg8fqZ9UDdiW9Knf8hlHSsnrtNfvbv7rKO1y744yAMvzTdwS4VQ+6xpW
 0hdr4yreKOXhEaTUFc/dY/YHHojBiQJ0KiLyXAGm6CK3xIbr8SRzD953jRlBDbsJisSR40DuJUS
 3OlrH68QD9GLNWE3cy3wDthPpWD5M6FuGrCTKwpc91p6td8xmcdbF+yZiD5mLXSMjkR/Yj8OJRr
 YdhfeaVWRS7zzbcYt5+5+DTxb5Qsy9aClmJsbKAkrSPwg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768294367;
 b=JwMelDbj5c9DAy0CgZgyPyixOpWhUjiF/IfHnL19oRKzdOneQnrMKEjMr4c6LwbS4hM/bgil
 0z2/ivNESL+ds9L41f9YDE/8DUERo1rh05GfcIqs1B/3ESo3UXtuYKflD70rgoMnGjrHb4/57ne
 7gHT0EUqvbZl07lN/gf5KMEvjBmLzCHGeDKrG9A84lItNAXV5VK9ohrx9UUqMXB+bd1kf2kJ7kk
 rePImD1Ndkf7l9JwDgDPbCHzMcsBcVZb0feADbjTm+98QUsMZBBr2vkOvOlZpHjx+laQZEe1GZe
 uemMIdJpXAVSTtcEHYICCqI826Mi6K8RXS5Cg4FWC0g2A==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay89-hz1.antispameurope.com; Tue, 13 Jan 2026 09:52:47 +0100
Received: from he-web01-hz1.hornetsecurity.com (unknown [10.1.31.91])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id AFABB5A0EB0;
 Tue, 13 Jan 2026 09:52:35 +0100 (CET)
From: =?utf-8?q?alexander=2Efeilke=40ew=2Etq-group=2Ecom?=
 <alexander.feilke@ew.tq-group.com>
In-Reply-To: <302c38-69287300-35-2a0bce00@4807151>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <302c38-69287300-35-2a0bce00@4807151>
Date: Tue, 13 Jan 2026 09:52:35 +0100
Cc: "Fabio Estevam" <festevam@gmail.com>, "Simon Glass" <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
To: "Tom Rini" <trini@konsulko.com>
MIME-Version: 1.0
Message-ID: <d6f95-69660800-e9-39c27bc0@93971335>
Subject: =?utf-8?q?Re=3A?= [BUG] silent hangup when debugging 
 =?utf-8?q?lib/fdtdec=2Ec?=
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay89-hz1.antispameurope.com with 4dr30g6glVz2pXvx
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8a35be522a0d225264531d786fd58fe1
X-cloud-security: scantime:2.074
DKIM-Signature: a=rsa-sha256;
 bh=BFki2m4DL4L1GcQtZsdTACjLLF+B4uXrSs6gmaMKBvY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768294366; v=1;
 b=SskwEExE1O0XXV/R+W/MxQcCkr583mXhr4QswjGmk62Us9eD0Xf/+LAaZlN2X/JzFtsoKkj3
 V2t1/t20wIEaL6gHPA2tUA7Kf1/m8W7sGR3tPLRDMNyxVVKucAO1mrysMqj1HG3oZ+TsBSpBrZq
 WumX8qg1lqKoBk1UHRB5mWY/5yhS7u2u+jTHxbPQantxn27OaWomQyIdaLWZfbjre4bCtaGEZIr
 XnKKw2ppcURlG+DNaHA1Tf9O6OjygEeSQKAxRRlHchDy5vSKrTt1vTE4YY2+SaVP0o9F+z3VZLO
 lEksDqM8Jo64CjBhitiEXdH/dqFgsaRTQ2qY56aqxhjQA==
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

> > Description: U-Boot hangs silently during boot when enabling DEBUG=20
> > in lib/fdtdec.c
> >=20
> > Not sure if its really a bug or rather a configuration issue on my =
side.
> >=20
> > Minimal steps to reproduce: <see patch>
> >=20
> > The hang is caused by `panic("FDT overlap");` later inside the if b=
lock.
> > (see `lib/fdtdec.c:1279` in `fdt=5Ffind=5Fseparate(void)`)
> >=20
> > Additionally, no boot log can be seen because serial is initialized=
 after
> > loading the devicetree in this boot stage (see `common/board=5Fr.c:=
665` in
> > `initcall=5Frun=5Fr(void)`)
> >=20
> > Tested on i.MX6 with configs for tqma6d=5Fmba6 and other tq boards =
that
> > aren't, mainlined yet (tqma6ulx=5Fmba6ul and tqma7d=5Fmba7).
> >=20
> > Any idea what to look for to fix this on our side?
> >
>=20
> I can boot and reproduce the hangup issue on mx7dsabresd:
>=20
> <debug=5Fuart>
> FDT 8787da38 gd 0091de20
> top 87887538 sp 87800000
> sys=5Finit=5Fsp=5Faddr 0091ff10
> gbl=5Fdata=5Fsize 000000f0
> FDT overlap
> resetting ...
> System reset not supported on this platform
> ### ERROR ### Please RESET the board ###

Just want to revive this topic as the issue is still unresolved.

