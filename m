Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A4D32D8B
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1381289215;
	Tue, 12 Nov 2024 11:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yd17DxFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19468893B6; Tue, 12 Nov 2024 11:40:15 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3520F88B9F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so45575891fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731408012; x=1732012812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek1SnbCqQq1MbWNqXiVwTdKJnSCEdMZgNsG6jicryoU=;
 b=Yd17DxFVd9mCBT3udjlbSSYgto/pBPnk5f/JMSjJIHmfJCcHqk1DDe61GV9LfQ2NU0
 gQ374CxmqFaS2S/o7P23TWIVfzx4bc2wSJwozhG4rp+5PFro3ylWWOJ2f4UxdWV4Cebq
 PqYqNMmGI4iyVXSBIxqArI6JoNgbCZJGlqAo7gpt7DMm8qnT6sKl/9vrPhksLzjibhfU
 MKgBEal/eUaFg3LqYF34mXbciRW/uVfMKJAWGp5L+cPmGzdqRhlRYBPPZlHjlv0HJIAS
 ggOIRLBHk+MtHaDng9dYvEwJ/u8mdC7mxZ12SGO8NVEAaOR2+dalicO1kPdiAk3NtFo4
 mM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731408012; x=1732012812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek1SnbCqQq1MbWNqXiVwTdKJnSCEdMZgNsG6jicryoU=;
 b=KM3vUzSQaFvIKUzZFxXNAZKlWZXaqdPGMJjlGqmmpILx/PMIE7FE+uHnT5gTcGjyce
 x9SbiAbd4U8b23qnuZg67I61HgpLgWJ6hZ5KE79MMnXX5M1TrEGb/1saz/v8LyAG3cuB
 9bdtBiVLF4txh/6v39gx1RvUO0R3EusOGKOXESjzHU+bVF1PhF4Lo9Mc3kU+cT7I+TiP
 Nk9Im8yNbBodyba8VZmd2tz0j6wU1x5nsTK8fLRLmnkjUdJbJcSvtjWoSKZveLoRA1D7
 jaaeSJK2ChRb14Tpxx0XH/bhPPhZHd7FLXSwcYrislLgeX0PqEZTDCcCebsS86lM4T1t
 ceOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMof7M/fDnsrF6lK+3T8Rv6IkFjvQ70I7H3q0SmqdRT3JEnWP2FmgLLHKfNeYXlemMkriHJmA=@lists.denx.de
X-Gm-Message-State: AOJu0YzelGkChlPzw5MbsJZhBZpK64EA4M/3RpRKZXsUag5UqTv8X0d5
 hWF2f4QrLcAWmTGtmIRu6VkjaPyNCdizsfotdOL4oknDZobYAUe3gtaHzsKwWqTU8+fXQtutlfH
 i5onyEDkVSXESN8IgHhauJSvk2Ps=
X-Google-Smtp-Source: AGHT+IFeAk1iZHXXkec5hen2+3Pim75DXa0d8GzjgOV41+g6UIpCXMhU7lJ9Na3OD+8/ILYU1RB5+hAUYP1iJKfMefs=
X-Received: by 2002:a2e:9b11:0:b0:2fc:9550:d658 with SMTP id
 38308e7fff4ca-2ff2028c40fmr52213341fa.24.1731408012134; Tue, 12 Nov 2024
 02:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20241112102415.37335-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241112102415.37335-1-heinrich.schuchardt@canonical.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Nov 2024 07:40:00 -0300
Message-ID: <CAOMZO5Afp9R_BHVv5Y72YUpRjrLpS083fs_PUenmLv95qHNEAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: add 'nvme scan' to preboot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, u-boot@lists.denx.de, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, Simon Glass <sjg@chromium.org>
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

On Tue, Nov 12, 2024 at 7:33=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

The 'configs' in the Subject is too generic.

It would be better to add write:

sifive_unmatched: add 'nvme scan' to preboot
