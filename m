Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC088606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nFmg63DJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=EXPgkpnj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39C0E60797;
	Fri, 30 Oct 2026 11:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKbD7xHMlbAc; Fri, 30 Oct 2026 11:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38DEF60679
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793358968;
	b=cJ5kdTnqkaAmvFgnjRfE9IsicYj6qfqOC7NFq9+5FD/fbnnBzXJvxJ/NDyx6B5acY9zy
	 iHQahg802r+HAEUV2SjTlAQTBw7+T5Kf+mLEvIqz48LkEMSK4zDvFiGa0B2wwe0j98y0r
	 umvxNRz1XYlF2yloNNZ/IyK13NOBEIzh6Q1lJ/f0xQ22EMCHjwU3QWIfTlw+Y4BTzoM2f
	 4HcdP8W0h9Z/ajTcYL/w/tgRNBEC+rGRyc1pgAG3r0JfI+OODhbCdBpjN86dh9MUg+R90
	 YyIyNELu748jkJUKMhyunxqGJSv9OeXG2+fa+GQFvTU4aM1GWv8AJAkGaFa5ExsbZzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793358968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HX4GzlwlSj+2ud9L6OAiJn1jBRA3z2P94Yl5/4oxQrM=;
	b=mF8G/4nvsEbnpcBw3APZySJIzWIcEU5b//w412ILZL0gR7x/Hv+JxCs94eHm32k21uhI
	 5AWW7bNOipo735ceMIgSb0yYes/VWbWIH8nZLY3SB7ZYlAvqpzSUmDm3MzYzclwSwEwmn
	 I1Uc4xPVD9h24UZTcCBLpNl5c58G1nUZzQnMwYMgdhuwkIln4qiYoFLWBqMgIFG3S+lWG
	 JlVGjfnJx9DLzrTwr6AMdLJpGDMTeqGvdz9kWTZvnMGKgMU4xK/LDSBwsI3LJ/6EwTvzH
	 ++fmT+/O3wXIk1Py3TvgkxIfZyATpTxxcS0nUvuKSdmE+M8i2hxaH3nppfPbsV3lGGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793358968;
	bh=HX4GzlwlSj+2ud9L6OAiJn1jBRA3z2P94Yl5/4oxQrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nFmg63DJuLzd/Ssrg7/6PDAinPErL9ZJRrvPbLCTBkRI3cIxuIqla6FTH4wiM4OWy
	 PhZ4fy5B0GAAs8NjrL4dBeGxIVfXeHaWIMQWZTd3lV+g1FrofWbdIrdAYyVaGven1W
	 ZPWVzDaXjTt00rCqhe9X8SyidD+H6kGDF8t9HIhSr4FsaXqdIbWFsCIab7wLA+AA9G
	 K/2/CUuljNdOleAKADTrRZCY6XXvtJzzEA+FdDUM322wM1Q19ELn8L0JvpNDoNaWPz
	 wJsnEd889KmsBgZc4OeaDsjEF/3DODftlNt7aIwq+apVhctugBd+Hk8y/uMjpkffyu
	 pU60Nw7cCQI5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38DEF60679;
	Fri, 30 Oct 2026 11:16:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8EB82AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C672F400B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id moCPZABaG0_N for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 11:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3D1C840063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793358966;
 b=eudZRiYTgm+U01HvAloIG+sEFmURrKjb8aQB0SDdK7/gP86njMSsu2/h9XGTAH7OiCPM
 D5n+HPtkcKH6hTSgBXT1FTh2SBbMXzhZtS+CqHhpC/yj/UMCW2Sbf86F/a8jREPdQ1Mat
 OvjSEs8JbxLPTiJADPiiHgQBpi31mI6kt2JNkh8I3cEPvSfOpXifI521T0wZMgxtc61Zt
 2pFk0i81WQMWlYf28VQskOOUTr6jLI2Le7pi0fcjKGpAFwgnqpFnal25VIFVujJ2Szk4Z
 JyQZwZqzvG3RoAEiF6FsvIFIPUBwbPrtkxXcRDnUn+CEwCpl30P8K+SsI1wJSNGjUUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793358966;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=HX4GzlwlSj+2ud9L6OAiJn1jBRA3z2P94Yl5/4oxQrM=;
 b=qRyJBfNNeyDeBtkZD6E3f6ww83T071Wq3HMBlGkvTdIP4dMyHbITljO6repSz/TIBOGj
 8amU60Sj8U7MxMRv95q6lgh5433ToFnoOzkoTNFqc3//Hc7z6+G+Xskk316tFBKdlvhoA
 TDlOswZfc9YweD8CwbReWyv74HiFIxOHV7RZZdVzHxDqO0WPFYUFmh2/oWTEgyHBvSC9B
 t1sfBP6jNg/iFyqW1Fil6JaZLww4HtIIVgk5PcVyarNqMGqrE5o+Jmv1Lyf5UV5Lzd/SC
 YbeEGD5N32VwQQfv20Sf9x9ftYhyPVsWCCta7R37/9KC3G9lV8FmccahDzy7OiqbUgg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=EXPgkpnj; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=EXPgkpnj
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D1C840063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793358960; x=1793963760; i=xypron.glpk@gmx.de;
 bh=HX4GzlwlSj+2ud9L6OAiJn1jBRA3z2P94Yl5/4oxQrM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EXPgkpnj9smgPAkLqezglOCHGOn0pC2YF+cU4XQisju7M1/TqyX2Xk3ae3Lu9tji
 Z+Cxs5UxYx+uBTaPeF4eKKmgORADOci6zwGzJDUJ1NVxwGjYmp7lucQ/1RtyoJboL
 4PWSR+oJYHrH5RcghTfxUHTFS39JQsIE1Cy/wz/+qPDfVCXpxoAnSwzN56n7BdYSP
 KumDlnuCiGZ1rEWW5vMiWbz0YbZ8iEmeMymET9wD1CJI4OywxTF1jtCk4g2doo9vq
 nADvNEyiTtN5uRlr6dQaF1ZihVBiVYtCZtNKYfh917XqvNMhU+/YIwc7kPCeZP83I
 XfM4Kjge0cSk8Sy8iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1xB6WU0zE6-00WXdu; Fri, 30
 Oct 2026 12:16:00 +0100
