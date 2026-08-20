Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE1C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B9CA80C7B;
	Thu, 20 Aug 2026 13:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPNvqpjuMS3y; Thu, 20 Aug 2026 13:07:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231227;
	bh=GsKWhyhiuvzGlWyXiRh3Q/6PlC8+9mdYDoX3cn9nCng=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yAJN5WT820duoqWfdRDBjoaWmFySKMpG2Mc02GLR9xrK0gKJoCDsqrWkHrA0GCvEs
	 WKEO3H7VOfMWB1OU5emoXxWqR+F3HgCtEgy55eG876qhGJ4+FfHn0argPeetqQIaMp
	 xga75o4Hg4a/xAK//0AF5oUMD6llS7MG7DAYiS3OIatDcQNXlL1IIpy+Od/sYLRV9z
	 OWf2SVQVmEexzTyBmMmuzAwM+I4BxLpyHLL4o98DPv4BXYvB3aaUC/m8fHlDJDwaP4
	 Kzw77AhG2BGKqfdnRBamCuYowPJ5qS4G3PjzrcBLBP4wfBOrSvvRmsxIz8TdHIzAIb
	 +Txrj4OEKqj0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2174780C9D;
	Thu, 20 Aug 2026 13:07:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02F8139E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD12C402BB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLiBVq3eKW56 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:48:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bxcE5rvT
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5A8A402A8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:48:38 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-74dce749cc5so526615137.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787230117; cv=none;
 d=google.com; s=arc-20260327;
 b=spFYPRmqg/lw/mTR21qkzq9Ujm6H8fpj1TVddIIMYFtHh+U6Wk2ZATLQB7s3RtMmJH
 IzV8EU7Y5Rs+O1IGgneceqYpRySv8TSdOEheq9hefkxWAkD2tABBUZ4sjHuQ4k2ZOpWW
 U7BAkIH5+jj0tROvD5JxstPIk7de9Jrxf8UefKi87ieEQNmU7A5w7ClmvfEODtimvh9R
 cf5y/kFwPR3gBv07e3/Q/2jqY23AX/KAFHd9bQ9meBZo85RDrbEa38AAJkeO83FwGk0Z
 0pE2Le5IuL5t5Wx4LNWFSG1/49Vd6PPOX4Or9cG21wexnsjc2uEpJ1J7HLPOozwqtSEg
 e5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=GsKWhyhiuvzGlWyXiRh3Q/6PlC8+9mdYDoX3cn9nCng=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=eX1+Zc7ZTNYM8yh3/+EgwZac6LI+SwauZSXvmrPvqom8qcAIK6AqwHy2857iQxm0lF
 0h46OBmjcCzjppFGdlbhQzQPobcMOXhqu9SDpFlbHg8HMcADW7dwGu72vkj/pWGFW3tB
 3yW+qrhGlWDt8E7OV4lU6wepxMoTp8Vj6S2RxCtYXkOau34dLHuScU/2PA1AyWrks5al
 mDiSv8jPcznvbqUSjbxxpDDsuWj3a41VEdeHW8UruXx4aPHfOt6PqtdeWBt2k39h4kJ9
 +jlK5vOKYm1vKurUGRAA3grBa+LexZZ/DMwNmcGkpcodAw8K6TWAEGJr+eNggiUr8txq
 X6iQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230117; x=1787834917;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GsKWhyhiuvzGlWyXiRh3Q/6PlC8+9mdYDoX3cn9nCng=;
 b=bxcE5rvTtkjCFfCqSyUH/bNhssV81YruStS9SXpJcFOQGS4FWsLPq5MS0+ITLbcPCM
 13sAQelDHM3TqCb1zBLChN0C699TUrtZ1tg5g8F0pQyrE0j5sHAZgtOYHRQpVQRZfM7t
 PguP7SxGBCFr6dpsDRXqj+n8hyidsYNtxjg/NfIdqYGWaBEBB6GGRIwU5I9K+itAT+tQ
 rnluyB9P6CDSIlLFIO8yR3nxkbr8gxpk6ZkPx4VFf3Q5BgUiakKsBlQ8JFdJ+LFqKq/X
 Mg66bcaYh7QTNnTz0NdEx3lNLUeM6GoRH1n9pkFHLZ8sVHNww/oaxikvFC28IbdOr0I8
 +dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230117; x=1787834917;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GsKWhyhiuvzGlWyXiRh3Q/6PlC8+9mdYDoX3cn9nCng=;
 b=das5PaeiQ1RNMOXlwuNjnojmNhzg9msmMCsqMtyB+0c+Xvf1TIl1pPxtajYiIfzJ4S
 xEvS6FZpc/G6l3Mdxyk5NnmsebKDoRfNggpykL0mie1vPupodlqBt1+Iq2bX7FEGi9DW
 bsFPc3xFaE4zJeutRZ6+CNkilTfuonRtZp8GiM5ZTM3Q2O0BBTI3mbqT8yfUuCzq4O1L
 /DvUkxkNIaoMqm2Tr+yPfp4Tr7Ywy0ZRnw4wpvlABoqhyb19KbZOMTYcHEc8hNEqjOm3
 RDldQmPD7S/VQHuUtVdVkVDLhiXOaXyfhxigLEVTKlYke07zucEYnNAbnxNmaUKM8Xkq
 NP1A==
