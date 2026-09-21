Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA8AC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 21:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEBF6407F2;
	Mon, 21 Sep 2026 21:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkSeEQTtsDv9; Mon, 21 Sep 2026 21:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E2E67407EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790026671;
	b=tQg6AbKd5feX4cUBjHt1Sa3+HgWlNShNqGwYZtOVZW+79AM5NYcWrKVxN21XW99HcTq0
	 /tMs+VJDgWWXeLVGMiEHaqkhRrGWctOYc71x76UcjuInKqsnY/3lM5Dh0xWFV0ikBSLk5
	 szSoNJ0Np43IjiFJsbek6t3ZZi6bAUtmZcm11++VKh1hDa2BCisXn1KHJDWszwLL2OCfD
	 qoHWVPZ4D+geyzOwCPzK3tR0DHHVpgJXzAmtngIap8yBJYYH1xTqmWWzTo8cP/v6PPC6S
	 Zym4f6e9mrtNkLM0D2P4OV8Pj6oYH7SS5w9i8UTWLomDIAbHR4zEkilLPcbCu+jvVBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790026671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d6yJAPekczsfNTKA6WOrbCJk7SPoINvN+p0GS3r4u5M=;
	b=R8bq8arcSDiCVsdIBKICnhLxq7QVikL8c0G1CvcxNiYTujWglZOh6vLaLr9R2VzOA60t
	 6odrt2IAZsTB90oN28CIpAdyZNN+B0kkdFNefqlTHJnXpEKg/s+cQ4BrYwRFxeXM08F8E
	 +gS17jv3FC9ANS4ELxjG4mQPCbj/0BRQa0Ta306raDDnZ3hnNXcMqmqjaRH1/i7ZzcMKL
	 /AzNh4+5XPFyj8j8k49DLJkTuBGtJoLQYE/qnd49ratXOHvd7bmz4Qpzlq1QsahEKFlSN
	 iM8nw50unBF3EWd3thbz58Nnjl4CHObiZ+L4VNAES+g46SQvhEcVUSL10k3BnmnBt9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790026671;
	bh=d6yJAPekczsfNTKA6WOrbCJk7SPoINvN+p0GS3r4u5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7i630laoaFZBEVZNvWzYwg6nm6kuDQhCzqtRWngLpeu6v+EbuDpQH43/Mz7PE5If
	 b6+muRdD0y6ImjL2n2UaMtsaN0a3LhaoJ8e4hBC+3ucUQ2CS1lWTt9yZ58zRcsPiA7
	 OArpb8GbXG17BGZEnLtKazIGeCVUhllaf6W6RpqwgGuMmf7CUGHOT576KX/6x1sc7M
	 HTfF04E9A3mYsjZZ+JMc3Jn5/pofeHFtYY2zJPclHlyh0SqECPhVSwwQMUx+2ka1IN
	 s8KUZ2FjuFaahNYGRJE+uYovMziFz4wgI08XnPsV2Ny/hKYbD6sKxnKHc58FKeesS8
	 iX/q/wyxJcJnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E67407EC;
	Mon, 21 Sep 2026 21:37:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E0299CA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 21:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 645E460674
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 21:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5DElXMRsfT6 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 21:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C64F60628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790026669;
 b=eKQfrz4ArcRYEDKwJWGqJtAtARx70vIyYrlWUUugZKr0IiY5tJ3za+3Vs2y5pkOkKD9A
 XRHgg7uu4E+e7TQXxTw8Rnt5pelfhmLqKN0MoxDxAou9qhCjurZpBpWuztO5rG13BxV8I
 0ke6+Oedhyew+YZ8e2363Rc4NI/0nWlBsk5JVg9w6jXBb0SzL9Hzb1td7i4DTVSrZA2d9
 eqU3AkbeQv17ogPXnA6qAt3YqR3ipL8wrIJrBXyAHLLd9pjdJKPOfH1b9xxeshw+HeHtB
 POIgHdn+0LZZdGlyOm0vvKGqcubl3QwN9urUCD8e7qJqf2eDoVrR6DuReQ4L/K6g/zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790026669;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=d6yJAPekczsfNTKA6WOrbCJk7SPoINvN+p0GS3r4u5M=;
 b=P2VudjGOOzS0sWQ7ltBPsx9qnjHG0SIMURV9dOtpAVmCR82JH1EuyfeIws7Ih6eG5mhT
 OD8PGQfPZrBChYUOmN5K8lpBDCAffkJ8vu0AqlTzu6shMcc0GmWy7AgZt0ScNfb7alGjr
 4WBg3puG57hbhgPuF4RlvNfDhyDb5jWHKEhnNLY+drJN82bOzIGRLot6XJvu2RLsPul8+
 AJEBeC5A2rLwMky1sA8gr7xQs/MqPtJHe2NBlRRybWJ3Grm7p2L8QIKB8shB4GHTiBlo/
 xRtmbfawRYfSy6rpx66Vq28pJxRLHCHNaMq42yzFBC22UVh7hL0cvLIkp7+ADxXIeHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BcUji3vr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::9;
 helo=mail-oi2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BcUji3vr
