Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B72ACC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D93560AB3;
	Fri, 16 Oct 2026 07:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JU6Z000ti2Wo; Fri, 16 Oct 2026 07:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C6F6607D8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792136127;
	b=GOkCkbnl6oGvaSmyTnTtJpnJ7vPZyZ3NepTrBVTY4wF4Kcp089iluk4YQWdxbEWNRsW9
	 rgHeYlGrwhrraXUYuqO9+kHMsRGlzWfpnW4cCShnn5mQ5EiM17RnFxBWgzjClkdK54nE3
	 TAaxGxGaltR3wnhSwxwso4iWCRnyutCfEJDflO+x+AKSxM/UidNBo2DlfGbDypl+gsABF
	 S9Uqj2L6jKMyO1BiU51UoKJxVRGOw+QoBXf7brUymOnh9xvh36KfoHkHaJ/wOlq0sQZMd
	 aoIsbHMak74HyLdX3VCspGVmRyFLKSxK7xZpsT3LhDUcgSCcbep/F3QZgFoVhgPFPAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792136127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fiX8lC7yXLbJakkuRrnwDqWETQ38tH5gwP/8qztHqqQ=;
	b=OGzAuZus8S+M/bQTC1RwCInO+EMr0Nn5k8fZEsh4nD4vgkyJ6nmoJsIyTE01RMX+6Wvw
	 PC+X4pPrP/XUSkAf8FrHJADEBy/4SCN/p6umQrxfjiD93DU0mkm3CIzauXp/ffbaBUapa
	 eFaYtIC1UljlQLURcY2xVVzW5iDmpr4AWZLEmC8jzZP2+VwuE2nTrtLnjYdrppvO7Cp2a
	 0lZ0gFh2dWQ/jApDT6Nk68WE0cEJEPquLT8X82OXDi9ABa/6qMMWxMe9uC5/1se0aF7Yl
	 BybS6tefBOzN3hUIggrmCkDnI/TVYp6ZcOZl+6V2dijIHVhHBBM9OqlzxuYtN8mHwqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792136127;
	bh=fiX8lC7yXLbJakkuRrnwDqWETQ38tH5gwP/8qztHqqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMK+RN9UZOJgHCD7GfbWoP6K4nxUR/1lbtH8xdqUYoyE5VRjP+7sNaDrEkZ3aT/H7
	 fW3cepGGGPO9mDTHl0WdVf1UUqu10OUpVMPSoq1EuAExWihZbC6VWlbsTniDOka/Et
	 vYQOiwgDYp2DMWcJqPJ7nsFDKOonTSJFUTkMj6ybIin5CH6HE94g0i9j5JfSc5ygi8
	 zkBMUZ82j1OAUtYxSMZNQRJJlH3RAOWGqJ6mDJUmzCjxM9nfPawDWALdd6FvaOQeyU
	 hISZuJn4E+WjCehRCtfQsaQ3wY6OFhERbAwm83ZgUvJhmzLjpm7vUif+bmJlvH6Q5d
	 mK0LB3yRfDA2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C6F6607D8;
	Fri, 16 Oct 2026 07:35:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 810D01DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 669CB812D6
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcaAKGH6qMe1 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 07:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A85B4812D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792136125;
 b=r8S5U33l5CAELczTFFmOAQdgetmYuI+E24FmxOMaNaRyXR9+7eWq3HXXGObPUYvKHjz9
 Q+30FBBbHmj8BaC5v7j/G05j51cNwMCDQcft98vN1XtUBfBPOcsv96o5kJ14ATpOvXbOU
 WQv2LDlXj/5DN7EHsrYTB2J61JjktCI0WzH0DSKbh7UXeM+kxkM7+dmN0J1kIgB4a26eK
 lfMstvY0M5xQnOCnOtsBzGTr/zHESGlJc8OsEv3uuDzc37K0ygwqeGsozU32xYDgJoCeb
 8qX0IJbMht12t4yDzPQrPJKIY5wz6CsuiZzyt2nMp4xexKqoWD+yKx7hh772xLpTUZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792136125;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=fiX8lC7yXLbJakkuRrnwDqWETQ38tH5gwP/8qztHqqQ=;
 b=bdt5ookv7qESCpnCxtU2ypgh56aJXcKB09fAykijJNfbcXFgGmZSYkfcQIhloJJ4kHzq
 Rax15AXWfDx68Ycl3FHBBkqimNH2IN6TcI7T0BO5/ERve/oPnductZkP0zz+bsVWoFI4y
 L+KxCbI3i+Yq4vFmze/oaGJgzl8yV7JIH3rU8/7tdgmjlIV7uHUcXsdNmPzGFKqt8lNRs
 T2KezOIWQMTA/pu6reyxw+csz1wQGwNKInrs50aiSCYS9aaJPcBYKxe+FmnBdfmGfcc/e
 Pw4iDS3r+8PnpXUxQ2tOIYaVJscsUs+ctL7stLyNfJ+0Sgi9tlnYalf2ROdC9M9abvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=SHwHlXgg; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=SHwHlXgg
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A85B4812D4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792136122; x=1792740922; i=xypron.glpk@gmx.de;
 bh=fiX8lC7yXLbJakkuRrnwDqWETQ38tH5gwP/8qztHqqQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SHwHlXggjmnqHopSK8T6alm2AifwixGpRBrbjTswbBLLDElbMpVwiVb7bsZCdIIY
 OeiLfE52UcG7JhytmcSjsgEXrTwytkxnGNkMchwRq2voDlpUlUG6D3i4fZ7Z0GMii
 syLOy3SF6jqfZDJDPl9bxGKn0IRipKLDBXVN1JoRZ9oFDDSSkX8Fn6tQ7oiX8ue5V
 q1uzPJh9Np08LN2Z53scdOoTLqVreRWm/eq6E/5ZFjYAjOjneGspyEFuKIifojXs+
 pWRw9dWExxMKB6HurGkphTPCvTz7ByFXyI1eXyXOGRxADybKVOBi3rhWRz69Xh1ua
 39TDwVLkmyo0KyXDog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1xKvrB49jY-00B0i4; Fri, 16
 Oct 2026 09:35:22 +0200
