Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F0EC79FAE
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 20:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AA7E60749;
	Tue,  8 Sep 2026 20:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbqDhVt6mNXn; Tue,  8 Sep 2026 20:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0DED2606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788901140;
	b=ErD83a+psL/Osb7DHncEEZLDNtBEVE6+A4y3jp3hUZIJCnQcBitlf1KO8AnX4Acl7jkh
	 +5eGrmjj+5iq962tlc3ojRqHdGDdR5MzdEB/zVreWEsbRHDUt4OjwNi6QDYNO9Iu8h8it
	 Pj9u/LT8Rn9hOJj7upD8JzDj7a6TXHmzcSUpy/yTwlmgLwgrgjP+s/LQQ0kYLKa/5Zf2Y
	 XItb+7Qdh0csxcJQ6M088kLA9gJvjrkgnUE3IVZV4wfwgbNNp+daZqtjB8LyMiZMy9G/U
	 6JP5HOoC1gP+7VwHL1jx4aro35vJyDKXbZYdg1GMwO2Se+Rj0hiqTQPySgrSJiZ+MGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788901140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
	b=VEZMrP1IqpAlJ4FJL6Z78bH0EXqmdK6T1bIP9JngixL23dGAOUdOXw6yeT4neJoEN/wO
	 wJM7k+kDyjaTvRM3bP22+rg0S4xHAugQRQxzCRCGvzP0IZbH0MQHi35V8IczzOjmsJS+t
	 mMcdYXJSnjvyiLjVJktGY7ZSLBR9FLbhipM1ujRqd0LOXxIXGjzwGobv+YEFOOt0xsQRS
	 VYDzSRXBVu9xm64k8GasU55l9mmi46F+CLbToda8YekyT716yIc8sryL9xSB+S7A+2nCb
	 qpa24aUYJH+Xy+NLstXEgk89mVlPOYJ16CTfhxo8b5T1mG6GTSWO7udeDEqiDYBm+dQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788901140;
	bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0LoRrifZ4hLzCJalGXacO/QAUDN5HB3DqNLqVtM892p1OsQN9W9+gkRpmBfS6MAE
	 qFDg4hMdEuhBfxC3ydBEg9sKgMaW/Nxa/ZQqrMDV0r4oZhy9qDe5avr5OiQjTZkiEE
	 MrcW7YvFrXzcYTrovFqGlsgo4U5s2ayovuY2GUokBVbZsj2VM/WrvuWjrzDpnlUaKF
	 s602s1SsnxIiYMgKBvR9U2vZ4auoX32FtYCfHqtg0yDjxDsub28pcI9YISQymwYHWk
	 +f8RAg3+JeYr66Qm8DtcFSA9AUQMFXtDSqptVleaSB1BaRAX1Xlik40dqHNs52/pjR
	 SHJQaxoAIUK7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DED2606F8;
	Tue,  8 Sep 2026 20:59:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 685332D2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37B9E4018D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VeklLd5hAWaP for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 20:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1409E4009A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788900924;
 b=mjIo0YYJxQY1qyB1EzJ2EFlF/9xtONEotKiXVAAPE7/nwf6NHvPGQJkoIb66wzM5C6ZS
 HiuLr1V3cXbWwk9d/wqsgJAbaaA0KEo3kbL24K9E53qr1W0YSxGXlQW9dsyMNuf4AIgwk
 dQHaCSOjiv0eaRvz7zimy2Nva3+kNttAbK5102NjL//gt/aqFh1oLhFrvk+N3eTqdMxit
 RJO6/ialUcR80jXb9ht9ziV9uKenZX6c08uJuEYvqGKv/dtkVJjfKDuqsILszDE6oyPYK
 4NAAOZIxA5lzus3n6lYt9GxRLBKgArDZePfJ5OAzlKxPu/jkTJOr6Ew6iAUewuKHURg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788900924;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
 b=W+tZS3PkHd4cY8yM0e/SyTeK5HImOR1tMtsH+7ocAySMEBlR4bi2MCZC4r9CbNfxtSF4
 Qt77+sUZfND0AD1SyYU2uUX6idQLcUUrQRprQkRmC2EO8M2SNBDbZ4xV192u1Sq/SerCB
 BDIbowc9kS4I+fuy1o/s8WAPBNlUbgvV4NK896D5TMHKnSIbAu7fs/brgVm0DBCLqNW8l
 C892WARHJsMC3iEt5A29m5YvBxSY8N1/KRrpbLRA8DSRmveSNx74iqiwqq5zkN+tfzzHb
 zy2AKHMSND+oXx8A0iOdi+DHiMAgWUOZwVxzJXoFizjSjxKEwR9PY0fzUdpYiP0wx1g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b="M/jcEAHB"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=yuxiaozhang@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=M/jcEAHB
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1409E4009A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:55:23 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so5393245a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 13:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788900923; cv=none;
 d=google.com; s=arc-20260327;
 b=NWmSklwSqPmLJNIgiY/1xsnZuEDI9MrVo8tn06qk9Lx+H497Qi9tCWx80TpLYU5r2x
 PjiqkcGp8evhPKwrWREl+O7tDlvvMtiphKczcVK8SHOrmfebURUa7H5O44K1z2MUb9zK
 X41hs/rkgp/Og/K/tJRVsipsZ6Jq4uc4g4+vtM17tprokuQ9i3uFIO6TeKL1LyijbGSO
 5jMjp1ga8Lb48jXtINkMxWB+uPgVgcbCKWwhtLyX3qlKSz+6ACoWBFBNtFfqJuS+tUbj
 hmPowrht07ZsI9fW08LCyt47wnyOq/nRGr5nFAV8cU3QX+jSYRHDT0YKYkR5aEKmMspy
 xLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
 fh=4p2nh7U32o8U0jml9uoUEJsQeRAzV/1RHbyNvyoMcXk=;
 b=W/EJpWe9zzKCakxKMJz6A6zAoSzGQr1V7RvmAEAFtM0s6GPYHUtyNa6YoinbfE7deN
 Aytqq6JX95jMTsAwc6ZSANSKAORs2grLtodnUshW0+u1MdgXoEWSljYy8NrHJrDi9Wme
 NythzE9VeKfM3p7qgFcD0wIrmPRcUWpykAtuMYEZ2riNQ9HfPkOEnXqYVWhi3IGqY3XO
 0tAVMbAa306xdy6r3KEhQDkanMaAB6JppAXYxSy0wX2QtDD0balaFzAuePLw41Bh3wM2
 869S5xpImNvd3s6esPcQPY+DaUd+jduSRWXe5URGg/dG41MV0nO39XcyKu3NRYUiJAFo
 KjBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788900923; x=1789505723;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
 b=M/jcEAHBd7Dr1gWDV3F4lyLowrMBIQJxeV1jGKqoirA1LnIjKAJIp3OGO8n6dacW1n
 xUZOKxbwx9IYoVPknfnkWnxI7MA75hfJ2rgfXuaAEjFo/OSM20leuXNCSdmD30wF8JkZ
 W9RFA+ztXc5wueWvjIt5sC8wg1ycT9dNXg8aDfcpRI82HSxuuNgmqW+2vx89Y2W3vjUl
 Ti7EUC7Kl4mwLJN5hG9PHNQBXvS6jhnujeWq+r4tb/53tqdb4DDBWh1tv06TTctffyL1
 Ryhi7LnL6qHTCYbNmto81wL82olBMF9YL4bxfhjMujXX+KlwG7Y+YUB5H1K63VAgpJep
 /1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788900923; x=1789505723;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FgbkoSuk2a5qNweKA6SRfiB1VzJ0K1IApMeKckXuXlg=;
 b=n1llD64UEtNfuixwGoCubgb182Mx0CvzJz9AMKxVokzsNWjrDs6/eLN7xYotKseld+
 DcqfN2AhSNSsMC4+HVda0dn8DWFPv6CHwQKNUlFYQ9rIHXFEeKbfmX9Wal6fmeORDqwj
 J5HOSDn9hFoqENR2L6Nd0T36JoQ69pXKRLueoUaVy8beWFWGDT08TLYaT2eh1nZR159+
 8C4O7KA8R8ji9Wc06lN6l2rye4+vbHT+p7IZw6hwvHm9TMDKQDooH7DUhlRQ8ZpSkYdJ
 isoGuXvsX+KrMsv2s8qo3oxGoElP2eoCXQdYC3oM79nGO+xcKhGei7k52tXi74fBmwCU
 36xQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIhrzPJI0g7Zbahfmf0iXNoOS5ElBsTCQb7Fz68307J54qxwN8/Qwh5KcXioa4VdoGTAn7sic=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mfC9hz2FXdGpkQXo3BEm+ij+n3Ko0vZ+LYxCH4DI8hKnzQUE6L
 3WcGhUT5e6O5g4sVF/3BFzAOvIrgU1WfVl0CFq5rZIa7SV5YzTJzSzrSgGhq3A1b81Enj+g19Ir
 FHl7SkyslhD0leFfovs6ZoAzJKzjtPoccIZJmTEi0
