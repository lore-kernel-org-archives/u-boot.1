Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5FAC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 12:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D42A787D9E;
	Sat, 27 Jan 2024 13:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8FkvuQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB0B87DAE; Sat, 27 Jan 2024 13:52:15 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB8087D93
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 13:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so334696a12.0
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706359931; x=1706964731; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSaeeK4676k/Td/ON4C5NjrO/rdAccyHGbIJmdGX/4o=;
 b=O8FkvuQjOwnILTpktGV8hjm1sUcPkPu6twhDRIFB+pZqfrKRwvO/jy1NbqOQ13z1H1
 ICshgG1RMs7UpccjmWdSfViyMOj9DTavYiGEjBQZXlOpu4wdY6+xWCsJ8Ho0oID2bpXw
 A3NYjnbKBuYhXl7spEJ52u6y2Ph88J96AagWTPkajfV5jDTXu01jtYWt4NBgV8vQ+A7K
 wO/LP7WjqqJr5fWONOlKJSxpy4ZmKr/EPoSUQcINnzBCickjbONFiSKuJxoJhYXUZEAp
 8SNFMdXRPggeQVLAF6C5qrsxKXPDRvJwsj1DFJAk8N3K0F+9ooR+z6Vzxodn9OxsxhvM
 UwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706359931; x=1706964731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSaeeK4676k/Td/ON4C5NjrO/rdAccyHGbIJmdGX/4o=;
 b=QTOjWmKZLgXQIaa8EKxFdoGJzmwEXRI0EgEVz/CV1GAQx+WJgmE1TCFdh2Fw9c5P4q
 SQQ1CAPEJhnQwdruJtTVua0nAzHj0/EaHt4wYgpcQFILKfQlwso1UR2zkBphycxeqmqP
 YBV/qGq5NCcvaCxqzljViqYWiBNI2JxjbNILgsrgXD2PpzBfky7b8abja4lbM6TJaqq/
 r7bzVDGI5TnnOTqbMEMeJ4HLjxciLrzl2smb3+Ea6QltthmzHrpZJI+nQAw0Jg/eCdBf
 lLTEiRQ5FpnvHS2bZtCfOnYEVi7tANSLgM3EFCJDBpzy5ydg0742aAbbD0ODcIESQ1ZP
 Xs4A==
X-Gm-Message-State: AOJu0YyM670h8RB8km1lwS20b7zwlqPLArSeCgokC1p9n9yJy1YwWTEz
 Z5nNd+8agJ2lo54sVoISDTPe+Yy5EJrx9wcer8YLUYUj4WKjyzIXCAitpyF2tIabj59Uxsux7xC
 oHDnsV4Rf+5rwrBl9bzF2vRgnKEU=
X-Google-Smtp-Source: AGHT+IGJYf6Umy4iJ067CL87ygfvchUj+erEyg6Ngg3Crr/d4lgrXxdqJU/y7swWGCjARsdg0qZMQi7ge2dqgEwKRmw=
X-Received: by 2002:a05:6a20:144f:b0:19c:a0ea:5515 with SMTP id
 a15-20020a056a20144f00b0019ca0ea5515mr441828pzi.2.1706359931483; Sat, 27 Jan
 2024 04:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
 <20240125110214.GA12545@francesco-nb>
In-Reply-To: <20240125110214.GA12545@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Jan 2024 09:52:01 -0300
Message-ID: <CAOMZO5DWuUouoUbBDCihU8aLacF5x0eH7kxjJMX_ySkBB2znGg@mail.gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
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

On Thu, Jan 25, 2024 at 8:02=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> there is some trailing space here at the end of the line.
>
> Fabio, can you fix this up before applying?

Removed the whitespace and applied it, thanks.
