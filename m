Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD6CE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 17:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E6C868BB;
	Sat,  7 Oct 2023 19:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h00DXPWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8756286A26; Sat,  7 Oct 2023 19:26:41 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8580868AE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 19:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2773b10bd05so693680a91.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696699596; x=1697304396; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdJw4T8PASujMIkAB5JpYdzdWcL+solQFHyvKHIOIKc=;
 b=h00DXPWUM6+G8hKlyXR3Nq5UY3pCUWCKPQOvtTA+R5rHdkAtGxRJv7G8bTatyNEAyo
 OcDAbjfzzO7U0zn5psHQTgjiqBXoCxOOuJ+HIYQvndXEcFYlDiruiiklNX+bJqNzWJCH
 3hh42epIaQSrvZjNH3GC743xjkd+ywII98JXnmlyWx0BfyduyUVsXck/1UVorV7mv7jq
 51yEA/oocCL0Gk8W6GtV3XmMcGKOBpDcbNoANA3EOqlI7skX4guGqsjViiC7aKbDLZsi
 nkPOqgTYGI7qV/sHDHi/zeuFaC0xv1lFkf2RII4yp40P07gA6FIYsByWxJizipE55ey0
 XjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696699596; x=1697304396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdJw4T8PASujMIkAB5JpYdzdWcL+solQFHyvKHIOIKc=;
 b=hWkKlfJcImQ1D3IlOoPfDDZNeblAruYgzNhsdVLDKIcHjB/bLEhfVqX5/natzhh2xR
 bLuQhtThkdUl5laPP4gXFpxpk9GQ7IZTiys1O8Vb3UQyGWXhWTEWf2smDZjGE/6a27Ld
 fOC5KIQAEWkWUibDlk4zWTlQsVWroAN9/2h8CHaqMg+RIPNuZfUZ6vJ347lU+leNInAw
 E4C4Uz3wiyeRoioD1ayW3fO51jIZJmN+NT+k5kPW0fPBVy7uV/hJ9FYJNC8H8mYpcvzv
 ArtliPxsLkeju0gKfL59Y0BCRLxWREGJOplpm4GafIhDn0POqd9x5kmzR+QVTHZr6fVE
 Kadw==
X-Gm-Message-State: AOJu0YyX8XcOXsjoyr6LMNDR6kvBra1OSfwpj8VvqpqEjjULY/jiH5Xi
 b9YrmHk485Qu8c8WoLHApLIF16X+1aWp/ug3FkNfg/mi
X-Google-Smtp-Source: AGHT+IEztrRYyqsHfKr1IXwgBQqAhiL+Ywx8ojhG1myS4hJ1vLsDydnrx3N2wYtPz0/Di3msEX2HrqFrInNCzhQTR8I=
X-Received: by 2002:a17:90a:3da1:b0:274:60c7:e15a with SMTP id
 i30-20020a17090a3da100b0027460c7e15amr9959318pjc.4.1696699595833; Sat, 07 Oct
 2023 10:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230928143933.11510-1-andrejs.cainikovs@gmail.com>
In-Reply-To: <20230928143933.11510-1-andrejs.cainikovs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 14:26:24 -0300
Message-ID: <CAOMZO5A8UCkhmMWuVkd_vG26vx9eXH2sNcfVoCqBeBG1Z0pmhQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx8mm: set fixed LPDDR4
 refresh rate as per errata ERR050805
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Thu, Sep 28, 2023 at 11:57=E2=80=AFAM Andrejs Cainikovs
<andrejs.cainikovs@gmail.com> wrote:
>
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>
> Update lpddr4 configuration and training using updated spreadsheet and
> tools from NXP using data from previous spreadsheet and verified
> toward datasheet:
>
> - MX8M_Mini_LPDDR4_RPA_v22.xlsx
> - mscale_ddr_tool_v3.31_setup.exe
>
> The most relevant update is related to errata ERR050805:
> "DRAM: Controller automatic derating logic may not work when
> the LPDDR4 memory temperature is above 85 =C2=B0C at initialization"
>
> Other relevant fixes:
> - DRAMTMG7 register: corrected calculation of T_CKPDX parameter
>   (equal to tCKCKEH for LPDDR4)
> - RANKCTL register: corrected calculations for ODTLon and ODTLoff
>   to follow the JEDEC specification
> - ADDRMAP7 register: added support for 17-row devices
>
> As per errata ERR050805:
>
> An issue exists with the automatic derating logic of the DDR
> controller that only samples the LPDDR4 MR4 register when the
> Temperature Update Flag (TUF) field (MR4[7] ) is 1=E2=80=99b1. If the
> LPDDR4 memory is initialized and starts operation above 85 =C2=B0C
> (MR4[2:0] > 3=E2=80=99b011), the MR4 Temperature Update Flag (TUF) will
> not be set. The DDR Controller will therefore not automatically
> adjust the memory refresh rate or de-rate memory timings based
> on the LPDDR4 memory temperature. This may cause the controller
> incorrectly setting the refresh period, potentially cause the
> LPDDR4 memory losing data contents and lead to possible data
> integrity issues above 85 =C2=B0C.
>
> Errata provides three possible workaround options, while option 2
> is the most reasonable:
>
> Disable the automatic derating logic of the DDR controller and
> apply fixed x2 refresh rate (0.5x refresh). This option is
> suitable for designs that are expected to boot at or above 85 =C2=B0C
> and memory=E2=80=99s MR4[2:0] (Refresh Rate) DOES NOT report the followin=
g
> conditions:
> 3b101: 0.25x refresh, no de-rating
> 3b110: 0.25x refresh, with de-rating
> 3b111: SDRAM High temperature operating limit exceeded
>
> [1]: https://www.nxp.com/docs/en/errata/IMX8MM_0N87W.pdf
>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
