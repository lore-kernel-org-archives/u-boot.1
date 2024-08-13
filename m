Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482FFC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 15:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A953886A7;
	Tue, 13 Aug 2024 17:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K9FLhoX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4577888981; Tue, 13 Aug 2024 17:12:27 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D3B88360
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 17:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b78c980981so31599756d6.2
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723561944; x=1724166744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG9mF7KqVYGparbgorQO6PWZaxWVP+TaWAmXRbn/brg=;
 b=K9FLhoX3QRjTNpIwTXOYx3A1DgSsMOfFKV0sjoghHjmgv7tDOAM/D5fj8Tx8KOzwhV
 1yFmhBsmqVtJxFQk7Oo2sN9rDBRPfi/Gb8PuJcLngYS/Y132DdFalTD4mPvgesS407Vp
 UDsZlEb8AJ2UX0W3xUd7YaQ4d4lzFcp0m2M3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723561944; x=1724166744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG9mF7KqVYGparbgorQO6PWZaxWVP+TaWAmXRbn/brg=;
 b=DXZOAU/5JpLftF/TBPWmXZxTrG5lgpCXxcuqS/S9APzGPNZkvF06OvPx6dlFJQbQQg
 9oPxOWdbn9BpBtTxSDX1B6WCz7NRxognWGjNfsV8euT6JlnkA+nmyW/D0P5HqsxJPYvJ
 SuX8Lkweb+zMKmAVKISLlfRkQpAe+DSjb4nnewIrZIlYZMI5AHcUjFnZGcqnEGDB77Fm
 G5v0IDDCMFeC1NXgmjLGDoWKsbdaABL7mjw4nOJtI6AykSeEd19OT/MDnhrBi9c382rk
 M7+8hwzUG+I4UqJDWIp5BeJS93NLwyaCISBMifd44Jnf2MlomdeKLofwM5xSv/IuLkJ8
 2TgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6u+KvTqjnypu3+CinIPIo44MCoqAXce5EDHgn5iX3YE4opfWLidmw5dHdeg6D6VcZPjkup2bq/7rwvPlb6dHLPsRfmw==
X-Gm-Message-State: AOJu0Yzk9YJv7XKCn89QGunCEE1BlloEGufAFkLFKY7TuWYSTohpLLqw
 jkPOv3aXp7dlBp7dVXbW83Ptg9Z1gzVw4ymsh5vFekPw2YMKxi2icIScZoGkndX4Jaikc3IfzIi
 Y3kA7ZliUY8EXPGq9sTV20P7tzeBkf3w6oYMF
X-Google-Smtp-Source: AGHT+IGijX+mMBZPcfy2oFcuWXFp9OeSs9m/CuNGKeZd4zui7VJiC9TUS8nRZFm3HfjCYwT/ky8DvlTGSWE40rmvkvs=
X-Received: by 2002:a05:6214:5d8f:b0:6b7:9c28:4cc9 with SMTP id
 6a1803df08f44-6bf4f884dc5mr44329056d6.51.1723561943709; Tue, 13 Aug 2024
 08:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
 <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
 <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
 <20240812184615.GI1626301@bill-the-cat>
 <CALu9rSbXMhGkyz5qw7nbCjdP3YuDKEZFR1SpRG0CHcYeQ7-OrA@mail.gmail.com>
 <CAFLszTj0GtiXq6m8Y+SQzH8zhkyp72oU0UMrt5o3RFAhWpMa6Q@mail.gmail.com>
In-Reply-To: <CAFLszTj0GtiXq6m8Y+SQzH8zhkyp72oU0UMrt5o3RFAhWpMa6Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 09:12:12 -0600
Message-ID: <CAFLszTiSS09fzS_SEwQap+0xO2Ls7+9c9udCWCmg6jkacWQrAw@mail.gmail.com>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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


On Tue, 13 Aug 2024 at 06:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Yasuharu,
>
> On Mon, 12 Aug 2024 at 21:50, Yasuharu Shibata
> <yasuharu.shibata@gmail.com> wrote:
> >
> > Dear Simon and Tom,
> >
> > Thank you for your details of the test and your advice.
> > The test has a problem that tcp_ack isn't calculated by the received da=
ta size.
> > sb_ack_handler() in test/cmd/wget.c, tcp_send->tcp_ack calculated by
> > following code:
> >
> >     tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
> >     tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);
> >
> > tcp_ack needs to be calculated by the received TCP payload size.
> >
> > Also, wget command may have a problem that
> > HTTP response from server must be divided into more than two packets.
> > wget command receive packets and change internal state in
> > wget_handler() as follows:
> >
> > 1. When current_wget_state is WGET_CONNECTED,
> >     wget_handler() calls wget_connected().
> >     It receives HTTP response and moves WGET_TRANSFERRING.
> > 2. When current_wget_state is WGET_TRANSFERRING
> >     and wget_tcp_state is TCP_ESTABLISHED,
> >     wget_handler() receives HTTP response and
> >     wget_loop_state sets NETLOOP_SUCCESS.
> > 3. When current_wget_state is WGET_TRANSFERRING
> >     and wget_tcp_state is TCP_CLOSE_WAIT,
> >     call net_set_state with wget_loop_state.
> >
> > If there are more than two HTTP response packets,
> > wget executes in the order 1 -> 2 -> 3 and terminates properly.
> > If there is only one HTTP response packet, wget executes in the order 1=
 -> 3,
> > wget_loop_state remains NETLOOP_CONTINUE and wget doesn't terminate
> > successfully.
> >
> > I wrote the patch at the end of this mail.
> > The wget issue is temporarily fixed on the test side.
> > This may need to be fixed on the wget side in the future.
> > In addition, I fixed the HTTP response returned at the correct timing.
> > If the patch is OK, I will send format-patch.
>
> Thank you for looking at this and for all the info. Yes, the patch
> looks good to me.

