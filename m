Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC97C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455F48799C;
	Thu, 25 Jan 2024 15:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k8qs+loi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE14C87A24; Thu, 25 Jan 2024 15:16:16 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44D787A2A
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a314ca7852cso135672266b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706192173; x=1706796973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kcbjqebjI4UysdxaKISv8HWSqM2sz/IwmV1Nh2Myva0=;
 b=k8qs+loiLuM++MgmYz8CaF3+79Pr+vIX5IR/IlvBNR7aoGtcP2NWbAkuJ9/dU/TXrP
 8bAfosZiaczXZ4Dxl0MXO56mENE3NkIVsIPN7V0WjAxoePwEZ1exAFy31mkMbFcniIEH
 g/fbPcaC0BfPPzTiC1DquTXz5WRA+Ix4oTKYQ23SLb69wXbuuNACNmPjhbhUOdosh3JQ
 UL9tSfNeA42iJyc4h1J/TeTrhEuG+yzJdcPJ0buWEGdkXmo9O3DpfR0WhegXq/K45eGq
 7ql+9nA0tEPxN/dXw6MEB4hCb6CsjqiUWUuIYr1y19Dydxzn1gIUTBG9mNccFxSa088u
 mu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706192173; x=1706796973;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcbjqebjI4UysdxaKISv8HWSqM2sz/IwmV1Nh2Myva0=;
 b=Q7iaN1mO9xjG10zAcihh9n6gFy/PIzdCOIf8IzkcxhVuQZYFotAuo9yPBRC/8wLA9W
 GA7WTDTnOJf+0WNauRS+19NoNTBx80cmYCLHb8nGACeaaxJHinuwaVid8Jc1H2K9wFV+
 Qyr3CBgk3MG4Swr/cPgC4BkVUHj4w8cOxxHecVXwAbygs07VeZW7tXZ46Nm+fbdmtbnQ
 xUpVp9Q0dNtm+N8eNgKLK3R/7ilO3ND7H5DqiezwLlGuJBeARJTbAHIVTfYH0G/oGuqG
 PjGAARvGqNSmYlz/4/KNdjDaFuv1kPsPvFB0K9S0aWqERaZfQ2tlqvwkkDxRjB4DPHyG
 66xg==
X-Gm-Message-State: AOJu0YzIPaCDat5M3HVwtgqHaAl9WPZrYL1KMxJOPEtA+qCIQ+UidVFM
 VOoSr4P23Oeuc/1gbZtlpwlM3kLi74QCVWZSbfW5vdUlJPuAAbRh
X-Google-Smtp-Source: AGHT+IFIO7C+JPPrpKCVW8CGYxKHTIrpyHIANB+No8+n4v/jb+pMSp82Giii7P1WInyiwi5lNsnjAA==
X-Received: by 2002:a17:907:c20e:b0:a31:fff9:30cd with SMTP id
 ti14-20020a170907c20e00b00a31fff930cdmr355651ejc.48.1706192172805; 
 Thu, 25 Jan 2024 06:16:12 -0800 (PST)
Received: from [127.0.0.1] ([46.211.247.89]) by smtp.gmail.com with ESMTPSA id
 w6-20020a170906184600b00a28f6294233sm1059639eje.76.2024.01.25.06.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 06:16:12 -0800 (PST)
Date: Thu, 25 Jan 2024 16:16:11 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
User-Agent: K-9 Mail for Android
In-Reply-To: <20240125141236.GI3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
 <20240125141236.GI3652023@bill-the-cat>
Message-ID: <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:12:36 GMT+02:0=
0, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
>>=20
>>=20
>> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 08:29:54 GMT+0=
2:00, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
>> >> Currently, if boot with extlinux=2Econf and do not set the fdt
>> >> U-Boot will provide its own device tree=2E This behavior is
>> >> beneficial if the U-Boot device tree is in sync with Linux,
>> >> but it totally halts the booting of pre-dtb kernels (3=2E4 for
>> >> example) since it uses ATAGs=2E To fix this, pass `-` in the
>> >> fdt extlinux field as a signal that no tree should be used=2E
>> >
>> >Passing - doesn't seem like the most intuitive thing=2E=2E=2E  Is ther=
e a
>> >different argument we could use?
>> >
>>=20
>> I agree that `-` is not the most intuitive argument,
>> but this is a way to implement a fix with the least
>> code posssible=2E To make this less obscure I have
>> adjusted documentation=2E=20
>
>It's also how historically we do similar things=2E eg, "bootm
>$kernel_addr_r - $fdt_addr_r"=2E My question is can we re-work this,
>cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase size
>anywhere that doesn't need this legacy case=2E
>

Which behavior you propose?
