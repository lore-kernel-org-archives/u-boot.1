Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE8606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z0e2xMFI;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=kOUohXro
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2020340737;
	Thu, 29 Oct 2026 13:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id veMc9vYvj1LV; Thu, 29 Oct 2026 13:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0365040707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280775;
	b=FxrSKDZu64uRxyfQ9YjGHAV/Bw3CH6Lm9zFEB6QZAWbeyx51k94Tu2UNeiWQUAGslrVF
	 IYa5kz1+oxveVBc8RMRpvmLekPhCYep0gTdI6kExDzVKTygwKb5ezgGgf+KOiDPZTu/Pf
	 jBkMNo17jgf89cK6QPgtU1Ag5meCAGCgJ+1yYI+nWwL1d84kgbYqmr4e0EAY0Oedeuf3/
	 JKxTH/m+SLjHMHYk60hI76y2144m+JXp63ITY2w9V4U8w1BuJL6NLFlr2dGMWWX7HotC9
	 XxsooEP5hmWJQo1iskLVd8MwPa+p9lJ6ZC/9uB61CyKWA1TjxML2ZZK0VvO7FI55iOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793280775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:Content-Type:
	 Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:In-Reply-To:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dTNYnTtxW5tGgnciNx9y82mnu+DQzSwM0fzj7/2viOg=;
	b=rm03cTKFumuzwMb6sS8bKbUZuH6YExLqgdeakg45rmAmnXJuXVloKGdWUKTLZ1OXsqkg
	 4OfsN1LgZp2xl7NXZzvU/kuJ1mtnl4ESIyXyugQzM1L2K1hAe2/2WMf3f6e5Uq4DZ5R2R
	 d7SmqyBL2V0NCOc3/mrBs5tzhwNCP10P/zJZmIjj2EXBloggBhM95MXrNOy5GyYWMnhFU
	 lDwgD8QU70eHQtlidjCnk+XV4/49rcwLFw7mRs50nf22s/uRlqPF3x8+l7pKK/RB1ZNLN
	 tHhYcM5KDbfFpOKISnrZQdVWWHQ+/qObRVm6RHDMgDJnNJiXR/Gfqgu+YkSidjtpqZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793280775;
	bh=dTNYnTtxW5tGgnciNx9y82mnu+DQzSwM0fzj7/2viOg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0e2xMFI5NpjY5H5F5MFpbwjTQpUmuOduk/0q+cz+mkvlMIX0S1WaQIyK2wAQgu1J
	 amZHi9rn0P0vZe18wr2uecC82Spzmt7w7jXcin6e9vQndUSpgZPPJdVIj52kXxK3Sf
	 w/8tim2ZCZVnjV1dj8F+yTG8jmCdegIOhR7cNAEO6aXWKuL3t+d9Hr8AlrjeehuSbK
	 m1TL44YYZ/jMde2OT3Ak64Od6Ely9VXhuOrqH+mvde33cXSwy9UyqfOOk3Gwph5YAJ
	 bR55XpFVActowbFJkF41tV3ieVLQ4RaM9+BpJVA4acRFDsOoG4flqIEe2vpswE0UzF
	 infmi37nhI74A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0365040707;
	Thu, 29 Oct 2026 13:32:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2888F356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05E6F40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hEki3OF0KEjH for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 95ADE40080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255829;
 b=Jgz+qm8/8PJD/pnLm5QbRzWOqb4VcGlBRD0uOCajC4x5KG/469gmOLaH//hfC3rouMpt
 QqLBRBBNS4rhnmOZ2eCzjGqnkAO7BD3lwoWn20vRj67haPcl3ipqLAPylxxekLIOUg1pv
 mChOjh0lcc8il5qFYzzw8cJNimgnU2gMIyLLrvaAM3cPsFqQaQF8cBDsPfOKI3DtlLCP5
 WBKldJg1lEHimt5R8Y3ZZdmyUxWpQoMvupeu+gHnzROntlifD/LtHFvMU8RaLHE2VeT6l
 skQkKJXtdo2M94y7K1m5Tl2Qccp0VskzC7RuoB753ua1Udf4KpfBMJHKKGjN8+5d4vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255829;
 h=Received-SPF:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
 X-QQ-RECHKSPAM;
 bh=dTNYnTtxW5tGgnciNx9y82mnu+DQzSwM0fzj7/2viOg=;
 b=qY3Pgrm1Si6dMkgQ/1muO2s/A7avXyhzvWWiqXbMn6o5KHwOvRBDXuEkcPULZNjl+bJE
 eUubsyaXNTq20JirAggs2ma77tMcjHmrRD465TcCRSBIFqmkfXWtaMz8+W+UNORZCyQC+
 4epbtoS0VClnGxk2db1HtbU1wtqYAcx+LhEvlwQoMz3MsEW0KyqbKCQeFAJnhjMBZ3NEO
 KAZ6kxlHpgMfJLe9JGra+HSNyux494863XacQmXL7WzmjzrPe5H2PjOFYoVU/I6TySosP
 oCMkEqzHE1ndtuwd57FA94rg/x1VgQyO0W0mRZ91HBq06QkI5vxy42pg8NW+RxtA4wA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=linux.spacemit.com;
 dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=kOUohXro; 
 arc=none smtp.remote-ip=43.155.80.173
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=troy.mitchell@linux.spacemit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=kOUohXro
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95ADE40080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1793255732;
 bh=dTNYnTtxW5tGgnciNx9y82mnu+DQzSwM0fzj7/2viOg=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=kOUohXrodcynaOyJ7KeFZw0FK4nEdB7e550c8FXvTl7tEcdRfiU5Lg/6AWZfNBusi
 ZlcdCzHtjXO8t11DqW0Jki0Bna6GzsDQQde/gsjPs8dKBILevjyIFX4ltbY7FboyYX
 bDd1bcgniu42JrlOJ71Fmht9jNOttTLkWxYqjTIM=
