Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619A8C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 03:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE078886A;
	Tue, 13 Aug 2024 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWv7OWVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6378C8871A; Tue, 13 Aug 2024 05:50:04 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22958886A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cb576db1c5so3339000a91.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723521000; x=1724125800; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffu0wumUKyBop5EBEVPT1Tk3VC6THlQPDw+PJoImT6Y=;
 b=lWv7OWVgJuXo++8DHpj4LVg7z0RTLrzFVjQLt2qATBVz4NOjPAVtKxhVLX2mSd8BF6
 yiVEKRmi3KyJlpsDkoMmvSJvuQE/uyK1XD6xCEEVo4N2lwPPw4yyTME0pDGFlJRO9ZE7
 IY3kdhPQ1U65ACo4SGTrAGsoCABE6dzpAenDYiPqL9MMcwmckIEvlRtsG2Jhpzhw1gl3
 lAVpXe6RKG9iO1uHdy3ZQtmKPMyokJbq4sq8dO0BLF/zHrbXtxAqL8axMxsEtDCFTe+3
 WuXxn13otSlsKXPLY8Fb9jWAXTQhTobbZf4DdNjpfLxpZJ59VFrx4tUPz2WowFKynQ7Y
 J03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723521000; x=1724125800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffu0wumUKyBop5EBEVPT1Tk3VC6THlQPDw+PJoImT6Y=;
 b=HPvmSgUiw/KEgVEhLLVd7XawekgMdVDH7pm5edvBSaKPL5/0uHXEjzGOMxSILiL+fK
 35Wt7eGLrnGaQ/7zhsFt2Q3ixOA5IDDf5ITtQcRl3gRsoanBv1k47Rg/zX21XrRpA+AT
 l6HAPKEYJHC2icc4+4hzT11Iiw7Q5Fi85nQdkYfdymc+AsCTbfhdrKIiS0fasbGtI14M
 cME9auoRngjdRXg22Hca7JkA4oEr3KY6iFpgk1WPsUFjy/Xz0R4+rF0e37sHMfdpGo1n
 kszORim7r5i8bRT/irLwILggSjU7bQfx3JMkrigYkrk7AIo9rISfSLV+kO1r8z3Fccu8
 6WOA==
X-Gm-Message-State: AOJu0YyGYtaDCJJK6VA7BL6rWHuQfNnSUbMixwROhtcsww77CvTJ3Rxa
 GucDJAsIA3baBjdnsNUtr2dN42cN+kr7SQYUzJ04h6EZl0lN/GFm3UmAmXMDfF7FChMjsIX8p0y
 0UWMxA4rPcSeG/kB08el1QGrX+yg=
X-Google-Smtp-Source: AGHT+IH6Cz6wYUJETDxNKHWlBvb9n8tRxPAJgjMkj+gUYCqDCMPItlKo7R+vH762pff9FrU9CvYRLKl08upmOWIo4Lg=
X-Received: by 2002:a17:90a:cb15:b0:2ca:8684:401a with SMTP id
 98e67ed59e1d1-2d392631b5emr2333799a91.32.1723521000356; Mon, 12 Aug 2024
 20:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
 <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
 <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
 <20240812184615.GI1626301@bill-the-cat>
In-Reply-To: <20240812184615.GI1626301@bill-the-cat>
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Date: Tue, 13 Aug 2024 12:48:00 +0900
Message-ID: <CALu9rSbXMhGkyz5qw7nbCjdP3YuDKEZFR1SpRG0CHcYeQ7-OrA@mail.gmail.com>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
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

Dear Simon and Tom,

Thank you for your details of the test and your advice.
The test has a problem that tcp_ack isn't calculated by the received data s=
ize.
sb_ack_handler() in test/cmd/wget.c, tcp_send->tcp_ack calculated by
following code:

    tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
    tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);

tcp_ack needs to be calculated by the received TCP payload size.

Also, wget command may have a problem that
HTTP response from server must be divided into more than two packets.
wget command receive packets and change internal state in
wget_handler() as follows:

1. When current_wget_state is WGET_CONNECTED,
    wget_handler() calls wget_connected().
    It receives HTTP response and moves WGET_TRANSFERRING.
2. When current_wget_state is WGET_TRANSFERRING
    and wget_tcp_state is TCP_ESTABLISHED,
    wget_handler() receives HTTP response and
    wget_loop_state sets NETLOOP_SUCCESS.
3. When current_wget_state is WGET_TRANSFERRING
    and wget_tcp_state is TCP_CLOSE_WAIT,
    call net_set_state with wget_loop_state.

If there are more than two HTTP response packets,
wget executes in the order 1 -> 2 -> 3 and terminates properly.
If there is only one HTTP response packet, wget executes in the order 1 -> =
3,
wget_loop_state remains NETLOOP_CONTINUE and wget doesn't terminate
successfully.

I wrote the patch at the end of this mail.
The wget issue is temporarily fixed on the test side.
This may need to be fixed on the wget side in the future.
In addition, I fixed the HTTP response returned at the correct timing.
If the patch is OK, I will send format-patch.

