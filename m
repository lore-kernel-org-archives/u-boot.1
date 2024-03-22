Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B829C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 18:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3E287CDB;
	Fri, 22 Mar 2024 19:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqZWfHi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463F687A0B; Fri, 22 Mar 2024 19:38:30 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBC487CDB
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 19:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so422141a12.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711132705; x=1711737505; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbsL4PMh6HVAWwVPUounKeALRArDoReMQQ4yYWSg31A=;
 b=gqZWfHi6IjpmIQAUhXueVIPYxAWBXdzKCfykhVgfR12PUiJIMNsi+jKel4yjEqkp2p
 WbGEF7au77BYRwkKT/2VrGNgMlVip7pSyM5lpILZqlVGvJbXGVAG0LiC0rFWyDMxDzX4
 B7sqjeB+7XX4PxInmt76GQp82jAl/pDfyuro0zQIWYbfiMzYxPebBJMF+4ooZtjNbOpT
 WCIDGk0fvcMnPXYBh/JK4LN5stzUhk3FN97pdqFLM6G4VN/ljro7bobzfxART21NbkpU
 5YUoMnZh9ZJXO9FYpxnrFJ7ilE7ToKdJmZwq9Tb6kXFfeZ5+TtWaOc7PgMKbOIb6nqTl
 CyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711132705; x=1711737505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbsL4PMh6HVAWwVPUounKeALRArDoReMQQ4yYWSg31A=;
 b=p8qG9VYgpKYOkO/YJZP3yfbkLYJY1PQlsjlSveFkgTrnVc+7ZLtlKYsaRcQtywOBbB
 gKNp4Y+WwG5LC82Kapp4E4mglGoYycnFNjy3FZEA1+4rMIK7wkygfGcOqZE9nfL2S3s2
 8nCeAXBPaIP0rSV4csnLKbqyrfQfNWKLQAQ3FGR43flFbtJ5WejR+0LQAsq+uK6dTu/7
 WjJ1Cb4gdD76GTSFcacMAPRNhsEgrugrpaeBN0Y6yECzLB0HXZ3va/mCjNK4AXlv/1rn
 SL3HMrRSbwm7Z1YNnP1I6yEMsNHcL+acc1/jwgOLx83yvcRNw3g943dITdXesrkRfmAk
 asPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUu5OM+4XZFDwB1n3rvAtfaTZZ4oanR4/OIpCPOW6LFyeRaZ967xla8Z0dKuIBSV4aEcrVr/oUelTfAiJC0eQ2o7bmXA==
X-Gm-Message-State: AOJu0YzBWc0vtfgGc1b5afSRJRQ/hKF8CWqizIg1Ym1Hfsdy19YI+DpO
 J890Mk8iC05UjgLSKEgJAGa9ebO9SvDbn6c6RVeKDE670+qZr7EHvjMbvDBLA3j2mBzcjwZDIhY
 L7qxUXJqBe9vn42JSJBbSyVGqYmQ=
X-Google-Smtp-Source: AGHT+IHMcwLXL/xs42Cu4aAiHioYbrqpZIyBjBOYB7F75BVIpeUzwty507ebR8wm2/nKIrWtvKqpZJ2JpJq7yXj5Q/w=
X-Received: by 2002:a17:90a:ba98:b0:29c:7487:43b8 with SMTP id
 t24-20020a17090aba9800b0029c748743b8mr482506pjr.1.1711132704632; Fri, 22 Mar
 2024 11:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOMZO5C02Fwe0ci1RW64E2Gxi4BbdDfhDAJx4ycczE_6oW-oxg@mail.gmail.com>
 <CAOMZO5DbSnU0LdUJwZGF4C2wFuO4WDaoODJPy8WqLa=aoN+0zg@mail.gmail.com>
 <CAOMZO5DjB+AmBteNJeda51zrFO_atDZN_5gg14KmVgZpiTioqA@mail.gmail.com>
 <CALG-KHzmrULyRYEiN_c9Br8gr=Rvz7jyKWfA87C_9Jawn2BKNA@mail.gmail.com>
In-Reply-To: <CALG-KHzmrULyRYEiN_c9Br8gr=Rvz7jyKWfA87C_9Jawn2BKNA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 15:38:11 -0300
Message-ID: <CAOMZO5DLaoy44321Kxo3iE_f1wtzoSwMskY3Xkhxq3VtUKxLcA@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Paul Liu <paul.liu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Paul,

On Sun, Feb 11, 2024 at 4:42=E2=80=AFPM Paul Liu <paul.liu@linaro.org> wrot=
e:
>
> Hi Fabio,
>
> I'm on vacation now (Chinese new year). I hope I'll find some time to rev=
ive my imx8 board.
> I've tried sandbox and qemu. Both of them are not reproducible. I'm wonde=
ring if it could be some packet loss that causes the issue. Because sandbox=
 and qemu there won't be any missing packets because of loopback devices.

Have you had a chance to reproduce the issue on your imx8mm board?
