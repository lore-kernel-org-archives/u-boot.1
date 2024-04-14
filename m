Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF7DC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 19:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917E387F41;
	Sun, 14 Apr 2024 21:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liOCWL/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8094288124; Sun, 14 Apr 2024 21:05:03 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CAD87EF4
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a2f2cd61cdso944959a91.1
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713121495; x=1713726295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBIRMqK40SXMsYQOBgRKNYyKP0ssr+GhPNXiM8xSwjY=;
 b=liOCWL/yJ8noVrhT4UaioW7q14G8CTiCWeKSsigSiS6aLW21PrRXCQdVBd0AcAVsmr
 PikaCxCIy3VIi+aR8T6swpKq9GgCPok0yuC88jvRrMfcaZRJ1CeQuuCFy8W8MjNvYm/w
 ljmbbOAgctJeYrLWI4nw4cvOmh8l/eQYIOAj4A0x9wwNzkUVJzkU5aRLsiXU1CgKTl7p
 a10r+YLju7nmQxx+5GPrPj43y8OS4fLS6z9yfQB6WOuCy1Y2LpVoUSGFLOj3f4TrSymz
 E4umYsBnRDt6sBj0psoPQGedil+zBw1GnJA8SsuozSs0b8gOmLcgn/fmbRxPuBC2/7sM
 2V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713121495; x=1713726295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBIRMqK40SXMsYQOBgRKNYyKP0ssr+GhPNXiM8xSwjY=;
 b=KZvNK2OQouyN603meeBlOqy2SLZokbkp5fqjiGnVZgP/h5DwndpIfUFKPp68wM8UWt
 Cj55I5J3dVeVlvp+XoqSSvEaUrOm0oj4v7LTMv8dOqEW0FhLSncbmEmPtxUUy9mw1qeb
 7M9PlS6v5NfXvrWdwV1JkmI72HfJ8c7TIKx73bLjs67yF5oNlVPT+DZ9UtJsGpcoKgQR
 a7ZZG7eBbNUhKEuO7sSN9kjtARJ8a5jyfBmU6mX4aX9d80Ws9jU3FJnQgogadv5Zs4oc
 VP/AWdTRqouFvVNcTucU6muxdzdq9GlvahxE8DBc6JToDevCyvp3TGlMjkuU8Qhb+OB3
 RKNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz+FhN7dD6zlW969JkOmjCuQaFeIM4qs2SNtrgcUPkzUeENN2WSs5aRlrgl0dF21y9WeF0MAsVCtRA02krfyvB62TzNg==
X-Gm-Message-State: AOJu0YwsaZZtpM/n2XKkUPk778K3rgcl72c3n4tuacGAaCWhGgZnQQ7D
 Sp0ZYSLaMaM9EOBdiWjboAgV0yJPm+ajW0MEKNHdj1P8vOn84YG9JhOEHwcz6Kqr7yLvZhg+hMi
 2X0E2AAOmO26mjqqQ4XN9AZFWiG8=
X-Google-Smtp-Source: AGHT+IGG6LiHy35lgxySPnCVFFxcTWPl1s+NZRiLIBLBpbLw89Xg9eXEekib1JBEKu2XSCO59dTeng2McDJtKtCK4Rs=
X-Received: by 2002:a17:90a:db0f:b0:2a6:8e66:d585 with SMTP id
 g15-20020a17090adb0f00b002a68e66d585mr7380511pjv.4.1713121494969; Sun, 14 Apr
 2024 12:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
In-Reply-To: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 14 Apr 2024 16:04:43 -0300
Message-ID: <CAOMZO5C2YGDokPoc_8Gr+5prMWfQS7xh8KWRrhjj7BpCVthADQ@mail.gmail.com>
Subject: Re: [PATCH] net: wget: Support retransmission a dropped packet
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Yasuharu,

On Sun, Apr 14, 2024 at 9:46=E2=80=AFAM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> The server sends multiple packets without waiting for an ACK
> by window control and if some packets are dropped,
> wget will return an ACK including the dropped packets.
>
> Following log indicates this issue.
>
>   wget_handler() wget: Transferring, seq=3D97bbdd4a, ack=3D30,len=3D580
>   wget_handler() wget: Transferring, seq=3D97bbedca, ack=3D30,len=3D580
>
> First packet of TCP sequence number is 0x97bbdd4a.
> Second packet of TCP sequence number should be 0x97bbe2ca,
> however it is 0x97bbedca and returns its ACK, so the server
> suppose that 0x97bbe2ca and 0x97bbedca are received appropriately.
> In this case, 0x97bbe2ca was lost and the data of wget was broken.
>
> In this patch, next_data_seq_num holds the next expected
> TCP sequence number.
> If the TCP sequence number different from next_data_seq_num,
> trying to retransmit the packet.

Thanks for your patch.

I tested it in the hope that it would fix the following issue:
https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf=
1CNaZBw@mail.gmail.com/

but I still get wget corruption when loading large files multiple
times in a row.

Would you happen to have any suggestions?

Thanks
