Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF345C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 11:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F2F87017;
	Tue, 28 Nov 2023 12:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kibf1odn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C96D87021; Tue, 28 Nov 2023 12:33:00 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E0686FA6
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc13149621so12662935ad.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701171176; x=1701775976; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91JXwbllB2qQVhJYpeALrVONaFD496sM+y0r7i7mDvk=;
 b=Kibf1odnOotx5HdBR1h9hFKNZgf1KFu9kqdo68fC2UVtPGEKNd1C40jbo15yDS1aNv
 ji9MxQqNUGrzKNvYDmOHI1FiIIX6s8Ohf/bqhN1f0UVqlmqiX8bqLA614VBElAar5C15
 yUVwf91QkevH/daNQrEHYqV+jrI3eTgwOEFUXf5q0WBHX3BU4buzEgL9yaRCYQkxJhOV
 jcCJA+4+Nh2X8dZQ98CmYsUtRRY3QMpbhw/M+Pz914BCcpRBKTgQScsjGTe6j/J62XpE
 sF4OsUBZJuWaElhrlTQP4Rr7+ysf8wJfH+o0R8F5qSjgwI5ucM6QtklEkObQcKiV6amq
 0gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701171176; x=1701775976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91JXwbllB2qQVhJYpeALrVONaFD496sM+y0r7i7mDvk=;
 b=fqE6zyf+VVYNv98jPx/f4T5TT1tfwt9zqYiRxAVIstGGkf3Fp/+r146feO1xq4InFi
 wgUJ8KleR2Ri+pIszheam+NoPvMKYCwhNekGsN2qpjUvUX4uuQo+B0BZ8cmBwkdicrCv
 GxQaHJNLTjiDDONVbTTd4nM4E1J0kUHBioNn4UqxDHgEeJSYk+cp/utH4uYSpvJUdtqU
 rIXU51iCW3d5My7smG7BTI12grFeKknmdy+j2BQwW6FffKPb9A5ONAhqPpIfasGQvxFH
 jWE+/lx+03JKdRoOdZvOok8/Me2zrBmsEBSN48z90AS6wdo/Fl01OY+3uYuvvS+BTAX4
 CJaA==
X-Gm-Message-State: AOJu0YxLwZhi9mjS2DtFpdRKFjxxMlQuAuANU59JilRif0kOPNQnqWrV
 eJAGOW8aZ8UcxTIXJvHdJd+tRxu0WxLrm/eWocQ=
X-Google-Smtp-Source: AGHT+IF0Hb/cnmyGHIxMJQ2TQqe74BVBxRkS7iAix75lRvL2GrKuS2qwNtfWMWk8dGj6Es3+XRozNoP9tk9XpGT5Yvw=
X-Received: by 2002:a05:6a20:da89:b0:18c:18d4:d932 with SMTP id
 iy9-20020a056a20da8900b0018c18d4d932mr18240947pzb.6.1701171175871; Tue, 28
 Nov 2023 03:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
In-Reply-To: <20231127125726.3735-8-maxim.uvarov@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Nov 2023 08:32:45 -0300
Message-ID: <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

Hi Maxim,

On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace wget command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Do you know whether this wget issue also happens when LWIP is used?

https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf=
1CNaZBw@mail.gmail.com/
