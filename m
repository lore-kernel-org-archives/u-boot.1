Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBCEC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42EA87D35;
	Mon, 11 Mar 2024 16:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hRt+e3qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B7387EB2; Mon, 11 Mar 2024 16:35:50 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9761287C48
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd74a009bdso8081425ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710171347; x=1710776147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3Dbf8Eb+7e6hFU/E30WWc2NGXL4OPvBChKFWgFN7x4=;
 b=hRt+e3qdzibuAEd8xdBCrnMEPI3NYVM+EHVsuFrv4G5T3h8OCfWIFEVJYxBewK17zW
 mTw5bKaSP24UaeGN/55Gf8OCUMOIx7ZD3HAIQt24SNjMDj3jStpR49hoGhFxIf5ZpJGx
 w/gkYrmNBHNy76e53yqQNLtXE1Rr9aSGn9Ox00VCp9GA9Khg8ekwJGAFrLS0Z3uvi5cn
 SeXSb6wfoySZv8Zngr6aTgGKlEtKb+LeSZOIDqS/v4ZkWd4iA9Ppf2JJfDx1ISzrGhTn
 9wUB+tbMJCU4u0yfsL+eYN4dGzl6Vu+0Y6+HivAsfskjo7Sgh63yb+lbeAojz1TV7Auo
 AB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171347; x=1710776147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3Dbf8Eb+7e6hFU/E30WWc2NGXL4OPvBChKFWgFN7x4=;
 b=Tf0EWNaVSvoo/MtrpHTt5pOvlyVNEs3OfJl4+izQ8YHf2K+JTqCnDOIpRzWJlvnb3+
 7PESrq/XxYXMky3JrRP/C1/qrnHx9jkz5U5OGKgPa+3aFLlEGIIblJ/LjAp1eLs7uMHU
 WrH+AXPXMtAyNKMa1LyMJ41fW8eVK86zvGioU9CKGCNBrUI26lmesw/MB23mgQg/qS9A
 qa/mNGaus7CBesJaTiP8bWI34UL0uVBjymKO7g18BT6gsxlE9dVRwi1ta3AedEIWpuNr
 wANc2vSI/5gONihVN86yHZzFvukLTfZ2bfT5V/kvbQn86PAdhrZJ35E+UAfNqgy/6fsx
 d+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEymyG4+OjktFDEqPrPhuTl7y0n+5+jIC76+hCYBOuj5tX4UzDlJR60qr3kzPVZBpAugq/nreZzhgvY/fB4KNlBy0nOg==
X-Gm-Message-State: AOJu0YzK/4JwuPvYI4WSPfQsBLbuvEJgSDFN8UZwcuWUPCGthHghfcLY
 4qpRu3XXU78x4ANiVcQHR70BzDOL6Jyv2PsjycA1z7wo/CrhK4uPiLTdpuGpCLEqxMzPLC2LGjp
 AaDIOT/1NkwN/IJA5hRrjvy1k/Uw=
X-Google-Smtp-Source: AGHT+IHnsK4Eyoxme6PrK9SRjLA5UUY/N6aQwcCdK2k5BqrrQrrswU2N95Wo0DG0VL9Mdd7la3cr7FrrHOUww8G+0xE=
X-Received: by 2002:a17:902:b193:b0:1dd:582a:bb05 with SMTP id
 s19-20020a170902b19300b001dd582abb05mr7378180plr.1.1710171346844; Mon, 11 Mar
 2024 08:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
 <20240311130400.4023780-4-l.anderweit@phytec.de>
 <CAOMZO5Cm08dpaEdRSZkj8khP3T1HySP1fqKM12cOF4XSr7kJfQ@mail.gmail.com>
 <f35b563652de6337603d513e294d8cdeb7c73744.camel@phytec.de>
In-Reply-To: <f35b563652de6337603d513e294d8cdeb7c73744.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 12:35:35 -0300
Message-ID: <CAOMZO5CcxeoO-2O8=_GfOMRBwmOLTPUWxxOo0B1ZQK5Sby-oBA@mail.gmail.com>
Subject: Re: [PATCH 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
To: Leonard Anderweit <L.Anderweit@phytec.de>
Cc: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>
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

Hi Leonard,

On Mon, Mar 11, 2024 at 11:32=E2=80=AFAM Leonard Anderweit
<L.Anderweit@phytec.de> wrote:

> I also got an error while applying this to next. To apply cleanly this
> series requires the commit 19f657600781 (configs: Resync with
> savedefconfig) which is on master but not on next.
>
> If this missing commit is intended I'll resend this series based on
> next.

At this point, the master branch is open only for bug fixes.

This series is targeted at the next branch, so please send a v2 based
on next and I will apply it.
