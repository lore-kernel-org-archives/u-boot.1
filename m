Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E4606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0hxUgwTN;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L9qtx3JK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61B1360607;
	Tue, 27 Oct 2026 00:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k86jLZ5Pkf8S; Tue, 27 Oct 2026 00:19:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60953605E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793060371;
	b=OO7/Rqfvq/mW2Sk9Wzu3TaolW2imB6itVSeUs/L+6XouBcfnNvf5jFjXrw54UWFRLVfR
	 UbH7EJjzwekkhEpXvPRA0oJPktbnemRIdKi+YXUu29dnq957bk4PH08X0nBHJdUod3BNG
	 7lnFoPROX6s8+K2NV4GJICxk6b+rsWeSPU8RBH5+UWI4PaaLbzFubzyVphp1Y9mcMFT9E
	 4G3r9jWejd3JfySbWXTE8P4ymaBkrBc6gEKtJp3slOHHKv3wtJ313m4pB0LtUBTJ/MgLB
	 UdvaIvQVQWNpuZdWAVvezeTxwuSvbG4kJqSxSyXoi10zSyUcVFAWjQrPrZkY8NSsmPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793060371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xdczK4MKYi+lmnspWCixeoW0nD42Y33nYKxnyAEJ/NQ=;
	b=BZOwST6e4CG4fUV+59rzQY16vrp3OEYllNyZKJ7nuEQYrO+Ag/xdB/FJO3SITzw+Ot6r
	 ktdWYhyHHSfXmwKgcIrG5URpJ9SouFcxf5xg2Xksj2ZmBpxuzoe/1R4uroKX0MKd/OhKg
	 rxV/n1gDFIrZSossLQiykJK0PuZ1N3VFhpItRRMfb0QJ98cMaZS1/wWAbRBlbS0dCa5o9
	 dpN+AhEiQeUKrhEr67R8K3h4IERAagUGeiV8HIMFYafSFrS+62B3CP7Qd9ljViJ3p+aQF
	 Fs9/ZK1Ea1gStMFQjQ83lGBxePhOoV5eYLId1yXimGCMgvIy7S81to2H+cBht+7UCWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793060371;
	bh=xdczK4MKYi+lmnspWCixeoW0nD42Y33nYKxnyAEJ/NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0hxUgwTN1J+8ImAYSViktFLuLhHtsXFtSC3jCLlr7cmPchdfcGUCOoGm8II7pDgBz
	 085Gu6LffXHLjeEgw/ghe3OvGUTHpPFw4OQd5k4YbOJX7OA15mJxiSPvhm0lpue1bn
	 PWBER24eEB+1Wr8HJDmWE97SUDtpxDNZPUSC695GLfIgf9PsNwtOGJ9/nJnDJ/0k+Z
	 HAEB28y9CFki90h5Q2K/PInBCOxBIhvIU1X4kh4T2/sZ3GNyQL9AhusWlRgWpXutRY
	 MjrlDSrbP/t2vhfgzKKdKZDokKPhmXch32d6dEuAlxl8lpOGLS0xvWI2MkcntVMPOb
	 yxYleXZ1mdh+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60953605E3;
	Tue, 27 Oct 2026 00:19:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 457D8356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42C0280AA0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DqLC5K4UL6S6 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 00:19:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25E7D80AAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793060369;
 b=a1D064bcSOBeKWb/p337xHc6riT4FDnLi6n/27EIW4nPt/VU2Q/rTQbaG0GZ0iUYySSs
 28wEvkbkpN7FbKxaLppoJI/tpmkD5SfMWDKiDUsTv82PtEqQ/SdaaunMkboAFQNnFUndO
 LTSNn7kFolyaB6RrM5BfRSkohJ8boluFvSzptLdoJjPZ65pfhQ5kttZuZXerQZeYB8O0i
 Y6xiRq6Rcn6fZWQmDEG6SrudgdDBnG1wyYXbiYx19rmb2c49GqlQCIrDgLvJXQKci92dX
 fYQa0CKb6Csy7AZwvNkhLXGFzSmRS70IUMWWK+XNzFZB50I2lt9pniAHeOypLXRhXbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793060369;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=xdczK4MKYi+lmnspWCixeoW0nD42Y33nYKxnyAEJ/NQ=;
 b=pPNhMOaMQKlDehvTlB8Hcp8sKqVXNQ97TYa80k8Ppa2y7RBbClL05pl7QozN+gU+LOA2
 zWrhMqmu5UTNsWfw4jDAqOpEyEhUq2jEKgpXxvUbVb9ZwgKWSBybf5IVOD0WoiMXhuPoA
 XGmDhA6oJI/io6M4mhMcdBSG4DD/aT2GK37L3YB1q0ShVk48xU4lotaOyueodSpF6UHQ/
 EKdUmh/+9Yt1dA9XtzUeo8hmNpmr+L26Nf/YNNjOjRPbxKfY2UessIzglUZOX3ecaLkRd
 2nqmKMoF1bncs3SUeMWGqRBs5PbWsrvbUlsCNxr44wghsHvkGyY4AnJZkHTNhDsu1dA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L9qtx3JK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L9qtx3JK
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25E7D80AAB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:19:28 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso689475a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793060367; x=1793665167;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xdczK4MKYi+lmnspWCixeoW0nD42Y33nYKxnyAEJ/NQ=;
 b=L9qtx3JKe6E8nwcGcY+3yoL5PIyFXWOctbRhFAWJ4cl1i7FLgfYorKriXeOx6Mqnau
 LDXNwo4T3f7t4dlcFWUDE306duyud+B9cU/JOe7lMDZK5xetxCv2Zf7mQ1SADN2K9Eof
 irpaw46XYxOZ9QU+eBdu61ZgxHCgcvN48v58Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060367; x=1793665167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdczK4MKYi+lmnspWCixeoW0nD42Y33nYKxnyAEJ/NQ=;
 b=RLEZ8czBL1ESLi498zSNBBwFz5F/ujow/ngGAk0UF19GyY086fBOPdip99VTM3eXzk
 evxYQxpK0zB8A59q7ZhgyOy6yq/d9itJ+dqNo8w4nrdCSL7RVnOu57xf2ZOz03jXL8XR
 cofL0qGhEss11a5jwsiWmjmXhIwSHmbPNLRuMoARxq+r6xxlXVA+Kes0/w2Tm307c2j9
 vdoJuNB1y0KSPk25ABkkdDGG27bptUwGWsVTssaXdz4Aaxqp2CZbifPcyozZeWGv6IxR
 5AQlwkavk6QENa7UVxP4pftacBGLVWpMBAR1Ibn/IoOHfk31RZzUXmiljDgN4ujDYAOQ
 aWgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0UbnWDqOT4r59uWSE5+RjQUmoc+Fvq+wwwa2Qop2QYYVpNwTx58+1bwZf1PJsktHragV5m9c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJCCrIL5krDb/CXEyzebHy2/6p2NK9zmKraED26QQ1XpKUZqU1w
 L/mwknKszE8dmZaKdUk3lZWJqmbl2AGUpNhKdwUsGEDpptb0gY6SDeWRIS79J8tr8Zg=
