Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D935CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD31F86A24;
	Tue, 19 Sep 2023 09:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OiV7IVlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8838B86A26; Tue, 19 Sep 2023 09:19:31 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCE786416
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-530e721f077so2886696a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107969; x=1695712769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvYkHb4cJ74rEd1sM1a0tUR/EddOehzr68asjEMMNU4=;
 b=OiV7IVlThqk/hxE8rbpSEbiAh7KuLcuAXsogBmA9Qu7IariwvEHTlG/gcumzRkslCE
 PRjMt+W+qunj+LGtxc+fYoT5JMVJ3QNWFq3gyl5UgxWcXYqdVA268JPmw2Fpt72VdhMP
 pReSTrkL0Ep8j8MTBNGy/UlhRIu0kmjByqY3WcFIIxzgP48T6WB56t5W5a5Vo/s6jsNy
 LFnG01HgpWwj4MhLTjKe6xQZly8U2qinYYKKgxxDMWZGVf306B2WZjwlWblj8vsTt6oY
 agQ/AF1P9Ehdnsf42df9nTxsRmxFEt5cNenoox2PfRyzJK9tNXot+ZIVdHZiaxbxuDDj
 P6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107969; x=1695712769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYkHb4cJ74rEd1sM1a0tUR/EddOehzr68asjEMMNU4=;
 b=leEE9+tLCo0weSIwZ3ERlHBA9EIwMGHR0hzmiXr8LgBJaBvf5zJrS+g6RJjIoRkVvV
 hC2yEQqj2Be/h3DwIumcSIzF4URmHtdhGDTtbVDk2+seVE1x/WVHfOTz3aWfXNj4ci0Q
 BrSjtSDzKyG2YL46AWjcUUmhXvLAgXJ1+Ex9ePerhPRbzSYojSytZDU3mGArHFizLY1S
 BQMFOhYYwFPvhJTb/BAWdtgQPL/CdjLl8s5xjXlW1O6NAFu3gZx8EWXtpmJ9iSG6ba4h
 XobiDLW0bKRCWuYIgI+NP5GB6Fdw72x9PJIeWLDtEXd3f98Va7/x1Y4AvuB3Yrgwxq+E
 YMEg==
X-Gm-Message-State: AOJu0YwsVFkApuma9G8K9NoXk5MCdEvUS3rEtRa8ESXIVoMX83nHg5i0
 69Tk0ByOA8e77GjZVI83F9Kw20bh8V+wO/L0074=
X-Google-Smtp-Source: AGHT+IHJrjQSEuVUEFyN1qfPBcvpcjn1bdGKrCWiuq+Mftz4++EiJGySe4ugEgoU/zP50eChbXh/RMyoc5+a9xCwFuA=
X-Received: by 2002:aa7:d809:0:b0:523:4acb:7f41 with SMTP id
 v9-20020aa7d809000000b005234acb7f41mr9698766edq.14.1695107969098; Tue, 19 Sep
 2023 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-2-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:16 +0800
Message-ID: <CAEUhbmWvMmjjRm7a14NCyWPkNOpSqio4PNuzpMu9Pw7xwh9f=Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] x86: coreboot: Add IDE and SATA
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add these options to permit access to more disk types.
>
> Add some documentation as well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  configs/coreboot64_defconfig    |  1 +
>  configs/coreboot_defconfig      |  9 +++++++++
>  doc/board/coreboot/coreboot.rst | 20 ++++++++++++++++++++
>  3 files changed, 30 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
