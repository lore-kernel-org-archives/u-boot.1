Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200F5C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE5A960786;
	Tue, 15 Sep 2026 13:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXFtR_-9EMBS; Tue, 15 Sep 2026 13:19:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 279896077C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789478367;
	b=nr6vRqp4doVbNTi7aUeQltMVGTVzkyqMIwJgiwdMYlJrJFNZXbg5iED1bm46lmZNN5ti
	 keQ6FMwvdmy6xd0n5u7EPYn992R35DZhnwec1NMllvM8bBfa6eOwCaWttZNW6bjChFs+I
	 x18IJPDKBSk4WC7T+ddxnUi2vL6SGjkLyguSHilKnou458x39J0ZMhiKsloiO4vvFXIYx
	 Ej2OBmDMhYyqpEJK9BZBaVxYHJ3Q3bChkkU7I4EBKali82Ro0GPxWuHedZQQo0YGT1221
	 +AtlHrA/eADIalBD8kflZgC9MLRHviBAOaBRC362JZhkeMdcKG2NfFmSWfx55dmZ3nw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789478367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
	b=Dc4Qs6WDs5KIJIIlk/Syfl9UhtOu16k/Q7mKjbw3f1VLga1JjcOwspiRuf5Hk/9pdwfL
	 X0vATyqjaZyX3+Fsda+84mO04TeBsRdNF+TT9oykRrqhMmaVG3dhPnBBZu8juNFmB1b+9
	 UzbctmD/y6tjV0HwHDCgjPaTizcXPUPwJPGLUBEXsISe0rhB9dNhZZJsdeEz0D3dv3MgZ
	 6grj49F5pjLoSnXp8WSB0wQ04NXnshrSyUCxmq6uxjQlvgpOW6hltPMFcI2bvkO4mJ7ZQ
	 BsC02/AbC+Jxitk51iSkGISJXoYLnhb70JXn7o4pCjyjN3VQ3bukcsD7XMfQ7YxzHyQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZZFBCxcX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789478367;
	bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKJHz6xllZBWBLS/rRtkYhEytqixv0Wff8Wq/Qc5hsFHdAaxSXEQS6UOGcLZwbR1v
	 2esYHYlsvoz1uSbpYxhbqnsGsiOe93vupKoE3hr85qEQRlXOqPT4waWYqj4jdMC+t3
	 9xv6fG7rkgE768B/j20OmGFL2RAZ3olFCe/cmJAB5c7fOR8YIg7SzZx/fwvBiuzwXs
	 hhUWUsUqQ3fAh3WzVLeMuGkbrNuGwUFnIFbGcp3ZiFzE5qk6+CyALtptyVnBVHKSI5
	 r0Cm+MQo70y3XpBXDsDyx05qoCwDP88N/XMrxezO25XG0khzEwdERFZQ8Dn6teNPmB
	 r6LZnIKl+wIjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 279896077C;
	Tue, 15 Sep 2026 13:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B122E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB46A6077C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUTANVHngP98 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:19:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C0F3D605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789478365;
 b=Vgme6rmnIMyiYpUUnh2UhfhuUc6J9OkJ+r2iuuSZJeeVyEBTv2KaSSbmK9DmLCuDqSEL
 6t8jGjn7Lpn0gM4vZg9TCThXlIV7zB7PM0yVPQPk+flwoMcY+cJaIezFUHB9k1XWUM0RM
 hZR8M+Q+Kc5gFyCnAelCtDbIWkSmQjqyG2HNnZq6guFejKDWQui8aV/lgBwrgZfATA97n
 dSKXn8MNuPEjIynm3A82Ml3G+COZcfBkuea/obzBOLFHejmElZEkHU/QvkZLXiFRRssdR
 +G2NmfYaUNPGd3zb+OV2I0ZT/lcgNs9MRc7X0KTuGGOp+agIl2EMvFyf2z8Z2CCJb5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789478365;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
 b=aobwWcLQ2BdpAGWcn7DGcQUd40479guxCc5NKkWXD9zi84TgElleKQ+xa3h2jqblTO6q
 ZoT1by15Z2wUIMn7hCwbrEOfqOcoB8O/Zkx1BlR9M/eHC45kt8itqF/bE++sCmZk1W2mD
 UnrhCH/jDftA818h7S/SzZF9/X+70CCwa+DwtjA02Pz/1/Zc8Gmx8U+SLwv3SSZVNdNg/
 GRKc0mv9a64lcxpb/4KA2cuPWKjcJazijuTFqavniMmyDMQVBlMWzcVgv0icbd4hBASm9
 VzTX7O+Hc6wXhrPo7yNqBmvtEUHx+Cyf0AXIKSQNGncUSanzPGB9OQ7M6qt7EsMlErw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZZFBCxcX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=imkyufie@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZZFBCxcX
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0F3D605EE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:19:24 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6bcc0c495efso150018eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478363; cv=none;
 d=google.com; s=arc-20260327;
 b=iaMYqwyTcyiUZY3Iv4sPLFf7e+SVtup7wtmXV4QGokvhiI96em8uuXEgD7TBCz5oZm
 TW1Ur1mpPLuQLehrls7xJ/RfG/K2ZbrEA0iDmnypXFE6LNEeKgaU+9wd6yeEMWKArTdD
 kDsvr00ceqf8MYOTO/uSsTNmjWhP+MrYCir9Polo4oL9ceJRkdS6gU8PFpRuPhTMG4tV
 IZ3P9jPvsC9DBlBFUb13moE3/NgtgANIQgz3o7vFYRrxS9CKSLpF5iYJw5dEW+1vhEcw
 0fNONLPX77Z3Pqs2y1E2YMF2+iEeVHT6iLegYp6XQ1H0w+v2+x6q1IlnNj8Cf3409riF
 WQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
 fh=sQcRvHF/IsbprZ3RHPuvxCNMU1aTINCqqdj1NllhIBQ=;
 b=QyYfv5FxUK1a4NmIDm8C7iaKpvnGF3OvHEtihgaP6jrJfM/k7S2XC40tzuoqrIQwyL
 3mUB3KR5t72pWHTj17h/vTvK85yFuQCrDLY5tXoxVPDYNmJL8EgySiD9I030k/Q3yO/p
 cq3I7TN3Btabf00ruck3VIiDEjc/bYzgjFjCjcyQi4HGkBvRkqd26Suf3EwgZeKEnv+m
 nUiYpojUGlKqSnuyj2BA75jYZIdpT0OUOVuMzva0yWbmCU3Nowcvu0UDUszV1xNHsCnT
 16LJaJfNjaPn0jJ2oqnPNxKJpvXZwRF3n56rLa1hCu3tfcWhNHZTNbRwMX+hGkmjG4l1
 xdRg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789478363; x=1790083163;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
 b=ZZFBCxcXBLiGPRp5mfSchFbmj+UiDPuDRvkwl9P9AWzzoU9kcKj5x/Y+Bd3SDKdAaz
 xu9tU5syy/R6Cf+VaN7aXRsD/0z6PORRS8hkkJr5K0W9oGFAfX5NojruNRHJkwNPL1y1
 cAC5kukDbQ69aeZ6+Qeq1e7UqqcpGU2pmfSrgjJX7hMtuNru91iS1dvVa+gKoJdYitep
 cfIbbkLnpZmJVniW6j4VGLfwbNxTNdGbLsliDCPzYI9Ik7AwO9qamHBeomUfVv+y0CTr
 C3NvQfrWpx+64a++HnccyPqA03jVT38+B6Fy9jwMZey14js2+GrCBld9qbX37lCpt7/p
 RhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478363; x=1790083163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JpN4Ln/J+UgAh5PDkPgUOgsTmIM7VZpKm9bSy0kt8Ho=;
 b=LS0/dIHHZkRDCAOSH6h3GtaCRhTXgwU9UW16OQm4b6+k+tc4wddn0ux0XL6W3bVjAl
 J6QsJiiLQ/P49H9+aQRV+hiuhaPZ5fOQMUiNlp6+TL73S2GQoSQCU7XPZHsT4XVQxcZQ
 vYLaHP96nsXR1YZ5/t7LLAy0/Y4RPtdSywXZnonc747VFWac3movHMetQmEQdpZK2NK9
 ouLElWu5q+06+rngQyovRWYJYNnVt/PFNdspxwitUjZArwq2w3dJhJEKh711NB+vxAtU
 wYEC+L6WNhyo0R0+jKrXZBgWs2KuNHkMghnj/D6cS+1GpmNTQneT2mVpkZv27uYQ0lDp
 6bSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypy1xuR1sZXoFjh07QhJCIvuwRGjr7UJQSPhUNt5CpB4DiycZK9uWPba9fTlzqCM6cOgLDJoY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXs8rffsT1OdsYr66nHKv1E8CcrHNwZOQRFR4AFcT3LXr5BuRg
 ok+ADoQ97sgWLMd0Hhq4JW7Ein/voRKVVznrDmwulyrc9EU810o3+DywtHKrRMnko8VC3Xbmwux
 PSS1yEv9LXM6PaU0C1mQNmV82n4LtMXo=