Message-ID: <7a1b30ab-d70d-4303-bec2-47d86b9e0fad@gmx.de>
Date: Fri, 30 Oct 2026 12:15:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] efi_loader: check the NT header size in
 efi_check_pe()
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rjHR7f8gyEJgVzTlJdxXPAya/nQIEdv3FxrNvbG6TOcKMjnfTwV
 SFRpqHB2FVqi+fhb2RnqnZrU1cggL8icH0fk55hmSC297LEB4FbCC+cPJTsxVohkzu5aJVh
 XPmlFUKl0pSWRpDLvvOBP0T3rfKSWNrP7WoSHu5QC8sQRmsMe3mafPYXuCYJ6uUHbhEPgns
 mO8V6R5DCD7cGE1pTFMNQ==
UI-OutboundReport: notjunk:1;M01:P0:5v2fyhksxXc=;bH+NFxJriRPazAKzl5gWOYTlFhR
 tzi5FKY7BnrTDlJuHuIPv7Z7fLERi1wREyBNMdhpBIgUwdUMum5laoBBaWFKYCm1+wqo6JzE/
 HG3LFpcCNvWc4tEL2AMEx0GsawiQwxJB34OgYUX0rmg9B8kOEcpshD5ePrsNt2aswpylKf/eN
 MncH7wa9UiK0d9OKVNgADBAq2u1QN+6Tqh+U8xqOVEkEwFc90soRpTDLMuC/a7EJa48sVQrEm
 v530VxwvY1QipjVaMmFHdWHncp7w/zs6pBhpmzerOLg0X5LFKHgae5BzuModAAgX5RUPqMJnQ
 OFAOr/xWQ6GlIcFNPumOZ1HYjoJQcJRGvi+LG0BYnuzoeyNRRpowIPuWBe0LvX+7QNjF+UfsX
 X60st6c8FERoNrFHrN88DSsVn2iQcKFCnwoezwBAsEMbc2UFHZlaL/FBRHwgvA0m0qyw+glPz
 MkTGdTHIBv3JoRdfsn/TYC2Wnox04FFjPzQFiuiAPluYyqFTSXlHCEuxjkPLzvydzsWtsTSYg
 oOs0QjtzxvNOwKZmSJgKWm8mqGtc7dOC0xwQXM3szJCHgminD9RwK2YzcTjePXTIW8d5UWiX6
 xMmmuDC75EWerJyrrWN57vyfbkvTxuN8roGE0o+WU4ACxLOxAqg4y+4lfmyQUgHMTntnTi8Yg
 AqYyjL8vG9VLkpyLBBNnyrE57ys3QxNkn8UAmTCyPrVj5vxWdlZd//eN6vhQCZ+sPdo/2OSZZ
 nIP2UG1xaHW7feDli5dvPQF2LUhKFM1cG8SIvH8o8yMu8PsfjmA9rds71QKAcd8SRnXg4uifu
 Gza2sADgc/JRk5/edCT5c67w9s9KLSlMkXoGrCtKEdndCccnb8KqrPQ5mJXZjQoNIxp0fOWwo
 YzY6tGoect+RYDMFUnuQxt5Nnm4lwQbAE6L/qgcGwWM5GeetME5hc6Ikq5pfwUafMFpxjni/m
 kcvdO+zV/uDYepGOZZPsRnfyNEOlBs2K/tnjnIc3Qyqoup64WybzqiMSuMd5DCfaLbc0Vh50n
 IGczCGGTSHEP6RnlIG4+8f3btOQrdMX9T2VQ4i3IpkA2hYlbVEXfL2rzeEm80gl6r1slbqyxl
 QJ9XoWdziMKUzaF9E2j0sE67OICkivpCiXvyXGLzlCDQdYIxWlnGHJUpYOMn+wk3p58IkND/R
 65c8DMopFFxmbgTsy1XDztgMmSROVNPn22GHe+gZIn6EKtYJZNsB/BNexkH9JQR420Jqe6tjP
 zE9mAtVT7X+7gQpWKESaMhs8nl0m7Alsn+uiZ6sMmFjmpjpswU0ljQVCvddTm6enYzNCQ8tyw
 RQVixl8UBhlib8SfvgIincKnsewo2XH475pIQVbPGEgjL31AmIm+UiwOJUaNSmk5NfTiW28g+
 ooBANKDhU3lzj+goyQBdHJt7MkKSigDPvM8EbZHtC9bPwiCXjBvSWvASo4Hc+Cjb4qHH5HWpc
 +nutEUCbbuS0LgpUDp7gse+iDfLHrWsFMhd+Qix+gmt7KKKRNBge4ZICxo70pnnkClx6r/lEI
 ZyIirMzKUDkWqShLeAWMpLEonDVCSfUhv40m0VvW20kltDg3sY+k+bCCPys8pwmpPiIVZiLNW
 BkHLypRC/fNG5HD3gNz1cEfmjHmJb6qtHeLFq8eWtdWp8WAyUzoOqBuPiNQiRZWpHHIkzhrMG
 RBKUyZl4p4hVaJAst9eEP+Dkpr0828+eRobB29wCfW2AREF2cyLmaNXbtGKKeqHy2MGGgY524
 O7qCTObDSK6rbRBEAeTUZ/0HHG97YH7B9Lmi0CzJMYuxLOYhTsZgzUcLWbYgJdJqfmkd0BzjO
 xXPYpIw/UwK6/FM1OvdRIA2I/AKOfDoaPRJfp4FIKFoD8T4Fn10fWx9VsHBW4a2O0useJFIMy
 ghT/wmoknxnhlNxMPovStjlvG4ZjXfZrdgsI5OKfHaoN4nO97NIM/KW/Rk0W9TMe+PVyg3v12
 ELNsmKGB0VA0oDUebPppjqFSXu+OqentpzWqBOYdDvf53ML4vXSMSbat+8blVGO4lBkKqJZlS
 TX1jQNBSQr4rnRhqSajeW19VQ6Nsy28TFSv7Y9UiU+K1GluM6bYGGzYA/l+9FKOtzoWUpzczg
 yEYZDOp3DAD6ZU+vwN58TE/2gDDevDoysqS5vqGoNGtAuezVH3HM7m1uQWmW/ifzdr55doB72
 z4PMzxRmo9mStc4xpBoajnriquA4YXy4JE1cK00GicSfWciozRclUU8DhU/UEeYu/acd8PTZ3
 D5sqE1mcR410qEIj+3/V0ChC585EegyllVV/4iayRO2aa5qVBHkamX2xhcGTX7Xx/pyEZGVnF
 pSZi4tNZoUFktf2UrApsNHK28kJ/P+Q8zsE+ToQlPBFGMwKL8q6ecGgDbR/3WApBHwIaGi3aE
 THAHxtF9ofjBMNs6QG05qWkcN0WFMBvm8ho4ek7/UR/ULCfEnT9qvE6CIYLs8Aujv6lOfLl6H
 EIvQHF0VceixYZ550JGxHZaQsjc1aeSvSCXckeIu8MCjUuFRzmePu/yAMEpNmpHYjLR99lMfH
 R0xRI/EuYQ5He/WwsIhKdKqDkwfHVHbAXYg6AMZoyL6iVWmY/5DBTqdEZIBMoOela32rjOrgA
 D99z2uBYlZ5XdN3fG0p7oBE4LcJiGhyRphZPw31jrS6tztApkAn3MbJ3ThEDtzDPZkeEH1nt4
 Bff5D0U4tTA2tfhmEEwbtGpSy1TmdAo0O397TB/0Ti/CZsJ7fDzsWAF3zXxC0NN4HtWI8JJ1Q
 iCHRWKD87Wj+/75ms+BtXwNMu0ZcrUTpmHzrsCYc0vJjKUjkeXPlasXNIYCYVTmkywnyMofDq
 pq4Xxy8RU6Q0QSLaAIyVPxfa8XrkDM3uT+7VBEqnHiMLuJe94ZwzvEVWVNIM73dpZKBqmhJp5
 u8ZjTRtH4bSzrRm/3J1ijh63UyBNm0O3jHYggLKFxnhxwUk6qeGXKByINRK9UwU/Gdx1jQVwV
 bvswHJssqbHthD29FrvDjYuoUK4ercqHfnVazb/Thl+tPBfMC/bqAgYTdQKvIDu06gVkHEtqi
 UOzh6+jENC9+gDepcUUfSrOV1LLe4e4qafetGb/3qgttKKC89s4X87PjJya1kLOsFql0SgoU7
 xJ85hJ/cYQExW8n+5vlclMW0TtK3KriA03+/N+hFnDgeCCW9N53/qSK2Gi2i8N28EVUgGP1+w
 vfJxGM876zd/8FhomUZnR4h43YuCp29zyDoaZC+ru2JkPdIPWylFJY01hjHpH72T3ZeXIJc0o
 hnKZ+zcjUp9GWUBgMyp1FJtl4m7amyLV+5tcvahnOTfwlaOPTbXuP4+5X/f+FDEwtC6kmfdmN
 ia3IEBB3usg8IqMB7y5aIMIp/KEhE8MBvL7PU2zirAMA7kRA30gaXMOfT3vEPEdmJZwduGZLt
 n2A87f1Y8a+jGfYj0SWM0Z0uhuClEK2sjCAPbpuRPY/fW1WVPNhyjZc4kkhoKDT0kK9GG/Kcl
 I9ofCVAc+Z2aQIwsCPYh1ysj1Jmyp6F+nl+774O42PNfDADgCAfMwdmXwwYn4KcMREMl9ODk7
 JHU813ny/eu0rn+HoiXKZHNB1BzcUVwadVKQPXAK+EJWoHphA6cabmhqdvJn1sAhw+D7cSAr1
 3BAUvkt0TTdLRSelEtpkhYwmDnxqyO7OXJVNGeVYF4O0uW++5o1dfoVbpOnpbeS9cWnoLZi/P
 xYWPnvkWmcP+lYFdKoWVzwa8XcSJdR4RALs/LmNKknqN3LraQ6DtxyzVZ4zjqw+R0fbjjZZy1
 t391rubZB61iSviU0d5FoYyIx5XYjbclB5L8t4X9uPW4aonaW34kPIrwnWrgxKHq+E2iBFndm
 MyVBhkcOHozH2UKDvelprVh1My/nTUP6gffNwVkfLXGwRcRD28AHUGpIJaUakqnvojtUneR9K
 4Z4OiuE3f2lZRn6jMbxxHbn3xY9TkGwFhtg3jusYtTLdYO5jmcKIwvX1gjFfMBGRLpcrdo++5
 bVyDVIFh/fFnSPeyfnpb/S5CfqNCNEbBMBJoLpofWa8tEKF5/918tMAf/MLClX7I7/+mCLw5f
 SGoL6aaoCa7YMR7+2c8njS1OXPEpOsMvpsFIyVK4OoMgdRqmTqB0+1vE/y4U/EbIu8C/pPdwt
 nddP2TQ4Z1onAqpIkYHRxytV4Ke7Xj1eovT39FQ45qAfKBKKMvGEHDEkrTWlQXuojX1mI5d80
 y91CxY52b4qOMtgH1aXLZJVBSMKWlNXJ40IEkEkqPkWVJEVTgMbp9UYq9wFR2VjOU2gEYJF9Q
 fDFqHmBUPU9uIlfFYv4/D0uYAdYI59/aSC1hK+3Rq4+fxMEEf3QjNres13V79F+SAJ/AWtjB4
 MSiQcEulnafusESpWHksk8jPqRGvwDomNIqCkOZG/AZdydpAXqor4GGpggzBple3DwXXY9uQA
 KQS/VVvo5Fvnf9r3Vu6MWRK4KiXogVe1QSh6iek9kGiTzs6BB9c+gA22lOC7804mz0C46U1b7
 ZOEMXzXK+CIPvVVDI6pL669XLDRxA5a0vqyUiXgWTzcT42VioGAlOfksL5aRGQ/4HArQKo1UR
 nUEuXkpNe9m+eLJ/lO1UFqobUWbNk/cKdPtAwsnEmZI/cszZXDkWtkotAs1HvTXuQVZmEaZYp
 EDdshjVZrmUx0Iwpxs2eavBSOXGYDephIvYXP9zF7cyrlhKiSqHt4ZWidHy74IvLZLeIJxHGa
 utPN+dyNDGusynwu8EcsQaDmKqfqTXJD7hH1pI+rYzmbqQRGuhPwse696LuTCcE8BiHmpAe3P
 HigvqD/nNG//zl4Kk6pWiaPaF+AbPP6ipR5mXZPQIKNRN8yGODStqiBj6TWYo9TYOWCGiZvhj
 YOKLK7qpdqlhOe/L9vHVIG1cnNBhakBHZE2DswgLzQyqgtVCr0ZmyUP1Wj85xFkSTQVZaWq/V
 rP0T7t8yeo6JBD9qaHSdZJxO6f3rTZ4uY3+fl3QcTm9ttAFxKEcFFn40XLOOUR3w1gYPVR9Cq
 8/Kh9SjjW9aMmwpomFXxkex0hRe4CzmPm/o0kp9x5Z5GBwzx/URd6vH+I27Lo77aTO+xq2quk
 PAVW8BK4f0UwsWnfAV3wq5BBYQ7wwCRzR7i0jqILDZhXpV+Zqfg7unfD2wWYQ1SgnAWr3Qg5T
 kQD7bHdssGIRXURR8NC6npTI3yrYRiy99xuHGkwCJ6yVZYUaX97bf6qowyC3Q+kn0cS4tbeyA
 jbb1rrTg1EsdU8Mc+vrSU9B3eqjWxNHyGJyGQthYsZZGXlVKuLICW+lVZb9pVdkYT/JpRgdkF
 qRyOuum/+mQOYzOZo46eeUORy4iuyV/KcPYQ5+yLD9jw0yqnDOxjdR7e4jTWd9WM1UsyAv9e2
 2/n6YY6P6KFVkD1SOpRTqkTTs8PSTfpBdSvDZy+tB0ouX7Ff4mEtNZ+ECqoZdq3cA2+v9XK8E
 LNiAZRavUT8pxLwXiNMJcZ8PciCsXaAWRQ6otmyRqheu07rerAPnkPMZu0f1s9l8B1kAQcoRl
 xER/NxhnAO5E3Au541MkfmiiVfGZaFL3EfmqXLZWMvEgOvvQVqkND/RjWrmrYBbeszYU24FQz
 C4KvG/liFEYt8dBrOLgUmmtj2HSgGTkZi1cNO9YoJqDZf07I4wWhfjCPiRWamAdRSWpsh/RxX
 ENvYFJRYfJVvi5HuWdUV3Ks7JlmVwtH1krWSNTjlmG1g2ers+t8a121Lt66uC8PVVc5reCaI3
 bZ0vWmAyC5qTY+5m73X3OrYujt10qMuaeIS9zQM/bA/HNv1GIrZ+8cZgFQMPVVnUyzRHAjTE+
 pnJ3/6MyJLihhVHGCnyg0X/A6uSVPr/f6UW0A+NDywDql+J0Xi6JQYR3HGkHXjQAZHHvHHkUd
 oMuSPfZQW+pvStEwzXjnkWi9EQhOrOtL07fn5Ij7smeqYcqZvbpBkXD8hTMzJf9TLfBglT9yO
 EMX24dH9uA9ZBpad2SrHP3K+3zbmPZyr3xIjkihM348y/IDllQvUbGya3TPjVFQ8DiKfaOFP1
 Iky0FeZdFiPW7nfmF1ZrQ2J7yPy3buiexT3Vl9zXd33le06k3hlemYe5pyhlZ/8ffTjAqcaJ7
 gR72dxefara4QwMn3Cs+0YUG24Isx7DLNqrtg196yuvFnS34h2A6VQ7YuSYDQikpH1O3BzUld
 1k1w94Ya6bVfRn2g5NNoZk73u97x3L1jZ5sWdJN/NHqLW0LSmrpI6Y3DrvPrf5yQn5HAiBzwc
 7fAYILUd2SbwzE0vUiyrDHnqY/n9IVmblgRJtdQ4Cm5mNWTrZDT7FxmV6eJVT++IisIxk9Nfw
 k842M5i65qISJV55fnQp7wPfWidSottmXfCxLFqE8HoukMYZIdCReeDtydrtbpjOae7p9J36a
 3OvldDV62CAF/8NnlTBJ/FM/RYhdxdbzjN/X3mrmV9RxG5qIHb1TJUYV4aI6iYuagxPGrNHmF
 dfAiXY5c26Y8zb7BrkCr5/yIXMCEQM6x+JfX38DE+zPJOg4rWmuUyEL2+kW+wb1Js8jZ0WqxB
 3RCccJvDOQDcTBIfp0xb/qDligD0osFXj13Z742Adu8LCyb5oq9U8bQW8QEYD9ezCrNe+bMsz
 UfjLWfsmkpS4y8kPJu6Ug5iHFVve9gkwf+am5S1oY1U8hBPcWPl+Ktk0NWYZk1t627l/2cwV8
 828SmZDgPtVRYRBqRMITJuawruwYfLlcpbuIFwev9ysjoG4wxpDk3DgWMUSY3LYKc95dYK0LR
 9DlwWh1GtYLrTiBgMoe4LQD+er4m9PKVNgoMGzrEthwwl6mdJiqdUcd1kUD/TkvisPL18rsw8
 0R4nawNQt4rU3FbdpkPHgWx/sdBg9Sq7NTgSVttMPeEFsN0EJwiSvsYAPiN+NSxTQPhj+uWfa
 4lDSRl7/EWS5cu7okO2K5vDks/YZ7/k2fRHcjhHNGlW5bQ3C3XgsFErh2E6HtUsTx65GeUiJs
 qcfJWSzh4FdsuSqu8pROs+hT7P1xHUgqTt4OkSidTqGAzqgIStVyCCOTNzGehXKih5ajaji4H
 HFnv1ApSdkBiYyS7AucltJ1qsoO1Lus/SjXrh2pLL4UxAs4qHuneLSrvuF0BQJPdhp9OImln+
 IpfWe/k/grbYVw5/ijsgED4eXjUE2gGKXAzB3tbIC7QmxQHHcF8ZFL9UDmYD/Sd7DjWeMcCAC
 ZZg+NC1QsOFWNzTz7qGoPeGQ3z1rW9YDX2TIAUxvl25IdsG9gIUtAxH9qRQdzspHIVv3uLWFY
 Vf2TaYS8xtYPUjJ0DQsU2NsWfhimwWVcEAqyoeK8oMh3KmRlmfcyem4dhJh84G1vIWoCh7Nih
 6hLLhYpDF23mcAYcih7BO8B7fdoOqLYb6C0VuZCAiRYi6CGDA79s7yS9odW7HLs8SISDtVAtN
 y888DBMCyZ79TFs
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_check_pe() is meant to check that the image holds a 64bit NT header,
> which is longer than a 32bit one, as its comment says. Since commit
> 5dad05a0e61d ("efi_loader: carve out efi_check_pe()") it checks for a
> 32bit one only, so the callers read the optional header fields and data
> directories of a PE32+ image past the end of a truncated image. The
> addition of e_lfanew can also wrap around on 32bit systems.
>=20
> Check for the size of the 64bit NT header again, without wrapping.
>=20
> Fixes: 5dad05a0e61d ("efi_loader: carve out efi_check_pe()")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index f9a2d2df405..e31493d5135 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -849,7 +849,8 @@ efi_status_t efi_check_pe(void *buffer, size_t size,=
 void **nt_header)
>   	 * least one section header follows we only need to check for the len=
gth
>   	 * of the 64bit header which is longer than the 32bit header.
>   	 */
> -	if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
> +	if (dos->e_lfanew > size ||
> +	    size - dos->e_lfanew < sizeof(IMAGE_NT_HEADERS64))
>   		return EFI_INVALID_PARAMETER;
>   	nt =3D (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
>  =20

Thank you for the fix which looks correct.

We continue to use

IMAGE_NT_HEADERS32 *nt;

though we check against IMAGE_NT_HEADERS64.

Shouldn't we be more consistent and use the same type everywhere in the=20
function?

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
