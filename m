Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEABECA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 13:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 962B860D61;
	Thu,  1 Oct 2026 13:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMHJRng7HIRV; Thu,  1 Oct 2026 13:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43C3D60C00
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790862927;
	b=VqRbHD/9wY2kl9oLyIhhfXXLWrPRs3ikak74QYb6NplzKaxf9d8bd/ClVQXrKJi7yYbp
	 QqJ09PKmdl67OlaHfC8xsN0xGEefp8m+jPeAw6erkftnQg2DMqczitmo+9EFMtRgI1JKx
	 Cz4ut8DuUJgJCVCbON7tp0WvrOfcdYfjR7V2Ud4CafRUm9a331C5fFk/Yo0zknuQ2dQNI
	 xkVBthNtycGpv7kuOt+s3eD4xnJ1+wE7wms75TqETOZiZ/OIfWgi1rAhCjnm4t1yyLcm4
	 +QwykAS2EZiuLN4QCRFRoUNiEw/p8vTma31nXYUfH2x6ULDjrGuKSqFGsFsEL+AaaLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790862927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Zvax4uOFohMjvZpLHPNsa9PdUKkT1wjdQzqkaOtbj98=;
	b=P6FSNy7gpGKHhliflmJ0iUMp/3nNYnKNCnbV9a/jKn7jFCajsltX0x8TfNsZIj23jinH
	 cbKPxtnFYS9lk0UGASMd4yLx4OkIYKvxUbO1LSzUCB8o+WXcpR8d64FBXwjrHcKU/aXJ9
	 EQx+Ae9OMaY/aQKW13xTltSxL53IvFOWgUiTemLW3ydx3oNzlXDETfvOhAD0J5v5sQ3T9
	 Aw7YTuXvHrm1mc5uUi8HHwYy0FYX2Tbn71jwyShfU9ZYeLuK8xrEF1ZBweFxHkMIpLIkK
	 p1wzFqfMDdcx9nGCZAOf6ENMQLc1cXxxJ8X9ms25WKCCpRLjjtDetjr0F1pxZbHW9eQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790862927;
	bh=Zvax4uOFohMjvZpLHPNsa9PdUKkT1wjdQzqkaOtbj98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=diLYF3Civzxg8LyaHh6dVSW0AGDqpWFyAipj//fSL71u/ZDwCUn1EsI1ge84DNPc1
	 dEm98Mg0IK44vAdRBpWwGbnmKEGYjBqFNuFFyiJSbP78UpRA+ChF5eKUS7SH+pMr00
	 tzTJ+I2gLD5NIvIeQXXvHw8kZsktDsNDyEMGjNa2wJL2P18j7ySMFuyJ/pCwXutve6
	 4JM8F4hsVOYU7mj1xe/wZgNqrmhGzACmwnQtj8BD4Y7o/6pyx+P9hR8GStdEzD9WOJ
	 leOTAdli5orHopWr1YzDzXlyTk2YufMhuzx30rVAOTUE2AnVMe6yUovHQKb2jRkvBE
	 8uOHQl5ptlhZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43C3D60C00;
	Thu,  1 Oct 2026 13:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9B913D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F30A812CD
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1Y61g-Hab4P for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 13:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2EABD81149
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790862924;
 b=dLUXeR+eSYbRziITjGPNl0QbMMTu1EWrWbWRz74WuX+LrMDzSKvnpHdwCvkVbw8tZsIg
 cV2DzQlp7QMuIGaEZuoMz1+h1R68p/1UPRV9hFZFyxMIIzVPtQBU9PkpkVrOcdK+E9UyW
 fFtjnnNqUVZTb5FYNtgDC3t5tfLc9XlnlbzVBg6koSqt+LS50GoHh2YjzCcyCdI8IPE/M
 axLrUavgaCtha6N8TqPeyCGE6QEFd6tnVCoT/eez6ftGLzDieLaTWeoCM691qE9BrlWlp
 ZD/ewmjb9HsW7DBjV/Ts6ZKPicUqdUuWfPCerdZJ5b+UrrgqSdrmGolOO61WEOM797g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790862924;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=Zvax4uOFohMjvZpLHPNsa9PdUKkT1wjdQzqkaOtbj98=;
 b=eqg/1Q8qNqu8mmdlEIamVFHwdOfYIC2swDrEYzgH1GZZ3WsVbHEZYARsOCWzQyCYXPyg
 hhUrsdKxafmLAm44ei7hmdwJexzpCZe2/67kj8X09pceRtAac0DqLWWnWxj0ODj2/m9/T
 tULFd3HCuBKIUYzRmuISrYi/JhX10fxxYcMV59uhZS+Won9XG+W0fGTm2ViKSeo3VazMA
 f64Bqq0f0Fw4SqMpC9kohnGug0nd9F2bO0sPseiTCOqpvrKEb8VSPi2jF8l2sNoviuvo7
 0tTxMAeBElMQXTgSUJhx5CjMOnQ0yFN7g1De6tsWyXcLMpN2tuYKs10VLdO1C6OxqEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=L2h90bBo; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=L2h90bBo
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EABD81149
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790862918; x=1791467718; i=xypron.glpk@gmx.de;
 bh=Zvax4uOFohMjvZpLHPNsa9PdUKkT1wjdQzqkaOtbj98=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=L2h90bBokPQDkt5VC+nmPv1vMQh4jX6YXAEql3LUQD75gfcB8cf8nGzS/U/fHOGt
 xiorkAz1jowxGxN4kl6uYL4KTGW/hPIP7WG8EmCc1VGZJEfdXtZ15INX4dDCqOwon
 0YBbanqT5NI3UPfG14L3JhKi+s586FrAfPTGAB3Tdyix7Fv4OyNvPwvvHsQg/y3l/
 aZO//JM6V3zffzvnKXJMqMPMJTmYcJ9ky4reC1I+uFnsvhQDBdzCVZsIybVw5KtLp
 y5od9Xnk+0931MqWX1i72IiWl2g8xKhkfPItFmhSMGhsJY3cjqxIpO5D4yeKTGiRS
 sQv9DnIQeIHk7zgiPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1x2L6P46k8-0098Bf; Thu, 01
 Oct 2026 15:55:18 +0200
