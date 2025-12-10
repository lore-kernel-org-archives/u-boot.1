Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D223D3C54A
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91C68389A;
	Wed, 10 Dec 2025 14:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DokF1KQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9B983AEF; Wed, 10 Dec 2025 09:33:24 +0100 (CET)
Received: from mx-relay177-hz1.antispameurope.com
 (mx-relay177-hz1.antispameurope.com [94.100.133.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A8283869
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04321b14fb=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate177-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=1M65WsxbDGMqydF4IBt8eNpMGyWs6fhd5lx1eLoJwlk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1765355601;
 b=YvBuaNj49445FbJ3VtzvkkVZZZsR9vJsYFb0zK4/zB3dmOXoLiWyzEdegdZu5dhAwmV2A6S/
 dXB0CYpGWBe1l4PRDEnvKKyC9ud6rwLBIphL+fHDPKKJvkiMJ7ZG7jETVxwnwhrd0hs7j4Bkx+6
 yN88N455Z6pnVGukX/OPt4M7gSvgH7GzapsMYYoi6896TGgq+TD5FerJQxtlKnPDdoTp4L9ANln
 zB3C++i+MrmPpJ0epAmowQAdSRZMXYXy4V4QqDs0pplzryzJxFdl0/DVGh+Cs1F3abho227v3U3
 YN5xAjsum1HX28CgN7nPo1e/b92shiW49NwIJDLWUwsWA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1765355601;
 b=BCfJ+NPWbshM7YtWNPakf4XdEl7AsBG5P1xSN52d/5wCP3PJQkmqoY7AgFaUbSOA/TuiFvQJ
 9JCn93f+qMuKQ/fjEJQOabBScYSWAPPY9o5ztu1RFUDqjaNQhGyKzzBZ9o2HV2YvFMxMMJDtFgG
 djOSSfBRFrCSAN1AiMk1AkNuZay8swjr98uuCaY2DFQ1r9tbSMErrQhuTy/m9BXW6S9EYUnSI6L
 Vge53bXn2UBTsVgstJJ/nfDm7fTTjIHYstRLj4n8eWXaH8+gbbvwJp1d8+Lwu2RkAy+YWeN1yCq
 4aRKNPA4D6Y+I+dOamIVshBXW8T4++E4huhUBnX6+8hXw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay177-hz1.antispameurope.com; Wed, 10 Dec 2025 09:33:21 +0100
Received: from he-web01-hz1.hornetsecurity.com (unknown [10.1.31.91])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 90C2ACC0E9A; Wed, 10 Dec 2025 09:33:03 +0100 (CET)
From: =?utf-8?q?alexander=2Efeilke=40ew=2Etq-group=2Ecom?=
 <alexander.feilke@ew.tq-group.com>
In-Reply-To: <302c38-69287300-35-2a0bce00@4807151>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <302c38-69287300-35-2a0bce00@4807151>
Date: Wed, 10 Dec 2025 09:33:03 +0100
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
To: "Fabio Estevam" <festevam@gmail.com>
MIME-Version: 1.0
Message-ID: <85495-69393000-129-6e273900@184833178>
Subject: [BUG] silent hangup when debugging =?utf-8?q?lib/fdtdec=2Ec?=
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
 mx-relay177-hz1.antispameurope.com with 4dR89q5t57z3kgDh
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 224be8b3f88c26a8ca40da717528c4df
X-cloud-security: scantime:3.090
DKIM-Signature: a=rsa-sha256;
 bh=1M65WsxbDGMqydF4IBt8eNpMGyWs6fhd5lx1eLoJwlk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1765355600; v=1;
 b=DokF1KQ6Phq5g/9/dj8WJBRV4IzUif1WcV3DvlwAeeomUWMa7XBE1OV0QZVUjf5kSKShdGO3
 1eX7qUcliIgMaEM5bCcxtv5Q8onWv+Pxmv8IPrdGPaTvfvCZKndIVmJkZrIcTWJ7ngPNCujZkso
 t1RJZ2pqvuXaz5Px5SeRBPBMqEmW8ZhoTOoIkTzgvdeWS/r2ac9WP8pRc+gYqc3fQxnu8kJi/ve
 Md/RZtQ4pO6U0z8X88L9A7OxZLf9dycFr28lMOf0sQyfmdcBpkSgdAadWHtGmxLNrTlUg6aVy/S
 +l4vhyUIpQ2pFAQY/MFA5vQwTb6H/HjPH7tdByO4VvLBw==
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:12:56 +0100
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

On Thursday, November 27, 2025 16:50 CET, alexander.feilke@ew.tq-group.=
com <alexander.feilke@ew.tq-group.com> wrote:
> On Thursday, November 27, 2025 15:02 CET, Fabio Estevam <festevam@gma=
il.com> wrote:
> > On Thu, Nov 27, 2025 at 9:33=E2=80=AFAM alexander.feilke@ew.tq-grou=
p.com
> > <alexander.feilke@ew.tq-group.com> wrote:
> >=20
> > > I also have a mx7dsabresd but I cannot bring it to boot with a ma=
ster build unfortunately.
> >=20
> > Just tested booting the top-of-tree U-Boot on a mx7dsabresd and it =
boots
>=20
> Thanks! When using 0ae3dc6809ff like you I can boot and reproduce the=
 hangup issue on mx7dsabresd

Any findings about this yet? Can you reproduce it on mx7dsabresd too? I=
'm having issues tracking down the problem there