Received: from mail-oi2-x09.google.com (mail-oi2-x09.google.com
 [IPv6:2607:f8b0:4864:32::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C64F60628
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 21:37:48 +0000 (UTC)
Received: by mail-oi2-x09.google.com with SMTP id
 5614622812f47-4c9a4910efeso787711b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790026668; x=1790631468;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d6yJAPekczsfNTKA6WOrbCJk7SPoINvN+p0GS3r4u5M=;
 b=BcUji3vrK6YuU3EnFfWNSWiTr6ql1LwDQKJr63jR6iKIk4G9RFrSulMGZH4ThzkcXh
 I7+9Ow9DwzAKVwz1jQb4BATawGh1oVVPW4JbW+v3NKsL7Yx0bATLe3YCFPGXlSOARMpS
 qhTZpoqF5xEmQeH/XfSbrwYfXV/A+iKSHgFKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026668; x=1790631468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d6yJAPekczsfNTKA6WOrbCJk7SPoINvN+p0GS3r4u5M=;
 b=bnVgJvvgVCYMk7x1VPwmlgs+PgzrcbumAacU7Dj+cxtzNBoAqmHui56HoAvrz1JS6u
 GAGq2oLAnm56qqD8STpdTMEuwg6qA8PzyNrCgB4WnwyIzoPPVQCrcRPSKtw0OpAuch/Q
 vBvUXYn88ixKnO5FOod3k4yzpjnEq1Se8Fi9cllR6W2w1MyGh+aCsd99bGgIYF8KsKcz
 jfPeN9sIas1IIQ8aHkfCez8f71uoBG+Drt7fjUOqcL5YHa46YU1sXwpdnvuHnyv2hEs4
 fpAXwAqLTwAtxi20tYbOtIxyVDA4Y9D2MzrbvCV7LyDtJSz+S9VPY2Lfue7cFGF04tpG
 5GMg==
X-Gm-Message-State: AFuF++lnlU1yAHMwxWx5chibX7D+MsB4xDLf14Pa7spLfpIgaAIuf8P5
 jc7SyltQMCp+IgK1l+iB/+H84eygyx9wcYMDnXQwqKUYjuzYqJXrUmmN7AYLn2q1M5k=
X-Gm-Gg: AYBFou0zMze7UsW3ZR4YSaO4RDa2MgGpw5Bq624KNr6WzVxLQ25Ten2WwlI8jOhRFGK
 sB4cOyx+2fhRLalp3QnrV8KnLHMFDab2yY525012/1FhfPBl6ybZ4L6mq/6ySKxcb6qmQO/bL+f
 PFq7V0zUrfRUpDiQfzYSo6F7hSy+XpVU9I0ADF6M2YOpetpzILJdkZzOg7VRzRg2hFLs7Q0yOAO
 RRTgDLKftYqsGNzJ7+PtCCz0MuR1CFkQKZ4SaLyLNf+lFGmSRePOZ3XFuZrSuOJmDfvQfC9p15d
 64UKQRYn5QPRve6GuIgKgKTPztSme5b9Kia+nLRXoFTeOx+dlgbn5lRDeZpkQKlAnUPHIuKGxAB
 i3MrbSJ6svW4845KMz5sZwzPrStysKn2ih707WBWA4VQKRdtpe2eJxxaAOrxn7PMYmuZtB/ay/G
 coG7oMYHoBVZ6cAKb4JE5HYEGtP+QclyAD4J/aQHZIERLd/vfM+qdy571Y2pWThmVtm1vQ5YdWd
 i8sFtVkU1fM77fPl+DsYGVdt1gHSmnMnpVMkcWmD4KX5w91KBVOZ73wibesU4tj1vop9PYN/SFL
 /X7aNOSRZRpMLTufk/w=
X-Received: by 2002:a05:6808:6413:b0:4c3:a091:52f9 with SMTP id
 5614622812f47-4ccf6a66ff0mr11953749b6e.2.1790026667689; 
 Mon, 21 Sep 2026 14:37:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d486e03ef4sm95159b6e.1.2026.09.21.14.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:37:46 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:37:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Vincent Jardin <vjardin@free.fr>, Cole Munz <Munzzyy1@proton.me>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 0/2] lib: Allow unaligned memory access from
 decompressors selectively
Message-ID: <20260921213744.GE858934@bill-the-cat>
References: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MZuZM11ciFSbxSN1"
Content-Disposition: inline
In-Reply-To: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
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


--MZuZM11ciFSbxSN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 03:44:33PM +0400, Alexey Charkov wrote:

> Some decompressors rely on wide unaligned loads, which get very expensive
> on strict alignment architectures such as ARM due to the need for the
> compiler to reassemble each wide load byte at a time.
>=20
> On the other hand, some ARM platforms such as Rockchip enable the MMU and
> d-cache early, making plain unaligned loads work too.
>=20
> Current Makefiles force the compiler to work around the unaligned loads
> unconditionally, which in case of e.g. Zstd in SPL on Rockchip degrades
> its performance by a factor of 4+ compared to native unaligned loads.
>=20
> Add an option for arches to opt out of the strict alignment flags for
> decompressors, when they can guarantee that wide unaligned loads are safe.
>=20
> This improves the decompression performance and reduces the SPL size due
> to fewer instructions generated per each unaligned load.
>=20
> CI for this series: https://git.u-boot-project.org/u-boot/contributors/al=
chark/u-boot/-/pipelines/1322
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

So, as a good thing, I see this is already implemented in a cautious
way. I would like the symbol name to be a bit more caution-forward. And
the explanation in the help text should note the performance benefit,
but be clearer that (a) it can only be used once certain conditions are
met and then (b) is only removed from certain parts of the code and not
globally.

--=20
Tom

--MZuZM11ciFSbxSN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarGjpAAKCRAr4qD1Cr/k
CrqWAP9tPZ6/0NE8CAzw0ETmrvUWAFmlDMBH1JnfUXPYpYiORAEA2FRsBvu10YwJ
mftUSkwFZja9MUdbRP9s5Gznj93VPww=
=PWkW
-----END PGP SIGNATURE-----

--MZuZM11ciFSbxSN1--
