Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32389C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C8D9405C8;
	Tue, 25 Aug 2026 19:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWAHvUTXp1hp; Tue, 25 Aug 2026 19:08:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684905;
	bh=RHhXfom/PVt8sn5EwtuOxaxvdjL2LlMD1vwZ+ooKzhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zd2sv48jbi33+WnhSas5FaT+MxBFPXyCgvDe6d3uBPLUukL5XDC/cTkVBp6wwRlqe
	 fR+UwxPHMjYpdkdaVB+bW/aSb5GpuFsHRj7+xYYuZ1mkLDmJGa7E35QiD19oeCEbvX
	 h4rkxm8uWyTilb9JtDIu5/tZ7OMq0H9bfoY4sBUPu8lPi6mNqbOU7JoL8r6uwCBbsR
	 +3D4RscReS65bgWFjJKs8JfvLy4D0d9a+glCfgLckfg4nR5aRZewMrSeo+hDQATjSJ
	 H8Z1rVV1TQrjXBP1vzrimnNwgAsD6YL802/7yvaz/NzHMkgkUOf4iP2+JLoJWLChdK
	 NyZRiBtsgydFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BE0F40569;
	Tue, 25 Aug 2026 19:08:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EC0639E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C95180C36
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7HMZZULpIzI for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:58:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=yuxiaozhang@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=dYDztohf
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3029E80C25
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:58:19 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so1874425ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787680699; cv=none;
 d=google.com; s=arc-20260327;
 b=CP4g7Gq74dd9mvcgLyPJTrP8/XrJJv+96tS7oCUjeEGQdvA58VnTGS4mGVe95Q7Opq
 EbLTycKodUoikxmjg7d3Gf1lEUN8aKFfvL5wAitZDmCb1XXp71p+EZ8GqqpFe6Uc6eKS
 LNDQr3VVNRMd2G8K48o6czJEBx/avp6v72+Yxy5M11Oedk5+yW3DB5+cNLjhlmxrqEC6
 c2pssiYS4cBYK3BIAy5WDdYEuSyGq5bbHMudZcuxxCNj233TAVl+wotTAo9Ql9PMCVCs
 zgPuc7m1FmlCojCSLi4f5I/bRktKwmQ3TeNDl8bfcW4+6KLc1GT/SYWm98pUCONsH2Zz
 nizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RHhXfom/PVt8sn5EwtuOxaxvdjL2LlMD1vwZ+ooKzhU=;
 fh=mnyZ2g33b+WJuknjrn8cCLJpDyhIx919UYkZVKAyZM8=;
 b=jZDg4cxe632qMGqyMqgI2GQrNouqPPteRd8IS3OCoC6RVyhebE8I3RFktabxTiQLBX
 T3COzNpJnvBkZ7y+20mMtED7jKNBwOUv1t8jBKQF/uC1n9XrOLEgtZGph6Rge8uBcpOY
 uBhSg9HWLt+v1Hu1OBelBcx+PbgjTjLOLK0lrxgCX3idUk2P2eYzmC7SzKXBEzuNYFCd
 t30FnlawFtqykLMY9AYM6KG3rNJSI+xTAf8bCFExnFDAzn+hF/SWXjVi0fOrnQKTkbCh
 7A0Ki+j2QYubYdZ3BhzKyPVNhumRyv0WnsxIbwpp7wKHV8sqRpR3VOcF82zNMB3//VcW
 9ugA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787680699; x=1788285499;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RHhXfom/PVt8sn5EwtuOxaxvdjL2LlMD1vwZ+ooKzhU=;
 b=dYDztohfWN18+w4EiGTQ9k5fGqfgkOrPk3MKyRf1MFA1CeY2umTcyKJYfoaKg35g6V
 Oh03JUJJykBLJwVcdUR/4xqdkg9p3S8ehIKZVKvyN/OA4OaR0jSCRO1ukq4H/Agd6EA6
 YcGPTgF1gZc0v7nt4mrVTjcx1gNWkk2cpkXqTvSq+mQ4zxzcoLr7WbuXNL9EMwe7sr1D
 sSQXipBrtkA+idfo0GmQYVQ90upVUiBbs11y2dYzKq2jSuWLxvrO5vtCp/vup0j4I9Oi
 yq/B87SLaEEk23slDe8WPdOjHHzLrd7nbjONpo3LEvCbMZadoLrn9DyO+R7y2O3xqrI5
 5a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787680699; x=1788285499;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RHhXfom/PVt8sn5EwtuOxaxvdjL2LlMD1vwZ+ooKzhU=;
 b=tPdBoyByExFLm/5nAggEWqkD3Fnerpl2V5bhwSKW72E57hiZbXF4EiPD1Z6+wcARNv
 x8pl5IsXzIzsTiVMTTEySkYM7t/0P0YAe3BxqNUWA00drzYodAP+ZqC1FNs0HI26Gms8
 rJPYc1nI7HuyyEgZHtfMc5HmOt2Zk1FA4LevVxZ1ARUVZvi2LvlYSwuKl8LyDzltVu2r
 BtrdKhreVal9YDdRm6w9vB5qdgV9WyymzBgvaeqcPrin6xEPC1hJ6TBBRv1a/UvpW4jh
 MwdhzUI0Pbj1CQmJJon8yXXWw5ysmMVFy/4pjTppcWM903CH/jqnUPLeFhgUNob5ukqT
 NEag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpbjh47cXig+9ncQ3IBrfd2a/0uUqBLCrWcJKdqj911ZeE+BwBg10jQeLLPsGlTN4/Y2YtNlKk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kAcT3oUseDbZ3zeiVCRj1ojIKwGrQXkJYnLvb6qO1QAhIRkNav
 fOYWtpYj+uhWc2G1RxlzmvUhwsVSOmR5/lldlp51sS8a7THp3PwWfQ+W6zVBDfjRA+q36P6cMls
 xztAwN92XkV8gE0HvydyAOCiQfXp2IBjcOif6ApuA
