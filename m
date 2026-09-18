Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D6C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5C1812DD;
	Fri, 18 Sep 2026 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45p2V1UGfrfj; Fri, 18 Sep 2026 15:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D4B3A81281
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744444;
	b=aCTvCe5nL5wwgfIPmUMd61BV/y9KSyJe0v9aFT51ka/pz8OtckxU8DzqbTK95XlH1y5l
	 OMuRWwgjRqNmKDNRUlWpuOpZFZUBUsdV6Px+kc7rxRxFewBGCh+jtacxWli/Dl8Q6PKgF
	 unpjXZfvNUbgPsP6Dgm7MyGk7U80dpAAjIRYH7qlcKRWR70Z/zYH6Um9sHTGUZWGM6sJ7
	 9K4Rmw2fWklfHMMYQAwNz+ftgeW5uiky9UdYeoENarSHbZZAcg8+Qli49zgqNlIsOiBdv
	 2Un7Jrm0dx11epPjmS7BPdmvZOGdx+hUDyy/oZL7JJYqvwyLkPA30ZPDfQlbY54pmRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3bSD39gQAFh0MmgAEI+KfmGU/5OKWLnH60LKljkO3Tw=;
	b=YHEwJJDNLtBE49XlkPfK1VfVBqGbDLEzYzWniJxOXGA1j38KutGc2lSQM4eL9s+nNaud
	 hTCNKS+/yj1JMKlcqkkWoEMGl+s5qLGPAWTh4u1uxKDjeKULLSFR43IflwePF0bVgVEv4
	 7/fAmCEYGvNdqhTKpr3VC/fiUhNOOLPRd/l6W2le5lmCzcjTQykyM5+f1I7WPc6OdGJVE
	 HK7Bw0iH/occnbhwINrJBKT+uc3t/ZzOs998Q0ApgHy1nEp3ie9caqS2P9htkXfLadaLv
	 2KnRSDxV9XvCshTpU8rBsaXxGE7luql6d15n6pGqyAfsWBseM6laLbwjyyNgwNXXW7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aDqzBPlE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789744444;
	bh=3bSD39gQAFh0MmgAEI+KfmGU/5OKWLnH60LKljkO3Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p/9wlkV2I7Bo1wvF+zgZgxNdyzk/pjqdog2vfPvifaBpEsxwQ5emzhjQ06YlDI8oa
	 4CzbhlWsM8KlsYC/cMin/iWq7NxLcqObxeBWRhZvBjBCsKtYv77GSUN9lIlgWITBx/
	 e9nZXhIfeTThlNv+vVFwGOcmYMIhiFksu4NKmI8UYc/F/H25oZ7BtS6Myjdt9tWKPj
	 tzmRW5GUPyxV5TMHiZHTgK5AszYw07e/TP+Z17YZHEIDgcZlyfn+WGZLWovWspQ67F
	 jtDnMHGzYDGoWIms0L78yeYoQqbdubSah+LfmuHSeRgvYBZkS8Y8CE/+fSAfmSVWTw
	 qUpMppXs5A5dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4B3A81281;
	Fri, 18 Sep 2026 15:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7351342D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 650CB81281
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzsAAXKXlTdi for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 15:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A42881277
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744441;
 b=RBmURedED9OrYCvRFIhLwoXNuve8mv5vApZ06TDdptfuUiI6equyAfXhvsE2DQThCXOM
 iIj0uVAprQ50c3LqbRIzDRggiZ7+QrlAqV7A/dibmAyYtYqV+l89lDAyzwUZ4Z5btuaeZ
 oATjG4kdLmquK4f0FP9nja2TmWbKWp3kPFHsmmkPGApmiGETbFqZR4Twoc/MwaqyroLsh
 RkyoV3QINff01kEQCMSpN94fEH/lVgokGL2rKKdluuTx1aPLmuPTfz5O+WCsYAQ8ex5Gv
 aEfBcx9HAIMbvK6lh9K7QOm0IAQvYCAFHXPRrjUMBlxusW7u9pDqb05/tpeWOuFBH8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744441;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3bSD39gQAFh0MmgAEI+KfmGU/5OKWLnH60LKljkO3Tw=;
 b=g8Kv1iS6blAfVKEFnlqF1vFcr77lk0XHJoBX/xbLb3CQOl/h2VD2IUG0NkpZlZdbhh2/
 OCilv1ZoIxC9DcMUHzbODVUqnBX5NENpUySNxI6kA60Onr84CIkkdiR72Cqs94jare7aF
 pfR8gUcCV6L5vt+YPmXesUhBeeiNhXfgvtdIRcrnFL531+wmOrR0PWjFlH6wVZtIvrRgF
 dD58Ni655Wtp8W1hGwx6G/M5mbwe2IYcNdJnB4ff7v8ZJwGVZzO3b3o8M3s8kDUkFypEm
 BthtCVaf2Kg05XM5FwxeTGruYEY0fHni090EECZcFHN9YAcrNcyvfROsPUkawrLiFsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aDqzBPlE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::6;
 helo=mail-yx2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aDqzBPlE
