Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7141EC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 11:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F26080EB3;
	Tue, 21 Jul 2026 11:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhyufhaN330Y; Tue, 21 Jul 2026 11:47:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4208E80E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784634453;
	bh=ceXPfOHt26ZnYf1SDnyZybse6zjH6MYqNIMLbDQGJbg=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ml58KiLZTKYGWEPrJd2Aq4kBiNQ7TK/zMfpmdjVHJ+6Hb6DMKLGzm0jj3VuJHnrli
	 uBKNNIdO8PShnBUESVlXU4aKiC81az/9TAkjHsrsyOqNcURW3rIq/FivTvWyfx2PmI
	 A2Blmy46yrd4H1pS12iJLEX7NBPG3fKgKCapetGazd8kNOSG/2BBbAAUAFaZueh3I7
	 zR+yVXaCAfjai5G0RUt5xFzc1tTEhxiHjdAUohu7NxVBSihIB5wAQunsvkx8KZkBXR
	 pwhvVLlDaG2qlcEBR/y9Vu4osD3x/Js7q8NQzytPqyYmj9j9P+6wEHUNlrl2B8UHUF
	 PkltgtgaWg9Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4208E80E18;
	Tue, 21 Jul 2026 11:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03E14224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE31380E18
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7nnoOM21Q2j for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 11:47:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C01CB80DD8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C01CB80DD8
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C01CB80DD8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:47:30 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aebd52488cso11743878e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 04:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784634448; cv=none;
 d=google.com; s=arc-20260327;
 b=c1oH45k0XmMIGt5UFjk9XJsWEKP+4E5YFRcskScim9v77ajU6IWLJMuZj/7K3W5/Ue
 Udw6IpJParQSWMjkvbpStpqMjP7s4oHba8sAkrk3ECHUkat3IBIZHthngl3dMTTp5BP9
 2yXu3GlTuDHrVPxfEGlt7/B+6lmUuY3aRj59kBm3kmAYrgiMQ6qESIZX38F4idxQKO2H
 4Fa+SVlCnwQoSrPQTyBig/h/6IG0k7mLGVAD/VDg15UoKE+fk913PUNKG19fI+w4ecjP
 W12NT4kKMSOWL+PYPGQjunT8MqMW8uCXexky2xp0x6uyD/jAZ0KTtHIeBOGcdhf8zbAI
 Z5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ceXPfOHt26ZnYf1SDnyZybse6zjH6MYqNIMLbDQGJbg=;
 fh=kgmXD09yDQCUOmVWHt5ku5TyveYnep525rEIa2yxBW4=;
 b=esEhMmido+/tC3zPlLV7D7Cu8DRuIkHMxwCoh3OhQjmRAoOac0Vh8v36rVTjtzL7C1
 633R9YUXqXxoRTGzxg6V3nKm37Dolo2Mj9IyRl++bi3L4DRXkqdOuXU/j5X6r4kmzIho
 YKH2m/sHaWsLMQUw6+rMFYmMsPophmXtTylyBJ564QNqXYMQefQvAhzpMaLQNIxqJWpk
 2PHOHsXnTEC4mtiixhR5Z//dMflQe/y4wrXKMk9gJpZAfAMx4Hsj0w1RllKw+xgLCWJq
 5l5KREh1descfuEpwzX8AkJLTUC+FhInOB0ylzHoyst32/IhJ1pP7vuAOgMB9qgGTyxy
 /qDA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634448; x=1785239248;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ceXPfOHt26ZnYf1SDnyZybse6zjH6MYqNIMLbDQGJbg=;
 b=kfGoFaQCkT3CSVOUirOeXGvz/4HdizirW0afXOAjeVp3KU3RolG08QuZWtpQ5TGIGK
 /8YbEuxXglKDUOQzYWvyFKMJYvuazp7ZAvNiWmTeCBXz11WP8paCJrS2qSMmde35LXkv
 qKNpNtbsOr7QnMDErb5V5tuIPq6QtzFamm0j2qJHkUoem7s7OrSfwM0WkD/iJ/Qka86x
 QCgvQ0EFgmiAVkTFwGre+HrfJHrYs4XxMr0/8ct00t7ZFQ+N5rrvL2hUELF5Wil0lrbT
 ZhPzQDLkkoiLX/JNHAsKDerWW1yq/iHIV7JhztioxR8rQPIDGowqWwvQ6c/WPz3IVqgp
 M00Q==
