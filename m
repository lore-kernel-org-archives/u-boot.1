Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB3606D811
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yjusKRgU;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OIQXMKLl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 563E081134;
	Tue,  3 Nov 2026 13:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YC-nFb8YLcu1; Tue,  3 Nov 2026 13:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 129F481119
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713950;
	b=rTASSaDny/Kh3NdjSvt5qkB8UmMEyFV4ZkEM/4vP4SsGJYFh56HKCR7I6Rn0TOpceg+v
	 T+vT5y7mxA9K6mZ7ljTE2huDftH+OP0BEjWV+Z0Z4hFsylVib+96+OIyHx52+5GUVPrxx
	 7fO+kDR0e0jtGDB/RRuRtVPcXqgOW5AuQ3B0nwi3MLWcSFbOUMUmGLM1tYA3oUnwXzR31
	 QCUbnd5pLqr65ID/rv0ky5YCdpMEaOoskJwW5Bxvs3XQStFQ6MpJ7rck8UNsEwbZS6ppb
	 aEY1MPRBhtXrsr/yyvaGKxLUZjn630pFZVpENGe1c19bGir7e1oOH/0hIhPN3Qemigg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RPrvBj3bgw16OAwyP5BX+L0J7vVGAI6rwudB2XDBrRA=;
	b=WirlzACy3xn76IiWXg0h1qZIPBNZbgPFunlBv4TUiQ2epYgZNLUjFxp59qW3XHgiQh/q
	 pMyggDXawrhrXAklcddAt2M8pxx5tuySUPuOcIfcS97VFISC5xrGAiAZOUChCb2zSDajS
	 hUBiGkgaq/dv3/H7N1jwJLXBRgrsyaDLfThzzUcGUttR0Oaf5vntnkkSjgR2EHA3Y2a+8
	 qC7QqoM4RglpF1WuIhLpoodYTy/ssY+BM0aeggTBdkYGsnQCTbqyNNOToBvNr1blOwycD
	 FP2PMIXfhrct+t/vf4t/kDVy9zeyao0EpSLrRZ4jIpCCyy8558/hmyjqaheifSSaPiA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713950;
	bh=RPrvBj3bgw16OAwyP5BX+L0J7vVGAI6rwudB2XDBrRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yjusKRgUkn++h5KtbimDGtqFPiUZNL6jpZsQSE28FPkHHn39oxGlxMMKp5cheZYcF
	 PYXLtDJmGROPOsZSlE64b7bMU//uPGTRGxI2fnbai/94wk3C51INtX1T3nIWP38HqX
	 C86ZMFeziXalJJCOiTrqyyc2xflGVkE+45lrG+Me4htTHEfo6CteGPqjZ63AMDfqls
	 FIrDFCB132qMv6lFRsNscaOy8Ch7cKRn0iJfPFgV7MG2F5zY5BxM/OuZ9C0k5FArfx
	 sP9RNkNfDqtUW1M7cMdfCGByBWtAoDdteVxfymAJbnYtDHaGmpA7iGvwW9qQCxyfud
	 T863YXcLYofBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 129F481119;
	Tue,  3 Nov 2026 13:52:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EBB6235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 641E440070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePF4g-FNYv1S for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 898F740068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713947;
 b=K7/Parix3IQfK/BMFfXK1bADIlmksMR7KhqpyuRlxgSI9k6Y32gs1zX5z4+mAMxgYhx7
 +w87UjIecBp+/VFNjGIp/5by7ko0euRjhwcf7JO1xtL/WFjjWsg+0TpkLEAe6k5wXMquG
 P2raGIci62/9AiTCAe0tEEidznvpRUw//47Yl5fSdGgaMfq8eTJ71YiuZxGO6Xrjz6T48
 PDL2W6vxhT/0LIO/b2aQU0eVfMWPeenV6ztsfJeUCKC70KcTZqF/VGNUVr5SZNKuqzsX6
 ooxgfGYXOVZr9lhG51V5PiLMcR2UM3ulkXJgnNSxLdXIupRqlETYBH41kyq7nAQbgZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713947;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=RPrvBj3bgw16OAwyP5BX+L0J7vVGAI6rwudB2XDBrRA=;
 b=in5UYapiWTJnNbduokROnV1N1HdZsAiewEg1NCmSX3fUNmj3WnIM0qtcDZSe/J+N2U+0
 MKL+WjESDYN/chLvcG5QUlwwD0XrWpmun4XWAMy4YMy3TXZEjBysk8L5cmkVJFiVI3gm7
 O6vciK3300ie+IIEfqhng43+CapqmCjkV9xc7efmOK8n56N8y8S0iOqFobIIL/jWiYBnR
 PlJ0i83c/sZODDqiSVMtnpZ51eOLrEl5lpMdk+lwFqRwwROCReA37W4d7NWa1b26n6NAT
 axae1sSlWWCkkRLCpD3xZjTljp0Pzer+pgPPNxcUZpw4leivoEfI9dffYQ/EezndQgg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=OIQXMKLl; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=OIQXMKLl
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 898F740068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793713941; x=1794318741; i=xypron.glpk@gmx.de;
 bh=RPrvBj3bgw16OAwyP5BX+L0J7vVGAI6rwudB2XDBrRA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OIQXMKLlaFpITPvmJrEq0GbqU2LDoGWoauOLoH1g7JXisV1lKw5LSkoVcV3H3IdA
 dH09rspK0uE+0/Na9mnOgFZHYtBVsekZ+Iec4eadCV6ptCEffEFPTNUaVwDiHF5OZ
 uO2qS74kJRrSohliZnNfaVW52kID7RQNMr+PL3V+Lt5SMHuvCEBUZ4n5T/fAT5S3g
 Z97QvT5m8HWzz/gy5n5wNytThdzBKeW3249PkfDi8x3h4PcDtXWYExjZ/+wmqP6wy
 BcewDLfOAg4ScADcR0dnXc9SGxxLFc/uAXDG5o+NE9bwdkRDs/bvTwhJny1nqEJFo
 k8SY71F8aSWmei/kLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1wUBk20KyV-011wAm; Tue, 03
 Nov 2026 14:52:21 +0100