Received: from mail-yx2-x06.google.com (mail-yx2-x06.google.com
 [IPv6:2607:f8b0:4864:41::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A42881277
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:14:00 +0000 (UTC)
Received: by mail-yx2-x06.google.com with SMTP id
 00721157ae682-86f73e4cfcbso837487b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789744440; x=1790349240;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3bSD39gQAFh0MmgAEI+KfmGU/5OKWLnH60LKljkO3Tw=;
 b=aDqzBPlE6+tRuMI4LQeSv8gxhqOuDNxpwLMEVSLn5usuDHgXhFyymsDjgmSnetXqGG
 0Iuj/TcOZS4w+Se5acDFtyukubIp8ZXQaQlr0GRoueFVB/nVb/LyK0FrfzyysSSDInc1
 czQJyl1NCs61SqQ9kG/J57NGnlMn9OrqvyaE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789744440; x=1790349240;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3bSD39gQAFh0MmgAEI+KfmGU/5OKWLnH60LKljkO3Tw=;
 b=V9Pf4ZIOLyQB1qiwTsNNvp9tRoIeO1oI0RGchcyp6QQyf/LQXI7E7O/LNr8wZgNVDq
 h7vR+dIqMS/0h6ovETErBi/KwNUe6GUtInzQvTMkl0MZZWAiE+UQve6sm/9ApU9cBrA0
 8wqiKAvLLcWpXJ7+IXEvabauOQar7IGz3h4u2EZjJW0EZJI9uggAaRGGihA4QmF3ynnY
 tRh6QHnBW0/1hioJ5KlD5SBoS7uwpTrK4MpnzvfKb2A1TPPksrig2hi7yCBsJ8LrNW0K
 N7kIpCq3xRbhj3UlxiqfpZHdeErJAh3FhWuh+8lspR7kXbkzwkB4Bh1veLMMHRlCluFe
 Q9Fw==
X-Gm-Message-State: AFuF++lK5ae9WjrIGj7uVAR1gKyJC33VmU0WbBcrfqYe6CzCmtPClGZc
 97hyMs5I6AVFTfUY7Yygm1QREVgUBvO7LyfgFWvLuzBy7kEXXbm87IRubaY0N8gbdahG+/maM6d
 qY5WSBKjj98ZUFOI=
X-Gm-Gg: AYBFou01SGO3YTu8BcpFbEzipgGQNnfGJ2gpdlJbHLm+x7texXeV0oGGnp/lc2zzLf5
 mNenvyRvXN2E9k9XOz11KUIylZtHChlcusrPgyXsidIkz4UMp8u4O9wIPeusLkZFPrbFk9mjX9Y
 Arbaar2TZU2ydmmf/7ZvVkT/chc+d7TzEyQXpI4OZ2aOdjCfAguHzlEb/8ZkxyrQ9FkUJUFkjA3
 fnsW3kNFrL0FnFsWPTfYeE1ZfU9zmO13BgQyARSjw7lbxvp6O3zLFF67hvklg3wG0Qm3c7tdmJd
 TjJbceJ+CXkM/IM9rb1kL8q5cGF3Oc3I/CzbxJDg9ol9tcC7avMSI3CNOONma4ICZziXfYYNFVl
 QG8NiYclpuWGtw70hyZpzFc5+XgN7LV2uPZ/rxNjtR96RC0lgI+0iDrh3revB8mVuRFqcTv/wht
 A7Qpx6qx4kYcIMoXJLX7AAmjjKWqHn8ApuWPECL16bgQK8ay49FyJtfKHYdCTaTIc5a+fUX1v3y
 i/TPhFO3ugmFjVHGwdzZWWYtSybnxsVZ0yeeBZa3EiiWKncKyiGlxMmbJdzhaYjnDlTlJNJs7nt
 VBIVgJW2LvtFbeVuh0YH57UNPKOydC0=
X-Received: by 2002:a05:690c:402b:b0:873:5bb2:6c32 with SMTP id
 00721157ae682-8973635c2c6mr7396687b3.57.1789744439893; 
 Fri, 18 Sep 2026 08:13:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-897e85e5a57sm5607607b3.26.2026.09.18.08.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:13:59 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:13:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] boot: mention sbox in efi loader boot method doc
Message-ID: <20260918151356.GS858934@bill-the-cat>
References: <20260918-sbox-v1-1-792acae4a3a7@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LImCKUIrpDpvnwHW"
Content-Disposition: inline
In-Reply-To: <20260918-sbox-v1-1-792acae4a3a7@arm.com>
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


--LImCKUIrpDpvnwHW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 01:49:38PM +0200, Vincent Stehl=E9 wrote:

> U-Boot EFI Loader boot method looks for an architecture-dependant
> boot<arch>.efi executable, where <arch> comes from the list defined by
> the UEFI specification. [1]
>=20
> When booting with the sandbox in non-native mode (the default without
> --native) the <arch> that is considered in that case is "sbox".
> As this case is not listed in the UEFI specification, it can be
> surprising.
>=20
> Mention it in the BOOTMETH_EFILOADER configuration documentation.
>=20
> Link: https://uefi.org/specs/UEFI/2.11/03_Boot_Manager.html#uefi-image-ty=
pes [1]
> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--LImCKUIrpDpvnwHW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq1VNAAKCRAr4qD1Cr/k
CoBbAQDbO6CTBxJR78NT+G4O6PS3hjmp4suaQ7ADG2HJNAkv7gD/ar/cSKxZBsGZ
lfjWy6YAaZMXzMCNqrTVtVgZx3wUUAo=
=iHZ/
-----END PGP SIGNATURE-----

--LImCKUIrpDpvnwHW--
