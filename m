Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C70DE77363
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 15:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A679E86FC7;
	Sat, 30 Sep 2023 17:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="kss1dh1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6504487068; Sat, 30 Sep 2023 17:31:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E5985E44
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 17:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696087906; x=1696692706; i=frank-w@public-files.de;
 bh=WGAwQxZPeQnspzcD1gLws/hv8IHizqGSlLJ6u2Uc4oQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kss1dh1bZcnp3npoisKtlZaFB/XVv+NiL8k1DQRSfPVfLZeydxWPbuCPpVKsOCgjDBNpUewtZUu
 KKoWzWo3vyiqpZ6Hw6eDk+yDVtoKkxXmTddBRf9CjwITjAA6DogS1in5SyG5i5vrpE0+41tqvqjuq
 M2UselQbamax2LmknMY1mUqIVbWM2HTpyaoHzQS5oochXX9ZInQ9lEIqnpFjS5PpW9QkQNYh5QOhQ
 98mn4rSAXPm6rt6C4te8Qr8Dmbxh/gsectyrpsPKh4GVSZhSNtkb44543tO0s0WtM9VyUtvklnoMX
 ohKZ6t6eBU83r+6HjbjxCsW8Fybb8Jej2VAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.33] ([217.61.152.33]) by web-mail.gmx.net
 (3c-app-gmx-bs36.server.lan [172.19.170.88]) (via HTTP); Sat, 30 Sep 2023
 17:31:46 +0200
MIME-Version: 1.0
Message-ID: <trinity-ce745599-ef46-4436-8705-96569cf217d7-1696087906150@3c-app-gmx-bs36>
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
Subject: Aw: Re: github dependabot alert on py / pytest
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Sep 2023 17:31:46 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20230930144405.GQ305624@bill-the-cat>
References: <trinity-bf8ba9b5-b264-497a-b0b2-6af0ff5c1a7f-1696079610910@3c-app-gmx-bs36>
 <20230930144405.GQ305624@bill-the-cat>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZLyma5KsP2jPxt/zJGQ4embLB8cIxI9XztJwxRrlSUqkh3j/fAdqG13GgyIVs8UGPgIY5
 RTgyQw08ri3QJyn+Kx37ejriP0Px0fQkZFRqelUKoiRw/pLhjYgWrjJqviSDHJ+zwNJTUFpk+3Np
 QHT1e77OJXAiQ0LK1uJ7HZX+ywoT/1//lTF/PIDG6FKbU39g2JeVGVbbokGZ2cBMh45mAgZ6fXPM
 NZr1NnkdNO8ght1zBCIE320w3hTibGMsOtakRv2D6RlWgOrO8C5lXrs3/hqACtAaTsOiZxpqxSCl
 eE=
UI-OutboundReport: notjunk:1;M01:P0:M8e3fYIKTSk=;gwsFPO8CpHMK13qk0XPiC7qHz9f
 fZzGxz6/NsWSjn4NDMwPr0AKGlHKXEjfkzIjin34s3i0wbxR2+sOoGup7Fn3KolJ7xJNxlkOL
 ct4xxeqvMIEyCifvoFu88gjVk9qPJ/Qcm+/duBRkSEtuVrZhhHW/0PKYywfDrTIrCMbScs+pD
 Fxxz8d6PBVIx+9O84X3r7fE+zdPyN1li6QuwJPFfxIjNWwYT+mI3hzc5RiUH5Dae7OL9A0x97
 3tFnGq9N9v8mBBQtG0xPSO11X0GowNRnt8caINM0kjEQLAYciWGPHD1Bijnz8O4pXHxveF5b3
 w5MjXzwhmkGXfa6fdWp8u19K3rmzRVzgq3BexqGXJpETsRA30xz4SfPCgg8W7bRFcZiCoVC/i
 xWJ3Y/yJbXnajUhYHiF0+1SXnGL92pQpqRAW0CGsNx9kSjknTdrV6Gk0clxeE0t7a5yN/7QDb
 /0q0SAn3YJTtrO3SEPcki5m6/xFL+o3Ru2hddqrYLSIuOddhi7AkCG7JQVi5MoVaJk2TugkJ8
 pDzjOP17qLY0A9huhoe4aX93E4m0sO3pdjbN2T+qLcGBNmUrUryW8BYX82U1btyDNbwJEAvHm
 zr2ypRf442fqZkj9Gu7Md8I8nRkipaM8U6VMoU6Jq7alyMZawciLXAIzmA/wmR7pbohR+1Z6z
 LznshLAR6GPtXmc3Dc6+nsgo1BSJj9wp2lEka2fetovmq43rl37SKx7hgAOVFl4gPY99RdztA
 grHFMebjafDEgFPWJRyNoqSMJR8dX+XEejdnWIaDt0AvTJpt4NVlRdzSYG/XfEyhoPDeMfhIW
 zJArNHil3gVgwTj7dLT4cx6Q==
Content-Transfer-Encoding: quoted-printable
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


> Gesendet: Samstag, 30. September 2023 um 16:44 Uhr
> Von: "Tom Rini" <trini@konsulko.com>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
> Betreff: Re: github dependabot alert on py / pytest
>
> On Sat, Sep 30, 2023 at 03:13:30PM +0200, Frank Wunderlich wrote:
> > Hi,
> >
> > dependabot reports a high security issue
> >
> > https://github.com/frank-w/u-boot/security/dependabot/1
> >
> > it seems it is not yet fixed in master and next as there py is still i=
n and pytest=3D=3D6.2.5
> >
> > I have not yet seen any topics for this...are you aware of this? I kno=
w tests are run in
> > isolated environment through gitlab-pipeline, but maybe this can have =
still a risk.
>
> The dependabot requests aren't public.  But I don't see one myself when
> pushing to GitHub, can you please elaborate on what it's saying we
> should have updated?

it says py-package is affected till 1.11.0 and pytest after 7.2.0 does not=
 have requirement for it...
so dropping py package and upgrade pytest to at least 7.2.0 should be the =
right fix

i guess you do not use subversion (so basicly no security issue), but mayb=
e we can fix this by upgrading
pytest to avoid the alerts in future

full report:

ReDoS in py library when used with subversion #1


Package: py (pip)
Affected versions: <=3D 1.11.0
Patched version: None

The py library through 1.11.0 for Python allows remote attackers to conduc=
t a ReDoS (Regular expression Denial of Service) attack via a Subversion r=
epository with crafted info data, because the InfoSvnCommand argument is m=
ishandled.

The particular codepath in question is the regular expression at py._path.=
svnurl.InfoSvnCommand.lspattern and is only relevant when dealing with sub=
version (svn) projects. Notably the codepath is not used in the popular py=
test project. The developers of the pytest package have released version 7=
.2.0 which removes their dependency on py. Users of pytest seeing alerts r=
elating to this advisory may update to version 7.2.0 of pytest to resolve =
this issue. See https://github.com/pytest-dev/py/issues/287#issuecomment-1=
290407715 (comment) for additional context.

Severity
High
7.5 / 10
CVSS base metrics
Attack vector
Network
Attack complexity
Low
Privileges required
None
User interaction
None
Scope
Unchanged
Confidentiality
None
Integrity
None
Availability
High
CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H
Tags
Direct dependency
Weaknesses
Weakness CWE-1333
CVE ID
CVE-2022-42969


regards Frank