Also, would you mind adding a patch to enable the command for sandbox,
so the test runs in CI?

Thanks,
Simon

>
> Regards,
> Simon
>
> >
> > Best regards,
> > Yasuharu Shibata
> >
> > =E2=80=94
> > diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> > index 356a4dcd8f..32542cdfe2 100644
> > --- a/test/cmd/wget.c
> > +++ b/test/cmd/wget.c
> > @@ -26,6 +26,8 @@
> >  #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
> >  #define LEN_B_TO_DW(x) ((x) >> 2)
> >
> > +int net_set_ack_options(union tcp_build_pkt *b);
> > +
> >  static int sb_arp_handler(struct udevice *dev, void *packet,
> >                           unsigned int len)
> >  {
> > @@ -105,6 +107,10 @@ static int sb_ack_handler(struct udevice *dev,
> > void *packet,
> >         const char *payload1 =3D "HTTP/1.1 200 OK\r\n"
> >                 "Content-Length: 30\r\n\r\n\r\n"
> >                 "<html><body>Hi</body></html>\r\n";
> > +       union tcp_build_pkt *b =3D (union tcp_build_pkt *)tcp;
> > +       const int recv_payload_len =3D len - net_set_ack_options(b) -
> > IP_HDR_SIZE - ETHER_HDR_SIZE;
> > +       static int next_seq =3D 0;
> > +       const int bottom_payload_len =3D 10;
> >
> >         /* Don't allow the buffer to overrun */
> >         if (priv->recv_packets >=3D PKTBUFSRX)
> > @@ -119,13 +125,31 @@ static int sb_ack_handler(struct udevice *dev,
> > void *packet,
> >         tcp_send->tcp_dst =3D tcp->tcp_src;
> >         data =3D (void *)tcp_send + IP_TCP_HDR_SIZE;
> >
> > -       if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =3D=3D =
1) {
> > +       if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =3D=3D =
1 &&
> > recv_payload_len =3D=3D 0) {
> > +               // ignore ACK for three-way handshaking
> > +               return 0;
> > +       } else if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =
=3D=3D 1) {
> > +               // recv HTTP request message and reply top half data
> >                 tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
> > -               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);
> > -               payload_len =3D strlen(payload1);
> > +               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) +
> > recv_payload_len);
> > +
> > +               payload_len =3D strlen(payload1) - bottom_payload_len;
> >                 memcpy(data, payload1, payload_len);
> >                 tcp_send->tcp_flags =3D TCP_ACK;
> > -       } else if (ntohl(tcp->tcp_seq) =3D=3D 2) {
> > +
> > +               next_seq =3D ntohl(tcp_send->tcp_seq) + payload_len;
> > +       } else if (ntohl(tcp->tcp_ack) =3D=3D next_seq) {
> > +               // reply bottom half data
> > +               const int top_payload_len =3D strlen(payload1) -
> > bottom_payload_len;
> > +
> > +               tcp_send->tcp_seq =3D htonl(next_seq);
> > +               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) +
> > recv_payload_len);
> > +
> > +               payload_len =3D bottom_payload_len;
> > +               memcpy(data, payload1 + top_payload_len, payload_len);
> > +               tcp_send->tcp_flags =3D TCP_ACK;
> > +       } else {
> > +               // close connection
> >                 tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
> >                 tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);
> >                 payload_len =3D 0;
> > @@ -148,11 +172,9 @@ static int sb_ack_handler(struct udevice *dev,
> > void *packet,
> >                           pkt_len,
> >                           IPPROTO_TCP);
> >
> > -       if (ntohl(tcp->tcp_seq) =3D=3D 1 || ntohl(tcp->tcp_seq) =3D=3D =
2) {
> > -               priv->recv_packet_length[priv->recv_packets] =3D
> > -                       ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
> > -               ++priv->recv_packets;
> > -       }
> > +       priv->recv_packet_length[priv->recv_packets] =3D
> > +               ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
> > +       ++priv->recv_packets;
> >
> >         return 0;
> >
> >
> >  }
> >
> > On Tue, 13 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Aug 11, 2024 at 08:50:18AM -0600, Simon Glass wrote:
> > > > +Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > > >
> > > > Hi Yasuharu,
> > > >
> > > > On Sat, 10 Aug 2024 at 20:48, Yasuharu Shibata
> > > > <yasuharu.shibata@gmail.com> wrote:
> > > > >
> > > > > Dear Simon,
> > > > >
> > > > > Could you inform me how the wget test was broken?
> > > > > As I explained in the commit log, I fixed the bug in specific con=
ditions.
> > > > > Without the details of how the break happened,
> > > > > it is difficult to find a proper patch.
> > > > >
> > > > > Best regards,
> > > > > Yasuharu Shibata
> > > >
> > > > Yes, I should have mentioned that. It is test/cmd/wget.c - see also=
 [1].
> > > >
> > > > This is a good run:
> > > > Test: net_test_wget: wget.c
> > > > HTTP/1.1 200 OK
> > > > Packets received 5, Transfer Successful
> > > > Bytes transferred =3D 32 (20 hex)
> > > > md5 for 00020000 ... 0002001f =3D=3D> 234af48e94b0085060249ecb5942a=
b57
> > > > Failures: 0
> > > >
> > > > With your patch it hangs:
> > > >
> > > > Test: net_test_wget: wget.c
> > > > HTTP/1.1 200 OKT
> > >
> > > Can you please figure out what's going on with the sandbox test then?
> > > The change in question fixes wget support on real hardware, and also =
the
> > > other wget tests (as part of the lwIP series) work fine as well. This
> > > seems like something specific to that test.
> > >
> > > --
> > > Tom
