Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6402606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U4xEVfsq;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=CX/VihxL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D01280F81;
	Thu, 29 Oct 2026 13:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r40OAyU8DxSU; Thu, 29 Oct 2026 13:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8966F80F72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793280776;
	b=e6JpmMxJFiIXkK9wfZvP/aj7/q+YEcqB9EUlbqMemc6fBBaX3sWNRcji/niBrgHNMmJY
	 fGezPW01zhux6xOh8wr/2z+NC+miOZgGkEBva3BkRzHRXMC5oZGdUwaw0maq5T9/sftif
	 eXL9+zbwVz4kjxM0x5+/xd/sikEDsnQ8F9SB49PI4GIvn/7ELu1k8uNM4n7deiXoLuGxQ
	 AYi8KQGU6hf6FoXXBkcq0gly8W/JPtXQWmbFQ31S4dRmGvhxOqjwgYgvI+8fgY0i/vr3P
	 7g3BRi7MAVunERUDjUK/nNFSWq7rSeWrBs+EXEEJC6ZZom9e+hBd71DVXJPAr5dLj2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793280776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:Content-Type:
	 Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gxiRmIrSQsCFjWDtiRd0L2iZ8Hr3PCvyC3a+x6Lpoq4=;
	b=h35Mj3GRw6kMJ33JYyQDXQGUmZPgkc3fBZ/sS54NGRBwZ/d6dmk0F1JFI/gwAopqQShe
	 OsUnmGzRFO0uHW53Da275RL8pb3sEODFLhnDHidUhejdxOkL8Id/NYYmLPZxH7I3Qf0xW
	 hnlPidmQx3Zgpxh2dNS8k1/0XsaURqUGx2x9ks1A0gUdAEG7P8rb8TIhCeTsul0HGS2ks
	 CnjxSU0DLPDz7s98Pcal+qRbEnZ7UFLeZW/iOu4HVYrOJvdb6PZzBXFMnzDr3RSjMyjjf
	 bdu8REiw0pW1RACptN6ZQraf3maSY6UJWNOuzZdkWXU6kjN+9QIgqtzdIK/8BBgrsFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793280776;
	bh=gxiRmIrSQsCFjWDtiRd0L2iZ8Hr3PCvyC3a+x6Lpoq4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4xEVfsqhXoiobZ/kT1N17TlWv8JbT7ZzRUDGMPRfbw6B9B8L2fX+/IbG0UXfwDPn
	 rQDSPk8GyNdEPo0x/vUwbGxPLiDmwFKlhszXKpBmE9+/592yoxLsmyqts9SJ5EzM4V
	 cHYBpFKw1iDi6iljAiJ678RmuD48odnPkw4qWu//bnMbRHNhcQAQp+omozVIIW82hy
	 EK6iZwWR/P7QDZgUoj1R9mfT6ZD86/a2dhXHdeRncEVolULUaxdAPAtfnhFFlR7+0w
	 gfHNmnmKEXt9/46fM8a0dJyUEtPp4yovav+/JIYjSSWJUZFdT2NYuTwEDane06YG0+
	 aqEYeQPtsi67w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8966F80F72;
	Thu, 29 Oct 2026 13:32:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF90F380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1B1A60686
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UN6pO8ro9uy for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B93B6067E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793256023;
 b=CiOcYfMWRDL7DFLQ4cdkIlIWIThxBSl3pukIJlhVoUpY6BVsr1NMECesc+a2ffeNswvF
 UMwoT0hZ77iwOX2T1skL1IglHa1lZ73F2LFRwxpYRIqaOm7YEcYZCZGFjury1xveq5Pos
 hbIc/Kj24Pycgx7StDWXUQ8R03HFDIauhDphbB7TU9xpB6PVxGUDS0PLc+D15d4UHDbBf
 /ce+rcGERZqphU8+bF4vCUlom2+CRpnOTMKvwjlXGa7WeCA0g4qTnUbsyLWAw86s9U9XA
 BZReNSKqFXuCPp/9q9agn3nx5JiFLhSPFIW+yUk27tBkIvuN0kv92pX+Jj0yUia3Wsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793256023;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:
 Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:
 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
 References:In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
 bh=gxiRmIrSQsCFjWDtiRd0L2iZ8Hr3PCvyC3a+x6Lpoq4=;
 b=ojGChGOfojA5eDP+fXW+ymj80v16I99OfsHMtN7BJmGuQWwgoq2785jSDK1MOtxHoCNo
 eInqR/SwYuzT6m+1y2V4a4myVom5nzaDSOsp5Ve1kkKaoqL0JCPxounSTXEjiNZDYmMVk
 t3RtAb23xByVzPiOYYNLhDm35DUCmj0pLq2NpWlBuy6JBgIXsZg3rGgFAxq2FA4lWkQLH
 uxdnmPvmgzWCPxFtIgYJ9noZEZvcMd7hkh0jai43Hxdwh4sQfhBMAujiDx/y7EEj96xUa
 79FU452rFM2JgOCfTqgFmW9enod6kDcY6Y3nuF6aoPbu1GyM9bLVfGpQbL8in7Lkdyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=linux.spacemit.com;
 dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b="CX/VihxL"; 
 arc=none smtp.remote-ip=54.207.22.56
