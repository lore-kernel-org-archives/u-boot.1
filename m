Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17F7870FC;
	Mon, 18 Dec 2023 12:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Wp0iD34r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A35871C7; Mon, 18 Dec 2023 12:36:48 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA1587076
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e7415df4d6so715877b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702899404; x=1703504204;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZY5dHkSbKe8BdAK+7yeLiiNClGhn4n5TpSGDc/jzI=;
 b=Wp0iD34rkGozSvXC9RaAkFf9aqPl4MvWpLnKxe0CjNZ5P9YJFcs9JGOUeilbWtbmkg
 wpS6/3L+TDQDjN5Z4RTPUvQ7lQaYESug3fn3bfkag11f3PIjFL5X3rxb5PJdQJ/CLHI+
 j77PcbgGPGeoLJkQZmr3hEI/PCRmoNpCWTNg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899404; x=1703504204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZY5dHkSbKe8BdAK+7yeLiiNClGhn4n5TpSGDc/jzI=;
 b=ss5rLDXH+wmSDsUhw/QcK+QARJWdInYn7T2KhYUcHF+vHd2rP3Rwt5JJF8wd32yTy5
 GouUyzJ21T+6AOL38gbDkte+PuSZZPEy3HHjdiWsQnzPfK744BWawGkL5f8PVacGvkJ6
 jo1ZY14Wh2y9mk73AMwE/91+ufi/2GHG5+nkjKWnHeFT++yeUauwYwuArT0zrWheJxMq
 3O8p4M6VTCwyonpUqvgVOJXVT50f9UpxOyc76juH8oC/l4hPk9ZU5RUqUPS+/BS5PdfC
 +hCqTmk7vR3RdlHjnxbolTc0o00O4l76M7EC82nBoi+hNroDu2itnEsc98fzKByMvj64
 GXzw==
X-Gm-Message-State: AOJu0YwGnWfoqmlmAckDOADgL/4oCoou6K5eHy+AK05GckCwLXAWxuT0
 /0NFr3p1O3MnllJ7SuCcO7hX8yzJCmuOnqOQslOxHA==
X-Google-Smtp-Source: AGHT+IG2dNwICfk8S+/oZlP6ZP5SuLJt2ksWQx5f9gWLgqHQJxdmgpfw0LknsF5nDKSu/EIxqV/PmvQIpl1ZkPudH0I=
X-Received: by 2002:a25:ce13:0:b0:dbc:fbba:2e6c with SMTP id
 x19-20020a25ce13000000b00dbcfbba2e6cmr3061652ybe.45.1702899404644; Mon, 18
 Dec 2023 03:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20231106052438.12903-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20231106052438.12903-1-venkatesh.abbarapu@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 17:06:33 +0530
Message-ID: <CAMty3ZBan8u-Y-UpABjVU0DcVu2ZRP_LhOkV3Bu9M1Unx770WA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Update block protection flags for ospi
 flash parts
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
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

On Mon, Nov 6, 2023 at 10:55=E2=80=AFAM Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> Updating the block protection flags for Gigadevice gd25lx256e and
> ISSI is25wx256 OSPI flash parts.
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---

Applied to u-boot-spi/master
