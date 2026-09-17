Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE25C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E1680E25;
	Thu, 17 Sep 2026 14:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRzj-tgd-6TS; Thu, 17 Sep 2026 14:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0356380E28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657063;
	b=QpKP9zL7yontOX52sXY8GxxciTg47+56oaL7mCp55k8/o40G2+W15yUFpnWFAIR9aQvb
	 qbkqKXgWWdpNAAcn28LmxNFlDJ+YaSA34cKyZMaLx/0JykdzxHYXc5Q7GR2ci6pWwYE47
	 6qNw7r1MQUnOrpellJeuHP0t/IDAuzjHvvXFSX0ilD/osmbVOIrtQwLQJl1cZ5oCJMcX2
	 44Do3/YsARZWP0ZvNSaQbeRKXN2rgXx4jwu9LhVpOJrxzEFza5e5RQaKaz9FaGS964SVX
	 +9e4ZuGTcDDiTV8zl7yMvWyBT6VDzIPOBdSDPBcfQcowJgjm5vReqEcStlz59E75VYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
	b=PlLE9cZ8g0Hp3P1omz9g6nEJBzmKshhWG94o/MODYkv64kD5GlyvEmXzEqMxawXPcZpI
	 oaq0BPU+xkcJBygPrZKRHnmznhf42L4cCsBMl15nc1yEUZ5t7CpjwluYpeVnleyPGCcn6
	 ftyy/aAYM83hC1WsSaI02/oZO3k7/BByI38liKZUXoeDq3eKFKecm6r6o9Fh4IPzodUev
	 PDU0MA9OlMdfkaW99/ZJzPekNS+RasE7l7LrVSlz3utT/k+Y4mc7jCcErFfyNJp8wnMMn
	 LFataWK3bMvizt2UYLZxFMAWEXlsnNTnfXQRc4PS3zNVTbCcWtnJDQa8dMBjSaCRdjg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789657063;
	bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njBv8N69Houo5gxD+a1QPxG1S5ccdC1XW14SnvNv9W1QnPDTEDj+OFK6oBxYbC4SL
	 JSVDnenYUGmqbDLfSNotXD6HkUkS8TqbBt08VgO8vbt1MesfpeAYCDQAcEFlU73nRC
	 RVhUvcFjNroDWMMaVTdVjIoRJCviteXa/KI0ExRMGaZ+udvLJUkn2Fg82QZ4egDwyM
	 9bGI1HZyXnGMWY8VEXbmBqdTdjP8dycDpnA67SfXs47i4SwdtdxXIkZUoXcVqm+p2j
	 O5TKuQCofkcQb6ScSmKcHHrirer2bmb68IVujSyEQegsbls912jz4vJqP2J2jVyLZ9
	 yAiMHU4nhVShQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0356380E28;
	Thu, 17 Sep 2026 14:57:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 319FC3AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 236064036E
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-xTlWnTVVlM for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2CFA04007D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657061;
 b=D6zhxQ9vzwTmx1LRNpyErgUnUI9mGXNuKn+/juIl/vlXqJ3qD8xRoj3PlXfq/F6fsxVH
 P3EnIl048R21soqWIvz64lsduiMaJIIZj4Pm0jHH4iF4dLxYbiXJ42l1vhHMV90JxraUi
 BBBUTfaLVcGpJGdfZnqf6F7XnjPa4HSO66W2dntiCKGFoTVTSW+LRAQso0bSRfOeBDpON
 BTXgntU2cWkLw0QWNFmP5ZU6J7zo7Sj/z2S0HRqwdP8JPvE2PjuKlDhHVB+4JX/Lkmiwz
 c8eLzRixcMJCGKvEcbVCr7wGEFUvNZvtBQJod+kG1Kz98ZlCrBC6UZPy3PRoJsa5rqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789657061;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
 b=oqnhTosL03LDlwzXG7czPQqIIV7uVXIiShXFFRJSon3YBxFQrWAtOr52pSa9GOEBkng2
 jT/HNKYgxrrYe8jc4KfWoZAGvp9q7UrRPI3s4hCT+qtaWdg1z50vKYZP9KDwTKQY4WAOS
 pAt0oC3ddA7+bkoH6InwtgZcwW28t3XCba8v6uVgh0qnK7DgdKl3gRMM6xYhLH8MHOANN
 jLZ9JZ0il3MpDudR7l/T9dK+1puSUOaua7ga951zRqavy4RI+G4bbD6iWluqBZAu6vE2Y
 IAv/p8zQjcA4zrn4ubvECbJYyNRXom1RxSIg9eOi3Y/rlLosTl6CgkYHX5rZRsGx6DQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YQ19Hi63; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YQ19Hi63
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CFA04007D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:57:40 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66f943b286fso846810d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789657059; cv=none;
 d=google.com; s=arc-20260327;
 b=V4e7F/9ET+kqtCwENzX5PsKDCO6e/S+IH+6oMBdks9SXPdzoxaRkr3Lm8PFWOHXj21
 pHiHCMWeb4JEJxAX9aCbBvxW1txbacepsZXDpaRmsfnizOJURjKAtFlY0T8WgQa4Z9sZ
 V8mePE8dY7k1I00iktFAsLIsDz4eRmw/JP4VyKYGRnhycninwMcnjU8ZSFWPRk/NMPgo
 OFBGWruAT4FKcY6FIvdDEGCS7b6HI29khsqsDPDR0MZHbzk6lgkhjDzsgu5g9QxQQ5hQ
 raC6uu+7vSZ0FIFdztI8oepGzZssDmTnXreqQnD8mRSmpoINKlewRXU4Q1vtinXixZUH
 FoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
 fh=HfTzzgdk0mqFSSl3XkhZUC+4De14s9FYcfe7EAnOmk0=;
 b=Tl+R/fENQf6k2rd7PPTvLW7nlA6ErPOavhrUFHFUl91OIPsqglATAWlieTTbYIrcEz
 tBeC5UhdFPT++ceClkM2ZZiMwCbChgPQiPOtmC4m670AztxWqmufZu+GNtNin+dCxTXC
 YW7zCgU6ceWp/sX6GeHc9nfQaQVQzI1bPmz1NaijTZAwDdMb1mcB3tFyu4CfIBofajVp
 58NnfsDOLIKRAZrc7O2mIIJupyungdwwZC5FkmqTsLHYnd8ExnFJRBrnQfPp6vEhr4yC
 1b0S4lEOHgYUwR1rS10f/4ZEo/P12J8VznuBzCJ0HjcJ5SYst7XqKkFj9FOjKZQUI3oN
 WcbQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789657059; x=1790261859;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
 b=YQ19Hi63ztZP/vkuXqof8bhvsXXjs1Z/J0/rpM7NiymlIc8xEjF+R2FeEf7x8IP9VM
 9+bylIoiPxpZ8Jhw0rTZqd8N8TK1b+DLubWkXlrSNvlm+4ig7/U76qVQNRNmS8ptUpRM
 WvC4QHmv62Oeaq+k4SXjURBiOC2MqHu0lXE+drbBLCa/ZvoBbe/JQen7iD2bI3W6KIKX
 OJF2vBRkj6ajQqVEj6JUA8CuWANj9c5Kg0vnoDYE0b6Ac4TwgKfm2dR4QNBgBCG3ptkR
 QcJE18MkQLcYoJG6XYnaHUcv4l5UmzawtffeeCYTKASpEfaKQGk6w0GaAykVS/lusy7r
 c15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789657059; x=1790261859;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hu7Vb1WNmDzgaVm5JT8E9cdp4PHR2tsh5dSL3tBuoz8=;
 b=qBGXch805QzXkVRRScVpopnDldAYkAxpE6mvuSdGsmbPqEV3UNQDkmP111GFzIG1He
 KDDLEObcsJxTYxgm066P580lEeR4Of2bP6ipDnwuSdX1ugJ9rcOrEgzFDQzkSnaYhL9W
 AgwuulHTdDwEA2XArlf2F8xiJjP7roiC69uBWCqUBmcg+bQ87XZ3JbTuT5qw0yWPVqCz
 g3US3+PPypmaAKuYXKeEEnFSSyQHl6XZSFjEIRYIXDu/VJj/IGiX9PmoSI+TrBlRgxth
 k4HBbYJDz3tVPXH0Mj743BdQVD4dz812pqpvRaEuy2HVX4AxC3MZ+w1BJRM6xEayfkwF
 tfIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2WpuCRMdDkU9JWki4to0D0+TyPW5CI3J3MHe/PgmA0U6B+tmFEYpO/LgTi0XY57O6GQS4VNk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kbVALJyOPNBFm/9B8MqBLGzfy5lkD3YTOqNDpCFVBHOtVda7EZ
 mts6oIHUemoN132HcYHMWuQVXO3UPTRcCORwKPkftoWICnsGF4w+hD9RLvao7P1YOQ/hcFQoc66
 zc7gjHqkSSMpS4MCOpW2oKf+U2ufIuMaq4syVtEFHRg==
