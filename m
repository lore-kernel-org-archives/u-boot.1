Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4D7C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54D3360D62;
	Fri, 18 Sep 2026 12:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j6PfeB12rZm4; Fri, 18 Sep 2026 12:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E26E60D65
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789736323;
	b=E9r6ivo0/wrNclX9QGog/zqAVsZs5IdUpYDSWeuCdgGVTRTZrUMUE9CIdQT5GBmIUu4j
	 j2cdstAeLtsa8CPPiV0ux7UEHhHTlfy9ocOs1RcThggzuv6Ns4deVSm9+Ev8lKRHHm84u
	 8E5e8cRk7m6abBH1t0mjXSP/1bM4f4naldoPfsX1E+FK3YPctXcS48/gjCCtbwrqlrLdQ
	 7hO51LvjPmxPA8+oTvA8ldmbJPmC4ZllBGPrLRvUf/3LLHHfmxGLhGWk48pyquNLSfCol
	 /ky+zSxKRgJWeIlndzjfdtSwM2yhEaWx2Nfn9tVDGXJMl1Ldr/8KNh8MMbzQMWJgPfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789736323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
	b=NKCPeAHhYLs0rvuq6PrKp/cIvBwtmAMu5ThrkCKYMK90h6oDTC0sEMNCQnsX7L53cNVR
	 IKcDxnYx2uXjr59YDSIf+Z8KsDEO/lJVqoLR7htOIMpKhRnEc0vlxr9XeyBrJf4feRZb/
	 ptOnEptjFoVB95ErVYQZJhnFcZoH5shsptuReSg/1b1IKhlZcp+ByjwZaqh6H4UpntI8N
	 v1XOep5Yh66U1H8noQTDO6zqreGiQFRYnqwGHBfk0NIp0GI1SJg4x8JkGCU8fbetVg30/
	 e6nvw6Xg1bmFLqFHFG1HebgFgia2fyeJgv/r0l8a/yKCMb00EeSWInhTvdIjwfCiSMQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789736323;
	bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OooNOWW3tvZ6pb7EGoGy1sZGs+i+1kBXv8poB2bD3FoP7LXbaSqvRiTIJHmsIOLBk
	 0AlNkSakyKWxKPtD96z8eT50TIL9h90PjcZw7nU0ztsLWM+j/OODQ1XxiU/k+qqi8G
	 8lrVb2J8MkKCzK8/8JEYXW6aZgylZBRZtEsX85vRWZVvI5BQploJDtHW/IS9IOWkEB
	 SbxyjEPGgLP0Nq/GpOz0CNmewBmGxa+Z/pfXyQpgXwWPi/+lRUhiTNXoQe0Iijekwa
	 gaLLpcDsFkDXb2kZIjTzjqxt0Il/nD0BrRoxAA2yLtAcOIPvGhOzDEk91KPj9pYZwR
	 wh4cGKY3zJH5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E26E60D65;
	Fri, 18 Sep 2026 12:58:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A82A224
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 605CF40524
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ErXpwhy1q30 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 19F78400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::19"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789736321;
 b=FnitQH+96fs5zF0/sx2Sf8KI891OZ5WRIZK47AV+rCoc4QLcKGUaz2YIXA/x37eEUveI
 4Q099j7bJuFZJ96SWIXIo0210+2vvzcHwGrYL9LOO3Ui7Qgd/gMkvxowco5hl7PziFENe
 NQpg0mRX6EwNMSuYeelDFQwpIM/7vO9/J2oldC4B2RfxpoN29EP1ICcW2SiSIWrBshuMn
 kZWeY8K/9lp1MEqQfknfjTHXxMIE5zSijF3Gd5grmkPm4xfS7LW5OV3wd0iKg0JnMJ1Gt
 No36WzxdQnhWoHEb4grC8apju6Qw5tIMT/S4IGlCDrzPXyqsWZ+GGQg+83tUYneGDGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789736321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
 b=USi9ehU3qPCUktz+EgEfOkvewOP9h1I5b07/xe9mOijECPvJjCjC3q22vAlHZmMdVEjy
 7ao+amF4mvE7dqjjziGloENS6/EOVLse5stYqAzUIeD9lMzrHjqiU3xAfoeOfW7deTsiA
 uBvJGhBJgjQA+CBvk9LO/7nQgdizSlRi4ipWwLi5jIdyJhEyyDvFkxM0X5zWSSbfU3f2F
 9oLpC2gNCD55f3Ou/AJmcyIQetHuoZ3Brp8BkMAc9OILogFCHS31q3sXATvRI9kWTIeql
 EMHd2AiKkHo7r7vRUQOSZ+6dQI5WpYVdtkakxepGKKqq9cTaI0KaEmOaQCtnolha0Bw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RwO6d1J6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::19; helo=mail-yx2-x19.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RwO6d1J6