Message-ID: <79ac74ea-390e-409e-bfcf-033357832d71@gmx.de>
Date: Thu, 1 Oct 2026 15:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_selftest: add minimal fmp test
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-2-e943530349bb@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260922-authi-v1-2-e943530349bb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LlIvva4l6mMLNBast8KINVpO8xLx+9liOCeis+jsPFaU/9orfPM
 rjRSZ67HmQvgnPP6xlAp9DACgJXSWVPjsM+bsl13wSVJg8zPSZqOLXHpmil7MkwgaJnVvxD
 F4yg7ghU0FBvMuq/8JplI068pGdS2N3GvKuuI/xm6XcDu4yP3JXqPAl9N4aIRZTFk9ThXqE
 jdBkzbww9Q58+y2xseyFg==
UI-OutboundReport: notjunk:1;M01:P0:4xcOc8CnZww=;+CWv3Zhv+vUMp87ufmgroLSWfRa
 aNw5ipHYX90QYv5lO6ZrmPm70tm1Ju+zcL4S9u3PbGUOC5nTkdthTwwSE8/Z7aKYfHyL4IYYW
 3Pe25ecnWHBb+AkJLqb68ZfDTV3yh+zbQIjWoYCTsUs3LSSI/n+7Qah/XjtIqNJtnhWgvEUh6
 eSD2cunjbfZUupBOlmSUTvfcCD8LyPIPqR/tFNG0J8hsoCJm37rfxfPGaBdsjNzKejIdeld+f
 SyP28oRuDEX47WecV6MTH9IlephiS5b/Muu9X4NawuEoOcfLZ6BquD9ZqoPTsJhxBflg0qf1B
 DXnKHPKjHmEMIqzwugtDCaty3VcHzvLc4yHDRvC/wXanmbqimt7DldBCieG6g/bQDxifGIY0N
 dmW1k6/dHhudTl9yQ1QKmEEmwdm5MIuGWhK3zSJhChNnEiHQodXCHKQtGhlloqYxJQIlYv+dl
 TH6lGxAoN+D2SisbYf6v+U6iKe7Ww8o5HaDNQaU4g6Dbwqmg6IIOW8qCJUzR4wd4n91uUXHPx
 4+qzF85IOr/1XZnDRgXs2YXYeE7ZqaA4U3yBAix+CJLEWX2Jxtmk7A7uwMkjcYK16eIjd43Sv
 uLvKOK4mjuhBrq2JQZ0clXd+edDbJdbnL1nRKTvi7h8peHBhPX6RXC6kLNM/b9jH0EuBDGEf4
 DfF4z0Yy7OJ+rRuTntyulHE70OxdkE4eo67fSq6iUVpPAzxnt5BWs7YwVtHhPydKH9+9D1JEf
 iRl2ooO7VRBwGVQo7Hz/ZsQpYPZ9vJuPYe98duiM1kybxN11lrnasQQuOAJNtLWavmruSTheQ
 jCN97YxIRM50FR6pm9ypuegUxhpGEtc1keMksJcsUdxVHrPqwG3HrrU2+EbUPe3IJrJVdRARd
 7z5hPpVZaNJePbsENkVDInU/4gEX7LNWtFV0hJgNJIVGoTWxNmjr712gEmrYS3T8QGOs/uf0r
 UDPS+7P5LTpDIF/qIlyUBPWkzkbNerNmw0WVt9DCnwiNZKp+88WCIvhaw0o7a+Nxwizjst0fl
 sOBppW2BuZQtM6PyT2Nl0rimvk7Uk7uaQo7GOL36XZ+2FwOdHP6ySrXuksUe1iGS7NE6KoXXf
 6wz58bNl/km4ka2TagT715qWyneJopUXDj32RzebgAWtMllK1MOIOI5QaXijUNXICT/JCi2VH
 bWNwfyd+9q5uTEUuJKwE+aQ2fp80fBHl96iEKZc3BhfcDF5fHQTv2jUmvKetRDZlzGWZCYO9y
 f2BPdaFPDCU8QcWVEzA/1V4gWNVt2SwCVVLeYtDxzqujylIKYJ/HuszZ78W43bNPwxfjc3wpG
 taAVVpkZGBrt+Lpvob8xwNDA+a8qQjGXLkR6r3o+fQozN0rUkeW1soDbhilueVBIWp/ZMC9Dv
 ubRsx0FqczvHWxZGMZaRv/6kiCZw9b/BHlkG4U2bBeD9BUBbB8xJIGeAAQpq4GS/AF5TeUA/B
 iyYqJ76oD3DlMZjS2UeNVUY6FKCbtoe5Z9Ay449J83x8CTdagPWq+4yqt4W1q13fXy1WEAaeR
 HOUgT/LM7qboHg+v3PW7A8jSqYG/qWpeaeut3Mv0raShmPaHZOl2n9t833SjNMfQCVCHLTGIq
 v2PqPXbNFr96TAcPCWG/ZaiRkV8tc7OyMqm3wrXpQKLTApJxzXAx/TbZKkHNlUMx7PDDxmRsB
 bRE5w7eQ2/wnuWGeamG4mikIqfbRL4MOjeK34dHlXMSHSFstbHSeJGFtmJ7biHVR2QOekD28e
 QKtS3/BVTSxrpnOa/V8zCn+kSgOLkrGpEPx9Sv85gSpidRmdNBnYdNZH8WVDlLMXs7UUfg2K2
 W/4LU/OBt/TW9+IfrgDRqYymb7X7tbl1CL4DCOLLNVhITAFxFh3ZhdRXovLeTGWZF+Yah8CE/
 m3WmaVyhcQTybE3DiBiYon6og5uT0neVp4YqJAyjDoevIzzK+95czaCqLuJgBEMIOXDePzTM8
 8JHff2M/nP3AGkip6jQ6IPVZmxhOS1SwPYKPpC8LK/S1K5T2QHy7rljjAphDZ5YW9xiMmdeEb
 I6HwOu0JbNsqqzy4ypq743nOyYa0CZreSI2LgFVFxkSey56lvEnGB0qufbz8tSYDQcG0fe5cg
 TBd25U/57ReLFUZGGeSWm/da4VcAB+YOUbBYs06C+KlLevD2qWTo7c5CSibQZmCwrWy2vJrtu
 wE3LGyRSmM2zpdKjak5HSgRLrIXNBeyhiU7BzXLfp49ACLHIJSDErhTslLsbnfQJEnapY87Uz
 2XpiSb4rKoJXdUTzkro42zBEJHtoeDvyDjsqCyiXZECotJDG/zyXHqU0YTdr17dLXTHV0SsQK
 Snjd+xOfHaJuEKzeQz7hWg8o39YpPdqYP+jxbOjykMELv0W1fSFOzJSFM0ZbOFuca10bTjlyc
 4VecIqhMInoGzFU/mf8CnraKjeW8aA9plcntMxY/TgdDh9h+sbUbrtr7ZOQ9gRKtAmReGtED3
 G/csmnBxZaGUD3irwFYp81E2eQqobCPLa/2YNxa0Vcb0yRJek4+3ZH5G41SXbPbra8Ohz51We
 v6NzV0Z3FSb9umfPIY8lWFTjkGw6sC6QCjFlA8+091P9jc0qhvv5P2ccGbEd8xEwSDuw4e6ut
 JR9LnWHI16UVi7s+YOmhw8MZ1taghs7bEmW6GG2g/yMhGrRvhLqFH7xU7S9+J2Xf7FzHMN6LF
 g7R3H61Z6nkD72SQeyIL3dz/ITfdqyJEvHVksmzHUFXZ9W1NKn++8dxfG6R169bhqSke94MLc
 XNu+UfTfpoLx5tNoGUzyPB1CzGuLfinPzfcQEOrOmZ8F8KNlLwm/W3Lt5PmcUVjxKI3n4btvU
 cTGJqYigw2NUx7UY8gWB3azjNW/LeGO2hF+aQpOO5svsBDOwg7bCn+BGbP028ASeDSlRmsEX/
 C2TANJ1XWP2UOaRCQ3MG1TyMPkogOKYqOSrKAGDeR7OS0gl/417rUONlqV5QjSr7T/bhCpyYZ
 AMfnbZqOOs8nU4YryDK8hADRLvVk6LLSZerVjVxjKUQxseYqCPMk03Qrg2qqHKZmIIdMKXnXm
 6GboWCyg4rna19uWOYuEaStquh4N3X8faJIf8PXokEclQaDzzjfyo2X/oYEUN75CQATYx0mGp
 qn/L6C6AZ9CoaE5kD0WULTgeTO5kRuPDP6cZZFY66ALYYW4xONhzIHjA0Us8zcAQKAVp982c0
 XJf/JujoeFSmkH0am1yhmWPXBz3BlJA856JSP2nQmLMy3avlWCoSveqGiwTmSVqDFSO0SAAW+
 5r4N4KWx3GGIDyMN7lc8ZEm5gE7CM7eZv8D+2E1E3tRPhwUwN5j8ckZzPyqKEwQmFM1ncIaBK
 J1AdI8YhBUvWCcCKp1TH9QKZJj37ELP0NvAYdUetObnocYbT2CWYJe4KSfYF9uEQDKHqAUIs2
 y91+XFNkkqU77BMQ2RolzLVuS6mM8YrimrDKgeUHdiazO+j998ZemB9cS4vmmvKBzxIDF22AL
 QGCEDGzepUcwxBrAvLxUWW90xOikQg8SiDumoZLe95q+/JY82CHoe4KbCSOdie503h3VHXR7N
 QyR8SjES9HGrLGiXJwKj4b/OFYu5O+6bGmg0gMYrQtwP6U1rwfo1rifAIIPy1BtzPHVZl0icQ
 CbKRpVJMRPdk18HNzk7df3IM2XkcvfoiQFkPZhuQrxnwVn2UdzDQiG4Z3QtkUItXofadEqqN3
 8jL+VhFJwwnpzK0zj3pLJa3c3abrPXGMGB0gUXapUiPCRJAIAJFikppODTpQV+Q4uxDQg+zq+
 r0Qla/JUhsWPnQDvcvJCK3ud+ONrvg24QLIS1UzRj8Wqs2HhvvRpww9LzoVpjciwWUbaUpK9B
 Pc2rA0p0dYaZV6P2WWNtmRU8G76CFO0T1ggjff5T0c/NmSvpwuGoS64mwd2UDls8/KwwWr+gx
 FuHTi6nYn2/t++TMgDx+2UxzhV7Lpp1nUAsT0SccnajAvg355MnogfrTLowDaf9aLxxj4FV22
 ipnrlPbnb9gD8Ye/lYonslhtCKKn3y2sXgVwg9Ipm4yFTBMUeJEy/nH9vTuordQ610r5wOMhX
 NZvUNNfEJTI4hEUuveqeGOXv0e9rRD2AcpsD1KGyqfP4ClzxPgjkAvS7StYXlbfuUwYcOLyb1
 xS////h+tyBfT4ZR46e4Ey0DEcJ6fXeApWSGjOHU9qDzYb6AKF/6OS5yBusKc//VRfxS2c50k
 OMBrkCCcdH4BrSGr14rfCM48sn8HarqYvAATzWEtyWqo7WkymgXOL/7fcoKj3uTjLyESAbZPd
 N45mKQi9NVClAmZdcUGb0cH5EkPVctWup263Igp/s9DuMoWpbYpZsDauN6M6wz2v8/ZUQfgwn
 FsrPosZGfF8vOiyZwJOYBT1CLMaO/IiOMPmWDPBgooktkmt12Nx3LC3JSaq3mKCqDfT84JdM+
 tVJIU9lzzFn0s9618/0gG/+gX7pOJcN+wd08DJ+kfrUGh51rtNyP7OyrxA17VMQ6ez6pNy0F1
 0YmGqcnR4iYLZVZ1MSbzbOtY1Dq+tuNxVD/FocfRHtk/f5pCi86MdpbyGpsz3AC6LXPLjUmme
 leTtpzZsiblCMn9+8h7KdSG/oiiJ5SY17FLV7B2In10sOyoObW27QCgqli0j1zjNk/MAnkK4h
 mgwMR7P6aKkCmV442UebIWfaJ0D7uKN/QB4mqraTr5tBhLQ/ZFKtn8/OiMoSVTbcwqceqYCCs
 2ephRCUa/ppcIqaD4iDyBBDKEr6R1fSfROfDMDq6kHhREguH0FJydaRevIdm0K25KNy/8Hkqr
 jKXI32y1s+ZHVC37blNtva4FpK5OtZTmBSyyrYTaaZeUhW8V+C9QfBges7t1rxsnO4rJYc1GF
 ThDfQrRFIk4VWJCU9C0zlgaeWN+B6S1SPXm5LHEBr+omWXyvlevZXm731oLeBU/q3qnXwJSyx
 Dvxb3s8oJFUUG96YY3A5HtPnxUVzhB/tbCyS5hlFU+hFNGziw9gG1aKztz9pKsoM6tk/eSH00
 4MCkoWeLTcS3rJKbsGA+VYAi4WIZQrDFzmO9OO4sWv6QVEtK/xWhXx028a7vSuSS7mcb/82FQ
 zGcgWC82ulHaPTio28cJOrzXMs6tZC/KscFEz1Oh1ZAfYHD7l3kIHwrNISn5r3CXezepOzgVj
 7MFW1ozXF+tKlsQ/F+BzEEUg9PrQlvv151AFhL6P2wZ20A3u6oHCpthWrD1i1XMR0ZIwTZs/9
 vl4t6uL1/UlYXS0u414XPL0nmlzi+WgXAE4GXMFpKopxGMlB97fp+LX5fkzaEEjwVOtTpxcDr
 w01m1PF3c4/4eeStO6Q2ThZAWBUEnVygtryTRhhe/V0EbYF5wab3fvgZeozdp0IPWTy1izYNZ
 pPsuEHHTHI51Rogs9zTeEcAwBKtSc1jIuS/3EzM3bAbcD6DU8rD2o+HV+Mqa8GxQURqJzDiO5
 859+Away2IL1JiCC7N/UAyK8CV366QMRYscrEAizgPDKn9osqvZYHYXdeR8sZS+STCWrhY1bL
 fG8AyvIeHx/HnmMonMF/VihSeiBWQ1OAbzkz81OlONsDCgm80ivP8aDPJSRY0XsS+O3W5Qf3p
 6Y+MF1TDfpvTv8wsNTQSh0pWdu7QF1XIZskDIRvjv8byKAUJs0YQluFtIbapdfbXL8MccyAuR
 HZG0Cn7gjboWlBrq2TPO87SMW6YsS5I4IDYFTq6gzoODQz9+68dASZYaHXMpKRtjmBp2jWDeZ
 vBtRVimGxrbrK00p+SwHOdH5jxSPSEQ8Nu4G4nHupfnwTppFC8FYc5g1TGyaG8HBj03gpUAhb
 9sMpW8jPeHH/ej2gfK4/uaoVDeb6ZZmcjmRXOE0DYMjfTAFHFI5jRILxXG7Ru6XCtePoe1LLc
 mwqnrNewyBOngFj2ba/BI6S+NB5d1ZA0rUv6SALIV3SmJvHo9P38txOKIHPPT0tJMuGvDX3Bm
 Y9QY6EldUCAbY7OKGuqEgxcEnYV0cnIgyM0pR3WQAMntUXUG6LLx4F5T7xR047alS+YhN/CJt
 LxMU/P5HXDxJmDldIG7s/nM93GvnqABSyiitlekel4PryUiCIqEvQjB+70w7LLGyh21IymGKJ
 r6t5bM8fBnoFaZTHOSkr5Xa82nmFv/8V+ZqEhAvpjPmrrn+Fxktn5bO71B0T/175qsnSfT3vg
 kAxlNXRgSxHwhCyuF0twmtuer1z8IoWhxXfbU7HhvjRn7GwE64MlcQHL6HT2qS0T35c0EeD4R
 HcSlh77WjeHBGfhVq/uUyHzJ6OzMTDohyDgDhd/r9VWo6WReepLUF14Sc/0E93xPs1dKeLnBh
 wPiC/PJA4KWJU3waNd72pisbLZYhMtu1flzM7B+SBw12NPRb05NYQ+aMGaJaOUXn/ze2/BnxS
 lbYL8oIKl0LzwdZjr6wJNhl6VAGr633S3ZnY7MFEJgBbZjH/W9lzajgg=
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

