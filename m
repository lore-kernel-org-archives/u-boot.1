Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B7EC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 15:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49A0E406A5;
	Sun, 23 Aug 2026 15:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MLFGvakqGhc; Sun, 23 Aug 2026 15:00:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497247;
	bh=VOkXyrlEQziZZcx1wHFhF44FmJ/w1Ece3FTY2wRjFEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wgIT9hiVPKblRo1KMyxGkPHMQ5pwWEioohpeXd0JvSA4+Hlur0jt+V+z/EXg4Ayts
	 v1jira4uVN0z/+0ovS81G9Dy732js+DpUjBz/Fa5RB8SiQPTKp8PZou4vFPGOZKakt
	 96fbnEORDDdb8Sodt1HznYHoxJWrDJ+ttTKZ6rQ5WiYXqaNPEy5lOIieY9M73YrAbf
	 Q0NEqlU5atVXMUS2M8lEO0BB/7uvBn+npgy8fjFsChptJ8SMfpS8+TOYyNmy/zAqNN
	 Pm9Hp4oiQFpZQ5sWBWZV2CHFuoLRT2aOMOJxDrdQ3H/cefG6ZfuRGjIJp3Pg+lIRoM
	 Ty3+G1C1wLKvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADE5340532;
	Sun, 23 Aug 2026 15:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 464BB336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 382CB6064C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTuCBpN8h_Gc for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 15:00:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=petko.manolov@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Z+65ybAR
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21C866062D
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 15:00:44 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so3182999a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497243; x=1788102043;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VOkXyrlEQziZZcx1wHFhF44FmJ/w1Ece3FTY2wRjFEg=;
 b=Z+65ybARDatO05PZrpxi4YNptKaNjbR/K3YERF3Ywc/NaBz950Y86ea17UGTx8WiG1
 ZnMxokCGjBizceoNLiH3XIbmIGyPBSkigLVP+zgQSC52quzkmmWoo41sH6eatskHXiMO
 axlKBhMCnJau3QnCZrLB8aAqyYFzFkEcMEuFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497243; x=1788102043;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VOkXyrlEQziZZcx1wHFhF44FmJ/w1Ece3FTY2wRjFEg=;
 b=W6dkQEaXNqsvNMraFDdKpgeJbYF9Mfv0y3hMotqvm7GbvYreO/RNbL5/w+9tVUrVgw
 3yi+ZwqF+A+h1FRhXAw14bRBA78wy7VWCxOl0tt4qGrKdiqS7h1uiBwYitXKY/voshqa
 JI/BTQQYsw2GnRDAVjPBmAIyBWgCPYHjmW8et8bKzBSQbltR4XrQgRfKohzNDBpPLsIv
 bgHJwdHqm/KvfofuspLTWHdx8LJ5/i3a2vkEN+KpJkAjzNkLAdBVtlekxe1ByKC4ayuI
 mEgJBJj/wAqEUp1GQfiF8rynwXuU/Q8YaXgNdgpuwhMf2iW0vficqSHpDWrGDX1A3pE9
 jXLw==
X-Gm-Message-State: AFuF++m5p7ojpXvpxCYmlpMml381Do/WigHKK5wGAPzz28CZaOJVzITa
 Oja78X2poco7hM3FSVAryvN3Im5qM6A2yWnwU2AY9MbA678JJrphAdUlZsnk5ljo67I=
X-Gm-Gg: AR+sD10tbgvArW2Yiv1VyB8irrUCAbH68xzJYHdE0pg6g+Ck+gElbHaotzLi+FowYa/
 ZqQhQ/UV79Qvx/VxFcWO/mNYKSA4a2CiLVrUWYfNNNF1f/WOyUp6+uIGkYxkRS/Imb5eheUynPi
 PeZ9fpyjXaEBYi9PmS+ZlslIwelOGmM8wuaGa3fUh1VtpomVtsj72Io0TC8s5eTr0idq+J1S/E5
 JBEY3KFVlKvQvmeIFGtiAwOMGD1a4PiFDFYLybdTSvLvxqQPeWZUrOpG6YUuNuQVztHpleJedye
 mo/OKHI8J67OIvzjQJAK9jIfjWZGi9vya2DB2EmvZ9C9oeQn8KUhNmdphljvEexA9En9q3yORjv
 t/lTobdw+/cDL+i7emdvGB1XB51ainOxtFqRmsz2BU3NXy7Y50T41fMljZB9lnA/ERyzsLC07gK
 OjYix/uqM5UmjjEbaalQiPNmNUs9qIxueveLqdyIvnEmHbZinDBj8M6i3EOE1+8id2aYJf
