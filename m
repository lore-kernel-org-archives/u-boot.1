Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B450C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD3F487F88;
	Mon, 18 Mar 2024 00:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B2a2AeZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B4687F8F; Mon, 18 Mar 2024 00:53:33 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB6887F3F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso458389a91.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719609; x=1711324409; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kU8BlBYnmKyAjq8PHJwBR7juQpm+0QaSJtzxTaRhXAY=;
 b=B2a2AeZnUXJAigsXOODOZGWcPOnGAsH1k6FjBPR4a2gwMGC1BIfixzLZ7B+YiB1pM7
 NaoTlgan4I0bcvxbp0H3hdkm6CWqoB6EvUfbbN/YOwZUTUt2FxaxQdFQ4TH0/jFo5GGq
 b7RqNp93JuzduNnpbuhJzrLP11XePFESBFRSD8mdf5/3vVzc9NQ8h4kYDxDZe9dVGRjq
 o2hKDXKjdLA+sxdarQ8E3OMTRvy2bZ+lBQambEpxClyFjw6UZVqD1g7hKLVuddraXB4X
 6+42st+CfpYOmf8HnfwaWeuUDk1OcEmNiM6uNQBBYl4/SBTkOshlkWoOWBcu/4KXAm0E
 Zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719609; x=1711324409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kU8BlBYnmKyAjq8PHJwBR7juQpm+0QaSJtzxTaRhXAY=;
 b=pEbQ5QHiQsFkr9Pd3E0cU0bFh+ZRc/9C7T4eVaRnEcDqGZ/D20C8N+KEJLU86v+6v6
 KRNiydj0b/lpboIBG+Bk3RTXQND7elZw+S4SEUmAH+5Ddput370fzLKdQQwkTs4uggOq
 wLCzJ4LZkRIZ1v9Y4jqpwWwXQKzNS6REnCei5XoGA20fqPMFV8v2+7aNiVvhTBTSgFfw
 TCjeQ2JmzjCPDkVwYeChn9UAYypW0ydwf7oYiiLEZwUN/zovWSWrNTBI/UYbqODr57F9
 JdETs+hAwGW7m3xB8gD09nyuiJiNA/FQ8/gWwS69mKR/6CY9UJh1i1M+eIUsbULN4SkD
 S0Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKrOIaCtINOEergbQN2a+Vtzylg6xEESeIKew5dH9m7fcZRgHwonj7Fzmv0ynQg76Gsa5yuJO8CqxGrncdL3YKTwlF9Q==
X-Gm-Message-State: AOJu0YyBbEZmn15sJ+kZe0jx85S39Gy7JV2KJeUYt3yA2MgzmgGbtCTO
 GU6j1ZC/9CLRixNUa3yNeLnTAVYcO1BehsfiTfP4aOgJO+23xZ2uVg/lW6TuBMRSZNakk7Jw3JN
 vTmXZReoo5CLE++10oY1CgMT32kX8Ro9iuhk=
X-Google-Smtp-Source: AGHT+IFPz5/D1Zdy2FnyUQrBr5VI9M0hqlR1uVUnjl6z8McYZKvHssmhh6XeEKTunbDz7JPrj9tRCPbf93NV+GMsw+Y=
X-Received: by 2002:a17:90a:ad93:b0:29b:f75d:bf5d with SMTP id
 s19-20020a17090aad9300b0029bf75dbf5dmr9186138pjq.4.1710719609544; Sun, 17 Mar
 2024 16:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240312085957.902398-1-l.anderweit@phytec.de>
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:53:17 -0300
Message-ID: <CAOMZO5AOhjDZxVn8rJ7fyG_cTt4vE3wO0s2OThP-SiStCMhOOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add RAUC boot logic for phycore_imx8mp
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: trini@konsulko.com, t.remmet@phytec.de, u-boot@lists.denx.de, 
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

On Tue, Mar 12, 2024 at 6:00=E2=80=AFAM Leonard Anderweit <l.anderweit@phyt=
ec.de> wrote:
>
> This series adds RAUC boot logic for the phycore_imx8mp.
> The first patch converts the environment from a CFG_EXTRA_ENV_SETTINGS #d=
efine
> to a text environment for better readability and maintainability.
> The second patch moves the default bootcmd from the defconfig to the boar=
d
> environment.
> The third patch enables the redundant environment on phycore_imx8mp.
> Patch 4 adds RAUC boot logic common to all phytec boards.
> Patch 5 adds the RAUC boot logic to phycore_imx8mp.
>
> v2:
>  - rebase on next

Applied series for u-boot-imx/next, thanks.
