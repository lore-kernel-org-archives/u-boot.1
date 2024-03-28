Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4325C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3433287B89;
	Thu, 28 Mar 2024 14:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4iMe7NL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E91F87E9D; Thu, 28 Mar 2024 14:08:57 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D39879E2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a1f8308532so177034a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711631333; x=1712236133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTI0q4pn5EO0ctQ2bpOtY6NfRZzBcQPr3eFkMtxnFes=;
 b=P4iMe7NLqbLPWijOfnEDTEIiKKiHraBTMI71tVjYPjyvJYFvbv76eOeHeY3+n4q34/
 ZrD2JzZWwX6z6xRjv1mZX4c++Oadph8K4OiLuztLaT97TSJGg+1uxG15w8xrf3KkwHMQ
 qtfliWFR/xYDzp3wjd4nf/3g+Df5QeCLBmIY6SE2BW0OSQINA1zOcMHb1knVpS/Hw/ws
 JKnyhuQHj0wme7SbEh2n5hiVdtoVzV2gNAbHZ1aWEJEqvSgTdB9kpBSzZVvKxu3SjUx2
 CpQz8s4J7wV43bq2YvDHp/lOiYo3Zgo1EH3YQsT1lJm3WE0+1wi3fb7BBjcGGUWKZWG3
 LJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711631333; x=1712236133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTI0q4pn5EO0ctQ2bpOtY6NfRZzBcQPr3eFkMtxnFes=;
 b=hmbJNdl0VspnNcAz0zyU++Btw5PNcTq+Uqcj8bNE6MLIkm+UpErhrukiOSE2LfAl4b
 MdP1a1C+brwnfNXhrtrf654RBZAbL82yyYNGGq83dilB32fFnfa+HdsHkeH+t1C7k1Bl
 QAizZhywjbYJmC0bXA/GqxhNXzZFWyUzDg0H0y6E3Gra6F1DSfcHLkSc6OcDje5G/+yP
 76hJizzuiDXnWXdh0x2XLvQe9hZQXZYhU+pUCCyKoWxPHG1BeL3bnPK05HYwLtcjrVp8
 cka41bclA8cSsRZ6AblRvdH1h7iE3I/Xybb1A7Z7yKB7WHzPG96UEzy+YASYm2pUDJyq
 ZEmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/y9cuR9WIQh8rYNblmB5Zm96wqVMFNlsBRbGd6LkiS5x6qnI4g2fi4ctbwxZJNtctxe59MNl1lqKbA/EJtOx2j4nKrQ==
X-Gm-Message-State: AOJu0YwXhIzBFOJvuEbvlY07/mAsGvflFfeIZfjGeqTcx087lNeDIolW
 x4hT7XSZNp/DpyFhfgyJw/VOepWTTOerLM5y8hBjO+XMr3odCrZ3Hb+FOe+5jSQxvtrM5fS4izN
 NQD9wNXWPNk1bWxu2gbaqmIaZVkg=
X-Google-Smtp-Source: AGHT+IHdD4wGThQBiJ11II1hXjhZLwTrggUuD1AavLSBJh0qXvDWLZqBYl0G3//PWLe8bpAlyJ6+dwGaaPiSCDc2yMM=
X-Received: by 2002:a17:90b:8d0:b0:29b:fab2:8a24 with SMTP id
 ds16-20020a17090b08d000b0029bfab28a24mr2498821pjb.3.1711631333076; Thu, 28
 Mar 2024 06:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240328122116.2460855-1-festevam@gmail.com>
 <2fe4eeba-c805-4dbb-a07b-9eb9382c019c@solid-run.com>
 <fd3c8cd8-ac4a-463b-9f55-def931af77f2@solid-run.com>
In-Reply-To: <fd3c8cd8-ac4a-463b-9f55-def931af77f2@solid-run.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Mar 2024 10:08:40 -0300
Message-ID: <CAOMZO5C7f0TqGpp1mE0pHjTCX3JFHCkhKwAw6K87Qfq4_ifGxw@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
To: Josua Mayer <josua@solid-run.com>
Cc: "baruch@tkos.co.il" <baruch@tkos.co.il>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "cgmeiner@igalia.com" <cgmeiner@igalia.com>
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

Hi Josua,

On Thu, Mar 28, 2024 at 10:03=E2=80=AFAM Josua Mayer <josua@solid-run.com> =
wrote:

> I suggest changing their status to disabled, and keeping the nodes.
> >> +
> >> +            phy: ethernet-phy@0 {
> > This node name is shared with upstream imx6qdl-sr-som.dtsi
> Give this one a u-boot-only internal name, maybe ethernet-phy@ff
...
> Just disable the u-boot-internal phy node unconditionally, or delete it.
> Because u-boot DTB is synced with upstream, the code below will update st=
atus properties
> for the standard etherent-phy@[0,1,4] nodes used by Linux.

Thanks for the suggestions.

My imx6-cuboxi board does not turn on anymore, unfortunately.

As I cannot test it, I am not comfortable doing the changes.

I hope you or Christian can submit a proper fix.
