Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13846C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 22:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C84882B7;
	Tue, 25 Jun 2024 00:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Rz1mJi+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0997883D2; Tue, 25 Jun 2024 00:28:22 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF01184374
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 00:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a724a8097deso207556966b.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719268100; x=1719872900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3sorjRD5sWx65qot7iJvwV3GFcd47xslgJoS1OOYjI=;
 b=Rz1mJi+rLok+eS4/Sk8rO2Z3s42tnY9lOsAv5O3byVksST1OKIKnMoeelUhTqCbPlo
 rCpo2sonKFt+jj7T18oOLb9Z9zwp6ufrPzzznAcPCirdYP8KFpJ4kGTWaGkJnk5NL4d0
 GlIGLnkrnkezqzLOQI9vk7v19CSVn1lNdEQtLbOBozHhWqfm7/HeZn16IedhcZ/i/uYf
 l5t7unoGnXldmxd3GZViDm/tFuIr/4rKONXIu1IijipBnYPdJMBe0Ev8Dp80cjpEAgst
 LY1nHofeEZVWbpiytygTRKBrq77fJytV1lmufX+q/aygOi/AyWjRsDRW+mjh1FRM8Hot
 Qr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719268100; x=1719872900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3sorjRD5sWx65qot7iJvwV3GFcd47xslgJoS1OOYjI=;
 b=RjAfAsef25BQyTv174UR2qhSJORmng3cqI/fHKO/zdcdRQN3TBSYuB8F+H9EE3j94j
 zVC4EmV7BK05W6r5HmGhGsqwlFJQE/HweJSAOI+zfcVRV1gR0VLh3h7NkLqXsnRf6ypv
 RYwVLM8c/DuxWIKEwegmp1jJ4smk8tvoNXkPPUjZzhTLbCk6281agphqGPdL/mJndBzz
 9f8BHg+2nfhityUBdC9qbRIg93e2/ouqt8Q2j9ekZfda7XqpgZ9R9O69MIodGNqCx8An
 j+uiaPBObu2ooHA0H4vFmjSJ4iP+UpIgNcA9Z2UiYfrevWIM74ZsPBk4I7vz+r+DrxK7
 qaoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa/SmSW4kiQsJXPN4GCRwoXH3QlAgRHjZapWDIK+70ugcJo5LOWcEFOkGrQNskqUJseBoVfc8Bov65N5MGJQLskd9D0A==
X-Gm-Message-State: AOJu0YwEChzQAw6+MNksOjkHqDXAH0ON84YMWjCNmbVYsbvUDhXhOo9Q
 F8LfXVM2fDxtNw9J+w+aOPQiyzUB38h6dlUNKRCWqOKTqyqc/sVX1N87YYwvdqxe8Ly7cPSCFev
 4On9xOlKUE0x2Eh+Usl3FZQ/RZkDeOLXnDJRJWA==
X-Google-Smtp-Source: AGHT+IFGD3diYb7Y8dLvPQ9+rNwrzrXmbXeD5O8JSgXfzMUJti/XoZlFcb6QcNgJXhZrWmzBN6fAmMeLuAXDqdb4Ylw=
X-Received: by 2002:a17:906:dc91:b0:a72:60e2:bf5 with SMTP id
 a640c23a62f3a-a7260e21034mr131419466b.19.1719268099949; Mon, 24 Jun 2024
 15:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
 <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
 <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
 <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
 <CAJGZr0LCGaKN_G54HMOmQx8y7cuER_OLGP6Axf2ksUQLhoSF8Q@mail.gmail.com>
In-Reply-To: <CAJGZr0LCGaKN_G54HMOmQx8y7cuER_OLGP6Axf2ksUQLhoSF8Q@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 24 Jun 2024 15:28:08 -0700
Message-ID: <CAJ+vNU2X7n0VQjP0EZ7NpyVM-fKiqWQ7xL=MKGa3xQa+d4YXrA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>
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

On Sat, Jun 22, 2024 at 1:09=E2=80=AFAM Maxim Uvarov <muvarov@gmail.com> wr=
ote:
>
> =D0=BF=D1=82, 21 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 21:42, F=
abio Estevam <festevam@gmail.com>:
> >
> > Hi Tim and Jerome,
> >
> > On Fri, Jun 21, 2024 at 1:08=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> >
> > > I tried your to-upstream/v5-wip branch
> > > (042bea36eb9731079a3d7afffe3774d79e06ac5d) and it behaves the same. D=
o
> > > you have something else to try/test?
> >
> > Yes, when I tested older versions from Maxim I could never get lwIP to
> > work with i.MX.
> >
> > Jerome,
> >
> > Please try to run the lwIP series on any i.MX board, if possible.
> >
> > Thanks
>
> Packet not for us means that incoming packet DST MAC does not match to
> the MAC address inside lwip. I.e. to MAC address set into lwip when
> lwip_init was done. Original U-Boot network stack does not compare
> MACs but lwip does. There is something specific on this board, in
> general lwip with debug should print out
> MAC used during initialization. This MAC should match to the MAC from
> the incoming packet.
>

It seems 'packet not for us' can mean a lot of things.

I added a bit of debugging around 'DHCP packet accepted' and found I'm
not receiving any packets from my DHCP server. So I connected directly
to another board (isolated network) where I ran my own server and
tcpdump and I don't see packets coming from lwip:

without lwip my server shows:
# tcpdump -i eth1
tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
length 262144 bytes
tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
length 262144 bytes
22:18:01.043992 IP (tos 0x0, ttl 255, id 23, offset 0, flags [DF],
proto UDP (17), length 328)
22:18:01.044391 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
proto UDP (17), length 328)
22:18:01.044454 IP (tos 0x0, ttl 255, id 24, offset 0, flags [DF],
proto UDP (17), length 328)
22:18:01.044752 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none],
proto UDP (17), length 328)

# tcpdump -i eth1
tcpdump: listening on eth1, link-type EN10MB (Ethernet), snapshot
length 262144 bytes
22:22:41.602178  [|llc]
22:22:41.709978  [|llc]
22:22:41.867947  [|llc]
22:22:42.105202  [|llc]
22:22:42.502091  [|llc]
22:22:43.219079  [|llc]
22:22:44.497979  [|llc]
22:22:45.776884  [|llc]
22:22:47.054773  [|llc]
22:22:48.333667  [|llc]
22:22:49.611559  [|llc]
22:22:50.890469  [|llc]

What actual hardware has this been tested with? I think Tom mentioned
he tested with an rpi of some sort.

I don't know what the meaning of the llc msg is above but you can see
there is no DHCP request.

Best Regards,

Tim