X-QQ-mid: esmtpsz17t1793255725t55ce4ef5
X-QQ-Originating-IP: ON3vSkGa33UYQvBQ5Dke4ZG3gG7Js27uNOpelUvPgso=
Received: from = ( [58.254.69.131]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Oct 2026 14:35:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6680566752463418464
EX-QQ-RecipientCnt: 10
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f686e8e6ca8207550799ea8f1857b340aefafc2a4dfdb0f274a5e8747090;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 29 Oct 2026 14:34:28 +0800
Message-Id: <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved
 status of mimsic and maplic
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "E Shattow" <e@freeshell.de>, "Anirudh Srinivasan"
 <asrinivasan@oss.tenstorrent.com>
Cc: <u-boot@lists.u-boot-project.org>, "Yixun Lan" <dlan@kernel.org>, "Tim
 Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "Yao
 Zi" <me@ziyao.cc>, "Tom Rini" <trini@konsulko.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Guodong Xu" <guodong@riscstar.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
 <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
 <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
In-Reply-To: <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OfkVoC5krDM8V24b8cKB5o7BFnN2hTWLVnScsZo+Bd1cceK0F+PUVJbE
 sMx1FT08qJvKzQ+m19D5l6MkEyPCwAstAGr+ayLE6yFmbYISf/zLqh2e4eYXIY6VWIr9T5a
 hyCRAtJXHpdZbGRylrmsmKk7kaXm1BhMUD7L6g7f2+gDGq+aSaxTnNQ+ynGXUW0hyQTBd68
 pk/Ptyq1bOaRVeOUJBx+PB/N9x4AnmU+Cz//bN9UStejlWoPGbjTm33VPuoHcDEaQpS5dug
 V0ERgqARlxMZt/uceGOKeKwBZxQZJREB/ejX0z58dKF5y7CrSGm7vH0zo7TntrFOOy59CwZ
 WnqWyNxYnCWEWvg/+xxOvebl8HpbeiJfSCogHbm3H8x6eu7yWAOraPyE/YAFyeL0ARz5N4r
 AKNGc41H9OSkltg6YAVCWeMA2+B+YfGLoDwxwcKQrk9XY53bAxGOpARa86DdLwikifZk1j2
 +5/njqlq703OStIMGGjvoPbovEx6l2SKwXImfLJQFZJep/7853kgq/TUAiu4ZD1jKX+JXo+
 wQlQq3TxFXZPIIfWZPWtJCjKewI2xeFcxsewk0DQ7pEbjoMqvxCjlXOIZ1se2Si4Uaz3Ynb
 VDFg/wt4Ard0VRUuJFX53GikoPetpWdYKnce05MgtNTTxTA4RaA6aZupQEzbeqN0wBOiAZe
 L/iawurm19B6yOi1xUT1APA4vtDMHut2HcyJFMK/yLuS0z6tUyvQFBvEJ3ioXtTJ+3tZYot
 u5BLNJD+saSRyIA/DCGGjRIf+9PE6VQey/wsIjqt9BPiCVQn5EBXLye8FdMN95S1qotd/TN
 /LWAD1WZ86RV5VYZvdJYLjviWwOdBSZIAsul5/HhMaIfLC0uZlyucXgt/Uny0Y7Cj1WwhkY
 vXxcHK74T58yNKT63GmjAoruVJfd8Jf6vx5O5QGInNICLFMPfmMMD7dee8uE/0DXw25yiXi
 O8pXDWLTzNd05TACgkBluTKKZLIV6zBfhj21U2t7N6alts+lgEqqlNdkLaUOapHz0nMY1El
 jvHIrRA/0FTKkSKxmhz45zf++k9VGbh28wvMh1oO4sqIgUR9yBn3H/ZBdNs8SKLi3glq6jA
 N9/8Ja64AePEQqnppJKPL4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 29 Oct 2026 13:32:54 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--f686e8e6ca8207550799ea8f1857b340aefafc2a4dfdb0f274a5e8747090
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 29, 2026 at 6:35 AM +08, E Shattow wrote:
> Hi Anirudh, CC: Troy Mitchell, Guodong Xu
>
> On 10/28/26 15:01, Anirudh Srinivasan wrote:
>> On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
>>> Linux boot stalls when probing peripherals unless OpenSBI has the
>>> enabled mimsic and maplic nodes. Override these nodes so Linux can boot=
.
>>>
>>> Reported-by: Yixun Lan <dlan@kernel.org>
>>> Signed-off-by: E Shattow <e@freeshell.de>
>>> ---
>>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/sp=
acemit-k3-u-boot.dtsi
>>> index 352e85e7de87..278b36acc79f 100644
>>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>> @@ -3,4 +3,8 @@
>>>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>>   */
>>> =20
>>> +/* Override reserved status of mimsic and maplic for OpenSBI */
>>> +&mimsic { status =3D "okay"; };
>>> +&maplic { status =3D "okay"; };
>>=20
>> This should be fixed in the DT in linux. I guess you could carry this
>> patch till it is fixed in linux.
I think status =3D "reserved" in k3.dtsi is correct and should stay.
The DT spec defines "reserved" as a device that is operational
but should not be used, typically because it is controlled by
another software component such as platform firmware.

That is exactly the case for the M-level IMSIC and APLIC.
>>=20
>>> +
>>>  #include "spacemit-k3-binman.dtsi"
>>> --=20
>>> 2.53.0
>>>
>
> The upstream commit that adds these nodes as reserved status is:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D56f37e391a626
>
> Quote, "...Also add M-mode APLIC (maplic) and IMSIC (mimsic) nodes to
> represent the hardware topology and ready for potential firmware usage."
>
> When the mainline OpenSBI series lands adding SpacemiT K3 support:
>
> https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@li=
nux.spacemit.com/
>
> ...then I think we could send this upstream?
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

>
> Thanks for the review, -E


--=20
Troy Mitchell


--f686e8e6ca8207550799ea8f1857b340aefafc2a4dfdb0f274a5e8747090
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIYEABYKAC4WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCauLo9BAcdHJveUBrZXJu
ZWwub3JnAAoJEJgJ74D5MzQva2sA/1XKzSLLwRi4l+7oMnNgKUTawzITBiHoUw+5
DstrbB2DAP4+EKMhFhHlFhJNOEiiZc7A1YodIHBQX1+CSrQS8ODJCg==
=wuCx
-----END PGP SIGNATURE-----

--f686e8e6ca8207550799ea8f1857b340aefafc2a4dfdb0f274a5e8747090--
