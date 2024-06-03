Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E26AC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 16:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8C0881B8;
	Mon,  3 Jun 2024 18:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ees0Uu2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4778836E; Mon,  3 Jun 2024 18:44:23 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EE788180
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c1e9965478so443376a91.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717433059; x=1718037859; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oHABNbaFT6fqffYuuu4hrLEZdDti5JKIJ4u7CFaNaQ=;
 b=Ees0Uu2wbNMA+OvlPz0maAATkDwT5AcdjsUnqvyXAg+hEcPyP8tp/rxqIJYtT0Zk1G
 3O5OE5OF0X6Mc2Y38EVMjyWmfb9FwPr21Rar2on9JsNF8dpWbQ51xqs58g//+3vg1KW8
 GMvk/tEDhjOkrt8T8bq8DZtjfFTlGMxcM7LaSIREH8gy6kfMLcEy5CzJQbz3myZvr2dS
 3d+/c+ydMypkhLq4e34ZgO/FxifoigeYrWbrTNR2XVWqmEkyFvA6isxJcXw4i1M6NUoA
 wskgL473t1NSGTCt+k10BksYnGGqV3mVKKzxzEkiYx/jvt/xf3cZilpZCZTjx/b47/io
 81TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717433059; x=1718037859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oHABNbaFT6fqffYuuu4hrLEZdDti5JKIJ4u7CFaNaQ=;
 b=RIhBHPMG9xzwMYZMKQqYaYkx7hyqv9ccuXp00/l/HwqU2F16kHu+yHtVnKjWb0KONf
 98HfeweCDAzyUEsUcO5YZXU0eyOn0p8V7EX1kySK2EzeOwY7BVlk6DOemi0olSxitXPg
 uyZqvMt6OIZbTrMVAbZCTLLvATu+wQ21OqQ5WzwR8Wie7ZbMlsTxuNhd7wpciaiWvvRP
 fIPPvyFf6InOsjXiRNNzzcZdnSPn1k/mzhp+ks1KVUCYtFIyEvVilO+PDRLXM0KQH69y
 pjr39naGCZlsgkxYbgOkdnaGILPq3snPo/bMqIwHWCy6GXEI4ALYjN7N9fKReeepJRmG
 yXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQWhVXLBwP85+4PSeYaW9bkbFWWYC6t8tp4Dd6j7NG5RmNJhocs0+RvB46ydu8PTcCeitF0IRTUxE0UDOuleOUX923cw==
X-Gm-Message-State: AOJu0YzQW6C/ejKISOvybK+1u8s3+Mg33lOXCGZAzfaNfL1JM5XiUjvo
 h/RQE2mI3fiH8P2XIg/SpopOgVF7azdszyWWDR877qPpBGw9J7NWKMI2zhRaPQ9zzRUoThEgNId
 Q6FEfg28m6PGcK2I/1rup0pFBIcQ=
X-Google-Smtp-Source: AGHT+IEMkkHYEqoEj5y8uLb6XehCc2whuwrPJpdEFknrl4Qy6Ge8oAm54ZpvNXnCxFvtairdgpOX+XA0Fo3bAyX0TkI=
X-Received: by 2002:a17:90b:e90:b0:2c1:a9e3:9fcf with SMTP id
 98e67ed59e1d1-2c1dc5e0b9emr8543602a91.4.1717433059479; Mon, 03 Jun 2024
 09:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Jun 2024 13:44:07 -0300
Message-ID: <CAOMZO5D8FAY+iF4paCXq1kC2uMjkCKOoLmQbksVmh-ZEXqv3Nw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

On Tue, May 28, 2024 at 7:00=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Hi,
> This series adds support for 0090 PID4 Verdin iMX8M Mini Quad 4GB WB ET S=
KU.
> It also adds two new SKUs config block support: 0088 Aquila AM69 Octa 32G=
B WB IT and 0089 Verdin iMX95 Hexa 16GB WB IT.

Applied all to u-boot-imx/next, thanks.