X-Gm-Gg: AR+sD12J6FXN2yd2hMK6HHfmQdflbhhL5aDG2Y1Nd9ouaXl+HzWY2L4c5Suwxj8qkEt
 apsYBEyVzRs/zKCU53QwYDEJrA6C3s8uDjhLKT2SzZvg6bFGePEgX+x9V2NOh+C1zF4Xm3d1NMV
 4xsB4W9sI12VL32tL1FUBzQR/lpfkxGbuY2wN3f6NexoCruWz4r6bOSmt2Vlvh82pGPuxDSOGts
 WbNNVI8W/0TIg/SXEvdVKmC2MTCjGiOHx4cDlZOronEE7WlhRvyq13Y0GlVI6jxhxcD4NOmnGrR
 23vwklKVoPM9cpV7YpAU+NawCAai4kKEgSMW/QIf2JW+ydS65YdHgcn6dItUkF4ZtqOdqWIB9+D
 azbVXHxtQ9jmu
X-Received: by 2002:a17:90b:530c:b0:396:635a:9b10 with SMTP id
 98e67ed59e1d1-3966d3dc393mr1769050a91.11.1787680698208; Tue, 25 Aug 2026
 10:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260819191046.4125809-1-yuxiaozhang@google.com>
 <53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>
In-Reply-To: <53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Tue, 25 Aug 2026 10:58:06 -0700
X-Gm-Features: AcwNN1Vuz5GdWJZ7pcMpif6uVrsPVvbAP2AjyEPdUtV5l8g8qMQAkoP6yWgM9ns
Message-ID: <CAOOoKeQyJ+U-r1hNUrtkwNg=9Q3Qm_EqVUMSoN+-m+7k-zP=Sw@mail.gmail.com>
Subject: Re: [PATCH] dhcpv6: support rapid commit dhcp6 option
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
Content-Type: multipart/alternative; boundary="000000000000fe6b790659e2d806"
X-Mailman-Approved-At: Tue, 25 Aug 2026 19:08:20 +0000
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

