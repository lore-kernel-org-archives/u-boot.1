Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F349606A332
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hrEslbns;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gg4m0BQ6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1F50607F5;
	Mon, 16 Nov 2026 18:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wt7lr6cIfJvZ; Mon, 16 Nov 2026 18:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AB74607CD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854152;
	b=avmi8TugYUPGNy92nrqN7lYa/x+n5Aj0d/DETn38/JI6IgF1FVmwmhs7sRrQmfR6JgOH
	 msYDzbUR6f4THOd29MN1Y09duEovlOBjKyYQLtpYllzr89L6DFrkZOgSsN6GYkBJTOGIE
	 AbHuTw1ztM5r5mV5rTkHP+S4f/mrmRgsKtjPodvcNGknPagHa1lhrKbmb9LfPuQHCsDul
	 fo9pDiq7dSW7NAFXC9NEV66xCCPgW3/f8ue6+hdxDjU9txtKSLjuGyBzl175tMAMPhtgl
	 9uMHk9WQS1a6q6ADoScFRe0X021hxieyQHcqVZtddcibVJnJvgp16WjZ74WnkH5IC8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FVgJB3bbXEFQeWErTuUBh9cPyKJ3XGA4AAdzW6w/nqo=;
	b=ZsqqID8UcsRvSniKpjoz6GVTIEzEDhkMcAb82kTnM7vJujFemjKreZedYGzrCTGmfJBi
	 HGNxmI2Dh51FDhd+TzA3IXzgQKQlE0XUoKY0waf6Wz7ruE/g/L85gRVo06xk2fCUG31ZG
	 i6FIO7BRtRGfueYAHuZ9PAXl29pv9/xEOjKrd6Qrh00fGsgZ/qEKzYtJf9K9kjiLXqav/
	 yipRCPsAXx5IeHyVtdvxV8e6JILB8U6AePVgeZyNLsrBTQz90zmNXMuOoitmil6JCwm+j
	 HRPJuBK4sTEDmuE0B8Ob9h1IBg2z+GyfDbL7vg0D3XIWRTgsOXFzgT2gR6CX5S/tJpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854152;
	bh=FVgJB3bbXEFQeWErTuUBh9cPyKJ3XGA4AAdzW6w/nqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hrEslbnsgUETk4eWi54z86FG/Xg+xUq2yUspJxWByjZC13PRdBQFaqRDo1IDWa71d
	 WZp9t28kmyse4ItdlV1yUpGQh7PpZSG494xGuA/H0bn6mu/UekmCX1JVzPux+ZsxBf
	 9T5syf/uIX+IXsaZiThnARhDQDBxmLmdlVP/PDvpOtZKx6TnzFiYKeDBgIajzuskI5
	 55HeTfl2dHVLnnBlyDNZ8LEtR32RonYLDQ1o1694nBFQnjMTRI9hG47Thykgx1XbZU
	 o3+lkljP0YE7qgPe6vx3lL5bMdgc88EYqVniYWhg1Qm0G7/8y0WCfOIc8aHoTcDzAO
	 9zZBrJVIdIy3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AB74607CD;
	Mon, 16 Nov 2026 18:35:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E091E28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFF0F406B9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_3cb_dyuwoY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F364406E7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gg4m0BQ6
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F364406E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:35:49 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-862b76e3c8cso691083a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854149; x=1795458949;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FVgJB3bbXEFQeWErTuUBh9cPyKJ3XGA4AAdzW6w/nqo=;
 b=gg4m0BQ6GJOEYan640jDQlNTgkg5VU3GwrQmitZDsbBinFyd/WDgrCHUuhV2q0EWwR
 vpKxIvbVm0p+xiJAOddYvAgtgPnI81OHUBUcygoroKtet+6J22L6BgZ06Gj19sPJ1QYp
 UQHYeXJmHqPx+2FJglH/OyRNMEc4l6iBc7QMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854149; x=1795458949;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FVgJB3bbXEFQeWErTuUBh9cPyKJ3XGA4AAdzW6w/nqo=;
 b=22+V41Iz2DTmwwvlxMbwYSYqR7HcBzj5Hg5aGbX3xM5UelyP95KNknLQL1sSL/2332
 age3ZByxFQtiPLm7I6qK1ZzFUI/++SsdhrX4ZHLWvmhgkqmCw3WziIxUeFSLuefvTwQ4
 bLuubTT2f5Fm05krXEqUco3cP7GJofgr7U/O7vYQYij6qz4TXAlrEZV6nilNgjPgRNUk
 YR13hQgNoU8vkHzPHH7FoA4niPuuqE3obyTcbDfkqzjyrOGm1rbvkWlKMaVcAzs7Te2Q
 HCyZskN6S2GUcRUlDPcjJZJ7MmwnPz5+lDiHc3tcd+qSTa6jSZGD/eAzn5Pc260TtRuu
 Py7Q==