X-Gm-Message-State: AOJu0YyzC4va/pJnQRHsT9l4RzP7jnxf6usPcBWGZfw+SdvFDpm1SAWp
 bCYv8+XLDniQQQqdOTcWZBRSiNt2BS1PlHEJoQum5BjGsvXlfXvOlVwphccsOvleP80F7uNUKjh
 Np+EAb26CTtFU5o6IWfbMcWo8YtTJprk=
X-Gm-Gg: AR+sD12ukjebBCXdCaZbJSyVKy2uCiXmBJ2B3be2LmEHXEC9A8R7FQXIWEEDtZQIWFd
 fy5HoEOmGBikyIjBFfe+aiLQh3GK0MPYTrMSKdHIKJgIU6V/gv0q72GlTrgHn51ewcwM9GwkWr6
 En/BnULh52Tv4IJ4m3yTSPjSk7Fp/nhxvAqpvfcjBsaqUbW/iLF4q1AWpr5QzdqibkNOxWHjb2W
 BcPXbakGfyWTR2hKivRk8fZxtPOAMbvuafFjyUje3AWLVy1qJI16dcARAIXHPJCNmfARx11Wbqh
 C3eqxsT9pUWjQRz96oNs7s72giLvWX5YUAk7boZOEsE6/TmFzxz6rif3jSmq
X-Received: by 2002:a05:6512:1451:10b0:5b0:23cb:91ea with SMTP id
 2adb3069b0e04-5b28f87e34fmr2640063e87.22.1784634447873; Tue, 21 Jul 2026
 04:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
 <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
In-Reply-To: <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
Date: Tue, 21 Jul 2026 08:47:16 -0300
X-Gm-Features: AUfX_my8Lr_2fxJ9B9hZdTAJ7lGGk7Ypy2iAqurEoIeK1eA4izrFDZ4E94AYnaU
Message-ID: <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634448; x=1785239248;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ceXPfOHt26ZnYf1SDnyZybse6zjH6MYqNIMLbDQGJbg=;
 b=gSlt/g7qByKz1xicsZKdcC+7BCgJOTh56cEX/X0y918L04tNjxzFj2VMiHOwuqFFqc
 lDkci9BvmhvgcfcGtIZrtmmsdzwPkniAic8701jACtv4Isz2TtHLLldDpXKYMylkmOBb
 Ins/j18H8tDV8RQqkxchL/HdwhugJi7hicWJJ2tQ4zta2zU2jeUV3EPmQ7AUWiVStXyK
 1ZKJRlqVFNFMzaehnnoAT2CQn3pdDTloVubQqucOn4UC3wDs5/RLcaa4V0AH44hPwobD
 S7v3Na7YQRtXul93HS6Q6IU+vc6tL2akDKMFk7WcACgOOt3nk+tVGeA5M6XaGiKISen7
 4hPQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gSlt/g7q
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Krzysztof,

On Tue, Jul 21, 2026 at 7:59=E2=80=AFAM Krzysztof Drobi=C5=84ski via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> [1] is required to fix PMIC access on u-boot 2026.07 then both [2] and
> [3] works fine for me.
>
>
> [1]
> https://github.com/kd-solutions-pl/rozalin/blob/main/meta-rozalin/recipes=
-bsp/u-boot/u-boot-rozalin/imx91sfrdm/0011-power-Fix-access-to-LDO-SNVS.pat=
ch
>
> [2]
> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566287.h=
tml
>
> [3]
> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566288.h=
tml

Care to resend these patches?

Thanks
