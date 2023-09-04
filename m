Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D033EC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D78868D3;
	Mon,  4 Sep 2023 11:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iz04Csec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE37D86900; Mon,  4 Sep 2023 11:21:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EA586500
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso1653535a12.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819298; x=1694424098; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLT94AdaeS31zIeIOaoC+wBwP5v50ngj5SC1zwvKyhQ=;
 b=Iz04CsechZkQmP/calwdSDHhB0rfYnCJU7QolobF02SBU7UvGkXxEAQoSmDqASlgIh
 UhpJw/y/E93rDlz/g5olPnYShEvoU7DmtXvkRx/9jD5iwSsBxF6FPi7p3qV6lqWsrk8w
 wNY8Wnnc1MRihNuDaLO6TD794vhxSmcv78bjdL6RfUqxX45L7zfeOE14jopHdOUohLae
 15hkYymODIb3QtA1bVfaJ4VpkDOV1XezJTcyA+h4Xqda5Cx0d2EW/wqhktPsXNGK284t
 6/zHHHLUlXl77PXLk0Xl34vFXimnOLpR/Fs+vmMqA8dzwylo2LbhvX+r8b9XT1K3+iOa
 BqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819298; x=1694424098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLT94AdaeS31zIeIOaoC+wBwP5v50ngj5SC1zwvKyhQ=;
 b=TNnHGZdBpreWL7pVNva2IMjBMrKLT80c3RQfFk6I6sDk27RUTzmajLnveKsHW9gSJq
 moz3tnQix0cv5jnHWdwVvGoe5w4nM4Jeunc5VJkWvpnZxdYaMiF4JZ2j2vZtOUoh68Tq
 vChtV++WkgiLbjLqdXX/GhQ/wd7tx2QUICuleG0GmhJXaZK7oykVnb/8xnUa+fPimTgt
 4YCTsCXROo5MSAkeMOuz2oEIpij5k6co2ntnqnnAgr7FkiklfgY7RHTpFBFiTdcTIocH
 f1RK8dvgWzHOUAjNnKwmTFtJlzU+6kFUum948sNIVnZxQTm7qdtdNa50wXiP1T1czd7V
 s+3g==
X-Gm-Message-State: AOJu0YxLPqcFu+/o+NkUq2IFZHkKdYvwRcg2PTmHahIJ66lWtyh9yXo1
 PLlN9kbPECRB1S7WcmZCO/4XGzSY7QkfFC69CQV8cYzm6F84bQ==
X-Google-Smtp-Source: AGHT+IHrG2fVS2WnZzdt6TtWS+/6xxYFe9JAv/6r42lrN157mePh7JjmWtatj7uECReJCJmorcNDT3fgPgFW1/VMZW4=
X-Received: by 2002:a05:6402:b30:b0:523:4057:fa6e with SMTP id
 bo16-20020a0564020b3000b005234057fa6emr5519705edb.42.1693819297797; Mon, 04
 Sep 2023 02:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-2-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:21:23 +0800
Message-ID: <CAEUhbmXxtVoCwuco_Ew_1L7B4U5y_JSAa3tXkftf6TiyKB+9vw@mail.gmail.com>
Subject: Re: [PATCH 1/8] x86: broadwell: Show the memory delay
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Aug 24, 2023 at 2:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Samus only takes 7 seconds but it is long enough to think it has hung. Ad=
d
> a message about what it is doing, similar to the approach on coral.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/cpu/intel_common/mrc.c   | 18 +++++++++++++++++-
>  arch/x86/dts/chromebook_samus.dts |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