X-Gm-Gg: AYBFou21rhSKKTVyPKRVqkqqh1oL6LwBbPM60czBjIsCoutK1V+OKAnDiTNC++OAmbG
 Sf84QvoI2vSTnHswiLIKKrE+PRkMtczxCEovfdyw/0QSW06Cw2xL2gMREnKOgEyeqlOmV2NfNvH
 n/zmQBM1cN1yd7CCPlEKjq50AB0s6E01R8MJnEaVGYPUbIRrDTvdW3ovuJHnKQJ7mSvX4sKdv8P
 x/0ALb1R2iuyZwju5MeD8uKbEZBreguW3rzdV3UsiW3acot/9R2wup+Mpks70Dw1u0w559Rx2jB
 TiWtKB2t2WNVzO8LfGycTbxGKu9q2zevxAXXcXYBo6EC6S793CRuPn8rYnDZDY3ijEycnMj2sqE
 =
X-Received: by 2002:a17:90b:2681:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-39b261d52a4mr46803037a91.15.1788900922246; Tue, 08 Sep 2026
 13:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260825175417.1068611-1-yuxiaozhang@google.com>
 <63520249-a647-47ea-bd14-c9b6a41b35f8@arm.com>
In-Reply-To: <63520249-a647-47ea-bd14-c9b6a41b35f8@arm.com>
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Tue, 8 Sep 2026 13:55:10 -0700
X-Gm-Features: AcwNN1VEC5LzwCo4nxSlenFMLLSupjyfY_Ak5E5eKJFdT920pnU35PP3Y8O1_2g
Message-ID: <CAOOoKeSLKjWaeGBxvrMmc2MqvgdNahcBrbV=-aRQFLL0_caLnA@mail.gmail.com>
Subject: Re: [PATCH v2] dhcpv6: support rapid commit dhcp6 option
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
Content-Type: multipart/alternative; boundary="00000000000003dbbc065afef411"
X-Mailman-Approved-At: Tue, 08 Sep 2026 20:58:57 +0000
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