X-Gm-Gg: AYBFou2GTyUcK3vldE7sPEvpL/B+z4jP+05uATHUuEFSUgxgRPPa99R7dHEHi0YGhHb
 KdHin1f5Dy+3VX9r7zR5vXVeTjhKG48VS4fslVOJiTkV1cyfCNOx1DKYx3Db24xOA5+qIQay0oJ
 E4LgQDQauNg3u5k4U0bz9Rw+xNwPVzINPrDwvkMRPpkHpH1aFKE+EnHx5CzgbSy2rbyTx+Ilj0H
 msrnjiZHpk0dkfky+RVAXt3CcxW7ibWtQ6CHuAKCQcfjdeoJk9NoHilqrV7d31pdMNetjCmYY00
 Ql6Mt+0GNZKqac5RQqrrGpzDvq1EWs2LVAWKNYktuo3FlkCF2k0weOda7cd3MFHj/Ss3lOIiyyV
 cxk8nKttIw9j6eCkluY4fCmMKad5ZA+5vXj6ZUOKUvrX/f2EqNVlRDF2T8w8WljLcAIdJtpfK46
 6EQUuYdbTCsrHcUf8rZBueJt22b8qbmybgdver2JrprPtzc/1N7hkTrA0VB2cruu0tSAbbas7nn
 JLq3YN4FLjwxBo6PjprHeEgd0hhRqlh9GiUgxXyWIYxDDBxH6w2CwDkbnrBoJomDU1/haDAnHHR
 Gv91f3rESfT2ah7Dr1/LO5e2HIJ9ZG/9Fh+FFRfvDQGdd6dJZaqYREU/yBCg5F2ukKyOxduG5XB
 C+Rk83oEbvG7KB3eyDLZbsNy8iOjmUoEna0ELCJlrhOULaW29id+sz7PWOg==
X-Received: by 2002:a05:6820:a28c:10b0:6dd:6d12:22ff with SMTP id
 006d021491bc7-70ba0b811ecmr3554714eaf.11.1793060367223; 
 Mon, 26 Oct 2026 17:19:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb074fb6sm9931080a34.12.2026.10.26.17.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:19:26 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:19:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261027001923.GM646438@bill-the-cat>
References: <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
 <20261026183010.GI646438@bill-the-cat>
 <04F0CE3A-448A-450E-A49D-CA01BE76CF04@mainlining.org>
 <20261026211952.GL646438@bill-the-cat>
 <49FFC097-8DAD-4424-BAED-823C55BA3524@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8epeclRcXCri+yKS"
