Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E601C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 13:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1A987F8E;
	Wed, 17 Apr 2024 15:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiLg6s5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2758832B; Wed, 17 Apr 2024 15:14:19 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE1F87F2A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 15:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5f77640a4dcso248111a12.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713359656; x=1713964456; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpT/48EYVkPEiHZx5fwGcpbn5+ZH9jFD5HNMR7fQ428=;
 b=LiLg6s5dv6tSamj+NRzWfllhFhUOsgtURIeVhDsMZ/MzCVfOpsLfmdHid79WhQCAmb
 PqjDx4vCc+VZbA31WolfDX5fNI6nVunmiLzj9fXFDYnDg0BLzDPEDGcOH05w1kG5zB1U
 BpFP+NO/Y+Gw7w3MAj98wZQhxwXLjcsSXrUN1xxM8kWkqtA7wEVdrPf0VX6r7eFJIzoN
 EXS7QpZ+u5IkQ2AmQfjoQHzSKvCXNtv5adaEg8W32X83ii8bTTJ3d8SeqL030d/0mZRX
 IKZsMwq5v0DFCDccihFy6yi8blzsQKbRLEjQZwK/cSxpejxQd+doL6VVs9G8wCau3Jzm
 Z9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713359656; x=1713964456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpT/48EYVkPEiHZx5fwGcpbn5+ZH9jFD5HNMR7fQ428=;
 b=bt1yo2en4RvcP4OudNi9+aChMLOR3LLv4TrA/PR4Fmty09cU2y17u63U8Aj3OaVYJF
 /mjqlLbvdSQSW1Nz0Mxxb1p7bj5dB0Xti4mpGBV/7Il4vzXls+gAwcZ2H0I/L2GyxF+p
 RmcA0TK5pvS9ShLM468kBv4IY4MpZc8AwX8XbcxZUQ1zrODJnLXdXE8Sv08bnBP6cr/8
 wAWvo62m3KFCRMIk4VzEOQLEYo4W13Th5PSBWUDK6/bYPj3XKZxwFi3SUkMzy8KdhirI
 e9mNaeCQ/tAjkZOmje+9WBEE8B72T+3DWTCAEn/6KXIj71qs+8P64EcgRFvv/bQ4BnGM
 +1fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWagnhfECldJkT5MijXhRk0BJPiapGRhaz2T+DpoCk/DJWJ1HxVZAoWQ8jHzl65PnnMLginQMQRVYji6KTny7gT9ujMBg==
X-Gm-Message-State: AOJu0YzIDR8Oq4wuFomLBRxtBw6miRhUJcA8R2v04XrnpI9gPPlGmfA5
 m/yUYc6Xl/R7hvTJvXmf/4Qc9KXDVSWFjDu/uBxNq/1jKIa/7+5HnjId4DavqYD9A4re/oAmB5g
 5BUkiqpMt3hUROAhey1IxYvMRqDk=
X-Google-Smtp-Source: AGHT+IGF1IpJCAdi0FjtGivV4zBh9u09VdOgKcjXSKHnlyhtcJjmUNU0VYynEWCP0CXwBfJ2kIUtNhhqz8HRY1Zw3Vc=
X-Received: by 2002:a17:90b:243:b0:2a6:d2eb:860f with SMTP id
 fz3-20020a17090b024300b002a6d2eb860fmr14511073pjb.2.1713359655794; Wed, 17
 Apr 2024 06:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
 <CAOMZO5ASD3HuvUMXc6tmStE1AKRheW_NLUjRfpN5HuJ64ZF-Cg@mail.gmail.com>
 <DU0PR04MB9417723DD3E5F4010A2DB96388092@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417723DD3E5F4010A2DB96388092@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Apr 2024 10:14:03 -0300
Message-ID: <CAOMZO5AuwY_zp1a+XNpkyQpO=VTxQ+WON0ZmkcXirgg=NvdG5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 PHYTEC upstream <upstream@lists.phytec.de>
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

On Mon, Apr 15, 2024 at 9:55=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> ok.
> Do I need to switch back to only convert i.MX93 11x11 EVK to
> OF_UPSTREM?

Yes, please convert only the imx93 evk board for now.

Currently, on the dts/upstream repo in U-Boot master, only the imx93
evk board is present.

The Variscite and Phytec i.MX93 boards are not there yet.

They will show up after the dts/upstream is synced with kernel 6.9.