X-Greylist: delayed 208 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 29 Oct 2026 06:40:20 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=CX/VihxL
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=54.207.22.56; helo=smtpbgbr2.qq.com;
 envelope-from=troy.mitchell@linux.spacemit.com; receiver=<UNKNOWN> 
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B93B6067E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1793255979;
 bh=gxiRmIrSQsCFjWDtiRd0L2iZ8Hr3PCvyC3a+x6Lpoq4=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=CX/VihxLNjimiAoWsOMfIvwH26vMuTG+d9qKe04N9GYb1RkHW4sIsTASmYpDF1w6i
 lH0syE2jbCXr+q6/FTst+AR9YccUrJpWzQ1Trg4CuOJBDoRRRc72pK9ZaNewnQ3ApJ
 Liy9gUejycAOwMhHgBtWZB8aP2TWb7BPB38HX+q0=
X-QQ-mid: esmtpsz21t1793255977t0073720a
X-QQ-Originating-IP: 2oUU5brKz7N9xTpl8l9W/aGA4OqYRpy8JpSXn747iE4=
Received: from = ( [58.254.69.131]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Oct 2026 14:39:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 687765887663983352
EX-QQ-RecipientCnt: 10
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9e72c6eb1ecdf5c7d51573e91806e12f6fd5a282a95be3b6191611571e5a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 29 Oct 2026 14:39:31 +0800
Message-Id: <DMH46SAKH62G.3B9ZKSF91RX33@linux.spacemit.com>
Cc: <u-boot@lists.u-boot-project.org>, "Yixun Lan" <dlan@kernel.org>, "Tim
 Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "Yao
 Zi" <me@ziyao.cc>, "Tom Rini" <trini@konsulko.com>, "Guodong Xu"
 <guodong.xu@oss.qualcomm.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved
 status of mimsic and maplic
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "E Shattow"
 <e@freeshell.de>, "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
 <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
 <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
 <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
In-Reply-To: <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MIlXBrLv5wHmI7MUfRFM2YshwYYfIVk3IqyFN+zLtUFxCG48gcnl6/Oi
 qWIvV18Vts8vIVRrDpxtpDM9HOgOgu6vKlBLEjj0K4iPXR95Zu+Bz8BUcB6jG9XAjVzJQDK
 /eQ8lLeq4lbr58VJzUR7pk/8+5hNy+MycIZdYQbnptp4Yjbc7/a7uAi6R4s2GpwtvDSquFo
 oWeofqf5KarMMAcy5gnvbmslZM8lMT0tJMgPUDvtjoAA21X7RNFzxVvsLFvi7jENqKSmlhx
 AlY0xdbX5dyhVFGIPUVxYQ5dqMEGBKP06Fau6bmKrK2vvZFea1n4ZfXCQgArlCrt6ZL7bm/
 LshcXzbnpHvu3P92jMoW23Gux9XKa3rjjriOCfd/v4aeRjtGUA9lYaSShlfsi03BYem90v5
 UiWB20FGQcOpzn8HwZm79qTZPO4JqpTDQ6jh3uPOYtOP7GDGQyMyIGx609Jw26w1zc18LC1
 0QkSG8IbVDgLJymGDh2ulC9/IT/P1MNyYJYn9rlNnmUhOtNMlyLCIFBypEc66oZZ19RiuSg
 5l/H57Efzeg5oR/QZjy6wr8+AKG9ZkBOfENViQFlvEIKK/RpOgPmthZ4HKjDfZ5sFPxBh0/
 upRs+9SQNTU5Wh6xvepnUOPV/7JB4KnxQuwAh0DDsCUkQB8sZ6yb2YEU0VS/pFdzgMBBJDx
 M/G2BiH+r6YeHAd+zv5mh3LN07QrAMYDDoV3zP6IEkMD9oAO6pMQzIZdWsvQolkYErIaSEZ
 QP1Zb9hyILnh0ljs58O24sbSVcUFVXt+IDVC3olSOy0zXkeOPkHVCR2H+/vshtWkUGeUYZ2
 iq8ezxqSddzDqLsueUxMdTcRpg2apfgeyUvvF9etaoVDig2mROcPpgLk3QnsK23u1A/ssfr
 Tj7pbh1tph9+KBsrns+hymgiq0O01OBf5CTmhlgNeDz+Ja5yKPzQG43V6LHvDUsqnIEcUly
 jW2jrtHqdz/r0B5FVg90batBCDwPvXV9s7BUVfodLpgA4Mb7WnpON5vt3ipKBXXzCHdXAd+
 hSIVt5270q/Uae+IkBMGXSURjEp9Poi3huVJv0y5Ljj/Xb78tbdwZqgX+5q3pxsHTkZgjLh
 oDAzddFHWwr21McagQC+8BHSgS7eXW3dnZ2gqJbNVxmvLs+UQeb/pq1CV7CraYzhxBs8cSZ
 2oefv+PToJ0F2+gMtiudyg8+jfm3E6nkVJGP
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--9e72c6eb1ecdf5c7d51573e91806e12f6fd5a282a95be3b6191611571e5a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 29, 2026 at 2:34 PM +08, Troy Mitchell wrote:
> On Thu Oct 29, 2026 at 6:35 AM +08, E Shattow wrote:
>> Hi Anirudh, CC: Troy Mitchell, Guodong Xu
I realized after sending that you CC'd the wrong Guodong email.
I've corrected it here.

>>
>> On 10/28/26 15:01, Anirudh Srinivasan wrote:
>>> On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
>>>> Linux boot stalls when probing peripherals unless OpenSBI has the
>>>> enabled mimsic and maplic nodes. Override these nodes so Linux can boo=
t.
>>>>
>>>> Reported-by: Yixun Lan <dlan@kernel.org>
>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>> ---
>>>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/s=
pacemit-k3-u-boot.dtsi
>>>> index 352e85e7de87..278b36acc79f 100644
>>>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>>> @@ -3,4 +3,8 @@
>>>>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>>>   */
>>>> =20
>>>> +/* Override reserved status of mimsic and maplic for OpenSBI */
>>>> +&mimsic { status =3D "okay"; };
>>>> +&maplic { status =3D "okay"; };
>>>=20
>>> This should be fixed in the DT in linux. I guess you could carry this
>>> patch till it is fixed in linux.
> I think status =3D "reserved" in k3.dtsi is correct and should stay.
> The DT spec defines "reserved" as a device that is operational
> but should not be used, typically because it is controlled by
> another software component such as platform firmware.
>
> That is exactly the case for the M-level IMSIC and APLIC.
>>>=20
>>>> +
>>>>  #include "spacemit-k3-binman.dtsi"
>>>> --=20
>>>> 2.53.0
>>>>
>>
>> The upstream commit that adds these nodes as reserved status is:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D56f37e391a626
>>
>> Quote, "...Also add M-mode APLIC (maplic) and IMSIC (mimsic) nodes to
>> represent the hardware topology and ready for potential firmware usage."
>>
>> When the mainline OpenSBI series lands adding SpacemiT K3 support:
>>
>> https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@l=
inux.spacemit.com/
>>
>> ...then I think we could send this upstream?
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
>>
>> Thanks for the review, -E


--=20
Troy Mitchell


--9e72c6eb1ecdf5c7d51573e91806e12f6fd5a282a95be3b6191611571e5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIYEABYKAC4WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCauLqIxAcdHJveUBrZXJu
ZWwub3JnAAoJEJgJ74D5MzQvCwoA/j6erVQCCHvcEKPyTO4Z41hq0v6Hwk/YHIR2
zQUw9NjKAQCkauzigQvwR7V081OV06hR/bWr8johK+1CpIjdSKKtDA==
=GUqH
-----END PGP SIGNATURE-----

--9e72c6eb1ecdf5c7d51573e91806e12f6fd5a282a95be3b6191611571e5a--