X-Gm-Gg: AYBFou1sl82bNhqwEYVpnNPiwym/un+4+UIYbUdMbN/gfYtMdPzxGoz8k2mImZoSYtv
 oCGiQQvomkTHNdX5vf6utanFsKYMdOoeAqJZ2lnOPAXQMwTZAGd1U39IPCIHZm8XY2MNfOdSv+D
 Fq98ex+9BMBUJXgxaMKgXBSbnXT25ldcGlWP6qb4e5iz+CwpaElfwjjgLv291Drm4xzkF8QeO+I
 mZOxYxDS9OndLBRvvO2b3MY8gOplBAwwWH8a5UWv58YBkHoTOP8ev++m1aZ53Wxdz0DT1bBlqaI
 /Ub+zk0TBdOHkbqUf8o0qlms04oqOKcsv9XZG9gJ4vhz72HNb4Ky5GGEpBgQ2WArZbMX9352nqY
 iWfkpgCaNuqWPYV5PU+/I+g==
X-Received: by 2002:a05:6820:1688:b0:6b1:bdd9:453 with SMTP id
 006d021491bc7-6c736f640a0mr657436eaf.12.1789478363101; Tue, 15 Sep 2026
 06:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260912072619.244101-2-imkyufie@gmail.com>
 <20260912072619.244101-5-imkyufie@gmail.com>
 <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
 <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
 <baf0f0b0-ef54-435c-9603-39dffae10f51@oss.qualcomm.com>
