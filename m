Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA95C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF8787E06;
	Mon, 18 Dec 2023 12:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o8M0Nqwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8153387E06; Mon, 18 Dec 2023 12:25:53 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCFC87CF5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e6c8b70766so4536417b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702898749; x=1703503549;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EguggACRFpvg5l2wHrBnGSod6NA0Ol1sniMhUTqYZjQ=;
 b=o8M0NqwgvgHn311JmZcRTH5Hk5hVeiJLbr8BcIi7fr0JFRNntZIhl6k7lcN1cLn/xp
 lbQ7BjiPvVOrY8KmWPH+zSfuWikQW5Wotjajwg8Vv4aImlXv/Ul4Y8Ss5LyLdxhDyxRB
 b8v98v5cagB0cAXYk20l0e7ZLmdkWvxPP41wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702898749; x=1703503549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EguggACRFpvg5l2wHrBnGSod6NA0Ol1sniMhUTqYZjQ=;
 b=C1Tk4SAdud0g5LcJmRbWSWRIbgCioIUPio0w9vCohEkzZm5ug4eZBpaX4uq6ThcZ4l
 zy26VZM4lbDXLcH1AYAQbmbSrgLjhJOU63cWI2ZZExkkU+5g7M2+U3Nmb364izQVhmv/
 Ypncv9Lu8nzT3d2pJqIkb8EqjPK4HdbuLl5vKDVyqdTykvXrs7mkS390drFIEb0theIj
 8EyPSQBOx4rXoQsPGxukxm3WdEhTMofwaafYO0OReuWxh9PAAnppYgv/cBXI5l8Ego2k
 J0VVaO+xp3IV5l+PPq3tfsHeYXhlTIxsYzN9j1zj3CjrXIzWBQjd9WYTbiAEELlqbp2A
 yfoQ==
X-Gm-Message-State: AOJu0YyeaBafZKsdG0ZtuEGdu2sdydGOAOCc4HS23c3IAKQTTQftzWKG
 vO0QnAnwRHbU7dIkX0DBSD7Y/AoCRgYWq21SHLirJQ==
X-Google-Smtp-Source: AGHT+IE/602lXq0najyy7bciULalgByvI6Yu82FK/4DSn8PmOf/e+qdrt8BXDOXUeJDyH9IS6FfiY0xK+W1938QMneM=
X-Received: by 2002:a05:690c:2c91:b0:5e2:5d81:3c0c with SMTP id
 ep17-20020a05690c2c9100b005e25d813c0cmr5964470ywb.60.1702898749283; Mon, 18
 Dec 2023 03:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20231027134924.5771-1-bolsh@synopsys.com>
In-Reply-To: <20231027134924.5771-1-bolsh@synopsys.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 16:55:38 +0530
Message-ID: <CAMty3ZAW4gqQsJaXTY0NsAHwzZv7QMCu3A2E3SKCDB318++0pw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi: flash_is_unlocked return values fix
To: Stanislav Bolshakov <Stanislav.Bolshakov@synopsys.com>
Cc: u-boot@lists.denx.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
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

On Fri, Oct 27, 2023 at 9:22=E2=80=AFPM Stanislav Bolshakov
<Stanislav.Bolshakov@synopsys.com> wrote:
>
> In accordance with the name of the function 'flash_is_unlocked()',
> it is implied that the return value will be either 'true' or 'false'.
> Moreover, calling this function from other parts of the program is
> based precisely on this fact. The value of the pointer to the actual
> called function 'flash_is_unlocked()' depends on the memory manufacturer
> and can be stm_is_unlocked() or sst26_is_unlocked(). These two
> functions have inconsistent return values. This patch fixes this
> inconsistency.

Missing s-o-b
