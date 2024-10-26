Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186FBD149F8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520888FBF;
	Sat, 26 Oct 2024 02:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlvorBk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C5688730; Sat, 26 Oct 2024 02:20:52 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9B388730
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53b13ea6b78so4261949e87.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729902046; x=1730506846; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHQBzT02nk2J/ixR4Y6YJ+YgwteJm+H6eFM1hzkqTmc=;
 b=HlvorBk3ATFRLDFav4S20lh7vDlKwQve0VJS2CrhrslL+4WmqTbQjDt0tNdz7dvJLT
 NzBBel23h7F1e6OVhAjh61UCBOV8gQ/WfcWw0OEbZcM8X33chvpbfGU8FJ8MREu8iRRO
 gcxw7IRJe/jGo1wZoX4BzaDPevDelGqO5UrqafNxQWZ2/izVj9Jp1m8Y3jkkcrNj4NKR
 tvJY3zxvbrcH3FInCfB9FyJFqTop1HG/JKwNuLMzJhZRKflYtJSmCwhgLa0/OghFnL0V
 vyQdDhLb61fmooD5IKdwXqnQBkVwS1JivwzbW53k47bVFHGOoMe1Z9KG98C4HP0ijDcH
 tmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902046; x=1730506846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHQBzT02nk2J/ixR4Y6YJ+YgwteJm+H6eFM1hzkqTmc=;
 b=qe8xJPEHCpTCVnN1w4wU9VyTbRKHciDutxdakW3VCJrsG4LDNufJpM/ll3kygjZFIw
 egt3Mr/2evzbN/bIrAcFcL19rB4JYeiStErSSLDnF4JTSCcsKm8dKvcWxY5bmT0U+hdf
 1pAp80uM/lNnzkhYDgrPYzJ8U1uzbvQzqyrpu/H7/r5R+sY84rOlctrTGoPRHzuMsEy5
 Nbm/VS4LsB/huEtsPkJjoxIjc+C6gvyy+jRd3HG2nJQUBTqmlUtBCUyYifWOY8tvpmdK
 Yrs4eRD8lSnrgPdbb0+YiqR+Q/+xiTberzOyKFkfRKnwL6S/YZuPXz2v75qgF8uI+2/E
 dDTA==
X-Gm-Message-State: AOJu0YzwpwhmrBJzpl2DWuWwmXwCpTjBaOp5vZylunSc9xB+aBzEDwty
 9s6N/q4GRZ/votVQ5hKzSXovYg8pmMF/Duu3TYOxtXZrFcF28uivQ9NsGuuqVdYRCjfsDtMWCDP
 8xX+JyJizMUi8VqmlyR1l5ToF8CI=
X-Google-Smtp-Source: AGHT+IHoIEzuf2hX52flJKlTyWQRdfXnHatI8igggTra9KOPWA31azXe8Tl6QkS3uKy8zaoBJk2CvDqw6Mw3HtAj3qQ=
X-Received: by 2002:a05:6512:308b:b0:539:8cd1:848 with SMTP id
 2adb3069b0e04-53b34c3f9e7mr588632e87.61.1729902045887; Fri, 25 Oct 2024
 17:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241025225602.114784-1-marex@denx.de>
In-Reply-To: <20241025225602.114784-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 21:20:34 -0300
Message-ID: <CAOMZO5AgHkwd84_zT1DQbEtDJ51mcLqR5HeaAzW5=mRhbN1T0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: imx: imx8mp: Enable DM regulator on DH
 i.MX8MP DHCOM SoM on DRC02 board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Fri, Oct 25, 2024 at 7:56=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Make sure DM regulator support is enabled on this board, just like on all
> the other DH i.MX8MP DHCOM SoM based boards.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied all, thanks.