X-Gm-Message-State: AOJu0YwjI8wf3CQczh1uHitLX4V/CA7o5syb9QTAP8CaAr9wJ7MRuIMZ
 QhVuJ05EHSSNK9qbsqwOfmK4XvtuJLiYQzpi60og1XMEb5y7sEKACYG6OJ2xH74HoDdGz8u5DJm
 gswDmTaFFC6mi5iNcHxG1UNjr6Hdy/F7vRtYtSos=
X-Gm-Gg: AR+sD12xlgljHZ3aoXCRvwBVHeKjQHZqbkdIdt8Qy3i0wzuHbkb2YGr42zWdvaCiocI
 fuzQXQjM/eCSVvrbbuOmXhULdk9NAqvsXTp5hc422QHWNqEuAyfTb2nW8a0MRSmqxUgsuWNGaUU
 qua0wDfSuxqMYsQeiZ0cRB6TardsITnhDEr/uEll46/SW1zLdjyMYGtFwPnNR+mb1TvT5YcPZNZ
 4l9pxHpxC5D6qvhg7gxIxOaP+l0rj0eDkgP9sS/6lNzbzsWiZlooICnq6SJFggbMISVOcdkp4DN
 mphJFLLGErfrug5RZK8AK2nYMNn6QzK3ysahE/0XaEA9g50mpQxAkqsgX9fxH0RtYpJYaKqq8rc
 2Vzzv9/Mu9t7yg0eRYaEkKtwNoBAk
X-Received: by 2002:a05:6102:1499:b0:778:9b9f:f434 with SMTP id
 ada2fe7eead31-7789b9ff98bmr3615147137.11.1787230117046; Thu, 20 Aug 2026
 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260815220817.11754-1-pranavkasthuri@gmail.com>
 <20260820123315.9272-1-pranavkasthuri@gmail.com>
 <20260820123315.9272-3-pranavkasthuri@gmail.com>
In-Reply-To: <20260820123315.9272-3-pranavkasthuri@gmail.com>
From: Pranav R <pranavkasthuri@gmail.com>
Date: Thu, 20 Aug 2026 13:48:25 +0100
X-Gm-Features: AcwNN1UM3aAgEB8xQmYYOrN_rMUFqstbFVItnJngCbilLwpjcfcFxXWtB7Yu4Xw
Message-ID: <CANMPf=NLDUV=8o8e47kkYozRuVoJoROJU6hTC4GeO7c67uAfmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: bootp: bound DHCP option parsing by the
 received packet length
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000422eeb065979f0ff"
X-Mailman-Approved-At: Thu, 20 Aug 2026 13:07:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--000000000000422eeb065979f0ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

