Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B1DC369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CED783FDB;
	Fri, 11 Apr 2025 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QNgDogWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A23683FDC; Fri, 11 Apr 2025 14:46:04 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A5C83F7B
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54998f865b8so1896781e87.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744375561; x=1744980361; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaefP8ByZNx50t8bfEA5WudlYzHoxjgdyaiRcU00Ows=;
 b=QNgDogWf7K0pxfb2xCIXGh6Iys2gqhiLsE1Ar06XL72D56rM4rtQvvG/iD56Zd4+Hx
 /G7KMruKr5xS2lxITPHFz6IJncLMVmAi5D0JPb9Xkh21fp96ST8d6sX7eG5nJ4bZ9/wz
 i1U9lxr+LuOb1XHm0JYyygEm7fCorEittgvV7G+KwuV7+xe5UI0oAnwlqxRykhRJJj0H
 Hrbw6mPJHjmfP2AyhqrYLfK+cmFpzM0brgu3DIGMoPMnllLW31sjFTk9CeUmkYAmDxZ4
 ZHXWM3Cu5GRzQTgHc0TjiL2AYx6JiS2JsO35HSiys3JZIl17WL8BWlqikcGjJUD4hSwx
 FfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375561; x=1744980361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaefP8ByZNx50t8bfEA5WudlYzHoxjgdyaiRcU00Ows=;
 b=EVx3VkpLSVNRuFQBrGHs7X6PALR7j6riW+46gP/1Jgpy0p9oi61O29+5TWKT634HtZ
 w5omTguUNgHoa2se+3DoNvre0m3nN8ZoVRHU834aKXRXyXUWG7EKzogZvALXzllfJIhh
 /yIKLn3rxjUAX4UOuchTO8syvhhonKnooLYsPHmgPPKqb9DS3eXQceHnlTew/YaHDMGT
 ILqTJA32IPWYbGzxB+YG1u+KDQt5fDA734k8PTeuFQ/DfFF3Nm1UdAe4jLyzc/MnJpzT
 EznDSPseF6bM3svbcFWy0LKoqVmldowESsgUNxC0vCbIVGyrZ24WUwj3bXJzxh18vIt1
 8mPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvjJ/hOzm7VWuqviR+floS5UqXeFnaDbzcTUs6r9FF4dlxe3gGkU9rXOgp/UUes3fKGE1GRjg=@lists.denx.de
X-Gm-Message-State: AOJu0YzWzMETAiXDM1qQzdaEUqmoADsF9gFciwJM2IKijYxt/rbO7mpT
 RZDVjftJIAj+7d615yHU33U6nfsuqonLdzSiJJ1WvZ6bBAA3OX+FQzZEh8ChKhHYKur1/moXV7e
 kusJUpW39OG4P0J8b4qS//wLMeD8=
X-Gm-Gg: ASbGncuhROpPE7zNJX5p5SIevmfpgkOHsNMWOc4U0OJ9/57p+a1wCwTKJTnn8QUTdAd
 rqVccmDShf4oiavtfIrAE3NhOTRuDNhM9kqYiTVtyzt0wpreeEttLE485qx5h+5whkFwgGHEMXP
 fIDnsOhYAYTIGS/uFjj+fyJD5SdaqQ4eh5iB5EBRs9mBvXWqmoBonfKg==
X-Google-Smtp-Source: AGHT+IHfQo9ruEUidbfdOeAXPPF31wK58D7d5Ybqf0iafAGkf22fXVUCaZHuxp1PnRUUfAOsbMTU0bcjRrjBajHpPtk=
X-Received: by 2002:a05:6512:ac4:b0:549:7c13:e88a with SMTP id
 2adb3069b0e04-54d45296b10mr793468e87.17.1744375560812; Fri, 11 Apr 2025
 05:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250409075352.535194-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250409075352.535194-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 09:45:49 -0300
X-Gm-Features: ATxdqUH2EfEtqdTIvJBgLD9nkSoWMubK7xdFLXv51kOFX9Z9cDeN3Whm1Us21ag
Message-ID: <CAOMZO5BodWZDVcrZnzy+Qjb9nYks64v6_CFPvxotv1=dWR5MGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: marex@denx.de, trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, Apr 9, 2025 at 4:54=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:

> +static struct driver *scmi_proto_driver_get(unsigned int proto_id)
> +{
> +       struct scmi_proto_driver *start, *entry;
> +       int n_ents;
> +
> +       start =3D ll_entry_start(struct scmi_proto_driver, scmi_proto_dri=
ver);
> +       n_ents =3D ll_entry_count(struct scmi_proto_driver, scmi_proto_dr=
iver);
> +
> +       for (entry =3D start; entry !=3D start + n_ents; entry++) {
> +               if (entry->match->proto_id =3D=3D proto_id)
> +                       return entry->driver;
> +       }
> +
> +       return NULL;

Please send this with an actual usage. Otherwise, we get:

sandbox: + sandbox
102+drivers/firmware/scmi/scmi_agent-uclass.c:355:23: error:
=E2=80=98scmi_proto_driver_get=E2=80=99 defined but not used [-Werror=3Dunu=
sed-function]
103+ 355 | static struct driver *scmi_proto_driver_get(unsigned int proto_i=
d)
104+ | ^~~~~~~~~~~~~~~~~~~~~
105+cc1: all warnings being treated as errors
106+make[4]: *** [scripts/Makefile.build:256:
drivers/firmware/scmi/scmi_agent-uclass.o] Error 1
107+make[3]: *** [scripts/Makefile.build:398: drivers/firmware/scmi] Error =
2
108+make[2]: *** [scripts/Makefile.build:398: drivers/firmware] Error 2
109+make[1]: *** [Makefile:1919: drivers] Error 2
110+make: *** [Makefile:177: sub-make] Error 2