X-Gm-Gg: AYBFou3FYCBuLlkb0O++XkOgR5bOvkXMFNp9aY3ShLSv6Ay6R7iPGihFyCfFwLkS0E1
 W5mKrsAy1kZlQ5F+2IngPNgy4F0CuYE8yYAGdGIGZYtBcqoUFj5EUycl3JutzBPnRjbjrCG9/QZ
 ahicGPGfpkDE8OWTvl+9+4G2JKDKt2vn4ZzqHGKNpRAnauS+D0QqTBp0OUce/PX+bDV7m8KLuip
 S+XkDTMyqJ56tSlKELwLCnUpx96Efxd2vvGfHIaYD0npbFMv7XqmYnJEZcD+lNQ64GgLizxz19Q
 Hzilez3gKUShMjTdLahWMcCdxmq8Pqk7qJBEf6LJ1QQiwykF6Bnqh0zJIB1VvFnK5qIlvGrU9yo
 yBrXbIpLN8vO6wepGKtpxIrkPJ1OR9/azzT8yO5doQeDGDp+Yf7uhwyOQrkX1DVdiwdqKuH0mFK
 xVeVgtxmKs7ijw8eCamzBTb69GrU9g+o8mEOB8A9puNUPLcUTEhEJFcQ2bHNwdaTfwsoIBugOli
 cXhLm/nrwiMMyzXBfREdbjUY5xp5wXpRtWsFN/0DXGk+2OI3sJAEIxA8Wn6Xz3l/Jw9rO+85jxV
 9C5WLcgTHaDXloOsfUR7KuefM88UBktZEVCEvUYUcXVVuz82+8qUauAxatuaHKZBUQa3jVyncez
 Qyx7IS/1tqHedDL3nSiI8ObvM76VZklWSMmI7ai9O3x1Um6I0j6yTaV+g1hbA8vspGv0=