In-Reply-To: <baf0f0b0-ef54-435c-9603-39dffae10f51@oss.qualcomm.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Tue, 15 Sep 2026 20:19:10 +0700
X-Gm-Features: AcwNN1XQy-FB8z7_V5u3d_WHdVSCj8QUUvQHSE_-Hjn6nDChiuekdwDGYpBfj7E
Message-ID: <CAAq9HC4gyauTCqAwn1K6AoGQiXcy8GOmJCXsCJXBqEDDc_Yi8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
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

Hi,

Thanks for the advice, that would be great for v3.

--
Regards,
Reza Kurniawan

On Tue, Sep 15, 2026 at 7:24=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Reza,
>
> On 9/15/2026 4:50 PM, Reza Kurniawan wrote:
> > Hi,
> >
> > I didn't know about the submission when I was making this, apologies.
> >
> > Yes, you're right, it is doing the same thing as your patch.
> > I also wish it could be applied first, then I could put mine on top of =
it.
> > It seems like a more elegant solution compared to my own.
>
> Or you can send your patches on top of Alexey's and say in your cover
> letter that your series depends on
> https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fair=
phone.com/.
> I think that should also be fine.
>
> Regards,
>
> Balaji
>
> >
> > --
> > Regards,
> > Reza Kurniawan
> >
> >
> >
> > On Tue, Sep 15, 2026 at 4:45=E2=80=AFPM Alexey Minnekhanov <alexeymin@m=
inlexx.ru> wrote:
> >> On 12.09.2026 10:23, Reza Kurniawan via groups.io wrote:
> >>> Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSC=
R
> >>> directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
> >>> Add a poll_gdscr flag to struct qcom_power_map to facilitate those So=
Cs.
> >>>
> >>> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> >>> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>    drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
> >>>    drivers/clk/qcom/clock-qcom.h |  1 +
> >>>    2 files changed, 14 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-q=
com.c
> >>> index 6b46d9db7..754ff4ff4 100644
> >>> --- a/drivers/clk/qcom/clock-qcom.c
> >>> +++ b/drivers/clk/qcom/clock-qcom.c
> >>> @@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) =3D {
> >>>    static int qcom_power_set(struct power_domain *pwr, bool on)
> >>>    {
> >>>        struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_d=
river_data(pwr->dev);
> >>> -     void __iomem *base =3D dev_get_priv(pwr->dev);
> >>> +     void __iomem *base =3D dev_get_priv(pwr->dev), *poll_addr;
> >>>        const struct qcom_power_map *map;
> >>> -     u32 value;
> >>> +     u32 value, mask;
> >>>        int ret;
> >>>
> >>>        if (pwr->id >=3D data->num_power_domains)
> >>> @@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *=
pwr, bool on)
> >>>
> >>>        writel(value, base + map->reg);
> >>>
> >>> -     if (on)
> >>> -             ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_=
OFFSET,
> >>> +     poll_addr =3D base + map->reg;
> >>> +     if (map->poll_gdscr) {
> >>> +             /* Some SOCs such as MSM8917 poll at GDSCR */
> >>> +             ret =3D readl_poll_timeout(poll_addr,
> >>>                                         value,
> >>> -                                      (value & GDSC_POWER_UP_COMPLET=
E) ||
> >>> -                                      (value & GDSC_PWR_ON_MASK),
> >>> +                                      (!!(value & GDSC_PWR_ON_MASK) =
=3D=3D on),
> >>>                                         GDSC_STATUS_POLL_TIMEOUT_US);
> >>> -
> >>> -     else
> >>> -             ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_=
OFFSET,
> >>> +     } else {
> >>> +             mask =3D on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_=
COMPLETE;
> >>> +             ret =3D readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET=
,
> >>>                                         value,
> >>> -                                      (value & GDSC_POWER_DOWN_COMPL=
ETE) ||
> >>> -                                      !(value & GDSC_PWR_ON_MASK),
> >>> +                                      (value & mask) ||
> >>> +                                      !!(value & GDSC_PWR_ON_MASK) =
=3D=3D on,
> >>>                                         GDSC_STATUS_POLL_TIMEOUT_US);
> >>> +     }
> >>>
> >>>        if (ret =3D=3D -ETIMEDOUT)
> >>>                printf("WARNING: GDSC %lu is stuck during power on/off=
\n",
> >>> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-q=
com.h
> >>> index 3a4550d85..0b514cc1f 100644
> >>> --- a/drivers/clk/qcom/clock-qcom.h
> >>> +++ b/drivers/clk/qcom/clock-qcom.h
> >>> @@ -76,6 +76,7 @@ struct qcom_reset_map {
> >>>
> >>>    struct qcom_power_map {
> >>>        unsigned int reg;
> >>> +     bool poll_gdscr;
> >>>    };
> >>>
> >>>    struct clk;
> >> Hi,
> >>
> >> It's doing the same as the patch that was already posted, right? [1]
> >>
> >> Sadly it got no reviews, which kind of demotivates any further
> >> contributions to u-boot/qcom.
> >>
> >> [1]
> >> https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@f=
airphone.com/
> >>
> >> --
> >> Regards,
> >> Alexey Minnekhanov
