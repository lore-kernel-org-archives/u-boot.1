Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFD6FEEF2A
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 11:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8216483A41;
	Tue,  7 Apr 2026 13:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOfDoSmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66FA83F98; Tue,  7 Apr 2026 13:56:50 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAFC8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 13:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a2beddab48so4865908e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 04:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775563008; cv=none;
 d=google.com; s=arc-20240605;
 b=Aqo7wlZ9gknVTsKerzt9vCCA4GZvd+cBlsv7Ud/IE1LjK/VXQPuI2G1nFuW3BO9rIM
 7tDJAs9piodZ7dC6V5q9PW2tFNu9TwQAgdJLZkOoj353qYbIeoe/vzDmR1NZFR76+Rc/
 CQ+GAoPG+Qvjdu81amhRtsZC6gU6i0hm7FsCb1eYbGy7QGvs0Q+UJG8vE/xvIjLevvni
 Fy90SoeQcfxXU42aTMzqkdM5WlVFTtbiQPUYdDwqa/kpTSCqpSqDSfvuwiOxZBA3Df3g
 Q2Xlz0/JMqjP3brSJ0UPuUUVC4ATUbs3tcCBGKiDZIwhvWrgdS6auYCZ7HVNxgkqjtbO
 I+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eHddnZHYKG5WxHYSalGAfTH8R9Df1h3wRkw7SnQ4clA=;
 fh=HwURUStOJzBCJI1S06E4hgOV0nvIdOggDo2gcAjO7IQ=;
 b=WwGUxo356TROshFgTX+bX9n5xnp/zk2bDjxl1kKHLmiDkwWSsstaBN5vi2YC0hxUWh
 8pFmCsGf8jSaNHJGDcc0hdaFOgrXMoRDXA0rjHmqzmonmBe4kJ6kCYLQpMcYgk+e/Tuj
 i6HQ+aBvvMjvr+W8cLA13N3xRi3uwOwfGvqcCznrJVQ0ZKlQPMU7twWVHKfc2UY6gHPk
 jWznHA26e2ul6LiUlXXQsPuG1ot5TpsWT4vj3tmiFGvxA2FOBigHeIcHirmg7lN5UhL9
 222kn9mnMxbNslRUUMU/tV2mDnTMYirnkqqi0apPTOp6Aq+ax6mCUdmLlyK1esQ5cMsd
 iuYQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775563008; x=1776167808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHddnZHYKG5WxHYSalGAfTH8R9Df1h3wRkw7SnQ4clA=;
 b=OOfDoSmzTsNRW5u3kEC+ALzQDQEMh8qE3TrUBuOUHVe9hhXb6SM+RdTArWFyJqaw73
 TSYCaSAr56sXMMqfnd+Npth1KFn2qHVt5ZtfVX8+QBgaDQn2sKzmlW9Q7YagYJz+al0D
 nYicMA5Bn6SSygLrcr9bIdsWYCY81QFOUooho1AXr8gtXAkbd3oYuZoIlb/GiEvr8x9I
 339eNYmCPJ+VwyNLwMYtQ0XSa46xjR+PqPgzLGOkAc8TVlOS3TmdmKjH5tR2mqaxG8nS
 RFhGos/dfDbJDKzW8jabMSMjP6WJgJT3FYdKMiyOX9pV7TCxAUsaWt93aFefSRgnB4Qp
 0z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775563008; x=1776167808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHddnZHYKG5WxHYSalGAfTH8R9Df1h3wRkw7SnQ4clA=;
 b=TcP9vCL6B2gOESI6hACu8hRuEPUG/kCrg3entfedYNkGxpzGdyN05UON4+A4VOVTeB
 ymNQhm54V6Iui+15nqgQ7PAAIqQ6jSaFM1c7BlU9xUbMItHwTPYTTO1QJK6iyV0CZGh2
 rT8DA+w1tBgxrhzUdvi0cU2+eUlJZFlqzOoKJ9f0Z24Bd3JX57+8x3poTgw9jipN58cL
 mEIqoUxOBr5QhfoyZzqJF4oPSUlzvpcjeW2+DCTSXiBK/AiacjdKLogkyuX5MiJxf3mj
 +PfGIPB5lbb8FaPKCjqEm6vp+aSoK7Tks4KXj9DHf5I1eisDHF5wBSTQgCMREt0idbHF
 tCiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXjtcLb+ut+zsr43GK9sosc9OQ60VYBOLekTn9qThOGjfNtYPl2kxXorsuabVez5vob5I24I=@lists.denx.de
X-Gm-Message-State: AOJu0YwPvOTk7Df3r+U23BiuRZjIU1zgfTBDuWEYE9fnCnksewTb7HQe
 8Q5szluEcBcIU6KOtslVDOBHMdQfGm1DpVj6KFVHRPnPOXzkyk42wOS06CnOgvAW3tjJxZ37g4o
 kOztWnt+sONEXWmCgn5RNGRrttnZJdcU=
X-Gm-Gg: AeBDievW7GAgjGBnFDDpQjmZjSJwFgGrgwPFO3wO7ibnuT/JQ1GY3qpRg8ar+x6H05w
 FgxwbTZjhn2jaLyUtUAhROgBeTblY4cSfMXUti5ZiCqRjrNSQeyuio8NwxdlaoocZEdafIPFpe7
 I9LIjFe9eQXPzPHGFpNNGSpf93oi+jv9jOgHMzdhJybNIoL8OYcGXVeYL8TwYEuEYl6zCwkjrHN
 SSjRxlrGItXtY0xWScKDcTNXfeFNQY2jxBCTd2pHNXDciQeWx/TYkUT0573/QK6lMsVL5uIIEiw
 RozlJ1/LuruWWypGzcWhxLMKTlhsEPUF0ApDHyNTPD/9yBuctTrE+NdEbboP5x38oQrFNq/2ki7
 G7USzBwk=
X-Received: by 2002:a05:6512:3f0c:b0:5a2:c82d:3ce5 with SMTP id
 2adb3069b0e04-5a337580543mr5354638e87.22.1775563007660; Tue, 07 Apr 2026
 04:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
 <20260403-enetc-v1-3-e42ae28ae3fe@nxp.com>
 <CAOMZO5A_Tg4XOYvUekNH8a-t+_0nL7WU8fM1W1LK3QcQDHTsjQ@mail.gmail.com>
 <PAXPR04MB9644FCCC862BC4144D23F74FE25AA@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644FCCC862BC4144D23F74FE25AA@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Apr 2026 08:56:36 -0300
X-Gm-Features: AQROBzDOifqqCIJaeNw5d8_URiuiXvuyWUAjXY0BCKr5wL7Fj9pbZuZ3_aanw_w
Message-ID: <CAOMZO5AsKQPHHa760JpznaF2znX+cTv=g6pabvsRyMpgRugY8Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 3/3] imx952_evk: Enable ENETC0
To: Alice Guo <alice.guo@nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Marek Vasut <marex@nabladev.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Thomas_Sch=C3=A4fer?= <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, 
 Yao Zi <me@ziyao.cc>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>
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

Hi Alice,

On Tue, Apr 7, 2026 at 4:16=E2=80=AFAM Alice Guo <alice.guo@nxp.com> wrote:

> ENETC device tree nodes have not yet been submitted to the Linux. They ar=
e not present in linux-next or devicetree-rebasing. Do I need to resubmit t=
he patch to U-Boot after these nodes are included in linux-next?

Yes, please.