--000000000000fe6b790659e2d806
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the reviewing. Addressed the comments in patch V2.

Thanks,
-Yuxiao

On Tue, Aug 25, 2026 at 6:19=E2=80=AFAM Jerome Forissier <jerome.forissier@=
arm.com>
wrote:

> Hi Yuxiao,
>
> Two minor comments below. Thanks!
>
> On 19/08/2026 21:10, Yuxiao Zhang wrote:
> > Support rapid commit option code 14 which bypass the advertise and
> > request state. The option is enabled by DHCP6_RAPID_COMMIT.
> >
> > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > ---
> >
> >  cmd/Kconfig  |  8 ++++++++
> >  net/dhcpv6.c | 39 ++++++++++++++++++++++++++++++++-------
> >  net/dhcpv6.h |  2 ++
> >  3 files changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index ff90a87024c..b3cf3a6d8b6 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID
> >       int "Enterprise ID to send in DHCPv6 Vendor Class Option"
> >       default 0
> >
> > +config DHCP6_RAPID_COMMIT
> > +     bool "Request Rapid Commit (2-message exchange) from DHCPv6 serve=
r"
> > +     default n
> > +     help
> > +       Request the Rapid Commit option (option 14) in DHCPv6 Solicit
> > +       messages to enable a 2-message exchange (Solicit-Reply) rather
> > +       than the default 4-message exchange.
> > +
> >  endif
> >
> >  config BOOTP_MAY_FAIL
> > diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> > index 640f089a2e1..1e51e6de256 100644
> > --- a/net/dhcpv6.c
> > +++ b/net/dhcpv6.c
> > @@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar
> *pkt)
> >
> >               opt_len =3D sizeof(struct dhcp6_option_ia_na);
> >               break;
> > +     case DHCP6_OPTION_RAPID_COMMIT:
> > +             opt_len =3D 0;
> > +             break;
> >       case DHCP6_OPTION_ORO:
> >               oro_opt =3D (struct dhcp6_option_oro *)dhcp_option_start;
> >               oro_opt->req_option_code[num_oro++] =3D
> htons(DHCP6_OPTION_OPT_BOOTFILE_URL);
> > @@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)
> >       pkt +=3D dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
> >       pkt +=3D dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
> >       pkt +=3D dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
> > +     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))
> > +             pkt +=3D dhcp6_add_option(DHCP6_OPTION_RAPID_COMMIT, pkt)=
;
> >       if (CONFIG_DHCP_PXE_CLIENTARCH !=3D 0xFF)
> >               pkt +=3D dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE,
> pkt);
> >       pkt +=3D dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
> > @@ -448,6 +453,12 @@ static void dhcp6_parse_options(uchar *rx_pkt,
> unsigned int len)
> >                       }
> >                       sm_params.rx_status.preference =3D *option_ptr;
> >                       break;
> > +             case DHCP6_OPTION_RAPID_COMMIT:
> > +                     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
>
> option_len !=3D 0 should probably be rejected here
>
> > +                             debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n"=
);
> > +                             sm_params.rx_status.rapid_commit_found =
=3D
> true;
> > +                     }
> > +                     break;
> >               default:
> >                       debug("Unknown Option ID: %d, skipping parsing\n"=
,
> >                             ntohs(option_hdr->option_id));
> > @@ -618,14 +629,28 @@ static void dhcp6_state_machine(bool timeout,
> uchar *rx_pkt, unsigned int len)
> >               break;
> >       case DHCP6_SOLICIT:
> >               if (!timeout) {
> > -                     /* check the rx packet and determine if we can
> transition to next
> > -                      * state.
> > -                      */
> > -                     if (dhcp6_check_advertise_packet(rx_pkt, len))
> > -                             return;
> > +                     struct dhcp6_hdr *dhcp6_hdr =3D (struct dhcp6_hdr
> *)rx_pkt;
> > +
> > +                     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &&
> > +                         dhcp6_hdr && dhcp6_hdr->msg_type =3D=3D
> DHCP6_MSG_REPLY) {
>
> dhcp6_hdr is necessarily non-NULL here, so please drop "dhcp6_hdr &&"
>
> > +                             if (dhcp6_check_reply_packet(rx_pkt, len)=
)
> > +                                     return;
> > +                             if
> (!sm_params.rx_status.rapid_commit_found) {
> > +                                     debug("[DHCPv6] REPLY received
> without Rapid Commit option, ignoring\n");
> > +                                     return;
> > +                             }
> > +                             debug("REPLY (Rapid Commit) good,
> transition to DONE\n");
> > +                             sm_params.next_state =3D DHCP6_DONE;
> > +                     } else {
> > +                             /* check the rx packet and determine if w=
e
> can transition to next
> > +                              * state.
> > +                              */
> > +                             if (dhcp6_check_advertise_packet(rx_pkt,
> len))
> > +                                     return;
> >
> > -                     debug("ADVERTISE good, transition to REQUEST\n");
> > -                     sm_params.next_state =3D DHCP6_REQUEST;
> > +                             debug("ADVERTISE good, transition to
> REQUEST\n");
> > +                             sm_params.next_state =3D DHCP6_REQUEST;
> > +                     }
> >               } else if (sm_params.retry_cnt =3D=3D 1)  {
> >                       /* If a server UID was received in the first
> SOLICIT period
> >                        * transition to REQUEST
> > diff --git a/net/dhcpv6.h b/net/dhcpv6.h
> > index d41a3c30615..49f20390730 100644
> > --- a/net/dhcpv6.h
> > +++ b/net/dhcpv6.h
> > @@ -24,6 +24,7 @@
> >  #define DHCP6_OPTION_PREFERENCE              7
> >  #define DHCP6_OPTION_ELAPSED_TIME    8
> >  #define DHCP6_OPTION_STATUS_CODE     13
> > +#define DHCP6_OPTION_RAPID_COMMIT    14
> >  #define DHCP6_OPTION_OPT_BOOTFILE_URL        59
> >  #define DHCP6_OPTION_OPT_BOOTFILE_PARAM      60
> >  #define DHCP6_OPTION_SOL_MAX_RT              82
> > @@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {
> >       enum dhcp6_status       ia_status_code;
> >       enum dhcp6_status       status_code;
> >       u8                      preference;
> > +     bool                    rapid_commit_found;
> >  };
> >
> >  /**
> > ---
> > base-commit: 527115ef6783cec49e5610c523c124b399011361
> > branch: main
> >
>
> --
> Jerome
>

--000000000000fe6b790659e2d806
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3aW5nLiBBZGRyZXNzZWQgdGhl
IGNvbW1lbnRzIGluIHBhdGNoIFYyLjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2Pjxk
aXY+LVl1eGlhbzwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFpbF9x
dW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUs
IEF1ZyAyNSwgMjAyNiBhdCA2OjE54oCvQU0gSmVyb21lIEZvcmlzc2llciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbSI+amVyb21lLmZvcmlzc2llckBhcm0uY29t
PC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBZdXhpYW8sPGJyPg0KPGJyPg0KVHdv
IG1pbm9yIGNvbW1lbnRzIGJlbG93LiBUaGFua3MhPGJyPg0KPGJyPg0KT24gMTkvMDgvMjAyNiAy
MToxMCwgWXV4aWFvIFpoYW5nIHdyb3RlOjxicj4NCiZndDsgU3VwcG9ydCByYXBpZCBjb21taXQg
b3B0aW9uIGNvZGUgMTQgd2hpY2ggYnlwYXNzIHRoZSBhZHZlcnRpc2UgYW5kPGJyPg0KJmd0OyBy
ZXF1ZXN0IHN0YXRlLiBUaGUgb3B0aW9uIGlzIGVuYWJsZWQgYnkgREhDUDZfUkFQSURfQ09NTUlU
Ljxicj4NCiZndDsgPGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5OiBZdXhpYW8gWmhhbmcgJmx0Ozxh
IGhyZWY9Im1haWx0bzp5dXhpYW96aGFuZ0Bnb29nbGUuY29tIiB0YXJnZXQ9Il9ibGFuayI+eXV4
aWFvemhhbmdAZ29vZ2xlLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAtLS08YnI+DQomZ3Q7IDxicj4N
CiZndDvCoCBjbWQvS2NvbmZpZ8KgIHzCoCA4ICsrKysrKysrPGJyPg0KJmd0O8KgIG5ldC9kaGNw
djYuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLTxicj4NCiZn
dDvCoCBuZXQvZGhjcHY2LmggfMKgIDIgKys8YnI+DQomZ3Q7wqAgMyBmaWxlcyBjaGFuZ2VkLCA0
MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKTxicj4NCiZndDsgPGJyPg0KJmd0OyBkaWZm
IC0tZ2l0IGEvY21kL0tjb25maWcgYi9jbWQvS2NvbmZpZzxicj4NCiZndDsgaW5kZXggZmY5MGE4
NzAyNGMuLmIzY2YzYTZkOGI2IDEwMDY0NDxicj4NCiZndDsgLS0tIGEvY21kL0tjb25maWc8YnI+
DQomZ3Q7ICsrKyBiL2NtZC9LY29uZmlnPGJyPg0KJmd0OyBAQCAtMTk5Niw2ICsxOTk2LDE0IEBA
IGNvbmZpZyBESENQNl9FTlRFUlBSSVNFX0lEPGJyPg0KJmd0O8KgIMKgIMKgIMKgaW50ICZxdW90
O0VudGVycHJpc2UgSUQgdG8gc2VuZCBpbiBESENQdjYgVmVuZG9yIENsYXNzIE9wdGlvbiZxdW90
Ozxicj4NCiZndDvCoCDCoCDCoCDCoGRlZmF1bHQgMDxicj4NCiZndDvCoCA8YnI+DQomZ3Q7ICtj
b25maWcgREhDUDZfUkFQSURfQ09NTUlUPGJyPg0KJmd0OyArwqAgwqAgwqBib29sICZxdW90O1Jl
cXVlc3QgUmFwaWQgQ29tbWl0ICgyLW1lc3NhZ2UgZXhjaGFuZ2UpIGZyb20gREhDUHY2IHNlcnZl
ciZxdW90Ozxicj4NCiZndDsgK8KgIMKgIMKgZGVmYXVsdCBuPGJyPg0KJmd0OyArwqAgwqAgwqBo
ZWxwPGJyPg0KJmd0OyArwqAgwqAgwqAgwqBSZXF1ZXN0IHRoZSBSYXBpZCBDb21taXQgb3B0aW9u
IChvcHRpb24gMTQpIGluIERIQ1B2NiBTb2xpY2l0PGJyPg0KJmd0OyArwqAgwqAgwqAgwqBtZXNz
YWdlcyB0byBlbmFibGUgYSAyLW1lc3NhZ2UgZXhjaGFuZ2UgKFNvbGljaXQtUmVwbHkpIHJhdGhl
cjxicj4NCiZndDsgK8KgIMKgIMKgIMKgdGhhbiB0aGUgZGVmYXVsdCA0LW1lc3NhZ2UgZXhjaGFu
Z2UuPGJyPg0KJmd0OyArPGJyPg0KJmd0O8KgIGVuZGlmPGJyPg0KJmd0O8KgIDxicj4NCiZndDvC
oCBjb25maWcgQk9PVFBfTUFZX0ZBSUw8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9uZXQvZGhjcHY2
LmMgYi9uZXQvZGhjcHY2LmM8YnI+DQomZ3Q7IGluZGV4IDY0MGYwODlhMmUxLi4xZTUxZTZkZTI1
NiAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL25ldC9kaGNwdjYuYzxicj4NCiZndDsgKysrIGIvbmV0
L2RoY3B2Ni5jPGJyPg0KJmd0OyBAQCAtMTE1LDYgKzExNSw5IEBAIHN0YXRpYyBpbnQgZGhjcDZf
YWRkX29wdGlvbihpbnQgb3B0aW9uX2lkLCB1Y2hhciAqcGt0KTxicj4NCiZndDvCoCA8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvcHRfbGVuID0gc2l6ZW9mKHN0cnVjdCBkaGNwNl9v
cHRpb25faWFfbmEpOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4N
CiZndDsgK8KgIMKgIMKgY2FzZSBESENQNl9PUFRJT05fUkFQSURfQ09NTUlUOjxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgb3B0X2xlbiA9IDA7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBjYXNlIERIQ1A2X09QVElPTl9PUk86
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb3JvX29wdCA9IChzdHJ1Y3QgZGhjcDZf
b3B0aW9uX29ybyAqKWRoY3Bfb3B0aW9uX3N0YXJ0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG9yb19vcHQtJmd0O3JlcV9vcHRpb25fY29kZVtudW1fb3JvKytdID0gaHRvbnMoREhD
UDZfT1BUSU9OX09QVF9CT09URklMRV9VUkwpOzxicj4NCiZndDsgQEAgLTE5NCw2ICsxOTcsOCBA
QCBzdGF0aWMgdm9pZCBkaGNwNl9zZW5kX3NvbGljaXRfcGFja2V0KHZvaWQpPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgcGt0ICs9IGRoY3A2X2FkZF9vcHRpb24oREhDUDZfT1BUSU9OX0VMQVBTRURfVElN
RSwgcGt0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBwa3QgKz0gZGhjcDZfYWRkX29wdGlvbihESENQ
Nl9PUFRJT05fSUFfTkEsIHBrdCk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgcGt0ICs9IGRoY3A2X2Fk
ZF9vcHRpb24oREhDUDZfT1BUSU9OX09STywgcGt0KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChJ
U19FTkFCTEVEKENPTkZJR19ESENQNl9SQVBJRF9DT01NSVQpKTxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgcGt0ICs9IGRoY3A2X2FkZF9vcHRpb24oREhDUDZfT1BUSU9OX1JBUElEX0NP
TU1JVCwgcGt0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpZiAoQ09ORklHX0RIQ1BfUFhFX0NMSUVO
VEFSQ0ggIT0gMHhGRik8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwa3QgKz0gZGhj
cDZfYWRkX29wdGlvbihESENQNl9PUFRJT05fQ0xJRU5UX0FSQ0hfVFlQRSwgcGt0KTs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqBwa3QgKz0gZGhjcDZfYWRkX29wdGlvbihESENQNl9PUFRJT05fVkVORE9S
X0NMQVNTLCBwa3QpOzxicj4NCiZndDsgQEAgLTQ0OCw2ICs0NTMsMTIgQEAgc3RhdGljIHZvaWQg
ZGhjcDZfcGFyc2Vfb3B0aW9ucyh1Y2hhciAqcnhfcGt0LCB1bnNpZ25lZCBpbnQgbGVuKTxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzbV9wYXJhbXMucnhfc3RhdHVzLnByZWZlcmVu
Y2UgPSAqb3B0aW9uX3B0cjs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBicmVhazs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgREhDUDZfT1BU
SU9OX1JBUElEX0NPTU1JVDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChJU19FTkFCTEVEKENPTkZJR19ESENQNl9SQVBJRF9DT01NSVQpKSB7PGJyPg0KPGJy
Pg0Kb3B0aW9uX2xlbiAhPSAwIHNob3VsZCBwcm9iYWJseSBiZSByZWplY3RlZCBoZXJlPGJyPg0K
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
ZWJ1ZygmcXVvdDtESENQNl9PUFRJT05fUkFQSURfQ09NTUlUIEZPVU5EXG4mcXVvdDspOzxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc21fcGFy
YW1zLnJ4X3N0YXR1cy5yYXBpZF9jb21taXRfZm91bmQgPSB0cnVlOzxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVm
YXVsdDo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWJ1Zygm
cXVvdDtVbmtub3duIE9wdGlvbiBJRDogJWQsIHNraXBwaW5nIHBhcnNpbmdcbiZxdW90Oyw8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBudG9ocyhv
cHRpb25faGRyLSZndDtvcHRpb25faWQpKTs8YnI+DQomZ3Q7IEBAIC02MTgsMTQgKzYyOSwyOCBA
QCBzdGF0aWMgdm9pZCBkaGNwNl9zdGF0ZV9tYWNoaW5lKGJvb2wgdGltZW91dCwgdWNoYXIgKnJ4
X3BrdCwgdW5zaWduZWQgaW50IGxlbik8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
cmVhazs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBjYXNlIERIQ1A2X1NPTElDSVQ6PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCF0aW1lb3V0KSB7PGJyPg0KJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBjaGVjayB0aGUgcnggcGFja2V0IGFuZCBkZXRlcm1p
bmUgaWYgd2UgY2FuIHRyYW5zaXRpb24gdG8gbmV4dDxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICogc3RhdGUuPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKi88YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChkaGNwNl9jaGVja19hZHZlcnRpc2VfcGFja2V0KHJ4X3BrdCwgbGVuKSk8YnI+DQom
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBkaGNwNl9o
ZHIgKmRoY3A2X2hkciA9IChzdHJ1Y3QgZGhjcDZfaGRyICopcnhfcGt0Ozxicj4NCiZndDsgKzxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKElTX0VOQUJMRUQo
Q09ORklHX0RIQ1A2X1JBUElEX0NPTU1JVCkgJmFtcDsmYW1wOzxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGhjcDZfaGRyICZhbXA7JmFtcDsgZGhjcDZf
aGRyLSZndDttc2dfdHlwZSA9PSBESENQNl9NU0dfUkVQTFkpIHs8YnI+DQo8YnI+DQpkaGNwNl9o
ZHIgaXMgbmVjZXNzYXJpbHkgbm9uLU5VTEwgaGVyZSwgc28gcGxlYXNlIGRyb3AgJnF1b3Q7ZGhj
cDZfaGRyICZhbXA7JmFtcDsmcXVvdDs8YnI+DQo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkaGNwNl9jaGVja19yZXBseV9wYWNrZXQo
cnhfcGt0LCBsZW4pKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFzbV9wYXJhbXMucnhfc3RhdHVzLnJh
cGlkX2NvbW1pdF9mb3VuZCkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVidWcoJnF1b3Q7W0RIQ1B2Nl0gUkVQTFkg
cmVjZWl2ZWQgd2l0aG91dCBSYXBpZCBDb21taXQgb3B0aW9uLCBpZ25vcmluZ1xuJnF1b3Q7KTs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybjs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRlYnVnKCZxdW90O1JFUExZIChSYXBpZCBDb21taXQpIGdvb2QsIHRy
YW5zaXRpb24gdG8gRE9ORVxuJnF1b3Q7KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNtX3BhcmFtcy5uZXh0X3N0YXRlID0gREhDUDZfRE9O
RTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBj
aGVjayB0aGUgcnggcGFja2V0IGFuZCBkZXRlcm1pbmUgaWYgd2UgY2FuIHRyYW5zaXRpb24gdG8g
bmV4dDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICogc3RhdGUuPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKi88YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChkaGNwNl9jaGVja19hZHZlcnRpc2VfcGFja2V0KHJ4X3BrdCwgbGVu
KSk8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybjs8YnI+DQomZ3Q7wqAgPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZWJ1ZygmcXVvdDtBRFZFUlRJU0UgZ29vZCwgdHJhbnNpdGlv
biB0byBSRVFVRVNUXG4mcXVvdDspOzxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc21fcGFyYW1zLm5leHRfc3RhdGUgPSBESENQNl9SRVFVRVNUOzxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVidWcoJnF1b3Q7
QURWRVJUSVNFIGdvb2QsIHRyYW5zaXRpb24gdG8gUkVRVUVTVFxuJnF1b3Q7KTs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNtX3BhcmFtcy5u
ZXh0X3N0YXRlID0gREhDUDZfUkVRVUVTVDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVsc2UgaWYg
KHNtX3BhcmFtcy5yZXRyeV9jbnQgPT0gMSnCoCB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyogSWYgYSBzZXJ2ZXIgVUlEIHdhcyByZWNlaXZlZCBpbiB0aGUg
Zmlyc3QgU09MSUNJVCBwZXJpb2Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgKiB0cmFuc2l0aW9uIHRvIFJFUVVFU1Q8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9u
ZXQvZGhjcHY2LmggYi9uZXQvZGhjcHY2Lmg8YnI+DQomZ3Q7IGluZGV4IGQ0MWEzYzMwNjE1Li40
OWYyMDM5MDczMCAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL25ldC9kaGNwdjYuaDxicj4NCiZndDsg
KysrIGIvbmV0L2RoY3B2Ni5oPGJyPg0KJmd0OyBAQCAtMjQsNiArMjQsNyBAQDxicj4NCiZndDvC
oCAjZGVmaW5lIERIQ1A2X09QVElPTl9QUkVGRVJFTkNFwqAgwqAgwqAgwqAgwqAgwqAgwqAgNzxi
cj4NCiZndDvCoCAjZGVmaW5lIERIQ1A2X09QVElPTl9FTEFQU0VEX1RJTUXCoCDCoCA4PGJyPg0K
Jmd0O8KgICNkZWZpbmUgREhDUDZfT1BUSU9OX1NUQVRVU19DT0RFwqAgwqAgwqAxMzxicj4NCiZn
dDsgKyNkZWZpbmUgREhDUDZfT1BUSU9OX1JBUElEX0NPTU1JVMKgIMKgIDE0PGJyPg0KJmd0O8Kg
ICNkZWZpbmUgREhDUDZfT1BUSU9OX09QVF9CT09URklMRV9VUkzCoCDCoCDCoCDCoCA1OTxicj4N
CiZndDvCoCAjZGVmaW5lIERIQ1A2X09QVElPTl9PUFRfQk9PVEZJTEVfUEFSQU3CoCDCoCDCoCA2
MDxicj4NCiZndDvCoCAjZGVmaW5lIERIQ1A2X09QVElPTl9TT0xfTUFYX1JUwqAgwqAgwqAgwqAg
wqAgwqAgwqAgODI8YnI+DQomZ3Q7IEBAIC0xNTIsNiArMTUzLDcgQEAgc3RydWN0IGRoY3A2X3J4
X3BrdF9zdGF0dXMgezxicj4NCiZndDvCoCDCoCDCoCDCoGVudW0gZGhjcDZfc3RhdHVzwqAgwqAg
wqAgwqBpYV9zdGF0dXNfY29kZTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBlbnVtIGRoY3A2X3N0YXR1
c8KgIMKgIMKgIMKgc3RhdHVzX2NvZGU7PGJyPg0KJmd0O8KgIMKgIMKgIMKgdTjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmVmZXJlbmNlOzxicj4NCiZndDsgK8KgIMKgIMKgYm9v
bMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhcGlkX2NvbW1pdF9mb3VuZDs8YnI+DQom
Z3Q7wqAgfTs8YnI+DQomZ3Q7wqAgPGJyPg0KJmd0O8KgIC8qKjxicj4NCiZndDsgLS0tPGJyPg0K
Jmd0OyBiYXNlLWNvbW1pdDogNTI3MTE1ZWY2NzgzY2VjNDllNTYxMGM1MjNjMTI0YjM5OTAxMTM2
MTxicj4NCiZndDsgYnJhbmNoOiBtYWluPGJyPg0KJmd0OyA8YnI+DQo8YnI+DQotLSA8YnI+DQpK
ZXJvbWU8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--000000000000fe6b790659e2d806--