On 9/22/26 16:58, Vincent Stehl=C3=A9 wrote:
> Add a minimal test for the UEFI Firmware Management Protocol.
> At this point the test only does the following:
>=20
> - Get current firmware images info.
> - For each image, verify consistency of the authentication flags.
>=20
> This can be tested on the sandbox with the following command:
>=20
>    ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
>                    bootefi selftest"
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_selftest/Makefile           |   2 +
>   lib/efi_selftest/efi_selftest_fmp.c | 135 ++++++++++++++++++++++++++++=
++++++++
>   2 files changed, 137 insertions(+)
>=20
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index 67102648703..9882d9f2748 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -80,6 +80,8 @@ obj-$(CONFIG_EFI_ESRT) +=3D efi_selftest_esrt.o
>  =20
>   obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_selftest_debug_support.o
>  =20
> +obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) +=3D efi_selftest_fmp.o
> +
>   targets +=3D \
>   efi_miniapp_file_image_exception.h \
>   efi_miniapp_file_image_exit.h \
> diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_=
selftest_fmp.c
> new file mode 100644
> index 00000000000..c17cf59a237
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_fmp.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test Firmware Management Protocol support.
> + *
> + * Copyright (C) 2026 Arm Ltd.
> + */
> +#include <efi_selftest.h>
> +
> +static const efi_guid_t firmware_management_protocol_guid =3D
> +	EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID;
> +
> +static struct efi_boot_services *boottime;
> +static struct efi_firmware_management_protocol *fmp;
> +
> +/**
> + * setup() - Setup unit test.
> + * @handle:	handle of the loaded image
> + * @systable:	system table
> + *
> + * Keep Boot Services and locate firmware management protocol.
> + *
> + * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
> + */
> +static int setup(const efi_handle_t handle,
> +		 const struct efi_system_table *systable)
> +{
> +	efi_status_t ret;
> +
> +	boottime =3D systable->boottime;
> +
> +	ret =3D boottime->locate_protocol(&firmware_management_protocol_guid,
> +					NULL, (void **)&fmp);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("Firmware management protocol not available.\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	return EFI_ST_SUCCESS;
> +}
> +
> +/**
> + * execute() - Perform the test.
> + *
> + * Call GetImageInfo() to retrieve current firmware images descriptors.
> + * For each descriptor, verify image authentication consistency.
> + *
> + * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
> + */
> +static int execute(void)
> +{
> +	efi_status_t ret;
> +	efi_uintn_t img_info_size, desc_size;
> +	struct efi_firmware_image_descriptor *img_info =3D NULL;
> +	u32 desc_ver, pkg_ver;
> +	u8 desc_cnt;
> +	u16 *pkg_ver_name;
> +	int i, result =3D EFI_ST_FAILURE;
> +
> +	/* Determine buffer size */
> +	img_info_size =3D 0;
> +	ret =3D fmp->get_image_info(fmp, &img_info_size, NULL, NULL, NULL, NUL=
L,
> +				  NULL, NULL);
> +	if (ret !=3D EFI_BUFFER_TOO_SMALL) {
> +		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
> +		goto out;
> +	}

This fails if the number of images is 0.

ERROR: GetImageInfo returned 2 (EFI_INVALID_PARAMETER)

+struct efi_fw_image fw_images[] =3D {
+};
+
+struct efi_capsule_update_info update_info =3D {
+       .dfu_string =3D NULL,
+       .num_images =3D ARRAY_SIZE(fw_images),
+       .images =3D fw_images,
+};

This looks like a bug in efi_fill_image_desc_array((). Why does it=20
return EFI_INVALID_PARAMETER if the number of images is 0?

We should just return *img_info_size =3D 0 and EFI_SUCCESS instead.

The test should return EFI_ST_SUCCESS in this case.

Best regards

Heinrich

> +
> +	/* Allocate enough memory for image info */
> +	ret =3D boottime->allocate_pool(EFI_LOADER_DATA, img_info_size,
> +				      (void **)&img_info);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("AllocatePool returned %u\n", (unsigned int)ret);
> +		goto out;
> +	}
> +
> +	ret =3D fmp->get_image_info(fmp, &img_info_size, img_info, &desc_ver,
> +				  &desc_cnt, &desc_size, &pkg_ver,
> +				  &pkg_ver_name);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
> +		goto out;
> +	}
> +
> +	if (desc_ver !=3D EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
> +		efi_st_error("Bad DescriptorVersion %u\n", desc_ver);
> +		goto out;
> +	}
> +
> +	/* Verify each image info */
> +	for (i =3D 0; i < desc_cnt; i++) {
> +		const struct efi_firmware_image_descriptor *inf =3D &img_info[i];
> +		u64 attr_supp =3D inf->attributes_supported,
> +		    attr_set =3D inf->attributes_setting;
> +
> +		efi_st_printf("  image %u: %ps\n", inf->image_index, inf->image_id_na=
me);
> +
> +		/* Verify authentication */
> +		if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
> +		    (attr_supp & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> +		    !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
> +			efi_st_error("Bad AttributesSupported %u\n",
> +				     (unsigned int)attr_supp);
> +			goto out;
> +		}
> +
> +		if (CONFIG_IS_ENABLED(EFI_CAPSULE_AUTHENTICATE) &&
> +		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
> +		    !(attr_set & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
> +			efi_st_error("Bad AttributesSetting %u\n",
> +				     (unsigned int)attr_set);
> +			goto out;
> +		}
> +	}
> +
> +	result =3D EFI_ST_SUCCESS;
> +
> +out:
> +	if (img_info) {
> +		ret =3D boottime->free_pool(img_info);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("FreePool returned %u\n",
> +				     (unsigned int)ret);
> +			result =3D EFI_ST_FAILURE;
> +		}
> +	}
> +
> +	return result;
> +}
> +
> +EFI_UNIT_TEST(fmp) =3D {
> +	.name =3D "firmware management protocol",
> +	.phase =3D EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +	.setup =3D setup,
> +	.execute =3D execute,
> +};
>=20

