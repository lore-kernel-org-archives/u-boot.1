Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DECCCA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CA283956;
	Sun, 18 Jan 2026 02:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mNj3jfL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D636839DE; Sun, 18 Jan 2026 02:48:01 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8EB80FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6481bd1763bso3012365d50.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:47:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768700878; cv=none;
 d=google.com; s=arc-20240605;
 b=KsHsIFrui2lboQEpbukTfYlit+4gt+krzeGGSiOtFNkFPQ5n2zciuXBkK59oYZB8ky
 S0Ng80prRdI1r/IzInw6lJUAeQVhz0WYGCOVLW6cSX7kTHGeFPFURZ1S/BopnjgKV3XP
 z/mJx1CxCIWnTqTmHz2N1dQaIg04vktl8Y6Fn68bR+xdvDCACvqSUyjV3vUxnwLC+030
 o7FrX1qt7rrFECPEOwvfLHGXlLKDHfhesS/PVN+d462s0F9NVG2T22+3daSQLH0UUn4x
 63VHN5N+DZ6RfW8apfsFTBn+VwZWKly1uwO1B8gUQyAwrQkPmhKYWGirQ6gyqfi+pYgS
 2xvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j1hyg79xPA+clSm8tuLBOf8fZh+NB+IDWp8l1s6JQJI=;
 fh=tPAL1aj5DPWMQYt0/Gzb1VwqzsVcQ5rqfVdcwmj/79E=;
 b=Ok/DhGXIaMpjOIVmxwo54D8aQgoIGeQh+/OPbnJIo7idaUXLBZp2W4+J6FW87ddA+i
 Yrbgh69k/qaXMfSVhzeDjhE0pw17+njjQVJsjNdY0jxkFpV9drNrXRG0eFNwUpdD6ii0
 7I91jWutdism4DpTvvydlAEDWvyk5m9FLoRZSo6tbNGNLYqBWK/E3UQHgBtyLm5NDFRj
 3YAjDCLa/UO8TP5wDqt+SnDAAnf76DHndN9A4CTkTygwsOBPJhN3OHWN0Fpgkea5jaek
 sJ9qb5gsjKZTLGxHbJpRI+EaODUTOXRRNYUWAyRnbA9TozAGLcWuo5swtyxFkq5LHwdo
 HSvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700878; x=1769305678; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1hyg79xPA+clSm8tuLBOf8fZh+NB+IDWp8l1s6JQJI=;
 b=mNj3jfL8iWWjHt7Vzz5CGIxL4D3w8JNXD/HbuMuqDtE4CbpBHsuO1uvuV2qfYofEzM
 M1dijeSSCdHe7uDpAeB+nBNRd9AU3mtePY152wCF7b+cKsK2fOJAgkV5hQT4JLgq+7JV
 VgJ+mAaPIQ6ddAPEJDnHmg0BilC8hyq/lOlvf9r0yOBWsh9n8nICKoYKrc5JBGdVBZdC
 XhJ1jXttrW2TeKCpS/1OYANabRN7M2X79OaLd5uLUVqE4sxIoTOqwigVyBATO15ZzauP
 IF7UGfiDVmwJqLEzFDYR+0FL4LsUefragnRfHImEVzBJ5X9vA3VQuhhNTDQRQzcljDq8
 B97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700878; x=1769305678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1hyg79xPA+clSm8tuLBOf8fZh+NB+IDWp8l1s6JQJI=;
 b=Er7XHpGZiS/q5H1a45103jqZIKqoib90vkSCnKIwFb319NoHza29OlTyTKGRRRV8N1
 6S847taj6AzMo25nQtE+OztLibyfqnB1b9ATVEy+x8o2chPcmFr+Cm57KSZD4XYH/ESA
 ssUcD8lYa4ftQGRM17/AgBbmz6Mx1e+qhKyVfwC54MkMUExfKyqlEEWipR53UVOAYyy9
 12By/nMx8U//SpQHYEs3DF0YY9/b26JXm9LxLbpDXu24SaZ+kxEdSMoULAB5tH7x58rd
 yqypnxh/Yp3VbEswvMjhq3PcKVCne7q25vRGMbdlhotk4Lw0xCPY1uxZBSe5KLqhmL8H
 xIoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRbaH3RF9Va6qxlWXYAJrnyyOZ59XeO1r5OrEeVC/peg6JQgP10mq5Nfn3TQF6k+08uBeYyRg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4XRDMf2k2FixFpX8JnBt7KXzndo/GGRomRx3QpwgXX899TmLv
 pYRsLH8p2BPZGw5Z/8SOsR8UK2JsQ+YlARzryDyYcfQetugOdom1k/X1M1/l6ECIkFp/lhwyUXs
 MUelWqHCb0dzmpiUlZlfxliny273jT8c=
X-Gm-Gg: AY/fxX5m7l9J1ocQEMvYJIueNOdeK1+8Jko+uwkWAlC4YvuKTVWVBluIGS8hjIBIWDE
 AyY6Qa9T7gaxw4Mg7I9NWTZMqE4q95Ngft0vlXATYt5pp9hIvmfkrqM/cyGxOtt5zpIhaRYn2J0
 j0S0DuoFFQy+t3He4M1vBsanhK5bqNZF2206CdkdDvsCphec1c9qryRv/wIAzdYApWiNhyLbArW
 KUgOTBtDdXjWzbHEBkkJkMVr6j41GMGb72D+pEmhchEsJse5GH/7C/SfZ1CiLkb/mhI49318iwY
 hPyV3lst
X-Received: by 2002:a53:d252:0:b0:644:542b:bd1d with SMTP id
 956f58d0204a3-64916490f95mr4953140d50.35.1768700878191; Sat, 17 Jan 2026
 17:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:47:44 -0300
X-Gm-Features: AZwV_QgCYGeqc1eRBoVIQ8q_v4eGFfhef0eoDwcdwSQk2KquelSyG-rSvSxi_e0
Message-ID: <CAOMZO5AbKi8P61WJ3KE_ic1WrsFnQA+bS9tBL5KORdtTKBhGjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] board: TQMa6: improvements for config settings
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
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

On Fri, Jan 16, 2026 at 7:56=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> This series includes adjustments to the TQMa6 configurations.
> The RAM timings are also updated.
>
> Markus Niebel (1):
>   board: tqma6: update RAM timing to verified settings Rev.0300D
>
> Max Merchel (3):
>   board: tqma6: Kconfig: select default SoM variant based on SoC
>   configs: tqma6: mba6: add and use defconfigs with general
>     configurations
>   configs: tqma6: activate CONFIG_CMD_NFS
>
> Paul Gerber (1):
>   board: tqma6: improve config settings for TQMa6x/MBa6x

Applied, thanks.
