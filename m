Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5E3C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF0488C13;
	Fri,  2 Aug 2024 21:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+XPYqBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A3588BF0; Fri,  2 Aug 2024 21:24:59 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A96388C02
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so1525227e87.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626695; x=1723231495; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQVIrFWMwH7UgRaU9SABd1mzkvIu+u0Rt7m+ySZHJtk=;
 b=b+XPYqBliH+9ZuuTQAyWwDM6i52aQM//z9Gg1hbJRxEtlWTHiAGSq9Km8R3Vf1x8gE
 QH3tYn0r5/2e0ZbRVdDUWz32nUKUsPhtZEnJojfJcoI9C55UR2HabYz4ivFWMgot0c7E
 CPxzgxrlm19ZNILriXGjZ7lQzj9P/UFOP1btDmPU7b8059Sd+Dsfq4D7pM+x2QskNVXP
 K1nfsPnli7yhyXrrUQqSTUyhRLUe/3/ZoNz0pgPCi9zHz7CdD71ojna2nvtbJjbqVXUx
 pz5WF6WWMvf0tQpfMtpwdDGXbBf8DjKO1KS1lwyBp3eo8miKZKNsEUIYQSRNrg4E55mp
 PEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626695; x=1723231495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQVIrFWMwH7UgRaU9SABd1mzkvIu+u0Rt7m+ySZHJtk=;
 b=pok0hYlM/RKdIcsdEE6JbxilggcdgD9/0s6aF5jb3/it02hVIdcLtjglRwNLhM9FQH
 rC90JYeo41j933uh+ithYDJFl+0pnQq9oUwI7yoef+41oFxwapJK9xxM5mBxQKa4BkQT
 UC8RSjZuAOaW8eGhCRXVlDn6xkhNGa4/tUTjEz3gosVYa/eRs2ZxpdY26zIFc06AHvZB
 yeIrGQLRwXzKKQZxydAF0TT0KFjrJpj8SVHjwBBQTDvyaUMp/2Db5j8q1689310w/hkC
 KIv013zj9X/HxgYQL2PnQKf7PWXontckhT+uiCz+VeqNwqdEzI7wQDWnW7L1aeDpkO0s
 TBqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr9K0f5fjD9dFSg3plOPNrcAXkDXir7sfjLhxxOHbqDpCqobuDkFekzafi9saH/zQGCG7Iw8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzKsfUZ61HjMfLzuDKUCdlWTXr6B6Ihb79EAFx/cLn2AtP7i0Rp
 vIWUrcZs2pcqu6+U3MTtDZuIYExBrm8k1dC2IuEPb4I+K2cV6E+Ojlbg4pj73Njg9ChKmxahbel
 W7L2gQCjU6YV9NR9Z7osnvwTegTx51w==
X-Google-Smtp-Source: AGHT+IG+/Pm49vLQ1Sg7jPdKXDG0w4rVyuGYfbDUR/bIB2WczS/1ctKryJpA/TznaKYgTgV/U1sQxb7ElIlWONHMYbM=
X-Received: by 2002:a05:6512:acb:b0:52f:cfba:403c with SMTP id
 2adb3069b0e04-530bb36b64cmr1722993e87.3.1722626695211; Fri, 02 Aug 2024
 12:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
In-Reply-To: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Aug 2024 16:24:44 -0300
Message-ID: <CAOMZO5C+W_fA2j-wbYXmnSM2KQCjDgkMNhNMTc8_0Ju9tzZVzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Enable CMD_ERASEENV for Phytec imx8m boards
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Wed, Jul 31, 2024 at 4:23=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> Enable CMD_ERASEENV config option for
> imx8mm-phygate-tauri-l,
> phycore-imx8mm,
> phycore-imx8mp.
>
> ---
> Yannic Moog (3):
>       configs: imx8mm-phygate-tauri-l_defconfig: enable CMD_ERASEENV
>       configs: phycore-imx8mm_defconfig: enable CMD_ERASEENV
>       configs: phycore-imx8mp_defconfig: enable CMD_ERASEENV

Applied all, thanks.
