Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94667C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232D48409C;
	Fri, 11 Apr 2025 16:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xv5oLFRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA84B840A6; Fri, 11 Apr 2025 16:16:12 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F5584085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5498d2a8b89so2137012e87.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744380970; x=1744985770; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ8/sf3tCsYJ2/Nxf6T7lZb8FW/2XfyqDKTyTVRwQ6A=;
 b=Xv5oLFRZE8zqK/k28hj4Qm29U41bWgoXFV6SUGw6mjUw1U4QUifxTBEXGgtxlt+xvH
 ZwkY1fsdKJocNS8CnYrfSvUBm5RyCVlOXRotmHUZhnbwa1idmEreikFGH7FTkjTZekvi
 KukhKn7ShHRcIWJZbjUAe4ASPBRQrwSzdttZKKeYT3cp+eqzOHyOPD8k2UNo8csFEY7Y
 ArsopVLqZs8JXhQlHR15q0POLBhAg/XOowIeBjnQUxOenUm4umUIVKHbC6kzBUSSxmzG
 WoOxigqJT9BWZ8cBTQ7KBI5uHRJQQULuJtxPo3iOyOy5VsvN42CAnu7+7iShxFVgATkT
 GSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380970; x=1744985770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQ8/sf3tCsYJ2/Nxf6T7lZb8FW/2XfyqDKTyTVRwQ6A=;
 b=qZVfTJe3RHxiIErs3W06Sz4s+H70Da5w2eQ8YN6nzsehy7slQ3kJ4uA5BiYpqKKQDi
 GSkzAKsb2vn8qjoz2J75jY0r3EC+TCmfRWG6ryeyUx0dYEgOK35jj6o3I2EiZLkyecPT
 VY25KkCzKSS1CTel/9F0U/wrNaQENwnNitq7WBstG1swtAgXJ2LjUgVP0+5pY2bzuQqm
 Gb+zsh7DgoGOO8aOu4dEccbmD1+EYrumrXADnNDfwMEVIAOK03Ugs1MfoQ49JJI4oZXz
 S7WhUVm8fiHBbaXzt8DABUBoLKVS/L2GmHM/HywdLzzITlC+cLPjAkwt2FHbWIi49g+Z
 6OqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNmJlbCqXtYcZFA1ASLrjwHLWLwEtBDVPX98cuMPDtRL3eMB0SCAtEYGQ68ibI5kJ71/EqN6I=@lists.denx.de
X-Gm-Message-State: AOJu0YzWuqTUIwAkLuCQIPdoTtrVdf+E448wZbOeN9Tn+cp/Ds0vQvnI
 DKl9ctAP61ih94BAm8J66COiWszYuQ0b03QZ1Y9rqVtHEAAq4iCYn+jVI7a9zE0r44EBJ6NmWxL
 Ff0pOf9UQeTQAlrALYcNReZx+wT4=
X-Gm-Gg: ASbGnctpzxwwvE4OsUNXF4RIDC+vrjXcf0XKtt3UhDDZBcKllTbKk/gcQMm4se+G0yf
 OT6r5RoPCi1Ig8fFkdmi+dopCrUM4ISpIhyqF6Pabys2StYxPONxQV/VCgr2f3sM8JKLCXkinpY
 8QZ7xHgCJ1o9alIoOftpbsMKpLCtCteCB7QIZzmJMhm6WMh6vplmi++NofUsP5madv
X-Google-Smtp-Source: AGHT+IEZnc/i7WxNGTjzqp0PK4Hpp73u20O6lXueQF+9AULhQlX+yTPFanD+mBMRyDqxiEMLFksLRWDATcaYSbCVgXQ=
X-Received: by 2002:a2e:9a12:0:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-31049a80161mr12397751fa.32.1744380969412; Fri, 11 Apr 2025
 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 11:15:57 -0300
X-Gm-Features: ATxdqUFrovZFBN0at25Dmp1yUrnvAGtbVzR-m5XxeVmMJlGJKlDS4BT1XNZzykY
Message-ID: <CAOMZO5ASk4jFop0LAKdb0z41WNhs3qWL4DewdrdsuopM0eYUkA@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, Apr 3, 2025 at 4:39=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:

> Changes in v6:
> - Another rebase on next.
> - Fixed the clock 24M oscillator clock name due to recent changes.
> - Fixed a subject prefix.
> - Collected tags.
> - Fixed the CI by adding two missing configuration items to secondary
>   sandbox defconfigs.
> - Link to v5: https://lore.kernel.org/r/20250326-ge-mainline-display-supp=
ort-v5-0-ea4bc3fc9bca@bootlin.com

Applied the series, thanks.
