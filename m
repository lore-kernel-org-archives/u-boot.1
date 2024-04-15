Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55940C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97BD88151;
	Mon, 15 Apr 2024 13:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8lRhIjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A214B88152; Mon, 15 Apr 2024 13:03:38 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D024D8814A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2aa0f3625aeso167042a91.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713179012; x=1713783812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf1W8HtYizITqLYGOOPlMljnB22VMxh4yyadpKVu3Mw=;
 b=R8lRhIjSb6xTU3XEvOJE3bHXtVO7GpbnBIcqClmD/crrHCsuJ0clA0cFufmlRcisa7
 NPuerUblneeq/MxRQoe9cLYYoR9FgRca9ShxMotCpQYjsswzdf8Avr080wuC1tCBXFj8
 rnow0wZJ1CBSLLaoX0/w1+7PuSLZthmyDpFVlQpO5WWfQMnQRHb55ek+hFesETkueQ7w
 80fguG0eMmalRnWP+gwmEcoBlNfKYLZ6JRN9DRGs7vg0vmGkq89et9osUI3wR3S5tIer
 rPl+AEMNUkc2zkDV+ERcVfiNlJFHN+YJW50KNTKoGCuTHo6KuuPa2gyYMEadBlHDIoEV
 xVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713179012; x=1713783812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf1W8HtYizITqLYGOOPlMljnB22VMxh4yyadpKVu3Mw=;
 b=HbA6Y5njTTUOKEgvQ1ZTkSJcG9w7TZ7Olz271E9XGk6hVyMOWi9oeRQbFRGBT0I5Yn
 Q8Oz4o8cSXsPsORyN+54wdnZa3wu6MOlVynaQXVPmeLiRfooIfDRW+nYK0O2G0sovi/Q
 8X7uozj+k4vr49zglLd9SbAp8CVZRYYiheOKoP+ZEaC2Pot5HEftBG6//iOQXRbvcnB7
 1ZhWClW0XuFsRddaLZ6yx3Y2c+CiL0Nx8nMDzipTmtxEtYvPmkaeEI4QIQn4qHZd8fk0
 3kNl+RhCjOFoYNQyS85Z1shRKO7qVpLnbII5I4bQBDZr6hSxp5ocRcxjO5MxX2evUX9W
 08uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIUOt1io/SGp9vTW4HDJ1ayNoeypMOP4Ka4rglXjCza1+e5V7OZzt8G81Os8BHFVZM3uKNToA7GYSriWVtoG7HOemyeA==
X-Gm-Message-State: AOJu0YwG+VouBwRO7FPZiIGdXTIHb4noIHQCV7pIn+gycVZI4YHoeUSZ
 EulCpERHxqh4+63JfczRJdL56JpjSeDqVRWdKNr9jI9g+AhIaAS9I3I76QDZHvk1M3rekdjLJqs
 wKf1o/6PBB/8d88Ml0TgemXYzfUE=
X-Google-Smtp-Source: AGHT+IEhUfbtAxm8KQafAG9uWkN+/Az2731OvyoKmpjupGpKzAa/We2ZvGyBNm3mRG78ODsrhdO4dRqikX0aiXhgwVQ=
X-Received: by 2002:a17:90b:4b47:b0:2a6:d7ac:24dd with SMTP id
 mi7-20020a17090b4b4700b002a6d7ac24ddmr8360354pjb.1.1713179012322; Mon, 15 Apr
 2024 04:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
 <CAOMZO5C2YGDokPoc_8Gr+5prMWfQS7xh8KWRrhjj7BpCVthADQ@mail.gmail.com>
 <CALu9rSYHbRTnua8SEre-sk0kTQwnJOJCNc5-MJy2ugFUn66eog@mail.gmail.com>
In-Reply-To: <CALu9rSYHbRTnua8SEre-sk0kTQwnJOJCNc5-MJy2ugFUn66eog@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Apr 2024 08:03:21 -0300
Message-ID: <CAOMZO5CKODZhGhMxHy1X64T0Qo1YCwP6q+8eiHusK5NPEvd+=w@mail.gmail.com>
Subject: Re: [PATCH] net: wget: Support retransmission a dropped packet
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Yasuharu,

On Mon, Apr 15, 2024 at 7:10=E2=80=AFAM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:

> I have seen similar issue apart from this patch and will investigate
> it as a next step.
> If I have any information about the issue, I will send it to the thread.

Thanks, if you have any updates about this wget corruption, please
keep me on Cc.

Thanks,

Fabio Estevam