Message-ID: <1fceeb22-012d-4c41-af64-dbb10be2733b@gmx.de>
Date: Fri, 16 Oct 2026 09:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/20] doc: arch: Add documentation for LoongArch
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-19-me@ziyao.cc>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261016065500.137544-19-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNQk5cl4KeUmnlaa7zyFsPFl4Gql4ZZjq8XcBcQaEkMGHgfSdUL
 HAGkT/fB5oN8CardRyR08fVxkmOTvgoX9tNwpOVHlkJzIKJVOefEe+DzA20iwGIU3/69HL1
 5NjytpoqY6T1D+zJcLfGUm0fc/P0ZTYBBBDIVoTa+H9e/C3kiJR7vWFTvnodSeqS2N683xH
 BuI8KUFLFJ1cJcCeqpplg==
UI-OutboundReport: notjunk:1;M01:P0:KGrVFtoB5+I=;ywDZB1J2iofuMtxgc4CxmuZwESU
 V+bp0UPyGwBpYH71sElG7g+4VIYRBhLg5WXnEni/OrIvNTXzbnEomH/FeVyT2Uc518OinzZDx
 ZSGEWhgamWJrGYR+y5tqtExufcupwvEGyaYOa9GwHjywxOHd4RoIyqmdvmkive7C4qdSnG9OP
 DzoKGp/elknixxmLC38fMcOfN0AfFoEpbessWQ+Xs7V5SV8DCU8ZmHE6r3uESoGHpec2COaCH
 hogVzuVVUMsTefXo9NOVGDYNUqfSytgw0R7Rd87W2ZkzgLSgfE5WWyD70pQmC9QT25gnBVg4B
 1Zz6reV0YluxpuHuUKNBGYUKKXTThghmfdVopBaX4E/yGDYtaMr9P11wotyJBBEB0wqsx0KJ3
 qS3wEGli/HwttDpEzh9E6e4fp75ySGNXVD0Z8UM5kM2Q/KQTlCkm4honHdpgniosGH0Sf57XT
 OOEnZrHkAzX6fWpBp1pnOwoMzoutlvUc5//ahgN/GwkK/cuQmN78OUh74Rudbpq/efMeHput+
 U6CcZMBiw2KofZPewj7AuiW8IZ8Q2LOfg92TVYr/Wq8jwpZ5zTpe5zabSWXiKGZuU60IvkUbv
 DVNbuR2UOIkjmIY84slMXjtcQ4pyOLDm4ADL24zwQCcNcrGhR5XWZ4yCw9UqGQ45du/Zc54Ei
 jU8Cg/zi0RfxRVXLGL2S0J0XE983H3FqAEhAlDwfpKCSHrc+78Cmcywu/0tUPpyUWOTtgCv6N
 bUSWrwyELPMCjC8TW8s2o20VkCt2a1giAL2i/sYwdju0M4KHftbLKKh1/p85iSeTViniCjG9o
 fNolnwUQlUSsd0fZ76zS+JNkTx2qRjIyYuntisnfp4SE+H0MECJmhs4xfq9hfW3B+lylMEvNM
 s2KkPBGB718fD4Lgo3A22Uzl9XSXWwhhRMMXlDqvGJHJSLVp9mCotBZxoezzEdsjI2uVzUHAG
 F5tvzg5tnyRXR26c3Un7iXGCULdobPveldeD8PX3X4vCmSM/Ti+CymH8szR875J13ribBdPbx
 rxvZwmnfVEM+lHJXyuW2FERKSydaeVhZ3l00F+j2T5fW8y0U8iCo/TjgIPLDrsLwxSxkL/kZG
 0tmwAzdBoXiScWh3RLs5Jd44Jq/DzLx7bZnvfMWFnt5p6jqp5Orm5I2+CTzFZ7oKpXpXayQcs
 2JZlyFuYnE/6s+9UjqWCsgjnRdhNroifEEwIZNjVVaIHkKfSJD2WQjz1HMbLVz7S2CB3XlXei
 CujHLQ4kfqHBWON9t3y913XtzsEekLvJrEAhF5YtVrM8dTH6oMcbSI6qdiEbp25LHHlSmDIlq
 eFTHgU+p3PACzWpML/Dwlm0kYGAun7ZWBOXk7bjgGfBzdXkZICSj+OIGhFeUo8+V4FOuBsguH
 Mh6hRBIBU4dOdShwwqZ1osGSN9CrP14Occmy3P8FVp6tZTELSBTN7oJibHQDCS7FkLUj79uB1
 vqOPegdVWmkzbNkNLaGFkyAZsJ5+IS4Q3oRC5rcanAMSLOYQ5f+abGgwnWESyi0a25Efxe+UA
 giXeeFfq4vDOkcMFsNiWolqLhNhmZppyWNFwY1iO5ZOQL/XRbuKDYVm/8DjUdycml1D7/B5MZ
 enNof0SWVoJfyheH4801TyrXg8MWzj5uVUQGv+0T2P/ctk9XWi6IcUJNdGqfE/0HrI6+KRr/u
 hda33OusWU1Y3OpPlvnwjozilp0ddhydXLBJyjkC3aneZPAd04X35kF/SCUZKuuNCJw82hpyu
 9kNcIhLfdEbRPL87QalXytexWYyvvywOBbjjKFfhPOohOd09JpW/zph+EoxJ2zIbTYuSAoyTu
 BxgHR2YdoPTawruS0n3e8jG3AsCshe1S9GTRKQ/ig/qO95dEBc3xDI+uSPZZL+EURX2gP59cG
 YPo3VITx0fHFV7KSdTIJhuPkeV9SNnMFT7vgPeBDT6D66Vepiy/j0ZtNMX8/xvAfuQSDa123C
 jxFF9Gm89828wj2vggRD7iV3eztis6wpABEyuKdXuXrRub35sa8Mdgvt3iFr7gHIjScLwU64v
 RM5Lhe0hKrzAHhsCs1B/ANhUI1pM/UbozU0QME7+n6ReYPVtjILrcdMoPE7OIecrclsTema44
 CqH++dr6hriMX3StrFc0FhnNqMpoyBFO7t8hVIFj5WPn/15GMeoiFu2pChhK85kIdafO4k78X
 +4x54DgOJGUrH8XoDVupzIpZUCCe2L+7cLwF1aEUWU+rqIa6A5NFPMyZBBpuj3aQxhpBtAo3x
 +ufkZhyZaFHA69MOISHoD6pfLTFhTntK10PzqVRjzwLaY9vslJta2si8co5sT36xTVslsyrnF
 oK+AfWk1dSejMBdUDei8Gw9TZ4+Z1yy46dZ7INQq7qteWfYDVizUN04nilmLQmoAZrJW8wLNh
 P4yFrEun8lZwj2WulTo2T8jASO5azd/ve5yUbL9rBTSNZbqZ3g5h4JTKfzROiwZG/qN1CFOoC
 S0vyqaeI4Df6WSvb1gxR4BilDodOABuGy+U0NLT4QIj8hR3xNjoxHya62pC5GjbdzmQ32uZrW
 nfvtSKJZrbcJ10uRBglAoyjE9BEzsmceLDb/7ZBWavhHHbT+j29pd0rTYznB8c9tzHsjTD2w7
 zwUfyDxmn7PRAxjusH0UTsjNe4QNawbFAekcdn3014Uq6tfWzoDXpNbftCLukzT5r28+XjhnR
 7zCox7ypnWhvD9+PlIH9hnP9ucqSnOV/9hsOH/zoJupo6s70QNViqJvFVajNum8faZFCfmGR0
 g8/UHiJuXsMqaXvEeTTqOGcQAHmf/HkabeyyejfCZC04Hwn7UHruxgNdLBsJ4Z6hJGmW3rs9A
 DAHmTPlvSpHBs7Fpc7SPgiAnrCGiTjLpnbdHqpvUBULleofRPiev5+aY07nQRgW0XxbdkCwHk
 tYlN8ECjU1o8/b7+dz1Gxw+umUJ5qZB3xbuDliK8wqTesOy6/EbOkdr9t0qnm83IXuD6RAUgO
 qhJxfvTA9RuIst89wk+udZkya/Kkb3oE4KZVt3Pdh/FRVAMB3t9/YAMBGmHy8Bes6l/dfK920
 Cd/nUtwYGqhJsynGyRINVeL9Z+vKkADTY3skrh+foA+P/xwLSo4+Ad1nKC7OL/hbKyzQFcEEB
 YVMz+4uTZIjZCsNR2AcFoeDNhb/DK3gVDnQ3UL35UPIpP/mQi6bcxlUaXMOC3nnN9svWRz17B
 eJkxIPFjCzhROkYXQwFeD6Xd545tVGeyiWTy6lYkGaoqaBedbKQVmisMwIcKp8Sdtg4ktuYqA
 STsFNYP/dyRDRa9Hqm3uj4d7CilrFBBO6sU3ZHwmU92nSEUm5EIySafsWrUN2sDAoZLZzRSOs
 GPSkhlutnCqa3HRAM5jrHG2pHqcH1kMRSg4Vyse3JIxVtQ+DojDX+ZOpJ3SsbhiHu9eW5vhTU
 5/wotstSCrLAltZXUq1xgYCdi5uBZhbcFsC0iS9qRGqmuXcMtJmUr3PUgGJBgSTWNljJQJu+u
 Kiaz+JHvc1UsCc/KGpNFsf9iZXlpoICtjxC6LD0kcY23YBAnHAQpiJsJPrEkwkn7090tM3O63
 NTRPVvas+yF+2ACHOFRn1AV+YMpzYmL2xxasiudlgG3+mJQfCCkPYOVQTYU8JibK/jCWvbvr8
 R5ygutIj4UMYNvNmX9AlwABJ9awLp4bB3Q532cDf3vtWUdsF3/VNKcCOr+7SlPMhd35nnjgy4
 zL2MOQAVodXMWQa1j4ZXe8128zhM3Zk8CpN7U90eMVfrIv1QD2x1yvGVUq992dqYLvdfEvHaz
 RxCNEms77ZFOpaQPNndzRo+QZ9VDOV4JC82JzF1Vag7F6xE9yPNnzMQAUzl6FehLSRhA6Intd
 ylWBPu/6g/e2uQ0aG2mrfr/3RlPIXPvgCz0gzAPekI0eirjPVf3lVa/oeM/Qyuf+CUcY6zkpN
 GBd24/++aUCJaJ5mtsNvepImrRZXTKA+94CfdBJmbR2AkC23c7ZQd7h/NAv3BxYz8BGz/c1hF
 jW80UMvzPivGg4g4WGfuKlFf1NkPM9AaTuJv/2fRvcUl/SbJZIYYYIaY/hTD4DdGQ+y9DDq1O
 eJymBhG1GMtNjqYHsUrDPzNA6fx9v3vRGgqZL1EKt0vLLjUrl0/Y8D6zVIKlkmO168U54oLRG
 dDHNCPKVTx6pjbVREoyiSCKrIPmpwo3vDsDQjxdc436g3CKtJ9+LxoHsVDVDlM8VPzv0IJ8eF
 nNcpkxT1XtBp6ozMk6hTkBBSLJ+em0SWxbZbqCYKQ/oKB78Q3zOvQ7bklkxKDEgD2itM9NTC7
 GENIy0oPoyxwncr7teyI6KhsM2kAoVNoTW1l1TmAOuFgOxXdl6K1oRz5bcMfJK6pLwpCaU5Qu
 PhgHX6xFOgxICz5wCX+kOuiIUdMCibZAq7ztlT36EtWbhQBq81MmmvMyiYddG79K+OjVA9oXr
 lgrpB7izGZItaWzLISt/H/TsSxa5Bmz+13NzkGNIse4M6zZpJEX9IeBVJUav8RUGrIFkyuvqL
 hqPIyN1ST604zskhb55nNOo0leZ5bI2mNveuq3CGf9+jlPe+1AtFNgdbo6jbb9si4NAoCcR0d
 3Q83/mtoW++SjK+P7+UM46BJ/tRgOHU69QcAvLqpeRtnAS7Y/cxZcgCcjO4oWr9wKdRYRYfkN
 1n+9OPaX0UmAZTadksOlICYOm52SgAe016VONtaAL7ewYGZI1PGe0eyxhPeLCx5Crz0fEaX87
 Vu1R32Gjca/UAHRVzon6hcJaKcI0JrN8TlI4dvheGEAVit7/sxqZ3tl+wwLHYvgYH1RdfIJxg
 RQYVaXPPWkRMw5wIMA/v6YT0Yqv4PnKBvwvB5sZbkieGR/rYAFHuGTsc96rCHG65MRYhqX2lF
 IRvMHPKq0UhmpgImjlUsERjfgv58nNiZKIqA6kXSrTcwlFN52zIBE6kOMvPg1//zX5qAXqFbD
 hc3IRlisAAh0pEh837OaHriTeIzKwSxX2WZGiieuZOfoPP+l7Go79slRod8gbs09YCRfnxz5w
 olbVcRFhl2GDVMfBPphhIVP2mypbzc2i95Y22x7C+RZ8oPLxTbhsVsDAO1hGAqxEncXC3U3/D
 ZXnsxSFxVpAcvhpeHDO1BIU/KLviXR6Ct96DLx3O3dMR5EkhP7cbWz7SMvTbPcyC5hQH12g+D
 NsXm7MJsmdb90nTVQV5nSuRiOTBjL97PalukMF0IXKoQyxkqtN8U4gprNvwPkFpLwbnxK9Vl/
 ZJKmU/dubMa79pqk28ssVFykm3eC57MavrQ+/KhjrpNITWG7Y+K1HKPAdEPAU8QsF9fXA6O8c
 d4mzYrg2iGj+szGjDSlOqSFjgU2lhGk5FFT4vmcssq0dQ0BYkxgiwD4fXOB4a88Jtr7vYpxpG
 JWS2E83xjxzxHl8xmBLvexKppPY8vejc4c6L8uMt+Hk21ONpjaGHt6v13i7tNv1obMKsYpX7V
 vLEaV7ySMCbQ0PXmORhg/TYAcqI0sL4JWy29yzI4rguEBnOAyXDKchpMZxwY/Q1LkjzPxoFV0
 uA9n3n2aQVT3Xve53hcijeJ4oE69i624u1O/pUrQfYXGoYZwdLMsLMg5W++dNIGqa2HiSkYj6
 x+1O3GcaTcwcA9R81Ougobfu6Sl9T8oLxTsfRuRXYNTnQFurlxAFhcu959umQGPwL9PL+RROw
 X5BMSERTiE9SMZix4pWVhcn19+wcaRDvv8wYQsdvAk12mST0crd/by+WvhY6nQ8Hz4EPqBUAj
 5hRRrQlGg89tA7R/C2qQGMPtlwE4EEpSatlFb00UR0cQZU2ty2eVfrA1Wyt9y/IkqHSwHCNo/
 mI6f7jW5LSoowLpPpBSveDKhkwmANwm/yJkBDoDxj/FYEyNvkJdaD9OXYXn5dL5XbXDDHLGrC
 jRSFeGox0eBn9eirRHVFL5QRz8lZSry39+umq3FkWzIsXaOnN1p4Tcc7O0m7CekVKnnGirNIt
 5Jr1fb0n2aWYzM6KM6ewPDxpZ7WnyG+9BTn6wqrwQIVrHAsbiDMohsd94MFRaq3NWtdRVXLCH
 ADjjQ+4FiOmi8IQ+Fk8OHxm78TW4nszctjdgK1UJzs8QhwCWviSupMiYcGlMii91DZFl98HMM
 GcxLMC/Fd9jn5/Bv1hbYJG6Wvk3Ada6fUDt84vPPnNd4UpajigEIdYCsAO4LFvmiM2Hf0nYB5
 LoR/NmVDxdWn3OmpjI3Z4vcG73R3fG21rVOIydxBefgBgOPYLbufp1htUyy3IkRjHjNKT1q6X
 YfQNP1wZBLDaeiwkANKUUfpoAVBegWbgRJ1AAsEnngIrEnAjv7vdukzsH//jY4K19c4suXHMP
 x+ovPR+VsKF9bWYdAdxeFbq9IaV3P7i+AH+8Hh9oeYoZaefjzDBsn6/l0e8a74deMSQ8aV3/1
 kVo7poxCwz9FMfl+MegNlwP9MpCbeBc4Z/ZaKTh40Ug425tUChOsZbFyHzgcqGK+HFE7jzHdp
 YlUIWo+MSM9lo1ia2Znk3paOKlVzvEo9fs2sPZ+IhZNvpRMivryFmEkuHt65fEEDWzlRJXYYE
 NaeojmSO60503lJEvyUW3dBllnLZzXCQIjgYvC++lmPqU7GtaiiMa7K+CugTCCwL7HMMRVHOh
 ebYPWTTNLRS2sHh2HqMcxf1VhryF0lb4KPm70bFAr+Qfp71Uhk
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

