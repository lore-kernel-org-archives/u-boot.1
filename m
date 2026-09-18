Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9ADC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 14:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C6F060D7E;
	Fri, 18 Sep 2026 14:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fy2tneXrZp8X; Fri, 18 Sep 2026 14:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3099A60D77
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789742380;
	b=Qcivl0+NHRfMmQG0BAp3UvKbyUm58r5AQTd29tnsJ3ymMXS3OvuwYOaIHb7WGeQamEui
	 wVXXvjuhRsonvdxTLdrK32RIw8b3YREbe32Gk0Hlj/TE9ZXd9IypR58o6wAc/P0AVpe+L
	 1lkKC447QTAgaxDFtKdV74ae94HB5mJ3lMxsFKliA37TFZu5VFqQkWjH59RwA5ieFffw3
	 nxIfQs1j157DhgTPoW17YQqV8VztgciJCgXUofdUAU7YASMBWGmGl15hox0T4b/P22kIg
	 Rb0iuBKs4HnFh/xLfPYBT94LP4fyuvNW7AxqtihmTUutuWEabkU0eUHGEU0eekAAttA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789742380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
	b=aHI3ugoCVu7ca93HTOwza7SPQ5jTd0mbl0c77L3ZV/ZaO79MCnW9/CrZ9ad1Ejb9kaH4
	 ojiWScA0hw0ZGebJWc3wl3Nlxqi6M7diplOnzkN3KrjytIVWm4prGmkiRBR/3ti6DSo5d
	 +sLSOPMr+ksvnZq1J/Bmuof0O+RxvnSwvhV9PP+XnGCftwUJ1bqCktFYmRpBI3h/AQLZf
	 2kTGri0Rd8XZWE+a6kXKoq0LUi3ncPwV+eS0bTG60r1Ig10XzsYGD1yh8D7eg/5ppItMx
	 ihRH2YtTsaCHf9FVjuUiEM0mdATg0oIuvj9A6fRv1YWqHvZ3IoqGZ9A/POg0se+UGqA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789742380;
	bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dfcKOjOPUCNufxSEM5tNVlKzkaOU1pvQFNdnhbqE01NdgDau75TF3MT8u/4VsKHSz
	 QZZDwiWa51Nx4kPLIZqcYiEAFFDRo8jYsQEGh2u4/OG7AFCWpMK009/lna2h3vYRwy
	 D0/l140mqMebdVJcXCkXTeacIBNStjFkWhR+8xQ/IAIzayAldd4TjwYdsU++1ZzSSx
	 vl+FYdm1ZgB4/2irWe0SYDukCSsjqgSJK/BK/4VZHC54JCUgiZaAb+pNoB3QHpDG59
	 qL3+ikzSwp3sFumSePRrrzl9hD6MCnl09rzCvpj5Sdlk02OVJufJ9PTz0NzE/xZK+O
	 xC7GoBO1yQqeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3099A60D77;
	Fri, 18 Sep 2026 14:39:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8642E29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 14:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48CCE81274
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 14:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lk5_Tta3a_gc for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 14:39:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A73A811B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::1b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789742377;
 b=jvMHrT9G7AE9hfBDVvTTKZ/VIfwXuG6MWB+YYZaEjhElhqZN8KdkqWi4/5dBy0pLBxS8
 /m5lwYDxU/kU9bitTVOq7NANY/I1IxAqBj5d1sviJEdm8Is6kYfxSzE1zokqpw5hBAFXy
 6ibDwdM/tPQFoEbWbFdnpiO6bl5CmBWnOx8x12wZ0q9ECKeuxzJ+IecrQglJOUs/gfv11
 BF+q+hEwG7cmF0aX3FzMU4/+tSe+66tsEClfd2bhpy4WhPueCrbDGOls8tWMXR2eD4mME
 b5uA01NmvRKijqMGUlPot3ujUx8gB61Mufz0MaXmMr4loDDRIpbgyBhA5xhVg2EJ37g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789742377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
 b=GFdBFvqMQ3L1RPaLMLkaGMOohOKdVieINz1s8XbJUSwJT8GWBbFY1yzinmIXDVeVmF1o
 Ruj6VspdrQcTHA3Qech4PcReNTVaTw0plcdqjF43J7fOGsjB7LonR3BkrL0/S3k3Z3OBr
 jfas5hmKBLzpgHG5jwT/+MiblpFr17r26snxabm/1m8xGGBl3skT7MD0bYAhRYWrCWEym
 Yv0AeR0UdmtOG7ReXqLCMmsii/hpJGV0SMSoss22Nef/yO4sCG1aSCKFz3/qckiTlaMlX
 E2ha0RsrxZAGxUq6fEHRHlvb9k4gH/Sgu6mR9sazT3mUCFOXMRa8SZzLFrRT8JnFu8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DBvlKgqE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::1b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::1b; helo=mail-yx2-x1b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DBvlKgqE
