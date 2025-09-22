Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025A8CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C36083443;
	Mon, 22 Sep 2025 16:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JGCyHMEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5CB8344E; Mon, 22 Sep 2025 16:23:29 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA72832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-57bf912cbf6so1788560e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758551006; x=1759155806; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDNtGmnnGxaP2jX8f2dkyC9vlhWYD4io8sXW/Wmrg9g=;
 b=JGCyHMEx2rPVo6AtsOBtDSTiJ7GkKu+dn8iHSACym7hBDeXdDXtRQWAoMawYFcSZOF
 FRMnrepzbqBdS5ncqwTG+GlEWFhi1jSZYesB2Bu1NLSQKPvVjp9W8LcnqWq9xc5lr0/S
 dcaX942oqVsqGA+M/SsnZvBu5JaxASeQXW16dY6sZfJ5Ufnsamigs8Qp8x0vzRJjlDbx
 TY4+e5M8yv4xfRyndMuiORVojKgOUs/WGiixCKBnbDUWWVWnfwZmP4y/KOAjEcVDnssS
 YLTM4pZn+LJlxrk9jx/pyV2zFNp04Bc0L7I7G5w7A9ydFN088osYvSSV5VSsHlnNgs1b
 dD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551006; x=1759155806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDNtGmnnGxaP2jX8f2dkyC9vlhWYD4io8sXW/Wmrg9g=;
 b=Xfve9QHmfX0t8vT/5i4ujvGNMcHkkj6X1Sgit93HjuPdxukmhCW3FPuDYoTaaM4o9R
 Q9zWFEx/lEB1Istmkw7w5w6bwwxvbdC2VvXJLAb/Nz2vcjFY8BgfYwsGwwkbJYONo9Z3
 cEDY5nTAiC6mpkKOre55LY3RQZ5bNEUAbgIB1HhwGwpuSG4GONflhxwQYHP6AJIKGGd1
 0ocDkhTPJSFFBqCNwOckMEGXqdPTJCg+Chab61WOVY1W4NYVPd3vXmn4KY9KOlkkeLzv
 wz5H7/XI02s2B0S/OdlxQTcRz7Q+ASvV4UmTv3psjOgNPppamh8LRqae1qdD+VeQS3Z3
 7noQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0a7yiA0LzwIALjxkr8NRBuGHAvbYOsXjSzZ8mpBmlHsWREwbrBrVrv3KvsxZ5TOynUXWAzck=@lists.denx.de
X-Gm-Message-State: AOJu0YwtWzHU5PsfJQZmZxLrlfLQ8S4z7DgupQnbHy6WtL2poK1lWqcF
 4BOtnAqSlINVAkOW4xLgwDLB8Hv1w36VpVLEJGutLvpEjbV411wIdFSTXgkUuCtCAXeROpTwQTD
 Af6U8h61IXoubyJP38ZH54tPjNuMwHdM=
X-Gm-Gg: ASbGncs2xW1tBsrMb8OXH/eOYErLXcXo6rNJ1IkYpZIn73lMdGotYErxaMm7KhHZ3p7
 WgxK1XUFbZ5GWBINyZpO4OQgHX+cq7aaYDE4Pq8xDvFDATlPxkHwgGDEYLxfoNQUjuVKetbgx+Y
 42xFupFXrLJolYJDOIGOdL4DEF6EbsIn+H/HZ8Gzm23av/kvwePZCJOLtpirZEDi926TZBibWQU
 x4qsgvF0Hhf8WQCkckOJA9GmORyLz8+uV0MoNs=
X-Google-Smtp-Source: AGHT+IHmnMgAw4UUfNF79T3xQSAOTb8A7w+/R8UxpNI77Ns8wW8HjAytPHU1LCP3othbznpbFqNSCYU3faA9VhNJ6Qw=
X-Received: by 2002:a05:6512:3a95:b0:57b:6e38:654e with SMTP id
 2adb3069b0e04-57b6e3871d9mr3070893e87.7.1758551006382; Mon, 22 Sep 2025
 07:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
In-Reply-To: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:23:14 -0300
X-Gm-Features: AS18NWCEIWXxf1XEk5G_pp4r9URHah-kea3BO3xEauGoY2cIiFxw57O5ASPkVWw
Message-ID: <CAOMZO5A2f6yS+pgsYxwHLAx1-tmjxko3JvfN57OsUY0V+Wo3Dw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] PHYTEC imx8m boards: enable OP-TEE as default
To: Yannic Moog <y.moog@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, 
 upstream@lists.phytec.de, Benjamin Hahn <b.hahn@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet <j.remmet@phytec.de>
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

On Thu, Sep 18, 2025 at 3:14=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> OPTEE config was unset by default and the doc for the boards was not
> quite accurate as TEE configs must be enabled first in order to be able
> to build with OP-TEE support.
> This series enables the config by default, i.e. when wanting to build
> without OP-TEE now, configs need to be modified.
> Update and clean up the documentation:
> Change instructions on how to build bootable image with the new OP-TEE
> related changes.

Applied the series to -next, thanks.