--00000000000003dbbc065afef411
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:01=E2=80=AFAM Jerome Forissier <jerome.forissier@a=
rm.com>
wrote:

> Hi Yuxiao,
>
> On 25/08/2026 19:53, Yuxiao Zhang wrote:
> > Support rapid commit option code 14 which bypass the advertise and
> > request state. The option is enabled by DHCP6_RAPID_COMMIT.
> >
> > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > ---
> >
> > Changes in v2:
> > - Reject rapid commit option if option_len !=3D 0
> > - Drop redundant NULL check on dhcp6_hdr
> >
> >  cmd/Kconfig  |  8 ++++++++
> >  net/dhcpv6.c | 43 ++++++++++++++++++++++++++++++++++++-------
> >  net/dhcpv6.h |  2 ++
> >  3 files changed, 46 insertions(+), 7 deletions(-)
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
> > index 640f089a2e1..5ed8449edb5 100644
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
> > @@ -448,6 +453,16 @@ static void dhcp6_parse_options(uchar *rx_pkt,
> unsigned int len)
> >                       }
> >                       sm_params.rx_status.preference =3D *option_ptr;
> >                       break;
> > +             case DHCP6_OPTION_RAPID_COMMIT:
> > +                     if (option_len !=3D 0) {
> > +                             debug("Invalid rapid commit option
> length\n");
> > +                             break;
> > +                     }
> > +                     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
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
> > @@ -618,14 +633,28 @@ static void dhcp6_state_machine(bool timeout,
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
> > +                         dhcp6_hdr->msg_type =3D=3D DHCP6_MSG_REPLY) {
> > +                             if (dhcp6_check_reply_packet(rx_pkt, len)=
)
> > +                                     return;
> > +                             if
> (!sm_params.rx_status.rapid_commit_found) {
> > +                                     debug("[DHCPv6] REPLY received
> without Rapid Commit option, ignoring\n");
> > +                                     return;
> > +                             }
>
> dhcp6_check_reply_packet() calls dhcp6_parse_options(), which has side
> effects such as updating the bootfile information. I think the Rapid
> Commit check
> needs to happen before applying the other reply options.
>
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
> Thanks,
> --
> Jerome
>

Hi Jerome,

The rapid commit validation relies on dhcp6_check_reply_packet to set
rapid_commit_found field so it cannot run before dhcp6_check_reply_packet.
If we want early return we can add a rapid_commit parameter in
dhcp6_check_advertise_packet
and do the validation inside it. Let me know your preference.

Thanks,
-Yuxiao

--00000000000003dbbc065afef411
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Thu, Sep 3, 2026 at 2:01=E2=80=AFAM Jerome Forissier &lt;<a href=3D"=
mailto:jerome.forissier@arm.com">jerome.forissier@arm.com</a>&gt; wrote:</s=
pan></div><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi Yuxiao,<br>
<br>
On 25/08/2026 19:53, Yuxiao Zhang wrote:<br>
&gt; Support rapid commit option code 14 which bypass the advertise and<br>
&gt; request state. The option is enabled by DHCP6_RAPID_COMMIT.<br>
&gt; <br>
&gt; Signed-off-by: Yuxiao Zhang &lt;<a href=3D"mailto:yuxiaozhang@google.c=
om" target=3D"_blank">yuxiaozhang@google.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Reject rapid commit option if option_len !=3D 0<br>
&gt; - Drop redundant NULL check on dhcp6_hdr<br>
&gt; <br>
&gt;=C2=A0 cmd/Kconfig=C2=A0 |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 net/dhcpv6.c | 43 ++++++++++++++++++++++++++++++++++++-------<br=
>
&gt;=C2=A0 net/dhcpv6.h |=C2=A0 2 ++<br>
&gt;=C2=A0 3 files changed, 46 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/cmd/Kconfig b/cmd/Kconfig<br>
&gt; index ff90a87024c..b3cf3a6d8b6 100644<br>
&gt; --- a/cmd/Kconfig<br>
&gt; +++ b/cmd/Kconfig<br>
&gt; @@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int &quot;Enterprise ID to send in DHCPv6 Ve=
ndor Class Option&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default 0<br>
&gt;=C2=A0 <br>
&gt; +config DHCP6_RAPID_COMMIT<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;Request Rapid Commit (2-message exchan=
ge) from DHCPv6 server&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default n<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Request the Rapid Commit option (option 14=
) in DHCPv6 Solicit<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0messages to enable a 2-message exchange (S=
olicit-Reply) rather<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0than the default 4-message exchange.<br>
&gt; +<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 config BOOTP_MAY_FAIL<br>
&gt; diff --git a/net/dhcpv6.c b/net/dhcpv6.c<br>
&gt; index 640f089a2e1..5ed8449edb5 100644<br>
&gt; --- a/net/dhcpv6.c<br>
&gt; +++ b/net/dhcpv6.c<br>
&gt; @@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar *=
pkt)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_len =3D size=
of(struct dhcp6_option_ia_na);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case DHCP6_OPTION_RAPID_COMMIT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DHCP6_OPTION_ORO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oro_opt =3D (str=
uct dhcp6_option_oro *)dhcp_option_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oro_opt-&gt;req_=
option_code[num_oro++] =3D htons(DHCP6_OPTION_OPT_BOOTFILE_URL);<br>
&gt; @@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_add_option(DHCP6_OPTION_ELAPS=
ED_TIME, pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_add_option(DHCP6_OPTION_IA_NA=
, pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_add_option(DHCP6_OPTION_ORO, =
pkt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_add_op=
tion(DHCP6_OPTION_RAPID_COMMIT, pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (CONFIG_DHCP_PXE_CLIENTARCH !=3D 0xFF)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_a=
dd_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt +=3D dhcp6_add_option(DHCP6_OPTION_VENDO=
R_CLASS, pkt);<br>
&gt; @@ -448,6 +453,16 @@ static void dhcp6_parse_options(uchar *rx_pkt, un=
signed int len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sm_params.rx_status.preference =3D *option_ptr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case DHCP6_OPTION_RAP=
ID_COMMIT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (option_len !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;Invalid rapid commit option =
length\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;DHCP6_OPTION_RAPID_COMMIT FO=
UND\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sm_params.rx_status.rapid_commit_found =
=3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0debug(&quot;Unknown Option ID: %d, skipping parsing\n&quot;,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ntohs(option_hdr-&gt;option_id));<br>
&gt; @@ -618,14 +633,28 @@ static void dhcp6_state_machine(bool timeout, uc=
har *rx_pkt, unsigned int len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DHCP6_SOLICIT:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timeout) {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* check the rx packet and determine if we can transition to next<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * state.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (dhcp6_check_advertise_packet(rx_pkt, len))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct dhcp6_hdr *dhcp6_hdr =3D (struct dhcp6_hdr *)rx_pkt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0dhcp6_hdr-&gt;msg_type =3D=3D DHCP6_MSG_REPLY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dhcp6_check_reply_packet(rx_pkt, len=
))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sm_params.rx_status.rapid_commit_fo=
und) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;=
[DHCPv6] REPLY received without Rapid Commit option, ignoring\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
dhcp6_check_reply_packet() calls dhcp6_parse_options(), which has side<br>
effects such as updating the bootfile information. I think the Rapid Commit=
 check<br>
needs to happen before applying the other reply options.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;REPLY (Rapid Commit) good, t=
ransition to DONE\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sm_params.next_state =3D DHCP6_DONE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* check the rx packet and determine if =
we can transition to next<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * state.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dhcp6_check_advertise_packet(rx_pkt,=
 len))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0debug(&quot;ADVERTISE good, transition to REQUEST\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sm_params.next_state =3D DHCP6_REQUEST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;ADVERTISE good, transition t=
o REQUEST\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sm_params.next_state =3D DHCP6_REQUEST;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (sm_pa=
rams.retry_cnt =3D=3D 1)=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* If a server UID was received in the first SOLICIT period<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * transition to REQUEST<br>
&gt; diff --git a/net/dhcpv6.h b/net/dhcpv6.h<br>
&gt; index d41a3c30615..49f20390730 100644<br>
&gt; --- a/net/dhcpv6.h<br>
&gt; +++ b/net/dhcpv6.h<br>
&gt; @@ -24,6 +24,7 @@<br>
&gt;=C2=A0 #define DHCP6_OPTION_PREFERENCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 7<br>
&gt;=C2=A0 #define DHCP6_OPTION_ELAPSED_TIME=C2=A0 =C2=A0 8<br>
&gt;=C2=A0 #define DHCP6_OPTION_STATUS_CODE=C2=A0 =C2=A0 =C2=A013<br>
&gt; +#define DHCP6_OPTION_RAPID_COMMIT=C2=A0 =C2=A0 14<br>
&gt;=C2=A0 #define DHCP6_OPTION_OPT_BOOTFILE_URL=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 59<br>
&gt;=C2=A0 #define DHCP6_OPTION_OPT_BOOTFILE_PARAM=C2=A0 =C2=A0 =C2=A0 60<b=
r>
&gt;=C2=A0 #define DHCP6_OPTION_SOL_MAX_RT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 82<br>
&gt; @@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum dhcp6_status=C2=A0 =C2=A0 =C2=A0 =C2=A0=
ia_status_code;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum dhcp6_status=C2=A0 =C2=A0 =C2=A0 =C2=A0=
status_code;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preference;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 rapid_commit_found;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt; ---<br>
&gt; base-commit: 527115ef6783cec49e5610c523c124b399011361<br>
&gt; branch: main<br>
&gt; <br>
<br>
Thanks,<br>
-- <br>
Jerome<br></blockquote><div><br></div><div>Hi=C2=A0Jerome,</div><div><br></=
div><div>The rapid commit validation relies on=C2=A0<span style=3D"backgrou=
nd-color:transparent">dhcp6_check_reply_packet to set=C2=A0</span><span sty=
le=3D"background-color:transparent">rapid_co</span><span style=3D"backgroun=
d-color:transparent">mmit_found field so it cannot run before=C2=A0</span><=
span style=3D"background-color:transparent">dhcp6_check_reply_packet. If we=
 want early return we can add a rapid_commit parameter in=C2=A0</span><span=
 style=3D"background-color:transparent">dhcp6_check_advertise_packet and do=
 the validation inside it. Let me know your preference.</span></div><div><s=
pan style=3D"background-color:transparent"><br></span></div><div><span styl=
e=3D"background-color:transparent">Thanks,</span></div><div><span style=3D"=
background-color:transparent">-Yuxiao</span></div></div></div>

--00000000000003dbbc065afef411--
