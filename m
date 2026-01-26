Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70741D19502
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 18:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A3683D0F;
	Mon, 26 Jan 2026 19:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aaz9LDF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC69683D13; Mon, 26 Jan 2026 19:45:59 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF6783BD2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 19:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-59b710d46ceso4654310e87.3
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 10:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769453157; cv=none;
 d=google.com; s=arc-20240605;
 b=Wno1uyAquAzb0Oj+Q7f6hRwEQIJtCF/0WjRQRz5tGfDvX+iGPfU0ZbFEzyW5gJIEWL
 lMxvUtETh8JeypSyQDbRnyR9tuIdzzpwCcCKJjgScGiAumJ/nlB8AoeASXDVXKjWetfr
 XY1nvRYgyVQu3B97ZyI7A9VePnNZVXcOs6t3m50/dsBudBPfa9W7IFKwQKLSbYH5HXrm
 7mTq7rFrljIYv0aHJpU3cXC6d4yxtHFsILBJKOOZJbyR1ZXwy6DKwSLOcXCrhVkLZKWA
 RZoqebDNChN/xw8I7r6smdIvqXHF0cK2fcv1jHaDqoz2kiXSFzDo4siR80kcWlyNDsCY
 AGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GRv1w/IQ5p8AnZ6XRye8hJeFq8e2rDzky0kwIQM+m44=;
 fh=hmZM2R/tdrgghdCxD0JU6b7UTsxGeRQpElcZCPcYwfI=;
 b=CIR+PsQ++AgGPUyXFka9P5X9BQ5TA9qdxWkU52RxlFXf9U9aWZW8BEOWkQs3bB2LQ+
 QMJAat2qoyRl6OldZHQJMhDmM3130EM+Ah8jYpLVD9bZUJvRTVLIK7dKlhp+Xgds5VsP
 LIcIK1ncX7K2ECkmGD6bEVLS1maoeh2UwJjaWIZy0tIfv0qoHJqRAt5Oxgc8rXYYMJPC
 iSQIPy0+idH35L3iGaIRV2NZHm1oAWCL+xvl2jvxUA99jJQAWz0p/GvTMUGpJnJ2wig6
 niYN82M84NfEUNYCzi8R6LJAKs80oHA8dFMbn1Vb1wN8xQi78AeWvBwXJ+1dq70PonH1
 2NKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769453157; x=1770057957; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRv1w/IQ5p8AnZ6XRye8hJeFq8e2rDzky0kwIQM+m44=;
 b=aaz9LDF4B31T/2ovcUS0DmphUdqdBdsyCOMQE1vzwpyOYNA+99Ke0A4itiPJUCdcnP
 8op9dHSlYPgWQLYGwb7wWJN83KR2B0kQb+K+w+1x5o4Oj8w88Lvv2/CzSFbSP/E7F8Gm
 Mj/0YkQVXxL5F90ZuDPgS04J+3+/SZqG1Rsf1TBZ/Q2s6VXAa3M/X7YvlRtfBDuLlQD1
 rgqlGxlXLtv502gri8FNnXwoDzqnaOHe8Dnx0WXbdDBt+lAa1ifBZmqOuZ7of4URuHze
 rUXORuG8ncw/mJN1xWwchbrRXevCgnPir2rz1Huy5AUZH06f4AqFA/JIhMg3X4QuWceD
 6c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769453157; x=1770057957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRv1w/IQ5p8AnZ6XRye8hJeFq8e2rDzky0kwIQM+m44=;
 b=iJxX3hzunCV+gi6DsgA8n+c+f9gkBNOOcCSa0FuBgZ9AHWeIWx2TJrtuvMjHgynfJF
 Jy9PiFerHhTXSNGBOtt2kq0S/Ju1qxUycVfbgotzSumxgmfN1VCgUR7sMpmkC8FBez3x
 AvqXGYP0KlVM4+VRFg+yTr0KVtOD+A8Ko4WTrK1UgMvOQ6cYwpVy/tWo7D3J0c992kaI
 Q1vILybvVcNqzxvBF7tGiyJ0iDg+EOswEnNbd828Z/2wTr1P3KluxVY+F8t7M2+f6aa/
 p0MBLzfQg8VXxME69iSTqMtmlGZxyGzB0qQpREJoIdHc17qowo0POX/Fsj7OdsDgltgL
 Zoeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtxqMq40LJinIwRZZBnZGF1hT6Ok2iX00Bk2XxrC0ZYoZp5cJm1XNyy5XMwtctZ1dTGQQH4tk=@lists.denx.de
X-Gm-Message-State: AOJu0YxdIeM5Nscyn1ovwThroE/WhBF43zY08o2ngLFA8WavGguHbl/Z
 N+vgxJiltobRg3qtDCRjbS1a5zodOM3Yxb1fU3VZTQMFDO2xJUfSQDpXpmXU1/sHtdNwN1vyffp
 Zf+muhdSOvbiKfiFDKCjJZ0kR97LJtY0=
X-Gm-Gg: AZuq6aL9/VyKIqoPwhyx/zrx2pc/yaodFzwy7DAFeiiYwnzG2waLxc6uQuxtVsCZXaf
 shJn0jO4Ei54ekBS9Dj0hMs+TUD33gjaBsBspCTAgxPC1tkS6XQEf19TdR92AE+OrXlIQbrZfzy
 0nAXKa1f4ydjcV+Q/q9wHePS70KleVaTaguxO8N5cVwgrTiSx4+GprsGqH7fT/j3nZdXAF2qIk7
 majZ3e+1Vsj0aWxU/zhetpQo7X4sAYaV9s+p21LAn1AprQQ+rGqFag5j3EROHMvSEyyx+30SuNt
 couFT9++Adooh2cNf1jDU/5fCSM=
X-Received: by 2002:a05:6512:32c1:b0:59d:f5a8:273 with SMTP id
 2adb3069b0e04-59df5a8032amr1369862e87.29.1769453156817; Mon, 26 Jan 2026
 10:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20260123-nxp-v1-1-91feb4312639@nxp.com>
 <aab556e9-9789-41f0-a4c8-01d48c191940@mailbox.org>
 <20260123143854.GJ3416603@bill-the-cat> <aXbLT9xwbP4bipYR@shlinux89>
In-Reply-To: <aXbLT9xwbP4bipYR@shlinux89>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Jan 2026 15:45:44 -0300
X-Gm-Features: AZwV_Qj-tGmMO0HwwCYk7yrrXBUbZcLh__rgTx0O7yEJlb_26pOZxYwnugzE1Bg
Message-ID: <CAOMZO5ASey_Xqs0iQt4ZvvrXm83_qp395kh-i=quvMmyU3EL4w@mail.gmail.com>
Subject: Re: [PATCH RESEND] board: nxp: Rename board directory from
 board/freescale to board/nxp
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, alice.guo@oss.nxp.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

Hi Peng,

On Sun, Jan 25, 2026 at 11:03=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wr=
ote:

> Since this touches LS and i.MX both, I would like to get an Ack from Fabi=
o.
> Then I will send you the PR soon.

Personally, I'm not a big fan of changing directory names to reflect
companies' name changes.

I view it more as an unnecessary churn.

In the kernel, we still use freescale/fsl in several locations.

Anyway, I am not opposed to using nxp:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
