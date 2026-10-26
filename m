Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A41606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rCSJWfs7;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AorsKv4S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F68A40685;
	Mon, 26 Oct 2026 12:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJP0OyPrCuWo; Mon, 26 Oct 2026 12:37:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E923E405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018233;
	b=OOIFWDQw7+P+MqmmbawAj7Fx4GND2UikVQBrjJrRUIyIiqOdS4BcFN2OAZ+zxADrkXrb
	 MSh3b9zM7yGtyRyfi/Ga4Sdo8WCjFfz9IPCs+EyZvSCvbQ9G8R+QSE5mGm9yh02GJksxK
	 GpBoUrdIbL7JOz8QvfHO3hfAf1o7IV9h28T15vKNa+BDfqOELvgMoyGneFCpdWmJR+4Bn
	 qh93io1Em29JPA3p2KGuicQpDF7bT1Yg1aDqdBBfVgsCZF6hLpb+nqlr3/Ly2GTWYV1cl
	 nuE0+QLzBGeHtPafVM+ElJzkrTtAdQJfeJ42b2o1CEyqarnHS1QvUFs5WcYQnviq0mw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793018233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
	b=OkWugMJgollDZ5C/aK2hAw936BaAhnBeZDzBsY58/+IgVJrFWNXtRwoj+yeTT683SwvA
	 6rXfaOOJUD5kW5Y2Ae4uHIIqJzp5zRF+CB2Vt8XuuCL719CBrOEIwmZTlZmHuFrGlJT1W
	 ww+m6YgoZKTFGc6Q3OOEP36pfEAilcrbSTQRT3oj0tQIpKT+lUokyopXoOkA1M9UKnfWc
	 27JVuNDtVtMRM5Tqh6qxOntypZsPzWfT5zTpjTWoWerh860CxGnaBycCKbbK4o5jlcwqi
	 p2VhEuMBIdTwaSksvMhFNgg4OZH4ITyegV2/CQ8DrDBTnmD9mL7QyQUeyQOxTfz3jAw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793018233;
	bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCSJWfs7nOK7pwkAAk6gGZWPTlfmMT4ZUJ8MqZMT4Loi/LA2iBH7P8hT5WyMsKLRY
	 VU7zLZGBDgQQzuOuNYINWjPLp62SCkLPqV+jf+KYelzda3WO3os+jYRypurjKsYxGk
	 5cjYpHIoAAVvMQZJSzPSluzt7OppcfJDMlyxfaY0h66E37V8iRT186eEiIiu8nfP0C
	 Q5a2ddfBSeQM/MtVVxwhRjhJmzTBL6jJEVpKWfzLV/fzwbKyksdkxK1SGhn8NQB3Yj
	 +Jj5WhJiLGCD9+lO48FUTpwwsisoab3qsc5Z3V6An3GzkIowHd053P2y/9YgBxLRM7
	 29wHvwQFGkT8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E923E405F9;
	Mon, 26 Oct 2026 12:37:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 123834D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD8960615
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLFpEbhoMspB for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E34F1605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793018229;
 b=idQz4c10QwOpqNwdZPag2QbV8eeAZO9vhYMoo3d5gN/db3zgj3E+c6shPO82tn7hFxcM
 ZMP/s77LLvVM6z+tQhODqs/VKTnhUvK3WFOEjfj9c4U/qRQqpedvDTodu/YvpkQ28393I
 BAVSq0fgQBdB6aZCTutpHz13qS7KOY/CATXlz2zpwy5+EJpy1pWSHRSbIV1Sq+xfu5LqK
 X5FWzy9w9Nz6bzCbUa0Z5VIMsYp+xuTPUFo7Q9j1enzIzShASfE6W4BVQwA7GTBc7zIHx
 34fj3XbeelMF15+Ekd8TkumzoUSYns8oxEcepiU50Y9LbixvTZw1ChMGwrn3Igm5f8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793018229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
 b=LYIKMs16+phiuHd54d3wAtZMsNF0AITmigMwijEZd0b8tYbdvVnBWEwnpAR+MIn3EuYv
 qeXzFDVHRfh/2zZKVEMax5OFH3bKxGbSiW0o93LzqJnuUoeSeIlCZ1wlSC12JTffdKI0y
 vy635u0EuliY25YiD8CL9WAtZLmY8naIDhdadQlIt/vy9/8GY04X+rqwSy7xW7baZf8VC
 eUnfagWjtCjG2gfJ6PxZBlEfE2M9+hq0CrwOWM8HFLZsEi+BMQrjrEYf789QdLLAWkj6O
 Brq19mXVuqBcF4PJ5FnmmcYldd30dPzGCuje77VFXsl85q6sIKvyp6TrpY0BD7xPpuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AorsKv4S; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AorsKv4S
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E34F1605EA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:37:08 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso4486680a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018227; cv=none;
 d=google.com; s=arc-20260327;
 b=jD40mXlk9VK2Gz1Mxc9ZhHVkj/d8bDHBSrBtbK4JTwtXhJ+1ximUbTDc8i7NmIh1wm
 R0CFk2aggaR7vh78vr4AJsPrg72usW+8mPEnCTRGm3IAnzNZPUFnxfNi5rJK5RMIIilw
 QBBp+3xqU770rVVJlRHVxwPN4FFEafcD/EjSle/JK0bOzausj3i6j91myxzzwdEGjr7g
 y9UM0wt5TbeeKIXQFgOI9VytzPKC204mOPzHyJinoE0TYJY/jgCSnHarjlS2OvfXTu+s
 JLr4Fum+viqF0aDGBOmJTwCSyoTqOZnk9vht4Of9Tb/mf5SZv9+RFEuB9nb1V4BdDhBj
 P1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
 fh=t9AiWPuCZIrnSlANcE/ZG/3f7i+XX2j7GxSTaPYhjZU=;
 b=GMve5BcCkGdFBqjSWwBKAVRRu6fhgDwtH8x/UcZxNNFLKH2r/sVv32XOM5qKqgy1PL
 H8BzNcTJ3p+ghEjj0u6c6Ng8/dOL4tl+hcc1ltpiL6yhC3CCmzY0ISP64u1yZqwxpbuw
 Snx8reFDTnD91whp45IhuW9Xecezw3OZZyowRwBl57dpMohJ5IENq/CWnaXos3YqWT21
 +2mB5l3YOH97n3f20qeal6PHyfMTMIpnuUuOQ37Fv9mSoK32+BTp2VtWjUomrLysc6ng
 NXTdet2ZZ1dqI4sA5SQI63l5FytQl8uwphmQOY1JZQFZWs0ddI6ITx0hyVuPIhtfbENI
 1bUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793018227; x=1793623027;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
 b=AorsKv4Swzpv3tIW7ttFVcLKVmGmAeM6g1d9cdNyvIQK4wf+xRTSGv040WX3rop+ar
 QRzvpGitgnRQ9PQR1wGQqex1hYYWc/x2/RfLoXfhR5EMnBHf9IvmLRvTnqFKwX0PbFwi
 9O/2KQKmXO/WIxK+JQ04Uf6UPIUnWHIFCU3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793018227; x=1793623027;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I4zouXBoXc9aGD2gkt9HQnADROWHLAySC/uRAKqDNhU=;
 b=PjlBp4jXKwRzu262ELChuUx/c1xTuqdKxbyZ5GhTEir/6bHArqNEutd44bX5hcvNEA
 xzIL42gRcJQQddyZ9H7A9b9C1krCvz+PBRdkg9Acc5yoS/29N2Ns3Ng0dnBUqFK9WHw3
 HtIEhGPZTGf0P7m6UF9VQrTwKKgMEFoR2NQWHW99jdjFg7AGWsCmrIj8GPosyvjKaOWS
 UsfNiIKxQ7XuGYR3WtXvvPEqkHtizscR2WnPdPqRUJ26G8I9uwcSSUdr/HIuBOTWu3e0
 CsQ0cdqo4UrYFcQyhFHptoWhQMqOYht6qBzwdhrOSDcT+s61m6YogDgvzhra1+nRCY+n
 umFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyWUO+gP3RN8ejh4SlcxfyD4nlEMEMDPQOlxBE52K3+pqUJLcJMOXbrguW0BK1ZweLYDRcJNI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1VwsLOuNagvMBsc9McF8Ou+GoUHQiiDcqnGPPl2bUrhB+KpG3
 zg+oUzz49zXC8szfCWR6WxS+F84ynu1c4u9AYis7W86DKeNNv7OJZO02Bj0YHteyers/zVHUW+L
 4uUkWurvfcMlX8ewlYmQSPMkaEksytqVLV5rE2TVc