Received: from mail-yx2-x19.google.com (mail-yx2-x19.google.com
 [IPv6:2607:f8b0:4864:41::19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19F78400B4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:58:40 +0000 (UTC)
Received: by mail-yx2-x19.google.com with SMTP id
 956f58d0204a3-66e4ab1b9f7so350788d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789736319; cv=none;
 d=google.com; s=arc-20260327;
 b=CAnFEbKwFydI5r+4VtsMap93ESmnYlLkJj1p3WalcoCup0HLA467wwwKk17CF9tfZh
 mb2kCeV6jdiSEZqywZ1OKfVxyJfJygsWBkPS/We7HkezhqJkMtsiyG16T04Q7kBMmoTJ
 3wGc5bkQi5aVya+DRnqbepVPmsk4CuD+OkBHn/aBq85/Ed5s8pISJ53P2eCaFPV0yQnv
 BfbWqXeLg/VG5jEvb5UaJ1vdx7ttuXlijNz54uYXhZDeFYMDY1iAfJuUUSE8QtcfmKuz
 uwAU984aaNTGM8wuHXAkxAvzo7eJOjHo2dM2I9Zkotq/HaiEZJCUqA3sX+t9mamvga8o
 253A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=KpsvT4mJgzM1jSOP/sQTdUog7A0WSC6aGeKN9Qn5adOVE3hd+Sd1ciWzYVC/Bpnmr9
 3RwNo60x1bUKpG8SnUZi0hIOR8/cB6pQOEQ5TADl1Ph9ePlhMGG2zJWPyo3qOjmHnJGo
 fLyWhm/S5m9G5kzSqv2ZpY+fpyJz7nm37fMHh0Ot+R7hGO2g58ZF7AnbiasC5+7Wb+0z
 wH6hPl5zq149H9aUIDMNjx5+GOkwngwzt46b68+ANKhu6y7TrJAgiDddomPfxSo3ncx6
 Br9DcXqESfbQz+7gmiHwBF/P7LBr//GzgvCPiZejeneUBi8wMQ8HwKvMuhKarkPEhSBv
 DYyQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789736319; x=1790341119;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
 b=RwO6d1J6Dd7BHWnbFFKA4OuoyuMX3hwY+77s1GXD5/c007Zc6pAbiNstI1hoXD/9DA
 Y6hrV2a6zdp9Zgqj4oSsiOepfikqaokvb9brmaAf1LHQ0ckheDZjASCojz8o+NVIooat
 kC9/mSuVDOuGXc+BZE7jY7guA6/NobNnmXjGic4hYxdfwD+cOgXjWWKPJoBhxR/faV5Q
 hospYWYkD6yJa9IrjMy+SPceXjGgIwJKLBmJ3+/6HlirycDzYwamoJYeDHxumqBUJSUD
 kIrwtXkxPlB3p51mG05Lac1QvLVapyfwtSHfF5S3ZxZxOFIaySOEoMOqOK1uZCSmtO/U
 Uaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789736319; x=1790341119;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cLqYv1TEKqZbkvaPKnAQ2UZbxDBKERc0RWv/qPBaLrY=;
 b=G9Vvtb04YNLMyvo78CG5VzG4s/h+W5pZ5OW5+qqCyxPrIRFVVFxpa34iVZS4nj7Zhd
 4jzlhpKOTBbTuzx46SXopNpuHfnkiwSy0EWQhAm1lK14UDt2t46tniLzHxOEYomaxiYF
 MS5TAOlX2WgTPdF5EvWhdTEv7SCKvpBlKB91oENoD3R3mhsjWGn5jk4KPEB/YsQlqQXg
 MPUCounMiwTypogOYg4gkhWkyR0QwxhQ8iGEH8pPpyvqGIzrz4OJUiji2ltM/XN2Ikbh
 85y7jmlH6CDE9RMb3Gzonlohw9icNbegDEsqBBnDntac1XuQXEyeTugk8lzhcbzzFeJN
 FD8A==
X-Gm-Message-State: AFuF++m2S49QZQl1T/LDCQsvYlxB+/w8bwGbPFxtJlB3KOWMULWZHUVw
 xRfswyeEPnJyKsvvrNwdXsPtYuWMCfNDClkkAaZkVMLaZILrBs04nDrUiLfAnH/bga/ql/2xnoj
 IqjQt8jfJlgdRIahentAWDmvFnHhjDWM2lCQJ9GS8JQ==
X-Gm-Gg: AYBFou2nO/x4XyllTOaFNmDCW3YnsTR0+1I3UFLyCN0kClfufBlr6ekPz5BzA2T91EN
 WH+Opwo3ToIOqn0iPOCX2GzcwDhWwTXL6JFDQzyXj/6XTj1LGLrSX3/B/Qn/BBXA8PLc+GCLl3/
 +gCigt47A+D24VeRqgCNBaHiZG+tad+E6084cr12mC/mJB5VR8IEU0Y+PQSYKVDGzJ3luq8/86O
 relECWFe3ejmqi178A98cR6BOJGukc2Brzcx9MOgxsvEyaNMtUVsxbnmQ+C3ifkX0CEHdTXmLPg
 wlyPN/tDO+5yixmIT+G71flkM2cCuvnCeAIgBpVvQ01fe8wk2vFxmYi5yKgJ0UbSvzAWympYUOY
 qMNOfKXPJWdJa4ajX95lbD3lwmu20Xg7oZL3wpOCkZr/sOeQgx5PBJx0PNPaQhUr570sIk/APxF
 4wLMc3CFdXebbOnaH7woFglsVpv2401RN0c6ccOx5fOBcajxz4fACLNLW+6t1qUY8WbsxUClWT2
 bxvCLhpmjjvblk1lc5UvXr/I8l+7iIfwIJf2pF9i0PGHVmQJyPsqluGjn94r+tYWyu8m7VXXf9X
 4S9ccRRUa7APqq1gXqAcSAlhoUEatYDXTmxpDGtY8C/as/URyRmeWb+bz5FP9gszGg9NSiHZuCU
 lt76cPj3jak9pWi/9BrQdEwnrpmFuqPj1t7E3vCT44Oc/2Lyp4JQR4yiYgpAXMMg6
X-Received: by 2002:a05:690e:4841:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-6717fdd768dmr579956d50.13.1789736319327; Fri, 18 Sep 2026
 05:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-conform-v1-0-475b2947631a@arm.com>
 <20260904-conform-v1-1-475b2947631a@arm.com>
 <CAC_iWj+y1YnNfhijUdtzJhXJ9ig23dLnV9yBgZcT9sB5Kipk2Q@mail.gmail.com>
 <aq0wKfYmEAOcUZks@debian>
In-Reply-To: <aq0wKfYmEAOcUZks@debian>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 15:58:01 +0300
X-Gm-Features: AcwNN1X-0P-UZF6_jH_i_NJaiRRgAGcQiF_mZXpIIm-241c9HzX-7G-l5JBQKBA
Message-ID: <CAC_iWjLhCKXiOcM3bPZi7hp_BXG0TN_bf756it+CE50LsJqPCw@mail.gmail.com>
Subject: Re: [PATCH 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Vincent,

On Fri, 18 Sept 2026 at 15:35, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> On Thu, Sep 17, 2026 at 06:04:07PM +0200, Ilias Apalodimas wrote:
> > Hi Vincent,
>
> Hi Ilias,
>
> Thank you for reviewing; my comments below.
>
> Best regards,
> Vincent.
>
> >
> > On Fri, 4 Sept 2026 at 17:01, Vincent Stehl=C3=A9 <vincent.stehle@arm.c=
om> wrote:
> > >
> > > Adjust the EBBR 2.1 conformance profile ECPT entry configuration, and
> > > prepare to add more:
> > > - Introduce the HAVE_EFI_EBBR_2_1 non-visible configuration symbol to
> > >   compute the actual system conformance status with the dependencies.
> > >   This will make it easier to add more versions with a chain of
> > >   dependencies, while avoiding a chain of nested submenus.
> > > - Adjust version 2.1 dependencies to better match the specification.
> > >   Relax the dependency on the boot manager, which was introduced in
> > >   version 2.3, and make the list of required UEFI protocols and servi=
ces
> > >   more complete.
> > > - Reword the EFI_EBBR_2_1_CONFORMANCE configuration entry title and h=
elp
> > >   text, mostly to separate "EBBR" from "v2.1" and to attenuate the
> > >   redundant "table" mention.
> > >
> > > We do the following additional configurations dependencies
> > > approximations:
> > >
> > >       Configuration symbol  Used to approximate
> > >   ------------------------  ------------------------------------
> > >   EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
> > >                     DM_RTC  An RTC is present
> > >
> > > While at it, refine the ECPT help text to attenuate the redundant
> > > "table" mention there as well.
> > >
> > > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > >  lib/efi_loader/Kconfig | 36 +++++++++++++++++++++++++++---------
> > >  1 file changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 4cb13ae7c8a..40380876959 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -557,23 +557,41 @@ config EFI_ESRT
> > >         help
> > >           Enabling this option creates the ESRT UEFI system table.
> > >
> > > +config HAVE_EFI_EBBR_2_1
> > > +       bool
> > > +       depends on EFI_LOADER_HII
> > > +       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> > > +       depends on EFI_RNG_PROTOCOL || !DM_RNG
> > > +       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> > > +       depends on BOOTMETH_EFILOADER
> >
> > Similar comments here. The BOOTMETH_* shouldn't be a requirement
>
> I think you are right: depending on the boot method is a bit too
> specific.
>
> The original intention was to advertise a system as compliant only if we
> could guarantee that it would boot automatically with UEFI (in this
> patch with the default filename, and in previous patch with the boot
> manager).
> There did not seem to be an easy way to guarantee that with the
> configurations dependencies.
>
> What you see here is a second attempt, trying to -at least- avoid
> advertising as compliant a system, which we know cannot boot
> automatically with UEFI.
> Even for that depending on the BOOTMETH_* configurations is probably not
> good enough after all.

Fair enough but that's a bit of a chicken-and-egg situation, tbh...
and it's not straightforward.
For example, you *can* boot directly without bootmeth* if your default
command is 'bootefi bootmgr'. And I think it's better to document that
somewhere, rather than not exposing the ECPT entry for people that opt
out of bootmeth*

>
> I think you mentioned that you or Heinrich could amend the patches
> before merging; do not hesitate to let me know if you prefer that I send
> a v2 series with the dependency here and in the previous patch removed.
>

I found another place with the same dependancy, so please send a v2 if
it's not too much trouble.

Cheers
/Ilias
> >
> > Cheers
> > /Ilias
> > > +       depends on !EFI_VARIABLE_NO_STORE
> > > +       depends on BOOTM_EFI
> > > +       depends on EFI_BINARY_EXEC
> > > +       depends on EFI_DEVICE_PATH_TO_TEXT
> > > +       depends on EFI_DEVICE_PATH_UTIL
> > > +       depends on EFI_GET_TIME || !DM_RTC
> > > +       depends on EFI_PARTITION
> > > +       depends on EFI_SET_TIME || !DM_RTC
> > > +       depends on EFI_UNICODE_CAPITALIZATION
> > > +       depends on EFI_ESRT || !EFI_HAVE_CAPSULE_SUPPORT
> > > +       depends on EFI_RUNTIME_UPDATE_CAPSULE || !EFI_HAVE_CAPSULE_SU=
PPORT
> > > +       depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
> > > +       default y
> > > +
> > >  config EFI_ECPT
> > >         bool "Enable the UEFI ECPT generation"
> > >         default y
> > >         help
> > > -         Enabling this option created the ECPT UEFI table.
> > > +         Enabling this option creates the EFI Conformance Profiles T=
able
> > > +         (ECPT).
> > >
> > >  config EFI_EBBR_2_1_CONFORMANCE
> > > -       bool "Add the EBBRv2.1 conformance entry to the ECPT table"
> > > -       depends on BOOTMETH_EFI_BOOTMGR
> > > -       depends on EFI_ECPT
> > > -       depends on EFI_LOADER_HII
> > > -       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> > > -       depends on EFI_RNG_PROTOCOL || !DM_RNG
> > > -       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> > > +       bool "Add the EBBR v2.1 conformance entry to the ECPT"
> > > +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_1
> > >         default y
> > >         help
> > > -         Enabling this option adds the EBBRv2.1 conformance entry to=
 the ECPT UEFI table.
> > > +         Enabling this option adds the Embedded Base Boot Requiremen=
ts (EBBR)
> > > +         v2.1 conformance entry to the ECPT.
> > >
> > >  config EFI_CONSOLE_DISABLE_ANSI
> > >         bool "Disable ANSI escape sequence queries for console size"
> > >
> > > --
> > > 2.53.0
> > >
