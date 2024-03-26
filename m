Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A830CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 21:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF0487F78;
	Tue, 26 Mar 2024 22:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhE1qZjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F19F8801E; Tue, 26 Mar 2024 22:22:21 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1069987F49
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 22:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simonkbaby@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so3696720a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711488137; x=1712092937; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ItF5YK5J73wq+ET3B2hJZNo2qM/uVNmKmxVaBjP5w18=;
 b=RhE1qZjV23XT4tRdnXtIcDLqhMWEcIQ6Qr+sWGFyY9acnuZwUjnrUi6rm32/PWrK3I
 kkVigHMGg6bme8cuM66fBJ8fDIW017EC5nCf6QDfPqPU4I2+1UXAwhUaRTxdUVZhbBaN
 /Rira8Ejpx3Gx9Ea/9WE2LQEBbL5opZ2h+Yn1XjmEiPDfOdFbm9cwVpH8gKdrY5SQC1L
 6KTdcl86hALzYZgY4yr/ZYJAHcVzXzzAiWN2UltI5o+Zmgu6lkszY6FF5quJethkqJyZ
 +LNls6CKpUNw+nR1+S0XvZAE6tj7QHJPOPD9NW9Lly5CfQuHVt4quRBg2Nbhxy2EJF76
 NRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711488137; x=1712092937;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItF5YK5J73wq+ET3B2hJZNo2qM/uVNmKmxVaBjP5w18=;
 b=b3uIGNKu92awmc+K8kR8q5KPdvsMjqgQfW+pEi+N8rAtaeSDkGiNwNMlfPT1a+OAjq
 AXGDaO5jnY4fcx+sUfVu4fgvVM2HeHpRGdc/5ONdMdC80te5TvIWVYMetOCcj8nv2I7A
 fWgyxewfkPkH/pNqrkr94FyeBVrU+wu3EGVeJmWFhwS5sAKKGXsP1Drg0K81G8jpI9dA
 JDO+fPqRRMOUv8MEx9iRu4LQtjL4TRdmseG0Cjq71hB68CeDiCnFbFcA/Lh3sEALnfAV
 UtLr3/oZCgJW+1DHxRqZwWXFIar79FBU2q4xzD65+2teqaS1UJlOB+7eVh0oSJp+Z3U8
 w10A==
X-Gm-Message-State: AOJu0Yz1rLOlkcORFiqILAVw35v9DKJp/gu2YXdQM0GLuofT64OIdKi5
 SrBJj725PsIXzeyUOlNlPyxf7+HvUrvlFBldbUFQ5hMVuLkpauV9AZM1lRmlRrnjmV+lrRGmUrs
 FDH4yrOaS3gKBb3fioSM5WPkYOIAhVqeyYxn3ww==
X-Google-Smtp-Source: AGHT+IHTBLRXbuQx9PIZJcQ5f8h96+J64qG/+qWLm0N7+Pds95DULUFU1wlHGcSsdTG/szNj9DtWyahvusXao9G5odU=
X-Received: by 2002:a17:90b:1c07:b0:29b:c493:5c73 with SMTP id
 oc7-20020a17090b1c0700b0029bc4935c73mr2378598pjb.25.1711488136964; Tue, 26
 Mar 2024 14:22:16 -0700 (PDT)
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Tue, 26 Mar 2024 14:22:05 -0700
Message-ID: <CAEFUPH2BbytSt1L3Xvoo3v5SvqZFvTevHp0UbUsZs4+tYU27jw@mail.gmail.com>
Subject: query on CONFIG_EXTRA_ENV_SETTINGS and boot different images
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello ,
I am new to this email group.

my requirement is below:

1) I will have two linux kernel images, imageA and imageB

2) image A and image B can be on the same medium (different partition) or
different medium.

3) If there is any issue with imageA it should boot from imageB and vice
versa.

4) I would like to know what changes are required in u-boot and kernel for
achieving this.


Regards

Simon
