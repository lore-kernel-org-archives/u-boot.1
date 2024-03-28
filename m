Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79ECD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 16:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B6788193;
	Thu, 28 Mar 2024 17:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RY1wlJRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E51881AD; Thu, 28 Mar 2024 17:42:49 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969F388176
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 17:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso217575a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711644166; x=1712248966; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqWnKYKR9khUwnpqPUfpS/lvBGVfYW8O/Ik0pJkjHCo=;
 b=RY1wlJRunhSgnALzhNybZs9Fq13deVFaB+xYcM5ePi0a4IVha9pZxBGI0xU+6KjdkY
 z17EVvJZynMTDiTLivZ1sF7HtdA1Nr1j1bqjjeyoDMv0zaATVLWZgUdmLAdmJeLM0pKz
 Sa1weUrHTXoJlPj6IItWbUCVSyKcsxPatgQNOxwirr+9d5+42CKvo/nEvCx424JhHUJt
 Xeh+puJdcqZkq6cB0h0wxa3sdt9xXscPYvPrWAu8V6pFWENM+dXX7H+Zuy1NLulc7AHW
 u6zqVpO8+MYmQv+5QFzRv7oryRfByCuOypkNZ9MUENINlzj63HWmDsaac6cNIJUevowP
 IDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711644166; x=1712248966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqWnKYKR9khUwnpqPUfpS/lvBGVfYW8O/Ik0pJkjHCo=;
 b=CJvtk4XZr/7Eam/RUkLTRmK9EvEeuuxPsoqSZFcrDKl0rvaAj/5BDOPa2MUS+qe0pa
 WQVBhMxZk7Ktk6JW6udFKXN4ogNyE87Eo7SjvbHAH8S1VgCBAtyXksACSrDElsx0ytdu
 yM85oHclwakrMxNqDfjie8RbebRArcjtOf2UPEaUFvL69/ZmCf3bC+7tY0CUqXDsQJcW
 n5gk1cMYA42UzST5uoWm+6WHt1bic+uYHTnMWTL9ybTuJJ6V6J+rNs/MTe0jqSi3wWYi
 vLQG278MfZu8V9+V41UyHnSDd7ChLD4P3bmNMu60lWQSVeZHBqSPZDUTX9DPF6iN5e0N
 dDEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcMkUB2BqpL7CqB241GwZc5L36bloAKxIpicuTGLvA2/J9HZkOHXV1cIZmag+sg9ZyTxJbsDcDj1oxwnThhKzGVxaMqg==
X-Gm-Message-State: AOJu0YxOZUPLIW7N4mfdW8ZQsP96q+2/73D/56r19JmJoriPin24XtU4
 UEcR9yl3DyDHvNUo88/fC4Ux4ceQtgjcNaXrAzGGVq4yue8/soZfrZJh5pRnLLyvWwhIX0Bulob
 hz+WH93Mq4B04NB9JRbwB/mM+pEg=
X-Google-Smtp-Source: AGHT+IGhZv1vXcSmsqaZkpcMDoyE6UiCpd4WSPIMKp/jqCjIw+399X8nfPWu5orm/pG2viqD5L8thDB5/oQ0RcavYGA=
X-Received: by 2002:a17:90b:1bc2:b0:29c:7697:d2dc with SMTP id
 oa2-20020a17090b1bc200b0029c7697d2dcmr3257623pjb.4.1711644166048; Thu, 28 Mar
 2024 09:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240328153415.3706637-1-lukma@denx.de>
 <20240328153415.3706637-3-lukma@denx.de>
In-Reply-To: <20240328153415.3706637-3-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Mar 2024 13:42:33 -0300
Message-ID: <CAOMZO5DTc1S_HnHtVbNmUxswGMXV346gtBcVRutCdja52RMTpw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm: xea: Add support for reading SoM (CPU) and base
 board HW revision
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Lukasz,

On Thu, Mar 28, 2024 at 12:34=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wr=
ote:

> +static inline u8 get_som_rev(void)

There is no need for 'inline' here.

Also, get_som_rev() is only used 5/6, so I suggest to squash this
patch with 5/6.

Besides that, the series looks good.