Message-ID: <e54103ec-10c1-4342-8a2b-0e639ac0f6c1@gmx.de>
Date: Tue, 3 Nov 2026 14:52:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 u-boot@lists.u-boot-project.org
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261030143843.467968-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+urw5rZNI39UCSwtY5URqy/MhwA05r4BLpqpW9qJP8TsITxWDq
 WQSfuAFRf2aqdU6obJY1WIikubRw5d5ar+lBeemRdq/aPoGoUTnC0Q8xIcRXgRZTAbADoDJ
 ochngjkE9Oz7hVt62o6C4MVKbZkTKmEVS5mcPaR9Xt5n1Zm5Y9DvlcYGCueN7xwTPIKYtx4
 xf9iqRS2pAWdHvELif9Ww==
UI-OutboundReport: notjunk:1;M01:P0:+PODNALU95g=;BhtHO403C5YUE2+Cu/Gx1Ds86ky
 hHpeTjnxfmy6AUKFaVHbuFBZgyl7ovdatCrpw88Crzi+S+CyKK+HYHoQheCF+9nbGe9jfTvvU
 jPWEJv7zMn/FjgRWSA5hJLN0tbmqPLw2lkj4CqtfAeL4ksk/Nf6zT+9k/HClVrQjIL6raUVYI
 WyXDGA6Ky9PWyi2tfART0D77ZlVkxT2f0Mh2TbXN2p6L5Kff7VSr98HfRqctcSXwqPNRCyGB9
 BnZ2zhqJ39raRD7y3sk3Hrx5qOllLbjiWFcbwvGDwJSTzsCcIWwohhLt2Oiz610X5xZaImqbl
 thcm/ESrlbvP5UmB45Gq6+xJyO3ZTadiNCZ08wMFc2lHeG/qFynRBwWSNSWkWydBanutwh2p3
 RW32Xu68jdHuDODfK4wfmUKhpqyFdyPnIEpbiRZMRQlZ5nWl6nmHPDK0MoarUdRBXcuSjRqkG
 GG7fBTVQqShjmPa+UbXL5NKvK3MkqNAK7b6bFIBgy8iKSl0HVLLwG+FLzIPBEMPoJBk9r5kC2
 exMlfVIM1vJc90pLL3b7ddZeseJHg9f1MywuIRdUkciTLKO6Hq+levpbT72hsdSyRaCuzGkRU
 GTIko1JRozUb8m2sPp7Mf5LOeWnS8UC/KO81VyI7H5QBfZo2eahTmfLrrxSCG/WYzIE1qh2au
 r+kiTZR+rdcy6yxeBQzOn582DlBVvjI30V3+XP51KqcqBqgMkqNPqwZ+DXb5Ays8pjQkar1jQ
 +7TUPd66ULtp3z+P6J1g+AZ1z3tgME1U23eU5+kqOuMEgDQQUj6I6BpHKtXCB9l8FA1SrG1ia
 nxwzqv5Kzj7I7KnlusxBYSFB1d8MxtFt3efz3VBp034HdvS586T1rHPU0xDWHmcuwtk7gE7cA
 iLTlj+M8iMmCrRPEp7dPpvEHE20kkzt892ml2xBfXR7xe3BOUAB+UgEn50lyTyp5MKtu6du0J
 G9IOItTHLEZppsHCLEoPHTOlvZELTWxXtX/WnrSADtHNGwiF/4Q6oqIqYRrTctJlBQ9e725Zo
 ZyPgbMfuguNG/2vo1KAviHCKQQgPS18NrB61YXKkX3XXKvFUscmax4lhRl2Lgqid/U3i3IE8K
 /4hm9bOwgTK3BePZx79WzI2EQWHIqeMbsVtl37dik7HBTZ5NKj29DXCp0nhppgKgWIEtU7WQ2
 dwgu4jzng17O021M/rwl+shk2le5GZPqCXgOTtn1Ig9e/Jau4P6Dx2T8xI0Zf7u38L5c+/pUV
 kuYJFV61Fk9aG5ALJvtqACmqXjTm8J0wrfaSl8pdd6CrrMoM8TJk/2PQYmSj8c3gPnBTbbFD0
 r2O29gFk3lM94X6ch5Bf9h0zVqNhlIBAWI3ryrpBj2rbRd7UE6VtOf7tVcK1EBBOTllzRXI5g
 el1hAqjuZcsdQ1eciWhXgPcES/C3/WtoDyfgxm5Gal4Js3L/aUM0GIW/IqFZ1a2ppPxlyBfs1
 eZl0XBEMVrt8bvwAaLE4t3Xe8Q8WDBM1uNUNa7LnF6uqKypFrBoImHYSf/IcMQxxenBWTMSzr
 tcc5ZATxa1CjUohb0BnKnxeiYuhMf7BbcYFvc+fAM57gcH5pqbibLh3tQCzmoLtRh9QHyVXZf
 gBk4yslem91t5wp2OhMDDte1HvwvNktW2E1u6/TvRvzjKTniuxcwUfiRkQL0qBYFrJaW+vQsy
 Wo8tUBlF+wWxlgklAnnXjjcxqMrAhq7n6LU+wqxg2RVni+B5gq0MBAeO1UcZzPj3yruUvg5bq
 9BmE/0KrJpG/6Zpius5FvBgUKXfR/Lvn4NXjBZihsHiRygz81lzW4MYFYK64gCmdKLbKbrJ3h
 ZkgZKRGtWwFOnHinpmA7l+upfYo8Tuqjaj9n5UErxfVVmpGPYaOpcIQ/6hT3+ghsL39xzp/gQ
 tSEvrNS9MkJR7O2tdK3x+JP3/i///n7Q6N6QHJ5RK62rL25rSk+rxGgettYUmJBwNytr0QvxR
 4KzmA6+TA9+awWrvFJ4w3h8FmhA8SRUpHF53vQWHBZXagjgeC1qN3Hh7tmhreXzK4LWukKWVD
 DsKJptvWZl3QCIo/EMyAMtQzYBa9G0qIVDpVMyct3xcZUZxzI48Bjj7HD2qSNYgSc4/x7Fv2j
 nXdVadEMuuILlYs7kGwj1+9DOIZ8HIImLGbljqaXpdW35GqTxfZnfacztCwd4o4yXfHzebGDd
 slu6HqMG+qI1bZEKsh9xnqrFEAJnvap7d1qXu0peRmNtA4o1l6YEw//DcIaHP+x4KMPEvPXdU
 0YdbJNqoWA+7xTDG4s1ugZKd8w+NYSGN6g/1phqSzvbkINe9jcIzf+K4N2HXSxyDpGerFKDmk
 jfQ78z/VVUfrby4qkIjq9NkLydIk5E5cv5ubMNB2nIzZxuJCVs44XiK+GiTvQhS0zf0WQ4xl9
 UmPcWnR2s/4dJHI1N1f+QW0rCOe1QtrwhCUTWYMFkD5SFMASQ4G1dA+7yBY9fAn5zL9FNfuhJ
 6/eLraU1HigbIoUQiV3ASpV97ms2hAAzMsrP0jdXVSg39kRekfFJPTaMkKM5m2ChGaf2uznIG
 3QO7bZXn4RYfDbnp1QtcvoCmtixicoUjvXvkcUeoYsA0r5k5fp+M98tY/hrnKIpoBjYzuq2zS
 s+JnrN/bCWXDaPvwy5K+MnO+VS7GaSAcFdz9c6tDF9BJwuH5Q6AA6s7nyoXMmQcaKvjQjHJv7
 TIGOHZ/ERcfv56quLK1j7DR6lYf1vKBBZeBhTm+blT1ynkNz09mGKQbTcVsrB69WBvuqh9Hlu
 SsENat2jtysWdSjCrtrt0hcv+kSWeOjxr39Bu6Ry/1bvcVbAXQ3Aunc4uC78DkhtfATqDQg+z
 cBXLA6j9ImIOw/octXyjTILBNpNngPpz1tLpzNu3ZDP+OF5eNz36gg/CeFHWKhHpnkw1H6qa3
 A6iGrPZLsI/dehItetXAekOI2v0460AKqCTcSgYPBVmBA1LkxzvcELgVHKO9t6/YCLjqOU5LN
 Rfukv3918Q32ULgKQwB3ay8WHTxHhRjrVw/ODX2l3Y4ZwuHhBdhaP3x1IAnKmZJQQjfk8H/vS
 O3QUysv1vLrHStm1kbxv8lEpSm+nwZsdO4GQOUyxHqNhwgkGJuFA1qA3Hn0Wa27r8gIGWShDD
 wMdGc1ttqK6a42rdPdhh7vT9cVpHMSHuttsYpP0H2HDc/xdLOn7N2Cl420Xh1v5wPsBWLXrQs
 OdAMp2kAQE88JOLQpmrXyXz2nHUSXoGcYuCX76WSqRciUNHrCt53LksAcoufE3t89WO3TNpH8
 6//v4+bUJLDbTK5vnORlc9Pw5Zku6Q8b65peEW3yPzve+H2MSFRnCZihUDLqyugrcrgEO8B5b
 SZUSpCDAHu78iEc2ieh+2+pEuLQLPImend9NVcSZfkTQudMuTW3J0xsiyMsXjgzOq3XYOtHSV
 R1xSajxJAlHaTSIDOELzFzBpE5zkX4jGCRxFhM9wsgsPlJJiQZMx3fxJ0phNCct57oOgFTIdW
 BGGjIrBZcxNujdT3JkaYgCvxnSRW92lz/hFPnMLVsY9TyteLvQa4fDXWlzVjSsGYFLIkczL2N
 EZ/qFMTlN7mgJPquO0tEQ598K35fRWvN5NkS8gyipsxrsU8uiYgRF3gY5UGKsHF+hhaEJjHf4
 TelqxJPC2vWxDDSNCwRQiaUcNAr2HCkrTnSw/Nwvlz1Skr9SX7qgmKA4JPxTS00sbb1j0ZtKh
 9wV3MJ/CtuTjTymTWYC054MoWNx3+tMqLfdCKXUAGCTgcH5ANswKAYA9s3TlSKpvEVFp33KJk
 bgdMGmIB7NmIaqbH0fnlZt4AXW6x4jtFzka8yujnpk1DT0C+/6Z+d+vVj+IDK6dTXC77IVoSa
 sXnI/OXvI9vFyA8o5huOv8Z9OnYf0z0xOuVbVhlhm6a7aJndEH3issz5cG0Fbp6hJANB14TfY
 tt6uWw7h1OoJB0A/1wt3qmKBygY/GwkRZoIW8X/30xTk+yTPQz3jIXp/MWlCRtKlIvaNtoIxn
 5hNJA096gZNnBpd55emNL5CzJyKoVgZEdFkwrz1nS4WOAKcTYgZzypQi4r9Lz1t9I/E6MKeXn
 YXA1VkdWC5uPETMixfa6R/R4gpdVbn4zxkXp23QfmGdzPiG5ejJyUETY7SUMNR5OdeVd6sNQD
 PSK79EEzkb2oQWE424RAUq8vG4eCyhZaTPcWcG/LaqK20EcnGC9hV/wXSjctvKSSPxKdJd5JA
 8bs/OTb0/KBVN3QUAd5UnEe5p0g3DpfEzSu2gbh+9/jVKK+aUvJcLkosfxAZnPZJNm+4DErM9
 AOGSS6xcuewC42M3LLjQGMQe2y8ygmTuRc2RYl4sKvvWX2i3la7MsgcQxcqhLyOtxQvT60oIl
 U0uJN/R514AgQXeglnx1WtKkQVMWhxFLKZxwaN8/vxnUGBRJuRxqrIBmt8I7+GWvCxlUDAK5l
 kLbEEFuLBombTOXALtmA0t4ajGP0BBrXebOf3vMHCi3OTtVQVmtqrwPxSMxppV7IxGFwYnodC
 /cDc7AASSXkIvWxg6k7MPnkJ8GWy/S4+xhDwf4A2xNpmQnT81lCGCDWlV+ycWJLx6xgaAZgJn
 /mRqPJUn9ofAzcmtqc8NXWBBDW92qVjOx7jlU1Q/Iu9gSrygzMQkCTbPxP6E3YXjfSVbUasi8
 efhUOL8UXdexlW8NcxXWNaxNWKOMahtS0kfJMfcCnyQLwm8vsn4nUTPcdcrmryr0AgLnjOrIJ
 LyRcFdBr9nZ9+P8BnquUxLB9H37ogfrU72HRHp1nq9osINqdaFlf/7awfjdMU52nAr1cUfqgO
 km2BkOmViEtP5U6PS147of+OzRiC96+ixXsbRTziNkISU00XyaQBLbXUEE8s8kgXMtUtDe/OY
 Ul2FZ9r32NWgLEzugALf9ywVjL14OCcSN2O0XtTpF0flWvEiHrhRjILpP8LS0rvX8d7QPNdc0
 iYgxYW1h7yxhPBDa15pvD73nq8e0j9iFOTr5jmwwXs8IZ7jaKkxZ2mdXZXlu9tqDSQdwxcH56
 sfpnIYGh4HCh0QQWHuXSelNq3YlmLyOkvdgwUG7jE7zA6hOJvASMY1USkI9MX6E3FuA5c24en
 s7MhVVq6Rn5oN9WQrLuVVDL5OysHpVz3WKgBYcEzkXlvaa+NTZ9TpIdT6UR6K5lq8sqYHZnRf
 uX5Pm3kr39Yg+HW4YBOop3xmmKPZZKRJCecJNnd7Wzk13zlzy2WhfPudKNWa4g925n4RN5PC5
 R4372HKCk2Zxd1x8eKqKcOkl3DzB3QkUrulzAVMPLj7GRnddzSpz5zNKtTD6gZZ2PsSTqcjxO
 dtomKZE88to8xWGdBxPX2w3QL2SI82PHuCAktS9QQmAK6wxPF18F5RlSuL3KRtdlfxGvRJSX2
 o4R/IVfpSUXsud1q2yVw7c+7CxHCoZGlAr8RAfZJ6cuBVsnu6EC+TSSMFi7VMVo7kY0rM4lP/
 vdXGR3SZlTJpVIsIKA3iDbNsqMHGw0t9vWA+kpZGujmvEWoRCGqehad+Au421Y1gXQK+3DVp8
 iXE0X1kjrQbenVrblNGJp2ZnIAya7VYhJE35rhWtPD/EGjZJaJI8LKW5VBGfuNBq7QnGhYIzd
 48NiU/QKDWpRKAqq9qTmvOp+Arugfn6Ll01mdzOOBmv9H+VzoJGo0E7b9sP+BtjoLXnUn4/L7
 /0elvydbMgMiuVBWTDIjorjBb0+/M3PdsicSNEuCBKrfAzPyJXOI+1syf880dcE+of45FgVwR
 vD31rqgk3lsoY7ts/z0Acy+d4jlzFDisq+9lSsN6d0G5Ao93YBoWOnZK7Na90nB/+bcnqaBfz
 6ebOum38+jstfyABHR2k3u5U/ebbwKn7g20HlUE6TUwUNnpQl2al5Bx0DVsJhnzsn6AxMeaf9
 qMiIzDMmmvNIlJLbVJlVjTkQO6fctLlOBKJV0ehjxrsmkjDHbckmfMl7i2lvNwo5IMrSUpDVL
 k4hhLqx6LA+/RX3BVay8zxeJlnk4n6lqcxwt8PgGsHFcjCH417xtoUjw8QKOmkKWuLO63/8gh
 fpeVNhcJnfh8GMF2Kte/n+aeQI0iZf1GLmfElBwCrGRrVEMwHPcDNzhf7E05Ur1qnnbShryba
 WCp1OWjoF5J848pvoZMwskIYot+Q364Wj3TbU4R5FOkByx14wax1z6dVvE2XFnkWICpoPZjgO
 lN0VGkIbjh6VsTN8LwQ+zSgLNS1R00WPq2pP4JIhjW7wyhSZxkFPkQ8Uzt6bqdOc7p0tIHIMG
 Ozk2EpxI/4LlVjsulCYaL6C9KAp6/mbmw/i00U5vNWCV8upcxG1tFEOx9uLuQCkkMT7/8+Suk
 zFf0MCqiatVj/7htrac9GHZKPHZ9cjDPs+oYC1l0yMWfmqVRJcxgZur2nj4cw/IvMxp+havaf
 uwX1iLpkZd/Wq27JMW46FZFoWA0zYNU5WzEsyY28EjPJsSWkuEZRsXGjrcgebZ4WnoLHKqZjO
 5e7oiq7bVX4iW9IhwX5tWIJTa6b+yfMS51Ib+3HUyGV1oB0Y3Hn95g17ko8jRuKPT/cwcXmI5
 jY8XBcJb79+9JfsXMoaExUOZJ2fxLP8bW8KVhLlzxuQ9Leo2sNhY+pPcpW/Trfxgv8IkX6Igf
 9orDyjoS6AoH7FCdheSYXzpFuVHFXVX3vjs+s3UhmagdZzsIplp1A+AvfhoGl2Vf75GWCLi7v
 qeWHt2Axx0JcFQ/kh6RQXnOo/bFKUe1BFW5Si5QNEeMOLBK5Wb7K6DMEym6/ldZRBMDhKS1tI
 a8YDxbtQYR1noRNTPVAW3OR5YmVF1kEJAVs6gIF9frBtRBHfs7rbMMLEGyKk8/QfuQckVR3fV
 4+l0mw8e13URrdd16njPlHIbl7O1GkxWXynSjpPUFHfIMCVMAzEve/ejxNx/hNSXOy7XtTWWz
 yH50JtJODj01SxXocK6RfwdP6+Pqg7RktCjxJqTPDmjBPEsqEvhhp3DGW9w8KLurd5dEMacsG
 LaoKcwFZaTFbGzNC0VkFE8MqRV/ZP0pmaqIqFu48kbSisjSzjIXUta/x8Ma7Vvj85Vh3F4e/F
 PhqqPOYhVLVSujJWSzJN5I0JfUM6EPG1qocTF1NRPYSbN1jTQWGe+3N+kUg/5HtXFzZRmRhQH
 zg0LPwP5ujCHNkqUYS+NrSqizAhJESoQVMLzqZl9slnKBV4BJpm4wEBBXTvqmkrU0xNddp1FI
 gcUhCDMK3KA7kWGLvDzkMVHN3gekE8mH9FwcUI/XkeRLoXo8q8HGhjDXMxiNAzsJVhi3NauMn
 g8mZaMp+I1qV/7kmzr0eQzDCksegdR0DxLuZe9tdda45+opEyTkP3WlgtSEDN8E9C0+0H7WPJ
 vGMf3DInZMXdOVvHHvIVIQeODO46t3gdFp1KWCQzLAWXSm02GCoasOE/DE32eoDLM9BgA/A9t
 AZGdveOB7GbWfU3emoE+lLF2NR9xjmEHHnKHlc9WxnLDi17c/O8Rg7ajbBzCx19/442RI5Etu
 DS+EGoR62w/5bqCJdIGsOU65DUpFiLEBuMnNmCV4sHMYvkpzo=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 15:38, Felix Moessbauer wrote:
> EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
> measure the time spent inside the bootloader prior to loading the next
> stage. These values are then forwarded via efi variables to systemd,
> which exposes them via systemd-analyze. This helps to identify where in
> the boot chain delays are happening.

Is this process described anywhere?
Should U-Boot itself provide such measurements?

>=20
> Without having the protocol, bootloaders have to fall back to direct
> reads of the time counters, which are architecture specific. To unify
> this, we implement the EFI_TIMESTAMP_PROTOCOL inside the efi provider,
> resulting in an architecture independent interface.
>=20
> As the implementation of the protocol is tiny, we default enable it. If
> this is not desired, set EFI_TIMESTAMP_PROTOCOL=3Dn.
>=20
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>   include/efi_api.h              |  4 ++
>   include/efi_loader.h           |  4 ++
>   include/efi_timestamp.h        | 35 +++++++++++++++
>   lib/efi_loader/Kconfig         |  8 ++++
>   lib/efi_loader/Makefile        |  1 +
>   lib/efi_loader/efi_setup.c     |  7 +++
>   lib/efi_loader/efi_timestamp.c | 79 ++++++++++++++++++++++++++++++++++
>   lib/uuid.c                     |  4 ++
>   8 files changed, 142 insertions(+)
>   create mode 100644 include/efi_timestamp.h
>   create mode 100644 lib/efi_loader/efi_timestamp.c
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index d4fdd50c49e..9789237b025 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -475,6 +475,10 @@ struct efi_runtime_services {
>   	EFI_GUID(0x3152bca5, 0xeade, 0x433d, 0x86, 0x2e, \
>   		 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
>  =20
> +#define EFI_TIMESTAMP_PROTOCOL_GUID \
> +	EFI_GUID(0xafbfde41, 0x2e6e, 0x4262, 0xba, 0x65, \
> +		 0x62, 0xb9, 0x23, 0x6e, 0x54, 0x95)
> +
>   #define EFI_DT_FIXUP_PROTOCOL_GUID \
>   	EFI_GUID(0xe617d64c, 0xfe08, 0x46da, 0xf4, 0xdc, \
>   		 0xbb, 0xd5, 0x87, 0x0c, 0x73, 0x00)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 7b865fe900a..dd91c953776 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -384,6 +384,8 @@ extern const efi_guid_t efi_guid_cert_type_pkcs7;
>  =20
>   /* GUID of RNG protocol */
>   extern const efi_guid_t efi_guid_rng_protocol;
> +/* GUID of timestamp protocol */
> +extern const efi_guid_t efi_guid_timestamp_protocol;
>   /* GUID of capsule update result */
>   extern const efi_guid_t efi_guid_capsule_report;
>   /* GUID of firmware management protocol */
> @@ -674,6 +676,8 @@ efi_status_t efi_console_register(void);
>   efi_status_t efi_disks_register(void);
>   /* Called by efi_init_obj_list() to install EFI_RNG_PROTOCOL */
>   efi_status_t efi_rng_register(void);
> +/* Called by efi_init_obj_list() to install EFI_TIMESTAMP_PROTOCOL */
> +efi_status_t efi_timestamp_register(void);
>   /* Called by efi_init_obj_list() to install EFI_TCG2_PROTOCOL */
>   efi_status_t efi_tcg2_register(void);
>   /* Called by efi_init_obj_list() to install RISCV_EFI_BOOT_PROTOCOL */
> diff --git a/include/efi_timestamp.h b/include/efi_timestamp.h
> new file mode 100644
> index 00000000000..0fe0c41b62d
> --- /dev/null
> +++ b/include/efi_timestamp.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Nits:

GPL-2.0-or-later
see https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * Copyright (c) 2026, Siemens AG
> + */
> +
> +#if !defined _EFI_TIMESTAMP_H_
> +#define _EFI_TIMESTAMP_H_
> +
> +#include <efi.h>
> +#include <efi_api.h>
> +
> +/**
> + * struct efi_timestamp_properties - properties of the timestamp counte=
r
> + *
> + * @frequency:	frequency of the timestamp counter in Hz
> + * @end_value:	value at which the counter rolls over to zero
> + */
> +struct efi_timestamp_properties {
> +	u64 frequency;
> +	u64 end_value;
> +};
> +
> +/**
> + * struct efi_timestamp_protocol - EFI_TIMESTAMP_PROTOCOL
> + *
> + * @get_timestamp:	retrieve the current value of the timestamp counter
> + * @get_properties:	retrieve the properties of the timestamp counter
> + */
> +struct efi_timestamp_protocol {
> +	u64 (EFIAPI *get_timestamp)(void);
> +	efi_status_t (EFIAPI *get_properties)
> +		(struct efi_timestamp_properties *properties);
> +};
> +
> +#endif /* _EFI_TIMESTAMP_H_ */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c4b0c2137b8..25e2c4b1144 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -469,6 +469,14 @@ config EFI_RNG_PROTOCOL
>   	  Provide a EFI_RNG_PROTOCOL implementation using the hardware random
>   	  number generator of the platform.
>  =20
> +config EFI_TIMESTAMP_PROTOCOL
> +	bool "EFI_TIMESTAMP_PROTOCOL support"
> +	default y

default y if !HAS_BOARD_SIZE_LIMIT
depends TIMER

Some boards are very tight on memory. Don't add the protocol on these by=
=20
default.

> +	help
> +	  Provide an EFI_TIMESTAMP_PROTOCOL implementation giving EFI
> +	  applications access to a monotonic 64-bit timestamp counter and
> +	  its frequency.
> +
>   config EFI_TCG2_PROTOCOL
>   	bool "EFI_TCG2_PROTOCOL support"
>   	default y
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 567db518a8f..8ff5468ae9a 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_http.o
>   obj-$(CONFIG_ACPI) +=3D efi_acpi.o
>   obj-$(CONFIG_SMBIOS) +=3D efi_smbios.o
>   obj-$(CONFIG_EFI_RNG_PROTOCOL) +=3D efi_rng.o
> +obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) +=3D efi_timestamp.o
>   obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D efi_tcg2.o
>   obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_riscv.o
>   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd.o
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index f302bb62ab9..f0b3e59c3e7 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -325,6 +325,13 @@ efi_status_t efi_init_obj_list(void)
>   			goto out;
>   	}
>  =20
> +	/* Install EFI_TIMESTAMP_PROTOCOL */
> +	if (IS_ENABLED(CONFIG_EFI_TIMESTAMP_PROTOCOL)) {
> +		ret =3D efi_timestamp_register();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_RISCV_BOOT_PROTOCOL)) {
>   		ret =3D efi_riscv_register();
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_timestamp.c b/lib/efi_loader/efi_timesta=
mp.c
> new file mode 100644
> index 00000000000..78cefd7a8c1
> --- /dev/null
> +++ b/lib/efi_loader/efi_timestamp.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later

> +/*
> + * Copyright (c) 2026, Siemens AG
> + *
> + * Provides access to a monotonic 64-bit timestamp counter.
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <efi_timestamp.h>
> +#include <log.h>
> +#include <time.h>
> +#include <linux/kernel.h>
> +
> +const efi_guid_t efi_guid_timestamp_protocol =3D EFI_TIMESTAMP_PROTOCOL=
_GUID;
> +
> +/**
> + * get_timestamp() - retrieve the current value of the timestamp counte=
r
> + *
> + * This function implements the GetTimestamp() service of the
> + * EFI_TIMESTAMP_PROTOCOL.
> + *
> + * Return:	current value of the timestamp counter
> + */
> +static u64 EFIAPI get_timestamp(void)
> +{
 > +	EFI_ENTRY("");> +
> +	return EFI_EXIT(get_ticks());
> +}
> +
> +/**
> + * get_properties() - retrieve the properties of the timestamp counter
> + *
> + * This function implements the GetProperties() service of the
> + * EFI_TIMESTAMP_PROTOCOL.
> + *
> + * @properties:	buffer receiving the properties
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI
> +get_properties(struct efi_timestamp_properties *properties)
> +{
> +	EFI_ENTRY("%p", properties);
> +
> +	if (!properties)
> +		return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +	properties->frequency =3D get_tbclk();
> +	/* get_ticks() extends narrower hardware counters to 64 bits */
> +	properties->end_value =3D U64_MAX;

drivers/timer/Kconfig has:

"The timer is usually a 32 bits free-running up counter."

As the value is driver dependent we should add the end value as a=20
component to struct timer_dev_priv, set it in the probe functions and=20
provide a getter in the uclass.

Best regards

Heinrich

> +
> +	return EFI_EXIT(EFI_SUCCESS);
> +}
> +
> +static const struct efi_timestamp_protocol efi_timestamp_protocol =3D {
> +	.get_timestamp =3D get_timestamp,
> +	.get_properties =3D get_properties,
> +};
> +
> +/**
> + * efi_timestamp_register() - install the EFI_TIMESTAMP_PROTOCOL
> + *
> + * The protocol is installed on the root node.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_timestamp_register(void)
> +{
> +	efi_status_t ret;
> +
> +	ret =3D efi_add_protocol(efi_root, &efi_guid_timestamp_protocol,
> +			       (void *)&efi_timestamp_protocol);
> +	if (ret !=3D EFI_SUCCESS)
> +		log_err("Cannot install EFI_TIMESTAMP_PROTOCOL\n");
> +
> +	return ret;
> +}
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 16ca8f37751..d7022519f0e 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -189,6 +189,10 @@ static const struct {
>   		NULL, "Random Number Generator",
>   		EFI_RNG_PROTOCOL_GUID,
>   	},
> +	{
> +		NULL, "Timestamp",
> +		EFI_TIMESTAMP_PROTOCOL_GUID,
> +	},
>   	{
>   		NULL, "Simple Network",
>   		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,

