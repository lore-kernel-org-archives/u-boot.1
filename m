Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19F5C38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11EFA8827A;
	Sat,  6 Jul 2024 22:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FKpdTuHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17F4882D4; Sat,  6 Jul 2024 22:47:34 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A78B8827A
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e9d61a4b4so300298e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298852; x=1720903652; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soCagfvs0MzcgvunptIXfkVXO4M19V/j3q3a9MS3Jmo=;
 b=FKpdTuHZUfgpbYrDfDItdEeGreeLcOqJx/fCAMIBtN0vmH4qF+dZS6/T66WSyjAFFM
 El4l+CCipUzjJzb0+YYXCbEFxGYvQQadvwJceTGr/m8PNOISwEKuZNqadKo7QYMWQ6x3
 kdxStgGOeovdZi7lj4dGWRAGWU3+l5tDnzAdti5yCOR5e2EZ8TxZQjXCtwecAbrHGvgd
 /pN8ymBrat4S1KS+mnbruiTaE63emm8dWPwM+akuTquAaUKJ0UlBOf+J93Cy47amlHHP
 cQw6mJbqprM4TkfKKm6599HF6eXHBJDTLcVxMQ/JY1yo2IX4K6MsR+pfmXZwSwo7gs/o
 xhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298852; x=1720903652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soCagfvs0MzcgvunptIXfkVXO4M19V/j3q3a9MS3Jmo=;
 b=EPxzP6xlcZ1tjv4un5wVPVXJ6fJtazu7DlSg0AyJB7r5mK3xY0TVTirCHrrH7rRJDu
 ilKhRVHpk8DIVjzLU5shoILRX4ykd8U2Dkf0HGKbR/qFiIZzLJbDDzbBcJBr0QQ1scqT
 ILekFJOLPmBcezDeRyU+MsUCmV8BTIAmv6AOb2mStGkC9du4V1PTozrpYgL5AV7ONm2s
 nVJ2DfxrF0oYovrp2sx+PyXlzy4LyrYINynuZvOdqPzUtcMZBhjdyzOVlPW8ppAKJAwR
 tSajOdbYDhmYIPAkS8T6ZRw4oiIL9Prt9DztKncLNkmx9Q3zSjBDknLoIvw+YZHwJumk
 3FJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJSFCC0qjSpedK+By0VadMCt524kYmHxhNZaOVc2fuepnG5i5cTD6cky4H21uGGkxOjwKrcBU4MzYjoIK7YuLzIclfw==
X-Gm-Message-State: AOJu0Yw5gqs7Bd8OWeRMswLSUfQGTef8IuFkGtrNx89SQXh5p1aETfey
 vuWasXnfuTVL31fd/QDdsu1hlVWpV0VgNzV71MvEDDmMKIYj0yaiT1PgpsoFWQs+6UznDXQdj77
 jwTGo8073cZJSnjUoaoMo8qx74dU=
X-Google-Smtp-Source: AGHT+IGrBdyT+31kT6pU8jpw3E5p/3vtnoDhjGhQkRfRBLxIp6EcWoj4/hcJRQ7JfhodlUPgcxcKXZBCodG7Mxtebqc=
X-Received: by 2002:ac2:4115:0:b0:52c:6b51:2e9a with SMTP id
 2adb3069b0e04-52ea062998dmr4773667e87.2.1720298852181; Sat, 06 Jul 2024
 13:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240704120337.673211-1-festevam@gmail.com>
In-Reply-To: <20240704120337.673211-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:47:21 -0300
Message-ID: <CAOMZO5AMr1QsedmnGSQHvM=w7t9z34R6pHfqQsHyLPKh=ryvyA@mail.gmail.com>
Subject: Re: [PATCH v2] msc_sm2s_imx8mp: Adjust the initrd_addr location
To: ian.ray@gehealthcare.com
Cc: sbabic@denx.de, trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Jul 4, 2024 at 9:03=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Booting an initramfs with the current initrd_addr address may lead to
> initramfs corruption and boot failure.
>
> Fix the initramfs problem by applying the following layout
> suggested by Tom Rini:
>
> loadaddr=3D0x40480000 --> Gets moved to 0x40600000 in run-time:
>
>    Uncompressing Kernel Image
> Moving Image from 0x40480000 to 0x40600000, end=3D41e80000
>
> fdt_addr_r=3D moved loadaddr + 128 MiB =3D 0x48600000
>
> initrd_addr=3Dfdt_addr_r + 512 KiB =3D 0x48680000
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Tested-by: Stefano Babic <sbabic@denx.de>

Applied, thanks.