Good catch =E2=80=94 you're right, the outer bound alone doesn't cover it.
dhcp_process_options() trusted `popt < end` to mean the whole option
(code + length + payload) was safe, but that only guarantees the code
byte is readable. oplen =3D *(popt + 1) and the payload dereferences in
the switch had no bound check of their own, so a packet truncated
right after an option code byte, or with a declared length that
overruns the buffer, still walked off the end even with the outer fix
applied.

Sent as v2 with a prerequisite patch (1/2) that fixes this: the pad
option is now handled before touching a second byte, a length byte is
required to exist before it's read, and the full declared option
(header + payload) is required to fit before the switch runs on it =E2=80=
=94
otherwise parsing stops instead of reading past the buffer. Your
original outer-bound fix is 2/2, unchanged, rebased on top.

Both commits are checkpatch --strict clean and build warning-free at
W=3D1; a full sandbox build also passes.

Thanks,
Pranav

On Thu, Aug 20, 2026 at 1:33=E2=80=AFPM Pranav Rajendran <pranavkasthuri@gm=
ail.com>
wrote:

> dhcp_packet_process_options() derives the end of the option area from
> BOOTP_HDR_SIZE, a compile-time constant, rather than from the length of
> the packet that was actually received:
>
>         uchar *popt =3D (uchar *)&bp->bp_vend[4];
>         uchar *end =3D popt + BOOTP_HDR_SIZE;
>
> Since popt already starts near the end of the header, 'end' lands
> sizeof(struct bootp_hdr) bytes beyond it, so a short reply leaves
> dhcp_process_options() walking off the end of the received data and
> into whatever the receive buffer held before - typically the remains of
> earlier packets.
>
> That is not only a disclosure: the options found there are acted on
> like any others, so stale bytes that happen to parse as an option can
> influence the boot file name, the DNS server or the root path.
>
> The BOOTP path already gets this right and passes the real length to
> bootp_process_vendor(), and both callers here have the length in scope
> - they hand it to dhcp_message_type() on the lines above. Pass it in
> and use it as the limit. The overloaded 'file' and 'sname' areas are
> clamped the same way, as a truncated packet need not contain them
> either.
>
> Fixes: 774c3e05ec0a ("net: parse DHCP options from overloaded file/sname
> fields")
> Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
> ---
> v2: No change, rebased on top of the new patch 1/2 which fixes the
>     inner option-length validation gap Jerome raised against v1.
>
>  net/bootp.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/net/bootp.c b/net/bootp.c
> index eafbe9e3bb4..06083092875 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -977,32 +977,43 @@ static void dhcp_process_options(uchar *popt, uchar
> *end)
>         }
>  }
>
> -static void dhcp_packet_process_options(struct bootp_hdr *bp)
> +static void dhcp_packet_process_options(struct bootp_hdr *bp, unsigned
> int len)
>  {
> -       uchar *popt =3D (uchar *)&bp->bp_vend[4];
> -       uchar *end =3D popt + BOOTP_HDR_SIZE;
> +       uchar *pkt_end =3D (uchar *)bp + len;
> +       uchar *popt, *end;
> +
> +       if (len < offsetof(struct bootp_hdr, bp_vend) + 4)
> +               return;
>
>         if (net_read_u32((u32 *)&bp->bp_vend[0]) !=3D
> htonl(BOOTP_VENDOR_MAGIC))
>                 return;
>
> +       popt =3D (uchar *)&bp->bp_vend[4];
> +
>         dhcp_option_overload =3D 0;
>
>         /*
>          * The 'options' field MUST be interpreted first, 'file' next,
>          * 'sname' last.
>          */
> -       dhcp_process_options(popt, end);
> +       dhcp_process_options(popt, pkt_end);
>
>         if (dhcp_option_overload & OVERLOAD_FILE) {
>                 popt =3D (uchar *)bp->bp_file;
>                 end =3D popt + sizeof(bp->bp_file);
> -               dhcp_process_options(popt, end);
> +               if (end > pkt_end)
> +                       end =3D pkt_end;
> +               if (popt < end)
> +                       dhcp_process_options(popt, end);
>         }
>
>         if (dhcp_option_overload & OVERLOAD_SNAME) {
>                 popt =3D (uchar *)bp->bp_sname;
>                 end =3D popt + sizeof(bp->bp_sname);
> -               dhcp_process_options(popt, end);
> +               if (end > pkt_end)
> +                       end =3D pkt_end;
> +               if (popt < end)
> +                       dhcp_process_options(popt, end);
>         }
>  }
>
> @@ -1133,7 +1144,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest,
> struct in_addr sip,
>                                 debug("got BOOTP response; transitioning
> to BOUND\n");
>                                 goto dhcp_got_bootp;
>                         }
> -                       dhcp_packet_process_options(bp);
> +                       dhcp_packet_process_options(bp, len);
>                         if (CONFIG_IS_ENABLED(EFI_LOADER) &&
>                             IS_ENABLED(CONFIG_NETDEVICES))
>                                 efi_net_set_dhcp_ack(pkt, len);
> @@ -1160,7 +1171,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest,
> struct in_addr sip,
>
>                 if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len)
> =3D=3D DHCP_ACK) {
>  dhcp_got_bootp:
> -                       dhcp_packet_process_options(bp);
> +                       dhcp_packet_process_options(bp, len);
>                         /* Store net params from reply */
>                         store_net_params(bp);
>                         dhcp_state =3D BOUND;
> --
> 2.50.1 (Apple Git-155)
>
>

--000000000000422eeb065979f0ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hi Jerome,<br><br>Good catch =E2=80=94 you&#39;re righ=
t, the outer bound alone doesn&#39;t cover it.<br>dhcp_process_options() tr=
usted `popt &lt; end` to mean the whole option<br>(code + length + payload)=
 was safe, but that only guarantees the code<br>byte is readable. oplen =3D=
 *(popt + 1) and the payload dereferences in<br>the switch had no bound che=
ck of their own, so a packet truncated<br>right after an option code byte, =
or with a declared length that<br>overruns the buffer, still walked off the=
 end even with the outer fix<br>applied.<br><br>Sent as v2 with a prerequis=
ite patch (1/2) that fixes this: the pad<br>option is now handled before to=
uching a second byte, a length byte is<br>required to exist before it&#39;s=
 read, and the full declared option<br>(header + payload) is required to fi=
t before the switch runs on it =E2=80=94<br>otherwise parsing stops instead=
 of reading past the buffer. Your<br>original outer-bound fix is 2/2, uncha=
nged, rebased on top.<br><br>Both commits are checkpatch --strict clean and=
 build warning-free at<br>W=3D1; a full sandbox build also passes.<br><br>T=
hanks,<br>Pranav<br></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 20, 2026 at 1:33=E2=
=80=AFPM Pranav Rajendran &lt;<a href=3D"mailto:pranavkasthuri@gmail.com">p=
ranavkasthuri@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">dhcp_packet_process_options() derives the end of the=
 option area from<br>
BOOTP_HDR_SIZE, a compile-time constant, rather than from the length of<br>
the packet that was actually received:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uchar *popt =3D (uchar *)&amp;bp-&gt;bp_vend[4]=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uchar *end =3D popt + BOOTP_HDR_SIZE;<br>
<br>
Since popt already starts near the end of the header, &#39;end&#39; lands<b=
r>
sizeof(struct bootp_hdr) bytes beyond it, so a short reply leaves<br>
dhcp_process_options() walking off the end of the received data and<br>
into whatever the receive buffer held before - typically the remains of<br>
earlier packets.<br>
<br>
That is not only a disclosure: the options found there are acted on<br>
like any others, so stale bytes that happen to parse as an option can<br>
influence the boot file name, the DNS server or the root path.<br>
<br>
The BOOTP path already gets this right and passes the real length to<br>
bootp_process_vendor(), and both callers here have the length in scope<br>
- they hand it to dhcp_message_type() on the lines above. Pass it in<br>
and use it as the limit. The overloaded &#39;file&#39; and &#39;sname&#39; =
areas are<br>
clamped the same way, as a truncated packet need not contain them<br>
either.<br>
<br>
Fixes: 774c3e05ec0a (&quot;net: parse DHCP options from overloaded file/sna=
me fields&quot;)<br>
Signed-off-by: Pranav Rajendran &lt;<a href=3D"mailto:pranavkasthuri@gmail.=
com" target=3D"_blank">pranavkasthuri@gmail.com</a>&gt;<br>
---<br>
v2: No change, rebased on top of the new patch 1/2 which fixes the<br>
=C2=A0 =C2=A0 inner option-length validation gap Jerome raised against v1.<=
br>
<br>
=C2=A0net/bootp.c | 27 +++++++++++++++++++--------<br>
=C2=A01 file changed, 19 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/net/bootp.c b/net/bootp.c<br>
index eafbe9e3bb4..06083092875 100644<br>
--- a/net/bootp.c<br>
+++ b/net/bootp.c<br>
@@ -977,32 +977,43 @@ static void dhcp_process_options(uchar *popt, uchar *=
end)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-static void dhcp_packet_process_options(struct bootp_hdr *bp)<br>
+static void dhcp_packet_process_options(struct bootp_hdr *bp, unsigned int=
 len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uchar *popt =3D (uchar *)&amp;bp-&gt;bp_vend[4]=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uchar *end =3D popt + BOOTP_HDR_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uchar *pkt_end =3D (uchar *)bp + len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uchar *popt, *end;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &lt; offsetof(struct bootp_hdr, bp_vend=
) + 4)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (net_read_u32((u32 *)&amp;bp-&gt;bp_vend[0])=
 !=3D htonl(BOOTP_VENDOR_MAGIC))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0popt =3D (uchar *)&amp;bp-&gt;bp_vend[4];<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dhcp_option_overload =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The &#39;options&#39; field MUST be int=
erpreted first, &#39;file&#39; next,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &#39;sname&#39; last.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_process_options(popt, end);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_process_options(popt, pkt_end);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dhcp_option_overload &amp; OVERLOAD_FILE) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 popt =3D (uchar *)b=
p-&gt;bp_file;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D popt + size=
of(bp-&gt;bp_file);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_process_option=
s(popt, end);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end &gt; pkt_en=
d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0end =3D pkt_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (popt &lt; end)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_process_options(popt, end);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dhcp_option_overload &amp; OVERLOAD_SNAME) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 popt =3D (uchar *)b=
p-&gt;bp_sname;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D popt + size=
of(bp-&gt;bp_sname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dhcp_process_option=
s(popt, end);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end &gt; pkt_en=
d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0end =3D pkt_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (popt &lt; end)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_process_options(popt, end);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
@@ -1133,7 +1144,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, s=
truct in_addr sip,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug(&quot;got BOOTP response; tran=
sitioning to BOUND\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto dhcp_got_bootp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_packet_process_options(bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_packet_process_options(bp, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (CONFIG_IS_ENABLED(EFI_LOADER) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 IS_ENABLED(CONFIG_NETDEVICES))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 efi_net_set_dhcp_ack(pkt, len);<br>
@@ -1160,7 +1171,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, s=
truct in_addr sip,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dhcp_message_ty=
pe((u8 *)bp-&gt;bp_vend, (u8 *)pkt + len) =3D=3D DHCP_ACK) {<br>
=C2=A0dhcp_got_bootp:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_packet_process_options(bp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dhcp_packet_process_options(bp, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Store net params from reply */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 store_net_params(bp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dhcp_state =3D BOUND;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div>

--000000000000422eeb065979f0ff--
