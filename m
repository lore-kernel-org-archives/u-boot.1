Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BDDC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 17:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D402E87D74;
	Sun, 24 Mar 2024 18:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IcKWHv5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6B787D74; Sun, 24 Mar 2024 18:54:55 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C12F87D57
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 18:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd8ee2441dso4171495ad.1
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711302890; x=1711907690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfNiQ0NP/AAkVzKYA0v2ezWQBBSB+kts1//QqJGqE9U=;
 b=IcKWHv5zCgVWvL6YfxLmyifKwMg/MwFpgzqGqDWjWQNxDOPC2uew17oQ38a/S7BwQR
 Hii+ms4QXgJ6HDiWTzEzgdF09cB0RDT48BYzDD4Q/P/kQ4TZR2FOI6PNoPA1ugkJF+zR
 oucXPC6czaI8z9xKKthrVXmIZGtM0NE4oH0VJH134xcx4bYqBQvexj4A6UEn9r6oq4+9
 M5wkHGrUCm33XWeOmg4hCG3HbbtCphvYAo9tAzLX2iJmE5ODbh2WOBYMo3IhjiXpna9C
 KesNBClt0n/qSR6Fnp7KvDsCToV94EKw0WhWAy5U9l/ifycGGnQjoRszTA/AjgWzmxJB
 vfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711302890; x=1711907690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfNiQ0NP/AAkVzKYA0v2ezWQBBSB+kts1//QqJGqE9U=;
 b=ZzpTdTvNbDcpSeyE4QwSSwIZPLGrjCEABGyxvZBgdXTVTzkCOS54ii4Cu4+ebXaG+L
 b/Wz/Dpf+p2tUk5p4Pkqj9dA3VuziqezP2NS38wT2fV5zIePgF1lJfHnBjkTbZ49JMhG
 N97V1PMlXOIy07BXsD7SQVStO2cHm5xFqJMn2+YDt6J01JWqZnQRtWG6EtnAtLSzNdhQ
 Wnx0dczobJRc+WxZHeZD9L9Wy7GjJnpdygggTMFWz4Vf4UexUg5dqh6Fgr4diu//adxT
 qNd1vOJXn7BN4LMKsE1orkQx1QLqaax/EYTjccnGDaewJ/LjkJuBjOICoRqG7+lZM5x8
 A4Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ6YRfIY+A9HexCGc1lG8SfIJ0TAa2lY8DbndQUncCjuuTRj6PG3FSMO8FVtAqxCd4hh5FD0nIYpMr1SvAu54LB2kLaQ==
X-Gm-Message-State: AOJu0YxzbmP+UFky+MPi6M4aac8sSBySpWH3SQySUvaRmaAqxTQVEFa9
 I+vI0PIBV2rDW5AmlJ6zJLBI6A1tbB0K9P6/XRpvBxe+99U2GcOGAUfe6F/pOrATD+mKlHG+10e
 4bWn/KQ8N3CsZfRRTaVGqPxTS4Ko=
X-Google-Smtp-Source: AGHT+IGEfZe1H9G0wvGVCy+ScDeXFtYBv/Uu1THqMO3l4mIYCg6tSECYfU/wCUoAFGXv6jDoxFJezedWIoyF6C/+GK4=
X-Received: by 2002:a17:90a:bf07:b0:29b:961c:2df0 with SMTP id
 c7-20020a17090abf0700b0029b961c2df0mr4303186pjs.3.1711302890726; Sun, 24 Mar
 2024 10:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240321071953.14615-1-othacehe@gnu.org>
In-Reply-To: <20240321071953.14615-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Mar 2024 14:54:39 -0300
Message-ID: <CAOMZO5D9Rr2s8wOXkFROfDPTtNeUqQAUudYz4aTBgjjp4wH5og@mail.gmail.com>
Subject: Re: [PATCH] imx: ele_ahab: Add ahab_commit command support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Clement Faure <clement.faure@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Thu, Mar 21, 2024 at 4:20=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> This message is used to commit into the fuses any new SRK revocation and
> FW version information that have been found into the NXP (ELE FW) and
> OEM containers.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied to u-boot-imx/next, thanks.