On 10/16/26 08:54, Yao Zi wrote:
> Add a brief introduction to LoongArch architecture, some notes on the
> implementation, and the toolchain supporting status.
>=20
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> New patch, no changes since v3
> ---
>   doc/arch/index.rst     |  1 +
>   doc/arch/loongarch.rst | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 doc/arch/loongarch.rst
>=20
> diff --git a/doc/arch/index.rst b/doc/arch/index.rst
> index 60c93b3b6640..10903b806d2c 100644
> --- a/doc/arch/index.rst
> +++ b/doc/arch/index.rst
> @@ -9,6 +9,7 @@ Architecture-specific doc
>      arc
>      arm64
>      arm64.ffa
> +   loongarch
>      m68k
>      mips
>      nios2
> diff --git a/doc/arch/loongarch.rst b/doc/arch/loongarch.rst
> new file mode 100644
> index 000000000000..d744db6a4999
> --- /dev/null
> +++ b/doc/arch/loongarch.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
> +
> +LoongArch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch is a RISC ISA developed by Loongson Technology. It currently =
defines
> +three variants: a reduced 32-bit version (LA32R), a standard 32-bit ver=
sion
> +(LA32S) for embedded devices, and a 64-bit version (LA64).
> +
> +Notes
> +-----
> +
> +1. Currently U-Boot only runs on LA64 variant with the highest privileg=
e level
> +   (PLV0).
> +
> +2. LA64 is distinguished with 32-bit LoongArch with CONFIG_ARCH_LA64.

Thank you for the helpful documentation. Just some nits.

The prepositions should be

LA64 is distinguished from 32-bit LoongArch by CONFIG_ARCH_LA64.

Maybe:

"CONFIG_ARCH_LA64=3Dy selects support for the LA64 instruction set=20
architecture."

> +
> +3. U-Boot expects hardware-maintained coherency between I-D cache. Cach=
e

Maybe

"U-Boot requires hardware-maintained coherency of different levels of=20
instruction and data caches."

> +   topology is probed through CPUCFG; L2 and L3 caches, if present, mus=
t be

Maybe

"It determines the cache topology by reading CPUCFG registers before=20
enabling the caches."

Best regards

Heinrich

> +   unified or instruction-only. This is true for all commercial LA64 ha=
rdware.
> +   Refer to arch/loongarch/lib/cache.c for further description.
> +
> +Toolchain
> +---------
> +
> +LoongArch is supported in upstream binutils, gcc, and LLVM. GCC 12.1 st=
arted to
> +support LA64, and GCC 16 started to support LA32.
> +`kernel.org <https://mirrors.edge.kernel.org/pub/tools/crosstool/>`_ pr=
ovides
> +pre-built toolchain for both 32-bit and 64-bit LoongArch.

