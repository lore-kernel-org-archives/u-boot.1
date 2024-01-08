Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F0CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 08:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7168794A;
	Mon,  8 Jan 2024 09:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SXkakPdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFD787929; Mon,  8 Jan 2024 09:43:06 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6797887929
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 09:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so149921966b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704703384; x=1705308184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PysvAtygZvV/oByXKVHl3LA7AiZOjUv7VExLE+s46uM=;
 b=SXkakPdjCRBJPQnHpu1XCbVHhxp/+fuwPft2sJSa1XSJbQ0LvUvYfChMEDDLHpZwX0
 wsHpKXgkTyudQz1os8V8fk6Hm/LvHgnAlMBa0belClnBfNCZYjZHxK5u8BqVqMX+zYng
 qyw/Gjh1g9aqCNvbCZqfEytIzTK2q0gnwiE7XXNb6+33lGImrfHglTO64eY/tD8eARV5
 I0tv1TOfAWkBVscfrzhg0tm18OOQLJLXDNRlnnAiAuyPJopG89zUXd4QTSrVbuAj+iqS
 Q4S1YfyZjig6kXKxq52juFFfAwdyeu4OrwCl7nkF5RDcugDeV6SEp1QbvGzyxqaStXJb
 qdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704703384; x=1705308184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PysvAtygZvV/oByXKVHl3LA7AiZOjUv7VExLE+s46uM=;
 b=dfHWu1AokNLC/FLHdIBm9FGLSlYTiTfQQE2GNg43ugMkcmtm5Pd5/T5q6Xda9tYh9G
 XXTzdSbs6pNvcMEjzn8OqopfIbrbjPWhQCrTZ8ITjlQ3cUHvMssB00yoj+k56hQD+BBk
 9RsrEwNl/Yjx36+BvrRP+Abv5ljxCFFmwnDLlTjY1b/R28Sn6zuw9zlm8y9tRzVsnEXD
 3rLIFbD7PfaZZDlhfzUjR24Y8ZUUgCcLo1+fj+bJ5lNjEEkNjlc90b7KwsgOHCpHWWZ/
 Ky2F7QEgqeP/FK8BCYrdSfOORB9KeeKr4Z+RfVGJkpeZ1snv8HVC/mDgmgSV8jMCwmv0
 dC3w==
X-Gm-Message-State: AOJu0YxHE6Qwi2eosgh1kOSqCtVq3PmrwpeeAswycTDlOw8LnNgOsGqy
 pJMuGUKTOCbN6sPGPNtF1BGdinBd6Woz2CsQLNS5p/G+up/rOg==
X-Google-Smtp-Source: AGHT+IG/XyMF/xSDmd7I3/wtbHLFjqhyaP1Be47coT+geUry7la3T6+jVdeKVfoj6bZn282nXvNFLNExuoSIyah1r8I=
X-Received: by 2002:a17:907:1584:b0:a23:360f:f8c4 with SMTP id
 cf4-20020a170907158400b00a23360ff8c4mr1281948ejc.41.1704703383651; Mon, 08
 Jan 2024 00:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231219-49026ec51e53dffb0c4d4e20@thorsis.com>
 <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
 <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
 <CAD8XO3aXShwQGKzqqYO9GAoAV2SbQFx0Fys3G_ZonTQCWQCAJg@mail.gmail.com>
 <CAOMZO5DiJtMAePwZd-adxscDTZ5dSGoZiwLK-vH-7Yz8nyPfog@mail.gmail.com>
In-Reply-To: <CAOMZO5DiJtMAePwZd-adxscDTZ5dSGoZiwLK-vH-7Yz8nyPfog@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 8 Jan 2024 14:41:14 +0600
Message-ID: <CAD8XO3aeQDqfbzCTFVuP6VY5S1RXQaLxoayM4-NBaLi_2JktNA@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 5 Jan 2024 at 02:46, Fabio Estevam <festevam@gmail.com> wrote:

> On Thu, Jan 4, 2024 at 12:02=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
.org>
> wrote:
>
> > CI tests this in all qemu emulated boards. I tested it locally on
> Raspberry Pi - works well. This version did not
> > yet tested on imx8, but the previous version worked on eth0, did not
> work on eth1.  So I plan to continue testing
> > these patches on different boards. But in general it's the upper layer
> then drivers and theoretically has to work on any
> > board. But in fact different boards work in different ways and behaviou=
r
> is different with their qemu model. So I'm a little bit confused
> > how to test and debug these patches on board which I don't have physica=
l
> access...
>
> Can you try to get access to any i.MX board via Linaro?
>


I will try, but for some reason there is no i.MX board in the lab.


>
> > that is really strange, after reboot you should get the initial stage.
> > You can type 'lwip list' and 'net list' to check if there is an IP
> address for
> > active device set.
>
> Nothing strange there:
>
> u-boot=3D> lwip list
> 1:  eth0 UP IP: 192.168.0.122/255.255.255.0, GW: 192.168.0.1,
> 00:04:9f:06:33:d3
> done.
> u-boot=3D> net list
> eth0 : ethernet@30be0000 00:04:9f:06:12:98 active
>

MAC address is different in two commands, it has to be the same.

BR,
Maxim.
