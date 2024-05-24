Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374BC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72ADA888FA;
	Fri, 24 May 2024 19:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T/DzyHfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9414D88640; Fri, 24 May 2024 18:08:12 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E4F8800C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-df771983aedso1056129276.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716566889; x=1717171689;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN5cmpiiY6R6rKvvjUzM3RoEA6BRaf4FD7DzR6UYyWY=;
 b=T/DzyHfxVGUx+oIgp7QzrUumXbWpSYL1WnMKRUhTmW1PLd5E4BcHiI060wxnruUBkE
 jJutiZbHG8QgDJztJuyawfwnn1Qr+61kbKuU57vZuf9uu8+AP0uruIiXKLP54RePKQhA
 5QrgONpzeh7bUGdiwzXSc1H3ON7h6k9Kbl2ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716566889; x=1717171689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN5cmpiiY6R6rKvvjUzM3RoEA6BRaf4FD7DzR6UYyWY=;
 b=ltnXIhUMDxsrIPV/NIBgH6hqKABYIvda+MDemk5do5NvdGZbu0wGtyyqDsfVusWisM
 kOGPpTDX0FiuJA0al3D6pAQ2wOqBGeBDpeZOzRXyLm9qbhtPWS6A6YI7AHNvclV0L3oc
 ZegrhJMzt2/oNnf9N9qIfLR5fa5q+k42jrCOvBfIvdm2BDXzdS2MT/cmYzDIK5LiKUd3
 QnyhXCQ32wzkTkQpsEJlXbImssc0W+tKZ2IcPbm9Yc/G08tqYUxwbwoP+1BB+Ru/xfWB
 h8w5ZwJJrhK7U7n/XbQGWyrqkX98OQx26+Iz51GX57CNRU8WGNYVf9CNvfzhW1aaBn2E
 UU7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM1iT5NQt0d26yNn37f2UDIPkoCXMEwMW+TT7sTJqIgIJC2SOweHCIOiET91GQMm0uoG3JJkfaL+HO3nPqcwQmJ7VZxw==
X-Gm-Message-State: AOJu0Yx8UmR/1y4M0dQtE3CU625A5y2/Oa9VAKosRUlLoYP5FmvfHSSu
 HtfXGvNQ/B2doO9zilT+hgnKG76rtx9/uaXoFcQwxBV1f9YMJeTc13qihkJm2KmcmEiUTwFtJac
 bGQfBGhRI31EKLN1ncaaBX/tlJbBTDZ1lEB6j3g==
X-Google-Smtp-Source: AGHT+IGnS6DHTyExLDX2UbOG3WLrZcNFjwU8fdDtIfZy+geZQYugHqnhAHJVZUvnzESy/BaXbe/4vW4cdN3UhzW2TCY=
X-Received: by 2002:a25:c749:0:b0:df4:5660:42a1 with SMTP id
 3f1490d57ef6-df772167957mr2870268276.1.1716566888865; Fri, 24 May 2024
 09:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20240507154836.GV2568172@bill-the-cat>
 <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
 <20240524152646.GA2568172@bill-the-cat>
In-Reply-To: <20240524152646.GA2568172@bill-the-cat>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 24 May 2024 21:37:58 +0530
Message-ID: <CAMty3ZCyNHYC=tyWZap5CDRnFos-hK1U68AFdPGv3jMpWct2TQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "git (AMD-Xilinx)" <git@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:29 +0200
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

On Fri, May 24, 2024 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, May 24, 2024 at 04:09:00PM +0200, Michal Simek wrote:
> >
> >
> > On 5/7/24 17:48, Tom Rini wrote:
> > > On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:
> > >
> > > > + Tom Rini
> > > >
> > > > Do you have any comments for this series?
> > >
> > > Seems likely fine. Jagan, do you have time to put this in a PR for
> > > -next? Thanks.
> >
> > No reaction for quite a long time. Can you take it directly to next bra=
nch?
> > Or do you want me to send you pull request to get this to regression an=
d see
> > if this breaks someone else?
>
> I will (am now) taking a look directly, thanks for the reminder and your
> patience.

Will clear this weekend, if not if you are already on it. let me know.

Jagan,