Content-Disposition: inline
In-Reply-To: <49FFC097-8DAD-4424-BAED-823C55BA3524@mainlining.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--8epeclRcXCri+yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:27:05PM +0000, Bradley Morgan wrote:
> On 26 October 2026 21:19:52 GMT, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, Oct 26, 2026 at 09:14:37PM +0000, Bradley Morgan wrote:
> >> On 26 October 2026 18:30:10 GMT, Tom Rini <trini@konsulko.com> wrote:
> >> >On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
> >> >> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrot=
e:
> >> >> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
> >> >> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan
> >> ><brads@mainlining.org>
> >> >> >> wrote:
> >> >> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
> >> >> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
> >> >> >> >>>>
> >> >> >> >>>>Hi all,
> >> >> >> >>>>
> >> >> >> >>>>Just a data point from a user: we are using U-Boot on a T1040
> >> >(QorIQ
> >> >> >/
> >> >> >> >>>>mpc85xx) in a product, and we intend to keep up with mainline
> >as
> >> >> >much
> >> >> >> >as
> >> >> >> >>>>we can. We'd appreciate PowerPC support staying in tree, and
> >> >we're
> >> >> >> >happy
> >> >> >> >>>>to test patches on T1040 hardware and report back.
> >> >> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to
> >use
> >> >> >64-bit)
> >> >> >> >>>>and
> >> >> >> >>>>linux in 64-bit.
> >> >> >> >>>>I am in the process of bringing it up to our 2025.07 branch
> >and
> >> >> >> >>>>potentially
> >> >> >> >>>>mainlining as much as possible. We have some remnants of it
> >under
> >> >> >> >>>>`board/keymile/kmcent2`.
> >> >> >> >>>
> >> >> >> >>>Would T1042D4RDB affect you?
> >> >> >> >>
> >> >> >> >>Not directly from what I see in the code, as long as the shared
> >> >code
> >> >> >with
> >> >> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to
> >> >report
> >> >> >that
> >> >> >> >>there are dozens of us using powerpc :)
> >> >> >> >
> >> >> >> >What you could do if you would like is to test the whole series
> >to
> >> >see
> >> >> >if
> >> >> >> >it unaffected you.
> >> >> >> >
> >> >> >> >
> >> >> >> >Btw tom I had a idea: you merge Vincent's bug fix and my
> >maintainers
> >> >> >> >patch,you make a PowerPC custodian tree, and I handle the series
> >and
> >> >> >the
> >> >> >> >naks and stuff and the comments.
> >> >> >>=20
> >> >> >> and btw yes I'll make the pr with the finished patches so you can
> >> >merge
> >> >> >> them cleanly
> >> >> >
> >> >> >Trees are relatively cheap, but I'm not sure we need another one
> >either
> >> >> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts.
> >Since
> >> >> >I added you to the fsl-qoriq tree, you can also just pick up the
> >> >> >outstanding fixes and your maintainer patches (and leave dropping
> >stuff
> >> >> >for now, as this series shows today we're just getting people havi=
ng
> >a
> >> >> >chance to see and reply to this stuff) and send me a PR. Thanks.
> >> >>=20
> >> >> Hi, sorry, I didn't clarify enough, so I had a chat for some people
> >from
> >> >> the open src firmware slack, yes?
> >> >>=20
> >> >> And here is their answer=20
> >> >>=20
> >> >> "Ah, Peng Fan maintains the FSL QoriQ tree:
> >> >> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
> >> >>=20
> >> >> That is the vendor one though.
> >> >> So yea, I'd go with a general PowerPC tree.
> >> >>=20
> >> >> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
> >> >>=20
> >> >> And even my slopper suggests the tree, for sanity purposes :D
> >> >
> >> >Fine, trees are still cheap. There's u-boot-ppc now. But please keep =
in
> >> >mind everything else I said, thanks.
> >>=20
> >> Thx.=20
> >>=20
> >> Question: will you merge the maintainers patch on this PR, so I can
> >focus on my add-on maintainers patch and the removals?
> >
> >Lets hold off on the removals a bit more, as I was saying.
>=20
> That's not what I meant
>=20
> I meant, you'd merge ONLY the maintainers patch in this PR
>=20
> Then, I'll go and take up the removals, and give it say, a couple weeks to
> let it marinade, and give it responses THEN submit a PR with the removals
> in it. Then happy days.
>=20
>=20
> Or I could also take the maintainers patch with me too...

Yes, please pick up the maintainers patches and if I follow what's in
Peng's queue right, there are a few other powerpc fixes out there.

--=20
Tom

--8epeclRcXCri+yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/uCAAKCRAr4qD1Cr/k
CgvzAQDw/YzcmkAq5mknYYChv26ro0vYhlXnXnoq/T4jWbsSswEA5SfCwvobk5zB
a1lm9WeLpMv76cphs5LVxHqI0D8KnQQ=
=+cKK
-----END PGP SIGNATURE-----

--8epeclRcXCri+yKS--
