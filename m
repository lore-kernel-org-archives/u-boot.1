Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FD3C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 08:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAEB387692;
	Tue, 26 Dec 2023 09:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bFJ3iLRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A1787725; Tue, 26 Dec 2023 09:56:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5914786D2E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 09:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703580973; x=1704185773; i=xypron.glpk@gmx.de;
 bh=P1fkn2X86G8T7iT0Lyp5SgqYBbSh4ZamnD8O22zAQxk=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=bFJ3iLRNib7SBWdV405ny1bH46ZwPO4qUc2nFvHZW8394ur0/Z4ZkVLsdklDVSxy
 +PvLjnShMG/ybZcDDjTr26svH9AiNQHLnjTuM5yrjcN4byTGqXNypWbjZAkYNfN9g
 bS5jK9ZkLq9Wh9zeNOIaeplTNazXIR14TuHt5aYp/8LWznFH1NEB6xUy7yatPADXn
 uUAhmmHDHZp1Ji9ORs8X6v+n6XxSZ4VRvinG1BI7aDOQjn6MyVV/T7g541HLO/2FF
 0GJuqgGCJ24+CR08yDKhIJ3Q86si2L1Iww7+Lqo61ZikH3atex80O5Mp8EHV06GkT
 8ayQBpltsG9zkmVIzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1rTLlM1Rv7-00FjV8; Tue, 26
 Dec 2023 09:56:13 +0100
Message-ID: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
Date: Tue, 26 Dec 2023 09:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: ACPI: usage of sandbox virtual addresses
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WtL0bsVcfxdlbXkYz/9WC/sDvacq/ys1Rxzl0NA0F6qKNrSdfdl
 XQFApA152RnC5XyOP+i3u+P7uYL2KC1I3NYIWn5LzkvPMBuOTHBdjYYUuzmu9FSOi5hMr3u
 wQv1XV/9dQvQmj6aXjJeoLZMedGqWMPQqYYV2qayIiJ70N/CveWHk00fbe+mB/PaYPY+wnB
 W/hfYNTJ7oEMC5wzlMKKA==
UI-OutboundReport: notjunk:1;M01:P0:ZDQrMFK5ElA=;QN2LhaJfDJgzRumwHCAoj8c7SYL
 efu+jl8uKdM0R4wCj9jN6/gMgxE1WXcZUBb07+N/Y93bS4Rlru4Sgnb4k/6Dc7h1MFYoklApR
 DjAmfLTChpQS76YYHD0OmX9aPA3Tczx5WjyOaO3TBlLeKbtOCFeTibm9f89ZGAaBGCdudS9R+
 3LbmTXiZUMgpYxCn+dwQTwpKjy7uDv3Qv1bX9qTW3JfKxFlvmlQkXlKs0tdXpLBS5+7FHVGib
 RiURb8hIHsNtdh4tLwl18E1Uq0jqe38Gcps+PUz+WcHg8HIveGpczFUc73ZAy56Y+gCrFDDtm
 P4sHt5NcWvdmCAK6iFd1Gl8J886jjIcacTHEgArSh380er26qmpDvf3RPWMkqSWogBclSapEy
 odvsZl+PeOuXx2uFfYu1GZLuChwgsUCrixQ61rMhARb+PAacJaNKOGiWOqKkY33oNq0hKfMor
 7slhARbGCCoWTuCovJABLjACTKLsJzRX/vNCcP36hJh+SyJ4277hTaE4c+VA5HPKe1UR+eG+n
 jCXGHt2D2OwgRlmWYSzEwiWutNWTue5yAjk1RScwjLvn9FrK/p9YB3lMeeXFEE4VX8aLfT7U+
 imT9U6TEuCXAlTqDoIgx0KJzoOY6O/xDKMzI5Rqq4sRUepIGKRJ4eCJHO6Hh2Ageqk8c4fz7j
 C3zFxOqdr5/OLzuxOhJnZQmZl6cMslKryXjXxY+iy+BhdKuwtKXoiUkOrJZpdQO5H4+yNmYOB
 ikNRkV6/s6LrsSts7EOzskFaTkQ3WVOODsVVytrlqS/la01Oazj9SF5rN3tahJRdkwCTn+fGj
 WiJAwgDDwvSJyTEyAdYGFHMkWFGtQwB8dOQ8lmmuZDFP526AWvu/wl1SXNifkB2E6W8K9t5tO
 Vd++rCzNwn3/4x4e2XoyuL2gsDkogpxKT2pnlrpxqLLwQQzofps+xHWym3R0YVhS0ctzU3u0j
 bbszyQ==
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

Hello Simon,

currently we use sandbox virtual addresses in all ACPI tables. This
means that an application started by the U-Boot sandbox consuming these
tables will crash due to accessing invalid addresses.

Shouldn't the ACPI tables be migrated to use valid pointers?

Best regards

Heinrich