X-Received: by 2002:a05:6402:1ecc:b0:6a3:74c2:3cf3 with SMTP id
 4fb4d7f45d1cf-6a582b0c826mr14318037a12.6.1787497242662; 
 Sun, 23 Aug 2026 08:00:42 -0700 (PDT)
Received: from cabron.k.g ([95.111.117.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1cdbe9sm3653842a12.24.2026.08.23.08.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:00:42 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:00:41 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, uboot-imx@nxp.com
Subject: Re: [PATCH v1 1/1] arm: =?utf-8?Q?draeger?=
 =?utf-8?B?OiBEcsOkZ2VyIE00OCBv?= =?utf-8?Q?n?= NXP i.MX6(Q) and Intel/Altera
 SoCFPGA Cyclone V devicetree.
Message-ID: <20260823150041.GE17052@cabron.k.g>
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
 <20260819153014.834228-2-petko.manolov@konsulko.com>
 <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
 <20260820061912.GD24421@carbon.k.g>
 <CAOMZO5AfFXrpN3RMPuYw4vM=AHOWBj6hnaXdG8W=KhSsWj5big@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AfFXrpN3RMPuYw4vM=AHOWBj6hnaXdG8W=KhSsWj5big@mail.gmail.com>
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

On 26-08-21 16:33:20, Fabio Estevam wrote:
> Hi Petko,
> 
> On Thu, Aug 20, 2026 at 3:19 AM Petko Manolov
> <petko.manolov@konsulko.com> wrote:
> 
> > Unfortunately this board runs QNX, not Linux, so upstreaming them doesn't make
> > sense.
> 
> I don't think the OS running on the board changes this requirement.
> 
> Devicetree describes the hardware, not Linux, and DTs from the Linux tree are
> also consumed by other projects, including U-Boot. In U-Boot, we have been
> moving towards using the upstream Linux devicetree sources rather than
> maintaining independent copies of board DTs.

I have hard time believing the respective Linux maintainters would like to waste
time and energy upstreaming the DTs of a board that's never meant to run Linux
in the first place.  Will see... :)

> There is also an important review aspect here. The Linux devicetree
> maintainers and the subsystem/SoC maintainers review the hardware description
> and its bindings, including dt-schema validation. Simply running the
> validation tools locally is useful, but it is not a replacement for that
> review.
> 
> For the i.MX6 part in particular, this is a well-supported platform upstream,
> so I don't see a reason why the M48 hardware description could not be
> submitted to the Linux devicetree tree even if the product itself boots QNX.

OK

> My suggestion is still to split this work and submit the i. MX6 and SoCFPGA
> DTs to the respective Linux maintainers first.MX6 and SoCFPGA DTs to the
> respective Linux maintainers first. Once they have been accepted upstream,
> U-Boot can consume those DTs from the upstream Linux tree and keep only the
> U-Boot-specific additions in the *-u-boot.dtsi files.

_If_ these patches get accepted.  Have there been such precedents in the past?

> > Can i use some sort of DT validation tool that pass kernel's requirements?
> 
> Yes, the kernel provides dt_binding_check and dtbs_check targets for
> validating DT bindings and DTs against dt-schema. You should run these before
> submission, but passing them alone does not replace upstream DT review.

Yeah, these should be run against the DTs anyway.

Does it make sense to start submitting the arch part of the i.MX6 patches to
u-boot while i'm busy with the DTs?


thanks,
Petko
