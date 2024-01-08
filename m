Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82E9C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F7E87A24;
	Mon,  8 Jan 2024 11:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6UBWk/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662748794A; Mon,  8 Jan 2024 11:30:42 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED05C87A24
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28ba5cca7fdso342176a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704709838; x=1705314638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vACA5V7I9kpykdDM1k2LbKkm8AIpSVA3HFuBimh8Vag=;
 b=P6UBWk/KSldRNOCS6YT7JDF1MOzNHvpf94aGJ6AP+yCHTHem66CdajUBbSYqr/lZhl
 uOV8PL7YQ+v6J8N2NdQtnap32LndEX6K5GW/24umzuhVHKI6CxTE4CIAS9d2nVLzsA+W
 4iLDbyAc7nZ3XWNzdUlpLftzdUPpaBM1o3ANx57mZ6LtliclYMzr7ZDEi8pAjBIKQhVc
 eIicLewAr7M4J2Zy/xDt0/JNjOp+jBgkx+d7IaZw8hIn03RShe2NUl4AW/WeRFuqFpu5
 02KbgTaEqWpTe19iEwyeVBiGp2/+jQ2wXnqzbRiNHAZy6inOx6JdeyBMhc9e8sveNG8b
 R01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704709838; x=1705314638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vACA5V7I9kpykdDM1k2LbKkm8AIpSVA3HFuBimh8Vag=;
 b=Q8VLHpE4U6Xgty1Tk5MjIC1wxUXMEQ43l7jjgrVwz71KiMNw0ctTR5YLJH9dauQdn/
 BsRC8r4ax5p6FKg0Cg5QbVkrHP8Fo2iMp/vmfHOrZaiYBNUqR5tF0pUSAn8ibSbdSI8N
 qVnrnWjZl0d6sSCOG3uOSVvvpcanH75sBxfbMEBB8xZI0jrSV3k9ckJMfB6bBAZER2an
 rEXkWa78CJ/bnZAKOnXksFPOdshvDvhOlaJXo2F/IkpStCSybPnZucBgUKyp82RyjGYP
 tHQlw0mdJnPyzuK6vlDcN56KtToYcYQwMunK72ruMWO7Aokt77u5lm+YNMgvNC+Ml356
 nxOw==
X-Gm-Message-State: AOJu0Yx6mH6IcnFIPlZK5KGkUiqi6F80S/y7JV0Y02oOXEo8KJINv70n
 7h4EzNPN9cAR6ZVA3mlIwT40sW6J5S0lUYOB3Qo=
X-Google-Smtp-Source: AGHT+IF7wNyn/jDsaagLEjZb4oPWMptGTSzDKAfXpcBhy1jIC4IFApEBxbivpBCHzdcOWULC5hm96VzbEw4XL7Cg0Uw=
X-Received: by 2002:a17:90a:b78e:b0:28c:18b:3971 with SMTP id
 m14-20020a17090ab78e00b0028c018b3971mr5195266pjr.1.1704709837926; Mon, 08 Jan
 2024 02:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20240104155357.21865-1-othacehe@gnu.org>
 <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
 <87v88489b4.fsf@gmail.com>
In-Reply-To: <87v88489b4.fsf@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Jan 2024 07:30:26 -0300
Message-ID: <CAOMZO5CyqnaqqWpcLQZXPYXiSYbtzLzR+7k10NC-LZ2WA7P4iA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add imx93-var-som support
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

Hi Mathieu,

On Mon, Jan 8, 2024 at 6:26=E2=80=AFAM Mathieu Othacehe <m.othacehe@gmail.c=
om> wrote:

> This issue was that we are expecting binman to keep working on the CI
> even though the binary blobs are not present. I fixed that, had a green
> Github build and submitted a v6.

Excellent, thank you.

 I plan to apply this series today, after Tom releases 2024.01 and
merge next into master.

I will also wait for the Gitbug CI job to finish:
https://github.com/u-boot/u-boot/pull/457

Also, it seems you generated v6 against U-Boot master instead of U-Boot nex=
t?