X-Received: by 2002:a05:690e:43cb:b0:671:39cd:f9a5 with SMTP id
 956f58d0204a3-671632a454dmr1701915d50.58.1789657059081; Thu, 17 Sep 2026
 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
In-Reply-To: <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 16:57:02 +0200
X-Gm-Features: AcwNN1WL3NuisXoBITymdRqrrtJIbI7Pm6jw3vy0J6IpTvfR8CbVY0B6NBK4N2E
Message-ID: <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 17.09.26 15:01, Ilias Apalodimas wrote:
> > Hi Jan
> >
> > I pinged Jens for some help with the OP-TEE path.
> >
> > [...]
> >
> >> --- a/drivers/tee/optee/rpmb.c
> >> +++ b/drivers/tee/optee/rpmb.c
> >> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> >>  {
> >>         release_mmc(dev_get_priv(dev));
> >>  }
> >> +
> >> +void optee_rpmb_available(void)
> >> +{
> >> +       struct udevice *dev;
> >> +       struct uclass *uc;
> >> +       u32 tee_sess;
> >> +
> >> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> >> +               if (strcmp(dev->driver->name, "optee") != 0 ||
> >> +                   !device_active(dev))
> >> +                       continue;
> >> +
> >> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
> >> +                       continue;
> >> +
> >> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> >
> > so both optee_probe() and this function will now call
> > optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
> > In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
> > don't know OP-TEE that well to figure out if this can deadlock.
> >
>
> I was developing this under the assumption that probing and init paths
> are single-threaded in U-Boot - aren't they?


They are but iirc the responses from OP-TEE are RPC calls in the RPMB
case, they aren't guaranteed to run to completion.

Thanks
/Ilias
>
>
> Jan
>
> > Jens?
> >
> > Cheers
> > /Ilias
> >> +
> >> +               tee_close_session(dev, tee_sess);
> >> +       }
> >> +}
> >> diff --git a/include/tee/optee.h b/include/tee/optee.h
> >> index d1194493780..755533b2c0b 100644
> >> --- a/include/tee/optee.h
> >> +++ b/include/tee/optee.h
> >> @@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
> >>  }
> >>  #endif
> >>
> >> +#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
> >> +void optee_rpmb_available(void);
> >> +#else
> >> +static inline void optee_rpmb_available(void) {}
> >> +#endif
> >> +
> >>  #endif /* _OPTEE_H */
> >> --
> >> 2.47.3
> >>
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