X-Gm-Message-State: APuU4Z+6d8IjvVomOuAgh+GyubrDO/awYo+V1iInOYyw/lTYZbO5sRp2
 du0bCUZZXtl1Y1jyZGn7c1qmfA1FngNpJOA6lvxnBElP3a18YxKZWQJgTzfr1LDWUrY=
X-Gm-Gg: AYBFou0mmz5THldnuRk6bUdbDxtKWKRs7Tiz7rwuJGFRT2GQPEmq2flWZ0eWofAaT5w
 jl7gVKByjtbvKQS6IoiRcuCvhHMkdcXDEIzhFzcngQdkyi4jf1tk1Om2IAovywlynO1xk/q53I5
 kzEv7KjD+XPCa2P67zy9vAiVWI2XN75ZyvLDJ0CJV454zZxCqZGN2uunoW7d8QkkE6s3J/jxp48
 aEfDZXhqpeANw5v9EaxG3EgvnKavemf6kEVRxXtUDKiYigno1CP/6WDXO4HPe61b+Am/nprrId/
 kvq3zLt9oL0gazbwg9kQSrVYTjmXpEl2KiCvD+AiBne8rM9TSpj9LDZacfWmRBsmbFvWbVxCa6w
 Uc7VV+7BwxJRiIyMWYGEN3TfsrC7ShK5oRl7eOji3BUtoJk4de1bi+BPB/NwnXDzn0g0bGold09
 OMKBhF1grGqDKPcpNtRhT1nHiy7Oydt6IDOiOAoUMjD3NjxRz6WcqDChdllKmY4UmCqNti2O+Xc
 DKvx1MdZ+k9Boe3v5tjeEOgrWzdMlMwH4IOGHsQDZ/3X6CeZY6iX1efBE3B1yfrVPX3UT8i8pqw
 ekcVD+J0peov6sizs+PL/exmO84Xke2C6xRcCOapE4m76yfF9dpZBlTQ5Cg5O4YF1n/CBm8i0bx
 LNuNAun4Y0nJ6gS3dAHF4X3L9cjVvhoa6B0Z9SsXteX3kIDEneO4w93wtlh0w5aqHSzjANYyGuj
 2GnE4kIEn3HJmrpgGBLEt2ZKdbtiqbNoo=
X-Received: by 2002:a05:6830:4394:b0:804:d4b0:a36 with SMTP id
 46e09a7af769-862898ed608mr10926130a34.27.1794854148851; 
 Mon, 16 Nov 2026 10:35:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a5298sm11932014a34.7.2026.11.16.10.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:35:48 -0800 (PST)
Date: Mon, 16 Nov 2026 12:35:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Denis Mukhin <dmukhin@ford.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH v5 5/8] env: scsi: Add partition type GUID support and
 choice-based selection
Message-ID: <20261116183545.GD554944@bill-the-cat>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-5-79e76209457b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="99tZRywo12kp8y8F"
Content-Disposition: inline
In-Reply-To: <20261115-type-v5-5-79e76209457b@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--99tZRywo12kp8y8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:56:07AM +0530, Balaji Selvanathan wrote:

> Add support for locating SCSI environment partition using GPT type
> GUID.
>=20
> Introduce a Kconfig choice statement to select between three
> mutually exclusive partition lookup methods: UUID-based (default),
> type GUID-based, and hardware partition number.
>=20
> Reorganize existing configs to depend on their respective choice
> options. Update ENV_IS_IN_SCSI help text to document the
> new configuration structure.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

This patch should just be reworking the existing options in to a choice,
not doing that and adding the new one. The new one should be added in
the next patch, which introduces the support too.

--=20
Tom

--99tZRywo12kp8y8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtNAQAKCRAr4qD1Cr/k
Cjd/AQDwFWnyFH0c5nOyT8sYeaXnZpvT8tnUcbhARWWq/oxgegD/cX92T5C32MM1
GRTZ1S0A6ZtLi8L1qIA9zcYt8B+68wk=
=vPgy
-----END PGP SIGNATURE-----

--99tZRywo12kp8y8F--
