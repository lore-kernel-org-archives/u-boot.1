Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0D3CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82595830A0;
	Mon,  8 Sep 2025 18:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="McHEGo6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39683830A0; Mon,  8 Sep 2025 18:44:30 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3527B809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74382041c9eso3352945a34.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1757349866; x=1757954666; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDYlx+o9bTq3yM5q/u/yVi7vtUss6EzD5PwoYvUJX7w=;
 b=McHEGo6Sv0GUSx4QcYWahjjjbDtmDEzlV7KC7JA696DI8NfaiBLeKN74dw7dPpvfDS
 qspxPVhr2qpREg8XcVYjRnC4AaMg+excZbXzWEY0ZFYCxJ4HO9QUWBcjC9mrJDU5AXRq
 JEOuWoDou576zXK9y1IReJkjM7FvuIdwj0FmFGxKQvoba5T4eCUxpiFIwYg7P5CwS/fj
 s4Wi7Qkb/+KjvOSmUJZkaisj2IgvzYSw4VMQyceFPxwfUUkMG0y7JEVOcdG8EQWb+FeT
 mkPr5nYAtjfMX1hnXetBg6xOnIZ1EnSOCsY+1cSIK0Sn1YSnzjkjLpQz6VM28wCAG89A
 IqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757349866; x=1757954666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDYlx+o9bTq3yM5q/u/yVi7vtUss6EzD5PwoYvUJX7w=;
 b=ucdfp2+mhHokPa9u7HvnqMgfuQbdzI9fYl1SfPHJanJlXrqJrE45YHS8/YV0x2ddOx
 XoFqmuswKLy6Nj7EcTnVVp+40cMRD8h2cP9bFha7VJ++FhQZ21OT67SygU0NrCpDTArQ
 WzqnKQaxzYisQ2DeIxGF64lwqcSxfx6uftd3ePX9sHKHuxHMN4NP0paZ/z+zdBkXfMkr
 JWuEl+gqjE/AFzeoXAe/TmeMxpykAZmmue8Lffr6oxHWm3FrTqT0butaRvHk1jE7ry0Q
 7LBT4UtV/YN+Ms9qzP7AJARw8FiEpcbfpguK0qTZP/O+lDNb4hyFEURiTJ24YAMK343G
 w1Mw==
X-Gm-Message-State: AOJu0YwtzM/gdJZ5a5Qh3WFtNlJOm9K9ClmDUxIEhkr1WLaE7BgH9VPB
 yQuMi8+HoPR/Bb1fNvqeoAOoB3O3DraGz52ndcWQCe3hSk2ljAM+ePAoOScMtPyeoApEgGZemPo
 wpCBtt7mTBlg7BikUX9Wx7wKo9WBku33nXtrP4VNbxAE2XsXJYJNUKBo=
X-Gm-Gg: ASbGnct0yiWiySQpL0mkcsQ3aHyPj0d9CPHSdNec7zJcriWIUk1om0XcIcdzpiH9I8C
 QdTaumQTQzeAKzNuJTUNX80xkpnCKW0ibHwOBvB7XsOk6Ie/M8MXgrLqbqWYfgs8p61Fu9XqMm8
 M1YSgDXwquIE+wa6pT59ahLokpDYKt2b/t8LEl40kzYsM9NLaI9BY5lQAguj39BtM9cpx53zisf
 1EfQ8be6NfsZsvemg==
X-Google-Smtp-Source: AGHT+IEt/UKr6zY3sWQ81qx5lmk8tcU+ZV3xwi+t5PidKKVRrSF8roNMCfArAzQHBBRi/KRKR/oqEpgE4hyDUEKlNLs=
X-Received: by 2002:a05:6830:3590:b0:744:f0db:a19f with SMTP id
 46e09a7af769-74c790bac31mr4743758a34.35.1757349865881; Mon, 08 Sep 2025
 09:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
 <e0c32dde-f265-42b5-ba4d-29a3deaa7eaf@linaro.org>
In-Reply-To: <e0c32dde-f265-42b5-ba4d-29a3deaa7eaf@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 8 Sep 2025 09:44:15 -0700
X-Gm-Features: Ac12FXzbeuU-Rk5xOiDoFPedMhHhZMzYqhBlzhXrLFquKK2HOFe5UdJp12vFsE0
Message-ID: <CAJ+vNU3qmhCJhWbfoRFrSimOJpKxnRjx3sxKAUxqZ6tEX=FP5w@mail.gmail.com>
Subject: Re: LWIP buffer alignment
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>
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

On Mon, Sep 8, 2025 at 7:21=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tim,
>
> On 9/5/25 19:45, Tim Harvey wrote:
> > Hi Jerome,
> >
> > I'm working with a board that has an IMX ENETC MAC on it
> > drivers/net/fsl_enetc.c and when configured for LWIP it fails and
> > warns about RX buffers not being 64B aligned:
> > WARNING at drivers/net/fsl_enetc.c:776/enetc_setup_rx_bdr()!
> >
> > I tried changing MEM_ALIGNMENT to 64 in lib/lwip/u-boot/lwipopts.h but
> > that did not align the buffers to 64B. Where are the lwip buffers
> > created and do you have any suggestions for working around this?
>
> The LwIP RX buffers are created in net-lwip.c. See eth_init_rings().
> You might have PKTSIZE_ALIGN and/or PKTALIGN set wrongly.
>

Hi Jerome,

Thanks for pointing me to eth_init_rings(). This function uses
net_pkt_buf as the base for the net_rx_packets array which is a static
global and not aligned.

Looks like we need:
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 660ceb10cbe..aec05d55de6 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) =3D 0;
 static int net_try_count;
 static int net_restarted;
 int net_restart_wrap;
-static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
+static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
__attribute__((aligned(PKTALIGN)));
 uchar *net_rx_packets[PKTBUFSRX];
 uchar *net_rx_packet;
 const u8 net_bcast_ethaddr[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

If you agree I'll submit that. This does resolve the issue I see with
the enetc driver using LwIP.

Best Regards,

Tim
