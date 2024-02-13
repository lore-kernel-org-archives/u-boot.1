Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED42C48BC1
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 10:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4014187D37;
	Tue, 13 Feb 2024 11:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bvNC72xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC9F87CAB; Tue, 13 Feb 2024 11:35:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101D787D37
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 11:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mzamazal@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+630eYzBqnOfq0uJ36XCxNBlk8zBk+MqhBxeIj2WgDI=;
 b=bvNC72xXOpDAwWvQETQ+/IHjhNQjG43T6NlLYxm4ZffcRcVVlg/8Uj37iVLzoJG/5Jy9q8
 denSit+URvukpQREUxQy1oJCnJ7/3O3spaPmtpbFv94ISiSiLpv46EePwA09eMnVx7g1Xy
 kQnWn5Sv268smurYLcwLoIR0Plx7syw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-oys6zq_xP3KTNM6HMKoyaw-1; Tue, 13 Feb 2024 05:35:04 -0500
X-MC-Unique: oys6zq_xP3KTNM6HMKoyaw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3cfc0287faso23754666b.2
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 02:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820502; x=1708425302;
 h=content-transfer-encoding:mime-version:user-agent:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+630eYzBqnOfq0uJ36XCxNBlk8zBk+MqhBxeIj2WgDI=;
 b=WNNdZJ30fPpMiZUZy57nUMOU5bDI2VZYlJT5xXiFEqLN5trUcZuSGacSGauu1Zmv3v
 0b2eYDcn5ie3whiMOHJtQRBE7gj9I4AwQqLRip8vMNXLSbQkYIWG6YJ9pbl9Sw32jRe8
 ISxrk64osHwNwLCDiL0NjX9p9wwFs+9AjP7RTCdzkjb993/axhglgd8MuZaS9DMmd8F7
 SJS37xBSekT4Pf2aDacOy31Ah6y4lC3JO5q2m7FQVU3S275bi+fRfLbS52Hwad7aeevP
 aew0/zyG4HnPDvreRKc3ke7Cy5/gYbkd3tfVPHx/1U8MKPOufkcmlfAPNiWZAEGKT8G8
 kyFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYmNoiE45o3ou+FkRjwil/Ryzo1ayJ/fQbqDOXu0ly0o2c0tMTh+i3uGwWfBuueooCNDCjaDG56xeDd5S0qo2cw6/quA==
X-Gm-Message-State: AOJu0YxIgesdWFAica03q+am7Yo0/orwbOwlZHBH2H4i4PacEJpfPD+Q
 PwvG85v0sDOQf8iewbQM9nBimctKNJpE1s5QewggFq7SaJh56nXeG9EFynfgyaz8HDJBXgpaWbJ
 PHdC5ziTnni46aZagsqF5DUCzxFhQJoBnw1G0Z6ntoFf7Jwi406TSjCfdc4XvzYaa7GKpNVBzMA
 K8q5QRi3crXr+h9T1Vd+i48jXaOQoBudZVpfU=
X-Received: by 2002:a17:906:ccd6:b0:a3d:15f0:85cd with SMTP id
 ot22-20020a170906ccd600b00a3d15f085cdmr434980ejb.9.1707820502093; 
 Tue, 13 Feb 2024 02:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYu79zCxMUqjhEIqN+oiSbYkX3n6dsWOpQHWjQfVodN+pKTzcHY406UO9SEFvXHCyS8BgQaw==
X-Received: by 2002:a17:906:ccd6:b0:a3d:15f0:85cd with SMTP id
 ot22-20020a170906ccd600b00a3d15f085cdmr434957ejb.9.1707820501563; 
 Tue, 13 Feb 2024 02:35:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVntqZ9wuwTqiu/e5pemQXrHQQm0OF8G71ayHG/zy0RtoDngDIu3HmiJGpiveQrRs8LH6c+ePwuUEn7TQ+HtPGHWCk9i2Rvlfh3DkVTOyHuQNrfofTJFna+Zfqa46wublmFzKTSKKc0FcUlVP3i
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 ps7-20020a170906bf4700b00a3c7fb8cc74sm1137901ejb.154.2024.02.13.02.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:35:00 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Gilles Talis <gilles.talis@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>,  Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com,  u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
In-Reply-To: <CAKcgs2wmZPQEnV0xtr=L-BdX_Qt=Qbd2XwEZPDqSG_xHLUd9uA@mail.gmail.com>
 (Gilles Talis's message of "Mon, 12 Feb 2024 08:45:53 -0400")
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com>
 <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 <87bkavbo6c.fsf@redhat.com> <877cjrss43.fsf@redhat.com>
 <CAOMZO5A2W4ZZBdUjNkA9fqB+kBgASM7esfcLL3RvdwmCi9qakw@mail.gmail.com>
 <87r0hy38am.fsf@redhat.com>
 <CAKcgs2wmZPQEnV0xtr=L-BdX_Qt=Qbd2XwEZPDqSG_xHLUd9uA@mail.gmail.com>
Date: Tue, 13 Feb 2024 11:34:59 +0100
Message-ID: <87v86smz3g.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

Hi Gilles,

Gilles Talis <gilles.talis@gmail.com> writes:

> Hi Milan,
>
>
> Le mar. 30 janv. 2024 =C3=A0 15:55, Milan Zamazal <mzamazal@redhat.com> a=
 =C3=A9crit :
>>
>> Fabio Estevam <festevam@gmail.com> writes:
>>
>> > Hi Milan,
>> >
>> > On Tue, Jan 30, 2024 at 9:22=E2=80=AFAM Milan Zamazal <mzamazal@redhat=
.com> wrote:
>> >
>> >> Well, after trying both the SD cards again with fresh reinstallations=
, it works
>> >> with a 32 GB card and I get the error above with a 64 GB card.  Is it=
 possible
>> >> that there is something wrong with SDXC cards?
>> >
>> > Does the change below help?
>> >
>> > --- a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
>> > +++ b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
>> > @@ -128,6 +128,9 @@
>> >         bootph-pre-ram;
>> >         sd-uhs-sdr104;
>> >         sd-uhs-ddr50;
>> > +       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC2>;
>> > +       assigned-clock-rates =3D <400000000>;
>> > +       assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_400M>;
>> >  };
>> >
>> >  &usdhc3 {
>>
>> No, the same error. :-(
>>
>> Regards,
>> Milan
>>
> I tried with a  32GB Sandisk high endurance SD and a 64GB Sandisk
> Ultra SDXC UHS-I and both worked.
> Can you tell me which 64GB sd cards you tried booting with?=20

Sandisk SDXC Extreme 64 GB UHS-I U3

> And also, which steps you followed to get the errors (which image to down=
load,
> etc...)?

wget
https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/aarc=
h64/images/Fedora-Server-39-1.5.aarch64.raw.xz
unxz Fedora-Server-39-1.5.aarch64.raw.xz
sudo dd if=3DFedora-Server-39-1.5.aarch64.raw of=3D/dev/mmcblk0 bs=3D1M
sudo -E gparted /dev/mmcblk0
# move / resize the first partition by 8 MB / to 592 MB
sudo dd if=3Dflash.bin of=3D/dev/mmcblk0 bs=3D1k seek=3D32 conv=3Dfsync
sync

When I do the same with some older Kingston 32 GB, it boots fine.

Regards,
Milan