X-Gm-Gg: AYBFou0JxUqpkfKfwoFHES9wydnIB/n/6q6VCHolLldVOE0GuifIO9WIZMSD8AfUP2v
 0CG4BPdr0cz2VwxDsC53KI0tKfgRbb5iqi2Ebm4sRcRUk+m+5hkJDjlaoMBpVnPpsnzREWIXp0H
 HB4/YpCEfPw3if5atT1fu+odxVH3BbfVosjzDUKOgtxg30hKvaRJeNJ2ktgNuUnTnh7go5ejSFl
 zyXjM2HHWAHzBKI2bc4BitSKQa/X0TlAvvWRXjZVHKlbfBYl+LoSY2eF2weRFtQL5YotEWuuVoa
 M4dfEzzve2YznZSCopGiMjXQwNYHFcWzCPKKWJK4qe7FcooJktXk6l+CzRlI+L6ONMmxBJpGa8Z
 Bm14XYOS1hcVJ4/dsk3jICjGJBY/Ndoeq3BgpIvucGleqFO8r7zHqPyTJ
X-Received: by 2002:a05:6402:2811:b0:6b4:5842:58c5 with SMTP id
 4fb4d7f45d1cf-6b458425b53mr5886653a12.33.1793018226113; Mon, 26 Oct 2026
 05:37:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 05:37:03 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:11:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-3-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 05:37:02 -0700
X-Gm-Features: AclHuK_Yo5_xEZaEdLKtDxWxM-hhn_pglhrlxlQSYgFUmZvTa8mJ_K_UzufF9bs
Message-ID: <CAFLszTgP+KfBBGgyVTwzEMXWvHjsuBKV5CAccdt26ti1VXa8tA@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS loader and FW UCLASS
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader UCLASS and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
> While at it also drop some redundant check and rename some variables as we
> are updating the code for the UCLASS rework.
> Doc are renamed and updated to a more generic name and for the new UCLASS.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  ...{fs_firmware_loader.rst => firmware_loader.rst} |   6 +-
>  doc/develop/driver-model/index.rst                 |   2 +-
>  drivers/misc/Kconfig                               |   8 +
>  drivers/misc/Makefile                              |   2 +-
>  drivers/misc/fs_loader.c                           | 328 ---------------------
>  drivers/misc/fw_loader/Makefile                    |   4 +
>  drivers/misc/fw_loader/fs_loader.c                 | 175 +++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c          | 188 ++++++++++++
>  drivers/misc/fw_loader/internal.h                  |  91 ++++++
>  include/dm/uclass-id.h                             |   2 +-
>  include/fs_loader.h                                |  47 +--
>  include/fw_loader.h                                |  19 ++
>  12 files changed, 493 insertions(+), 379 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
