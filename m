Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE87C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A579788675;
	Mon,  1 Jul 2024 10:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="uLSb1+tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A20D88671; Mon,  1 Jul 2024 10:46:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66836886A0
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1719823559; x=1720428359; i=frank-w@public-files.de;
 bh=Qf5oDnme3QskRl5h+k6F0pJpxzEo0Va1YPTm6333z0g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uLSb1+tfnR4HacuDqRYzubiWG7PX6atJg70AUo0aDDR2fOFVAKXjlZ6MyaYxQo9n
 LJPH41Y881u79S6i20B6o8M+EwKFJWpushyLc8Mw6d+tXRywLyjUFqZEe/A0o6Doa
 SpgjF6hHCDi3NCCE8TRuHTbE2XL+NRNIwkMvq+h1Q8mDP0kIbTffbru4WC/2pEbbg
 /V3NxWplV/1D7wLDRBUj9H9KyyD+Q5sqU8Ksc1/6z+V9cQko4eVn8YvsBBi00pmWH
 11aURIBCRwb0i77MXOAhqyjOwmNEOzabQHR+BNeyX4agq9dAg75ckc778y3jFQxHH
 cMj6jiMDGleQzdeftQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.148.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1s3Q7n0ovU-00qX0a; Mon, 01
 Jul 2024 10:45:59 +0200
Date: Mon, 01 Jul 2024 10:45:57 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: =?ISO-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
CC: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>,
 John Crispin <john@phrozen.org>,
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Subject: Re: Aw: uboot 2024.07 regression
User-Agent: K-9 Mail for Android
In-Reply-To: <b4e9d236-f9b3-4fb8-837c-50c971eb56a3@armadeus.com>
References: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
 <trinity-d5e7efbf-06a7-4a02-ab82-c1738850841d-1719756653263@3c-app-gmx-bap39>
 <b4e9d236-f9b3-4fb8-837c-50c971eb56a3@armadeus.com>
Message-ID: <41B51364-A7D3-49D8-B9CA-3BE4CBBA780E@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8T1duJkrqz1gZ6sOCj+rYu3WNYuisFpkfkX+YhpSzGlZc5OiRGe
 cXBiHrmVxXyZ1U/CWSbn+IqR6hDEk2natbBS/2Aq6TpjM+K/LbeKb2jjJ5RIscjMBaEdtdw
 x6Wj7X5bhlohhtIEmAnBupJLqT90E/OGTdUCgmavIgknVkT1gnFjRophdvaPw+wADm++pVd
 8DQKsZMqnCgKe22LLx1bQ==
UI-OutboundReport: notjunk:1;M01:P0:pykOHb5dI8g=;XaxJ0dcNaXgDTM/+OlBQC0qNdu+
 ZcQhBhCjpzgB8okkp3bl8i1gT7NWhvDM/kZt1p4xCMpisqVL5lD3gVIL6PjGsI7DznbuX0Vct
 iGig4CMQDVQimm4uo1gHHMpBF8WUezFWtYficK+x/f8Yw1Y71flAO/68X4ZzSwxPPZ7D/tCly
 NFYMeYHoCCEJcyaWDhbk09AxRYPBoQR7ZBersWLdfx62/Py0BjmMxRoSvM5V5IpbQnAIztHVO
 3QNLSBxRhJvGy1HmfKIA/RZqcj8FjJO+zHMKAEqDp+0VIphD47JQ3ft1+ivz1/WZJv++MWVyl
 yXSKWzfS5WtDolYxu07ej3r+NY7uv+FLG4cpsdYFU0WGBieFzVlik6RkN/3QEXQs5swfIZFdU
 g7iZW9sST6D0hkGMIUx1NLYPTddL+LbfonqXLKQaEa27oDb0E7joBiyg0Sd+ELPRA2QF0Naql
 WxpwRjwQedY5bEW3ddAWLD2+LK+7xoVwgxV10mZAVz4KQ++P4Mr5+MporO/dlH2Y7luX0W7NM
 Pu3razu0vkZeGpzOW6/FZ5uR9RlXaLL1HPYKA8t/PTjaubuo/eNnWHy8/BW++IkXG3Uob+vgF
 vLZgOH+7tS9Rq8FnksO78x1wCDftBXkfhx/DEceX8b9oBKZDLElufOhkkvY1Gtbi5jMth3UxI
 CrH7w0qvg8g6nrtm3h27I6lUxAbD0uMvoZaZHCzdhcWioY+EQXdpAsv78Hw7eTGFvb3YfikpV
 7e7Kx0Ms3LHCd8m1X23/NKlhuPVr1s/0XOzhVe/8pwcSUXvnOLQpz9QAY2RVMU3hbhgtKV91y
 Clm+OOdh59XscwkOQqkNDZmanv5Cdf/m+iu72uxw1rCLc=
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 1=2E Juli 2024 10:19:58 MESZ schrieb "S=C3=A9bastien Szymanski" <sebasti=
en=2Eszymanski@armadeus=2Ecom>:
>Hello,
>
>On 6/30/24 16:10, Frank Wunderlich wrote:
>> Hi,
>>=20
>> any thoughts about this?
>
>Do you use an environment file ? If so, can you share it?

Hi,

yes,I use this as builtin env:

<https://github=2Ecom/frank-w/u-boot/blob/2024-04-bpi/uEnv_r2=2Etxt>

But did not notice any scrambling there with printenv=2E Imho it should on=
ly affect serverip and ipaddr

>Regards,
>
>>=20
>> Changes do not look like they would cause the ethernet-breakage, but re=
vert confirms=2E=2E=2Ebut i have no idea why this happens (maybe some optim=
ization is triggered)=2E
>>=20
>> regards Frank
>>=20
>>=20
>>> Gesendet: Samstag, 15=2E Juni 2024 um 10:35 Uhr
>>> Von: "Frank Wunderlich" <frank-w@public-files=2Ede>
>>> An: u-boot@lists=2Edenx=2Ede, "S=C3=A9bastien Szymanski" <sebastien=2E=
szymanski@armadeus=2Ecom>
>>> Cc: "Daniel Golle" <daniel@makrotopia=2Eorg>, "John Crispin" <john@phr=
ozen=2Eorg>, "Christian Marangi (Ansuel)" <ansuelsmth@gmail=2Ecom>
>>> Betreff: uboot 2024=2E07 regression
>>>=20
>>> Hi,
>>>=20
>>> while testing clock-patches for mediatek as preparation for OF_upstrea=
m i've noticed an issue on
>>> mt7623 based board (bananapi r2) with ethernet (no ping possible) in 2=
024=2E07-rc1 where 2024=2E04 is good=2E
>>>=20
>>> i bisected it to this commit:
>>> ff3bcb17f436 2024-02-23 Makefile: pass -undef option to cmd_gen_envp
>>> and when reverting this commit in 2024=2E07 ethernet works
>>>=20
>>> it seems not yet reported or reverted (till 2024=2E07-rc4)=2E
>>>=20
>>> I'm not sure why this commit breaks network on this board, but revert =
confirms it=2E=2E=2E
>>>=20
>>> regards Frank
>>>=20
>>>=20
>


regards Frank
