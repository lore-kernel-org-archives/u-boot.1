Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA663C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 07:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CA680815;
	Tue, 11 Feb 2025 08:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Bor0ZBfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD59803CC; Tue, 11 Feb 2025 08:38:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B2680079;
 Tue, 11 Feb 2025 08:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739259492; x=1739864292; i=xypron.glpk@gmx.de;
 bh=t2P0aRiximOFWELFhPkBmuH2fYaO248rwj+zAKNbWOY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Bor0ZBfbuoR8dZqqftOor0uED2MB4qPN5QqjbC7m2xJrNOObnbhgnsGATB/nQDUA
 kUXZX65IaUVq1R00tGVZ6ISWto9b1nn4hZgPG9euFUUXkc9/MzpvLsqMILN5MGzEi
 vcAIQcTxj2+9LfFkKWYJAg/YrSZZhW+ZKl76Awx2Xy653l6FWkbo0CZ5rjFkjFV0l
 fsb5A5YfSDcV7QynBcelKYlDyTgiaTw2bkMAcRdjVM4YQxjmg4oGCKcI6fare0DjT
 7iJoKv7jyHIf/ownaQpIwuJsbH+7pHFXcCHQg+uz6dpkUHTOrpm6mIDEI3TOFdM6W
 x1lyf8S5T48Ln8a18A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.104.192]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1tkkSR35jz-001Nuf; Tue, 11
 Feb 2025 08:38:12 +0100
Message-ID: <5b1e2d1d-87b1-4051-acb1-ea91b0a31dc2@gmx.de>
Date: Tue, 11 Feb 2025 08:37:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2025.04-rc2 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20250210220151.GR1233568@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250210220151.GR1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QcjsT9/LObXWb2gj/lJwnOJN5o12GSWEYDrG4EUhGfY7faOUgHc
 o48V1nYHbmVRoers5s6k8lRh4t5PNzWY13NmxL5nzD0X+vMoyoGCcr3V7dF4Cg9ng5thIgl
 F3x65TmtrARo63Wa3yy97FrbWnbOt/jPKBOaFScBdRRF8H9BT0P6El/BMvr5iL4ssP+golV
 BaK2vc2/T6FuwF2IpBvLQ==
UI-OutboundReport: notjunk:1;M01:P0:WGL9f6H6ppg=;kNPZvj0Ll0RXILGQL/0lgDD1zz8
 BzNz9azp/h+nj0/dkguig04jHocxaBDC+xYBM80343or2eSHtWuMXeh6Tx/ZR8UQEM1Hq2goZ
 BGC2W0TA/7xnRMswc0FL3v/4+CY99f4Q0RPAI9GBWpGjh/0q6qdVSoA359DuyuLYB+u7WDYiR
 CcwUT3wFVW7YRw23nTniBaRzKiEaMJe8fR5ncRTkNc9KcdetD3rsgoIbKeJVUAm/dlh0QRl34
 lwGip5ymZilc4pdT9vRuaMl3F4oy19JszVzb8+XWHW15EbuwxOIr45Y7qppQkQQjD1WgOFE9U
 ELHwrJKs5w9kQRpVcYYj9srRzQQhH1az0SkM/04o8VasVYdJ1mki1qhAvignb7PDNGfxEJVgC
 99YsPO4Tnd/1byUjy0O9jXRrJB94abVC6Spw9d1xmKlrdQbtrdRAgadphrI437oGYhrCei1O0
 7HvyWGgtyyrvuH7o+At3DsD2i2ghcGKFFZIAr+XHjB3DHRoSiqV3V403K9EASopg62xDXghC5
 CKrWfQEmvtO/MbgEu323pS0xmadpoXTr88ZSWQpkqU7u2ozadDEd2Soz2wSClHfoYLagykM75
 p/wwguRentbQkUMEJgy6DGfyrl+D+2spiFCWLuzygz+sV6InrMrH1E2wiumJcGyXI4P49M+tK
 kcsAXN5zMyRLGBeed5dzOEGC5a8Pnng7CDLRzoCEUxDGeYua0HpXJc/zqnsrmbk9aEUWsSg5d
 UKb2CWmSV7D95ldKGYe/W2N9u0D5oUsnKHBBFo3kKYe4Oazv65YmsH4ouu9gy8cwts7XYdBHV
 5X/b8ZcbSGI9zFtlHRxMwJdR/CmJEWC/N+VlpxRC4D3U9r5pnbklWwwmazVg9o1RIajquNS5Z
 Q++nHrm8ownXHdQ0prVWG9HEwbQ9XBlyTuYeVD3jCKJDnZJWI3vpn/mCLkE5c54EQDsEJI0O4
 DEy+7GJDEfW2lI/yVOKN9E1CyeUvl1BrzWZxDbYIwVui/Xe478j3E0HnurFojLa81DRNr6EuH
 sLLh8Wlnq9aG3v9ALfNDaYVsMMcgC83ygB0xSe8zW7oHTe4eDXkE+3U/nCtvH4VBR1qrFNQcl
 jBiYfMmQaQIHO5AYL8o+0glx01BJ7M52dwFQkSde0ezgxOCsQAIXSwWJHOz8bAKeGlBblEm8h
 G2YkF9J4awwUnxIlQ86us6tdjD2RkF6f2TRzaikg5t63nbHs4WEJZL4RNAMG+Fwt8t7xI3gCD
 YF7H6QT0bcSM3AIw5U8zNJpC3gD9LaHGBoeOvyMXOLerYSO8Rvk/XcH8enzkAZJpJLqRVM3Qo
 XnH+BMZRu9in4jdN5PTFt/cFiIm+VT/Bxzv4/WqgUgcwWhFm0/NnTiLp752i4Nn5KkwSRQYwA
 AlWUy67rfv47TF6w34ayfYXAG2URmW7shmjfarrbyVQ/rKptipNzX/X4H2GxGowpFO8TAC5Zq
 nZWIE9A==
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10.02.25 23:01, Tom Rini wrote:
> Hey all,
>
> It's release day and so here's v2025.04-rc2. As this is the -rc2
> release, I've now also opened up the -next branch and will be stricter
> about what I apply myself, and what I see coming in for pull requests as
> well moving forward.
>
> Continuing on with what I started after the -rc1 release, I've
> scheduled a video call tomorrow at 9am -0600 and the calendar link is:
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN28=
0N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1Z=
jBhYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a=
83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com

When I try to follow this link it Google just tells me "Calendar could
not load the data. Please try reloading later."

Best regards

Heinrich

> and this is the same as last time. I've edited that event to be
> recurring and will tweak it as needed as we aren't quite every 2 weeks
> every time, but close enough.
>
> In terms of a changelog,
> git log --merges v2025.04-rc1..v2025.04-rc2
> As always, more details in pull requests (or the tags referenced by
> them) will result in more details here.
>
> I continue to plan to do an rc release every two weeks and the final
> release will be 07 April 2025.
>
> Thanks all!
>