Received: from mail-yx2-x1b.google.com (mail-yx2-x1b.google.com
 [IPv6:2607:f8b0:4864:41::1b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A73A811B5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 14:39:36 +0000 (UTC)
Received: by mail-yx2-x1b.google.com with SMTP id
 956f58d0204a3-66e4aa8e6bdso411172d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789742375; cv=none;
 d=google.com; s=arc-20260327;
 b=jTETeG7yxS0wfjj7VhrFVgstwd2RU/zu01IYeh6EwszeEWhZsa/aGfr+QCahIdp+mn
 X7AbZdP/v5+LEqlg+L42rB8QeNFGbrcfg/dqLMZ70hLXXZTbPZNyLeNkcAuhGjE+y7S8
 rbOniWbir2hZTCeqNFIrKA0n3agYUThPCiIOdYnABWZs7hw0X5JWfvz16+rysGgBE6ZO
 w4BY1EO0K1cGgGGQ/O1vSrR0dXXgGm9j5r5H3U161j01oky1Dl+Q8vG5X79Euq1J31Pv
 MWaE2HjRVkj7w9X9h0DMbEi00fs9s621WwApzN3tWUoo/eEOMiZ7X8uegsfNhthn8tcK
 LrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
 fh=5La+CPK+POE4mNBXB/PDk/tei65NLo6nJUQ3o6TV19U=;
 b=mE8ikDglervIATbVKbCfULz2RsQxtH34J1d00O5bMqvr8OXmOMDeIilFjSWvafGceC
 kQhzsVyqpGsa++3o2iQZ8AgBRyS/bW7y90N04iRAqbSbxhAA+J09tNbxTtkmObmMc6h3
 gQ3LV6DsBW/IGYQ4Y0juDI/1KCPIhjzJkaBNAg2a3sJEnC1TBzY7AzopsPiN6ja5hAvy
 F5pWMIo8ot0g5lJ+ihzd0Ii967iGzRQcNt4iLVGe0CIqvGjXHZUBCcbiW8SjPC8oG2ld
 iQyANoZ592qqTfnd0//yqsInUurQaOi71aA+D2gbsB1HpSrwOVACys2sBJxik8IYKbC7
 WtIw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789742375; x=1790347175;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
 b=DBvlKgqEgUfHtnuIx3yQfKAdRV5pL2UPcpOI4qd2ICcQt2xSYYR01dtWm6/g2KH2vl
 w3SMMR03dXzLYopwMexvdyfdijuarYKxDfu1JJN/roltddsw+wNyFXqjQg/vyBGWDgl1
 xP5pqId1ZxbA6HrqkH4JX/+gcsAyVRP68Im7kWeawkt1/5TDa76up0CF03DhmcjSSbyD
 4vaN8uw9LJPhezxJW2T73/BdE1jdOhdRf3of/AVqgHEQvxg/Xjg7Gy33I5r2xa3iKHVG
 HDKQxwAUI1/+rsDjXm4QQBPc2y5wO39u6B0jbbITJKN+OUoOjMSDatDVDg6wIpCNPUVZ
 Iqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789742375; x=1790347175;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99s6uWyj6GkGS6rB9l0hAvQJ0ZWEjMxQKySawB/Uwtk=;
 b=uN7G++VChodEe3kZ7K3MLK+u21WahQ8YlHo+N3lalJyjWbAWHdxYl8pY26Bq4JXl76
 1e506DNbFcRFaCJTwqd5zlUSvfMDSFTFz5PpTQ4X6ccMygl/QfIf0FZj0Nl5rQdGg6Xz
 zw1bgYSgdmIt0/kTMq1IPG78V3bFHo6RqNs55F7pZp4XtA8nWIkdYRzUFMIhjfCHTFIg
 qp3bproUBwdKvo99+g3DmstENrx8Zmw2jjuKbEcszWb1yYXnrx4ZdIbvUxjxEaMpWL3A
 dd28l66HvPhDg9xmLWGa3WrYIacPAUwXkALVd1i668Gy21HPlmhBnRy/PIyDOUCwqjym
 huVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwUvxNUc+y+P+oN6SNlVelVQUmD5htSkCC8hnll45dPE008UhalKw+0l7mMkhXf56bI5JcJRY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l3OrdigEQsONsU5/WqsyIK5hm3P2Ajm3tMR5avvTKhqnuWy8p9
 gLQ8obgobDj6HJx/NKS8S0bCe061EP2n+8N6KsOFnoaI78+Y+dFQ084W7kfxwKqlUMiWtH2uh+9
 +KNadTBpg8dLAh7PdVibA1yhUXEHD30gp1NMgqKfAzA==
X-Gm-Gg: AYBFou0W6jN166/B4lVOzbtM0nll7tf6abbBkvo5COpNIAG6bCUZY7svDm5WrzAFSGH
 UPmvhl5IOfILBxOMErvFSfKyuIHJXbrXBIxF2LkMhTcFqlE3YzpTlnt4S1ys3dpf/mZHoyIj03c
 RuzdcUxReI0YQfO/KYGyjDZXSFs6+m/fzMN4NXhMpaHxgpvlaiPOcM2xAs29hhLxIRT8nI8JUA+
 5KieGb/1KLvUbTqAvKJP02HZer4RXNQf/feH0+zLy1avyrI4SHXLZRlF8e08blDqfyyxIo9t5K/
 cuALERZnknpdm1mc0oZ7Z9O1u0GT6S7pomaK/xuHm+m2pwx9A2Yh/pmBc+ZOn81VWT8j4+8ZDE7
 JlhKc9m5H1gfUSWBuCDJyB0RTmWBgv2Ppdim/SYSVBoc2aQ07vCsRyad9fGkPL8iKP3gwNKzjio
 ofj/wkzWlNtKDKZJAZ0sJdOTHwISCao3y7egvORXmvougMPrs5Em4lZhYKRBADQjKgyeyIsjr4b
 7zfzpUGuogDgo3J68r/vyNrQrb/CCGsNO+7ReRFwkNCDYurLgZQW6kP9ZGCaZXz/zj9EpPFpIyh
 dKyadCJ5AQn4OhLVmz3goTo8pE6sT6mq7yV3rLr6E1P5ebZKu4cTZQ2OV2qUEZEGEPk+p1mwhCF
 ft1gxbbhcWJR+iW7jZcmjo120LhkXFBOo/t6V92zUI1Yo8Ip68Fsk8g==
X-Received: by 2002:a05:690e:4841:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-6717fdd768dmr645132d50.13.1789742374891; Fri, 18 Sep 2026
 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
 <DLHP3HJCA217.1Z4YOZ4KVQZNO@linaro.org> <aq1AZXpdeEHLmPYw@debian>
In-Reply-To: <aq1AZXpdeEHLmPYw@debian>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 17:38:59 +0300
X-Gm-Features: AcwNN1V09fj62Pth6R-bJIyWngrvq1Fpldchvlq0aZjZKEA4DpKr7AUVXFqWG6w
Message-ID: <CAC_iWj+dfO56L3njEzZ+wvF5fGh-gYr6D4h6HaakOdY2-o33Eg@mail.gmail.com>
Subject: Re: [PATCH] fwu: fix read buffer size
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.u-boot-project.org, 
 Etienne Carriere <etienne.carriere@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 18 Sept 2026 at 16:45, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> On Thu, Sep 17, 2026 at 06:26:37PM +0300, Ilias Apalodimas wrote:
> > Hi Vincent,
> >
> > On Tue Sep 15, 2026 at 5:29 PM EEST, Vincent Stehl=C3=A9 wrote:
> > > When the trial_counter_read() function reads its counter from the
> > > TrialStateCtr UEFI Variable, it erroneously computes the return buffe=
r
> > > size to be the size of a pointer instead of a u16.
> > >
> > > As the UEFI Variable is always created by trial_counter_update() with
> > > the right size before any read attempt, overflow cannot happen in
> > > practice, but fix the size computation for correctness.
> >
> > The fix is correct, but the commit message if a bit off. The creation
> > is not the reason the read works. It works because the current sizeof i=
s
> > always > of the new updated sizeof so the GetVariable calls has enough =
size
> > to fix the output.
>
> Hi Ilias,
>
> Thank you for reviewing.
>
> Is that not the other way around?
> In the patch the call to GetVariable() was truncated but here are the
> details:
>
>   status =3D efi_get_variable_int(
>                u"TrialStateCtr",
>                &efi_global_variable_guid,
>                NULL,
>                &var_size,                  // data_size
>                trial_state_ctr,            // data
>                NULL);
>
> We are telling GetVariable() to read as much as 4 to 8 bytes
> (sizeof(trial_state_ctr), the size of a pointer, in var_size), into a 2
> bytes buffer (the u16 pointed to by trial_state_ctr).
> I think what saves us here is that we are sure the variable contains
> only 2 bytes, which will never overflow.

Yep, I misread the patch the first time. But indeed
efi_get_variable_int() only copies the actual data length

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Best regards,
> Vincent.
>
> >
> >
> > Cheers
> > /Ilias
> > >
> > > Fixes: 7e9814cc6c1d ("FWU: Add boot time checks as highlighted by the=
 FWU specification")
> > > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> > > Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > > Cc: Kory Maincent <kory.maincent@bootlin.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > > Hi,
> > >
> > > This has been tested on the sandbox, with CONFIG_FWU_MULTI_BANK_UPDAT=
E=3Dy
> > > & CONFIG_FWU_MDATA_V2=3Dy, and with a modified fwu_boottime_checks()
> > > function doing essentially the following sequence:
> > >
> > >   efi_init_obj_list();
> > >   trial_counter_update();
> > >   trial_counter_read();
> > > ---
> > >  lib/fwu_updates/fwu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> > > index e9bb1b4fc65..24a8f1ce5b2 100644
> > > --- a/lib/fwu_updates/fwu.c
> > > +++ b/lib/fwu_updates/fwu.c
> > > @@ -82,7 +82,7 @@ static int trial_counter_read(u16 *trial_state_ctr)
> > >     efi_status_t status;
> > >     efi_uintn_t var_size;
> > >
> > > -   var_size =3D (efi_uintn_t)sizeof(trial_state_ctr);
> > > +   var_size =3D (efi_uintn_t)sizeof(*trial_state_ctr);
> > >     status =3D efi_get_variable_int(u"TrialStateCtr",
> > >                                   &efi_global_variable_guid,
> > >                                   NULL,
> > >
> > > ---
> > > base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
> > > change-id: 20260914-fwu-24265a691f9a
> > >
> > > Best regards,
> > > --
> > > Vincent.
> >
