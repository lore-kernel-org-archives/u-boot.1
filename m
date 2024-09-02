Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC608CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC0388C39;
	Mon,  2 Sep 2024 19:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4mw41za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF0288C39; Mon,  2 Sep 2024 19:45:07 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19191882EF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f5064816edso51182681fa.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299103; x=1725903903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7rJZoptIBO/2oH51cFw4DxpMQ0WBxDP4OK5uxNJt2A=;
 b=L4mw41zaqzoBzf6qINoTmexSHT0jB+UZTJbT1yIn/tIuV7ZHtROQpc478YeF8qwxwu
 N0F+W5HgfwPPz/sWVFv5SDBbkX0o/oUcFLowuGFYiwAwJtcf1xBgw5C2L/ieWZeQtHvB
 cgnFWFYS57ahYXrJiT5959B3tTuSB0AQXAHe6jAPlWwzOC4LpUzdWdVPCPlm7gSJZL3E
 Gz6TREwQ9FPRmuc4LF8khUA/7KhVRwEwkmF2F3NKKAInM4cS+FOFAqows0IYRuNVipjZ
 RWZcq2bzccqfTEoWcBZHr0TmbtWuJHN1T7xhqOkBoRi/1rUCjaslnClvOZsAKQh2ZDhc
 qgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299103; x=1725903903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7rJZoptIBO/2oH51cFw4DxpMQ0WBxDP4OK5uxNJt2A=;
 b=Bsebo/bYHSh0DePcR42PJrIOBI6e1QnAijIugY7TnX4N1C6Bn2Cs1OEutz2Tkg7ULg
 WqU5/dO93yGF9/7O8MtIM/P/A79CY8Ax7y0fFjMiMKEoYjYSkJAPvmk6/UO6MyVCtSzr
 OZB/9iM6WRorYP8usHYJAmvlrqULbNyz2BigEP+RxzqM5EpDbJGKhTtQeM0OICgmxeVC
 hAG2USXNShJ2f20T1om9DsOES0hJPO0HwiIRFcyroCMYVdTl5m8k/xAwSuzvf314rJTL
 EIBWHaRqKlZCEG8N9pBA0HE8eGyk5+oh/iuftsvvuNkwvAQk6RWOpKJUtxoG1D/ruBHz
 kKag==
X-Gm-Message-State: AOJu0Yz6D7APnYiNIXWqF1K5CfWCesmTkuW4DLAS6NsSL1Q7mzO1cFLX
 h4aQJUDbZbiR+lGjD1iamKLT/soOkbQnBUiBSsqp+wyB2MBWXgY2qr5UlUe7xuW7Qj+MACMI5ot
 tmACFVpZ8Uj17p/qhCVHRMPgSDi43ng==
X-Google-Smtp-Source: AGHT+IEnTRg+5JVwNwgLpH2aQaDTNDLALIhcip5Kqv7ImHoSjDKSotuxlLRPW2/Wx70lpIOFwh+mTKBwWfIbHGXZRlU=
X-Received: by 2002:a05:651c:211f:b0:2f3:b081:114c with SMTP id
 38308e7fff4ca-2f61054a1acmr101825621fa.40.1725299103047; Mon, 02 Sep 2024
 10:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240901003813.674730-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240901003813.674730-1-marek.vasut+renesas@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:44:51 -0300
Message-ID: <CAOMZO5ARd_cW3Uw=Hjzmpa2r+4C=HW7Kh1rDOk_xuAEiFmXTMQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: Wrap i.MX config options in MACH_IMX
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

On Sat, Aug 31, 2024 at 9:38=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Wrap all the i.MX specific options in MACH_IMX, otherwise they keep
> showing up in other SoC vendor configurations. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied, thanks.
