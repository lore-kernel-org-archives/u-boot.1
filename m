Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F3BFC72C4
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FC084065;
	Sun, 22 Mar 2026 14:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7JipfPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185A68408D; Sun, 22 Mar 2026 14:27:07 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3738780212
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a27bfadca9so4171317e87.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186024; cv=none;
 d=google.com; s=arc-20240605;
 b=LLIo9K334l5rRbLD7xA3z+X8aAitJ+ndULCLHGnLNBgJnEyA1PhxqGsj0EHbkbvXJ7
 RZX6E120GyqjzKtvBBMMXa9xnWHXY2az0CieZEM9g0zAt3H8N4Js+i3wBZaNVZJqM6xI
 7OqXR5hKOVwo1pykEbci7gJLH0vMPdVGLBOaIBuume1vGcGFZk4tUHq5QC/7t7XZ+bQV
 xyMlZns8SKqPxcNPZn57+OrY9+EKVEIbxCTtjJ/Tf8BD2pC1nRRwsiefrxgEhS6w2XiI
 H3sRrtsikWFPnz3pbojS9cL7h9VIS5qW014MzMdu1OpFfO6kZeWK3IrpO4QxfrJf5SNf
 8iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PwBub04iej6lb1XkbXCIUAcilbl25gt91Imkay56N88=;
 fh=acHe4rqjWOVAMJ1mo4SRG38fXg797A1nzh+AiI0tsPg=;
 b=F6NtMe6LgyJb5RAotYP0gLQAzPTMmTj751vA7Fp28qZaTvfzzuPq1Ry4gAMG+xc9jr
 CI2eLEIrK6GH+5AFt083AggADUe/JungRiyf+2S5Rz7rdKLk2rhpXYDrx6pGD1ySZfLk
 qaB+A+piXvroIvpdcdKpdpt6eSCmQXj8wbk5AIAJ7/QJ1PZqw2rLVLVYASxxTx1dwb9Q
 C/1n5NhrFpV69lto3+9RH6b8OFgXvPm99w50pYWQ41OQVIH1jI9Pay+AVOklFdemtvzP
 3z9AFyNNm5O2/+qO7EEgjQ/uzIkM4eZt14sffhNLI44dQTMIBYu0Jb39hN54n0wZcvDO
 8ELQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186024; x=1774790824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwBub04iej6lb1XkbXCIUAcilbl25gt91Imkay56N88=;
 b=T7JipfPMEI3sTVMiUC7220FzQWQU68xkfPdv2gb3cbOMBJIEykXNFZ4QFxCNlsxwcb
 EGubqDR4o0d2X4AFT5vKSHPdNPRt3FzUNbBxjQkNaNxccX6T1ffjKvWSBBJt7uCuoWLa
 IbUCTTxzU08Tzyx5AiKhSk4PaD+Od5CXFPJrJVV4DiJ7f4EJw1eYiJ91Xs4pBI/KTB16
 X23x0KcHwOACKZdQOQ6qOQYIN/GaDB6Z7pGedgWuV0oiEpTN996rWp5AfFqPXTuiKvbP
 1fkxvr/T6E7YRdaoq98Up69naRZuDkNjarhh0VJFoTCzkPLimNs7qo9ohvRPoShU7Ti1
 Kvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186024; x=1774790824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PwBub04iej6lb1XkbXCIUAcilbl25gt91Imkay56N88=;
 b=hU6sDiww/suntV9FpE62KgyPB4B/H8nliW7Tvf+QEeql8sTZiJxrW+Rgh4EkbTlp3p
 zdM33tE9lUhWsPhegjOS7u/tP/61RpqhKLiZ9o48iBrAxTmfnmtyNXTz8IxgM1IcsbQX
 btQCMtCIBKPa3qbtwWawsuF3dGAbBIROykQeqNkUuN7C6Ta6vLioT6/SfGvql/iApgiP
 dahXqYPum5dztUp2Fbts8R6E/1cogGpjog00cXyhetdasvKTe5UwnPFstfzzLf3QFcTK
 9RXy21pdVrRfScNJm/IezwtJakdEJXR0uiLPwYr0aclAjX9qGWDPjKCAMsJogD01NvzZ
 60VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+njbHIhPvUt9tE31sqcHd2D9ASWZhyiLlV25/O/f66cUxiY86qd7W81ZmrICesJLNm55fC+A=@lists.denx.de
X-Gm-Message-State: AOJu0YxMrd4jxNEDPQUZn668KFLq3XJeisZiYz5BxtUSI+y6ncO+wrrt
 EIHrQVzmSb+JgJ4179lUMp4x21sEm/EtiQlG2l0m1ax4eIBrHJPAF1EjvXurXA3/JTztNn+Uu0q
 zY1zzxwE91wNWPraJt3Uddh9eUVSYGY4=
X-Gm-Gg: ATEYQzzwOGM8mR/auEi9kCkidOM7XxGM/1Hj9zRlo3sAxrQie2Lm/R3EU1Fub4B8xUw
 Wq9eTl/WGVe8WVRz8Nw3ypVGhrz5I7hdqdxp9GypojPNNBaxugoBwuAo3VGUuyJ0MO1YWlUCArk
 Kdyk6Pigj4ffao3Wtv2pwR6f9eTxL9LwcUON86cGO3fR8+sRnwPrEjXCj5Atri4MqUeuUwKVA2g
 EmpWtUWz9Z7WT7mp4Rps+8HytiRuHqUtYT/Md0vlIK0df1eoRgGQE2jT4MQYz7K6mUL7yL4kNws
 RZavbh2TS9/9cxql8aNE8JTrP4VJxhyncL8WZhf094EXl2axsZZVxWyVPvMSsBLG1CgvjI8=
X-Received: by 2002:a05:6512:acf:b0:5a1:4f87:27a9 with SMTP id
 2adb3069b0e04-5a285b44297mr2892634e87.21.1774186024137; Sun, 22 Mar 2026
 06:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-7-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-7-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:26:52 -0300
X-Gm-Features: AaiRm51x3at-X3Fhf8UgNiqGP9t0IUndRXQ5ovI14IVG-72U3PgxeIxtX66F2PQ
Message-ID: <CAOMZO5A_2OaG-Mp_VuwY1pHb_WWdeN6vh61N5-ozY2AB9LaCEg@mail.gmail.com>
Subject: Re: [PATCH 06/13] board: tqma6: change to use shareable tq environment
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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

On Thu, Mar 12, 2026 at 6:58=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> - while at it create tqma6 environment file

Starting a phrase with "While at it" does not look good.

Better to rephrase it.