Best regards,
Yasuharu Shibata

=E2=80=94
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 356a4dcd8f..32542cdfe2 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -26,6 +26,8 @@
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)

+int net_set_ack_options(union tcp_build_pkt *b);
+
 static int sb_arp_handler(struct udevice *dev, void *packet,
                          unsigned int len)
 {
@@ -105,6 +107,10 @@ static int sb_ack_handler(struct udevice *dev,
void *packet,
        const char *payload1 =3D "HTTP/1.1 200 OK\r\n"
                "Content-Length: 30\r\n\r\n\r\n"
                "<html><body>Hi</body></html>\r\n";
+       union tcp_build_pkt *b =3D (union tcp_build_pkt *)tcp;
+       const int recv_payload_len =3D len - net_set_ack_options(b) -
IP_HDR_SIZE - ETHER_HDR_SIZE;
+       static int next_seq =3D 0;
+       const int bottom_payload_len =3D 10;

        /* Don't allow the buffer to overrun */
        if (priv->recv_packets >=3D PKTBUFSRX)
@@ -119,13 +125,31 @@ static int sb_ack_handler(struct udevice *dev,
void *packet,
        tcp_send->tcp_dst =3D tcp->tcp_src;
        data =3D (void *)tcp_send + IP_TCP_HDR_SIZE;

-       if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =3D=3D 1) {
+       if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =3D=3D 1 &&
recv_payload_len =3D=3D 0) {
+               // ignore ACK for three-way handshaking
+               return 0;
+       } else if (ntohl(tcp->tcp_seq) =3D=3D 1 && ntohl(tcp->tcp_ack) =3D=
=3D 1) {
+               // recv HTTP request message and reply top half data
                tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
-               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);
-               payload_len =3D strlen(payload1);
+               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) +
recv_payload_len);
+
+               payload_len =3D strlen(payload1) - bottom_payload_len;
                memcpy(data, payload1, payload_len);
                tcp_send->tcp_flags =3D TCP_ACK;
-       } else if (ntohl(tcp->tcp_seq) =3D=3D 2) {
+
+               next_seq =3D ntohl(tcp_send->tcp_seq) + payload_len;
+       } else if (ntohl(tcp->tcp_ack) =3D=3D next_seq) {
+               // reply bottom half data
+               const int top_payload_len =3D strlen(payload1) -
bottom_payload_len;
+
+               tcp_send->tcp_seq =3D htonl(next_seq);
+               tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) +
recv_payload_len);
+
+               payload_len =3D bottom_payload_len;
+               memcpy(data, payload1 + top_payload_len, payload_len);
+               tcp_send->tcp_flags =3D TCP_ACK;
+       } else {
+               // close connection
                tcp_send->tcp_seq =3D htonl(ntohl(tcp->tcp_ack));
                tcp_send->tcp_ack =3D htonl(ntohl(tcp->tcp_seq) + 1);
                payload_len =3D 0;
@@ -148,11 +172,9 @@ static int sb_ack_handler(struct udevice *dev,
void *packet,
                          pkt_len,
                          IPPROTO_TCP);

-       if (ntohl(tcp->tcp_seq) =3D=3D 1 || ntohl(tcp->tcp_seq) =3D=3D 2) {
-               priv->recv_packet_length[priv->recv_packets] =3D
-                       ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
-               ++priv->recv_packets;
-       }
+       priv->recv_packet_length[priv->recv_packets] =3D
+               ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
+       ++priv->recv_packets;

        return 0;


 }

On Tue, 13 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Aug 11, 2024 at 08:50:18AM -0600, Simon Glass wrote:
> > +Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> >
> > Hi Yasuharu,
> >
> > On Sat, 10 Aug 2024 at 20:48, Yasuharu Shibata
> > <yasuharu.shibata@gmail.com> wrote:
> > >
> > > Dear Simon,
> > >
> > > Could you inform me how the wget test was broken?
> > > As I explained in the commit log, I fixed the bug in specific conditi=
ons.
> > > Without the details of how the break happened,
> > > it is difficult to find a proper patch.
> > >
> > > Best regards,
> > > Yasuharu Shibata
> >
> > Yes, I should have mentioned that. It is test/cmd/wget.c - see also [1]=
.
> >
> > This is a good run:
> > Test: net_test_wget: wget.c
> > HTTP/1.1 200 OK
> > Packets received 5, Transfer Successful
> > Bytes transferred =3D 32 (20 hex)
> > md5 for 00020000 ... 0002001f =3D=3D> 234af48e94b0085060249ecb5942ab57
> > Failures: 0
> >
> > With your patch it hangs:
> >
> > Test: net_test_wget: wget.c
> > HTTP/1.1 200 OKT
>
> Can you please figure out what's going on with the sandbox test then?
> The change in question fixes wget support on real hardware, and also the
> other wget tests (as part of the lwIP series) work fine as well. This
> seems like something specific to that test.
>
> --
> Tom
