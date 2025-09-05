Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD99CCA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A4783816;
	Fri,  5 Sep 2025 15:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wp3zw1B8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C1983826; Fri,  5 Sep 2025 15:28:45 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B7983622
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55f7ad815ceso2390812e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757078923; x=1757683723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF+mOFJ9biQHq0ZLUsv9ARlS7Tp45P3Zkwch31mUQuA=;
 b=Wp3zw1B8tQLrg/iGYrSSWt2epBiB+94skwjCb5GkX5f3be8AKsYqGeLyasL4VvUqIS
 Swp7z5QtwaOzeTB9wt7dLNfsGyc4kdikKx3F4yaoktUmOKVfVWRo8IlDnCm1KHYO+kkO
 bjF/yfEd59NfLcYT4kqhVrFWEXS4HwQYKWm8xjHBEiWTlEgcyv9ZhH1BNCj0XKsyQmtm
 HW+i0+tGGtooGGeEY9dP3x6En+wfV90KnoWpv8bCgTUSxO+lF/Jf9aFB+Wrqk18KmbvR
 I7Zk/5ONClhmk2evmIJ2aqm6pWXW5oMQnQYkz58DA+VYOVv/jOtXGp3hbLW0mu8Cg88z
 ALyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757078923; x=1757683723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CF+mOFJ9biQHq0ZLUsv9ARlS7Tp45P3Zkwch31mUQuA=;
 b=YjRTwJ7gF57fcpy5PE7GIA+ph3trfny1Qx3RUBn1H88VE0z6GITNNgSMFs45BZkuf3
 z5yWgRzE1sIG2Wsyzmo5dBCfrEX3nn7x06yn3LLcuaQvr1CrckW7l0TxaublKAAfblie
 yz1u4/wa4282ICKJY/zhxsJH+FF5BSkSTEPAkJIntU7w/AVsJlP2LumwR+fpuVBYWqPE
 ZUH251Agn2wLtOJOT3UE4ebENt7q3rK9MDw2pznJwuk3OAw3aAztwBLqEtErZrLTb82n
 7olrDacHwnkQFSRo+MXVAaHB0lS76dOJpwo3W2tTv/4+ssvT7KhAGNtyQ/TH0xONgUwo
 prFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbIU3VczSN69EHNMJiJsu4BaMgq8YDcTzDYtL7ip+PqUT8hJDrdydg7tpLWEiRD3Nu1HBebFM=@lists.denx.de
X-Gm-Message-State: AOJu0YxwFPG/anmINr5PLd9Q0P1qj9uQtHC2QxpgwR5HM5jkvI2I/TD0
 XvaXZ666qxLu/F5MJEHjRZpKX0aTpuOFUt0S8Z34ONFSTJ4xYG7n1nEHP4Rv5Kd6+WJG6LbVTJq
 XjpoE2dOQqs6dL7QZmhFTkw/9IIp/LRk=
X-Gm-Gg: ASbGncsC/kAjt0XkdXELLKh7n2Kl+m3hsIjbIk2emEZ00an0hm3ajO11Dy3nVrCrFD1
 HHtlTDayYTr+CPAINn/CGh7hjL/lsThDsAdhtVSKdwh08jckJzx6DPWYbQaxVnfQhIVhBaW2DOp
 yViGJDvx19OtBPDReNE+N7Wd+oH0RcD4C73XES/PiWNklO09J3pnzWcCoUbSjDIGIptRvbtyFBn
 1m1PJb7ABOeonyUFO2FESC/sZtC3Bq1BFCK2nwgBLdhkoHN3g==
X-Google-Smtp-Source: AGHT+IHZThLrUtoQOdUUJjmBSbxgco5fs98tCy84qsUFNpYdpSxa6B+urLV4By9dCoAzJtE6B7MzFbtnQ8Cer8YOdS8=
X-Received: by 2002:a05:6512:b24:b0:55f:4ac2:a5a8 with SMTP id
 2adb3069b0e04-55f708bce0bmr5327550e87.13.1757078922254; Fri, 05 Sep 2025
 06:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250812060807.1224861-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250812060807.1224861-1-ilias.apalodimas@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:28:30 -0300
X-Gm-Features: Ac12FXxE3LlkVKdLUQ7VmmX5eKIp_04mVN7c0MYIQ6twpJ57TFPijADxd-ynj3o
Message-ID: <CAOMZO5Bq0y2yD=8+fvR=o3n97OKfBhbGvYkgkRfHHy0408cN6Q@mail.gmail.com>
Subject: Re: [PATCH] tools: imx8image: Make imx8image_check_params() static
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Peng Fan <peng.fan@nxp.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@denx.de>, 
 Gary Bisson <bisson.gary@gmail.com>, Maks Mishin <maks.mishinfz@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, Aug 12, 2025 at 3:23=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We are trying to enable -Wmissing-prototypes and this functiion is only
> used locally. Mark it as static.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to next, thanks.
