Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C23BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D749874D0;
	Thu,  2 Nov 2023 23:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JzAlupEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDED876DF; Thu,  2 Nov 2023 23:49:22 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E969587743
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7afd45199so18421747b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965357; x=1699570157; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvwWA7yqRrbOGZIAyEvHc7+79AgOOyBVWhUGLGq+o+c=;
 b=JzAlupEoANhPH5QyvqhA60vlrcDuafjDAeFeSTUP8pZqNbXJT5e9az/FXo9hdNADSu
 Qi00Vwgb1d6XeCraTcZo2mvMPoZi1uHkfKmo6Fhe9UIAjKqEJ5HhMoeBHi1Ac3vAjHQO
 SLrzwQZbmhdcSIP24iOP36zIUhzrsrk7JTkTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965357; x=1699570157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvwWA7yqRrbOGZIAyEvHc7+79AgOOyBVWhUGLGq+o+c=;
 b=FfMWzCGLJPPT2/f+X7hcVLjZDckSb/XtTRV7IL8At4+QdWWyZE9qxQ/+KKG36bDNq6
 s3nFksZRokyLu064OYwGWdMrfawk2nVSwrGiZKcPlMPwyfZMdjmpcLTs1Xuu6ff/a+qH
 uvL6Z9Gn/pjUTc7YqxRH6gVav41ReOY0iOZDqWYRM+57rHhKpo9XeL7oThYReIlU0Iy7
 wnUTDeCpvIs9yB07sMU+HoQfy2AoURaCBxsHlc5ruCobu7eIBBjNw/KtwU0dydO6dWdZ
 iX0jVw/KMoBp+Sa7kgi/bEWnJR57y4q5HCi2Zv17+0ezPMvy5bbVqpwAl5UbH+3JKA9Y
 4nfw==
X-Gm-Message-State: AOJu0YzG3T/pXCujYoVGcckrYbHGGdl8hC2up8tx4GhoHVftzOEyafQl
 19EVVxxBsubLeQqb0BT0ltuDxfgk+nREb1wOnq+ROsD1OluLEVo4FeY=
X-Google-Smtp-Source: AGHT+IF3dZUZYN9ySFSRMnYcsB77SRIN3VrkX9Vtje0FWe6f+/WmVCxp1eLZtNVLQKtKhEVYhExtMy1jfBaXpo/8zyM=
X-Received: by 2002:a81:494c:0:b0:5a8:7cb2:15d0 with SMTP id
 w73-20020a81494c000000b005a87cb215d0mr1180656ywa.11.1698965357243; Thu, 02
 Nov 2023 15:49:17 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:11 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231018134030.27260-1-mps@arvanta.net>
References: <20231018134030.27260-1-mps@arvanta.net>
Date: Thu, 2 Nov 2023 17:49:11 -0500
X-Google-Sender-Auth: l5wQc8ZzwQkD-KSr1ZbBt0Mf5IE
Message-ID: <CAPnjgZ1Q+-S1eoKnZLwM1rvTbOX6xq6HPUWRAvx6BZgFAPatsA@mail.gmail.com>
Subject: Re: [PATCH v2] cros_ec: spi: disable annoying key echo on console
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

on Peach-pi console every key press is echoed with message
'cros_ec_command: Returned status 1'

this is not proper fix, just hack to disable this message

Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
changed patch to use log_debug and added forgoten Signed-off-by and
and Reviewed-by Simon response mail

 drivers/misc/cros_ec_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
